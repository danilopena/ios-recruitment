//
//  Languages.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 25/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

enum Currencies: String {
    
    case CAD = "CAD"
    case HKD = "HKD"
    case ISK = "ISK"
    case PHP = "PHP"
    case DKK = "DKK"
    case HUF = "HUF"
    case CZK = "CZK"
    case AUD = "AUD"
    case RON = "RON"
    case SEK = "SEK"
    case IDR = "IDR"
    case INR = "INR"
    case BRL = "BRL"
    case RUB = "RUB"
    case HRK = "HRK"
    case JPY = "JPY"
    case THB = "THB"
    case CHF = "CHF"
    case SGD = "SGD"
    case PLN = "PLN"
    case BGN = "BGN"
    case TRY = "TRY"
    case CNY = "CNY"
    case NOK = "NOK"
    case NZD = "NZD"
    case ZAR = "ZAR"
    case MXN = "MXN"
    case USD = "USD"
    case ILS = "ILS"
    case GBP = "GBP"
    case KRW = "KRW"
    case MYR = "MYR"
    case EUR = "EUR"
    case UNK = ""
 
    func nameOfCountryOrCity() -> String {
        switch self {
        case .CAD:
            return Localizable.canada
        case .HKD:
            return Localizable.hongKong
        case .ISK:
            return Localizable.iceland
        case .PHP:
            return Localizable.philippine
        case .DKK:
            return Localizable.denmark
        case .HUF:
            return Localizable.hungary
        case .CZK:
            return Localizable.czechRepublic
        case .AUD:
            return Localizable.australia
        case .RON:
            return Localizable.romania
        case .SEK:
            return Localizable.sweden
        case .IDR:
            return Localizable.indonesia
        case .INR:
            return Localizable.india
        case .BRL:
            return Localizable.brazil
        case .RUB:
            return Localizable.russia
        case .HRK:
            return Localizable.croatia
        case .JPY:
            return Localizable.japan
        case .THB:
            return Localizable.thailand
        case .CHF:
            return Localizable.switzerland
        case .SGD:
            return Localizable.singapore
        case .PLN:
            return Localizable.poland
        case .BGN:
            return Localizable.bulgaria
        case .TRY:
            return Localizable.turkey
        case .CNY:
            return Localizable.china
        case .NOK:
            return Localizable.norway
        case .NZD:
            return Localizable.newzealand
        case .ZAR:
            return Localizable.southAfrica
        case .USD:
            return Localizable.eua
        case .MXN:
            return Localizable.mexico
        case .ILS:
            return Localizable.isarel
        case .GBP:
            return Localizable.unitedKingdom
        case .KRW:
            return Localizable.southKorea
        case .MYR:
            return Localizable.malaysia
        case .EUR:
            return Localizable.euroZone
        case .UNK:
            return Localizable.unknown
        }
    }
    
    func returnCurrencyBasedOnLanguage() {
//        CAD = en_CA  Canada
//        HKD = en_HK  Hong Kong
//        ISK = is_IS  Islândia
//        PHP = en_PH | fil_PH Philipine
//        DKK = da_DK  Dinamarca
//        HUF = hu_HU | hu  Hungria
//        CZK = cs_CZ  República Checa
//        AUD = en_AU  Australia
//        RON = ro_RO | ro  Romenia
//        SEK = fr_CH | de_CH | it_CH | rm_CH Suecia
//        IDR = id_ID | id Indonésia
//
//        INR = bn_IN | bo_IN | ta_IN | te_IN | kn_IN | gu_IN | as_IN | ne_IN | ur_IN | pa_Guru_IN | en_IN | or_IN | kok_IN | hi_IN | ml_IN | mr_IN India
//
//        BRL = pt_BR Brasil
//        RUB = ru_MD | ru | ru_UA | ru_RU Russia
//        HRK = hr_HR | hr Croacia
//        JPY = ja | ja_JP Japao
//        THB = th_TH Tailandia
//        CHF = gsw_CH | gsw Suíça e Lichenstain
//        SGD = zh_Hans_SG | en_SG Singapura
//        PLN = pl_PL Polonia
//        BGN = bg_BG | bg Bulgaria
//        TRY = tr_TR | tr Turquia
//        CNY = zh_Hant_HK | zh_Hans_HK | zh_Hans_CN | bo_CN | zh_Hant_MO | zh_Hans_MO | ii_CN China Popular Republic
//        NOK = nb_NO | nn_NO Noruega
//        NZD = en_NZ Nova zelândia
//        ZAR = af_ZA | en_ZA | zu_ZA Africa do Sul
//        USD = en_US_POSIX | haw_US | en_US | es_US | chr_US EUA
//        MXN = es_MX México
//        ILS = he_IL Israel
//        GBP = cy_GB | gv_GB | en_GB | kw_GB Reino Unido
//        KRW = ko_KR | ko Coreia do Sul
//        MYR = ms_MY | ms Malásia
    }
}

extension Currencies {
    private enum Localizable {
        static let canada = "canada.name"
        static let hongKong = "hongkong.name"
        static let iceland = "iceland.name"
        static let philippine = "philippine.name"
        static let denmark = "denmark.name"
        static let hungary = "hungary.name"
        static let czechRepublic = "czechrepulic.name"
        static let australia = "australia.name"
        static let romania = "romania.name"
        static let sweden = "sweden.name"
        static let indonesia = "indonesia.name"
        static let india = "india.name"
        static let brazil = "brazil.name"
        static let russia = "russia.name"
        static let croatia = "croatia.name"
        static let japan = "japan.name"
        static let thailand = "thailand.name"
        static let switzerland = "switzerland.name"
        static let singapore = "singapore.name"
        static let poland = "poland.name"
        static let bulgaria = "bulgaria.name"
        static let turkey = "turkey.name"
        static let china = "china.name"
        static let norway = "nowway.name"
        static let newzealand = "newzealand.name"
        static let southAfrica = "southafrica.name"
        static let eua = "eua.name"
        static let mexico = "mexico.name"
        static let isarel = "israel.name"
        static let unitedKingdom = "unitedkingdom.name"
        static let southKorea = "southkorea.name"
        static let malaysia = "malaysia.name"
        static let euroZone = "eurozone.name"
        static let unknown = "unknownCurrency"
    }
}
