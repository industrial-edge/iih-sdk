# IIH Software Development Kit

### Welcome to the Industrial Information Hub Software Development Kit (IIH SDK).

Your Developer Companion to guide you in the complete app development lifecycle.
<br>

![Alt text](./docs/001_pages/01_home/_graphics/01_Overview.png)

The IIH SDK speeds up and enhances the entire development lifecycle of IIH apps from creation to deployment. This allows the developer to focus more on the business logic and offload the app creation, generation and deployment to SDK.

You can develop apps on your development machine/VM without the need for a physical Industrial Edge device or Industrial Edge Management. Additionally, SDK provides a data simulator to generate mock data for app testing and debugging.

This repository contains the documentation providing details of SDK, how to set up and manage the SDK and how to use the app workflows with examples. Please use the contents section below to navigate the documentation.

## Table Of Contents
- [IIH Software Development Kit](#contents)
    - [What SDK provides](#what-sdk-provides)
    - [Core Components](#core-components)
    - [Setup and Manage IIH SDK](#setup-and-manage-iih-sdk)
        - [Requirements](#requirements)
        - [Prerequisites](#prerequisites)
        - [How to Install](#how-to-install)
        - [How to Start](#how-to-start)
        - [How to Stop](#how-to-stop)
        - [How to Uninstall/Remove](#how-to-uninstallremove)
    - [IIH App Workflows](#iih-app-workflows-through-example)
        - [Create App](#create-your-app)
        - [Test App](#test-you-app)
        - [Deploy App](#deploy-your-app)
        - [Importing App to IEM](#importing-app-to-iem)
        - [Install App on IED](#install-app-on-ied)
    - [More Examples](#more-examples)
    - [SDK Versions](#sdk-versions)
    - [Community](#community)
    - [Contact us](#contact-us)
    - [Contribution](#contribution)
    - [License and Legal Information](#licence-and-legal-information)
- [IIH Mendix Integration](#iih-mendix-integration)


## What SDK Provides

The IIH SDK addresses the pain points associated with traditional development approaches. The key value added is given below.

- **Speeding up App Development:**
  The SDK accelerates app development through efficient Code Generation, allowing developers to focus on the core business logic.

- **App Artifact Generation:**
  Developers save time by leveraging automated app artifact generation, eliminating the manual effort required in configuring development environments.

- **Overhead-Free Configurations:**
  SDK mitigates the overhead of complex configurations, providing a more streamlined and developer-friendly experience.

- **Automated Deployment Builds:**
  Automation of the .app build process ensures consistency and reliability in the application packaging phase.

- **Optimizing Resource Utilization:**
  The SDK optimizes resource utilization, ensuring efficient use of computing resources during both development and execution.


## Core Components

The SDK offers 3 major capabilities that not only ease up the app development process but also make it very fast and efficient.

![Alt text](./docs/001_pages/01_home/_graphics/02_Architecture.png)

### 1. Create Your App - IIH App Code Generation
   - Faster development through code generation (templates, libraries).
   - Wraps the runtime dependencies and guides developers to add business logic in simple steps.

### 2. Test your app - Local Testing & Debugging
   - Efficient testing and debugging by emulating device services.
   - Enables automation of unit tests in the development environment.
   - Provides live metrics of dependency resource utilization.

### 3. Deploy your app - Build & Publish
   - Optimal packaging for delivery or deployment to IEM.
   - Speeds up overall development time and enhances the app development experience.

## Setup and Manage IIH SDK

The SDK is currently packaged as installable software on a Debian-based machine/VM. The installation is made very easy through a managing script. Please follow the steps below for installation.

### Requirements

Debian-based PC or VM.
    - Min. 2 core CPU
    - 8GB RAM
    - 100GB HDDz
    - No Graphic Card required
- Internet access is needed (to pull installation and base images from the docker hub)
- Chrome Browser (Tested on -: 122.0.6261.129 (Official Build) (64-bit) (cohort: Stable))

### Prerequisites
 
- Please make sure Docker is installed and the local user is added to the Docker User Group. [Instruction is provided here.](https://docs.docker.com/engine/install/linux-postinstall/#configure-where-the-docker-daemon-listens-for-connections)

- One of the services of IIH SDK connects to the daemon over 2375 port. Please make sure the 2375 port is exposed following the steps from the [docker docs](https://docs.docker.com/config/daemon/remote-access/).

- Install make using the command below.



      sudo apt install make


### How to Install
 
- Clone the [IIH SDK](https://github.com/industrial-edge/iih-sdk) repository to your system and navigate into the repo:
 
   ``` cmd
   git clone https://github.com/industrial-edge/iih-sdk.git
   ```
   ``` cmd
   cd ./iih-sdk/
   ```
 
- Provide execute permissions to the iih-sdk.sh manager-script. 
   ``` cmd
   sudo chmod +x iih-sdk.sh
   ```
 
- To install the IIH SDK run the below command.
   ``` cmd
   ./iih-sdk.sh install
   ```
You should observe images being pulled from dockerhub. If in case you observe any issues here, please check the internet access.

### How to Start


- To start the IIH SDK,  navigate into the cloned repository directory and run the below command.
   ``` cmd
   ./iih-sdk.sh start
   ```

- Please type in the URL in your Chrome browser to access the web user interface.

   ``` cmd
   http://localhost:48080
   ```

### How to Stop

- To stop the IIH SDK, navigate into the cloned repository directory and run the below command.
   ``` cmd
   ./iih-sdk.sh stop
   ```

### How to Uninstall/Remove
- To Uninstall/remove the IIH SDK,  navigate into the cloned repository directory and run the below command.
   ``` cmd
   ./iih-sdk.sh remove
   ```

## IIH App Workflows through example

An overview of the app developer journey using the IIH SDK is given below.

![Alt text](./docs/001_pages/01_home/_graphics/03_App_Developer_Journey.png)

Please click on the respective titles to know more.

### [**Create Your App**](./docs/001_pages/02_create_app/01-Create-Workflow.md)
   - Faster development through code generation (templates, libraries).
   - Wraps the runtime dependencies and guides developers to add business logic in simple steps.
   - Please click on the title to know more.

### [**Test your app**](./docs/001_pages/03_test_app/02-Test-Workflow.md)
   - Efficient testing and debugging by emulating device services.
   - Enables automation of unit tests in the development environment.
   - Provides live metrics of dependency resource utilization.
   - Please click on the title to know more.

### [**Deploy your app**](./docs/001_pages/04_deploy_app/03-Deploy-Workflow.md)
   - Optimal packaging for delivery or deployment to IEM.
   - Speeds up overall development time and enhances the app development experience.
   - Please click on the title to know more.

### [**Importing App to IEM**](https://docs.eu1.edge.siemens.cloud/get_started_and_operate/industrial_edge_management/vm/operation/catalog/importing_edge_apps.html)
   - Industrial Edge Management provides the capability to import the app created externally into the catalog.
   - Please click on the title to know more.

### [**Install App on IED**](https://docs.eu1.edge.siemens.cloud/get_started_and_operate/industrial_edge_management/vm/operation/catalog/installing_an_app_from_the_catalog.html)
   - The steps explain how the app can be installed on a Industrial Edge Device and access it.
   - Please click on the title to know more.

   ### **Voila! The app is installed and running on your IED**.

## More Examples
Please find below additional examples to learn more and build your apps easily.

### Example 1

Triangular wave using random data - provided by the Development Kit - Create an application without any service and form a **triangular** wave using **Streamlit**.<br>
Access the example [here](./docs/002_example_apps/001_Example_001/001_Example_001.md)

#### Expected Result

 ![Triangular wave ](./docs/002_example_apps/001_Example_001/_graphics/image.png)

### Example 2

Triangular wave using databus as service - provided by the Development Kit - Create an application to form a **triangular** wave using **Databus** and **flow creator** as service and get data through them. The data represented in a triangular waveform is created by using **Streamlit**. <br>
Access the example [here](./docs/002_example_apps/002_Example_002/002_Example_002.md)

#### Expected Result 

![Alt text](./docs/002_example_apps/002_Example_002/_graphics/image-10.png)


### Example 3

Triangular wave using IIH essentials - provided by the Development Kit - Create an application to form a **triangular** wave using **IIH essentials** and **IIH Simulator** as a service to get data from **PLC** and visualize that data using **Streamlit.**
<br>
Access the example [here](./docs/002_example_apps/003_Example_003/003_Example_003.md)

#### Expected Result

![Alt text](./docs/002_example_apps/003_Example_003/_graphics/IIHessentialdep.png)

## SDK Versions
<details>
  <summary style="font-weight: bold; font-size: large;">v1.0.0 | 2024-03-20</summary>
  </summary>
  <h3>Launched with the below features/capabilities</h3>
  <ul>
    <li><h4>App Generation for Python</h4>
    Developers can generate Python-based applications with ease, leveraging the power and flexibility of the Python programming language.</li>
    <li><h4>Emulation with IIH Apps </h4>
    The IIH SDK allows developers to emulate and test their applications seamlessly within the IIH Suite. Currently, the SDK supports emulation of IIH Essentials only.
    </li>
    <li><h4>Automated Packaging</h4>
    The packaging process is automated, simplifying the deployment of applications to the Industrial Edge.</li>
    <li><h4>App Workflow through example</h4></li>
</details>

## Community

Please ask IIH SDK-related general questions in the [Industrial Edge support forum](https://forum.industrial-edge.siemens.cloud/).

## Contact us

For specific support requests contact your regional contact person. They take care of your concerns and give you feedback.

## Contribution

Thank you for your interest in contributing. Anybody is free to report bugs, unclear documentation, and other problems regarding this repository in the Issues section.
Additionally, everybody is free to propose any changes to this repository using Pull Requests.

If you haven't previously signed the [Siemens Contributor License Agreement](https://cla-assistant.io/industrial-edge/) (CLA), the system will automatically prompt you to do so when you submit your Pull Request. This can be conveniently done through the CLA Assistant's online platform. Once the CLA is signed, your Pull Request will automatically be cleared and made ready for merging if all other test stages succeed.

# License and Legal Information

Please read the [Legal information](LICENSE.md) documentation.

# IIH Mendix Integration

Please Refer to the [IIH Mendix Integration](./docs/001_pages/09_iih_mendix_integration/09-IIH-mendix.md) documentation for details.
