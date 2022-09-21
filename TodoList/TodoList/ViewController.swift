
import UIKit
import CoreData

enum PriorityLevel: Int64 {
    case level1 // 자동으로 0으로 배정
    case level2 // 1
    case level3 // 2
}

extension PriorityLevel {
    var color: UIColor {
        switch self {
        case .level1:
            return .green
        case .level2:
            return .orange
        case .level3:
            return .red
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    var todoList = [TodoList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To Do List"
        
       makeNavigationBar()
        
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        fetchData()
        todoTableView.reloadData()
    }
    
    func fetchData() { // 로컬 저장소에서 불러오기
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        let context = appdelegate.persistentContainer.viewContext
        
        do {
            self.todoList = try context.fetch(fetchRequest)
            
        } catch {
            print(error)
        }
        
    }
    

    func makeNavigationBar() {
        // 상단 버튼 추가
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        item.tintColor = .black
        self.navigationItem.rightBarButtonItem = item
        
        // 배경색 변경
        let barAppearance = UINavigationBarAppearance() // 기본 회색
        barAppearance.backgroundColor = .blue.withAlphaComponent(0.2)
        
        self.navigationController?.navigationBar.standardAppearance = barAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    @objc func addNewTodo() {
        let detailVC = TodoDetailViewController(nibName: "TodoDetailViewController", bundle: nil)
        detailVC.delegate = self
        self.present(detailVC, animated: true, completion: nil)
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        cell.topTitleLabel.text =  self.todoList[indexPath.row].title
        
        if let hasDate = self.todoList[indexPath.row].date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd hh:mm:ss"
            let dateString = formatter.string(from: hasDate)
            
            cell.dateLabel.text = dateString
        } else {
            cell.dateLabel.text = ""
        }
      
        let priority = todoList[indexPath.row].priorityLevel
        
        let priorityColor = PriorityLevel(rawValue: priority)?.color
        
        cell.priorityView.backgroundColor = priorityColor
        cell.priorityView.layer.cornerRadius = cell.priorityView.bounds.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = TodoDetailViewController(nibName: "TodoDetailViewController", bundle: nil)
        detailVC.delegate = self
        detailVC.selectedTodoList = todoList[indexPath.row]
        self.present(detailVC, animated: true, completion: nil)
    }
    
    
}

extension ViewController: TodoDetailViewControllerDelegate {
    func didFinishSaveData() {
        self.fetchData()
        self.todoTableView.reloadData()
    }
    
    
}



