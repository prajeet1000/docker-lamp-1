<?php 
$servername = "database-1.cluster-chu2hpbhxioh.ap-northeast-1.rds.amazonaws.com";
  $username = "admin";
  $password = "prajeet123";
  $dbname = "database1";
  
  $conn = new mysqli($servername, $username, $password,$dbname);
  
  
  
  
  $sql = "CREATE TABLE MyGuests (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
gender VARCHAR(30) NOT NULL,
comment VARCHAR(255) NOT NULL,
reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)";
if ($conn->query($sql) === TRUE) {
  echo "Table MyGuests created successfully";
} else {
  echo "Error creating table: " . $conn->error;
}

$conn->close();
