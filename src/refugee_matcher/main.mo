
import Map "mo:base/HashMap";
import Principal "mo:base/Principal";
import Option "mo:base/Option";
import Bool "mo:base/Bool";
import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Int "mo:base/Int";
import Nat8 "mo:base/Nat8";
import Time "mo:base/Time";
import Location "location";
import Region "region";
import Country "country";
import Host "host";
import Utils "utils";
import Refugee "refugee";

import Debug "mo:base/Debug";

actor class HttpCounter(initial_admin: Principal) {
    /// Admin section
    stable var admin_1 : Principal = initial_admin;
    stable var admin_2 : Principal = initial_admin;
    
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

    /// Stable Data section

    stable var stable_countries_v1: [Country.V1] = [];
    stable var stable_hosts_v1: [Host.V1] = [];
    stable var stable_refugees_v1: [Refugee.V1] = [];

    var countries = Utils.load_id<Country.V1, Country.Runtime>(stable_countries_v1, Country.Runtime);
    var hosts = Host.Set(stable_hosts_v1, countries);
    var refugees = Refugee.Set(stable_refugees_v1, countries);

    system func preupgrade() {
        stable_countries_v1 := Iter.toArray(Iter.map(countries.vals(), Country.toDisk));
        stable_hosts_v1 := hosts.store_v1();
        stable_refugees_v1 := refugees.store_v1();
    };

    system func postupgrade() {
        stable_countries_v1 := [];
        stable_hosts_v1 := [];
        stable_refugees_v1 := [];
    };

    /// Admin interface section
    public shared(msg) func add_country(country: Country.V1) : async Nat {
        assert(is_admin(msg.caller));
        let id = countries.size();
        countries.add(Country.Runtime(id, country));
        id
    };

    public shared(msg) func set_country_name(country_id: Nat, name: Text) {
        assert(is_admin(msg.caller));
        countries.get(country_id).setName(name);
    };

    public shared(msg) func add_region(country_id: Nat, region: Region.V1): async Nat {
        assert(is_admin(msg.caller));
        countries.get(country_id).addRegion(region)
    };

    public shared(msg) func update_region(country_id: Nat, region_id: Nat, region: Region.V1) {
        assert(is_admin(msg.caller));
        countries.get(country_id).setRegion(region_id, Region.Runtime(region_id, region))
    };
    public shared(msg) func backup_refugees() : async [Refugee.V1] {
        assert(is_admin(msg.caller));
        refugees.store_v1()
    };
    public shared(msg) func backup_hosts() : async [Host.V1] {
        assert(is_admin(msg.caller));
        hosts.store_v1()
    };


    /// User interface section
    public query func get_countries() : async [Country.V1] {
        Iter.toArray(Iter.map(countries.vals(), Country.toDisk))
    };

    /// Stub
    public shared(msg) func upsert_host(host: Host.V1) {
        hosts.upsert_host(Host.Runtime(countries, host));
    };
    /// Stub



    /// Stub
    public type Refugee = {
        referral_code: Text;
        last_updated: Time.Time;
        location: (Nat, Nat); // Country ID, Region ID
        start_window: {
            #ASAP;
            #ThisWeek;
            #NextWeek;
            #Later;
        };
        people: Nat16;
        includes_pets: Bool;
        includes_kids: Bool;
        includes_men: Bool;
        includes_women: Bool;
        description: Text;
        contant_info: Text;
    };
    /// Stub
    public shared(msg) func upsert_refuge(refugee: Refugee) {
        refugees.upsert_refugee(Refugee.Runtime(countries, {
            owner = msg.caller;
            is_active = true;
            last_updated = refugee.last_updated;
            location = refugee.location;
            start_window = switch (refugee.start_window) {
                case(#ASAP) #ASAP;
                case(#ThisWeek) #ThisWeek;
                case(#NextWeek) #NextWeek;
                case(#Later) #Later;
            };
            people = refugee.people;
            includes_pets = refugee.includes_pets;
            includes_kids = refugee.includes_kids;
            includes_men = refugee.includes_men;
            includes_women = refugee.includes_women;
            description = refugee.description;
            contant_info = refugee.contant_info;
        }));
    };
    /// Stub
};
