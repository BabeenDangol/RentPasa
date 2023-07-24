const jwt = require('jsonwebtoken');

const verifyUser = async (req, res, next) => {
    const token = req.headers.authorization;

    if(!token) {
        return res.status(403).json({ message: 'Authentication error. Please send valid token'});
    }

    jwt.verify(token, "secretKey", (err, decoded) => {
        if(err) {
            return res.status(403).json({ message: 'Authentication error. Please send valid token'});
        }

        req.user = decoded;
        next();
    });
}

const verifyOwner = async (req, res, next) => {
    const token = req.headers.authorization;

    if(!token) {
        return res.status(403).json({ message: 'Authentication error. Please send valid token'});
    }

    jwt.verify(token, "secretKey", (err, decoded) => {
        if(err) {
            return res.status(403).json({ message: 'Authentication error. Please send valid token'});
        }

        req.user = decoded;
        if(req.user.role === "owner") {
            next();
        } else {
            return res.status(401).json({ message: 'You do not have the permission to perform this action.'});
        }
        
    });
}

module.exports = {
    verifyUser,
    verifyOwner
}