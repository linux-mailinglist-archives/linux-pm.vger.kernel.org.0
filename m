Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B792C5A69
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404350AbgKZRSo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:18:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:50836 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403939AbgKZRSi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 12:18:38 -0500
IronPort-SDR: MqZjXS/PLUXeNsknaQSW3u3qXUnTMBFvOFrzw6f8EvcJjofqy16F5AOT7ERwHrroy4qcDnwWyr
 aroRpT/F8REA==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="190462921"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="190462921"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 09:18:36 -0800
IronPort-SDR: FNOBOM4p//IZN1O62LQ130jn+7hNwcpBNxnmeGYUWv/UTelHr5bcD0Y7DCjOZ2JirSzYPrfMvM
 17g+JbDp53RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="313450931"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2020 09:18:36 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] thermal: int340x: processor_thermal: Add RFIM driver
Date:   Thu, 26 Nov 2020 09:18:28 -0800
Message-Id: <20201126171829.945969-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201126171829.945969-1-srinivas.pandruvada@linux.intel.com>
References: <20201126171829.945969-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for RFIM (Radio Frequency Interference Mitigation) support
via processor thermal PCI device. This drivers allows adjustment of
FIVR (Fully Integrated Voltage Regulator) and DDR (Double Data Rate)
frequencies to avoid RF interference with WiFi and 5G.

Switching voltage regulators (VR) generate radiated EMI or RFI at the
fundamental frequency and its harmonics. Some harmonics may interfere
with very sensitive wireless receivers such as Wi-Fi and cellular that
are integrated into host systems like notebook PCs.  One of mitigation
methods is requesting SOC integrated VR (IVR) switching frequency to a
small % and shift away the switching noise harmonic interference from
radio channels.  OEM or ODMs can use the driver to control SOC IVR
operation within the range where it does not impact IVR performance.

DRAM devices of DDR IO interface and their power plane can generate EMI
at the data rates. Similar to IVR control mechanism, Intel offers a
mechanism by which DDR data rates can be changed if several conditions
are met: there is strong RFI interference because of DDR; CPU power
management has no other restriction in changing DDR data rates;
PC ODMs enable this feature (real time DDR RFI Mitigation referred to as
DDR-RFIM) for Wi-Fi from BIOS.

This change exports two folders under /sys/bus/pci/devices/0000:00:04.0.
One folder "fivr" contains all attributes exposed for controling FIVR
features. The other folder "dvfs" contains all attributes for DDR
features.

Changes done to implement:
- New module for rfim interfaces
- Two new per processor features for DDR and FIVR
- Enable feature for Tiger Lake (FIVR only) and Alder Lake

The attributes exposed and explanation:

FIVR attributes

vco_ref_code_lo (RW): The VCO reference code is an 11-bit field and
controls the FIVR switching frequency. This is the 3-bit LSB field.

vco_ref_code_hi (RW): The VCO reference code is an 11-bit field and
controls the FIVR switching frequency. This is the 8-bit MSB field.

spread_spectrum_pct (RW): Set the FIVR spread spectrum clocking
percentage

spread_spectrum_clk_enable (RW): Enable/disable of the FIVR spread
spectrum clocking feature

rfi_vco_ref_code (RW): This field is a read only status register which
reflects the current FIVR switching frequency

fivr_fffc_rev (RW): This field indicated the revision of the FIVR HW.

DVFS attributes

rfi_restriction_run_busy (RW): Request the restriction of specific DDR
data rate and set this value 1. Self reset to 0 after operation.

rfi_restriction_err_code (RW): Values:  0 :Request is accepted, 1:Feature
disabled, 2: the request restricts more points than it is allowed

rfi_restriction_data_rate_Delta (RW): Restricted DDR data rate for RFI
protection: Lower Limit

rfi_restriction_data_rate_Base (RW): Restricted DDR data rate for RFI
protection: Upper Limit

ddr_data_rate_point_0 (RO): DDR data rate selection 1st point

ddr_data_rate_point_1 (RO): DDR data rate selection 2nd point

ddr_data_rate_point_2 (RO): DDR data rate selection 3rd point

ddr_data_rate_point_3 (RO): DDR data rate selection 4th point

rfi_disable (RW): Disable DDR rate change feature

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |  23 +-
 .../processor_thermal_device.h                |   5 +
 .../int340x_thermal/processor_thermal_rfim.c  | 244 ++++++++++++++++++
 4 files changed, 270 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c

diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index 86e8d3c87df7..f4e2eb7d9606 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_INT340X_THERMAL)	+= int3402_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3403_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device.o
 obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) += processor_thermal_rapl.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_rfim.o
 obj-$(CONFIG_INT3406_THERMAL)	+= int3406_thermal.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 589ac7deec02..b6a7358b989d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -429,6 +429,8 @@ static int proc_thermal_mmio_add(struct pci_dev *pdev,
 {
 	int ret;
 
+	proc_priv->mmio_feature_mask = feature_mask;
+
 	if (feature_mask) {
 		ret = proc_thermal_set_mmio_base(pdev, proc_priv);
 		if (ret)
@@ -443,9 +445,21 @@ static int proc_thermal_mmio_add(struct pci_dev *pdev,
 		}
 	}
 
-	proc_priv->mmio_feature_mask = feature_mask;
+	if (feature_mask & PROC_THERMAL_FEATURE_FIVR ||
+	    feature_mask & PROC_THERMAL_FEATURE_DVFS) {
+		ret = proc_thermal_rfim_add(pdev, proc_priv);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add RFIM interface\n");
+			goto err_rem_rapl;
+		}
+	}
 
 	return 0;
+
+err_rem_rapl:
+	proc_thermal_rapl_remove();
+
+	return ret;
 }
 
 static void proc_thermal_mmio_remove(struct pci_dev *pdev)
@@ -455,6 +469,9 @@ static void proc_thermal_mmio_remove(struct pci_dev *pdev)
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_RAPL)
 		proc_thermal_rapl_remove();
 
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR ||
+	    proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS)
+		proc_thermal_rfim_remove(pdev);
 }
 
 static int  proc_thermal_pci_probe(struct pci_dev *pdev,
@@ -566,7 +583,7 @@ static int proc_thermal_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(proc_thermal_pm, NULL, proc_thermal_resume);
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
-	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
+	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS) },
 	{ PCI_DEVICE_DATA(INTEL, BDW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BSW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BXT0_THERMAL, 0) },
