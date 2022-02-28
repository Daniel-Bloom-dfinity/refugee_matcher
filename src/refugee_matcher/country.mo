import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Location "location";
import Region "region";

module {
    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type V1 = {
        name: Text;
        regions: [Region.V1];
    };

    /// Runtime data for countries
    public class Runtime(data: V1) {
        var name = data.name;
        var regions: Buffer.Buffer<Region.Runtime> = Buffer.Buffer(data.regions.size());
        for (r in data.regions.vals()) {
            regions.add(Region.Runtime(r));
        };
        public func setName(n: Text) {
            name := n;
        };
        public func getName() : Text = name; //{} Syntax Highlighter Hack

        public func addRegion(r: Region.Runtime) : Nat {
            regions.add(r);
            regions.size() - 1
        };

        public func setRegion(id: Nat, r: Region.Runtime) {
            regions.put(id, r);
        };
        public func getRegions() : Buffer.Buffer<Region.Runtime> {
            regions
        };
    };

    public func toDisk(data: Runtime) : V1 = {
        name = data.getName();
        regions = Iter.toArray(Iter.map(data.getRegions().vals(), Region.toDisk));
    }
/*
    func getRegionName(r: R.Region) : Text = r.getName(); //{} SHH
    func getRegionLocation(r: R.Region) : L.Location = r.getLocation(); //{} SHH
    func getRegionMicroLat(r: R.Region) : Int32 = r.getLocation().micro_lat; //{} SHH
    func getRegionMicroLong(r: R.Region) : Int32 = r.getLocation().micro_long; //{} SHH

    public func loadCountry(name: Text, region_names: [Text], region_micro_locations: [L.Location]) : Country {
        var regions : B.Buffer<R.Region> = B.Buffer(region_names.size());
        for (i in Iter.range(0, region_names.size()-1)) {
            regions.add(R.Region(
                region_names[i],
                region_micro_locations[i],
            ));
        };
        Country(name, regions)
    };

    public func getName(c: Country) : Text = c.getName(); //{} SHH
    public func getRegionNames(c: Country) : [Text] =
        Iter.toArray(Iter.map(c.getRegions().vals(), getRegionName)); //{} SHH
    public func getRegionMicroLats(c: Country) : [Int32] =
        Iter.toArray(Iter.map(c.getRegions().vals(), getRegionMicroLat)); //{} SHH
    public func getRegionMicroLongs(c: Country) : [Int32] =
        Iter.toArray(Iter.map(c.getRegions().vals(), getRegionMicroLong)); //{} SHH
    public func getRegionLocations(c: Country) : [L.Location] =
        Iter.toArray(Iter.map(c.getRegions().vals(), getRegionLocation)); //{} SHH
*/
}