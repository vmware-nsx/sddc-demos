import nsxt_parameters
import requests
import json
import time

# Disable Certificate verification
requests.packages.urllib3.disable_warnings()

# URL Definition
url = "https://" + nsxt_parameters.nsxt_manager01_url + "/api/v1/fabric/compute-managers"
compute_manager_id = requests.get(url, verify=False, headers=nsxt_parameters.headers, )


compute_manager_id_json = json.loads(compute_manager_id.text)
#print(compute_manager_verification_json)

vcenter_id = compute_manager_id_json["results"][0]["id"]
print("The vCenter ID is: ", vcenter_id )

# The Python Script will verify if the vCenter is registered 
url_verify = "https://" + nsxt_parameters.nsxt_manager01_url + "/api/v1/fabric/compute-managers/" + vcenter_id + "/status"

compute_manager_status = requests.get(url_verify, verify=False, headers=nsxt_parameters.headers)

compute_manager_status_json = json.loads(compute_manager_status.text)

if compute_manager_status.status_code == 200:
    print("The configuration has been accepted, the status code is: ", compute_manager_status.status_code)
    print("The actual response from the API is:")
    print(compute_manager_status_json)
    if compute_manager_status_json['connection_status'] == 'UP':
        if compute_manager_status_json['registration_status'] == 'REGISTERED':
            print("vCenter has been successfully registered")
        else:
            print("TO DEBUG")
    else:
        print("TO DEBUG")













