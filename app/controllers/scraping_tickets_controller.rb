class ScrapingTicketsController < ApplicationController

  def index
    puts "Test"
    test = 'test varialbe'
    ticket_summary_data = TicketSummary.new(departure_date: "2021-12-31", return_date: "2021-12-31", time_from_out: "0600", time_to_out: "0700", search_time: Time.now.strftime("%Y-%m-%d %H:%M:%S"), total_tickets_out: 100, total_tickets_in: 400)
    ticket_summary_data.save
    
    ticket_company_data = TicketAirlineCompany.new(ticket_summary_id: ticket_summary_data.id, airline_company_name: "AAAA", ticket_lowest_price: 1235.66, total_flights_available: 50, ticket_type: "YED")
    ticket_company_data.save

    ticket_airline_data = AirlineFlight.new(ticket_airline_id: ticket_company_data.id, flight_code: "CCC", flight_price: 1235.66, flight_changeable_status: "Changable", flight_ticket_type: "BBB")
    ticket_airline_data.save
    
    binding.pry
  
  end

  # def scrap_tickets
  #   puts "Scraping tickets"
  #   render :nothing => true
  # end

end
