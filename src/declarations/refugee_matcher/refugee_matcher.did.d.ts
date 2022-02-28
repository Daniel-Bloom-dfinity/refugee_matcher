import type { Principal } from '@dfinity/principal';
export interface Country { 'name' : string, 'regions' : Array<Region> }
export interface HttpCounter {
  'add_country' : (arg_0: Country) => Promise<bigint>,
  'add_region' : (arg_0: bigint, arg_1: Region) => Promise<bigint>,
  'check_admin' : () => Promise<boolean>,
  'get_countries' : () => Promise<Array<Country>>,
  'greet' : (arg_0: string) => Promise<string>,
  'set_country_name' : (arg_0: bigint, arg_1: string) => Promise<undefined>,
  'set_next_admin' : (arg_0: Principal) => Promise<undefined>,
  'switch_admin' : () => Promise<undefined>,
  'update_region' : (arg_0: bigint, arg_1: bigint, arg_2: Region) => Promise<
      undefined
    >,
}
export interface Location { 'micro_lat' : number, 'micro_long' : number }
export interface Region { 'name' : string, 'location' : Location }
export interface _SERVICE extends HttpCounter {}
