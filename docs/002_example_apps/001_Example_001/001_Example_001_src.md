## Main.py
File path - services/(service_name)/src/main.py
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
File path - services/(service_name)/pyproject.toml

```
[tool.poetry.dependencies]
python = "3.10.13"
paho-mqtt = "1.6.1"

[tool.poetry.dev-dependencies]
streamlit = "1.20.0"
plotly = "5.18.0"
```

## Dockerfile
File path - services/(service_name)/Dockerfile
```
CMD ["streamlit", "run", "main.py", "--server.port", "8887"]
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




