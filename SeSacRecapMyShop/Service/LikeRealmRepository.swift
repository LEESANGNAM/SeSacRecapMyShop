//
//  RealmRepository.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/10.
//

import Foundation
import RealmSwift

protocol LikeRepositoryType: AnyObject {
        func fetch() -> Results<LikeProduct>
        func fetchFilter(item: Item) -> Results<LikeProduct>
        func createItem(_ item: LikeProduct)
        func removeItem(_ item: LikeProduct)
}

class LikeRepository:LikeRepositoryType {
    
    private let realm = try! Realm()
    
    func fetch() -> Results<LikeProduct>{
        let data = realm.objects(LikeProduct.self).sorted(byKeyPath: "createTime", ascending: false)
        return data
    }
    
    func fetchFilter(item: Item) -> Results<LikeProduct>{
        let result = realm.objects(LikeProduct.self).where {
            $0.productID == item.productID
        }
        return result
    }
    
    func createItem(_ item: LikeProduct){
        do{
            try realm.write {
                realm.add(item)
            }
        }catch{
            print(error)
        }
    }
    func removeItem(_ item: LikeProduct) {
        do {
            try realm.write {
                realm.delete(item)
            }
        }catch{
            print(error)
        }
    }

}

