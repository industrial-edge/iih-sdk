### Example 1 - Triangular Wave using Random Data

Triangular wave using random data - provided by the Development Kit - Create an application without any service and form a **triangular** wave using **streamlit**.

1. Create your application - Enter the name and description of your application. No service is needed in this example. Add service name and move to summary page for reviewing all the details.

![Alt text](../assets/Examples/01-Example/image-1.png)

![Alt text](../assets/Examples/01-Example/image-2.png)

![Alt text](../assets/Examples/01-Example/image-3.png)

2. Download your application - After reviewing it carefully start generating the source code. A zip file will be downloaded. Unzip it and open in VS code.

3. Business Logic - Add business logic to your application for generating triangular wave using random data.
You can find the source code for this example [here](../source-code/01-Example.md)

4. Build the Image - Once the code is ready, build the image. Building the image can be done by command

```
make servicename_build
```
5. Run your application to test if it works as expected or not - Start the docker compose to check if the application is running on the desired port. You must be in the same path where the docker compose yml file is placed.

```
docker compose up
```

#### Expected Result 

 ![Triangular wave ](../assets/Examples/01-Example/image.png)


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


