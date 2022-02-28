
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
    func load<A, B>(stable_data : [A], map: (A) -> B) : Buffer.Buffer<B> {
        let runtime_data = Buffer.Buffer<B>(stable_data.size());
        for (v in stable_data.vals()) {
            runtime_data.add(map(v));
        };
        runtime_data
    };

    stable var stable_countries_v1: [Country.V1] = [];
    stable var stable_hosts_v1: [Host.V1] = [];

    var countries = load<Country.V1, Country.Runtime>(stable_countries_v1, Country.Runtime);
    var hosts = load<Host.V1, Host.Runtime>(stable_hosts_v1, Host.Runtime);

    system func preupgrade() {
        stable_countries_v1 := Iter.toArray(Iter.map(countries.vals(), Country.toDisk));
        stable_hosts_v1 := Iter.toArray(Iter.map(hosts.vals(), Host.toDisk));
    };

    system func postupgrade() {
        stable_countries_v1 := [];
        stable_hosts_v1 := [];
    };

    public shared(msg) func add_country(country: Country.V1) : async Nat {
        assert(is_admin(msg.caller));
        countries.add(Country.Runtime(country));
        countries.size() - 1
    };

    public shared(msg) func set_country_name(country_id: Nat, name: Text) {
        assert(is_admin(msg.caller));
        countries.get(country_id).setName(name);
    };

    public shared(msg) func add_region(country_id: Nat, region: Region.V1): async Nat {
        assert(is_admin(msg.caller));
        countries.get(country_id).addRegion(Region.Runtime(region))
    };

    public shared(msg) func update_region(country_id: Nat, region_id: Nat, region: Region.V1) {
        assert(is_admin(msg.caller));
        countries.get(country_id).setRegion(region_id, Region.Runtime(region))
    };

    public query func get_countries() : async [Country.V1] {
        Iter.toArray(Iter.map(countries.vals(), Country.toDisk))
    };

    public shared(msg) func add_host(host: Host.V1) : async Nat {
        hosts.add(Host.Runtime(host));
        hosts.size() - 1
    };
    public query func get_host(host_id: Nat) : async Host.V1 {
        Host.toDisk(hosts.get(host_id))
    };
};
