close all; clear all; clc;

pointSamples = [1:9 ceil(logspace(1, 3, 21))];

for idx = 1:3
    dataFile = sprintf('data/data%d.mat', idx);
    outputFile = sprintf('data/output_%d.png', idx);
    load(dataFile);

    dataSamples = dat(:, 1:2);
    dataLabels = dat(:, end);

    fig = figure();
    subplot(2, 1, 1);
    hold on;
    posIdx = dataLabels == 1;
    plot(dataSamples(posIdx, 1), dataSamples(posIdx, 2), 'r+');
    plot(dataSamples(~posIdx, 1), dataSamples(~posIdx, 2), 'bo');
    title('groundtruth');

    subplot(2, 1, 2);
    hold on;
    model = AdaboostClassifier(1000);
    model.train(dataSamples, dataLabels);
    predictions = model.test(dataSamples);
    posIdx = predictions == 1;
    plot(dataSamples(posIdx, 1), dataSamples(posIdx, 2), 'r+');
    plot(dataSamples(~posIdx, 1), dataSamples(~posIdx, 2), 'bo');
    title('classification');

    drawnow;
    if isvalid(fig)
        print(fig, '-dpng', outputFile);
    end

    errorRates = zeros(size(pointSamples));
    for iter = 1:numel(pointSamples)
        model = AdaboostClassifier(pointSamples(iter));
        model.train(dataSamples, dataLabels);
        predictions = model.test(dataSamples);
        errorRates(iter) = mean(predictions ~= dataLabels);
    end

    fig = figure();
    plot(pointSamples, errorRates, 'b-', 'LineWidth', 2);
    title(sprintf('Error on dataset #%d', idx));

    drawnow;
    if isvalid(fig)
        print(fig, '-dpng', sprintf('error_%d.png', idx));
    end
end
