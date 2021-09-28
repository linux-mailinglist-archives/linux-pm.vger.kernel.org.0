Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D0041A901
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhI1Gfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 02:35:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:15771 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234207AbhI1Gfg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Sep 2021 02:35:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224696347"
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="224696347"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 23:33:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="706570359"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by fmsmga006.fm.intel.com with ESMTP; 27 Sep 2021 23:33:53 -0700
From:   pandith.n@intel.com
To:     djakov@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mgross@linux.intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: [PATCH V7 1/1] interconnect: intel: Add Keem Bay noc driver
Date:   Tue, 28 Sep 2021 12:03:52 +0530
Message-Id: <20210928063352.13559-1-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Add support for Network on Chip(NOC) counters. Enable features to configure
and capture NOC probe counters, needed for DDR bandwidth measurement. NOC
driver is specific to Intel Keem Bay SOC. NOC hardware counters are used
for DDR statistics profiling, it is not related to timers.
Interface details are provided in include/uapi/linux/noc_uapi.h

Signed-off-by: Pandith N <pandith.n@intel.com>
Reviewed-by: Mark Gross <mgross@linux.intel.com>

---
Changes in V2 :
NOC is class driver, platform driver not needed.
Removed LINUX syscall note from noc_driver.c.
Order variable from longest to shortest.
Using variable in sizeof parameter, rather than data type.
Consistent project naming as Keem Bay

Changes in V3 :
Free noc device in failure case and module exit.
Remove platform device references.

Changes in V4 :
Rephrased commit description, added missing punctuation in Kconfig.

Changes in V5 :
Local variables are always initialized before use in all cases
of capture function
No need of counter 3 definition in enumeration

Changes in V6 :
Renaming noc driver as keembay-bwmon, moved to interconnect/intel.
Added more description about DSS, NOC

Changes in V7 :
Removed unwanted parenthesis, optimized local variables usage.
---
 MAINTAINERS                                |   6 +
 drivers/interconnect/Kconfig               |   1 +
 drivers/interconnect/Makefile              |   1 +
 drivers/interconnect/intel/Kconfig         |  19 ++
 drivers/interconnect/intel/Makefile        |   5 +
 drivers/interconnect/intel/keembay-bwmon.c | 310 +++++++++++++++++++++
 drivers/interconnect/intel/keembay-bwmon.h | 110 ++++++++
 include/uapi/linux/noc_uapi.h              |  42 +++
 8 files changed, 494 insertions(+)
 create mode 100644 drivers/interconnect/intel/Kconfig
 create mode 100644 drivers/interconnect/intel/Makefile
 create mode 100644 drivers/interconnect/intel/keembay-bwmon.c
 create mode 100644 drivers/interconnect/intel/keembay-bwmon.h
 create mode 100644 include/uapi/linux/noc_uapi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..0c22e30ed2ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9045,6 +9045,12 @@ M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
 F:	drivers/char/hw_random/ixp4xx-rng.c
 
+INTEL KEEM BAY DDR SUBSYSTEM, NETWORK ON CHIP INTERCONNECT DRIVER
+M:	Pandith N <pandith.n@intel.com>
+S:	Supported
+F:	drivers/interconnect/intel/
+F:	include/uapi/linux/noc_uapi.h
+
 INTEL KEEM BAY DRM DRIVER
 M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
 M:	Edmund Dea <edmund.j.dea@intel.com>
diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index d637a89d4695..e820e270b40d 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -12,6 +12,7 @@ menuconfig INTERCONNECT
 if INTERCONNECT
 
 source "drivers/interconnect/imx/Kconfig"
+source "drivers/interconnect/intel/Kconfig"
 source "drivers/interconnect/qcom/Kconfig"
 source "drivers/interconnect/samsung/Kconfig"
 
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 97d393fd638d..c88227f7a7c5 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -5,5 +5,6 @@ icc-core-objs				:= core.o bulk.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
+obj-$(CONFIG_INTERCONNECT_INTEL)	+= intel/
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
 obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
