package com.example.grieveasy;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.button.MaterialButton;

public class RegistrationActivity extends AppCompatActivity {

    private EditText editTextEmail, editTextRegId, editTextContact, editTextPassword;
    private MaterialButton registerButton;
    private TextView alreadyHaveAccountText;
    private DatabaseHelper databaseHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.registration);

        // Initialize views
        editTextEmail = findViewById(R.id.editTextEmail);
        editTextRegId = findViewById(R.id.editTextRegId);
        editTextContact = findViewById(R.id.editTextContact);
        editTextPassword = findViewById(R.id.editTextPassword);
        registerButton = findViewById(R.id.registerButton);
        alreadyHaveAccountText = findViewById(R.id.login_text);

        // Initialize database helper
        databaseHelper = new DatabaseHelper(this);

        // Set onClickListener for the register button
        registerButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String email = editTextEmail.getText().toString().trim();
                String regId = editTextRegId.getText().toString().trim();
                String contact = editTextContact.getText().toString().trim();
                String password = editTextPassword.getText().toString().trim();

                // Validate input fields
                if (email.isEmpty() || regId.isEmpty() || contact.isEmpty() || password.isEmpty()) {
                    Toast.makeText(RegistrationActivity.this, "Please fill all fields", Toast.LENGTH_SHORT).show();
                } else {
                    boolean isInserted = databaseHelper.insertUser(email, regId, contact, password);
                    if (isInserted) {
                        Toast.makeText(RegistrationActivity.this, "Registration successful", Toast.LENGTH_SHORT).show();

                        // Navigate to login screen after registration
                        Intent intent = new Intent(RegistrationActivity.this, LoginActivity.class);
                        startActivity(intent);
                        finish(); // Close the registration activity
                    } else {
                        Toast.makeText(RegistrationActivity.this, "Registration failed: Email might already be in use", Toast.LENGTH_SHORT).show();
                    }
                }
            }
        });

        // Set onClickListener for the "Already have an account?" text
        alreadyHaveAccountText.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Navigate to login screen
                Intent intent = new Intent(RegistrationActivity.this, LoginActivity.class);
                startActivity(intent);
                finish(); // Close the registration activity
            }
        });
    }
}
