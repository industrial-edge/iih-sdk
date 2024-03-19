# Test Workflow

The Test Workflow in the IIH Copilot Software Development Kit (SDK) focuses on efficient testing and debugging by emulating device services. This feature allows for the automation of unit tests in the development environment, ensuring faster testing and providing live metrics of dependency resource utilization. With this workflow, developers can streamline the testing and debugging process without the need to deploy and install the application on the Industrial Edge every time for testing.

## Service Overview

### Core Services
1. **IIH Essentials:**
   - Provides a user interface (UI).
   - Repository: [IIH Essentials Development Kit](https://github.com/industrial-edge/iih-essentials-development-kit-getting-started)
   - User manual: [Documenttion](https://support.industry.siemens.com/cs/document/109823792/iih-essentials-for-industrial-edge?dti=0&lc=en-WW)

### Platform Services
1. **Common Configurator:**
   - Provides a user interface (UI).
   - User manual: [Documentation](
https://support.industry.siemens.com/cs/document/109803582/iih-configurator-for-industrial-edge?dti=0&lc=en-WW)
2. **IIH Semantics:**
   - Repository: [IIH Semantics Getting Started](https://github.com/industrial-edge/iih-semantics-getting-started)
    - User manual: [Documenttion](https://support.industry.siemens.com/cs/document/109823792/iih-essentials-for-industrial-edge?dti=0&lc=en-WW)
3. **IIH Databus Gateway:** 
4. **IIH Registry Service:**
5. **Databus:**
    - User manual: [Databus](
https://support.industry.siemens.com/cs/document/109821528/databus-v2-2-0?dti=0&lc=en-WW)

### Application Services
1. **IIH Essentials Simulator:**
   - Provides a user interface (UI).
2. **Flow Creator:**
   - Provides a user interface (UI).

![Alt text](../assets/Workflows/02-Test-Workflow/image.png)
![Alt text](../assets/Workflows/02-Test-Workflow/image-1.png)

## Workflow Page

### Test Your Application

The Test Workflow page is designed with the following features:

- **Services Tiles:**
  - IIH Essentials (UI), Common Configurator (UI), IIH Semantics, IIH Databus Gateway, IIH Registry Service, Databus, IIH Essentials Simulator, Flow Creator (UI).
  
- **Buttons:**
  - **Start All Services:**
    - Starts all services at once.
  - **Stop All Services:**
    - Stops all services at once. If no service is running, only the Start button will be active. If any single service is running, the Stop button will be activated. 

- **Individual Start Button:**
  - Each service tile has an individual Start button to start a particular service.

- **Resource Metrics:**
  - Memory usage and CPU usage are displayed in the service tiles.

This user-friendly interface provides developers with the flexibility to control and monitor services efficiently during the testing phase.
