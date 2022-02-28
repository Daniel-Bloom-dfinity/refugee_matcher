import B "mo:base/Buffer";
import Iter "mo:base/Iter";
import L "location";
import R "region";

module {
    public class Country(iname: Text, regions: B.Buffer<R.Region>) {
        var name = iname;
        public func setName(n: Text) {
            name := n;
        };
        public func getName() : Text = name; //{} Syntax Highlighter Hack

        public func addRegion(name: Text, location: L.Location) : Nat {
            regions.add(R.Region(name, location));
            regions.size() - 1
        };

        public func setRegion(id: Nat, name: Text, location: L.Location) {
            regions.put(id, R.Region(name, location));
        };
        public func getRegions() : B.Buffer<R.Region> {
            regions
        };
    };

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
}