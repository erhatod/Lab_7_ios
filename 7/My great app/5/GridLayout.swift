//
//  GridLayout.swift
//  My great app
//
//  Created by Oleksii Afonin on 05.12.2020.
//

import UIKit

class SquareGridLayout: UICollectionViewFlowLayout {
    
    private var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributesArray = [UICollectionViewLayoutAttributes]()
        if cache.isEmpty {
            prepare()
        }
        for (_, layoutAttributes) in cache {
            if rect.intersects(layoutAttributes.frame) {
                layoutAttributesArray.append(layoutAttributes)
            }
        }
        return layoutAttributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath]
    }
    
    
    internal var scpacing: (vertical: CGFloat, horisontal: CGFloat) {
        return (vertical: 1, horisontal: 1)
    }
    
    internal var numberOfColumns: Int {
        return 4
    }
    
    var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    var contentHeight: CGFloat = 0
    
    public override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView else {
            return
        }
        
        cache.removeAll()
        
        
        let itemWidth = (contentWidth - CGFloat(numberOfColumns - 1) * scpacing.horisontal) / CGFloat(numberOfColumns)
        let itemHeight = itemWidth
        
        let expandedWidth = itemWidth * 2 + scpacing.horisontal
        let expandedHeight = expandedWidth
        
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        
        func add(rect: CGRect, at idx: Int) {
            
            let indexPath = IndexPath(row: idx, section: 0)
            let targetLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            targetLayoutAttributes.frame = rect
            contentHeight = max(rect.maxY, yOffset+expandedWidth)
            cache[indexPath] = targetLayoutAttributes
            
        }
        
        
        for sectionNumber in 0..<collectionView.numberOfSections {
            for rowNumber in 0..<collectionView.numberOfItems(inSection: sectionNumber) {
                
                switch (rowNumber) % 10 {
                case 0:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight), at: rowNumber)
                    xOffset += itemWidth + scpacing.horisontal
                case 1:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: expandedWidth, height: expandedHeight), at: rowNumber)
                    xOffset += expandedWidth + scpacing.horisontal
                case 2:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight), at: rowNumber)
                    xOffset = 0
                    yOffset += itemWidth + scpacing.vertical
                case 3:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight), at: rowNumber)
                    xOffset += itemWidth + 2 * scpacing.horisontal + expandedWidth
                case 4:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight), at: rowNumber)
                    xOffset = 0
                    yOffset += itemWidth + scpacing.vertical
                    
                case 5:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: expandedWidth, height: expandedHeight), at: rowNumber)
                    xOffset += scpacing.horisontal + expandedWidth
                    
                case 6:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight), at: rowNumber)
                    xOffset += scpacing.horisontal + itemWidth
                case 7:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight), at: rowNumber)
                    xOffset = scpacing.horisontal + expandedWidth
                    yOffset += itemWidth + scpacing.vertical
                case 8:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight), at: rowNumber)
                    xOffset += scpacing.horisontal + itemWidth
                case 9:
                    add(rect: CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight), at: rowNumber)
                    xOffset = 0
                    yOffset += itemWidth + scpacing.vertical


                    
                default:
                    print(rowNumber)
                    fatalError()
                }
                    
                
                
            }
        }
        
    }
    
    
}
