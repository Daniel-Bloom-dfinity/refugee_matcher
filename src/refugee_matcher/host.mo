import Option "mo:base/Option";
import Buffer "mo:base/Buffer";
import Time "mo:base/Time";
import Location "location";
import Region "region";
import Country "country";

module {
    type Active = {
        
    };

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
    };

    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type V1 = {
        owner: Principal;
        is_active: Bool;
        referral_code: Text;
        last_updated: Time.Time;
        location: (Nat, Nat); // Country ID, Region ID
        offer: HousingOfferV1;
        spots_available: Nat16;
        start_date: Time.Time;
        duration: DurationV1;
        accepts_pets: Bool;
        accepts_kids: Bool;
        accepts_men: Bool;
        accepts_women: Bool;
        description: Text;
        contant_info: Text;
    };

    public class Runtime(countries: Buffer.Buffer<Country.Runtime>, data: V1) {
        var active = data.is_active;
        let (country_id, region_id) = data.location;
        let region = Option.chain(
            countries.getOpt(country_id),
            func (c: Country.Runtime) : ?Region.Runtime = c.getRegions().getOpt(region_id),
        );
        switch(region) {
            case (?region_) {
                //region_.add_user
            };
            case (null) {
                active := false;
            };
        };
        //let country_id = data.location.0;
        //var location = if (countries.size() countries.get(data.location.0);

        public func owner() : Principal = data.owner;
        public func setActive(v: Bool) {
            active := v;
        };
        public func isActive() : Bool = active;
        public func referralCode() : Text = data.referral_code;
        public func lastUpdated() : Time.Time = data.last_updated;
        public func locationID() : (Nat, Nat) = data.location;

        public func offer() : HousingOfferV1 = data.offer;
        public func spotsAvailable() : Nat16 = data.spots_available;
        public func startDate() : Time.Time = data.start_date;
        public func duration() : DurationV1 = data.duration;
        public func acceptsPets() : Bool = data.accepts_pets;
        public func acceptsKids() : Bool = data.accepts_kids;
        public func acceptsMen() : Bool = data.accepts_men;
        public func acceptsWomen() : Bool = data.accepts_women;
        public func description() : Text = data.description;
        public func contantInfo() : Text = data.contant_info;
    };


    public func load_set(stable_data : [V1], d: Buffer.Buffer<Country.Runtime>) : Buffer.Buffer<Runtime> {
        let runtime_data = Buffer.Buffer<Runtime>(stable_data.size());
        for (v in stable_data.vals()) {
            runtime_data.add(Runtime(d, v));
        };
        runtime_data
    };

    public func toDisk(data: Runtime) : V1 = {
        owner = data.owner();
        is_active = data.isActive();
        referral_code = data.referralCode();
        last_updated = data.lastUpdated();
        location = data.locationID();
        offer = data.offer();
        spots_available = data.spotsAvailable();
        start_date = data.startDate();
        duration = data.duration();
        accepts_pets = data.acceptsPets();
        accepts_kids = data.acceptsKids();
        accepts_men = data.acceptsMen();
        accepts_women = data.acceptsWomen();
        description = data.description();
        contant_info = data.contantInfo();
    };
}
