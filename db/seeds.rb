User.create!([
               {email: 'hr@yopmail.com', first_name: "Hr", password: 12345678, dob: "01-01-1990", role: "hr"},
               {email: 'superadmin@yopmail.com', first_name: "Super", last_name: "Admin", password: 12345678, dob: "01-01-1990", role: "super_admin"},
               {email: 'manager@yopmail.com', first_name: "Manager", password: 12345678, dob: "01-01-1990", role: "manager"},
               {email: 'employee@yopmail.com', first_name: "Employee", password: 12345678, dob: "28-04-1998", role: "employee"}
             ])

Project.create!([{name: "Project 1"}, {name: "Project 2"}, {name: "Project 3"}])

# ------------------ Create Node --------------------------
# Dashboard Node
Node.create!(name: "Dashboard", controller: "dashboard", action: "index", icon: "fas fa-desktop", position: 1)
# Attendance Report Node
attendance_node = Node.create!(name: "Attendance", action: "", controller: "attendance", icon: "fa fa-address-card", position: 2)
Node.create!(name: "Attendance Report", action: "user_attendance_list", controller: "attendance", icon: "fa fa-address-card", position: 1, parent_id: attendance_node.id)
Node.create!(name: "Today Attendance", action: "today_attendance_list", controller: "attendance", icon: "fa fa-address-card", position: 2, parent_id: attendance_node.id)

# DSR Node
dsr_node = Node.create!(name: "DSR", controller: "dsr", action: "", icon: "far fa-list-alt", position: 3)
Node.create!(name: "Add New", controller: "dsr", action: "add_dsr", icon: "fas fa-plus", position: 1, parent_id: dsr_node.id)
Node.create!(name: "Send DSR", controller: "dsr", action: "send_dsr", icon: "fas fa-paper-plane", position: 2, parent_id: dsr_node.id)
Node.create!(name: "Received DSR", controller: "dsr", action: "received_dsr", icon: "fas fa-database",position: 3, parent_id: dsr_node.id)

# Weekly Report Node
report_node = Node.create!(name: "Weekly Report", controller: "report", action: "", icon: "fas fa-file-alt", position: 4)
Node.create!(name: "Add New", controller: "report", action: "add_report", icon: "fas fa-plus", position: 1, parent_id: report_node.id)
Node.create!(name: "Send Report", controller: "report", action: "send_report", icon: "fas fa-paper-plane", position: 2, parent_id: report_node.id)
Node.create!(name: "Received Report", controller: "report", action: "received_report", icon: "fas fa-database",position: 3, parent_id: report_node.id)

# Employees Node
Node.create!(name: "Employees", action: "index", controller: "employees", icon: "fas fa-users", position: 6)
# ------------------ Create Node --------------------------
