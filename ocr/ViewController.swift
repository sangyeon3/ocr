//
//  ViewController.swift
//  ocr
//
//  Created by  sangyeon on 2022/02/18.
//

import UIKit
import MLKitTextRecognitionKorean
import MLKitTextRecognition
import SnapKit

class ViewController: UIViewController {
    
    let picker = UIImagePickerController()
    var myImageView = UIImageView()
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("button", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(onClickBtn(_:)), for: .touchUpInside)
        
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        displaySetting()
    }
}


extension ViewController{
    
    func displaySetting(){
        view.addSubview(button)
        button.snp.makeConstraints{
            $0.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func onClickBtn(_ sender: Any){
        actionSheetAlert()
    }
    
    private func actionSheetAlert(){
        let alert = UIAlertController(title: "선택", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let cameraAction = UIAlertAction(title: "카메라", style: .default){ [weak self] (_) in
            self?.presentCamera()
        }
        let albumAction = UIAlertAction(title: "앨범", style: .default){ [weak self] (_) in
            self?.presentAlbum()
        }
        
        alert.addAction(cancel)
        alert.addAction(cameraAction)
        alert.addAction(albumAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayImage(){
        view.addSubview(myImageView)
        myImageView.snp.makeConstraints{
            $0.top.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(300)
        }
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    private func presentCamera(){
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    private func presentAlbum(){
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    // Use Photo 클릭 시 발생하는 함수
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            myImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
        displayImage()
    }

    // cancel 클릭 시 발생하는 함수
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//extension ViewController{
//
//    // MARK: 이미지로부터 텍스트 인식
//    func getText(image: UIImage){
//        let koreanOptions = KoreanTextRecognizerOptions()
//        let textRecognizer = TextRecognizer.textRecognizer(options: koreanOptions)
//        //let visionImage = vision
//        //visionImage.orientation = image.imageOrientation
//    }
//
//}
