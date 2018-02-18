module ContactsList exposing (..)

import Html exposing (Html, a, div, input, h1, text, table, tbody, thead, tr, th, td)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onInput)
import Http
import Json.Decode as Decode


-- MODEL


type alias Contact =
    { address : String
    , id : String
    , name : String
    }


type ContactsFilter
    = NoFilter
    | FilteredText String


type alias Model =
    { contacts : List Contact
    , filteredContacts : List Contact
    , contactsFilter : ContactsFilter
    }



-- JSON


contactsDecoder : Decode.Decoder (List Contact)
contactsDecoder =
    Decode.list
        (Decode.map3 Contact
            (Decode.field "address" Decode.string)
            (Decode.map (\id -> toString id) (Decode.field "id" Decode.int))
            (Decode.field "name" Decode.string)
        )



-- INIT


loadContacts : Cmd Msg
loadContacts =
    let
        request =
            Http.get "/contacts.json" contactsDecoder
    in
        Http.send LoadContacts request


init : ( Model, Cmd Msg )
init =
    ( { contacts = []
      , filteredContacts = []
      , contactsFilter = NoFilter
      }
    , loadContacts
    )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "mb-6" ]
        [ div [ class "py-2 pr-2" ]
            [ input [ class "py-3 px-2 w-full", onInput OnFilterContacts ] []
            ]
        , table [ class "table-light" ]
            [ thead []
                [ tr []
                    [ th [] [ text "Name" ]
                    , th [] [ text "Address" ]
                    ]
                ]
            , tbody [] (List.map contactRow model.filteredContacts)
            ]
        ]


contactRow : Contact -> Html Msg
contactRow contact =
    tr []
        [ td [] [ a [ href ("/contacts/" ++ contact.id) ] [ text contact.name ] ]
        , td [] [ text contact.address ]
        ]



-- MSG


type Msg
    = LoadContacts (Result Http.Error (List Contact))
    | OnFilterContacts String
    | None



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        LoadContacts (Ok contacts) ->
            ( { model | contacts = contacts, filteredContacts = contacts }, Cmd.none )

        OnFilterContacts inputText ->
            let
                filteredContacts =
                    List.filter
                        (\contact -> String.contains (String.toLower inputText) (String.toLower contact.name))
                        model.contacts
            in
                ( { model | filteredContacts = filteredContacts }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
