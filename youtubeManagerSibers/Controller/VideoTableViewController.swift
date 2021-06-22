//
//  VideoTableViewController.swift
//  youtubeManagerSibers
//
//  Created by Ruslan Abbasov on 10.06.2021.
//


class VideoTableCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    @IBOutlet weak var cellDescriptionLabel: UILabel!
    
    @IBOutlet weak var cellImageView: UIImageView!
}


import UIKit

class VideoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let networkManager = NetworkManager()
    
    var videosTableArray:[Item]? = []
    
    private static let videoCell = "videoCell"
    
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        youtubeSerch(searchWords: searchField.text ?? "")
    }

    // MARK: TableView
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return videosTableArray?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoTableCell

        cell.cellTitleLabel.text = videosTableArray?[indexPath.row].snippet?.title
        cell.cellDescriptionLabel.text = videosTableArray?[indexPath.row].snippet?.snippetDescription
        let url = URL(string: videosTableArray?[indexPath.row].snippet?.thumbnails?.medium?.url ?? "https://i.ytimg.com/vi/OYE9bQQii0I/default.jpg")
        cell.cellImageView.load(url: url!)
            return cell
    }
    
    @IBAction func searchFieldAciton(_ sender: Any) {
        youtubeSerch(searchWords: searchField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func youtubeSerch(searchWords: String){
        networkManager.getNewVideos(maxResult: 25, searhWord: searchWords) { Videos, error in
            self.videosTableArray = Videos
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MainViewController {
            let vc = segue.destination as? MainViewController
            let path = self.tableView.indexPathForSelectedRow
            vc?.videoID =  (videosTableArray?[path?.row ?? 0].id?.videoID)!
            vc?.descriptionString = (videosTableArray?[path?.row ?? 0].snippet?.snippetDescription)!
            vc?.titleString = (videosTableArray?[path?.row ?? 0].snippet?.title)!
        }
    }
}



 
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
