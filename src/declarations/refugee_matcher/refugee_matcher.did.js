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
  const HttpCounter = IDL.Service({
    'add_country' : IDL.Func([Country], [IDL.Nat], []),
    'add_region' : IDL.Func([IDL.Nat, Region], [IDL.Nat], []),
    'check_admin' : IDL.Func([], [IDL.Bool], []),
    'get_countries' : IDL.Func([], [IDL.Vec(Country)], ['query']),
    'greet' : IDL.Func([IDL.Text], [IDL.Text], []),
    'set_country_name' : IDL.Func([IDL.Nat, IDL.Text], [], ['oneway']),
    'set_next_admin' : IDL.Func([IDL.Principal], [], ['oneway']),
    'switch_admin' : IDL.Func([], [], ['oneway']),
    'update_region' : IDL.Func([IDL.Nat, IDL.Nat, Region], [], ['oneway']),
  });
  return HttpCounter;
};
export const init = ({ IDL }) => { return [IDL.Principal]; };
