import L "location"

module {
    public class Region(name: Text, location: L.Location) {
        public func getName() : Text = name;
        public func getLocation() : L.Location = location;
    };

    public func getLocation(r: Region) : L.Location = r.getLocation();
}
