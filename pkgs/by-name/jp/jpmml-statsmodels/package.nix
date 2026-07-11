{
  lib,
  fetchFromGitHub,
  maven,
  jre_headless,
  makeBinaryWrapper,
  nix-update-script,
}:

let
  pname = "jpmml-statsmodels";
  version = "1.3.13";
in
maven.buildMavenPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "jpmml";
    repo = "jpmml-statsmodels";
    tag = version;
    hash = "sha256-QVJhJliHLST5MJV9OZVC+jTk8vV+bUu7i2IL6GSqK34=";
  };

  mvnHash = "sha256-AixWa1gLTgH3dfI2zEiFph4R1naq+7Nq7AA9nIOHfxY=";

  mvnParameters = "-B package";

  strictDeps = true;

  __structuredAttrs = true;

  nativeBuildInputs = [ makeBinaryWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/java" "$out/bin"
    install -Dm444 \
      pmml-statsmodels-example/target/pmml-statsmodels-example-executable-${version}.jar \
      "$out/share/java/jpmml-statsmodels.jar"

    makeBinaryWrapper ${jre_headless}/bin/java "$out/bin/jpmml-statsmodels" \
      --add-flags "-jar $out/share/java/jpmml-statsmodels.jar"

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Java library and CLI for converting StatsModels models to PMML";
    longDescription = ''
      JPMML-StatsModels converts Python StatsModels fitted model results
      (serialized as Pickle files) into the Predictive Model Markup Language
      (PMML) format, enabling deployment of those models on the JVM via
      JPMML-Evaluator.

      Supported model families include OLS/WLS/QuantReg linear regression,
      GLMs (Binomial, Gaussian, Poisson), Logit, MNLogit, Poisson count
      models, OrderedModel, and ARIMA time-series models.
    '';
    homepage = "https://github.com/jpmml/jpmml-statsmodels";
    changelog = "https://github.com/jpmml/jpmml-statsmodels/releases/tag/${version}";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ b-rodrigues ];
    mainProgram = "jpmml-statsmodels";
    platforms = lib.platforms.all;
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
  };
}
