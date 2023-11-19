const args = require('yargs').argv;
const jsonexport = require('jsonexport');
var fs = require('fs');
var async = require('async');
var newman = require('newman');

jsonToCsvConvert = function(jsonData, filepath)
{
	var option = { includeHeaders: (iterationCount == 1) ? true : false };

	if (iterationCount == 1 && fs.existsSync(filepath)) {
		fs.unlinkSync(filepath)
	}

	jsonexport(jsonData, option, function (err, csv) {
		if (err) console.log(err);
		csv += "\n";
		fs.appendFile(filepath, csv, function (err) {
			if (err) throw err;
			console.log('file saved');
		});
	});
}

var iterationCount = 0;
var tasks = [];
var virtualUsers = args.virtualUsers;
var environmentFile = args.environmentFile;
var collectionFile = args.collectionFile;
var accessToken = args.accessToken;
var artifactStagingDirectory = args.artifactStagingDirectory;

parallelCollectionRun = function (options) {
	newman.run(options)
		.on('beforeDone', (error, data) => {
			if (error) {
				console.log(error);
			}

			iterationCount++;
			var individualOutput = data.summary.run.executions.map((element) => (
				{
					iteration: iterationCount,
					name: element.item.name, method: element.item.method, responseCode: element.response.code, responseStatus: element.response.status, responseSize: element.response.responseSize, responseTime: element.response.responseTime
				}
			));
			var timings = data.summary.run.timings;
			var stats = data.summary.run.stats;
			var summaryOutput =
				[{
					iteration: iterationCount,
					responseAverage: timings.responseAverage, responseMax: timings.responseMax, responseMin: timings.responseMin, responseSd: timings.responseSd,
					iterationExecuted:  stats.iterations.total, iterationFailed:  stats.iterations.failed,
					requestsExecuted:  stats.requests.total, requestsFailed:  stats.requests.failed,
					scriptsExecuted:  stats.scripts.total, scriptsFailed:  stats.scripts.failed,
					prerequestScriptsExecuted:  stats.prerequestScripts.total, prerequestScriptsFailed:  stats.prerequestScripts.failed,
					assertionsExecuted: stats.assertions.total, assertionsFailed: stats.assertions.failed,
					totalDataReceived: data.summary.run.transfers.responseTotal
				}];

			jsonToCsvConvert(individualOutput, `${artifactStagingDirectory}/detail_report.csv`);
			jsonToCsvConvert(summaryOutput, `${artifactStagingDirectory}/summary_report.csv`);
	});
}

for (let i = 0; i < virtualUsers; i++) {

	var options = {
		environment: environmentFile,
		collection: collectionFile,
		envVar: [
			{ "key":"token_type", "value":"Bearer" },
			{ "key":"access_token", "value":`${accessToken}`}
		],
		insecure: true,
		reporters: ['cli']
	};

	tasks.push(() => parallelCollectionRun(options));
}

// Runs the Postman sample collection based on passing argument (virtualUsers), in parallel.
async.parallel(tasks,

	/**
	 * The
	 *
	 * @param {?Error} err - An Error instance / null that determines whether or not the parallel collection run
	 * succeeded.
	 * @param {Array} results - An array of collection run summary objects.
	 */
	function (err, results) {
		err && console.error(err);

		results.forEach(function (result) {
			var failures = result.run.failures;
			console.info(failures.length ? JSON.stringify(failures.failures, null, 2) :	`${result.collection.name} ran successfully.`);
		});
	});
