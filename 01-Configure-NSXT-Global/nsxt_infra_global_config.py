import nsxt_parameters
import requests
import json

# Disable Certificate verification
requests.packages.urllib3.disable_warnings()

# URL Definition
url = "https://" + nsxt_parameters.nsxt_manager01_url + "/policy/api/v1/infra/global-config"


get_global_config_response = requests.get(url, verify=False, headers=nsxt_parameters.headers, )
get_global_config_response_json = get_global_config_response.json()
actual_revision = get_global_config_response_json['_revision']


# API Call feedback
#print(get_global_config_response.status_code)
#print(get_global_config_response.text)
#print("\n\n\n")
#print(type(get_global_config_response_json))
#print(get_global_config_response_json)

global_config_data_dict = {
    "l3_forwarding_mode":"IPV4_AND_IPV6",
    "uplink_mtu_threshold":9000,
    "resource_type":"GlobalConfig",
    "id":"global-config",
    "display_name":"default",
    "path":"/infra/global-config",
    "relative_path":"global-config",
    "parent_path":"/infra",
    "marked_for_delete":"false",
    "_system_owned":"true",
    "_protection":"NOT_PROTECTED",
    "_revision": actual_revision,
    "mtu":9000
}
global_config_data_str = json.dumps(global_config_data_dict)


set_global_config_response = requests.put(url, verify=False, headers=nsxt_parameters.headers, data=global_config_data_str)

if set_global_config_response.status_code == 200:
    print("The configuration has been accepted, the status code is: ", set_global_config_response.status_code)
    print("The actual response from the API is:")
    print(set_global_config_response.text)
elif set_global_config_response.status_code == 201:
    print("The configuration has been accepted, the status code is: ", set_global_config_response.status_code)
    print("The actual response from the API is:")
    print(set_global_config_response.text)
else:
    print("****** ERROR *******")
    print("The status code is: ", set_global_config_response.status_code)
    print("The actual response from the API is:")
    print(set_global_config_response.text)






