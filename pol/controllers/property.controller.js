
const PropertyService = require('../services/property.services');
const PropertyModel = require('../model/property.model.js');
// Create a new booking
exports.createProperty = async (req, res, next) => {
  try {
    const {
      propertyAddress,
      ownerName,
      ownerId,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate,
      propertyDescriptions,
    } = req.body;

    const property = await PropertyService.createProperty(
      propertyAddress,
      ownerName,
      ownerId,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate,
      propertyDescriptions
    );
    res
      .status(201)
      .json({ status: true, success: "Property added successfully", property });
  } catch (error) {
    next(error);
  }
};
exports.getProperty = async (req, res, next) => {
  try {
    const property = await PropertyService.getProperty();
    res.status(200).json({ status: true, property });
  } catch (error) {
    next(error);
  }
};
exports.getBooks = async (req, res, next) => {
  try {
    const getbooks = await PropertyService.getBooks();
    res.status(200).json({ status: true, getbooks });
  } catch (error) {
    next(error);
  }
};
