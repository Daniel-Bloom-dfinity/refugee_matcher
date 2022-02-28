
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
    var hosts = Host.load_set(stable_hosts_v1, countries);
    var refugees = Refugee.load_set(stable_refugees_v1, countries);

    system func preupgrade() {
        stable_countries_v1 := Iter.toArray(Iter.map(countries.vals(), Country.toDisk));
        stable_hosts_v1 := Iter.toArray(Iter.map(hosts.vals(), Host.toDisk));
        stable_refugees_v1 := Iter.toArray(Iter.map(refugees.vals(), Refugee.toDisk));
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


    /// User interface section
    public query func get_countries() : async [Country.V1] {
        Iter.toArray(Iter.map(countries.vals(), Country.toDisk))
    };

    /// Stub
    public shared(msg) func add_host(host: Host.V1) : async Nat {
        hosts.add(Host.Runtime(countries, host));
        hosts.size() - 1
    };
    /// Stub
    public query func get_host(host_id: Nat) : async Host.V1 {
        Host.toDisk(hosts.get(host_id))
    };
    /// Stub
    public shared(msg) func add_refuge(refugee: Refugee.V1) : async Nat {
        refugees.add(Refugee.Runtime(countries, refugee));
        refugees.size() - 1
    };
    /// Stub
    public query func get_refugee(refugee_id: Nat) : async Refugee.V1 {
        Refugee.toDisk(refugees.get(refugee_id))
    };
};
