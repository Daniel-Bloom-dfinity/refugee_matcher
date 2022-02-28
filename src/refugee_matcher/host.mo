import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Time "mo:base/Time";
import Location "location";
import Region "region";

module {
    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    type HousingOfferV1 = {
        #FullHouse;
        #FullApartment;
        #RoomInHome;
        #Bed;
        #HotelHostel;
        #Other: Text;
    };

    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type DurationV1 = {
        #Days;
        #Weeks;
        #Months;
        #Years;
    };

    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type V1 = {
        is_active: Bool;
        verification_code: Text;
        last_updated: Time.Time;
        offer: HousingOfferV1;
        spots_available: Nat16;
        start_date: Time.Time;
        duration: DurationV1;
        pets: Bool;
    };

    public class Runtime(data: V1) {
        var active = data.is_active;

        public func setActive(v: Bool) {
            active := v;
        };
        public func isActive() : Bool = active;
        public func verificationCode() : Text = data.verification_code;
        public func lastUpdated() : Time.Time = data.last_updated;
        public func offer() : HousingOfferV1 = data.offer;
        public func spotsAvailable() : Nat16 = data.spots_available;
        public func startDate() : Time.Time = data.start_date;
        public func duration() : DurationV1 = data.duration;
        public func pets() : Bool = data.pets;
    };

    public func toDisk(data: Runtime) : V1 = {
        is_active = data.isActive();
        verification_code = data.verificationCode();
        last_updated = data.lastUpdated();
        offer = data.offer();
        spots_available = data.spotsAvailable();
        start_date = data.startDate();
        duration = data.duration();
        pets = data.pets();
    };
}