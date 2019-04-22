import UIKit

//호텔 예약, 항공기, 렌터카 검색
struct Hotel {
    //호텔 객실에 대한 정보
}

struct HotelBooking{
    static func getHotelNameForDates(to: NSDate, from: NSDate) -> [Hotel]? {
        let hotels = [Hotel]()
        //호텔을 가져오는 로직
        return hotels
    }
    
    static func bookHotel(hotel: Hotel){
        //호텔 객실을 예약하는 로직
    }
}

//항공기 API
struct Flight {
     //항공기에 대한 정보
}

struct FlightBooking {
    static func getFlightNameForDates(to: NSDate, from: NSDate) -> [Flight]?{
        let flights = [Flight]()
        //항공기를 가져오는 로직
        return flights
    }
    
    static func bookFlight(flight: Flight){
        //항공기를 예약하는 로직
    }
}

//렌트카 API
struct RentalCar {
    //렌터카에 대한 정보
}

struct RentalCarBooking {
    static func getRentalCarNameForDates(to: NSDate, from: NSDate) -> [RentalCar]?{
        let cars = [RentalCar]()
        //렌트카를 가져오는 로직
        return cars
    }
    
    static func bookRentalCar(rentalCar: RentalCar){
        //렌트카를 예약하는 로직
    }
}

//파사드 패턴을 이용해 각각의 API의 구현 상태를 숨긴다. 나중에 API 동작방식을 변경하는 경우에는 코드 전체를 리팩토링 하지 않고 파사드 타입만 변경하여 유지 보수를 쉽게 한다.
struct TravelFacade {
    
    var hotels: [Hotel]?
    var flights: [Flight]?
    var cars: [RentalCar]?
    
    init(to: NSDate, from: NSDate){
        hotels = HotelBooking.getHotelNameForDates(to: to, from: from)
        flights = FlightBooking.getFlightNameForDates(to: to, from: from)
        cars = RentalCarBooking.getRentalCarNameForDates(to: to, from: from)
    }
    
    func bookTrip(hotel: Hotel, flight: Flight, rentalCar: RentalCar){
        HotelBooking.bookHotel(hotel: hotel)
        FlightBooking.bookFlight(flight: flight)
        RentalCarBooking.bookRentalCar(rentalCar: rentalCar)
    }
}
