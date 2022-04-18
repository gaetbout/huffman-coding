%lang starknet
#
# Imports
#
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.math_cmp import is_le
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
    arr_len : felt, arr : felt*
):
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
func do_it{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    arr_len : felt, arr : CharacterOccurence*
):
    let (arr_len, arr) = string_to_compress()
    let (arr_occurences_len, arr_occurences) = generate_list_of_occurences(arr_len, arr)
    let (arr_sorted_len, arr_sorted) = sort_occurences_array(arr_occurences_len, arr_occurences)
    return (arr_sorted_len, arr_sorted)
end

#
# Generating list of occurences
#

func generate_list_of_occurences{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    arr_len : felt, arr : felt*
) -> (arr_len : felt, arr : CharacterOccurence*):
    alloc_locals
    let (local arr_character : CharacterOccurence*) = alloc()
    return generate_list_of_occurences_recursive(arr_len, arr, 0, arr_character, 0)
end

func generate_list_of_occurences_recursive{
    syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
}(
    arr_character_len : felt,
    arr_character : felt*,
    arr_occurences_len : felt,
    arr_occurences : CharacterOccurence*,
    current_index : felt,
) -> (arr_len : felt, arr : CharacterOccurence*):
    if arr_character_len == current_index:
        return (arr_occurences_len, arr_occurences)
    end
    let current_caracter = arr_character[current_index]
    let (found) = check_character_already_in(arr_occurences_len, arr_occurences, current_caracter)
    if found == 1:
        return generate_list_of_occurences_recursive(
            arr_character_len, arr_character, arr_occurences_len, arr_occurences, current_index + 1
        )
    end
    let (nb_occurences) = count_occurences_of(arr_character_len, arr_character, current_caracter)
    assert arr_occurences[arr_occurences_len] = CharacterOccurence(current_caracter, nb_occurences)
    return generate_list_of_occurences_recursive(
        arr_character_len, arr_character, arr_occurences_len + 1, arr_occurences, current_index + 1
    )
end

func check_character_already_in{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    arr_len : felt, arr : CharacterOccurence*, character : felt
) -> (found : felt):
    return check_character_already_in_recursive(arr_len, arr, character, 0)
end

func check_character_already_in_recursive{
    syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
}(arr_len : felt, arr : CharacterOccurence*, character : felt, current_index : felt) -> (
    found : felt
):
    if arr_len == current_index:
        return (0)
    end
    if arr[current_index].character == character:
        return (1)
    end
    return check_character_already_in_recursive(arr_len, arr, character, current_index + 1)
end

func count_occurences_of{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    arr_len : felt, arr : felt*, character : felt
) -> (nb_occurences : felt):
    return count_occurences_of_recursive(arr_len, arr, character, 0, 0)
end

func count_occurences_of_recursive{
    syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
}(arr_len : felt, arr : felt*, character : felt, current_count : felt, current_index : felt) -> (
    nb_occurences : felt
):
    if arr_len == current_index:
        return (current_count)
    end
    if arr[current_index] == character:
        return count_occurences_of_recursive(
            arr_len, arr, character, current_count + 1, current_index + 1
        )
    end
    return count_occurences_of_recursive(arr_len, arr, character, current_count, current_index + 1)
end

#
# Sorting
#

func sort_occurences_array{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    arr_len : felt, arr : CharacterOccurence*
) -> (arr_len : felt, arr : CharacterOccurence*):
    alloc_locals
    let (local arr_sorted : CharacterOccurence*) = alloc()
    return sort_occurences_array_recursive(arr_len, arr, 0, arr_sorted)
end

func sort_occurences_array_recursive{
    syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
}(
    arr_occurences_len : felt,
    arr_occurences : CharacterOccurence*,
    arr_sorted_len : felt,
    arr_sorted : CharacterOccurence*,
) -> (arr_sorted_len : felt, arr_sorted : CharacterOccurence*):
    alloc_locals
    # Array to be sorted is empty
    if arr_occurences_len == 0:
        return (arr_sorted_len, arr_sorted)
    end
    let (maxCharacterOccurences) = find_max_occurences(arr_occurences_len, arr_occurences)
    let (newArrayOccLen, newArrayOcc) = create_new_array_without(
        arr_occurences_len, arr_occurences, maxCharacterOccurences
    )
    # Pushing the max occurence to the last available spot
    assert arr_sorted[arr_sorted_len] = maxCharacterOccurences

    return sort_occurences_array_recursive(
        newArrayOccLen, newArrayOcc, arr_sorted_len + 1, arr_sorted
    )
end

func find_max_occurences{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    arr_len : felt, arr : CharacterOccurence*
) -> (max_occurences : CharacterOccurence):
    if arr_len == 1:
        return (arr[0])
    end
    return find_max_occurences_recursive(arr_len, arr, arr[0], 1)
end
func find_max_occurences_recursive{
    syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
}(
    arr_len : felt,
    arr : CharacterOccurence*,
    current_max : CharacterOccurence,
    current_index : felt,
) -> (max_occurences : CharacterOccurence):
    if arr_len == current_index:
        return (current_max)
    end
    let (isMaxSmallerOrEqualThenCurrent) = is_le(
        current_max.occurences, arr[current_index].occurences
    )
    if isMaxSmallerOrEqualThenCurrent == 1:
        return find_max_occurences_recursive(arr_len, arr, arr[current_index], current_index + 1)
    end

    return find_max_occurences_recursive(arr_len, arr, current_max, current_index + 1)
end

func create_new_array_without{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    arr_len : felt, arr : CharacterOccurence*, item_to_remove : CharacterOccurence
) -> (arr_len : felt, arr : CharacterOccurence*):
    alloc_locals
    let (local arr_new : CharacterOccurence*) = alloc()
    return create_new_array_without_recursive(arr_len, arr, 0, arr_new, item_to_remove, 0)
end

func create_new_array_without_recursive{
    syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
}(
    arr_len : felt,
    arr : CharacterOccurence*,
    arr_new_len : felt,
    arr_new : CharacterOccurence*,
    item_to_remove : CharacterOccurence,
    current_index : felt,
) -> (arr_len : felt, arr : CharacterOccurence*):
    if arr_len == current_index:
        return (arr_new_len, arr_new)
    end
    # TODO Compare structure?
    if arr[current_index].character == item_to_remove.character:
        return create_new_array_without_recursive(
            arr_len, arr, arr_new_len, arr_new, item_to_remove, current_index + 1
        )
    end
    assert arr_new[arr_new_len] = arr[current_index]
    return create_new_array_without_recursive(
        arr_len, arr, arr_new_len + 1, arr_new, item_to_remove, current_index + 1
    )
end
