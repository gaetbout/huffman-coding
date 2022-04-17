%lang starknet
#
# Imports
#
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.alloc import alloc

#
# Constructor
#

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    return ()
end
#
# Events
#
# call using
#    Log.emit("Something", get_caller_address(), 1, 2)
@event
func Log(stringValue : felt, sender_address : felt, value : felt, data : felt):
end

@event
func EventName(account : felt, tokenId : Uint256):
end

#
# Storage vars
#
@storage_var
func name_of_storage(arg1 : felt) -> (returnValue : felt):
end

#
# Getters
#
@view
func string_to_compress{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
        arr_len : felt, arr : felt*):
    let (arr) = alloc()
    # This is a sentence that needs to be compressed.
    assert arr[0] = 'T'
    assert arr[1] = 'h'
    assert arr[2] = 'i'
    assert arr[3] = 's'
    assert arr[4] = ' '
    assert arr[5] = 'i'
    assert arr[6] = 's'
    assert arr[7] = ' '
    assert arr[8] = 'a'
    assert arr[9] = ' '
    assert arr[10] = 's'
    assert arr[11] = 'e'
    assert arr[12] = 'n'
    assert arr[13] = 't'
    assert arr[14] = 'e'
    assert arr[15] = 'n'
    assert arr[16] = 'c'
    assert arr[17] = 'e'
    assert arr[18] = ' '
    assert arr[19] = 't'
    assert arr[20] = 'h'
    assert arr[21] = 'a'
    assert arr[22] = 't'
    assert arr[23] = ' '
    assert arr[24] = 'n'
    assert arr[25] = 'e'
    assert arr[26] = 'e'
    assert arr[27] = 'd'
    assert arr[28] = 's'
    assert arr[29] = ' '
    assert arr[30] = 't'
    assert arr[31] = 'o'
    assert arr[32] = ' '
    assert arr[33] = 'b'
    assert arr[34] = 'e'
    assert arr[35] = ' '
    assert arr[36] = 'c'
    assert arr[37] = 'o'
    assert arr[38] = 'm'
    assert arr[39] = 'p'
    assert arr[40] = 'r'
    assert arr[41] = 'e'
    assert arr[42] = 's'
    assert arr[43] = 's'
    assert arr[44] = 'e'
    assert arr[45] = 'd'
    assert arr[46] = '.'

    return (47, arr)
end

@view
func generate_list_of_occurences{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        arr_len : felt, arr : felt*) -> ():
    return ()
end