@@ -580,7 +597,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ICL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
 	{ PCI_DEVICE_DATA(INTEL, JSL_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, SKL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
-	{ PCI_DEVICE_DATA(INTEL, TGL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
+	{ PCI_DEVICE_DATA(INTEL, TGL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR) },
 	{ },
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 45214571e00d..4bbb88f6b4a7 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -54,6 +54,8 @@ struct rapl_mmio_regs {
 
 #define PROC_THERMAL_FEATURE_NONE	0x00
 #define PROC_THERMAL_FEATURE_RAPL	0x01
+#define PROC_THERMAL_FEATURE_FIVR	0x02
+#define PROC_THERMAL_FEATURE_DVFS	0x04
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
@@ -70,4 +72,7 @@ static void __maybe_unused proc_thermal_rapl_remove(void)
 }
 #endif
 
+int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+void proc_thermal_rfim_remove(struct pci_dev *pdev);
+
 #endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
new file mode 100644
index 000000000000..aef993a813e2
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * processor thermal device RFIM control
+ * Copyright (c) 2020, Intel Corporation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "processor_thermal_device.h"
+
+struct mmio_reg {
+	int read_only;
+	u32 offset;
+	int bits;
+	u16 mask;
+	u16 shift;
+};
+
+/* These will represent sysfs attribute names */
+static const char * const fivr_strings[] = {
+	"vco_ref_code_lo",
+	"vco_ref_code_hi",
+	"spread_spectrum_pct",
+	"spread_spectrum_clk_enable",
+	"rfi_vco_ref_code",
+	"fivr_fffc_rev",
+	NULL
+};
+
+static const struct mmio_reg tgl_fivr_mmio_regs[] = {
+	{ 0, 0x5A18, 3, 0x7, 12}, /* vco_ref_code_lo */
+	{ 0, 0x5A18, 8, 0xFF, 16}, /* vco_ref_code_hi */
+	{ 0, 0x5A08, 8, 0xFF, 0}, /* spread_spectrum_pct */
+	{ 0, 0x5A08, 1, 0x1, 8}, /* spread_spectrum_clk_enable */
+	{ 1, 0x5A10, 12, 0xFFF, 0}, /* rfi_vco_ref_code */
+	{ 1, 0x5A14, 2, 0x3, 1}, /* fivr_fffc_rev */
+};
+
+/* These will represent sysfs attribute names */
+static const char * const dvfs_strings[] = {
+	"rfi_restriction_run_busy",
+	"rfi_restriction_err_code",
+	"rfi_restriction_data_rate",
+	"rfi_restriction_data_rate_base",
+	"ddr_data_rate_point_0",
+	"ddr_data_rate_point_1",
+	"ddr_data_rate_point_2",
+	"ddr_data_rate_point_3",
+	"rfi_disable",
+	NULL
+};
+
+static const struct mmio_reg adl_dvfs_mmio_regs[] = {
+	{ 0, 0x5A38, 1, 0x1, 31}, /* rfi_restriction_run_busy */
+	{ 0, 0x5A38, 7, 0x7F, 24}, /* rfi_restriction_err_code */
+	{ 0, 0x5A38, 8, 0xFF, 16}, /* rfi_restriction_data_rate */
+	{ 0, 0x5A38, 16, 0xFFFF, 0}, /* rfi_restriction_data_rate_base */
+	{ 0, 0x5A30, 10, 0x3FF, 0}, /* ddr_data_rate_point_0 */
+	{ 0, 0x5A30, 10, 0x3FF, 10}, /* ddr_data_rate_point_1 */
+	{ 0, 0x5A30, 10, 0x3FF, 20}, /* ddr_data_rate_point_2 */
+	{ 0, 0x5A30, 10, 0x3FF, 30}, /* ddr_data_rate_point_3 */
+	{ 0, 0x5A40, 1, 0x1, 0}, /* rfi_disable */
+};
+
+#define RFIM_SHOW(suffix, table)\
+static ssize_t suffix##_show(struct device *dev,\
+			      struct device_attribute *attr,\
+			      char *buf)\
+{\
+	struct proc_thermal_device *proc_priv;\
+	struct pci_dev *pdev = to_pci_dev(dev);\
+	const struct mmio_reg *mmio_regs;\
+	const char **match_strs;\
+	u32 reg_val;\
+	int ret;\
+\
+	proc_priv = pci_get_drvdata(pdev);\
+	if (table) {\
+		match_strs = (const char **)dvfs_strings;\
+		mmio_regs = adl_dvfs_mmio_regs;\
+	} else { \
+		match_strs = (const char **)fivr_strings;\
+		mmio_regs = tgl_fivr_mmio_regs;\
+	} \
+	\
+	ret = match_string(match_strs, -1, attr->attr.name);\
+	if (ret < 0)\
+		return ret;\
+	reg_val = readl((void __iomem *) (proc_priv->mmio_base + mmio_regs[ret].offset));\
+	ret = (reg_val >> mmio_regs[ret].shift) & mmio_regs[ret].mask;\
+	return sprintf(buf, "%u\n", ret);\
+}
+
+#define RFIM_STORE(suffix, table)\
+static ssize_t suffix##_store(struct device *dev,\
+			       struct device_attribute *attr,\
+			       const char *buf, size_t count)\
+{\
+	struct proc_thermal_device *proc_priv;\
+	struct pci_dev *pdev = to_pci_dev(dev);\
+	unsigned int input;\
+	const char **match_strs;\
+	const struct mmio_reg *mmio_regs;\
+	int ret, err;\
+	u32 reg_val;\
+	u32 mask;\
+\
+	proc_priv = pci_get_drvdata(pdev);\
+	if (table) {\
+		match_strs = (const char **)dvfs_strings;\
+		mmio_regs = adl_dvfs_mmio_regs;\
+	} else { \
+		match_strs = (const char **)fivr_strings;\
+		mmio_regs = tgl_fivr_mmio_regs;\
+	} \
+	\
+	ret = match_string(match_strs, -1, attr->attr.name);\
+	if (ret < 0)\
+		return ret;\
+	if (mmio_regs[ret].read_only)\
+		return -EPERM;\
+	err = kstrtouint(buf, 10, &input);\
+	if (err)\
+		return err;\
+	mask = GENMASK(mmio_regs[ret].shift + mmio_regs[ret].bits - 1, mmio_regs[ret].shift);\
+	reg_val = readl((void __iomem *) (proc_priv->mmio_base + mmio_regs[ret].offset));\
+	reg_val &= ~mask;\
+	reg_val |= (input << mmio_regs[ret].shift);\
+	writel(reg_val, (void __iomem *) (proc_priv->mmio_base + mmio_regs[ret].offset));\
+	return count;\
+}
+
+RFIM_SHOW(vco_ref_code_lo, 0)
+RFIM_SHOW(vco_ref_code_hi, 0)
+RFIM_SHOW(spread_spectrum_pct, 0)
+RFIM_SHOW(spread_spectrum_clk_enable, 0)
+RFIM_SHOW(rfi_vco_ref_code, 0)
+RFIM_SHOW(fivr_fffc_rev, 0)
+
+RFIM_STORE(vco_ref_code_lo, 0)
+RFIM_STORE(vco_ref_code_hi, 0)
+RFIM_STORE(spread_spectrum_pct, 0)
+RFIM_STORE(spread_spectrum_clk_enable, 0)
+RFIM_STORE(rfi_vco_ref_code, 0)
+RFIM_STORE(fivr_fffc_rev, 0)
+
+static DEVICE_ATTR_RW(vco_ref_code_lo);
+static DEVICE_ATTR_RW(vco_ref_code_hi);
+static DEVICE_ATTR_RW(spread_spectrum_pct);
+static DEVICE_ATTR_RW(spread_spectrum_clk_enable);
+static DEVICE_ATTR_RW(rfi_vco_ref_code);
+static DEVICE_ATTR_RW(fivr_fffc_rev);
+
+static struct attribute *fivr_attrs[] = {
+	&dev_attr_vco_ref_code_lo.attr,
+	&dev_attr_vco_ref_code_hi.attr,
+	&dev_attr_spread_spectrum_pct.attr,
+	&dev_attr_spread_spectrum_clk_enable.attr,
+	&dev_attr_rfi_vco_ref_code.attr,
+	&dev_attr_fivr_fffc_rev.attr,
+	NULL
+};
+
+static const struct attribute_group fivr_attribute_group = {
+	.attrs = fivr_attrs,
+	.name = "fivr"
+};
+
+RFIM_SHOW(rfi_restriction_run_busy, 1)
+RFIM_SHOW(rfi_restriction_err_code, 1)
+RFIM_SHOW(rfi_restriction_data_rate, 1)
+RFIM_SHOW(ddr_data_rate_point_0, 1)
+RFIM_SHOW(ddr_data_rate_point_1, 1)
+RFIM_SHOW(ddr_data_rate_point_2, 1)
+RFIM_SHOW(ddr_data_rate_point_3, 1)
+RFIM_SHOW(rfi_disable, 1)
+
+RFIM_STORE(rfi_restriction_run_busy, 1)
+RFIM_STORE(rfi_restriction_err_code, 1)
+RFIM_STORE(rfi_restriction_data_rate, 1)
+RFIM_STORE(rfi_disable, 1)
+
+static DEVICE_ATTR_RW(rfi_restriction_run_busy);
+static DEVICE_ATTR_RW(rfi_restriction_err_code);
+static DEVICE_ATTR_RW(rfi_restriction_data_rate);
+static DEVICE_ATTR_RO(ddr_data_rate_point_0);
+static DEVICE_ATTR_RO(ddr_data_rate_point_1);
+static DEVICE_ATTR_RO(ddr_data_rate_point_2);
+static DEVICE_ATTR_RO(ddr_data_rate_point_3);
+static DEVICE_ATTR_RW(rfi_disable);
+
+static struct attribute *dvfs_attrs[] = {
+	&dev_attr_rfi_restriction_run_busy.attr,
+	&dev_attr_rfi_restriction_err_code.attr,
+	&dev_attr_rfi_restriction_data_rate.attr,
+	&dev_attr_ddr_data_rate_point_0.attr,
+	&dev_attr_ddr_data_rate_point_1.attr,
+	&dev_attr_ddr_data_rate_point_2.attr,
+	&dev_attr_ddr_data_rate_point_3.attr,
+	&dev_attr_rfi_disable.attr,
+	NULL
+};
+
+static const struct attribute_group dvfs_attribute_group = {
+	.attrs = dvfs_attrs,
+	.name = "dvfs"
+};
+
+int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
+{
+	int ret;
+
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR) {
+		ret = sysfs_create_group(&pdev->dev.kobj, &fivr_attribute_group);
+		if (ret)
+			return ret;
+	}
+
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS) {
+		ret = sysfs_create_group(&pdev->dev.kobj, &dvfs_attribute_group);
+		if (ret && proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR) {
+			sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(proc_thermal_rfim_add);
+
+void proc_thermal_rfim_remove(struct pci_dev *pdev)
+{
+	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
+
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR)
+		sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
+
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS)
+		sysfs_remove_group(&pdev->dev.kobj, &dvfs_attribute_group);
+}
+EXPORT_SYMBOL_GPL(proc_thermal_rfim_remove);
+
+MODULE_LICENSE("GPL v2");
-- 
2.25.4

