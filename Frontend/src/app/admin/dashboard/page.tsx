"use client";

import { useState, useEffect, useRef } from "react";

export default function AdminDashboard() {
  const [users, setUsers] = useState<any[]>([]);
  const [search, setSearch] = useState("");

  const [showModal, setShowModal] = useState(false);
  const [selectedUser, setSelectedUser] = useState<any | null>(null);

  const [showFilter, setShowFilter] = useState(false);
  const [filterRole, setFilterRole] = useState("all");

  const filterRef = useRef<HTMLDivElement>(null);

  const [hasSubmitted, setHasSubmitted] = useState(false);
    
  const [deleteSuccess, setDeleteSuccess] = useState(false);

  const [editMode, setEditMode] = useState(false);
  const [editData, setEditData] = useState<any>(null);



  const [formData, setFormData] = useState({
    first_name: "",
    last_name: "",
    email: "",
    school_id: "",
    password: "",
    confirm_password: "",
    role: "client",
  });

  const [errors, setErrors] = useState<any>({});
  const [serverError, setServerError] = useState("");

  // ================= CLICK OUTSIDE FILTER =================
  useEffect(() => {
    const handleClickOutside = (event: any) => {
      if (filterRef.current && !filterRef.current.contains(event.target)) {
        setShowFilter(false);
      }
    };

    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, []);

  // ================= FETCH USERS =================
  const fetchUsers = async () => {
    try {
      const res = await fetch("http://127.0.0.1:8000/api/admin/users", {
        method: "GET",
        headers: { Accept: "application/json" },
      });

      const data = await res.json();

      if (res.ok) {
        setUsers(data.users || data);
      }
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  // ================= FILTER + SEARCH =================
  const filteredUsers = users
    .filter((u) => (filterRole === "all" ? true : u.role === filterRole))
    .filter((u) =>
      `${u.first_name} ${u.last_name} ${u.email}`
        .toLowerCase()
        .includes(search.toLowerCase())
    );

  // ================= INPUT =================
  const handleChange = (e: any) => {
    const { name, value } = e.target;

    setFormData((prev) => ({ ...prev, [name]: value }));
    setErrors((prev: any) => ({ ...prev, [name]: "" }));
    setServerError("");
  };

  // ================= VALIDATE =================
  const validate = () => {
    const newErrors: any = {};

    if (!formData.first_name)
      newErrors.first_name = "First Name is required";
    if (!formData.last_name)
      newErrors.last_name = "Last Name is required";
    if (!formData.email) newErrors.email = "Email is required";
    if (!formData.school_id)
      newErrors.school_id = "School ID is required";
    if (!formData.password)
      newErrors.password = "Password is required";
    if (!formData.role) newErrors.role = "Role is required";
    if (formData.password !== formData.confirm_password)
      newErrors.confirm_password = "Passwords do not match";

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  // ================= CREATE =================
  const handleSubmit = async (e: any) => {
    e.preventDefault();

    setHasSubmitted(true);

    if (!validate()) return;

    try {
      const res = await fetch("http://127.0.0.1:8000/api/admin/users", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
        },
        body: JSON.stringify(formData),
      });

      if (res.ok) {
        setFormData({
          first_name: "",
          last_name: "",
          email: "",
          school_id: "",
          password: "",
          confirm_password: "",
          role: "",
        });

        setErrors({});
        setServerError("");
        fetchUsers();
        setShowModal(false);
      } else {
        const data = await res.json();

        // ✅ CASE 1: Laravel validation errors (BEST CASE)
        if (data.errors) {
          const formattedErrors: any = {};

          Object.keys(data.errors).forEach((key) => {
            formattedErrors[key] = Array.isArray(data.errors[key])
              ? data.errors[key][0]
              : data.errors[key];
          });

          setErrors(formattedErrors);
          setServerError(""); // IMPORTANT: prevent top message
        }

        // ❌ CASE 2: fallback message (DO NOT SHOW TOP ONLY)
        else {
          setServerError(data.message || "Error creating user");
        }
      }
    } catch {
      setServerError("Server error");
    }
  };

    const handleEditChange = (e: any) => {
    const { name, value } = e.target;

    setEditData((prev: any) => ({
      ...prev,
      [name]: value,
    }));
  };

    const handleEditSubmit = async (e: any) => {
      e.preventDefault();

      try {
        const res = await fetch(
          `http://127.0.0.1:8000/api/admin/users/${editData.id}`,
          {
            method: "PUT",
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
            body: JSON.stringify(editData),
          }
        );

        const data = await res.json();

        if (res.ok) {
          setEditMode(false);
          setSelectedUser(null);
          fetchUsers();
        } else {
          alert(data.message || "Failed to update user");
        }
      } catch {
        alert("Server error");
      }
    };

  useEffect(() => {
    const token = localStorage.getItem("admin_token");
    console.log("TOKEN:", token);

    if (!token) {
      window.location.replace("/admin/login");
    }
  }, []);

  return (
    <div className="relative min-h-screen bg-chat-gradient p-6">

      {/* HEADER */}
      <div className="bg-white/30 backdrop-blur-md rounded-xl p-4 mb-6 text-center text-2xl font-bold">
        Admin Dashboard
      </div>

      {/* TOP BAR */}
      <div className="flex justify-between items-center mb-4 relative z-10">

        {/* SEARCH + FILTER */}
        <div className="flex items-center gap-2 w-1/2 relative">

          <div className="relative w-full">
            <span className="absolute left-3 top-2.5">🔍</span>
            <input
              type="text"
              placeholder="Search users..."
              className="w-full pl-10 p-2 border rounded text-black"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
            />
          </div>

          {/* FILTER */}
          <div className="relative" ref={filterRef}>
            <button
              onClick={() => setShowFilter((prev) => !prev)}
              className="bg-gray-700 text-white px-4 py-2 rounded"
            >
              Filter
            </button>

            {showFilter && (
              <div className="absolute right-0 bg-white shadow rounded mt-2 w-40 z-20 text-black">
                {[
                  { value: "all", label: "All" },
                  { value: "client", label: "Client" },
                  { value: "admin", label: "Admin" },
                ].map((item) => (
                  <button
                    key={item.value}
                    className="block w-full px-4 py-2 hover:bg-gray-100 text-left"
                    onClick={() => {
                      setFilterRole(item.value);
                      setShowFilter(false);
                    }}
                  >
                    {item.label}
                  </button>
                ))}
              </div>
            )}
          </div>

        </div>

        {/* CREATE BUTTON */}
        <button
          onClick={() => {
            setShowFilter(false); // 🔥 fix overlap
            setShowModal(true);
          }}
          className="bg-black text-white px-4 py-2 rounded relative z-10"
        >
          Create
        </button>
      </div>

      {/* USERS */}
      <div className="bg-white/20 rounded p-4 min-h-[400px] relative z-0">
        {filteredUsers.length === 0 ? (
          <div className="flex justify-center items-center h-[400px] text-black">
            No accounts available yet.
          </div>
        ) : (
          <div className="space-y-2 max-h-[400px] overflow-y-auto">
            {filteredUsers.map((user, i) => (
              <div
                key={i}
                onClick={() => setSelectedUser(user)}
                className="p-3 bg-white rounded shadow cursor-pointer flex justify-between items-center hover:bg-gray-100"
              >
                <div>
                  {user.first_name} {user.last_name} - {user.email}
                </div>

                <div
                  className={`w-6 h-6 rounded-full flex items-center justify-center text-white ${
                    user.role === "admin"
                      ? "bg-yellow-500"
                      : "bg-blue-500"
                  }`}
                >
                  {user.role === "admin" ? "★" : "🎓"}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* USER DETAILS */}
      {selectedUser && (
        <div className="fixed inset-0 bg-black/60 flex justify-center items-center z-40">
          <div className="bg-white p-8 rounded-xl w-full max-w-lg relative">
            <button
              onClick={() => setSelectedUser(null)}
              className="absolute top-2 right-3 text-black"
            >
              ✕
            </button>

            <h2 className="text-xl font-bold mb-4 text-black">User Details</h2>

            <div className="text-black">
              <p><b>Name:</b> {selectedUser.first_name} {selectedUser.last_name}</p>
              <p><b>Email:</b> {selectedUser.email}</p>
              <p><b>School ID:</b> {selectedUser.school_id}</p>
              <p><b>Role:</b> {selectedUser.role}</p>
              <p><b>Password:</b> ••••••••</p>
            </div>

            {/* ACTION BUTTONS */}
            <div className="mt-6 flex gap-3">

              {/* EDIT BUTTON */}
              <button
                onClick={() => {
                  setEditData(selectedUser);
                  setEditMode(true);
                }}
                className="flex-1 bg-blue-600 text-white px-4 py-2 rounded"
              >
                Edit
              </button>

              {/* DELETE BUTTON */}
              <button
                onClick={async () => {
                const confirmDelete = confirm(
                  `Delete ${selectedUser.first_name} ${selectedUser.last_name}?`
                );

                if (!confirmDelete) return;

                try {
                  const res = await fetch(
                    `http://127.0.0.1:8000/api/admin/users/${selectedUser.id}`,
                    {
                      method: "DELETE",
                      headers: {
                        Accept: "application/json",
                      },
                    }
                  );

                  if (res.ok) {
                    setDeleteSuccess(true); // ✅ show success popup

                    // wait then close everything
                      setTimeout(() => {
                      setDeleteSuccess(false);
                      setSelectedUser(null);
                      fetchUsers();
                    }, 1500);
                  } else {
                    alert("Failed to delete user");
                  }
                } catch {
                  alert("Server error");
                }
              }}
                className="flex-1 bg-red-600 text-white px-4 py-2 rounded"
              >
                Delete
              </button>

            </div>
          </div>
        </div>
      )}

      {deleteSuccess && (
        <div className="fixed inset-0 flex items-center justify-center bg-black/60 z-50">
          <div className="bg-white px-8 py-6 rounded-xl shadow-lg text-center">
            <h2 className="text-xl font-bold text-green-600">
              Deleted Successfully
            </h2>
            <p className="text-sm text-gray-600 mt-2">
              Returning to dashboard...
            </p>
          </div>
        </div>
      )}

      {/* CREATE ACCOUNT MODAL */}
      {showModal && (
        <div className="fixed inset-0 bg-black/60 flex justify-center items-center z-50">
          <div className="bg-white p-12 rounded-xl w-full max-w-4xl">

            <h2 className="text-2xl mb-6 text-[#ffe38c] font-bold">Create Account</h2>

            {serverError && <p className="text-red-500">{serverError}</p>}

            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="flex flex-col">
              <select
                name="role"
                value={formData.role}
                onChange={handleChange}
                className={`w-full p-3 border rounded outline-none text-gray-400 ${
                  hasSubmitted && errors.role ? "border-red-500" : "border-gray-300"
                }`}
              >
                <option value="client">Client</option>
                <option value="admin">Admin</option>
              </select>

              {hasSubmitted && errors.role && (
                <p className="text-red-500 text-sm mt-1">{errors.role}</p>
              )}
            </div>
              {Object.keys(formData)
              .filter((field) => field !== "role") // ✅ remove role from loop
              .map((field) => (
              <div key={field} className="flex flex-col">

                <input
                  name={field}
                  type={field.includes("password") ? "password" : "text"}
                  placeholder={field
                    .replaceAll("_", " ")
                    .replace(/\b\w/g, (l) => l.toUpperCase())}
                  value={(formData as any)[field]}
                  onChange={handleChange}
                  className={`w-full p-3 border rounded outline-none ${
                    hasSubmitted && errors[field] ? "border-red-500" : "border-gray-300"
                  }`}
                />

                {/* ✅ ERROR MESSAGE BELOW FIELD */}
                {hasSubmitted && errors[field] && (
                  <p className="text-red-500 text-sm mt-1">
                    {errors[field]}
                  </p>
                )}

              </div>
            ))}
              <div className="flex justify-between text-red-500">
                <button
                  type="button"
                  onClick={() => {
                    setShowModal(false);

                    // ✅ reset all form data
                    setFormData({
                      first_name: "",
                      last_name: "",
                      email: "",
                      school_id: "",
                      password: "",
                      confirm_password: "",
                      role: "client",
                    });

                    // ✅ clear errors
                    setErrors({});

                    // ✅ clear backend error
                    setServerError("");
                  }}
                >
                  Cancel
                </button>

                <button type="submit" className="bg-black text-white px-4 py-2">
                  Create
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* EDIT USER MODAL */}
      {editMode && editData && (
        <div className="fixed inset-0 bg-black/60 flex justify-center items-center z-50">
          <div className="bg-white p-10 rounded-xl w-full max-w-2xl">

            <h2 className="text-2xl mb-6">Edit User</h2>

            <form onSubmit={handleEditSubmit} className="space-y-4">

              <input
                name="first_name"
                value={editData.first_name}
                onChange={handleEditChange}
                className="w-full p-3 border rounded"
              />

              <input
                name="last_name"
                value={editData.last_name}
                onChange={handleEditChange}
                className="w-full p-3 border rounded"
              />

              <input
                name="email"
                value={editData.email}
                onChange={handleEditChange}
                className="w-full p-3 border rounded"
              />

              <input
                name="school_id"
                value={editData.school_id}
                onChange={handleEditChange}
                className="w-full p-3 border rounded"
              />

              <select
                name="role"
                value={editData.role}
                onChange={handleEditChange}
                className="w-full p-3 border rounded"
              >
                <option value="client">Client</option>
                <option value="admin">Admin</option>
              </select>

              <div className="flex justify-between">
                <button type="button" onClick={() => setEditMode(false)}>
                  Cancel
                </button>

                <button className="bg-blue-600 text-white px-4 py-2 rounded">
                  Save Changes
                </button>
              </div>

            </form>
          </div>
        </div>
      )}

      {/* LOGOUT */}
      <button
        onClick={() => {
          localStorage.removeItem("admin_token");
          window.location.replace("/admin/login");
        }}
        className="fixed bottom-6 right-6 bg-red-600 text-white px-5 py-2 rounded-full"
      >
        Log Out
      </button>
    </div>
  );
}