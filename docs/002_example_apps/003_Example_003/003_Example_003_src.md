## Main.py
File path - services/(service_name)/src/main.py
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

## Dockerfile 
File path - services/(service_name)/Dockerfile

Add this command in dockerfile to run the your application
```
CMD ["streamlit", "run", "main.py", "--server.port", "8889"]
```

## Pyproject.toml
File path - services/(service_name)/pyproject.toml

Add these dependencies in pyproject.toml
```
[tool.poetry.dependencies]
python = "3.10.13"
streamlit = "1.20.0"
plotly = "5.18.0"
```

### Docker compose 
file path - docker-compose.yml

example - 

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

[Deploy](../Workflows/03-Deploy-Workflow.md) your application as the final step to generate .app file.
Go to your project directory and you'll find a release folder in it. The .app file will be generated there.


