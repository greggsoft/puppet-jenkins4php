# Class: jenkins4php
#
# This module manages jenkins4php
#
# Parameters:
#
# Actions:
#
# Requires:
#  - phpqatools
#  - jenkins
#
# Sample Usage:
#
class jenkins4php {
	include phpqatools

	class { 'jenkins':
		plugin_hash => {
			"git-plugin" => {name => "git"},
			"checkstyle" => {name => "checkstyle"},
			"cobertura" => {name => "cobertura"},
			"cloverphp" => {name => "cloverphp"},
			"dry" => {name => "dry"},
			"htmlpublisher" => {name => "htmlpublisher"},
			"jdepend" => {name => "jdepend"},
			"plot" => {name => "plot"},
			"pmd" => {name => "pmd"},
			"violations" => {name => "violations"},
			"xunit" => {name => "xunit"},
			"build-pipeline-plugin" => {name => "build-pipeline-plugin"},
		}
	}

	# PHP Template Job (see: http://jenkins-php.org/)
	$jenkins_dir = '/var/lib/jenkins'

	file { "${jenkins_dir}/jobs":
		owner => "jenkins",
		group => "jenkins",
		ensure => directory,
		require => Package['jenkins']
	}
	file { "${jenkins_dir}/jobs/php-template":
		owner => "jenkins",
		group => "jenkins",
		ensure => directory
	}
	file { "${jenkins_dir}/jobs/php-template/config.xml":
		owner => "jenkins",
		group => "jenkins",
		source => "puppet:///modules/jenkins4php/php-template/config.xml",
		notify => Service['jenkins']
	}
	file { "${jenkins_dir}/jobs/php-template/LICENSE":
		owner => "jenkins",
		group => "jenkins",
		source => "puppet:///modules/jenkins4php/php-template/LICENSE"
	}
}
