import SwiftUI

struct TaskPage: View {
    @State private var Timer = true
    @State private var Task = false
    var body: some View{
            if Timer {
                VStack{
                    TimerPage()
                    HStack{
                        Button("Timer"){}.buttonStyle(.bordered).bold()
                        Button("Tasks"){
                            Timer.toggle()
                            Task.toggle()
                        }.buttonStyle(.bordered)
                    }
                    .padding(.top, 7)
                    }
            }else if Task{
                VStack{
                    Spacer()
                    listView()
                    HStack{
                        Button("Timer"){
                            Timer.toggle()
                            Task.toggle()
                        }.buttonStyle(.bordered)
                        Button("Tasks"){}.buttonStyle(.bordered).bold()
                    }
                }
            }
            }
        
    }

struct listView: View{

    @EnvironmentObject var listViewModel: ListViewModel

    var body: some View{
        List{
            ForEach(listViewModel.items) { item in
                ListRowView(item: item)
                    .onTapGesture {
                        withAnimation(.linear){
                            listViewModel.updateItem(item: item)
                        }
                    }
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
        }.listStyle(PlainListStyle())
            .navigationTitle("Tasks")
            .navigationBarItems(
                leading: EditButton(),
                trailing: NavigationLink("Add", destination: AddView())
            )
            .background(CustomColor.myColor)
    }
    
}


struct ListRowView: View{
    let item: Tasks
    
    var body: some View{
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical,8)
    }

}

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    var body: some View{
        ScrollView{
            VStack{
                TextField("Type Task here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(.lightGray))
                    .cornerRadius(10)
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased()).foregroundColor(.white).font(.headline).frame(height:55).frame(maxWidth: .infinity).background(Color.accentColor).cornerRadius(10)
                })
            }
        }.padding(14)
        .navigationTitle("Add a task")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed(){
        if textIsAppropriate(){
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool{
        if textFieldText.count < 3{
            alertTitle = "your new task must be 3 characters long!!"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert{
        return Alert(title: Text(alertTitle))
    }
}


struct Tasks: Identifiable{
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool){
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updatecompleted() -> Tasks{
        return Tasks(id: id, title: title, isCompleted: !isCompleted)
    }
}
