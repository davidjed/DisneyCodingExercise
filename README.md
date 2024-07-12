# DisneyCodingExercise

This coding example displays an initial set of Marvel comic book characters on a tvOS interface; individual characters can be selected to view an initial set of comics associated with that character.

- App is written entirely in SwiftUI with MVVM pattern
- Async/Await is used primarily for API calls to the Marvel API; limited use of Combine is demonstrated in one back-end call, however, with Continuations to convert it to Async/Await
- AsyncImage used extensively to load images from URLs
- A single unit tests validates the ViewModel's logic to convert timestamp date Strings to display dates
- MD5 hash algorithm is used to sign requests to API. Since Marvel API is publicly available, key exposure was deemed acceptable
