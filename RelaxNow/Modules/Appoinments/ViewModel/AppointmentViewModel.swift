//
//  AppointmentViewModel.swift
//  RelaxNow
//
//  Created by Pritrum on 11/03/21.
//

class AppointmentViewModel: NSObject{
    
    private var doctorId: String?
    
    private var appointmentsList: [PatientData]?
    
    private var searchResults: [PatientData]?
    func setAppointmentList(appointments: [PatientData]){
        self.appointmentsList = appointments
        self.searchResults = appointments
    }
    
    var numberOfItems: Int{
        return searchResults?.count ?? 0
    }
    
    func appointment(atIndex index: Int) -> PatientData?{
        if searchResults?.count ?? 0 > index{
            return searchResults?[index] ?? nil
        }
        return nil
    }
    
    public func resetSearchResult(){
        self.searchResults = self.appointmentsList
    }
    func filterResultWith(text: String){
        let resultArr = self.appointmentsList?.filter({($0.rN_CUSTOMER_FIRST_NAME?.lowercased().contains(text.lowercased()) ?? false)})
        self.searchResults = resultArr
    }
    
    override init() {
        super.init()
    }
    
}
