package com.example.grieveasy;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class DatabaseHelper extends SQLiteOpenHelper {

    private static final String DATABASE_NAME = "GrieveEasy.db";
    private static final String TABLE_NAME = "users";
    private static final String COL_1 = "ID";
    private static final String COL_2 = "EMAIL";
    private static final String COL_3 = "REGISTRATION_ID";
    private static final String COL_4 = "CONTACT";
    private static final String COL_5 = "PASSWORD";

    public DatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // Create the users table
        db.execSQL("CREATE TABLE " + TABLE_NAME + " (ID INTEGER PRIMARY KEY AUTOINCREMENT, EMAIL TEXT UNIQUE, REGISTRATION_ID TEXT, CONTACT TEXT, PASSWORD TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        onCreate(db);
    }

    // Insert user into database
    public boolean insertUser(String email, String regId, String contact, String password) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_2, email);
        contentValues.put(COL_3, regId);
        contentValues.put(COL_4, contact);
        contentValues.put(COL_5, password);

        long result = db.insert(TABLE_NAME, null, contentValues);
        return result != -1;  // Returns true if insertion is successful
    }

    // Validate user credentials
    public boolean validateUser(String email, String password) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = null;
        try {
            cursor = db.rawQuery("SELECT * FROM " + TABLE_NAME + " WHERE " + COL_2 + " = ? AND " + COL_5 + " = ?", new String[]{email, password});
            return cursor.getCount() > 0; // User exists in the database
        } catch (Exception e) {
            Log.e("DatabaseHelper", "Error validating user: " + e.getMessage());
            return false; // Validation failed due to an error
        } finally {
            if (cursor != null) {
                cursor.close(); // Ensure cursor is closed to prevent memory leaks
            }
        }
    }
}
