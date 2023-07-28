const PropertyModel = require('../model/property.model.js');
const BookModel = require("../model/book.model.js");
class PropertyService {
  // Create a new property
  static async createProperty(propertyAddress,ownerName, ownerId, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyImageBase64,propertyDescriptions, propertyImage) {
    try {
      const property = new PropertyModel({
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
        propertyImage:{
          data: propertyImageBase64,
          contentType: 'image/jpg',
        },
      });
      return await property.save();
    } catch (error) {
      throw error;
    }
  }

  // Get all properties

  static async getProperty() {
    try {
      return await PropertyModel.find();
    } catch (error) {
      throw error;
    }
  }
  static async getBooks() {
    try {
      return await BookModel.find();
    } catch (error) {
      throw error;
    }
  }
  // Update a property
  static async updateProperty(propertyId, propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyImage) {
    try {
      const updatedData = { propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyImage };
      return await PropertyModel.findByIdAndUpdate(propertyId, updatedData, { new: true });
    } catch (error) {
      throw error;
    }
  }

  // Delete a property by ID
  static async deleteProperty(propertyId) {
    try {
      return await PropertyModel.findByIdAndDelete(propertyId);
    } catch (error) {
      throw error;
    }
  }


static async uploadImage(bookingId, imageBase64) {
  try {
    const property = await PropertyModel.findById(bookingId);

    if (!property) {
      throw new Error('property not found');
    }

    // Update the propertyImage field with the new image data
    property.propertyImage = {
      data: imageBase64,
      contentType: 'image/jpg', // You can set the appropriate content type here based on the image file type
    };

    return await property.save();
  } catch (error) {
    throw error;
  }
}
}



module.exports = PropertyService;