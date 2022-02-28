import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Location "location";
import Region "region";
import Utils "utils"

module {
    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type V1 = {
        name: Text;
        regions: [Region.V1];
    };

    /// Runtime data for countries
    public class Runtime(id: Nat, data: V1) {
        var name = data.name;
        var regions = Utils.load_id<Region.V1, Region.Runtime>(data.regions, Region.Runtime);
        
        public func setName(n: Text) {
            name := n;
        };
        public func getName() : Text = name; //{} Syntax Highlighter Hack

        public func addRegion(r: Region.V1) : Nat {
            let id = regions.size();
            regions.add(Region.Runtime(id, r));
            id
        };

        public func setRegion(id: Nat, r: Region.Runtime) {
            regions.put(id, r);
        };
        public func getRegion(id: Nat) : Region.Runtime = regions.get(id);
        public func getRegions() : Buffer.Buffer<Region.Runtime> {
            regions
        };
    };

    public func toDisk(data: Runtime) : V1 = {
        name = data.getName();
        regions = Iter.toArray(Iter.map(data.getRegions().vals(), Region.toDisk));
    }
}
