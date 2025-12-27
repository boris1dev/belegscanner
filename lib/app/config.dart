class ApiConfig {
  const ApiConfig({required this.baseUrl, required this.apiKey});

  final String baseUrl;
  final String apiKey;
}

const defaultApiConfig = ApiConfig(
  baseUrl: 'https://api.example.com/uploads',
  apiKey: 'replace-with-api-key',
);
