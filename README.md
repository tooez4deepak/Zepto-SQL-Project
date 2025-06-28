# Zepto-SQL-Project

Welcome to the Zepto SQL Project, a structured approach to managing, transforming, and troubleshooting large volumes of data using SQL Server. This repository showcases my journey through effective schema design, bulk data handling, and resilient SQL techniques tailored for complex, real-world datasets.

🚀 Project Goals
- Design scalable, maintainable SQL Server schemas.
- Load bulk data efficiently while minimizing errors.
- Cleanse and transform messy CSV/Excel data using SQL techniques.
- Identify and resolve data import issues such as type mismatches, nullability conflicts, and encoding issues.
- Document every step with clear, structured SQL comments for maintainability and team understanding.
  
🔧 Features Implemented So Far
- ✅ Table Creation: Designed normalized SQL Server tables to reflect Zepto’s dataset needs.
- ✅ Bulk Insert Processes: Leveraged BULK INSERT to load large CSV files, handling delimiters and file format nuances.
- ✅ Error Handling and Troubleshooting: Diagnosed data type mismatches using TRY_CAST, REPLACE, and column trimming strategies.
- ✅ File Format Flexibility: Experimented with varied delimiters and encoding options for maximum compatibility.
- ✅ Commented SQL Queries: Focused on maintainable, well-documented queries that explain logic and assumptions at each step.
- ✅ Visual Identity: Created a custom database icon set (with DB lettering) in various colors for use in documentation and UI concepts.

🛠 Tools & Techniques
- SQL Server 2019+
- TRY_CAST, REPLACE, LTRIM, RTRIM, ISNUMERIC
- BULK INSERT, FORMATFILE, ERRORFILE
- Data visualization with custom-generated icons for clarity and branding
  
📌 Next Steps
- Automate validation scripts for pre-insert quality checks
- Incorporate stored procedures for dynamic error resolution
- Create a dashboard to visualize loaded data and detect anomalies
- Polish GitHub Wiki for deeper documentation
