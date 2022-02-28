import Location "location"

module {
    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type V1 = {
        name: Text;
        location: Location.V1;
    };

    public class Runtime(data: V1) {
        var location = Location.Runtime(data.location);
        public func getName() : Text = data.name;
        public func getLocation() : Location.Runtime = location;
    };

    public func toDisk(data: Runtime) : V1 = {
        name = data.getName();
        location = data.getLocation();
    };
    public func getLocation(r: Runtime) : Location.Runtime = r.getLocation();
}
