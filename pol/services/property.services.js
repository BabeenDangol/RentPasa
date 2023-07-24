const PropertyModel = require('../model/property.model.js');

class PropertyService {
  // Create a new property
  static async createProperty(propertyAddress,ownerName, ownerId, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyImageBase64, propertyImagePath) {
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

  // Update a property
  static async updateProperty(bookingId, propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyImage) {
    try {
      const updatedData = { propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyImage };
      return await PropertyModel.findByIdAndUpdate(bookingId, updatedData, { new: true });
    } catch (error) {
      throw error;
    }
  }

  // Delete a property by ID
  static async deleteProperty(bookingId) {
    try {
      return await PropertyModel.findByIdAndDelete(bookingId);
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