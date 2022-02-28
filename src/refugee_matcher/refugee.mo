
import Time "mo:base/Time";
import Buffer "mo:base/Buffer";
import Option "mo:base/Option";
import Country "country";
import Region "region";

module {

    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type StartTimeWindowV1 = {
        #ASAP;
        #ThisWeek;
        #NextWeek;
        #Later;
    };

    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type V1 = {
        owner: Principal;
        is_active: Bool;
        referral_code: Text;
        last_updated: Time.Time;
        location: (Nat, Nat); // Country ID, Region ID
        start_window: StartTimeWindowV1;
        people: Nat16;
        includes_pets: Bool;
        includes_kids: Bool;
        includes_men: Bool;
        includes_women: Bool;
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
        public func startWindow() : StartTimeWindowV1 = data.start_window;
        public func people() : Nat16 = data.people;
        public func includesPets() : Bool = data.includes_pets;
        public func includesKids() : Bool = data.includes_kids;
        public func includesMen() : Bool = data.includes_men;
        public func includesWomen() : Bool = data.includes_women;
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
        start_window = data.startWindow();
        people = data.people();
        includes_pets = data.includesPets();
        includes_kids = data.includesKids();
        includes_men = data.includesMen();
        includes_women = data.includesWomen();
        description = data.description();
        contant_info = data.contantInfo();
    };
}
