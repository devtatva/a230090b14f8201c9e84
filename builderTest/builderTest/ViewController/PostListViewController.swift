//
//  PostListViewController.swift
//  builderTest
//
//  Created by pcq186 on 06/02/23.
//

import UIKit
import UIScrollView_InfiniteScroll

class PostListViewController: BaseViewController {

    //MARK: - Outlets
    @IBOutlet private weak var postTableView: UITableView!
    
    //MARK: - Variables
    private lazy var viewModel: PostListViewModel = PostListViewModel(controller: self)
    let refreshController = UIRefreshControl()
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    //MARK: - Helper methods
    private func prepareView() {
        postTableView.register(UINib(nibName: "PostTableViewCell", bundle: .main), forCellReuseIdentifier: "PostTableViewCell")
        self.refreshController.addTarget(self, action: #selector(refresh(_ :)), for: .valueChanged)
        postTableView.addSubview(refreshController)
        self.setPostData(page: self.viewModel.page)
        addPagination()
    }
    
    private func addPagination() {
        postTableView.addInfiniteScroll { [weak self] tableView in
            guard let self = self else { return }
            self.setPostData(page: self.viewModel.page)
            self.viewModel.page += 1
            tableView.reloadData()
        }
    }
    
    private func setPostData(page: Int) {
        if page < viewModel.post?.nbPages ?? 1 {
            viewModel.callGetPostListAPI(tags: "story", page: page) { [weak self] (isSuccess, error) in
                guard let self = self else { return }
                if isSuccess {
                    DispatchQueue.main.async {
                        self.postTableView.reloadData()
                        self.showNavTitle(title: "Total Displaying Hits : \(self.viewModel.hitList.count)")
                    }
                } else {
                    let alertVC = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
                    self.present(alertVC, animated: true, completion: nil)
                }
                self.refreshController.endRefreshing()
                self.postTableView.finishInfiniteScroll()
            }
        } else {
            self.postTableView.removeInfiniteScroll()
        }
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.page = 0
        self.setPostData(page: self.viewModel.page)
        addPagination()
    }
}

//MARK: - Tableview delegate and Data source methods
extension PostListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.hitList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell {
            cell.hit = viewModel.hitList[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
