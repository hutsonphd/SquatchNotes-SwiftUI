//
//  NoteListViewModel.swift
//  SquatchNotes
//
//  Created by Hutson on 3/31/21.
//

import Foundation
import Combine

class NoteListViewModel: ObservableObject {
    
    @Published var noteRepo = NoteRepository()
    @Published var noteCellViewModels = [NoteCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        noteRepo.getNotes()
        noteRepo.$notes
            .map { notes in
                notes.map { note in
                    NoteCellViewModel(note: note)
                }
            }
            .assign(to: \.noteCellViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addNote(note: Note) {
        noteRepo.addNote(note)
//        let noteVM = NoteCellViewModel(note: note)
//        self.noteCellViewModels.append(noteVM)
    }
}