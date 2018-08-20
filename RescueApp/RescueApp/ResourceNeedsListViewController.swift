//
/*
ResourceNeedsListViewController.swift
Created on: 8/17/18

Abstract:
Resources as a list

*/

import UIKit

class ResourceNeedsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var requests = [RequestModel]()
    var requestsType: RequestType!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Button Actions
    // UNUSED METHOD FOR NOW
    @objc func onMap(_ sender: UIButton) {
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(1.0)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationTransition(.flipFromRight, for: (navigationController?.view)!, cache: false)
        navigationController?.popViewController(animated: false)
        UIView.commitAnimations()
    }
}

extension ResourceNeedsListViewController {
    func configureUI() {
        title = requestsType.rawValue
    }
}

extension ResourceNeedsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListViewCell
        let model = requests[indexPath.row]
        cell?.nameLabel.text = model.requestee
        cell?.locationLabel.text = model.location
        return cell!
    }
}

extension ResourceNeedsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? ResourseNeedsDetailViewController else {
            return
        }
        vc.selectedRescue = requests[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
