//
//  TripRowView.swift
//  journeypin
//
//  Created by mateusz on 15/06/2025.
//
import SwiftUI



struct TripRowView: View {
    @ObservedObject var trip: Trip
    let formatter: DateFormatter
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.6)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "map.fill")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.medium)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(trip.tripname ?? "Podróż bez nazwy")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                if let date = trip.date {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.caption)
                            .foregroundColor(.blue)
                        
                        Text(date, formatter: formatter)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                if let notes = trip.notes, !notes.isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: "note.text")
                            .font(.caption)
                            .foregroundColor(.orange)
                        
                        Text(notes)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                
                if let pins = trip.trippin {
                    HStack(spacing: 4) {
                        Image(systemName: "pin.fill")
                            .font(.caption)
                            .foregroundColor(.red)
                        
                        Text("\(pins.count) \(pins.count == 1 ? "pinezka" : "pinezki")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 0.5)
        )
    }
}
