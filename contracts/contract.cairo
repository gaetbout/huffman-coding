%lang starknet
#
# Imports
#
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
#
# Structures
#
struct CharacterOccurence:
    # The character
    member character : felt
    # Its number of occurences
    member occurences : felt
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
    generate_list_of_occurences_recursive(arr_len, arr, 0)
    return ()
end

func generate_list_of_occurences_recursive{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        arr_len : felt, arr : felt*, current_index : felt) -> ():
    return ()
end

# let (local arr : CharacterOccurence*) = alloc()
# assert arr[0] = CharacterOccurence('T', 1)
# assert arr[1] = CharacterOccurence('g', 1)
# assert arr[2] = CharacterOccurence('h', 1)

# En vrai faut faire une méthode increment qui return le nvel array et length
#   Si il trouve le truc il inc
#   Si il trouve pas il ajoute un objet stou

@view
func do_it{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
        arr_len : felt, arr : CharacterOccurence*):
    alloc_locals
    let (arr_len, arr) = string_to_compress()
    let (local arr_character : CharacterOccurence*) = alloc()

    return do_it_recursive(arr_len, arr, 0, arr_character, 0)
end

func do_it_recursive{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        arr_character_len : felt, arr_character : felt*, arr_occurences_len : felt,
        arr_occurences : CharacterOccurence*, current_index : felt) -> (
        arr_len : felt, arr : CharacterOccurence*):
    if arr_character_len == current_index:
        return (arr_occurences_len, arr_occurences)
    end
    let current_caracter = arr_character[current_index]
    let (found) = check_character_already_in(arr_occurences_len, arr_occurences, current_caracter)
    if found == 1:
        return do_it_recursive(
            arr_character_len,
            arr_character,
            arr_occurences_len,
            arr_occurences,
            current_index + 1)
    end
    let (nb_occurences) = count_occurences_of(arr_character_len, arr_character, current_caracter)
    assert arr_occurences[arr_occurences_len] = CharacterOccurence(current_caracter, nb_occurences)
    return do_it_recursive(
        arr_character_len,
        arr_character,
        arr_occurences_len + 1,
        arr_occurences,
        current_index + 1)
end

func check_character_already_in{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        arr_len : felt, arr : CharacterOccurence*, character : felt) -> (found : felt):
    return check_character_already_in_recursive(arr_len, arr, character, 0)
end

func check_character_already_in_recursive{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        arr_len : felt, arr : CharacterOccurence*, character : felt, current_index : felt) -> (
        found : felt):
    if arr_len == current_index:
        return (0)
    end
    if arr[current_index].character == character:
        return (1)
    end
    return check_character_already_in_recursive(arr_len, arr, character, current_index + 1)
end

func count_occurences_of{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        arr_len : felt, arr : felt*, character : felt) -> (nb_occurences : felt):
    return count_occurences_of_recursive(arr_len, arr, character, 0, 0)
end

func count_occurences_of_recursive{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        arr_len : felt, arr : felt*, character : felt, current_count : felt,
        current_index : felt) -> (nb_occurences : felt):
    if arr_len == current_index:
        return (current_count)
    end
    if arr[current_index] == character:
        return count_occurences_of_recursive(
            arr_len, arr, character, current_count + 1, current_index + 1)
    end
    return count_occurences_of_recursive(arr_len, arr, character, current_count, current_index + 1)
end
