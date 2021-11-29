import nsxt_parameters
import requests
import json

# Disable Certificate verification
requests.packages.urllib3.disable_warnings()

# URL Definition
url = "https://" + nsxt_parameters.nsxt_manager01_url + "/api/v1/cluster-profiles"


# API Call feedback
#print(get_global_config_response.status_code)
#print(get_global_config_response.text)
#print("\n\n\n")
#print(type(get_global_config_response_json))
#print(get_global_config_response_json)



edge_cluster_profile_data_dict =[
    {
    "resource_type": "EdgeHighAvailabilityProfile",

    "bfd_probe_interval": 500,
    "bfd_allowed_hops": 255,
    "bfd_declare_dead_multiple": 3,
    "standby_relocation_config": {
        "standby_relocation_threshold": 30
        },
        "resource_type": "EdgeHighAvailabilityProfile",
        "display_name": "Edge Cluster Profile - Edge VM",
        "description": "Lowest BFD Timers for Edge VM - Provisioned using Python and REST API"
    },
    {
    "resource_type": "EdgeHighAvailabilityProfile",

    "bfd_probe_interval": 50,
    "bfd_allowed_hops": 255,
    "bfd_declare_dead_multiple": 3,
    "standby_relocation_config": {
        "standby_relocation_threshold": 30
        },
        "resource_type": "EdgeHighAvailabilityProfile",
        "display_name": "Edge Cluster Profile - Edge BM",
        "description": "Lowest BFD Timers for Edge BM - Provisioned using Python and REST API"
    }               
]

for edge_clusters_profile_data in edge_cluster_profile_data_dict:
    edge_cluster_profile_data_dict_str = json.dumps(edge_clusters_profile_data)
    set_edge_cluster_config_requests = requests.post(url, verify=False, headers= nsxt_parameters.headers, data=edge_cluster_profile_data_dict_str)

    if set_edge_cluster_config_requests.status_code == 200:
        print("The configuration has been accepted, the status code is: ", set_edge_cluster_config_requests.status_code)
        print("The actual response from the API is:")
        print(set_edge_cluster_config_requests.text)
    elif set_edge_cluster_config_requests.status_code == 201:
        print("The configuration has been accepted, the status code is: ", set_edge_cluster_config_requests.status_code)
        print("The actual response from the API is:")
        print(set_edge_cluster_config_requests.text)
    else:
        print("****** ERROR *******")
        print("The status code is: ", set_edge_cluster_config_requests.status_code)
        print("The actual response from the API is:")
        print(set_edge_cluster_config_requests.text)



















#
#
#edge_cluster_profile_data_dict_str = json.dumps(edge_cluster_profile_data_dict)
#
#set_edge_cluster_config_requests = requests.post(url, verify=False, headers= nsxt_parameters.headers, data=edge_cluster_profile_data_dict_str)
#
#
#
#
#
#
#if set_edge_cluster_config_requests.status_code == 200:
#    print("The configuration has been accepted, the status code is: ", set_edge_cluster_config_requests.status_code)
#    print("The actual response from the API is:")
#    print(set_edge_cluster_config_requests.text)
#elif set_edge_cluster_config_requests.status_code == 201:
#    print("The configuration has been accepted, the status code is: ", set_edge_cluster_config_requests.status_code)
#    print("The actual response from the API is:")
#    print(set_edge_cluster_config_requests.text)
#else:
#    print("****** ERROR *******")
#    print("The status code is: ", set_edge_cluster_config_requests.status_code)
#    print("The actual response from the API is:")
#    print(set_edge_cluster_config_requests.text)






