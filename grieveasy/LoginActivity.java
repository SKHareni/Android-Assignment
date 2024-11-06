package com.example.grieveasy;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.button.MaterialButton;

public class LoginActivity extends AppCompatActivity {

    private EditText emailEditText, passwordEditText;
    private MaterialButton loginButton;
    private TextView goToRegisterText;
    private DatabaseHelper databaseHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.content_main);

        // Initialize views
        emailEditText = findViewById(R.id.email_edit_text); // Ensure this ID matches your XML
        passwordEditText = findViewById(R.id.password_edit_text); // Ensure this ID matches your XML
        loginButton = findViewById(R.id.login_button); // Ensure this ID matches your XML
        goToRegisterText = findViewById(R.id.register_text); // Ensure this ID matches your XML

        // Initialize database helper
        databaseHelper = new DatabaseHelper(this);

        // Set onClickListener for the login button
        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String email = emailEditText.getText().toString().trim();
                String password = passwordEditText.getText().toString().trim();

                // Validate input fields
                if (email.isEmpty() || password.isEmpty()) {
                    Toast.makeText(LoginActivity.this, "Please enter both email and password", Toast.LENGTH_SHORT).show();
                } else if (!android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
                    Toast.makeText(LoginActivity.this, "Please enter a valid email", Toast.LENGTH_SHORT).show();
                } else {
                    boolean isUserValid = databaseHelper.validateUser(email, password);
                    if (isUserValid) {
                        Toast.makeText(LoginActivity.this, "Login successful", Toast.LENGTH_SHORT).show();

                        // Navigate to the grid screen
                        Intent intent = new Intent(LoginActivity.this, GridActivity.class);
                        startActivity(intent);
                        finish(); // Close the login activity
                    } else {
                        Toast.makeText(LoginActivity.this, "Invalid email or password", Toast.LENGTH_SHORT).show();
                    }
                }
            }
        });

        // Set onClickListener for the "Go to Register" text
        goToRegisterText.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Navigate to registration screen
                Intent intent = new Intent(LoginActivity.this, RegistrationActivity.class);
                startActivity(intent);
                finish(); // Close the login activity
            }
        });
    }
}
