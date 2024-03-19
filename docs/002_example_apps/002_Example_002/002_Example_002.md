### Example 2 - Triangular wave using Databus Service

Triangular wave using databus as service - provided by the Development Kit - Create an application to form a **triangular** wave using **Databus** and **flow creator** as service and get data through them. The data represented in a triangular wave form is created by using **streamlit**.

1. [Create your application](../Workflows/01-Create-Workflow.md) - Enter the name and description of your application. Add service and select Databus from the dropdown. Proceed to app summary and review it.
2. Download your application - After reviewing the application, start generating the source code. Once the downlaod is complete you can extract the zip file in your desired location adn open it in VS Code.
3. [Start services for application](../Workflows/02-Test-Workflow.md) - Go to test workflow and start databus service and [flow creator app](http://localhost:1880/). Redirect to flow creator using the button and create the flow to receive timestamp. 
![Alt text](../assets/Examples/02-Example/image-5.png)
   - Screen should look like this when you open flow creator
   ![Alt text](<../assets/Examples/02-Example/databus app flow 1.PNG>)

   - Add timestamp, mqtt-in, mqtt-out, a function and debug.
   ![Alt text](../assets/Examples/02-Example/image-7.png)

   - Configuring the timestamp and set the interval to 1 sec.
   ![Alt text](<../assets/Examples/02-Example/databus app flow 3.PNG>)

   - Configure the function 
   ![Alt text](../assets/Examples/02-Example/image-8.png)
      Code Snippet - 

      ```
      var counter = flow.get("counter")||0;
      if (msg.topic =="timestamp"){
         counter = counter +0.1;
         if (counter>0.5){
            counter - 0;
         }
         flow.set("counter", counter);
      }
      var newMsg = {payload: Math.round(counter*10)/10}
      return newMsg
      ```

   - Edit the mqtt-broker node
   ![Alt text](<../assets/Examples/02-Example/databus app flow 4.PNG>)

   - Provide the credentials -  <br>
   `username - edge` <br>
                 `Password - edge`
   ![Alt text](<../assets/Examples/02-Example/databus app flow 5.PNG>)

   - Deploy and you should see the timestamp in debug pane.
   ![Alt text](../assets/Examples/02-Example/image-9.png)



3. Business Logic - Add business logic to your application to generate a triangular wave using timestamp data received from the databus and flow creator. Please note that example source code for implementing this functionality is provided. Ensure to incorporate the provided example code into your application. You can find the source code for this example [here](../source-code/02-Example.md)
4. Build the image - Building the image can be done by command

```
make servicename_build
```
5. Run your application to test if it works as expected - Start the docker compose to check if the application is running on the desired port.
You must be in the same path where the docker compose yml file is placed.

```
docker compose up
```

#### Expected Result 

![Alt text](../assets/Examples/02-Example/image-10.png)

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


