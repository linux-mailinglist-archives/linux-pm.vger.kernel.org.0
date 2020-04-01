Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8209719ADEE
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbgDAOdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 10:33:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40308 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733065AbgDAOdW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 10:33:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 895C01A0E96;
        Wed,  1 Apr 2020 16:33:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B1621A0E8F;
        Wed,  1 Apr 2020 16:33:19 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 65D4620507;
        Wed,  1 Apr 2020 16:33:18 +0200 (CEST)
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
Subject: [PATCH v2 5/8] interconnect: imx: Add platform driver for imx8mm
Date:   Wed,  1 Apr 2020 17:33:04 +0300
Message-Id: <823cd307bea7416cf7df804bbcb77ab2887e0687.1585751281.git.leonard.crestez@nxp.com>
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

Add a platform driver for the i.MX8MM SoC describing bus topology.

Bandwidth adjustments is currently only supported on the DDRC and main
NOC. Scaling for the vpu/gpu/display NICs could be added in the future.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/interconnect/imx/Kconfig          |   4 +
 drivers/interconnect/imx/Makefile         |   2 +
 drivers/interconnect/imx/imx8mm.c         | 108 ++++++++++++++++++++++
 include/dt-bindings/interconnect/imx8mm.h |  49 ++++++++++
 4 files changed, 163 insertions(+)
 create mode 100644 drivers/interconnect/imx/imx8mm.c
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h

diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
index f39336f8d603..2cd4fad4976a 100644
--- a/drivers/interconnect/imx/Kconfig
+++ b/drivers/interconnect/imx/Kconfig
@@ -1,5 +1,9 @@
 config INTERCONNECT_IMX
 	tristate "i.MX interconnect drivers"
 	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Generic interconnect drivers for i.MX SOCs
+
+config INTERCONNECT_IMX8MM
+	tristate "i.MX8MM interconnect driver"
+	depends on INTERCONNECT_IMX
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
index 86ae0bd28d8c..c234e5d3dfd1 100644
--- a/drivers/interconnect/imx/Makefile
+++ b/drivers/interconnect/imx/Makefile
@@ -1,3 +1,5 @@
 imx-interconnect-objs			:= imx.o
