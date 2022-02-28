import type { Principal } from '@dfinity/principal';
export interface Country { 'name' : string, 'regions' : Array<Region> }
export type Duration = { 'Days' : null } |
  { 'Weeks' : null } |
  { 'Years' : null } |
  { 'Months' : null };
export interface HostV2 {
  'foo' : number,
  'duration' : Duration,
  'active' : boolean,
  'pets' : boolean,
  'last_updated' : Time,
  'start_date' : Time,
  'rooms_available' : number,
}
export interface HttpCounter {
  'add_country' : (arg_0: Country) => Promise<bigint>,
  'add_host' : (arg_0: HostV2) => Promise<bigint>,
  'add_region' : (arg_0: bigint, arg_1: Region) => Promise<bigint>,
  'check_admin' : () => Promise<boolean>,
  'get_countries' : () => Promise<Array<Country>>,
  'get_host' : (arg_0: bigint) => Promise<HostV2>,
  'set_country_name' : (arg_0: bigint, arg_1: string) => Promise<undefined>,
  'set_next_admin' : (arg_0: Principal) => Promise<undefined>,
  'switch_admin' : () => Promise<undefined>,
  'update_region' : (arg_0: bigint, arg_1: bigint, arg_2: Region) => Promise<
      undefined
    >,
}
export interface Location { 'micro_lat' : number, 'micro_long' : number }
export interface Region { 'name' : string, 'location' : Location }
export type Time = bigint;
export interface _SERVICE extends HttpCounter {}
