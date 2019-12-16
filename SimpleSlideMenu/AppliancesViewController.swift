import UIKit

class AppliancesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var appliancesTableView: UITableView!
    
    let myTitle = ["", "Appliances", "Scripts", "Settings", "About"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        appliancesTableView.delegate = self
        appliancesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appliancesTableView.dequeueReusableCell(withIdentifier: "MenuCell") as! AppliancesTableViewCell
        //cell.labelText.text = myTitle[indexPath.row]
        return cell
    }

}
