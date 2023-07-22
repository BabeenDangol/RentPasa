const { UserModel } = require("../model/user.model.js");
const jwt = require("jsonwebtoken");
class UserService {
  static async registerUser(names, phone, email, password, role) {
    try {
      const createUser = new UserModel({ names, phone, email, password, role });
      return await createUser.save();
    } catch (err) {
      throw err;
    }
  }

  static async checkuser(email) {
    try {
      return await UserModel.findOne({ email });
    } catch (error) {
      throw error;
    }
  }
  static async generateToken(tokenData, secretKey, jwt_expire) {
    return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
  }
  static async getUser() {
    try {
      return await UserModel.find();
    } catch (error) {
      throw error;
    }
  }
}
module.exports = UserService;
