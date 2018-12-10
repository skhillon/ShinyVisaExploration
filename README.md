## Group members:
- Christina Walden
- Sarthak Khillon
- Juan Moreno

## Important Files
- [`Report`](Final_Project_Report.html): Final project report.
- [`misc/`](misc): Experimental scripts, notes, testing, etc.
- [`phase2/`](phase2): All code for the phase 2 submission.

### Supplementary Scripts
Some of these generate intermediate `.RData` files which are loaded in other scripts
- [`generate_env.R`](generate_env.R)
- [`visa_and_models.R`](visa_and_models.R)

### Shiny App
- [`global.R`](global.R): Shared variables, libraries, and functionality.
- [`server.R`](server.R): Data processing.
- [`ui.R`](ui.R): User Interface design.
- [`DESCRIPTION`](DESCRIPTION): App configuration settings.


## Data:
- Link: https://www.kaggle.com/gpreda/h-1b-visa-applications
- Description: Contains 5 years of people’s applications for a work-based non-immigrant visa.

There are 3,002,458 observations.

### Columns:
- `X : int` - Row number
- `CASE_STATUS: chr` - Describes the status of the application after processing
- `EMPLOYER_NAME: chr` - Name of the employer submitting labor condition application
- `SOC_NAME: chr` - Occupational name associated with the SOC_CODE. SOC_CODE is a classification code assigned by the Standard Occupational Classification (SOC) System.
- `JOB_TITLE: chr` - Title of the job
- `FULL_TIME_POSITION: chr` - “Y” = Full Time Position, “N” = Part Time Position
- `PREVAILING_WAGE: num` - Average wage paid to similarly employed workers in the requested occupation in the area of intended employment
- `YEAR: int` - Year in which the H-1B visa petition was filed
- `WORKSITE: chr` - City where the worker intends to be employed
- `lon: num` - Longitude. Missing is coded as ‘NA’
- `lat: num` - Latitude. Missing is coded as ‘NA’
