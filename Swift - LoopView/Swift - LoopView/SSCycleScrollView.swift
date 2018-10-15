//
//  SSCycleScrollView.swift
//  Swift - LoopView
//
//  Created by nice on 2018/10/15.
//  Copyright © 2018 NICE. All rights reserved.
//

import UIKit
import SnapKit

class SSCycleScrollView: UIView {
    
    let totalItems : Int = 3 * 100
    var timer: Timer?
    
    
    // MARK: -- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitUI()
        
        setUpTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commitUI() {
        self.addSubview(self.collectionView)
        self.collectionView.backgroundColor = UIColor.orange
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.layoutIfNeeded()
        
        collectionView .scrollToItem(at: NSIndexPath.init(item: totalItems / 2, section: 0) as IndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally
            , animated: false)
    }
    
    func setUpTimer() {
        self.invalidateTimer()
        
        timer = Timer.init(timeInterval: 2, repeats: true, block: { (timer) in
            
            if self.totalItems == 0 {return}
            let currentIndex : Int = self.getCurrentIndex()
            let targetIndex: Int = currentIndex + 1
            
            self.scrollToIndex(targetIndex: targetIndex)
        })
        
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    func invalidateTimer() {
        self.timer?.invalidate()
        
    }
    
    func getCurrentIndex() -> Int{
        if self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0{
            return 0
        }
        
        let index: Int = Int((self.collectionView.contentOffset.x + self.frame.size.width * 0.5 ) / self.frame.size.width)
        
        return max(0, index)
    }
    
    func scrollToIndex(targetIndex: Int) {
        var targetIndex = targetIndex
        
        if targetIndex >= self.totalItems{
            targetIndex = Int(self.totalItems / 2)
        }
        
        self.collectionView.scrollToItem(at: NSIndexPath.init(row: targetIndex, section: 0) as IndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = self.frame.size
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        return collectionView
        
    }()

}


// MARK: collectionDelegate

extension SSCycleScrollView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row % 3
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if index == 0{
            cell.backgroundColor = UIColor.red
            
        } else if index == 1{
            cell.backgroundColor = UIColor.yellow
            
        } else{
            cell.backgroundColor = UIColor.blue
            
        }
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.invalidateTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.setUpTimer()
    }
}
