export const idlFactory = ({ IDL }) => {
  const V1__1 = IDL.Record({
    'micro_lat' : IDL.Int32,
    'micro_long' : IDL.Int32,
  });
  const V1 = IDL.Record({ 'name' : IDL.Text, 'location' : V1__1 });
  const V1__2 = IDL.Record({ 'name' : IDL.Text, 'regions' : IDL.Vec(V1) });
  const Time = IDL.Int;
  const V1__4 = IDL.Record({
    'duration' : IDL.Variant({
      'Days' : IDL.Null,
      'Weeks' : IDL.Null,
      'Months' : IDL.Null,
    }),
    'accepts_kids' : IDL.Bool,
    'accepts_pets' : IDL.Bool,
    'offer' : IDL.Variant({
      'Bed' : IDL.Null,
      'RoomInHome' : IDL.Null,
      'FullHouse' : IDL.Null,
      'HotelHostel' : IDL.Null,
      'FullApartment' : IDL.Null,
      'Other' : IDL.Text,
    }),
    'owner' : IDL.Principal,
    'accepts_women' : IDL.Bool,
    'accepts_men' : IDL.Bool,
    'description' : IDL.Text,
    'last_updated' : Time,
    'contant_info' : IDL.Text,
    'start_date' : Time,
    'referral_code' : IDL.Text,
    'is_active' : IDL.Bool,
    'spots_available' : IDL.Nat16,
    'location' : IDL.Tuple(IDL.Nat, IDL.Nat),
  });
  const StartTimeWindowV1 = IDL.Variant({
    'Later' : IDL.Null,
    'ThisWeek' : IDL.Null,
    'ASAP' : IDL.Null,
    'NextWeek' : IDL.Null,
  });
  const V1__3 = IDL.Record({
    'owner' : IDL.Principal,
    'people' : IDL.Nat16,
    'description' : IDL.Text,
    'last_updated' : Time,
    'start_window' : StartTimeWindowV1,
    'contant_info' : IDL.Text,
    'is_active' : IDL.Bool,
    'location' : IDL.Tuple(IDL.Nat, IDL.Nat),
    'includes_men' : IDL.Bool,
    'includes_women' : IDL.Bool,
    'includes_kids' : IDL.Bool,
    'includes_pets' : IDL.Bool,
  });
  const Host = IDL.Record({
    'duration' : IDL.Variant({
      'Days' : IDL.Null,
      'Weeks' : IDL.Null,
      'Months' : IDL.Null,
    }),
    'accepts_kids' : IDL.Bool,
    'accepts_pets' : IDL.Bool,
    'offer' : IDL.Variant({
      'Bed' : IDL.Null,
      'RoomInHome' : IDL.Null,
      'FullHouse' : IDL.Null,
      'HotelHostel' : IDL.Null,
      'FullApartment' : IDL.Null,
      'Other' : IDL.Text,
    }),
    'accepts_women' : IDL.Bool,
    'accepts_men' : IDL.Bool,
    'description' : IDL.Text,
    'contant_info' : IDL.Text,
    'start_date' : Time,
    'referral_code' : IDL.Text,
    'is_active' : IDL.Bool,
    'spots_available' : IDL.Nat16,
    'location' : IDL.Tuple(IDL.Nat, IDL.Nat),
  });
  const Refugee = IDL.Record({
    'people' : IDL.Nat16,
    'description' : IDL.Text,
    'start_window' : IDL.Variant({
      'Later' : IDL.Null,
      'ThisWeek' : IDL.Null,
      'ASAP' : IDL.Null,
      'NextWeek' : IDL.Null,
    }),
    'contant_info' : IDL.Text,
    'referral_code' : IDL.Text,
    'location' : IDL.Tuple(IDL.Nat, IDL.Nat),
    'includes_men' : IDL.Bool,
    'includes_women' : IDL.Bool,
    'includes_kids' : IDL.Bool,
    'includes_pets' : IDL.Bool,
  });
  const HttpCounter = IDL.Service({
    'add_country' : IDL.Func([V1__2], [IDL.Nat], []),
    'add_region' : IDL.Func([IDL.Nat, V1], [IDL.Nat], []),
    'backup_hosts' : IDL.Func([], [IDL.Vec(V1__4)], []),
    'backup_refugees' : IDL.Func([], [IDL.Vec(V1__3)], []),
    'check_admin' : IDL.Func([], [IDL.Bool], []),
    'get_countries' : IDL.Func([], [IDL.Vec(V1__2)], ['query']),
    'set_country_name' : IDL.Func([IDL.Nat, IDL.Text], [], ['oneway']),
    'set_next_admin' : IDL.Func([IDL.Principal], [], ['oneway']),
    'switch_admin' : IDL.Func([], [], ['oneway']),
    'update_region' : IDL.Func([IDL.Nat, IDL.Nat, V1], [], ['oneway']),
    'upsert_host' : IDL.Func([Host], [], ['oneway']),
    'upsert_refuge' : IDL.Func([Refugee], [], ['oneway']),
  });
  return HttpCounter;
};
export const init = ({ IDL }) => { return [IDL.Principal]; };
