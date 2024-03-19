## Main.py
File path - services/(service_name)/src/main.py

```
"""Service driver code starts here"""
import time
import logging
import streamlit as st
import plotly.graph_objects as go
from datetime import datetime

from dependencies.databus.client import DatabusClient

logging.basicConfig(level=logging.INFO, format='%(asctime)s | %(levelname)s | %(filename)s | %(funcName)s |  %(message)s')

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        logging.info("Connected to MQTT broker.")
        client.subscribe("ie/test")
    else:
        logging.info("Connection to MQTT broker failed.")

def on_message(client, userdata, message):
    # logging.info(f"Message from databus topic {message.topic}: {message.payload.decode()}")
    userdata["mqttclient_obj"].on_data_callback.append(message.payload.decode())

if __name__=="__main__":
    logging.info("Main Initiated")
    data_list = []
    databusclient_obj = DatabusClient()
    databusclient_obj.set_on_connect_callback(on_connect)
    databusclient_obj.set_on_message_callback(on_message)
    databusclient_obj.on_data_callback = data_list
    databusclient_obj.authenticate()

    st.title("Real-Time Data from IEDatabus")
    x_values = []

    placeholder = st.empty()
    while True:
        time.sleep(1)
        with placeholder.container():
            if len(data_list) > 0:
                x_values.append(datetime.now().strftime("%H:%M:%S"))
                if len(x_values) > 10:
                    x_values.pop(0)
                    del data_list[0]
                logging.info(f"Data on databus: {data_list}")
                realtime_databus_chart, realtime_databus_data = st.columns([3, 1])
                realtime_databus_data.metric(
                    label="Current data",
                    value=data_list[-1]
                )

                realtime_databus_chart.subheader("Graph")
                fig = go.Figure(data=go.Scatter(x=x_values, y=data_list, mode='lines+markers', name="Triangle Wave"))
                fig.update_xaxes(title_text="Timestamp")
                fig.update_yaxes(title_text="Process Values")
                realtime_databus_chart.plotly_chart(fig)
```

## Pyproject.toml
File path - services/(service_name)/pyproject.toml

Add these dependencies in pyproject.toml
```
[tool.poetry.dependencies]
python = "3.10.13"
paho-mqtt = "1.6.1"

[tool.poetry.dev-dependencies]
black = "^22.1"
streamlit = "1.20.0"
plotly = "5.18.0"
```

## Dockerfile
File path - services/(service_name)/Dockerfile

Add this command in dockerfile to run the your application

```
CMD ["streamlit", "run", "main.py", "--server.port", "8888"]
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


