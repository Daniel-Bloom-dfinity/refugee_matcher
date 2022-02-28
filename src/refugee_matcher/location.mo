module {
    /// "On Disk" for upgrades
    /// DO NOT CHANGE
    public type V1 = {
        /// GPS coords in micro degrees
        micro_lat: Int32;
        micro_long: Int32;
    };

    public type Runtime = V1;
    public func Runtime(data: V1) : Runtime = data; // {}
    public func toDisk(data: Runtime) : V1 = data;
}
