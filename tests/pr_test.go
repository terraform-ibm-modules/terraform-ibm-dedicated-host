// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

// Use existing resource group
const resourceGroup = "geretain-test-resources"

// Ensure every example directory has a corresponding test
// const advancedExampleDir = "examples/advanced"
const basicExampleDir = "examples/basic"

// const upgradeExampleDir = "examples/upgrade"
const region = "us-south"

func setupOptions(t *testing.T, prefix string, dir string) *testhelper.TestOptions {
	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  dir,
		Prefix:        prefix,
		ResourceGroup: resourceGroup,
		Region:        region,
	})
	return options
}

// Consistency test for the basic example
func TestRunBasicExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "dh-basic", basicExampleDir)

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

// Advanced test will be added once the quota has been increased.
// func TestRunAdvancedExample(t *testing.T) {
//	t.Parallel()

//	options := setupOptions(t, "mod-adv", advancedExampleDir)

//	output, err := options.RunTestConsistency()
//	assert.Nil(t, err, "This should not have errored")
//	assert.NotNil(t, output, "Expected some output")
//}

func TestRunUpgradeExample(t *testing.T) {
	t.Skip()

	options := setupOptions(t, "dh-upg", basicExampleDir)

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
