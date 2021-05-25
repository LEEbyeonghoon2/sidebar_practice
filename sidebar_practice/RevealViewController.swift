//
//  ViewController.swift
//  SWReveal_practice
//
//  Created by 이병훈 on 2021/05/25.
//

import UIKit

class RevealViewController: UIViewController {
    var contentVC: UIViewController?// 메인
    var sideVC: UIViewController? // 사이드바
    
    var isSideBarShowing = false // 현재 사이드바가 열려있는지 확인
    
    let SLIDE_TIME = 0.3 // 사이드바가 열리고 닫히는데 걸리는 시간
    let SIDEBAR_WIDTH: CGFloat = 260 // 사이드가 열릴 너비

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    //초기 화면 설정
    func setupView() {
        if let vc = self.storyboard?.instantiateViewController(identifier: "sw_front") as? UINavigationController {
            //클래스 전체에서 참조를 할수 있도록 contentVC 속성에 저장
            self.contentVC = vc
            //프론트 컨트롤러 객체를 메인 컨트롤러의 자식으로 등록, 처음에 front가 등장해야 하므로
            self.addChild(vc)
            //view의 서브뷰로 등록
            self.view.addSubview(vc.view)
            //vc의 컨트롤러에 부모 뷰 컨트롤러가 바뀌었다고 알려준다.
            vc.didMove(toParent: self)
            //내비게이션 컨트롤러에 연결되어 있는 자식 컨트롤러는 배열 형태로 되어 있어 순서대로 0 부터 저장이 됩니다.
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
        }
    }
    //사이드바의 뷰를 읽어온다
    func getSideView() {
        //sideVC가 nil이면 읽어온다. 왜냐하면 값이 들어있으면 굳이 읽어올 필요가 없으니깐
        guard self.sideVC == nil else {
            return
        }
        
        if let vc = self.storyboard?.instantiateViewController(identifier: "sw_rear") as? UITableViewController {
            self.sideVC = vc
            
            self.addChild(vc)
            
            self.view.addSubview(vc.view)
            
            vc.didMove(toParent: self)
            
            //_프론트컨트롤러의 뷰를 제일 위로 올린다.
            self.view.bringSubviewToFront((self.contentVC?.view)!)
        }
        
    }
    // 콘텐츠 뷰에 그림자 효과를 준다.
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if shadow == true {
            //그림자 설정
            //maskToBounds는 테두리 뷰가 기준이 됩니다.
            self.contentVC?.view.layer.masksToBounds = false
            self.contentVC?.view.layer.cornerRadius = 10
            self.contentVC?.view.layer.shadowOpacity = 0.8
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
        } else {
            //그림자 설정하지 않기
            self.contentVC?.view.layer.cornerRadius = 0 // 모서리 둥굴기 업애기
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    // 사이드 바를 연다.
    func openSideBar(_ complete: ( () -> Void)?) {
        //사이드뷰를 읽어옵니다.
        self.getSideView()
        //그림자 효과 설정
        self.setShadowEffect(shadow: true, offset: -2)
        
        //애니메이션 옵션
        //.curveEaseInOut은 애니메이션 구간별 속도 조정 옵션입니다. 처음과 끝은 느리게 가고 중간은 점점 빠르게 움직이도록 조절하는것입니다.
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        //애니메이션 실행
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME),
                       //애니메이션 시작할때 지연시간 주는것
                       delay: TimeInterval(0),
                       //애니메이션 실행 옵션
                       options: options,
                       //실행할 애니메이션 내용
                       animations: { self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)},
                       // $0 == true라면 정상적으로 애니메이션이 종료했으면
                       completion: { if $0 == true {
            self.isSideBarShowing = true
            complete?()
        }})
        
    }
    // 사이드 바를 닫는다.
    func closeSideBar(_ complete: ( () -> Void)?) {
        
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME),
                       delay: TimeInterval(0),
                       options: options,
                       //x = 0 y = 0이 될때까지 이동하는 애니메이션 효과
                       animations: {
                        self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                       }, completion: { if $0 == true {
                        //완료되면 슈퍼뷰에서 사라지게 된다.
                        self.sideVC?.view.removeFromSuperview()
                        self.sideVC =  nil
                        self.isSideBarShowing = false
                        self.setShadowEffect(shadow: false, offset: 0)
                        complete?()
                       }})
    }

}

