const PropertyService = require('../services/property.services.js');
const upload = require('../middleware/multer.js'); // Import the multer middleware

// Create a new property
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
      propertyImageBase64,
    } = req.body;
    console.log("CHECK MEEEE",req.body);

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
      propertyDescriptions,
      propertyImageBase64,
      // Remove "path" from the parameters as it's not used here.
    );

    res.status(201).json({ status: true, success: "Property added  successfully", property });
  } catch (error) {
    next(error);
  }
};

// Retrieve all properties
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
    res.status(200).json({ status: true, getbooks});
  } catch (error) {
    next(error);
  }
};

// Update a property
exports.updateProperty = async (req, res, next) => {
  try {
    const { propertyId } = req.params;
    const {
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate,
      propertyImage,
    } = req.body;

    const property = await PropertyService.updateProperty(
      propertyId,
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate,
      propertyImage
    );

    res.status(200).json({ status: true, success: "Property updated successfully", property });
  } catch (error) {
    next(error);
  }
};

// Delete a property
exports.deleteProperty = async (req, res, next) => {
  try {
    const { propertyId } = req.params;
    await PropertyService.deleteProperty(propertyId);
    res.status(200).json({ status: true, success: "Property deleted successfully" });
  } catch (error) {
    next(error);
  }
};

// Variable to keep track of the image count
let imageCount = 0;

exports.getImageCount = () => {
  return imageCount;
};

exports.incrementImageCount = () => {
  imageCount++;
};

// Upload an image
exports.uploadImage = async (req, res, next) => {
  try {
    if (!req.file) {
      return res.status(400).json({ status: false, message: 'No image provided' });
    }

    const fileName = req.file.fileName;

    res.status(200).json({ status: true, message: `Image uploaded successfully at ${fileName}` });
  } catch (error) {
    console.error(error);
    next(error);
  }
};