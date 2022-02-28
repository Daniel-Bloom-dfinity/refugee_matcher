import type { Principal } from '@dfinity/principal';
export interface Host {
  'duration' : { 'Days' : null } |
    { 'Weeks' : null } |
    { 'Months' : null },
  'accepts_kids' : boolean,
  'accepts_pets' : boolean,
  'offer' : { 'Bed' : null } |
    { 'RoomInHome' : null } |
    { 'FullHouse' : null } |
    { 'HotelHostel' : null } |
    { 'FullApartment' : null } |
    { 'Other' : string },
  'accepts_women' : boolean,
  'accepts_men' : boolean,
  'description' : string,
  'contant_info' : string,
  'start_date' : Time,
  'referral_code' : string,
  'is_active' : boolean,
  'spots_available' : number,
  'location' : [bigint, bigint],
}
export interface HttpCounter {
  'add_country' : (arg_0: V1__2) => Promise<bigint>,
  'add_region' : (arg_0: bigint, arg_1: V1) => Promise<bigint>,
  'backup_hosts' : () => Promise<Array<V1__4>>,
  'backup_refugees' : () => Promise<Array<V1__3>>,
  'check_admin' : () => Promise<boolean>,
  'get_countries' : () => Promise<Array<V1__2>>,
  'set_country_name' : (arg_0: bigint, arg_1: string) => Promise<undefined>,
  'set_next_admin' : (arg_0: Principal) => Promise<undefined>,
  'switch_admin' : () => Promise<undefined>,
  'update_region' : (arg_0: bigint, arg_1: bigint, arg_2: V1) => Promise<
      undefined
    >,
  'upsert_host' : (arg_0: Host) => Promise<undefined>,
  'upsert_refuge' : (arg_0: Refugee) => Promise<undefined>,
}
export interface Refugee {
  'people' : number,
  'description' : string,
  'start_window' : { 'Later' : null } |
    { 'ThisWeek' : null } |
    { 'ASAP' : null } |
    { 'NextWeek' : null },
  'contant_info' : string,
  'referral_code' : string,
  'location' : [bigint, bigint],
  'includes_men' : boolean,
  'includes_women' : boolean,
  'includes_kids' : boolean,
  'includes_pets' : boolean,
}
export type StartTimeWindowV1 = { 'Later' : null } |
  { 'ThisWeek' : null } |
  { 'ASAP' : null } |
  { 'NextWeek' : null };
export type Time = bigint;
export interface V1 { 'name' : string, 'location' : V1__1 }
export interface V1__1 { 'micro_lat' : number, 'micro_long' : number }
export interface V1__2 { 'name' : string, 'regions' : Array<V1> }
export interface V1__3 {
  'owner' : Principal,
  'people' : number,
  'description' : string,
  'last_updated' : Time,
  'start_window' : StartTimeWindowV1,
  'contant_info' : string,
  'is_active' : boolean,
  'location' : [bigint, bigint],
  'includes_men' : boolean,
  'includes_women' : boolean,
  'includes_kids' : boolean,
  'includes_pets' : boolean,
}
export interface V1__4 {
  'duration' : { 'Days' : null } |
    { 'Weeks' : null } |
    { 'Months' : null },
  'accepts_kids' : boolean,
  'accepts_pets' : boolean,
  'offer' : { 'Bed' : null } |
    { 'RoomInHome' : null } |
    { 'FullHouse' : null } |
    { 'HotelHostel' : null } |
    { 'FullApartment' : null } |
    { 'Other' : string },
  'owner' : Principal,
  'accepts_women' : boolean,
  'accepts_men' : boolean,
  'description' : string,
  'last_updated' : Time,
  'contant_info' : string,
  'start_date' : Time,
  'referral_code' : string,
  'is_active' : boolean,
  'spots_available' : number,
  'location' : [bigint, bigint],
}
export interface _SERVICE extends HttpCounter {}
