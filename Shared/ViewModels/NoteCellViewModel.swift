//
//  NoteCellViewModel.swift
//  SquatchNotes
//
//  Created by Hutson on 3/31/21.
//

import Foundation
import Combine

class NoteCellViewModel: ObservableObject, Identifiable {
    
    @Published var noteRepo = NoteRepository()
    @Published var note: Note
    
    var id = ""
    
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(note: Note) {
        self.note = note
    
    $note
        .compactMap { note in
            note.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
        
    $note
        .dropFirst()
        .debounce(for: 0.5, scheduler: RunLoop.main)
        .sink { note in
            self.noteRepo.updateNote(note)
        }
        .store(in: &cancellables)
    }
}
