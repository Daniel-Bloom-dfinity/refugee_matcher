import Buffer "mo:base/Buffer";

module {
    public func load_id<A, B>(stable_data : [A], map: (Nat, A) -> B) : Buffer.Buffer<B> {
        let runtime_data = Buffer.Buffer<B>(stable_data.size());
        var i = 0;
        for (v in stable_data.vals()) {
            runtime_data.add(map(i, v));
            i += 1;
        };
        runtime_data
    };

    public func load_with_data<A, B, D>(stable_data : [A], d: D, map: (D, A) -> B) : Buffer.Buffer<B> {
        let runtime_data = Buffer.Buffer<B>(stable_data.size());
        for (v in stable_data.vals()) {
            runtime_data.add(map(d, v));
        };
        runtime_data
    };
}