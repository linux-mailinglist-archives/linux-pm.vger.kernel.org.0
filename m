Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45DE1935B6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 03:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCZCQg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 22:16:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37748 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbgCZCQg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 22:16:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BF121A07A5;
        Thu, 26 Mar 2020 03:16:33 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 84EAC1A0791;
        Thu, 26 Mar 2020 03:16:33 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 74D57203CD;
        Thu, 26 Mar 2020 03:16:32 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Martin Kepplinger <martink@posteo.de>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/8] interconnect: imx: Add platform driver for imx8mn
Date:   Thu, 26 Mar 2020 04:16:19 +0200
Message-Id: <b102df7782672627699ca629400155ad444b9b0a.1585188174.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585188174.git.leonard.crestez@nxp.com>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1585188174.git.leonard.crestez@nxp.com>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a platform driver for the i.MX8MN SoC describing bus topology, based
on internal documentation.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/interconnect/imx/Kconfig          |  4 +
 drivers/interconnect/imx/Makefile         |  2 +
 drivers/interconnect/imx/imx8mn.c         | 97 +++++++++++++++++++++++
 include/dt-bindings/interconnect/imx8mn.h | 41 ++++++++++
 4 files changed, 144 insertions(+)
 create mode 100644 drivers/interconnect/imx/imx8mn.c
 create mode 100644 include/dt-bindings/interconnect/imx8mn.h

diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
index a2e6127f25b7..be2928362bb7 100644
--- a/drivers/interconnect/imx/Kconfig
+++ b/drivers/interconnect/imx/Kconfig
@@ -6,8 +6,12 @@ config INTERCONNECT_IMX
 
 config INTERCONNECT_IMX8MM
 	tristate "i.MX8MM interconnect driver"
 	depends on INTERCONNECT_IMX
 
+config INTERCONNECT_IMX8MN
+	tristate "i.MX8MN interconnect driver"
+	depends on INTERCONNECT_IMX
+
 config INTERCONNECT_IMX8MQ
 	tristate "i.MX8MQ interconnect driver"
 	depends on INTERCONNECT_IMX
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
index e7d7e029d6c7..21fd5233754f 100644
--- a/drivers/interconnect/imx/Makefile
+++ b/drivers/interconnect/imx/Makefile
@@ -1,7 +1,9 @@
 imx-interconnect-objs			:= imx.o
 imx8mm-interconnect-objs       		:= imx8mm.o
 imx8mq-interconnect-objs       		:= imx8mq.o
+imx8mn-interconnect-objs       		:= imx8mn.o
 
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx-interconnect.o
 obj-$(CONFIG_INTERCONNECT_IMX8MM)	+= imx8mm-interconnect.o
 obj-$(CONFIG_INTERCONNECT_IMX8MQ)	+= imx8mq-interconnect.o
