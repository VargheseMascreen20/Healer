//
//  CardView.swift
//  Healer
//
//  Created by VARGHESE T MASCREEN on 06/01/23.
//

import SwiftUI

struct CardView: View {
    
    
    var body: some View {

                
        ScrollView {
            VStack {
                        VStack {
                                Image("doc1")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                                    .clipped()
                                    .shadow(radius: 5)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    
                                HStack {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Dr.John Lenny")
                                                .font(.title2)
                                                .fontWeight(.black)
                                                .foregroundColor(.primary)
                                            .lineLimit(3)
                                            Spacer()
                                            Button{}label: {
                                                Text("Consult").fontWeight(.bold)
                                            }
                                        }
                                        Text("Senior Consultant - Paediatric Cardiac Surgery")
                                            .font(.subheadline)
                                            .lineLimit(0)
                                            .foregroundColor(.secondary)
                                        
                                        Text("Cardiac Surgery")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .layoutPriority(100)
                                    
                                    Spacer()
                                }
                                .padding()
                            }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20,style: .continuous)).padding()
                        
                        
                        VStack {
                            Image("doc2")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .frame(minHeight: 300)
                                
                                .clipped()
                                
                                .shadow(radius: 5)
                                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                                
                            
                            
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Dr.Jeff Kimson")
                                            .font(.title2)
                                            .fontWeight(.black)
                                            .foregroundColor(.primary)
                                        .lineLimit(3)
                                        Spacer()
                                        Button{}label: {
                                            Text("Consult").fontWeight(.bold)
                                        }
                                    }
                                    Text("Surgical Oncology")
                                        .font(.subheadline)
                                        .lineLimit(0)
                                        .foregroundColor(.secondary)
                                    
                                    Text("MBBS, MS, MCh(Onco), FRCS Edinburgh")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .layoutPriority(1)
                                
                                Spacer()
                               
                            }
                            .padding()
                        }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20,style: .continuous))
                            
                            .padding()

                        VStack {
                            Image("doc3")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .clipped()
                                
                                .shadow(radius: 5)
                                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                                
                            
                            
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Dr.Amanda Lewis")
                                            .font(.title2)
                                            .fontWeight(.black)
                                            .foregroundColor(.primary)
                                        .lineLimit(3)
                                        Spacer()
                                        Button{}label: {
                                            Text("Consult").fontWeight(.bold)
                                        }
                                    }
                                    Text("Senior Consultant - Orthopaedic Surgery")
                                        .font(.subheadline)
                                        .lineLimit(0)
                                        .foregroundColor(.secondary)
                                    
                                    Text("Fellowship in Arthroplasty, DNB in Orthopaedics, D Ortho, MBBS")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .layoutPriority(100)
                                
                                Spacer()
                            }
                            .padding()
                        }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20,style: .continuous))
                            
                            .padding()


                        
            }
        }
               
    }
    
    
    
    private func addDocs(){
//        var doctorsList = [DoctorModel]()
//        doctorsList.append(DoctorModel(docName: "John", docDegree: "MBBS, MS, MCh(Onco), FRCS Edinburgh", docSpecialisation: "Surgical Oncology"))
//        doctorsList.append(DoctorModel(docName: "Jacob", docDegree: "MBBS, MS, MCh(Onco), FRCS Edinburgh", docSpecialisation: "Surgical Oncology"))
//        doctorsList.append(DoctorModel(docName: "Mat", docDegree: "MBBS, MS, MCh(Onco), FRCS Edinburgh", docSpecialisation: "Surgical Oncology"))
    }

}
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
