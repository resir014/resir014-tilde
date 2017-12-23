/* eslint-disable global-require, import/no-extraneous-dependencies */

exports.paths = {
  public: 'static',
  watched: ['app', 'vendor'],
};

exports.files = {
  javascripts: {
    joinTo: {
      'javascripts/app.js': /^app/,
      'javascripts/vendor.js': /(^bower_components|vendor)[\\/]/,
    },
  },
  stylesheets: {
    joinTo: {
      'stylesheets/app.css': 'app/styles/app.scss',
    },
  },
};

exports.plugins = {
  babel: {
    presets: [
      ['env', {
        targets: {
          browsers: ['last 2 versions', 'safari >= 7'],
        },
      }],
    ],
  },
  postcss: {
    processors: [
      require('autoprefixer'),
      require('cssnano'),
    ],
  },
};
