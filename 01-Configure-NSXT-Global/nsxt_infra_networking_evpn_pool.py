import nsxt_parameters
import requests
import json
import time

# Disable Certificate verification
requests.packages.urllib3.disable_warnings()

url = "https://" + nsxt_parameters.nsxt_manager01_url + "/policy/api/v1/infra/vni-pools/vxlan-pool"

#url = "https://srv-nsxt-manager-01.megasp.net/policy/api/v1/infra/vni-pools/vxlan-pool"

vxlan_pool = json.dumps({
    "start": 100000,
    "end": 110000,
    "id": "VXLAN-VNI-Pool",
    "display_name": "VXLAN-VNI-Pool",
    "description": "Provisionned through Rest-API"
}
)

#vxlan_pool_response = requests.request("PUT", url, verify = False, headers=nsxt_parameters.headers, data=vxlan_pool)

vxlan_pool_response = requests.put(url, verify = False, headers=nsxt_parameters.headers, data=vxlan_pool)

if vxlan_pool_response.status_code == 200:
    print("The configuration has been accepted, the status code is: ", vxlan_pool_response.status_code)
    print("The actual response from the API is:")
    print(vxlan_pool_response.text)
elif vxlan_pool_response.status_code == 201:
    print("The configuration has been accepted, the status code is: ", vxlan_pool_response.status_code)
    print("The actual response from the API is:")
    print(vxlan_pool_response.text)
else:
    print("****** ERROR *******")
    print("The status code is: ", vxlan_pool_response.status_code)
    print("The actual response from the API is:")
    print(vxlan_pool_response.text)