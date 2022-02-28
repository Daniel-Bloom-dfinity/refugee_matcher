
import Map "mo:base/HashMap";
import Principal "mo:base/Principal";
import Option "mo:base/Option";
import B "mo:base/Buffer";
import Iter "mo:base/Iter";
import L "location";
import R "region";
import C "country";

actor class HttpCounter(initial_admin: Principal) {
    stable var admin_1 : Principal = initial_admin;
    stable var admin_2 : Principal = initial_admin;

    stable var stable_country_names : [Text]  = [];
    stable var stable_region_names : [[Text]]  = [];
    stable var stable_region_locations : [[L.Location]]  = [];

    func build_countries() : B.Buffer<C.Country> {
        let countries = B.Buffer<C.Country>(stable_country_names.size());
        for (i in Iter.range(0, stable_country_names.size()-1)) {
            countries.add(C.loadCountry(
                stable_country_names[i],
                stable_region_names[i],
                stable_region_locations[i],
            ));
        };
        countries
    };

    var countries = build_countries();

    system func preupgrade() {
        stable_country_names := Iter.toArray(Iter.map(countries.vals(), C.getName));
        stable_region_names := Iter.toArray(Iter.map(countries.vals(), C.getRegionNames));
        stable_region_locations := Iter.toArray(Iter.map(countries.vals(), C.getRegionLocations));
    };

    system func postupgrade() {
        stable_country_names := [];
        stable_region_names := [];
        stable_region_locations := [];
    };

    func is_admin(user: Principal) : Bool {
        admin_1 == user or admin_2 == user
    };

    public shared(msg) func check_admin() : async Bool {
        is_admin(msg.caller)
    };

    public shared(msg) func set_next_admin(user: Principal) {
        assert(is_admin(msg.caller));
        admin_2 := user;
    };
    public shared(msg) func switch_admin() {
        assert(is_admin(msg.caller));
        admin_1 := admin_2;
    };

    public type Region = {
        name: Text;
        location: L.Location;
    };

    public type Country = {
        name: Text;
        regions: [Region];
    };

    public shared(msg) func add_country(country: Country) : async Nat {
        assert(is_admin(msg.caller));

        let regions : B.Buffer<R.Region> = B.Buffer(country.regions.size());
        for (x in country.regions.vals()) {
            regions.add(R.Region(x.name, x.location));
        };
        
        countries.add(C.Country(country.name, regions));
        countries.size() - 1
    };

    public shared(msg) func set_country_name(country_id: Nat, name: Text) {
        assert(is_admin(msg.caller));
        
        countries.get(country_id).setName(name);
    };

    public shared(msg) func add_region(country_id: Nat, region: Region): async Nat {
        assert(is_admin(msg.caller));

        countries.get(country_id).addRegion(region.name, region.location)
    };

    public shared(msg) func update_region(country_id: Nat, region_id: Nat, region: Region) {
        assert(is_admin(msg.caller));

        countries.get(country_id).setRegion(region_id, region.name, region.location)
    };

    public query func get_countries() : async [Country] {
        Iter.toArray(Iter.map(countries.vals(), func (c: C.Country) : Country = {
            name = c.getName();
            regions = Iter.toArray(Iter.map(c.getRegions().vals(), func (r: R.Region) : Region = {
                name = r.getName();
                location = r.getLocation();
            }));
        }))
    };

    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };
};
