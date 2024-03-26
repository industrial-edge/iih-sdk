## Main.py

Please copy the python source code given below and replace the content of main.py. The file path is services/(service_name)/src/main.py

```
import json
import logging
import streamlit as st
import pandas as pd
import time

from dependencies.iih_essentials.api.data_api import DataApi
from dependencies.iih_essentials.api.variables_api import VariablesApi
from datetime import datetime, timedelta
 
logging.basicConfig(level=logging.INFO, format='%(asctime)s | %(levelname)s | %(filename)s | %(funcName)s |  %(message)s')

if __name__=="__main__":
    logging.info("Main Initiated")
    variables = VariablesApi().data_service_variables_get(async_req=False).to_dict()["variables"][0]["variable_id"]
    logging.info("Variable %s", [variables])

    placeholder = st.empty()
    while(True):
        time.sleep(1)
        with placeholder.container():
            current_date = datetime.now()
            previous_date = current_date - timedelta(seconds = 360)
            logging.info("From Date %s",previous_date.isoformat())
            logging.info("To Date %s",current_date.isoformat())
            response = DataApi().data_service_data_get(variable_ids=json.dumps([variables]), _from=previous_date.isoformat(), to=current_date.isoformat())
            # logging.info("Response %s", response)
            response_dict = response.to_dict()["data"][0]["values"]
            logging.info(f"Response {response_dict}")
            df = pd.DataFrame(response_dict)
            st.title('Streamlit Graph Display')
            st.line_chart(df[['timestamp', 'value']].set_index('timestamp'))
            st.write("Historic Data :")
            st.write(df)
```



## Pyproject.toml
Please copy the configuration given below and append it to the right sections. 

Add the following dependencies under the [tool.poetry.dependencies]. If incase you have other packages already, just append these lines. Also, please make sure the python is as needed for your app. Please modify the version as needed, for example here we have the python version as 3.10.13, but if you are using a different version, please verify.

```
[tool.poetry.dependencies]
python = "3.10.13"
paho-mqtt = "1.6.1"
```

Add this under [tool.poetry.dev-dependencies]. If incase you have other packages already, just append these lines. Please modify the version as needed, for example here we have the streamlit version as 1.20.0, but if you are using a different version, please verify.

```
[tool.poetry.dev-dependencies]
python = "3.10.13"
streamlit = "1.20.0"
plotly = "5.18.0"
```

## Dockerfile 
We have 2 stages in the Dockerfile, one for development and one for production. Please update the start commands 'CMD' as needed for your application. For this example, please replace the CMD in line no 30 and 37 with the CMD command given below.

The Docker file  path is - services/(service_name)/Dockerfile
```
CMD ["streamlit", "run", "main.py", "--server.port", "8889"]
```

### Docker compose 
Since we are developing a application which has a web user interface, the port at which the server listens has to exposed. 

Please add these lines to service in the existing docker-compose.yaml
```
    ports:
      - 34001:34001
```
This will map the external port 34001 and to internal port 34001. 

As an example, the modified docker compose file will look this if the service name is 'get-data-from-iih'. The service name in your case could be different, please verify. The docker compose file path - docker-compose.yml

```
version: "2.4"
services:
  
  get-data-from-iih:
    container_name: get-data-from-iih
    image: get-data-from-iih:1.0
    ports:
      - 34001:34001
  
    mem_limit: 2048mb
    restart: 'on-failure'
    networks:
      proxy-redirect:
  
networks:                                                                                     
  proxy-redirect:
    name: proxy-redirect
    driver: bridge
    external: true

volumes:
  app-volume:
    name: app-volume

```
