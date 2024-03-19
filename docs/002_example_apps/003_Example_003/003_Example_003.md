## Example 3 - Triangular wave using IIH Essentials

Triangular wave using IIH essentials - provided by the Development Kit - Create an application to form a **triangular** wave using **IIH essentials** and **IIH Simulator** as service to get data from **PLC** and visualize that data using **streamlit.**

1. Create your application - Enter the name and description of your application. Add service and select IIH Essentials from the dropdown. Proceed to app summary and review it.
2. Download your application - After reviewing the application, start generating the source code. Once the downlaod is complete you can extract the zip file in your desired location adn open it in VS Code.
3. Start services for application - Go to test workflow and start IIH Essentials and IIH Simultion.
4. PLC Configuration - Configure the PLC to send the data to IIH Essentials which can then send data to the application.
5. Create new Tag in Simulation UI.
To create a tag, follow these steps:
    - Open a browser.
    - To access the Simulation UI, enter the following address: `http://localhost:4519`
    - Add a simulation group with following configuration and create it
        - Period: 1 minute
        - Cycle: 1 second

  ![Alt text](../assets/Examples/03-Example/image.png)

  ![Alt text](../assets/Examples/03-Example/image-1.png)


6. Add a new simulation variable to the created group
   - set the name to "Sinus"
   - type should be "Int"
   - add a simulation with following configuration
     - choose "sinus"
     - Period: 1 minute
     - Amplitude: 20
     - Zeropoint: 0
     - click on "Save"
   - click on "Create"

  ![Alt text](../assets/Examples/03-Example/image-2.png)

  ![Alt text](../assets/Examples/03-Example/image-3.png)

  ![Alt text](../assets/Examples/03-Example/image-4.png)

6. Transfer Tag to IIH Essentials

To connect the tag to the IIH Essentials, follow these steps:

1. Open a browser.
2. To access the IIH Essentials UI, enter the following address: `http://localhost:4203`
3. Go to connectors and configure the connector to get the data from the simulation

  ![Alt text](../assets/Examples/03-Example/image-5.png)

  ![Alt text](../assets/Examples/03-Example/image-6.png)

If configured correctly, it should look like this:

  ![Alt text](../assets/Examples/03-Example/image-7.png)
4. Create a new asset with following configuration and add it
    - Name: Example Asset

  ![Alt text](../assets/Examples/03-Example/image-8.png)

5. Create a Variable with following configuration and add it
   - Connector: Simulation Connector
   - Choose the created Tag "New Simulation Group/Sinus"

  ![Alt text](../assets/Examples/03-Example/image-9.png)

  ![Alt text](../assets/Examples/03-Example/image-10.png)

If the simulation variable has been successfully connected to the IIH Essentials, you can see the current value of the variable.

  ![Alt text](../assets/Examples/03-Example/image-11.png)

3. Business Logic - Add business logic to your application to generate a triangular wave using data received from IIH Essentials and IIH simulation. Please note that example source code for implementing this functionality is provided. Ensure to incorporate the provided example code into your application.  You can find the source code for this example [here](../source-code/03-Example.md)

4. Build the image - Building the image can be done by command

```
make servicename_build
```
5. Run your application to test if it works as expected - Start the docker compose to check if the application is running on the desired port.You must be in the same path where the docker compose yml file is placed.

```
docker compose up
```

#### Expected Result

![Alt text](../assets/IIHessentialdep.png)

After successfull completion. You can expose the port in docker compose yml to build and publish the application in IEM. 

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


