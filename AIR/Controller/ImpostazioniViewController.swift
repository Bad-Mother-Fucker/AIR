import UIKit

class ImpostazioniViewController: UIViewController {
    
    
    let rows = ["Rimuovi Pubblicità","Valuta AIR Orari","Disclaimer","Suggerimenti","Contatti"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        setColors()
    }
    
    func setColors(){
        self.navigationController?.navigationBar.tintColor = Colors.background
       self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.text]
        tableView.backgroundColor = Colors.background
        view.backgroundColor = Colors.background

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        scroll()
    }
    
    func scroll(){
        tableView.isScrollEnabled = true
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
        tableView.isScrollEnabled = false
    }
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(enableDarkMode), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disableDarkMode), name: .darkModeDisabled, object: nil)
    }

    
}

extension ImpostazioniViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0{
            let view = UIView(forAutoLayout: ())
            view.backgroundColor = .white
            view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "modNotte")!
            let uiswitch = cell.viewWithTag(1) as! UISwitch
            uiswitch.setOn(false, animated: true)
            if let title = cell.viewWithTag(2) as? UILabel {
                title.textColor = Colors.text
            }
            cell.contentView.backgroundColor = Colors.background

        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "tvcell")!
            let label = cell.viewWithTag(1) as! UILabel
            label.text = rows[indexPath.row]
            label.textColor = Colors.text
            cell.contentView.backgroundColor = Colors.background
            if let image = cell.viewWithTag(4) as? UIImageView{
                image.image = Bacheca.isDarkModeEnabled ? UIImage(named: "chevron dark") : UIImage(named: "chevron light")
            }
            
        }
      
        
        return cell
    }
    
    
}


extension ImpostazioniViewController: DarkModeDelegate{
    func didEnableDarkMode() {
        setColors()
    }
    
    func didDisableDarkMode() {
        setColors()
    }
    
   
}

//
