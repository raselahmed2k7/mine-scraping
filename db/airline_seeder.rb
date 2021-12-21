def airline_seeder
    puts 'seeding airlines...'
    airline_list = [
    'ANA', 
    'JAL',
    'Air Do',
    'スカイマーク',
    'ジェットスター',
    'ソラシド',
    'スターフライヤー',
    'フジドリームエアラインズ',
    'ジェットスター・ジャパン',
    'ピーチ・アビエーション',
    'スプリング・ジャパン',
    'IBEXエアラインズ',
    '天草エアライン',
    'オリエンタルエアブリッジ'
    ]
    
    Airline.destroy_all
    airline_list.each do |airline|
        Airline.create( name: airline)
    end

end
