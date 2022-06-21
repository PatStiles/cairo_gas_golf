%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.find_element import find_element

struct KeyValue:
    member id : felt
    member value : felt
end

########################
#     STORAGE VARS     #
########################

# basic mapping write
@storage_var
func _num() -> (res : felt):
end

# basic struct mapping
@storage_var
func _arrayCompoundKey(a : felt, b : felt) -> (res : felt):
end

# array defined as elements of key -> value storage map
@storage_var
func _arrayMap(i : felt) -> (res : felt):
end

# basic struct storage
@storage_var
func _key_value() -> (res : KeyValue):
end

#######################
#     SINGLE FELT     #
#######################
@view
func get_num{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (val : felt):
    let (num) = _num.read()
    return (num)
end

@external
func set_num{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(num : felt):
    _num.write(num)
    return ()
end

###########################
#     BASIC ARRAY-MAP     #
###########################
@view
func get_elementArrayMap{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _i : felt, _num : felt
) -> (num : felt):
    let (num) = _arrayMap.read(_i)
    return (num=num)
end

@external
func set_elementArrayMap{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _i : felt, _num : felt
):
    _arrayMap.write(_i, _num)
    return ()
end

#####################
#     Multi-Key     #
#####################
@view
func get_elementCompoundKey{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _a : felt, _b : felt
) -> (num : felt):
    let (num) = _arrayCompoundKey.read(_a, _b)
    return (num=num)
end

@external
func set_elementCompoundKey{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _a : felt, _b : felt, _num : felt
):
    _arrayCompoundKey.write(_a, _b, _num)
    return ()
end

#######################
#     BASIC ARRAY     #
#######################

@view
func get_elementArray{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _array_len : felt, _array : felt*, _i : felt
) -> (num : felt):
    return (num=_array[_i])
end

@external
func set_elementArray{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _array_len : felt, _array : felt*, _i : felt, _num : felt
):
    assert _array[_i] = _num
    return ()
end

############################
#     KEY VALUE STRUCT     #
############################
@view
func get_KeyValue{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    keyValue : KeyValue
):
    let (keyValue : KeyValue) = _key_value.read()
    return (keyValue)
end

@external
func set_KeyValue{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _id : felt, _value : felt
):
    _key_value.write(KeyValue(id=_id, value=_value))
    return ()
end

######################################
#     ARRAY OF KEY VALUE STRUCTS     #
######################################
@view
func get_ArrayKeyValue{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _key_value_array_len : felt, _key_value_array : KeyValue*, _i : felt
) -> (keyValue : KeyValue):
    return (keyValue=_key_value_array[_i])
end

@external
func set_ArrayKeyValue{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _key_value_array_len : felt, _key_value_array : KeyValue*, _i : felt, _id : felt, _value : felt
):
    assert _key_value_array[_i] = KeyValue(id=_id, value=_value)
    return ()
end

#################################################
#     Cairolang Felt Array Element Set/Find     #
#################################################
@view
func get_find_element{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _array_len : felt, _array : felt*, _size : felt, _key : felt
) -> (element_len : felt, element : felt*):
    let (element : felt*) = find_element(
        array_ptr=_array, elm_size=_size, n_elms=_array_len, key=_key
    )
    return (_size, element)
end
