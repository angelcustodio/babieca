cluster = require('cluster')

# Code to run if we're in the master process
if (cluster.isMaster)
    # Count the machine's CPUs
    cpuCount = require('os').cpus().length;

    # Create a worker for each CPU
    for i in [0...cpuCount]
        cluster.fork();
else

  express = require 'express'

  app = express()

  # Load models
  require('./models/position')
  require('./models/heartbeat')


  # Load config
  require('../config/')(app)

  # Load routes
  require('./routes/')(app)

  # Start server
  app.listen app.get('port'), ->

    console.info "                                                       "
    console.info "                           N                           "
    console.info "                      N   NmN   N                      "
    console.info "                       NNNNmNNNN                       "
    console.info "                    N                                  "
    console.info "                    NmNNNNNNNN                         "
    console.info "                     mmmmmmmmmmmmNNN                   "
    console.info "                   NmmmmmmmmmmmmmmmmN                  "
    console.info "                  mmmmmmmmmmmmmmmmmmmmmN               "
    console.info "                 Nmmmmmmmmmmmmmmmmmmmmmm               "
    console.info "               NmmmmmmmmmmmmmmmmmmmmmmmmmN             "
    console.info "             Nmmmmmmmmmmmmmmmmmmmmmmmmmmmmm            "
    console.info "            mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmNN           "
    console.info "           NmmmmmmmmNN Nmmmmmmmmmmmmmmmmmmm            "
    console.info "            Nmmmmm    NmmmmmmmmmmmmmmmmmmmN            "
    console.info "                     NmmmmmmmmmmmmmmmmmmmmN NN         "
    console.info "                    NmmmmmmmmmmmmmmmmmmmmmmmN          "
    console.info "                    mmmmmmmmmmmmmmmmmmmmmmmmmN         "
    console.info "                   mmmmmmmmmmmmmmmmmmmmmmmNN           "
    console.info "                 NmmmmmmmmmmmmmmmmmmmmmmN              "
    console.info "                NmmmmmmmmmmNNN                         "
    console.info "                mmmmmmmmmN                             "
    console.info "                mmmmmmNN                               "
    console.info "                NNNN                                   "
    console.info "                                                       "

    console.info '✔ Babieca server running on port %d in %s mode',
      app.get('port'),
      app.settings.env
