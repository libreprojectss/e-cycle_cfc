import requests
import json
import time
import geopandas as gpd # for visualization
BASE_API_URL = 'https://raw-data-api0.hotosm.org/v1'


headers = {'accept': "application/json","Content-Type": "application/json"}
def get_amenity(amenity):
  payload = {
  "outputType": "geojson",
  "fileName": "Pokhara_buildings",
  "geometry": {
    "type": "Polygon",
    "coordinates": [
      [
            [
              83.85431608008628,
              28.29347235664565
            ],
            [
              83.85431608008628,
              28.07970927182484
            ],
            [
              84.15592415509326,
              28.07970927182484
            ],
            [
              84.15592415509326,
              28.29347235664565
            ],
            [
              83.85431608008628,
              28.29347235664565
            ]
          ]
    ]
  },
  "filters": {
    "tags": {
      "all_geometry": {
        "join_or": {
          "amenity": [amenity]
        },
      }
    },
    "attributes": {
      "all_geometry": [
        "name"
      ]
    }
  },
  "geometryType": [
    "point",
    "polygon"
  ]
}
# making call to the api to get boundary
  task_response = requests.post(url = f"{BASE_API_URL}/snapshot/", data = json.dumps(payload),headers=headers)

  # raise if any error occurs
  task_response.raise_for_status()
  result = task_response.json() # I will be on queue and it gives my unique task_id and link to track it
  task_track_url = result['track_link']
  stop_loop = False
  while not stop_loop:
    check_result = requests.get(url=f"{BASE_API_URL}{task_track_url}")
    check_result.raise_for_status()
    res=check_result.json() # status will tell current status of your task after it turns to success it will give result
    if res['status'] == 'SUCCESS'or res['status'] == 'FAILED':
      stop_loop= True
    time.sleep(1) # check each second
  return(res)