Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3BB19ADEF
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbgDAOdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 10:33:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40356 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732749AbgDAOdW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 10:33:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B303B1A0E9C;
        Wed,  1 Apr 2020 16:33:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A11E51A0E8F;
        Wed,  1 Apr 2020 16:33:20 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BFE620507;
        Wed,  1 Apr 2020 16:33:19 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
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
        Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/8] interconnect: imx: Add platform driver for imx8mq
Date:   Wed,  1 Apr 2020 17:33:05 +0300
Message-Id: <31ed81d384ca9922242bbd24f68091fddc4aee36.1585751281.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585751281.git.leonard.crestez@nxp.com>
References: <cover.1585751281.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1585751281.git.leonard.crestez@nxp.com>
References: <cover.1585751281.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a platform driver for the i.MX8MQ SoC describing bus topology,
based on internal documentation.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/interconnect/imx/Kconfig          |   4 +
 drivers/interconnect/imx/Makefile         |   2 +
 drivers/interconnect/imx/imx8mq.c         | 106 ++++++++++++++++++++++
 include/dt-bindings/interconnect/imx8mq.h |  48 ++++++++++
 4 files changed, 160 insertions(+)
 create mode 100644 drivers/interconnect/imx/imx8mq.c
 create mode 100644 include/dt-bindings/interconnect/imx8mq.h

diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
index 2cd4fad4976a..a2e6127f25b7 100644
--- a/drivers/interconnect/imx/Kconfig
+++ b/drivers/interconnect/imx/Kconfig
@@ -5,5 +5,9 @@ config INTERCONNECT_IMX
 	  Generic interconnect drivers for i.MX SOCs
 
 config INTERCONNECT_IMX8MM
 	tristate "i.MX8MM interconnect driver"
 	depends on INTERCONNECT_IMX
+
+config INTERCONNECT_IMX8MQ
+	tristate "i.MX8MQ interconnect driver"
+	depends on INTERCONNECT_IMX
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
index c234e5d3dfd1..e7d7e029d6c7 100644
--- a/drivers/interconnect/imx/Makefile
+++ b/drivers/interconnect/imx/Makefile
@@ -1,5 +1,7 @@
 imx-interconnect-objs			:= imx.o
 imx8mm-interconnect-objs       		:= imx8mm.o
+imx8mq-interconnect-objs       		:= imx8mq.o
 
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx-interconnect.o
 obj-$(CONFIG_INTERCONNECT_IMX8MM)	+= imx8mm-interconnect.o
