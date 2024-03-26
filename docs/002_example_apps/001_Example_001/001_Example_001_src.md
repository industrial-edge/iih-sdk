## Main.py

Please copy the python source code given below and replace the content of main.py. The file path is services/(service_name)/src/main.py

```
import logging
import time
import numpy as np
import streamlit as st
import plotly.graph_objs as go
from datetime import datetime
import pytz
logging.basicConfig(level=logging.INFO, format='%(asctime)s | %(levelname)s | %(filename)s | %(funcName)s |  %(message)s')

if __name__=="__main__":
    logging.info("Main Initiated")

    x_values = []
    y_values = [0.1, 0.2, 0.3, 0.4, 0.5, 0.1, 0.2, 0.3, 0.4, 0.5]
    st.title("Edge app without dependencies")
    st.write("The app doesn't depend on any IIH/IE apps.")
    placeholder = st.empty()

    while True:
        time.sleep(1)
        with placeholder.container():
                x_values.append(datetime.now(pytz.timezone('Europe/Berlin')).strftime("%H:%M:%S")) #change to current timezone
                if len(x_values) > 10:
                        x_values.pop(0)
                        y_values = np.roll(y_values, -1)

                logging.info(f"Data Generated: {y_values}")
                realtime_databus_chart, realtime_databus_data = st.columns([3, 1])
                realtime_databus_data.metric(
                        label="Current data",
                        value=y_values[-1]
                )

                realtime_databus_chart.subheader("Time series plot")
                fig = go.Figure(data=go.Scatter(x=x_values, y=y_values, mode='lines+markers', name="Triangle Wave"))
                fig.update_xaxes(title_text="Timestamp")
                fig.update_yaxes(title_text="Process Values")
                realtime_databus_chart.plotly_chart(fig)
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
streamlit = "1.20.0"
plotly = "5.18.0"
```

## Dockerfile

We have 2 stages in the Dockerfile, one for development and one for production. Please update the start commands 'CMD' as needed for your application. For this example, please replace the CMD in line no 30 and 37 with the CMD command given below.

The Docker file  path is - services/(service_name)/Dockerfile
```
CMD ["streamlit", "run", "main.py", "--server.port", "8887"]
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




