//
//  ViewController.swift
//  SHProfile


import UIKit

var dropDownY: CGFloat = 90.0
var dropDownMainY: CGFloat = 50.0
var dropDownX: CGFloat = 0.0

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var topProfileView: profileView!
    @IBOutlet weak var topViewWidth: NSLayoutConstraint!
    @IBOutlet weak var profileImageOutline: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageBottom: NSLayoutConstraint!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var coverImage: coverView!
    @IBOutlet weak var coverOverlay: coverMask!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var followWidth: NSLayoutConstraint!
    @IBOutlet weak var repositoryTableView: UITableView!
    
    
    var panGestureRecognizer = UIPanGestureRecognizer()
    var repoDictArray = [
        ["title":"SHTransition","desc":"SHTransition is a Library for the transition between the views in a viewcontroller","lang":"•Swift"],
        ["title":"SHSnakbarView","desc":"SHSnackbarView is a sample project for toast view like a snakbarview","lang":"•Swift"],
        ["title":"SHPopup","desc":"SA lightweight library for popup view","lang":"•Swift"],
        ["title":"SHSeatSelection","desc":"Sample project of seat selection using collectionview","lang":"•Swift"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dropDownX = view.bounds.size.width/2
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        topProfileView.addGestureRecognizer(panGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupUI(){
        
        profileName.text = "iamShezad"
        profileImageOutline.layer.cornerRadius = 50
        profileImageOutline.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 45
        profileImage.layer.masksToBounds = true
        profileImage.image = #imageLiteral(resourceName: "pro")
        coverImage.layer.opacity = 0
        coverOverlay.layer.opacity = 0
        coverImage.image = #imageLiteral(resourceName: "cover")
        followButton.layer.cornerRadius = 15
        followButton.layer.masksToBounds = true
    }
    
    @objc func draggedView(_ panGesture: UIPanGestureRecognizer) {
        let touchPosition = panGesture.location(in: self.view)
        if panGesture.state == UIGestureRecognizerState.changed{

            if touchPosition.y > 100 {
                dropDownX = touchPosition.x
                dropDownY = touchPosition.y
                dropDownMainY = touchPosition.y - 40
                self.coverOverlay.layer.opacity = 0.0
                self.coverImage.layer.opacity = 0.0
                UIView.animate(withDuration: 0.4, animations: {
            
                })
                topViewWidth.constant = touchPosition.y
                topProfileView.setNeedsDisplay()
                self.view.layoutIfNeeded()
            }
            
        }
        if panGesture.state == UIGestureRecognizerState.ended{
            if touchPosition.y > view.frame.height/2 {
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    dropDownX = self.view.frame.width/2
                    dropDownY = self.view.frame.height/2
                    dropDownMainY = (self.view.frame.height/2) - 40
                    self.profileImageBottom.constant = 15
                    self.topViewWidth.constant = (self.view.frame.height/2) + 10
                    self.topProfileView.setNeedsDisplay()
                    self.view.layoutIfNeeded()
                }, completion: { (success) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.coverOverlay.layer.opacity = 1.0
                        self.coverImage.layer.opacity = 1.0
                    })
        
                })
            }else {
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    dropDownX = self.view.bounds.size.width/2
                    dropDownY = 90.0
                    dropDownMainY = 50
                    self.coverOverlay.layer.opacity = 0.0
                    self.coverImage.layer.opacity = 0.0
                    self.profileImageBottom.constant = 40
                    self.topViewWidth.constant = 100.0
                    self.topProfileView.setNeedsDisplay()
                    self.view.layoutIfNeeded()
                }, completion: { (success) in

                })
            }
        }
    }
    
    @IBAction func followAction(_ sender: UIButton) {
        if self.followButton.title(for: .normal) != "unfollow"{
            UIView.animate(withDuration: 0.5, animations: {
                self.followWidth.constant = 30
                self.followButton.setTitle("", for: .normal)
                self.view.layoutIfNeeded()
            }) { (animated) in
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.followWidth.constant = 140
                    self.followButton.setTitle("unfollow", for: .normal)
                    self.view.layoutIfNeeded()
                }, completion: { (success) in
              
                })
            }
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.followWidth.constant = 30
                self.followButton.setTitle("", for: .normal)
                self.view.layoutIfNeeded()
            }) { (animated) in
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.followWidth.constant = 140
                    self.followButton.setTitle("follow", for: .normal)
                    self.view.layoutIfNeeded()
                }, completion: { (success) in
                    
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return repoDictArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! SHRepoCell
        cell.repoTitle.text = repoDictArray[indexPath.row]["title"]
        cell.repoDesc.text = repoDictArray[indexPath.row]["desc"]
        cell.repoLang.text = repoDictArray[indexPath.row]["lang"]
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row % 2) == 0
        {
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
            cell.layer.transform = transform
            UIView.animate(withDuration: 1.0, animations: {
                cell.alpha = 1.0
                cell.layer.transform = CATransform3DIdentity
            })
        }else{
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, 250, 0, 0)
            cell.layer.transform = transform
            UIView.animate(withDuration: 1.0, animations: {
                cell.alpha = 1.0
                cell.layer.transform = CATransform3DIdentity
            })
        }
    }

}

