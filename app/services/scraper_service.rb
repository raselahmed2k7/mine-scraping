class ScraperService
  WAIT = Selenium::WebDriver::Wait.new(timeout: 20) # Maximum wait to find out search results html
  options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
  WEB_DRIVER = Selenium::WebDriver.for(:firefox, options: options)
  MAX_CALL = 3
  MAX_RETRY = 40

  class << self
    def start_scraping
        departure_dates = DepartureDate.all
        airports = Airport.all
        departure_dates&.each do |departure_date|
          if Date.current < departure_date.departure_date
            airports&.each do |airport|
              departure_airport = airport
              destination_airports = airports.where.not(id: airport[:id])
              destination_airports.each do |destination_airport|
                complete_scraping_process(departure_date, airport, destination_airport)
              end
            end
          end
        end
      end

      def complete_scraping_process(departure_date, airport, destination_airport)
        departure_date_string = departure_date.departure_date.to_s.delete("-")
        begin
          retries ||= 0
          search_flight(departure_date_string, airport,  destination_airport)

          # return if check_search_not_found or if ticket search parameters are not suitable
          WAIT.until { WEB_DRIVER.find_element(css: "#Act_response_out").displayed? }
          begin
            check_search_not_found = WEB_DRIVER.find_element(css: "#Act_response_out .box-util-notfound > p > b")&.attribute("innerHTML")&.include? '指定された条件を満たす'
            return if check_search_not_found
          rescue
          end

          # Wait for few seconds until able to find return tickets list
          WAIT.until { WEB_DRIVER.find_element(css: "#Act_response_out .company-list").displayed? }

          ticket_searched_fields = {
            'id' => nil,
            'departure_date_id' => departure_date.id,
            'search_date' => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
            'airport_id' => airport.id,
            'arrival_airport_id' => destination_airport.id,
            'departure_time_from' => Settings.departure_time_from,
            'departure_time_to' => Settings.departure_time_to
          }
          search_data = Search.create(ticket_searched_fields)  # Save search data if ticket flights found
          ticket_searched_flights = prepare_search_data(search_data.id)
          Flight.transaction do
            Flight.create(ticket_searched_flights) # Save flights
            puts "Flights scraped successfully and saved to DB..."
          end
        rescue Exception => e
          retries += 1
          begin
            check_if_not_found = WEB_DRIVER.find_element(css: "#Act_response_out .box-util-notfound > p > b")&.attribute("innerHTML")&.include? '指定された条件を満たす'
            return if check_if_not_found # Tickets not found due to departure and airport miscombination, skip and return to next
          rescue
            puts 'Ticket found but need to wait for few time...'
          end

          retry if (retries <= MAX_CALL)
          puts "Could not get ticket website information: Please give necessary information to search and try again"
        end
      end

      def search_flight(departure_date, airport, destination_airport)
        search_url = "https://www.tour.ne.jp/j_air/list/?adult=1&air_type=2&arr_out=" +
        "#{destination_airport.code}" +
        "&change_date_in=0&change_date_out=0&date_out=" +
        "#{departure_date}&dpt_out=" +
        "#{airport.code}"

        WEB_DRIVER.navigate.to search_url
        sleep(1)
        begin
          retries ||= 0
          ticket_summary_button_out = nil
          ticket_summary_button_out = WEB_DRIVER.find_element(:css, '#Act_Airline_Out')
          return if ticket_summary_button_out.nil?
          ticket_summary_button_out.click
        rescue Exception => e
          puts 'Trying to fetch data.. ' + retries.to_s
          retries += 1
          sleep(1)   # Wait 1s to load the page properly
          retry if (retries <= MAX_RETRY)
          return "Error clicking airlines. Please check URL or try again"
        end
      end

      def prepare_search_data(search_id)
        ticket_airlines = WEB_DRIVER.find_elements(:css, '#Act_response_out .company-list .company-box')
        ticket_flight_lists = []
        ticket_airlines&.each do |ticket_airline|
          ticket_company_name = ticket_airline.find_element(:css, '.airline-name').text
          @check_airline = Airline.find_by(name: ticket_company_name)
          if @check_airline.nil?
            airline = Airline.create('name': ticket_company_name)
            airline_id = airline.id
          else
            airline_id = @check_airline['id']
          end

          ticket_airline_flights_lists = ticket_airline.find_elements(:css, '.Act_flight_list')
          ticket_airline_flights_lists&.each do |ticket_flight|
            flight_data = {}
            flight_data['search_id'] = search_id
            flight_data['code'] = ticket_flight.find_elements(:css, '.ticket-summary-row > span')[1]&.attribute("innerHTML")
            flight_data['airline_id'] = airline_id
            flight_data['price'] = ticket_flight.find_elements(:css, '.ticket-detail-item .ticket-detail-item-inner .ticket-price > label > b')[0]&.attribute("innerHTML")&.delete(",").to_f
            flight_data['flight_seat'] = ticket_flight.find_elements(:css, '.ticket-detail-item .ticket-detail-item-inner .ticket-detail-type .ticket-detail-icon .icon-seat')[0]&.attribute("innerHTML")
            flight_data['changeable_status'] = ticket_flight.find_elements(:css, '.ticket-detail-item .ticket-detail-item-inner .ticket-detail-type .ticket-detail-icon .icon-date')[0]&.attribute("innerHTML")
            flight_data['flight_type'] = ticket_flight.find_elements(:css,
                                        '.ticket-detail-item .ticket-detail-item-inner .ticket-detail-type .ticket-detail-type-text .ticket-detail-type-text-ellipsis')[0]&.attribute("innerHTML")
            flight_data['flight_type_discount'] = ticket_flight.find_elements(:css, '.ticket-detail-item .ticket-detail-item-inner .ticket-detail-unit-price >b')[0]&.attribute("innerHTML")&.delete(",").to_f
            ticket_flight_lists.push(flight_data)
          end
        end
        return ticket_flight_lists
      end
  end
end
