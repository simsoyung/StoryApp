//
//  ViewController.swift
//  StoryApp
//
//  Created by 심소영 on 6/12/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class ViewController: UIViewController {

    var imageList = Images(documents: [], meta: Meta(is_end: false, pageable_count: 0, total_count: 0))
    
    lazy var storyCell = UICollectionView(frame: .zero, collectionViewLayout: storyViewLayout())
    
    lazy var textImages = {
        let image = TextImage(frame: .zero)
        return image
    }()
    lazy var textSearchBar = {
        let view = SearchTextField()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    configureHierarchy()
    configureLayout()
    configureUI()
    requestImage()
    }
    
    private func callRequest(query: String){
        
    }
    private func requestImage(){
        let url = "\(API.APIURL.kakaoImageURL)"
        let parameters: Parameters = ["query": "강아지"]
        let header: HTTPHeaders = ["Authorization" : API.APIKey.kakaoKey]
        AF.request(url, parameters: parameters, headers: header).responseDecodable(of: Images.self) { response in
                switch response.result {
                case .success(let value):
                    self.imageList = value
                    self.storyCell.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
    private func configureHierarchy(){
        view.addSubview(textImages)
        view.addSubview(textSearchBar)
        view.addSubview(storyCell)
        storyCell.delegate = self
        storyCell.dataSource = self
        textSearchBar.delegate = self
        storyCell.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: StoryCollectionViewCell.id)
    }
    private func configureLayout(){
        textImages.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(44)
        }
        textSearchBar.snp.makeConstraints { make in
            make.top.equalTo(textImages.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(44)
        }
        storyCell.snp.makeConstraints { make in
            make.top.equalTo(textSearchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(100)
        }
    }
    private func configureUI(){
        view.backgroundColor = .white
        storyCell.showsHorizontalScrollIndicator = false
    }
    
    private func storyViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: sectionSpacing)
        return layout
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.id, for: indexPath) as! StoryCollectionViewCell
        let data = imageList.documents[indexPath.item]
        let urlImage = "\(data.thumbnail_url)"
        let url = URL(string: urlImage)
        cell.image.kf.setImage(with: url)
        cell.contentMode = .scaleAspectFill
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.clipsToBounds = true
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest(query: textSearchBar.text!)
    }
}

