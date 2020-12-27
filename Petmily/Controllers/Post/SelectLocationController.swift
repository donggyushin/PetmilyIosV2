//
//  SelectPetKindController.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/27.
//

import UIKit

private let reuseIdentifier = "Cell"

class SelectLocationController: UICollectionViewController {

    // MARK: Properties
    private lazy var searchController:UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        return sc
    }()
    
    
    // MARK: Lifecycles
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureSearchController()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Configures
    func configureUI() {
        collectionView.backgroundColor = .systemBackground
    }
    
    func configureSearchController() {
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "지역을 검색해주세요"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }



}


extension SelectLocationController:UICollectionViewDelegateFlowLayout {
    
}


extension SelectLocationController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        
        print("text:\(text)")
    }
}
