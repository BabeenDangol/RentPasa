const { AdminModel } = require("../model/admin.model.js");
const jwt = require("jsonwebtoken");
class AdminService {

  static async registerAdmin(names, phone, email, password) {
    try {
      const createAdmin = new AdminModel({ names, phone, email, password });
      return await createAdmin.save();
    } catch (err) {
      throw err;
    }
  }

  static async checkadmin(email) {
    try {
      return await AdminModel.findOne({ email });
    } catch (error) {
      throw error;
    }
  }

  static async generateToken(tokenData, secretKey, jwt_expire) {
    return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
  }

}
module.exports = AdminService;
