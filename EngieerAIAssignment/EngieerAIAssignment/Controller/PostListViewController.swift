//
//  PostListViewController.swift
//  EngieerAIAssignment
//
//  Created by kushal mandala on 17/12/19.
//  Copyright © 2019 kushal mandala. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView?
    
    var postListarray : [PostObject] = []
    var selectedPostListArray : [PostObject] = []

    var page = 1
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil)
        
        self.tableView?.register(nib, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        self.tableView?.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresPosts), for: .valueChanged)
        

        self.requestPosts(page)
        self.title = "Selected " + String(selectedPostListArray.count)

        // Do any additional setup after loading the view.
    }
    
    @objc func refresPosts()  {
        self.page = 1
        self.requestPosts(page)

    }
    
    @objc func loadMore()  {
        self.page = self.page + 1
        self.requestPosts(page)

    }

    
    func appendPosts(additionalPosts:[PostObject])
    {
        
        for post in additionalPosts
        {
            self.postListarray.append(post)
        }
        
    }
    
    func requestPosts(_ page : Int) {
        
        let urlString = ServiceInfo.baseUrl + "\(page)"
        
        NetworkManager.getposts(urlString) { (Posts) in
            

            if page == 1
            {
                self.postListarray = Posts.hits
            }
            else
            {
                self.appendPosts(additionalPosts: Posts.hits)
                
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                  self.tableView?.reloadData()
              }
            
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostListViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.postListarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell else
       {
        return UITableViewCell()
      }
        
        let post = self.postListarray[indexPath.row]
        
        cell.title?.text = post.title
        cell.created_at?.text = post.created_at
        
        if self.selectedPostListArray.contains(where: { $0.objectID == post.objectID }) {
            cell.toggle?.setOn(true, animated: true)
                
        }else {
                   
            cell.toggle?.setOn(false, animated: true)
        }

        
        cell.toggle?.addTarget(self, action: #selector(toggleSelected), for: .valueChanged)
        if indexPath.row == self.postListarray.count - 1
        {
            self.loadMore()
        }
        
        return cell;
            
    }
       
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let post = self.postListarray[indexPath.row]

        if let post = selectedPostListArray.firstIndex(where: { $0.objectID == post.objectID }) {

            self.selectedPostListArray.remove(at: post)
        
        }else{
            
            self.selectedPostListArray.append(post)
        }
        
        
        tableView.reloadData()
        
        self.title = "Selected " + String(selectedPostListArray.count)
        
       }
    
    @objc func toggleSelected(sender: UISwitch) {
                
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: buttonPosition)
        let post = self.postListarray[(indexPath?.row)!]
        if let post = selectedPostListArray.firstIndex(where: { $0.objectID == post.objectID }) {
            self.selectedPostListArray.remove(at: post)
        }
        else
        {
            self.selectedPostListArray.append(post)
        }
        
        self.title = "Selected " + String(self.selectedPostListArray.count)
        tableView!.reloadData()
                
    }
    
}
