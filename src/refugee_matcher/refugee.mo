
import Time "mo:base/Time";
import Buffer "mo:base/Buffer";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import HashMap "mo:base/HashMap";
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

        public func toDisk() : V1 = {
            owner = data.owner;
            is_active = active;
            last_updated = data.last_updated;
            location = data.location;
            start_window = data.start_window;
            people = data.people;
            includes_pets = data.includes_pets;
            includes_kids = data.includes_kids;
            includes_men = data.includes_men;
            includes_women = data.includes_women;
            description = data.description;
            contant_info = data.contant_info;
        };
    };


    func toDisk((owner, data): (Principal, Runtime)) : V1 = data.toDisk();

    public class Set(stable_data : [V1], countries: Buffer.Buffer<Country.Runtime>) {
        let map = HashMap.HashMap<Principal, Runtime>(stable_data.size(), Principal.equal, Principal.hash);
        for (v in stable_data.vals()) {
            map.put(v.owner, Runtime(countries, v));
        };

        public func upsert_refugee(v: Runtime) {
            map.put(v.owner(), v);
        };
        public func store_v1() : [V1] {
            Iter.toArray(Iter.map(map.entries(), toDisk));
        };
    };

}
