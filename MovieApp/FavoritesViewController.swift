//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
   @IBOutlet private var favoritesTableView: UITableView!
    private let frc = FavoritesMO.fetchResultsController(context: PersistanceService.shared.viewContext)
    private let kTableViewCellNib = UINib(nibName: "FavoritesTableViewCell", bundle: nil)
    private let kTableViewCellReuseIdentifier = "kTableViewCellReuseIdentifier"
    private var cellHeights: [IndexPath : CGFloat] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(kTableViewCellNib, forCellReuseIdentifier: kTableViewCellReuseIdentifier)
        setUpUI{}
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.topItem?.title = "Избранное"
        
    }
}
extension FavoritesViewController {
    private func setUpUI(completion: ()-> Void) {
        do {
            frc.delegate = self
            try frc.performFetch()
            favoritesTableView.dataSource = self
            favoritesTableView.delegate = self
            completion()
        }catch {
            let alertController = UIAlertController(title: nil,
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Close",
                                         style: .default,
                                         handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}
extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellReuseIdentifier, for: indexPath) as! FavoritesMoviesTableViewCell
 let model = frc.fetchedObjects![indexPath.row]
       cell.configureSelf(withModel: model)
        print(model.title)
        return cell
    }
    
    
}
extension FavoritesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else { return 150.0 }
        return height
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //let model = frc.fetchedObjects![indexPath.row]
        if editingStyle == .delete{
            let context = PersistanceService.shared
                .persistentContainer
                .newBackgroundContext()
            do {
             
//                PersistanceService.shared.viewContext.delete(frc.fetchedObjects![indexPath.row])
                PersistanceService.shared.persistentContainer.viewContext.delete(frc.fetchedObjects![indexPath.row])
            
                try context.save()
        } catch {
            print("")
        }
        
    }
    }}

//MARK: - extension (NSFetchedResultsControllerDelegate)

extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoritesTableView.beginUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
               favoritesTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                favoritesTableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                favoritesTableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            favoritesTableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoritesTableView.endUpdates()
    }
}
