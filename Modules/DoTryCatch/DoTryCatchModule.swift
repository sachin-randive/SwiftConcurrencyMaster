//
//  DoTryCatchModule.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 10/11/25.
//

import SwiftUI
/*
 A throwing function requires the use of try when called
 Try requires do/catch, unless you use try? or try!, which isnt safe or requires optionals
 Function or property that 'tries' can 'catch' errors that are 'thrown' and handle them
 */

enum EncryptionError: Error {
    case invalidPassword
    case weakPassword
}

struct Encrptor {
    func encrypt(_ message: String, password: String) throws -> String {
        
        guard !password.isEmpty else {
            throw EncryptionError.invalidPassword
        }
        guard password.count > 5 else {
            throw EncryptionError.weakPassword
        }
        let encrypted = password + message + password
        return String(encrypted.reversed())
    }
}


struct DoTryCatchModule: View {
    let encryptor = Encrptor()
    let message = "Hello, World!"
    var encryptedMessage: String {
        do {
            return try encryptor.encrypt(message, password: "123")
        } catch let error as EncryptionError{
            return "Encryption error: \(error)"
        }  catch {
            return "An unknown error ocurred"
        }
      
    }
    var body: some View {
        Text(message)
        Text("Encrypted: \(encryptedMessage)")
    }
}

#Preview {
    DoTryCatchModule()
}