class profileView: UIView {
    
    var bezierPath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        drawpath()
    }
    func drawpath() {
        
        bezierPath = menuPath()
        UIColor(red: 243.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0).set()
        bezierPath.fill()
    }
    func menuPath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: 0.0))
        bezierPath.addLine(to: CGPoint(x:0.0, y: dropDownMainY))
        bezierPath.addCurve(to: CGPoint(x:self.bounds.size.width, y: dropDownMainY), controlPoint1: CGPoint(x: dropDownX, y: dropDownY), controlPoint2: CGPoint(x: dropDownX, y: dropDownY))
        bezierPath.addLine(to: CGPoint(x: self.bounds.size.width, y: 0.0))
        return bezierPath
    }
    
}

class coverMask: UIView {
    
    var bezierPath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        drawpath()
    }
    func drawpath() {
        bezierPath = menuPath()
    }
    func menuPath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: 0.0))
        bezierPath.addLine(to: CGPoint(x:0.0, y: dropDownMainY))
        bezierPath.addCurve(to: CGPoint(x:self.bounds.size.width, y: dropDownMainY), controlPoint1: CGPoint(x: dropDownX, y: dropDownY), controlPoint2: CGPoint(x: dropDownX, y: dropDownY))
        bezierPath.addLine(to: CGPoint(x: self.bounds.size.width, y: 0.0))
        return bezierPath
    }
    
}

class coverView: UIImageView{
    var bezierPath = UIBezierPath()
    
    override func setNeedsLayout() {
        bezierPath = menuPath()
        bezierPath.reversing()
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
        self.layer.masksToBounds = true
    }
    
    func menuPath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: 0.0))
        bezierPath.addLine(to: CGPoint(x:0.0, y: dropDownMainY))
        bezierPath.addCurve(to: CGPoint(x:self.bounds.size.width, y: dropDownMainY), controlPoint1: CGPoint(x: dropDownX, y: dropDownY), controlPoint2: CGPoint(x: dropDownX, y: dropDownY))
        bezierPath.addLine(to: CGPoint(x: self.bounds.size.width, y: 0.0))
        return bezierPath
    }
}

class CircleView: UIView
{
    var circleLayer: CAShapeLayer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear

        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: CGFloat((Double.pi * 3.0)/2), endAngle: CGFloat(((Double.pi * 3.0)/2)-6.5), clockwise: false)

        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 3.0;
        circleLayer.strokeEnd = 0.0
        
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    func animateCircle(duration: TimeInterval) {
      
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.strokeEnd = 1.0
        CATransaction.setCompletionBlock {
            print("animation complete")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "circle"), object:nil)
        }
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
        CATransaction.commit()
    }
}