+imx8mm-interconnect-objs       		:= imx8mm.o
 
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx-interconnect.o
+obj-$(CONFIG_INTERCONNECT_IMX8MM)	+= imx8mm-interconnect.o
diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
new file mode 100644
index 000000000000..ee3783a98c01
--- /dev/null
+++ b/drivers/interconnect/imx/imx8mm.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Copyright (c) 2019, NXP
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ * Author: Leonard Crestez <leonard.crestez@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/interconnect/imx8mm.h>
+
+#include "imx.h"
+
+static const struct imx_icc_node_adj_desc imx8mm_dram_adj = {
+	.bw_mul = 1,
+	.bw_div = 16,
+	.phandle_name = "fsl,ddrc",
+};
+
+static const struct imx_icc_node_adj_desc imx8mm_noc_adj = {
+	.bw_mul = 1,
+	.bw_div = 16,
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
+	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC, &imx8mm_noc_adj,
+			IMX8MM_ICS_DRAM, IMX8MM_ICN_MAIN),
+
+	DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM, &imx8mm_dram_adj),
+	DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM, NULL),
+	DEFINE_BUS_MASTER("A53", IMX8MM_ICM_A53, IMX8MM_ICN_NOC),
+
+	/* VPUMIX */
+	DEFINE_BUS_MASTER("VPU H1", IMX8MM_ICM_VPU_H1, IMX8MM_ICN_VIDEO),
+	DEFINE_BUS_MASTER("VPU G1", IMX8MM_ICM_VPU_G1, IMX8MM_ICN_VIDEO),
+	DEFINE_BUS_MASTER("VPU G2", IMX8MM_ICM_VPU_G2, IMX8MM_ICN_VIDEO),
+	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, NULL, IMX8MM_ICN_NOC),
+
+	/* GPUMIX */
+	DEFINE_BUS_MASTER("GPU 2D", IMX8MM_ICM_GPU2D, IMX8MM_ICN_GPU),
+	DEFINE_BUS_MASTER("GPU 3D", IMX8MM_ICM_GPU3D, IMX8MM_ICN_GPU),
+	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, NULL, IMX8MM_ICN_NOC),
+
+	/* DISPLAYMIX */
+	DEFINE_BUS_MASTER("CSI", IMX8MM_ICM_CSI, IMX8MM_ICN_MIPI),
+	DEFINE_BUS_MASTER("LCDIF", IMX8MM_ICM_LCDIF, IMX8MM_ICN_MIPI),
+	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, NULL, IMX8MM_ICN_NOC),
+
+	/* HSIO */
+	DEFINE_BUS_MASTER("USB1", IMX8MM_ICM_USB1, IMX8MM_ICN_HSIO),
+	DEFINE_BUS_MASTER("USB2", IMX8MM_ICM_USB2, IMX8MM_ICN_HSIO),
+	DEFINE_BUS_MASTER("PCIE", IMX8MM_ICM_PCIE, IMX8MM_ICN_HSIO),
+	DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, NULL, IMX8MM_ICN_NOC),
+
+	/* Audio */
+	DEFINE_BUS_MASTER("SDMA2", IMX8MM_ICM_SDMA2, IMX8MM_ICN_AUDIO),
+	DEFINE_BUS_MASTER("SDMA3", IMX8MM_ICM_SDMA3, IMX8MM_ICN_AUDIO),
+	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, NULL, IMX8MM_ICN_MAIN),
+
+	/* Ethernet */
+	DEFINE_BUS_MASTER("ENET", IMX8MM_ICM_ENET, IMX8MM_ICN_ENET),
+	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, NULL, IMX8MM_ICN_MAIN),
+
+	/* Other */
+	DEFINE_BUS_MASTER("SDMA1", IMX8MM_ICM_SDMA1, IMX8MM_ICN_MAIN),
+	DEFINE_BUS_MASTER("NAND", IMX8MM_ICM_NAND, IMX8MM_ICN_MAIN),
+	DEFINE_BUS_MASTER("USDHC1", IMX8MM_ICM_USDHC1, IMX8MM_ICN_MAIN),
+	DEFINE_BUS_MASTER("USDHC2", IMX8MM_ICM_USDHC2, IMX8MM_ICN_MAIN),
+	DEFINE_BUS_MASTER("USDHC3", IMX8MM_ICM_USDHC3, IMX8MM_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN, NULL,
+			IMX8MM_ICN_NOC, IMX8MM_ICS_OCRAM),
+};
+
+static int imx8mm_icc_probe(struct platform_device *pdev)
+{
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
+}
+
+static int imx8mm_icc_remove(struct platform_device *pdev)
+{
+	return imx_icc_unregister(pdev);
+}
+
+static struct platform_driver imx8mm_icc_driver = {
+	.probe = imx8mm_icc_probe,
+	.remove = imx8mm_icc_remove,
+	.driver = {
+		.name = "imx8mm-interconnect",
+	},
+};
+
+module_platform_driver(imx8mm_icc_driver);
+MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx8mm-interconnect");
diff --git a/include/dt-bindings/interconnect/imx8mm.h b/include/dt-bindings/interconnect/imx8mm.h
new file mode 100644
index 000000000000..5404f2af15c3
--- /dev/null
+++ b/include/dt-bindings/interconnect/imx8mm.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ */
+
+#ifndef __IMX8MM_ICM_INTERCONNECT_IDS_H
+#define __IMX8MM_ICM_INTERCONNECT_IDS_H
+
+#define IMX8MM_ICN_NOC		1
+#define IMX8MM_ICS_DRAM		2
+#define IMX8MM_ICS_OCRAM	3
+#define IMX8MM_ICM_A53		4
+
+#define IMX8MM_ICM_VPU_H1	5
+#define IMX8MM_ICM_VPU_G1	6
+#define IMX8MM_ICM_VPU_G2	7
+#define IMX8MM_ICN_VIDEO	8
+
+#define IMX8MM_ICM_GPU2D	9
+#define IMX8MM_ICM_GPU3D	10
+#define IMX8MM_ICN_GPU		11
+
+#define IMX8MM_ICM_CSI		12
+#define IMX8MM_ICM_LCDIF	13
+#define IMX8MM_ICN_MIPI		14
+
+#define IMX8MM_ICM_USB1		15
+#define IMX8MM_ICM_USB2		16
+#define IMX8MM_ICM_PCIE		17
+#define IMX8MM_ICN_HSIO		18
+
+#define IMX8MM_ICM_SDMA2	19
+#define IMX8MM_ICM_SDMA3	20
+#define IMX8MM_ICN_AUDIO	21
+
+#define IMX8MM_ICN_ENET		22
+#define IMX8MM_ICM_ENET		23
+
+#define IMX8MM_ICN_MAIN		24
+#define IMX8MM_ICM_NAND		25
+#define IMX8MM_ICM_SDMA1	26
+#define IMX8MM_ICM_USDHC1	27
+#define IMX8MM_ICM_USDHC2	28
+#define IMX8MM_ICM_USDHC3	29
+
+#endif /* __IMX8MM_ICM_INTERCONNECT_IDS_H */
-- 
2.17.1

