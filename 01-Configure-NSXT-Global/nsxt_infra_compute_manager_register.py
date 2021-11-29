import nsxt_parameters
import requests
import json
import time

# Disable Certificate verification
requests.packages.urllib3.disable_warnings()

# URL Definition
url = "https://" + nsxt_parameters.nsxt_manager01_url + "/api/v1/fabric/compute-managers"

compute_manager_dict = {
    "server": "", # input needed here
    "display_name": "vCenter",
    "origin_type": "vCenter",
    "id": "vCenter",
    "credential": {
        "credential_type": "UsernamePasswordLoginCredential",
        "username": "", # input needed here
        "password": "", # input needed here
        "thumbprint": "" # input needed here
        }
        }

compute_manager_str = json.dumps(compute_manager_dict)


compute_manager_response = requests.post(url, verify=False, headers=nsxt_parameters.headers, data=compute_manager_str)

if compute_manager_response.status_code == 200:
    print("The configuration has been accepted, the status code is: ", compute_manager_response.status_code)
    print("The actual response from the API is:")
    print(compute_manager_response.text)
elif compute_manager_response.status_code == 201:
    print("The configuration has been accepted, the status code is: ", compute_manager_response.status_code)
    print("The actual response from the API is:")
    print(compute_manager_response.text)
else:
    print("****** ERROR *******")
    print("The status code is: ", compute_manager_response.status_code)
    print("The actual response from the API is:")
    print(compute_manager_response.text)



time.sleep(30)