diff --git a/drivers/interconnect/intel/Kconfig b/drivers/interconnect/intel/Kconfig
new file mode 100644
index 000000000000..449f43f66ee5
--- /dev/null
+++ b/drivers/interconnect/intel/Kconfig
@@ -0,0 +1,19 @@
+# Copyright (C) 2019 Intel Corporation
+# SPDX-License-Identifier: GPL-2.0-only
+config INTERCONNECT_INTEL
+	bool "Intel Network-on-chip interconnect drivers"
+	help
+	  Support for Intel's Network on chip interconnect hardware.
+
+config INTERCONNECT_INTEL_KEEMBAY
+	tristate "Intel Keem Bay Enable DDR profiling using NOC"
+	depends on INTERCONNECT_INTEL || ARCH_KEEMBAY || COMPILE_TEST
+	help
+	  Enable this option for DDR bandwidth measurements using NOC.
+
+	  Add support for Network-on-chip (NOC) in DDR Subsystem(DSS).
+	  DSS NOC has capabilities to enable and get statistics profiling.
+	  NOC driver enables features to configure and capture NOC probe
+	  counters, needed for DSS bandwidth measurement.
+	  Say Y if using a processor that includes the Intel VPU such as
+	  Keem Bay.  If unsure, say N.
diff --git a/drivers/interconnect/intel/Makefile b/drivers/interconnect/intel/Makefile
new file mode 100644
index 000000000000..5bb34fcfefae
--- /dev/null
+++ b/drivers/interconnect/intel/Makefile
@@ -0,0 +1,5 @@
+# Copyright (C) 2019 Intel Corporation
+# SPDX-License-Identifier: GPL-2.0-only
+#     Makefile for Keem Bay NOC
+#
+obj-$(CONFIG_INTERCONNECT_INTEL_KEEMBAY) += keembay-bwmon.o
diff --git a/drivers/interconnect/intel/keembay-bwmon.c b/drivers/interconnect/intel/keembay-bwmon.c
new file mode 100644
index 000000000000..c5061e929e16
--- /dev/null
+++ b/drivers/interconnect/intel/keembay-bwmon.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*  Copyright (C) 2020 Intel Corporation
+ *
+ *  Purpose: Intel Keem Bay NOC bandwidth measurement interface
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler_types.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/noc_uapi.h>
+#include <linux/of_device.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include "keembay-bwmon.h"
+
+/* Filter and counter offset */
+static const int f_offset[] = {0x44, 0x80, 0xbc, 0xf8};
+static const int c_offset[] = {0x134, 0x148, 0x15c, 0x170};
+static struct noc_device noc_dev;
+
+static inline u32 noc_readl(u32 offset)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(PLATFORM_SIP_SVC_DSS_NOC_PROBE_READ, offset,
+		      0, 0, 0, 0, 0, 0, &res);
+	return res.a1;
+}
+
+static inline void noc_writel(u32 offset, u32 value)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(PLATFORM_SIP_SVC_DSS_NOC_PROBE_WRITE, offset,
+		      value, 0, 0, 0, 0, 0, &res);
+}
+
+/**
+ * flex_noc_setup() - Setup two counters for trace ports
+ * @noc: NOC type to setup counters
+ * @counter: Counter number to set up counter n and n+1
+ * @trace_port: trace port number to setup counters
+ *
+ *  Returns 0 on successful setup, -EINVAL on failure
+ */
+int flex_noc_setup(enum noc_ss_type noc, enum noc_counter counter, int trace_port)
+{
+	int offset;
+
+	if (noc >= NOC_TYPE_MAX || counter >= NOC_COUNTER_MAX)
+		return -EINVAL;
+
+	offset = f_offset[counter / 2];
+
+	/* Stop ongoing stats */
+	noc_writel(MAINCTL, 0);
+	noc_writel(CFGCTL, 0);
+
+	/* Setup trace port and counters port select */
+	noc_writel(TRACEPORTSEL, trace_port);
+	noc_writel(c_offset[counter] + C_PORTSEL, trace_port);
+	noc_writel(c_offset[counter + 1] + C_PORTSEL, trace_port);
+
+	/* Setup counter sources & triggers, Alarm mode - OFF */
+	noc_writel(c_offset[counter] + C_SRC, COUNTERS_0_SRC_VAL);
+	noc_writel(c_offset[counter] + C_ALARMMODE, COUNTERS_ALARMMODE_VAL);
+	noc_writel(c_offset[counter + 1] + C_SRC, COUNTERS_1_SRC_VAL);
+	noc_writel(c_offset[counter + 1] + C_ALARMMODE,
+		   COUNTERS_ALARMMODE_VAL);
+
+	/* Setup filters - RouteID mask, addr base, window size */
+	noc_writel(offset + F_ROUTEIDBASE, 0);
+	noc_writel(offset + F_ROUTEIDMASK, 0);
+	noc_writel(offset + F_ADDRBASE_LOW, 0);
+	noc_writel(offset + F_ADDRBASE_HIGH, 0);
+	noc_writel(offset + F_WINDOWSIZE, FILTER_WINDOW_VAL);
+	noc_writel(offset + F_OPCODE, FILTER_OPCODE_VAL);
+	noc_writel(offset + F_STATUS, FILTER_STATUS_VAL);
+	noc_writel(offset + F_LENGTH, FILTER_OPCODE_VAL);
+
+	return 0;
+}
+
+/**
+ * flexnoc_probe_start() - Start two counters for the NOC probe
+ * @noc: NOC type to setup counters
+ *
+ * This function will start the counters.  When this
+ * function returns NOC_PROBE_CAPTURE_STARTED, it is guaranteed that NOC
+ * is setup for probing counters.
+ *
+ *  Returns NOC_PROBE_CAPTURE_STARTED on starting counters or
+ *  NOC_PROBE_ERR_INVALID_ARGS on invalid arguments
+ */
+enum noc_status flexnoc_probe_start(enum noc_ss_type noc)
+{
+	if (noc >= NOC_TYPE_MAX)
+		return NOC_PROBE_ERR_INVALID_ARGS;
+
+	/* Setting up probe */
+	noc_writel(MAINCTL, (1 << MAINCTL_STATEN_POS));
+	noc_writel(FILTERLUT, 1);
+	noc_writel(STATALARMMIN, 0);
+	noc_writel(STATALARMMAX, 1);
+	noc_writel(STATALARMEN, 1);
+	noc_writel(MAINCTL, ((1 << MAINCTL_STATEN_POS) |
+			     (1 << MAINCTL_ALARM_EN_POS) |
+			     (1 << MAINCTL_ALWAYS_CHAINABLE_POS)));
+	noc_writel(STATPERIOD, NOC_STATPERIOD_VAL);
+	noc_writel(FILTERLUT, 0x00000001);
+	noc_writel(CFGCTL, 0x00000001);
+
+	return NOC_PROBE_CAPTURE_STARTED;
+}
+
+/**
+ * flexnoc_counterp_capture() - Capture the counter statistic values
+ * @noc: NOC type to setup counters
+ * @counter:  Counter number to capture statistics values for n and n+1
+ * @value: statistics values read are returned in this address passed
+ *
+ * This function will return the statistics value of started counters.
+ * When this function returns NOC_PROBE_COMPLETED, it is guaranteed that NOC
+ * counters are idle and finished probing.
+ * Algo : The values should not returned when counters are active/running.
+ * Once the counter is frozen, the values are good to read. There is an
+ * iteration logic implemented to check this. An maximum timeout config
+ * is provided to for capture timeout - NOC_CAPTURE_TIMEOUT_MSEC
+ *
+ *  Returns NOC_PROBE_COMPLETED if the counters are stopped or
+ *  NOC_PROBE_ERR_IN_PROGRESS if counters are still running
+ */
+enum noc_status flexnoc_counter_capture(enum noc_ss_type noc,
+					enum noc_counter counter, u32  *value)
+{
+	unsigned long timeout;
+	u32 c0_0, c0_1;
+
+	if (noc >= NOC_TYPE_MAX ||
+	    counter >= NOC_COUNTER_MAX  ||
+	    !value)
+		return NOC_PROBE_ERR_INVALID_ARGS;
+
+	timeout = jiffies + msecs_to_jiffies(NOC_CAPTURE_TIMEOUT_MSEC);
+	do {
+		c0_0 = noc_readl((c_offset[counter] + C_VAL));
+		usleep_range(10000, 11000);
+		c0_1 = noc_readl((c_offset[counter] + C_VAL));
+		/* If mainctrl is zero , return error */
+		if (noc_readl(MAINCTL) == 0)
+			return NOC_PROBE_ERR_IN_PROGRESS;
+		/* If counters are zero, keep reading */
+		if (0 == c0_0 && 0 == c0_1) {
+			break;
+		} else if (c0_0 != c0_1) {
+			continue;
+		} else {
+			/* counters look good break the while */
+			break;
+		}
+	} while (time_before(jiffies, timeout));
+
+	if (c0_0 != c0_1)
+		return NOC_PROBE_ERR_IN_PROGRESS;
+
+	c0_0 = noc_readl((c_offset[counter] + C_VAL));
+	c0_1 = noc_readl((c_offset[counter + 1] + C_VAL));
+	*value = (c0_0 | (c0_1 << 16));
+
+	return NOC_PROBE_COMPLETED;
+}
+
+static long noc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct flexnoc_countercapture capture_data;
+	void __user *argp = (void __user *)arg;
+	struct flexnoc_probestart probe_data;
+	struct flexnoc_setup setup_data;
+	int rc;
+
+	if (!arg) {
+		pr_err("NOC: Null pointer from user\n");
+		return -EINVAL;
+	}
+	switch (cmd) {
+	case NOC_SETUP:
+		if (copy_from_user(&setup_data,
+				   argp, sizeof(setup_data))) {
+			return -EFAULT;
+		}
+		rc =  flex_noc_setup(setup_data.noc_type, setup_data.counter,
+				     setup_data.traceport);
+		setup_data.ret_id = rc;
+
+		if (copy_to_user(argp,
+				 &setup_data, sizeof(setup_data))) {
+			return -EFAULT;
+		}
+	break;
+	case NOC_PROBE_START:
+		if (copy_from_user(&probe_data, argp,
+				   sizeof(probe_data))) {
+			return -EFAULT;
+		}
+		rc = flexnoc_probe_start(probe_data.noc_type);
+		probe_data.ret_id = rc;
+
+		if (copy_to_user(argp,
+				 &probe_data, sizeof(probe_data))) {
+			return -EFAULT;
+		}
+	break;
+	case NOC_COUNTER_CAPTURE:
+		if (copy_from_user(&capture_data, argp,
+				   sizeof(capture_data))) {
+			return -EFAULT;
+		}
+		rc = flexnoc_counter_capture(capture_data.noc_type,
+					     capture_data.counter,
+					     &capture_data.bw_res);
+		capture_data.ret_id = rc;
+
+		if (copy_to_user(argp, &capture_data,
+				 sizeof(capture_data))) {
+			return -EFAULT;
+		}
+	break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct file_operations noc_fops = {
+	.owner  = THIS_MODULE,
+	.unlocked_ioctl = noc_ioctl,
+};
+
+static int intel_noc_cdev_init(struct noc_device *nocdev)
+{
+	if ((alloc_chrdev_region(&nocdev->cdev, 0, 1, "nocdev")) < 0) {
+		pr_err("Cannot allocate major number for NOC\n");
+		return -EINVAL;
+	}
+
+	cdev_init(&nocdev->noc_cdev, &noc_fops);
+	if ((cdev_add(&nocdev->noc_cdev, nocdev->cdev, 1)) < 0) {
+		pr_err("Cannot add NOC device to the system\n");
+		goto r_class;
+	}
+
+	nocdev->dev_class = class_create(THIS_MODULE, "noc_class");
+	if (!nocdev->dev_class) {
+		pr_err("Cannot create the NOC class\n");
+		cdev_del(&nocdev->noc_cdev);
+		goto r_class;
+	}
+
+	if ((device_create(nocdev->dev_class, NULL, nocdev->cdev,
+			   NULL, "noc")) == NULL) {
+		pr_err("Cannot create NOC device\n");
+		cdev_del(&nocdev->noc_cdev);
+		goto r_cdev;
+	}
+
+	return 0;
+
+r_cdev:
+	class_destroy(nocdev->dev_class);
+r_class:
+	unregister_chrdev_region(nocdev->cdev, 1);
+	return -EINVAL;
+}
+
+static void intel_noc_cdev_exit(struct noc_device *nocdev)
+{
+	cdev_del(&nocdev->noc_cdev);
+	class_destroy(nocdev->dev_class);
+	unregister_chrdev_region(nocdev->cdev, 1);
+}
+
+static int __init noc_driver_module_init(void)
+{
+	int ret;
+
+	ret = intel_noc_cdev_init(&noc_dev);
+	if (ret)
+		pr_err("NOC char device init failed\n");
+	return ret;
+}
+
+static void noc_driver_module_exit(void)
+{
+	intel_noc_cdev_exit(&noc_dev);
+}
+
+module_init(noc_driver_module_init);
+module_exit(noc_driver_module_exit);
+
+MODULE_DESCRIPTION("Intel Keem Bay NOC interconnect driver");
+MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
+MODULE_AUTHOR("Sudarshan Ravula <sudarshan.ravula@intel.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/intel/keembay-bwmon.h b/drivers/interconnect/intel/keembay-bwmon.h
new file mode 100644
index 000000000000..9343a6ed70b3
--- /dev/null
+++ b/drivers/interconnect/intel/keembay-bwmon.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  Copyright (C) 2020 Intel Corporation
+ *
+ *  Purpose: Intel Keem Bay NOC bandwidth measurement interface
+ *
+ */
+#ifndef LINUX_NOCDRIVER_H
+#define LINUX_NOCDRIVER_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <uapi/linux/noc_uapi.h>
+
+/**
+ * enum noc_status - NOC probe status
+ * @NOC_PROBE_CAPTURE_STARTED: Probe counters monitoring started
+ * @NOC_PROBE_ERR_IN_PROGRESS: Probe counters are active, capture failure
+ * @NOC_PROBE_ERR_INVALID_ARGS: NOC error, Invalid arguments passed
+ * @NOC_PROBE_ERR_COMPLETED: NOC counter values captured successfully
+ */
+enum noc_status {
+	NOC_PROBE_CAPTURE_STARTED,
+	NOC_PROBE_ERR_IN_PROGRESS,
+	NOC_PROBE_ERR_INVALID_ARGS,
+	NOC_PROBE_COMPLETED,
+};
+
+/**
+ * enum noc_counter - NOC counter
+ * @NOC_COUNTER_0: NOC Counter 0
+ * @NOC_COUNTER_1: NOC Counter 1
+ */
+enum noc_counter {
+	NOC_COUNTER_0,
+	NOC_COUNTER_1,
+	NOC_COUNTER_2,
+	NOC_COUNTER_MAX
+};
+
+/* NOC Control Register Probe offsets */
+#define ID_COREID		0x0000
+#define ID_REVISIONID		0x0004
+#define MAINCTL			0x0008
+#define CFGCTL			0x000C
+#define TRACEPORTSEL		0x0010
+#define FILTERLUT		0x0014
+#define TRACEALARMEN		0x0018
+#define TRACEALARMSTATUS	0x001C
+#define TRACEALARMCLR		0x0020
+#define STATPERIOD		0x0024
+#define STATGO			0x0028
+#define STATALARMMIN		0x002C
+#define STATALARMMAX		0x0030
+#define STATALARMSTATUS		0x0034
+#define STATALARMCLR		0x0038
+#define STATALARMEN		0x003C
+
+/* NOC Filter Registers offsets */
+#define F_ROUTEIDBASE		0x0000
+#define F_ROUTEIDMASK		0x0004
+#define F_ADDRBASE_LOW		0x0008
+#define F_ADDRBASE_HIGH		0x000C
+#define F_WINDOWSIZE		0x0010
+#define F_OPCODE		0x001C
+#define F_STATUS		0x0020
+#define F_LENGTH		0x0024
+#define F_URGENCY		0x0028
+#define F_USERBASE		0x002C
+#define F_USERMASK		0x0030
+
+/* NOC Counter Registers offsets */
+#define C_PORTSEL		0x0000
+#define C_SRC			0x0004
+#define C_ALARMMODE		0x0008
+#define C_VAL			0x000C
+
+/* NOC register secure access r/w */
+#define PLATFORM_SIP_SVC_DSS_NOC_PROBE_READ		(0x8200ff28)
+#define PLATFORM_SIP_SVC_DSS_NOC_PROBE_WRITE		(0x8200ff29)
+
+/* Timeout(msec) for checking active counters */
+#define NOC_CAPTURE_TIMEOUT_MSEC	2000
+#define NOC_STATPERIOD_VAL		0x1B
+
+#define COUNTERS_0_SRC_VAL	0x14
+#define COUNTERS_1_SRC_VAL	0x10
+#define COUNTERS_ALARMMODE_VAL	0x02
+#define FILTER_WINDOW_VAL	0xFFFFFFFF
+#define FILTER_OPCODE_VAL	0x0F
+#define FILTER_STATUS_VAL	0x03
+#define FILTER_LENGTH_VAL	0x03
+
+/* NOC Probe Main controli register fields */
+#define MAINCTL_STATEN_POS		3
+#define MAINCTL_ALARM_EN_POS		4
+#define MAINCTL_ALWAYS_CHAINABLE_POS	7
+
+struct noc_device {
+	struct class *dev_class;
+	struct cdev noc_cdev;
+	dev_t cdev;
+};
+
+int flex_noc_setup(enum noc_ss_type noc, enum noc_counter counter, int trace_port);
+enum noc_status flexnoc_probe_start(enum noc_ss_type noc);
+enum noc_status flexnoc_counter_capture(enum noc_ss_type noc,
+					enum noc_counter counter, u32 *value);
+
+#endif
diff --git a/include/uapi/linux/noc_uapi.h b/include/uapi/linux/noc_uapi.h
new file mode 100644
index 000000000000..8da3b03efe65
--- /dev/null
+++ b/include/uapi/linux/noc_uapi.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*  Copyright (C) 2020 Intel Corporation
+ *
+ *  Purpose: Intel Keem Bay NOC interface for user space access.
+ */
+
+#ifndef __NOC_UAPI_H
+#define __NOC_UAPI_H
+
+#include <linux/types.h>
+
+#define NOC_MAGIC 'n'
+#define NOC_SETUP		_IOW(NOC_MAGIC, 1, void*)
+#define NOC_PROBE_START		_IOW(NOC_MAGIC, 2, void*)
+#define NOC_COUNTER_CAPTURE	_IOW(NOC_MAGIC, 3, void*)
+
+enum noc_ss_type {
+	DSS_NOC = 0,
+	NOC_TYPE_MAX
+};
+
+struct flexnoc_setup {
+	enum noc_ss_type noc_type;
+	__u16 counter;
+	__u16 traceport;
+	__u16 ret_id;
+};
+
+struct flexnoc_probestart {
+	enum noc_ss_type noc_type;
+	__u16 ret_id;
+	__u32 captime;
+};
+
+struct flexnoc_countercapture {
+	enum noc_ss_type noc_type;
+	__u32 bw_res;
+	__u16 counter;
+	__u16 ret_id;
+};
+
+#endif  /*_NOC__UAPI_H*/
-- 
2.17.1

