//
//  GithubSignupViewModel.swift
//  rxStudy
//
//  Created by 古賀貴伍社用 on 2023/03/05.
//

import RxSwift
import RxCocoa

class GithubSignupViewModel {

    let valigatedUsername: Driver<ValidationResult>
    let valigatedPassword: Driver<ValidationResult>
    let validatedRepeated: Driver<ValidationResult>


    init(
        input: (
            username: Driver<String>,
            password: Driver<String>,
            repeatedPassword: Driver<String>,
            loginTaps: Driver<()>
        ),
        dependency: (
            API: GitHubAPI,
            validationService:GitHubValidationService
        )
    ){
        let API = dependency.API
        let validationService = dependency.validationService


        valigatedUsername = input.username
            .flatMapLatest { username in
                return validationService.validateUsername(username)
                    .asDriver(onErrorJustReturn: .failed(message: "Error contacting server"))
            }

        valigatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
            }

        validatedRepeated = Driver.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)


    }


}
