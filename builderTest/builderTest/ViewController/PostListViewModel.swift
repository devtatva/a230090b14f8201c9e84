//
//  PostListViewModel.swift
//  builderTest
//
//  Created by pcq186 on 06/02/23.
//

import Foundation
import MBProgressHUD

class PostListViewModel {
    
    //MARK: - Variables
    var controller: PostListViewController!
    var post: Post?
    var hitList: [Hits] = []
    var page: Int = 0
    
    //MARK: - Object life cycle
    init(controller: PostListViewController) {
        self.controller = controller
    }
    
    //MARK: - Custom methods
    func callGetPostListAPI(tags: String, page: Int, completion: @escaping(_ isSuccess: Bool, _ error: String?) -> Void) {
        if page == 0 {
            MBProgressHUD.showAdded(to: controller.view, animated: true)
        }
        APIManager.shared.sendRequest(.getPostHits(tags: tags, page: page), type: Post.self) { [weak self] response in
            guard let self = self else { return }
            self.post = response
            if page == 0 {
                self.hitList.removeAll()
            }
            self.hitList.append(contentsOf: response.hits ?? [])
            completion(true, nil)
            MBProgressHUD.hide(for: self.controller.view, animated: true)
        } failureCompletion: { error in
            completion(false, error.localizedDescription)
            MBProgressHUD.hide(for: self.controller.view, animated: true)
        }
    }
}
