<?php
/**
 * Package_Formatter class
 *
 * @package  WooCommerce
 */

namespace Automattic\WooCommerce\MonorepoTools\Changelogger;

use Automattic\Jetpack\Changelogger\FormatterPlugin;

/**
 * Jetpack Changelogger Formatter for WooCommerce packages
 */

require_once 'class-formatter.php';

/**
 * Jetpack Changelogger Formatter for WooCommerce Packages
 *
 * Class Formatter
 */
class Php_Package_Formatter extends Formatter implements FormatterPlugin {
	/**
	 * Prologue text.
	 *
	 * @var string
	 */
	public $prologue = "# Changelog \n\nThis project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).";

	/**
	 * Get Release link given a version number.
	 *
	 * @throws \InvalidArgumentException When directory parsing fails.
	 * @param string $version Release version.
	 *
	 * @return string Link to the version's release.
	 */
	public function getReleaseLink( $version ) {
		// Capture anything past /woocommerce in the current working directory.
		preg_match( '/\/packages\/php\/(.+)/', getcwd(), $path );

		if ( ! count( $path ) ) {
			throw new \InvalidArgumentException( 'Invalid directory.' );
		}

		return 'https://github.com/woocommerce/' .  $path[1] . '/releases/tag/' . $version;
	}
}