+obj-$(CONFIG_INTERCONNECT_IMX8MQ)	+= imx8mq-interconnect.o
diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
new file mode 100644
index 000000000000..8fb953a1b9ff
--- /dev/null
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -0,0 +1,106 @@
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
+#include <dt-bindings/interconnect/imx8mq.h>
+
+#include "imx.h"
+
+static const struct imx_icc_node_adj_desc imx8mq_dram_adj = {
+	.bw_mul = 1,
+	.bw_div = 4,
+	.phandle_name = "fsl,ddrc",
+};
+
+static const struct imx_icc_node_adj_desc imx8mq_noc_adj = {
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
+	DEFINE_BUS_INTERCONNECT("NOC", IMX8MQ_ICN_NOC, &imx8mq_noc_adj,
+			IMX8MQ_ICS_DRAM, IMX8MQ_ICN_MAIN),
+
+	DEFINE_BUS_SLAVE("DRAM", IMX8MQ_ICS_DRAM, &imx8mq_dram_adj),
+	DEFINE_BUS_SLAVE("OCRAM", IMX8MQ_ICS_OCRAM, NULL),
+	DEFINE_BUS_MASTER("A53", IMX8MQ_ICM_A53, IMX8MQ_ICN_NOC),
+
+	/* VPUMIX */
+	DEFINE_BUS_MASTER("VPU", IMX8MQ_ICM_VPU, IMX8MQ_ICN_VIDEO),
+	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MQ_ICN_VIDEO, NULL, IMX8MQ_ICN_NOC),
+
+	/* GPUMIX */
+	DEFINE_BUS_MASTER("GPU", IMX8MQ_ICM_GPU, IMX8MQ_ICN_GPU),
+	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MQ_ICN_GPU, NULL, IMX8MQ_ICN_NOC),
+
+	/* DISPMIX (only for DCSS) */
+	DEFINE_BUS_MASTER("DC", IMX8MQ_ICM_DCSS, IMX8MQ_ICN_DCSS),
+	DEFINE_BUS_INTERCONNECT("PL301_DC", IMX8MQ_ICN_DCSS, NULL, IMX8MQ_ICN_NOC),
+
+	/* USBMIX */
+	DEFINE_BUS_MASTER("USB1", IMX8MQ_ICM_USB1, IMX8MQ_ICN_USB),
+	DEFINE_BUS_MASTER("USB2", IMX8MQ_ICM_USB2, IMX8MQ_ICN_USB),
+	DEFINE_BUS_INTERCONNECT("PL301_USB", IMX8MQ_ICN_USB, NULL, IMX8MQ_ICN_NOC),
+
+	/* PL301_DISPLAY (IPs other than DCSS, inside SUPERMIX) */
+	DEFINE_BUS_MASTER("CSI1", IMX8MQ_ICM_CSI1, IMX8MQ_ICN_DISPLAY),
+	DEFINE_BUS_MASTER("CSI2", IMX8MQ_ICM_CSI2, IMX8MQ_ICN_DISPLAY),
+	DEFINE_BUS_MASTER("LCDIF", IMX8MQ_ICM_LCDIF, IMX8MQ_ICN_DISPLAY),
+	DEFINE_BUS_INTERCONNECT("PL301_DISPLAY", IMX8MQ_ICN_DISPLAY, NULL, IMX8MQ_ICN_MAIN),
+
+	/* AUDIO */
+	DEFINE_BUS_MASTER("SDMA2", IMX8MQ_ICM_SDMA2, IMX8MQ_ICN_AUDIO),
+	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MQ_ICN_AUDIO, NULL, IMX8MQ_ICN_DISPLAY),
+
+	/* ENET */
+	DEFINE_BUS_MASTER("ENET", IMX8MQ_ICM_ENET, IMX8MQ_ICN_ENET),
+	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, NULL, IMX8MQ_ICN_MAIN),
+
+	/* OTHER */
+	DEFINE_BUS_MASTER("SDMA1", IMX8MQ_ICM_SDMA1, IMX8MQ_ICN_MAIN),
+	DEFINE_BUS_MASTER("NAND", IMX8MQ_ICM_NAND, IMX8MQ_ICN_MAIN),
+	DEFINE_BUS_MASTER("USDHC1", IMX8MQ_ICM_USDHC1, IMX8MQ_ICN_MAIN),
+	DEFINE_BUS_MASTER("USDHC2", IMX8MQ_ICM_USDHC2, IMX8MQ_ICN_MAIN),
+	DEFINE_BUS_MASTER("PCIE1", IMX8MQ_ICM_PCIE1, IMX8MQ_ICN_MAIN),
+	DEFINE_BUS_MASTER("PCIE2", IMX8MQ_ICM_PCIE2, IMX8MQ_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN, NULL,
+			IMX8MQ_ICN_NOC, IMX8MQ_ICS_OCRAM),
+};
+
+static int imx8mq_icc_probe(struct platform_device *pdev)
+{
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
+}
+
+static int imx8mq_icc_remove(struct platform_device *pdev)
+{
+	return imx_icc_unregister(pdev);
+}
+
+static struct platform_driver imx8mq_icc_driver = {
+	.probe = imx8mq_icc_probe,
+	.remove = imx8mq_icc_remove,
+	.driver = {
+		.name = "imx8mq-interconnect",
+	},
+};
+
+module_platform_driver(imx8mq_icc_driver);
+MODULE_ALIAS("platform:imx8mq-interconnect");
+MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/interconnect/imx8mq.h b/include/dt-bindings/interconnect/imx8mq.h
new file mode 100644
index 000000000000..94701b19f35a
--- /dev/null
+++ b/include/dt-bindings/interconnect/imx8mq.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, NXP
+ */
+
+#ifndef __IMX8MQ_ICM_INTERCONNECT_IDS_H
+#define __IMX8MQ_ICM_INTERCONNECT_IDS_H
+
+#define IMX8MQ_ICN_NOC		1
+#define IMX8MQ_ICS_DRAM		2
+#define IMX8MQ_ICS_OCRAM	3
+#define IMX8MQ_ICM_A53		4
+
+#define IMX8MQ_ICM_VPU		5
+#define IMX8MQ_ICN_VIDEO	6
+
+#define IMX8MQ_ICM_GPU		7
+#define IMX8MQ_ICN_GPU		8
+
+#define IMX8MQ_ICM_DCSS		9
+#define IMX8MQ_ICN_DCSS		10
+
+#define IMX8MQ_ICM_USB1		11
+#define IMX8MQ_ICM_USB2		12
+#define IMX8MQ_ICN_USB		13
+
+#define IMX8MQ_ICM_CSI1		14
+#define IMX8MQ_ICM_CSI2		15
+#define IMX8MQ_ICM_LCDIF	16
+#define IMX8MQ_ICN_DISPLAY	17
+
+#define IMX8MQ_ICM_SDMA2	18
+#define IMX8MQ_ICN_AUDIO	19
+
+#define IMX8MQ_ICN_ENET		20
+#define IMX8MQ_ICM_ENET		21
+
+#define IMX8MQ_ICM_SDMA1	22
+#define IMX8MQ_ICM_NAND		23
+#define IMX8MQ_ICM_USDHC1	24
+#define IMX8MQ_ICM_USDHC2	25
+#define IMX8MQ_ICM_PCIE1	26
+#define IMX8MQ_ICM_PCIE2	27
+#define IMX8MQ_ICN_MAIN		28
+
+#endif /* __IMX8MQ_ICM_INTERCONNECT_IDS_H */
-- 
2.17.1

