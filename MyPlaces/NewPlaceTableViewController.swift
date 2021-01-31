//
//  NewPlaceTableViewController.swift
//  MyPlaces
//
//  Created by Vladimir Karsakov on 28.01.2021.
//

import UIKit

class NewPlaceTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var imageIsChanged = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var imageOfPlace: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false //не доступно нажатие кнопки по умолчанию
        nameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged) //при внесении изменений в текстовое поле name будет срабатывать метод
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -100 //поднимает view.frame на 100 поинтов при появлении клавиатуры
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0 //опускает на место view.frame при сворачивании клавиатуры
        }
        tableView.tableFooterView = UIView() //убираем разлиновку пустых строк таблицы под последней ячейкой
    }
    
    
    //MARK: - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{ //при нажатии на первую ячейку таблицы..
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoLibaryIcon = #imageLiteral(resourceName: "photo")
            
            let alertActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let alertActionTakePicture = UIAlertAction(title: "Сделать фото", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            alertActionTakePicture.setValue(cameraIcon, forKey: "image") //добавляем картинку на action
            let alertActionLoadGallery = UIAlertAction(title: "Выбрать из библиотеки", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            alertActionLoadGallery.setValue(photoLibaryIcon, forKey: "image") //добавляем картинку на action
            let alertActionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            alertActionSheet.addAction(alertActionTakePicture)
            alertActionSheet.addAction(alertActionLoadGallery)
            alertActionSheet.addAction(alertActionCancel)
            
            present(alertActionSheet, animated: true, completion: nil)
            
        } else{
            view.endEditing(true) //убираем клавиатуру при нажатии на любую ячейку, кроме первой
        }
    }
    
    func saveNewPlace(){
                
        var image: UIImage?
        
        if imageIsChanged == true{ //если пользователь использует свое изображение, то
            image = imageOfPlace.image
        } else{ //если картинка не загружена пользователем
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        
        let imageData = image?.pngData() //из uiimage в data
        
        guard let name = nameTextField.text else { return }
        let newPlace = PlaceModel(name: name, location: locationTextField.text, type: typeTextField.text, imageData: imageData)
        
        StorageManager.saveObject(newPlace)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
    //MARK: - text field delegate
extension NewPlaceTableViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField{
            locationTextField.becomeFirstResponder()
        } else if textField == locationTextField{
            typeTextField.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc private func textFieldChanged(){
        if nameTextField.text?.isEmpty == false{ //если текстфилд с именем не пустой
            saveButton.isEnabled = true //то кнопка сохранить активна
        } else{
            saveButton.isEnabled = false
        }
    }
}

    //MARK: - work to image
extension NewPlaceTableViewController: UIImagePickerControllerDelegate{
    func chooseImagePicker(source: UIImagePickerController.SourceType){ //source - источник выбора изображения
        if UIImagePickerController.isSourceTypeAvailable(source){ //если источник выбора изображения доступен, то
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true //возможность редактировать выбранные изображения
            imagePicker.sourceType = source //выбираем тип источника для выбранного изображения
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageOfPlace.image = info[.editedImage] as? UIImage //присваиваем отредактированное изображение нашему аутлету
        imageOfPlace.contentMode = .scaleAspectFill //масштабируем изображение по содержимому uiimage
        imageOfPlace.clipsToBounds = true //обрезаем изображение по границе uiimage
        imageIsChanged = true //пользователь использует свое изображение
        dismiss(animated: true, completion: nil)
    }
}
