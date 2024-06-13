import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_tutorial/weather_app/bloc/weather_bloc.dart';
import 'package:bloc_tutorial/weather_app/data/repository/weather_repository.dart';
import 'package:bloc_tutorial/weather_app/models/weather_model.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockWeatherModel extends Mock implements WeatherModel {}

void main() {
  group('WeatherBloc', () {
    late WeatherBloc weatherBloc;
    late MockWeatherRepository mockWeatherRepository;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      weatherBloc = WeatherBloc(mockWeatherRepository);
    });

    tearDown(() {
      weatherBloc.close();
    });

    test('initial state is WeatherInitial', () {
      expect(weatherBloc.state, WeatherInitial());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherSuccess] when WeatherFetched is added and weather is fetched successfully',
      build: () {
        when(() => mockWeatherRepository.getCurrentWeather())
            .thenAnswer((_) async => MockWeatherModel());
        return weatherBloc;
      },
      act: (bloc) => bloc.add(WeatherFetched()),
      expect: () => [
        WeatherLoading(),
        isA<WeatherSuccess>(),
      ],
      verify: (_) {
        verify(() => mockWeatherRepository.getCurrentWeather()).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherFailure] when WeatherFetched is added and fetching weather fails',
      build: () {
        when(() => mockWeatherRepository.getCurrentWeather())
            .thenThrow(Exception('Failed to fetch weather'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(WeatherFetched()),
      expect: () => [
        WeatherLoading(),
        isA<WeatherFailure>(),
      ],
      verify: (_) {
        verify(() => mockWeatherRepository.getCurrentWeather()).called(1);
      },
    );
  });
}