+obj-$(CONFIG_INTERCONNECT_IMX8MN)	+= imx8mn-interconnect.o
diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
new file mode 100644
index 000000000000..e57d77cd36fd
--- /dev/null
+++ b/drivers/interconnect/imx/imx8mn.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, NXP
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/interconnect/imx8mn.h>
+
+#include "imx.h"
+
+static const struct imx_icc_node_adj_desc imx8mn_dram_adj = {
+	.bw_mul = 1,
+	.bw_div = 4,
+	.phandle_name = "fsl,ddrc",
+};
+
+static const struct imx_icc_node_adj_desc imx8mn_noc_adj = {
+	.bw_mul = 1,
+	.bw_div = 4,
+	.main_noc = true,
+};
+
+/*
+ * Describe bus masters, slaves and connections between them
+ *
+ * This is a simplified subset of the bus diagram, there are several other
+ * PL301 nics which are skipped/merged into PL301_MAIN
+ */
+static struct imx_icc_node_desc nodes[] = {
+	DEFINE_BUS_INTERCONNECT("NOC", IMX8MN_ICN_NOC, &imx8mn_noc_adj,
+			IMX8MN_ICS_DRAM, IMX8MN_ICN_MAIN),
+
+	DEFINE_BUS_SLAVE("DRAM", IMX8MN_ICS_DRAM, &imx8mn_dram_adj),
+	DEFINE_BUS_SLAVE("OCRAM", IMX8MN_ICS_OCRAM, NULL),
+	DEFINE_BUS_MASTER("A53", IMX8MN_ICM_A53, IMX8MN_ICN_NOC),
+
+	/* GPUMIX */
+	DEFINE_BUS_MASTER("GPU", IMX8MN_ICM_GPU, IMX8MN_ICN_GPU),
+	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MN_ICN_GPU, NULL, IMX8MN_ICN_NOC),
+
+	/* DISPLAYMIX */
+	DEFINE_BUS_MASTER("CSI1", IMX8MN_ICM_CSI1, IMX8MN_ICN_MIPI),
+	DEFINE_BUS_MASTER("CSI2", IMX8MN_ICM_CSI2, IMX8MN_ICN_MIPI),
+	DEFINE_BUS_MASTER("ISI", IMX8MN_ICM_ISI, IMX8MN_ICN_MIPI),
+	DEFINE_BUS_MASTER("LCDIF", IMX8MN_ICM_LCDIF, IMX8MN_ICN_MIPI),
+	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MN_ICN_MIPI, NULL, IMX8MN_ICN_NOC),
+
+	/* USB goes straight to NOC */
+	DEFINE_BUS_MASTER("USB", IMX8MN_ICM_USB, IMX8MN_ICN_NOC),
+
+	/* Audio */
+	DEFINE_BUS_MASTER("SDMA2", IMX8MN_ICM_SDMA2, IMX8MN_ICN_AUDIO),
+	DEFINE_BUS_MASTER("SDMA3", IMX8MN_ICM_SDMA3, IMX8MN_ICN_AUDIO),
+	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MN_ICN_AUDIO, NULL, IMX8MN_ICN_MAIN),
+
+	/* Ethernet */
+	DEFINE_BUS_MASTER("ENET", IMX8MN_ICM_ENET, IMX8MN_ICN_ENET),
+	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MN_ICN_ENET, NULL, IMX8MN_ICN_MAIN),
+
+	/* Other */
+	DEFINE_BUS_MASTER("SDMA1", IMX8MN_ICM_SDMA1, IMX8MN_ICN_MAIN),
+	DEFINE_BUS_MASTER("NAND", IMX8MN_ICM_NAND, IMX8MN_ICN_MAIN),
+	DEFINE_BUS_MASTER("USDHC1", IMX8MN_ICM_USDHC1, IMX8MN_ICN_MAIN),
+	DEFINE_BUS_MASTER("USDHC2", IMX8MN_ICM_USDHC2, IMX8MN_ICN_MAIN),
+	DEFINE_BUS_MASTER("USDHC3", IMX8MN_ICM_USDHC3, IMX8MN_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN, NULL,
+			IMX8MN_ICN_NOC, IMX8MN_ICS_OCRAM),
+};
+
+static int imx8mn_icc_probe(struct platform_device *pdev)
+{
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
+}
+
+static int imx8mn_icc_remove(struct platform_device *pdev)
+{
+	return imx_icc_unregister(pdev);
+}
+
+static struct platform_driver imx8mn_icc_driver = {
+	.probe = imx8mn_icc_probe,
+	.remove = imx8mn_icc_remove,
+	.driver = {
+		.name = "imx8mn-interconnect",
+	},
+};
+
+module_platform_driver(imx8mn_icc_driver);
+MODULE_ALIAS("platform:imx8mn-interconnect");
+MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/interconnect/imx8mn.h b/include/dt-bindings/interconnect/imx8mn.h
new file mode 100644
index 000000000000..03d099dd71f8
--- /dev/null
+++ b/include/dt-bindings/interconnect/imx8mn.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, NXP
+ */
+
+#ifndef __IMX8MN_ICM_INTERCONNECT_IDS_H
+#define __IMX8MN_ICM_INTERCONNECT_IDS_H
+
+#define IMX8MN_ICN_NOC		1
+#define IMX8MN_ICS_DRAM		2
+#define IMX8MN_ICS_OCRAM	3
+#define IMX8MN_ICM_A53		4
+
+#define IMX8MN_ICM_GPU		5
+#define IMX8MN_ICN_GPU		6
+
+#define IMX8MN_ICM_CSI1		7
+#define IMX8MN_ICM_CSI2		8
+#define IMX8MN_ICM_ISI		9
+#define IMX8MN_ICM_LCDIF	10
+#define IMX8MN_ICN_MIPI		11
+
+#define IMX8MN_ICM_USB		12
+
+#define IMX8MN_ICM_SDMA2	13
+#define IMX8MN_ICM_SDMA3	14
+#define IMX8MN_ICN_AUDIO	15
+
+#define IMX8MN_ICN_ENET		16
+#define IMX8MN_ICM_ENET		17
+
+#define IMX8MN_ICM_NAND		18
+#define IMX8MN_ICM_SDMA1	19
+#define IMX8MN_ICM_USDHC1	20
+#define IMX8MN_ICM_USDHC2	21
+#define IMX8MN_ICM_USDHC3	22
+#define IMX8MN_ICN_MAIN		23
+
+#endif /* __IMX8MN_ICM_INTERCONNECT_IDS_H */
-- 
2.17.1

