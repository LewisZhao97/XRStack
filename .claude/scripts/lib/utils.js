/**
 * Shared utilities for Claude Code session scripts.
 * Provides cross-platform path resolution and file I/O helpers.
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

/**
 * Get the Claude home directory (~/.claude)
 * @returns {string} Path to ~/.claude
 */
function getClaudeDir() {
  return path.join(os.homedir(), '.claude');
}

/**
 * Get the canonical sessions directory (~/.claude/session-data/)
 * @returns {string} Path to sessions directory
 */
function getSessionsDir() {
  return path.join(getClaudeDir(), 'session-data');
}

/**
 * Get all directories to search for session files.
 * Primary: ~/.claude/session-data/
 * Legacy:  ~/.claude/sessions/
 * @returns {string[]} Array of directory paths
 */
function getSessionSearchDirs() {
  return [
    path.join(getClaudeDir(), 'session-data'),
    path.join(getClaudeDir(), 'sessions')
  ];
}

/**
 * Ensure a directory exists, creating it recursively if needed.
 * @param {string} dirPath - Directory path to ensure
 */
function ensureDir(dirPath) {
  if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath, { recursive: true });
  }
}

/**
 * Read a file and return its content as a string, or null on failure.
 * @param {string} filePath - Path to file
 * @returns {string|null} File content or null
 */
function readFile(filePath) {
  try {
    return fs.readFileSync(filePath, 'utf8');
  } catch {
    return null;
  }
}

/**
 * Log a message to stderr (non-blocking, for diagnostics only).
 * @param {string} message - Message to log
 */
function log(message) {
  try {
    process.stderr.write(message + '\n');
  } catch {
    // Silently ignore logging failures
  }
}

module.exports = {
  getClaudeDir,
  getSessionsDir,
  getSessionSearchDirs,
  ensureDir,
  readFile,
  log
};
