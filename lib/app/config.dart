class ApiConfig {
  const ApiConfig({required this.apiBaseUrl, required this.apiKey});

  final String apiBaseUrl;
  final String apiKey;

  ApiConfig copyWith({String? apiBaseUrl, String? apiKey}) {
    return ApiConfig(
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      apiKey: apiKey ?? this.apiKey,
    );
  }
}

const defaultApiConfig = ApiConfig(
  apiBaseUrl: 'https://n8n.zeitgewinn.ai/webhook-test/78dc69de-06a3-491e-a19c-715d7a3f15d3',
  apiKey: 'replace-with-api-key',
);
