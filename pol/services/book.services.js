const BookModel = require('../model/book.model.js');

class BookService {
  // Create a new book
  static async createBook(userId,propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate) {
    try {
      const book = new BookModel({userId, propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate });
      return await book.save();
    } catch (error) {
      throw error;
    }
  }



  // Update a book
  static async updateBook(bookId, propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate) {
    try {
      const updatedData = { propertyAddress,propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate };
      return await BookModel.findByIdAndUpdate(bookId, updatedData, { new: true });
    } catch (error) {
      throw error;
    }
  }

  // Delete a book by ID
  static async deleteBook(bookId) {
    try {
      return await BookModel.findByIdAndDelete(bookId);
    } catch (error) {
      throw error;
    }
  }
}

module.exports = BookService;