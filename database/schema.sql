CREATE DATABASE IF NOT EXISTS loanwise_db;

USE loanwise_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'user',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS loan_applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,

    Gender VARCHAR(20),
    Married VARCHAR(10),
    Dependents VARCHAR(10),
    Education VARCHAR(30),
    Self_Employed VARCHAR(10),

    ApplicantIncome DECIMAL(15,2),
    CoapplicantIncome DECIMAL(15,2),
    LoanAmount DECIMAL(15,2),
    Loan_Amount_Term DECIMAL(15,2),

    Credit_History TINYINT,
    Property_Area VARCHAR(30),

    prediction VARCHAR(10),
    prediction_explanation TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_loan_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);
