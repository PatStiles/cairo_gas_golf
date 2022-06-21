from starknet_py.net.client import Client
from starknet_py.contract import Contract
from starknet_py.net.networks import TESTNET
import asyncio

address = "0x066736bb9ed9166dbb467b649e33636633d1eb3f710a0673227f3123418223cc"
client = Client(TESTNET)

async def get_fee_estimate(func_args):
    contract = await Contract.from_address(address, client)
    for k, v in funcs.items():
        if isinstance(v,list):
            invocation = contract.functions[k].prepare(*v)
        if isinstance(v,dict):
            invocation = contract.functions[k].prepare(**v)
        print('function : {0} fee (gwei) : {1}'.format(k, await invocation.estimate_fee()))

# Input for args:
    # struct* = { "_struct_name": [{"key1: 1, "key2: 2}, {key1: 2, key2: 3}]}
    # struct  = { "_struct_name": {"key1: 1, "key2: 2}}

funcs= {
        "get_num" : [],
        "set_num" : [1],
        "get_elementArrayMap" : [1,1],
        "set_elementArrayMap" : [1,1],
        "get_elementCompoundKey" : [1,1],
        "set_elementCompoundKey" : [1,1,1],
        "get_elementArray" : [[1],1],
        "set_elementArray" : [[1],1,1],
        "get_KeyValue" : [], 
        "set_KeyValue" : [1,1], 
        "get_ArrayKeyValue" : {'_key_value_array': [{"id": 1, "value": 1}], '_i': 0}, 
        "set_ArrayKeyValue" : {'_key_value_array': [{"id": 1, "value": 1}], '_i': 0, '_id': 1, '_value':1},
        "get_find_element" : [[1], 1, 1]
        }

asyncio.run(get_fee_estimate(funcs))