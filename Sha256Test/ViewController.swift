//
//  ViewController.swift
//  Sha256Test
//
//  Created by Jeonggyu Park on 26/02/2020.
//  Copyright © 2020 Jeonggyu Park. All rights reserved.
//

import UIKit
import CryptoSwift


class ViewController: UIViewController {

    let key: String = "testKeystestKeystestKeystestKeys"
    let plainText: String = "암호화될 평문입니다."
    let iv: [UInt8] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //print("sha256 테스트: " + "hello world".sha256())
        do {
            let encryptedText = try AES(key: key.bytes, blockMode: CBC(iv: self.iv), padding: .pkcs5).encrypt(self.plainText.bytes)
            print("encrypted text: " + encryptedText.toHexString())
            
           
            print("decrypted text: " + (decryptArtisan(cryptedMessage:encryptedText.toHexString()) ?? ""))
            
        } catch {
            print(error)
        }
        
        
        
        //let uuid = UUID().uuidString
        //print("uuid: " + uuid)
    }
    
    
        
    
    
    
    func decryptArtisan(cryptedMessage: String) -> String? {
        var clairMessage:String? = nil;
        
        if let cryptedData = Data(base64Encoded: cryptedMessage) {
            do {
                let aes = try AES(key: Array<UInt8>(key.utf8), blockMode: CBC(iv: self.iv), padding: .pkcs5) // aes128
                let cipher = try aes.decrypt(Array<UInt8>(cryptedData))
                clairMessage = String(bytes: cipher, encoding: .utf8)
            }catch{
                let error = error as NSError
                print(error)
            }
        }
        
        return clairMessage
    }


}

