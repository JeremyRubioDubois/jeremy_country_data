# Jeremy Country Data

Jeremy Country Data is a Flutter application that allows users to:

- Display a list of countries worldwide
- View a dashboard
- Access details about a country when clicking on a list item

## APIs Used

- **Country State City API**: [https://countrystatecity.in/](https://countrystatecity.in/)
- **OpenAI API**: [https://platform.openai.com/](https://platform.openai.com/)
- **Pexels API**: [https://www.pexels.com/api/](https://www.pexels.com/api/)

## Environment Variables

This project requires an `.env` file to run locally. The `.env` file contains sensitive API keys that the app needs to interact with external services. For security reasons, this file is not included in the repository.

You can contact me to get the `.env` file.

Alternatively, create a `.env` file manually and add the required variables.

Add the file to the root directory of the project (same level as `pubspec.yaml`).

The `.env` file should include the following keys:

```txt
COUNTRY_STATE_CITY_API_KEY=your_country_state_city_api_key_here
OPENAI_API_KEY=your_openai_api_key_here
PEXELS_API_KEY=your_pexels_api_key_here
```
