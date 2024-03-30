## Product Management System
This project is a comprehensive Windows Form application developed using C# language and .NET Framework 4.7.2. It serves as a management system for handling products. The project adheres to the Repository Pattern to ensure a structured and maintainable codebase. Additionally, Crystal Reports are utilized for generating and displaying reports related to product data.

## Description
The Product Management System is designed to streamline the process of managing product information within a business or organization. It provides functionalities to perform various operations related to products, such as adding new products, updating existing ones, deleting outdated entries, and generating reports to analyze product data.

## Key Features
Product CRUD Operations: Perform Create, Read, Update, and Delete operations on product data.
Repository Pattern: Ensures a clear separation of concerns and maintainability of codebase.
Crystal Reports Integration: Utilize Crystal Reports for generating detailed and insightful reports on product information.
Database Connectivity: Seamless integration with a SQL Server database for storing and retrieving product data.
User-Friendly Interface: Intuitive and easy-to-navigate Windows Form interface for effortless usage.

## Prerequisites

To run this project, you'll need the following:

* **Microsoft Visual Studio:** Download and install a compatible version of Visual Studio (https://visualstudio.microsoft.com/downloads/).
* **.NET Framework 4.7.2:** Ensure you have .NET Framework 4.7.2 or a later version installed on your system (https://dotnet.microsoft.com/download/dotnet-framework).
* **Crystal Reports :** If you intend to utilize Crystal Reports for report generation, download and install the appropriate version compatible with your development environment (https://scn.sap.com/en/community/crystal-reports).

## Database Setup

1. **Generate Database:**
   - Locate the `SampleStoreDB_ForWindowsFormsql.sql` file within the `DatabaseScript` folder.
   - Open SQL Server Management Studio (SSMS). Connect to your desired SQL Server instance.
   - Execute the `SampleStoreDB_ForWindowsFormsql.sql` script in SSMS to create the database schema.

2. **Update Connection String:**
   - Open the `App.config` file within the project directory.
   - Locate the connection string section (`<connectionStrings>`) and modify the connection details (server name, database name, user ID, and password) according to your database configuration.

## Usage Instructions

1. **Download or Clone Repository:** Download or clone this repository from GitHub.
2. **Open Project in Visual Studio:** Open the solution file (`.sln`) in Visual Studio.
3. **Build and Run:** Build the project and run the executable to launch the application.
