const AdminService = require('../services/admin.services');

exports.register = async (req, res, next) => {
    try {
        const { names, phone, email, password } = req.body;
        const successRes = await AdminService.registerAdmin(names, phone, email, password);
        res.status(201).json({ status: true, success: "Admin successfully registered", data: successRes });
    } catch (error) {
        next(error);
    }
};

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        // check email from the database
        const admin = await AdminService.checkadmin(email);

        if (!admin) {
            return res.status(400).json({ status: false, message: "User doesn't exist!" });
        }

        const isMatch = await admin.comparePassword(password);

        if (isMatch === false) {
            return res.status(400).json({ status: false, message: "Password is invalid. Please try a valid one!" });
        }

        let tokenData = { _id: admin._id, email: admin.email, names:admin.names, phone:admin.phone, role:admin.role };

            const token = await AdminService.generateToken(tokenData, "secretKey", '1h');

            res.headers = {};
            res.headers.authorization = token;

            res.cookie('authorization', token, {httpOnly: true, secure: true});

            res.status(200).json({ status: true, token: token });

    } catch (error) {
        next(error);
    }
};
exports.getUser = async (req, res, next) => {
    try {
      const user = await UserService.getUser();
      res.status(200).json({ status: true, user });
    } catch (error) {
      next(error);
    }
  };