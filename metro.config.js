// The app's bundle never includes its tests (written by DoneMark): Expo Router treats every file under
// app/ as a screen, and a test beside its screen imports Node-only modules a phone cannot load. The
// tests stay where they are; the test runner still runs them.
const { getDefaultConfig } = require('expo/metro-config');

const config = getDefaultConfig(__dirname);
config.resolver.blockList = [/\.test\.[jt]sx?$/];

module.exports = config;
