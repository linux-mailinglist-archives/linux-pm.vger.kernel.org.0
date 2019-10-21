Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC70CDE2C3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 05:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfJUDtU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 23:49:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42006 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfJUDtU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 23:49:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 869CA1A02C8;
        Mon, 21 Oct 2019 05:49:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A6141A01FC;
        Mon, 21 Oct 2019 05:49:12 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 59CF3402D3;
        Mon, 21 Oct 2019 11:49:04 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Li Biwen <biwen.li@nxp.com>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v7 3/3] soc: fsl: add RCPM driver
Date:   Mon, 21 Oct 2019 11:49:27 +0800
Message-Id: <20191021034927.19300-3-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021034927.19300-1-ran.wang_1@nxp.com>
References: <20191021034927.19300-1-ran.wang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The NXP's QorIQ Processors based on ARM Core have RCPM module
(Run Control and Power Management), which performs system level
tasks associated with power management such as wakeup source control.

This driver depends on PM wakeup source framework which help to
collect wake information.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v7:
	- Replace 'ws->dev' with 'ws->dev->parent' to get aligned with
	c8377adfa781 ("PM / wakeup: Show wakeup sources stats in sysfs")
	- Remove '+obj-y += ftm_alarm.o' since it is wrong.
	- Cosmetic work.

Change in v6:
	- Adjust related API usage to meet wakeup.c's update in patch 1/3.

Change in v5:
	- Fix v4 regression of the return value of wakeup_source_get_next()
	didn't pass to ws in while loop.
	- Rename wakeup_source member 'attached_dev' to 'dev'.
	- Rename property 'fsl,#rcpm-wakeup-cells' to '#fsl,rcpm-wakeup-cells'.
	please see https://lore.kernel.org/patchwork/patch/1101022/

Change in v4:
	- Remove extra ',' in author line of rcpm.c
	- Update usage of wakeup_source_get_next() to be less confusing to the
reader, code logic remain the same.

Change in v3:
	- Some whitespace ajdustment.

Change in v2:
	- Rebase Kconfig and Makefile update to latest mainline.

 drivers/soc/fsl/Kconfig  |   8 +++
 drivers/soc/fsl/Makefile |   1 +
 drivers/soc/fsl/rcpm.c   | 132 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/soc/fsl/rcpm.c

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index f9ad8ad..4918856 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -40,4 +40,12 @@ config DPAA2_CONSOLE
 	  /dev/dpaa2_mc_console and /dev/dpaa2_aiop_console,
 	  which can be used to dump the Management Complex and AIOP
 	  firmware logs.
+
+config FSL_RCPM
+	bool "Freescale RCPM support"
+	depends on PM_SLEEP
+	help
+	  The NXP QorIQ Processors based on ARM Core have RCPM module
+	  (Run Control and Power Management), which performs all device-level
+	  tasks associated with power management, such as wakeup source control.
 endmenu
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 71dee8d..906f1cd 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
+obj-$(CONFIG_FSL_RCPM)			+= rcpm.o
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
 obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
 obj-$(CONFIG_DPAA2_CONSOLE)		+= dpaa2-console.o
diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
new file mode 100644
index 0000000..3da9fc3
--- /dev/null
+++ b/drivers/soc/fsl/rcpm.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// rcpm.c - Freescale QorIQ RCPM driver
+//
+// Copyright 2019 NXP
+//
+// Author: Ran Wang <ran.wang_1@nxp.com>
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/kernel.h>
+
+#define RCPM_WAKEUP_CELL_MAX_SIZE	7
+
+struct rcpm {
+	unsigned int	wakeup_cells;
+	void __iomem	*ippdexpcr_base;
+	bool		little_endian;
+};
+
+static int rcpm_pm_prepare(struct device *dev)
+{
+	int i, ret, idx;
+	void __iomem *base;
+	struct wakeup_source	*ws;
+	struct rcpm		*rcpm;
+	struct device_node	*np = dev->of_node;
+	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1], tmp;
+
+	rcpm = dev_get_drvdata(dev);
+	if (!rcpm)
+		return -EINVAL;
+
+	base = rcpm->ippdexpcr_base;
+
+	/* Begin with first registered wakeup source */
+	ws = wakeup_source_get_start(&idx);
+	do {
+		/* skip object which is not attached to device */
+		if (!ws->dev->parent)
+			continue;
+
+		ret = device_property_read_u32_array(ws->dev->parent,
+				"fsl,rcpm-wakeup", value,
+				rcpm->wakeup_cells + 1);
+
+		/*  Wakeup source should refer to current rcpm device */
+		if (ret || (np->phandle != value[0])) {
+			dev_info(dev, "%s doesn't refer to this rcpm\n",
+					ws->name);
+			continue;
+		}
+
+		for (i = 0; i < rcpm->wakeup_cells; i++) {
+			/* We can only OR related bits */
+			if (value[i + 1]) {
+				if (rcpm->little_endian) {
+					tmp = ioread32(base + i * 4);
+					tmp |= value[i + 1];
+					iowrite32(tmp, base + i * 4);
+				} else {
+					tmp = ioread32be(base + i * 4);
+					tmp |= value[i + 1];
+					iowrite32be(tmp, base + i * 4);
+				}
+			}
+		}
+	} while (ws = wakeup_source_get_next(ws));
+
+	wakeup_source_get_stop(idx);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rcpm_pm_ops = {
+	.prepare =  rcpm_pm_prepare,
+};
+
+static int rcpm_probe(struct platform_device *pdev)
+{
+	struct device	*dev = &pdev->dev;
+	struct resource *r;
+	struct rcpm	*rcpm;
+	int ret;
+
+	rcpm = devm_kzalloc(dev, sizeof(*rcpm), GFP_KERNEL);
+	if (!rcpm)
+		return -ENOMEM;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	rcpm->ippdexpcr_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(rcpm->ippdexpcr_base)) {
+		ret =  PTR_ERR(rcpm->ippdexpcr_base);
+		return ret;
+	}
+
+	rcpm->little_endian = device_property_read_bool(
+			&pdev->dev, "little-endian");
+
+	ret = device_property_read_u32(&pdev->dev,
+			"#fsl,rcpm-wakeup-cells", &rcpm->wakeup_cells);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(&pdev->dev, rcpm);
+
+	return 0;
+}
+
+static const struct of_device_id rcpm_of_match[] = {
+	{ .compatible = "fsl,qoriq-rcpm-2.1+", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rcpm_of_match);
+
+static struct platform_driver rcpm_driver = {
+	.driver = {
+		.name = "rcpm",
+		.of_match_table = rcpm_of_match,
+		.pm	= &rcpm_pm_ops,
+	},
+	.probe = rcpm_probe,
+};
+
+module_platform_driver(rcpm_driver);
-- 
2.7.4

