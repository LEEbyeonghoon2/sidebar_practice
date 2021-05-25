//
//  FrontViewController.swift
//  SWReveal_practice
//
//  Created by 이병훈 on 2021/05/25.
//

import UIKit

class FrontViewController: UIViewController {
    var delegate: RevealViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //버튼 객체 생성
        let leftBtn = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:)))
        
        self.navigationItem.leftBarButtonItem = leftBtn
    }
    @objc func moveSide(_ sender: Any) {
        if sender is UIScreenEdgePanGestureRecognizer {
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeGestureRecognizer {
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem {
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil)
            } else {
                self.delegate?.closeSideBar(nil)
            }
        }
        
    }
    func sideTouch() {
        // 왼쪽에서 오른쪽으로 스와이프 할때 제스처 등록
        let dragLeft =  UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left // 탭이 시작되는 위치
        // 사이드 메뉴 닫기
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left
        
        //뷰에 제스처 등록
        self.view.addGestureRecognizer(dragLeft)
        self.view.addGestureRecognizer(dragRight)
    }
    //프론트 뷰컨트롤러의 아무데나 클릭해도 사이드바 감춰지게 설정
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.delegate?.isSideBarShowing == true {
            self.delegate?.closeSideBar(nil)
        }
    }
}
