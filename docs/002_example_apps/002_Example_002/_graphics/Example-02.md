### Example 2 - Triangular wave using Databus Service

Triangular wave using databus as service - provided by the Development Kit - Create an application to form a **triangular** wave using **Databus** and **flow creator** as service and get data through them. The data represented in a triangular wave form is created by using **streamlit**.

1. Create your application - Enter the name and description of your application. Add service and select Databus from the dropdown. Proceed to app summary and review it.
2. Download your application - After reviewing the application, start generating the source code.
3. Start services for application - Go to test workflow and start databus service and flow creator app. Go to flow creator and create the flow to receive timestamp. 
![Alt text](../assets/image-5.png)
   - Screen should look like this when you open flow creator
   ![Alt text](<../assets/databus app flow 1.PNG>)

   - Add timestamp, mqtt-in, mqtt-out, a function and debug.
   ![Alt text](../assets/image-7.png)

   - Configuring the timestamp
   ![Alt text](<../assets/databus app flow 3.PNG>)

   - Configure the function
   ![Alt text](../assets/image-8.png)

   - Edit the mqtt-broker node
   ![Alt text](<../assets/databus app flow 4.PNG>)

   - Provide the credentials -  <br>
   `username - edge` <br>
                 `Password - edge`
   ![Alt text](<../assets/databus app flow 5.PNG>)

   - Deploy and you should see the timestamp in debug pane.
   ![Alt text](../assets/image-9.png)



3. Business Logic - Add business logic to your application for generating triangular wave using timestamp data received from databus and flow creator. You can find the source code for this example [here](../source-code/Triangular-wave-02-databusdependency)
4. Build the image - Building the image can be done by command

```
make servicename_build
```
5. Run your application to test if it works as expected - Start the docker compose to check if the application is running on the desired port

#### Expected Result 

![Alt text](../assets/image-10.png)

