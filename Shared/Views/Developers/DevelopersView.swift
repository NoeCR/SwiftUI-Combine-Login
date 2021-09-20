//
//  DevelopersView.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 20/09/2021.
//

import SwiftUI

struct DevelopersView: View {
    @StateObject var viewModel: DeveloperViewModel
    
    var body: some View {
        ScrollView(.vertical){
            if let boots = viewModel.bootcamps{
                ForEach(boots){ bootcamp in
                    Text("\(bootcamp.name)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.orange)
                        .bold()
                    
                    if let developers = viewModel.developers{
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(developers){ develop in
                                   DeveloperRowView(developer: develop)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct DevelopersView_Previews: PreviewProvider {
    static var previews: some View {
        DevelopersView(viewModel: DeveloperViewModel(testing: true))
    }
}


