
import UIKit
import CoreData

protocol TodoDetailViewControllerDelegate: AnyObject {
    func didFinishSaveData()
}

class TodoDetailViewController: UIViewController {
    
    weak var delegate: TodoDetailViewControllerDelegate?

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var lowButton: UIButton!
    
    @IBOutlet weak var normalButton: UIButton!
    
    @IBOutlet weak var highButton: UIButton!
    
    var selectedTodoList: TodoList?
    
    var priority: PriorityLevel?
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let hasData = selectedTodoList {
            self.titleTextField.text = hasData.title
            self.priority = PriorityLevel(rawValue: hasData.priorityLevel)
            
            makePriorityButtonDesign()
            
            saveButton.setTitle("Update", for: .normal)
            
            deleteButton.isHidden = false
        } else {
            saveButton.setTitle("Save", for: .normal)
            deleteButton.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        normalButton.layer.cornerRadius = normalButton.bounds.height / 2
        highButton.layer.cornerRadius = highButton.bounds.height / 2
    }


    
    @IBAction func setPriority(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            priority = .level1
        case 2:
            priority = .level2
        case 3:
            priority = .level3
        default:
            break
        }
        
        makePriorityButtonDesign()
    }
    
    
    func makePriorityButtonDesign() {
        lowButton.backgroundColor = .clear
        normalButton.backgroundColor = .clear
        highButton.backgroundColor = .clear
        
        switch self.priority {
        case .level1:
            lowButton.backgroundColor = priority?.color
        case .level2:
            normalButton.backgroundColor = priority?.color
        case .level3:
            highButton.backgroundColor = priority?.color
        default:
            break
        }
    }
    
    
    
    @IBAction func saveOrUpdateTodo(_ sender: Any) {
        if selectedTodoList != nil {
            updateTodo()
        } else {
            saveTodo()
        }
        delegate?.didFinishSaveData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveTodo() { // 로컬 저장소에 저장
        let context = appdelegate.persistentContainer.viewContext
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else {
            return
        }
        
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else {
            return
        }
        // 데이터 객체의 뼈대를 가져오는 과정
        
        object.title = self.titleTextField.text
        object.date = Date()
        object.uuid = UUID()
        object.priorityLevel = priority?.rawValue ?? PriorityLevel.level1.rawValue
     
        appdelegate.saveContext()
    }
    
    func updateTodo() {
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        guard let hasData = selectedTodoList else {
            return
        }
        
        guard let hasUUID = hasData.uuid else {
            return
        }
        
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        let context = appdelegate.persistentContainer.viewContext
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            
            loadedData.first?.title = titleTextField.text
            loadedData.first?.date = Date()
            
            guard let hasPriorityLevel = loadedData.first?.priorityLevel else {
                return
            }
            
            loadedData.first?.priorityLevel = self.priority?.rawValue ?? hasPriorityLevel
            
        } catch {
            print(error)
        }
       
        appdelegate.saveContext()
    }
    
    
    @IBAction func deleteTodo(_sender: UIButton) {
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        guard let hasData = selectedTodoList else {
            return
        }
        
        guard let hasUUID = hasData.uuid else {
            return
        }
        
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        let context = appdelegate.persistentContainer.viewContext
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            
            if let loadFirstData = loadedData.first {
                context.delete(loadFirstData) // 삭제
                appdelegate.saveContext()   // 커밋 역할.
            }
        
        } catch {
            print(error)
        }
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true, completion: nil)
    }
}
