export const idlFactory = ({ IDL }) => {
  const Location = IDL.Record({
    'micro_lat' : IDL.Int32,
    'micro_long' : IDL.Int32,
  });
  const Region = IDL.Record({ 'name' : IDL.Text, 'location' : Location });
  const Country = IDL.Record({
    'name' : IDL.Text,
    'regions' : IDL.Vec(Region),
  });
  const Duration = IDL.Variant({
    'Days' : IDL.Null,
    'Weeks' : IDL.Null,
    'Years' : IDL.Null,
    'Months' : IDL.Null,
  });
  const Time = IDL.Int;
  const HostV2 = IDL.Record({
    'foo' : IDL.Int32,
    'duration' : Duration,
    'active' : IDL.Bool,
    'pets' : IDL.Bool,
    'last_updated' : Time,
    'start_date' : Time,
    'rooms_available' : IDL.Nat16,
  });
  const HttpCounter = IDL.Service({
    'add_country' : IDL.Func([Country], [IDL.Nat], []),
    'add_host' : IDL.Func([HostV2], [IDL.Nat], []),
    'add_region' : IDL.Func([IDL.Nat, Region], [IDL.Nat], []),
    'check_admin' : IDL.Func([], [IDL.Bool], []),
    'get_countries' : IDL.Func([], [IDL.Vec(Country)], ['query']),
    'get_host' : IDL.Func([IDL.Nat], [HostV2], ['query']),
    'set_country_name' : IDL.Func([IDL.Nat, IDL.Text], [], ['oneway']),
    'set_next_admin' : IDL.Func([IDL.Principal], [], ['oneway']),
    'switch_admin' : IDL.Func([], [], ['oneway']),
    'update_region' : IDL.Func([IDL.Nat, IDL.Nat, Region], [], ['oneway']),
  });
  return HttpCounter;
};
export const init = ({ IDL }) => { return []; };
