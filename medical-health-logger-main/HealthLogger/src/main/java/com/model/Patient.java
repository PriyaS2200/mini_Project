package com.model;

public class Patient {
	
	private int id;
    private String name;
    private String email;
    private String phone;
    private int age;
    private String diagnosis;
    private String remark;
    private String gender;
 
    // Constructor
    public Patient(int id, String name, String email, String phone, int age, String diagnosis, String remark, String gender) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.age = age;
        this.diagnosis = diagnosis;
        this.remark = remark;
        this.gender = gender;
    }
 
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

}
