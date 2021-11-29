import nsxt_parameters
import requests
import json
import time

# Disable Certificate verification
requests.packages.urllib3.disable_warnings()

url = "https://" + nsxt_parameters.nsxt_manager01_url + "/policy/api/v1/infra/bfd-profiles/bfd-profile"

#url = "https://srv-nsxt-manager-01.megasp.net/policy/api/v1/infra/vni-pools/vxlan-pool"

bfd_profile = json.dumps(
    {
    "interval": 500,
    "multiple": 3,
    "id": "BFD-Profile",
    "display_name": "BFD-Profile",
    "description": "Provisionned through Rest-API"
    }
)





#vxlan_pool_response = requests.request("PUT", url, verify = False, headers=nsxt_parameters.headers, data=vxlan_pool)

bfd_profile_response = requests.put(url, verify = False, headers=nsxt_parameters.headers, data=bfd_profile)

if bfd_profile_response.status_code == 200:
    print("The configuration has been accepted, the status code is: ", bfd_profile_response.status_code)
    print("The actual response from the API is:")
    print(bfd_profile_response.text)
elif bfd_profile_response.status_code == 201:
    print("The configuration has been accepted, the status code is: ", bfd_profile_response.status_code)
    print("The actual response from the API is:")
    print(bfd_profile_response.text)
else:
    print("****** ERROR *******")
    print("The status code is: ", bfd_profile_response.status_code)
    print("The actual response from the API is:")
    print(bfd_profile_response.text)