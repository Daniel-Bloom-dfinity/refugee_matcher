import Option "mo:base/Option";
import Buffer "mo:base/Buffer";
import Time "mo:base/Time";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";

import Location "location";
import Region "region";
import Country "country";

module {
    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type V1 = {
        owner: Principal;
        is_active: Bool;
        referral_code: Text;
        last_updated: Time.Time;
        location: (Nat, Nat); // Country ID, Region ID
        offer: {
            #FullHouse;
            #FullApartment;
            #RoomInHome;
            #Bed;
            #HotelHostel;
            #Other: Text;
        };
        spots_available: Nat16;
        start_date: Time.Time;
        duration: {
            #Days;
            #Weeks;
            #Months;
        };
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

        public func toDisk() : V1 = {
            owner = data.owner;
            is_active = active;
            referral_code = data.referral_code;
            last_updated = data.last_updated;
            location = data.location;
            offer = data.offer;
            spots_available = data.spots_available;
            start_date = data.start_date;
            duration = data.duration;
            accepts_pets = data.accepts_pets;
            accepts_kids = data.accepts_kids;
            accepts_men = data.accepts_men;
            accepts_women = data.accepts_women;
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
        public func upsert_host(v: Runtime) {
            map.put(v.owner(), v);
        };
        public func store_v1() : [V1] {
            Iter.toArray(Iter.map(map.entries(), toDisk));
        };
    }
}
