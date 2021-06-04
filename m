Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711C639B719
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFDKcI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 06:32:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36837 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229625AbhFDKcF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 06:32:05 -0400
X-UUID: 164b0dfa5df14000825ea90120ca080c-20210604
X-UUID: 164b0dfa5df14000825ea90120ca080c-20210604
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 793061546; Fri, 04 Jun 2021 18:30:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Jun 2021 18:30:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Jun 2021 18:30:12 +0800
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V10 08/12] interconnect: mediatek: Add interconnect provider driver
Date:   Fri, 4 Jun 2021 18:29:55 +0800
Message-ID: <20210604102959.13807-9-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210604102959.13807-1-dawei.chien@mediatek.com>
References: <20210604102959.13807-1-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Henry Chen <henryc.chen@mediatek.com>

Introduce Mediatek MT6873/MT8183/MT8192 specific provider driver
using the interconnect framework.

             ICC provider         ICC Nodes
                              ----          ----
             ---------       |CPU |   |--- |VPU |
    -----   |         |-----  ----    |     ----
   |DRAM |--|DRAM     |       ----    |     ----
   |     |--|scheduler|----- |GPU |   |--- |DISP|
   |     |--|(EMI)    |       ----    |     ----
   |     |--|         |       -----   |     ----
    -----   |         |----- |MMSYS|--|--- |VDEC|
             ---------        -----   |     ----
               /|\                    |     ----
                |change DRAM freq     |--- |VENC|
             ----------               |     ----
            |  DVFSR   |              |
            |          |              |     ----
             ----------               |--- |IMG |
                                      |     ----
                                      |     ----
                                      |--- |CAM |
                                            ----
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/Kconfig            |   1 +
 drivers/interconnect/Makefile           |   1 +
 drivers/interconnect/mediatek/Kconfig   |  13 ++
 drivers/interconnect/mediatek/Makefile  |   3 +
 drivers/interconnect/mediatek/mtk-emi.c | 331 ++++++++++++++++++++++++++++++++
 5 files changed, 349 insertions(+)
 create mode 100644 drivers/interconnect/mediatek/Kconfig
 create mode 100644 drivers/interconnect/mediatek/Makefile
 create mode 100644 drivers/interconnect/mediatek/mtk-emi.c

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index d637a89d4695..da91f847aabd 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -12,6 +12,7 @@ menuconfig INTERCONNECT
 if INTERCONNECT
 
 source "drivers/interconnect/imx/Kconfig"
+source "drivers/interconnect/mediatek/Kconfig"
 source "drivers/interconnect/qcom/Kconfig"
 source "drivers/interconnect/samsung/Kconfig"
 
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 97d393fd638d..d697500d99f0 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -5,5 +5,6 @@ icc-core-objs				:= core.o bulk.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
+obj-$(CONFIG_INTERCONNECT_MTK)		+= mediatek/
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
 obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
diff --git a/drivers/interconnect/mediatek/Kconfig b/drivers/interconnect/mediatek/Kconfig
new file mode 100644
index 000000000000..ec98d6a80f55
--- /dev/null
+++ b/drivers/interconnect/mediatek/Kconfig
@@ -0,0 +1,13 @@
+config INTERCONNECT_MTK
+	bool "Mediatek Network-on-Chip interconnect drivers"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  Support for Mediatek's Network-on-Chip interconnect hardware.
+
+config INTERCONNECT_MTK_EMI
+	tristate "Mediatek EMI interconnect driver"
+	depends on INTERCONNECT_MTK
+	depends on (MTK_DVFSRC && OF) || COMPILE_TEST
+	help
+	  This is a driver for the Mediatek Network-on-Chip on DVFSRC-based
+	  platforms.
diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
new file mode 100644
index 000000000000..353842b2c273
--- /dev/null
+++ b/drivers/interconnect/mediatek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_INTERCONNECT_MTK_EMI) += mtk-emi.o
\ No newline at end of file
diff --git a/drivers/interconnect/mediatek/mtk-emi.c b/drivers/interconnect/mediatek/mtk-emi.c
new file mode 100644
index 000000000000..8d650be62b90
--- /dev/null
+++ b/drivers/interconnect/mediatek/mtk-emi.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/soc/mediatek/mtk_dvfsrc.h>
+#include <dt-bindings/interconnect/mtk,mt6873-emi.h>
+#include <dt-bindings/interconnect/mtk,mt8183-emi.h>
+
+enum mtk_icc_name {
+	SLAVE_DDR_EMI,
+	MASTER_MCUSYS,
+	MASTER_GPUSYS,
+	MASTER_MMSYS,
+	MASTER_MM_VPU,
+	MASTER_MM_DISP,
+	MASTER_MM_VDEC,
+	MASTER_MM_VENC,
+	MASTER_MM_CAM,
+	MASTER_MM_IMG,
+	MASTER_MM_MDP,
+	MASTER_VPUSYS,
+	MASTER_VPU_PORT_0,
+	MASTER_VPU_PORT_1,
+	MASTER_MDLASYS,
+	MASTER_MDLA_PORT_0,
+	MASTER_UFS,
+	MASTER_PCIE,
+	MASTER_USB,
+	MASTER_WIFI,
+	MASTER_BT,
+	MASTER_NETSYS,
+	MASTER_DBGIF,
+
+	SLAVE_HRT_DDR_EMI,
+	MASTER_HRT_MMSYS,
+	MASTER_HRT_MM_DISP,
+	MASTER_HRT_MM_VDEC,
+	MASTER_HRT_MM_VENC,
+	MASTER_HRT_MM_CAM,
+	MASTER_HRT_MM_IMG,
+	MASTER_HRT_MM_MDP,
+	MASTER_HRT_DBGIF,
+};
+
+#define MT8183_MAX_LINKS	1
+
+/**
+ * struct mtk_icc_node - Mediatek specific interconnect nodes
+ * @name: the node name used in debugfs
+ * @ep : the type of this endpoint
+ * @id: a unique node identifier
+ * @links: an array of nodes where we can go next while traversing
+ * @num_links: the total number of @links
+ * @sum_avg: current sum aggregate value of all avg bw kBps requests
+ * @max_peak: current max aggregate value of all peak bw kBps requests
+ */
+struct mtk_icc_node {
+	unsigned char *name;
+	int ep;
+	u16 id;
+	u16 links[MT8183_MAX_LINKS];
+	u16 num_links;
+	u64 sum_avg;
+	u64 max_peak;
+};
+
+struct mtk_icc_desc {
+	struct mtk_icc_node **nodes;
+	size_t num_nodes;
+};
+
+#define DEFINE_MNODE(_name, _id, _ep, ...)	\
+		static struct mtk_icc_node _name = {			\
+		.name = #_name,						\
+		.id = _id,						\
+		.ep = _ep,						\
+		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.links = { __VA_ARGS__ },				\
+}
+
+DEFINE_MNODE(ddr_emi, SLAVE_DDR_EMI, 1);
+DEFINE_MNODE(mcusys, MASTER_MCUSYS, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(gpu, MASTER_GPUSYS, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(mmsys, MASTER_MMSYS, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(mm_vpu, MASTER_MM_VPU, 0, MASTER_MMSYS);
+DEFINE_MNODE(mm_disp, MASTER_MM_DISP, 0, MASTER_MMSYS);
+DEFINE_MNODE(mm_vdec, MASTER_MM_VDEC, 0, MASTER_MMSYS);
+DEFINE_MNODE(mm_venc, MASTER_MM_VENC, 0, MASTER_MMSYS);
+DEFINE_MNODE(mm_cam, MASTER_MM_CAM, 0, MASTER_MMSYS);
+DEFINE_MNODE(mm_img, MASTER_MM_IMG, 0, MASTER_MMSYS);
+DEFINE_MNODE(mm_mdp, MASTER_MM_MDP, 0, MASTER_MMSYS);
+DEFINE_MNODE(vpusys, MASTER_VPUSYS, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(vpu_port_0, MASTER_VPU_PORT_0, 0, MASTER_VPUSYS);
+DEFINE_MNODE(vpu_port_1, MASTER_VPU_PORT_1, 0, MASTER_VPUSYS);
+DEFINE_MNODE(mdlasys, MASTER_MDLASYS, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(mdla_port_0, MASTER_MDLA_PORT_0, 0, MASTER_MDLASYS);
+DEFINE_MNODE(ufs, MASTER_UFS, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(pcie, MASTER_PCIE, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(usb, MASTER_USB, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(wifi, MASTER_WIFI, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(bt, MASTER_BT, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(netsys, MASTER_NETSYS, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(dbgif, MASTER_DBGIF, 0, SLAVE_DDR_EMI);
+
+DEFINE_MNODE(hrt_ddr_emi, SLAVE_HRT_DDR_EMI, 2);
+DEFINE_MNODE(hrt_mmsys, MASTER_HRT_MMSYS, 0, SLAVE_HRT_DDR_EMI);
+DEFINE_MNODE(hrt_mm_disp, MASTER_HRT_MM_DISP, 0, MASTER_HRT_MMSYS);
+DEFINE_MNODE(hrt_mm_vdec, MASTER_HRT_MM_VDEC, 0, MASTER_HRT_MMSYS);
+DEFINE_MNODE(hrt_mm_venc, MASTER_HRT_MM_VENC, 0, MASTER_HRT_MMSYS);
+DEFINE_MNODE(hrt_mm_cam, MASTER_HRT_MM_CAM, 0, MASTER_HRT_MMSYS);
+DEFINE_MNODE(hrt_mm_img, MASTER_HRT_MM_IMG, 0, MASTER_HRT_MMSYS);
+DEFINE_MNODE(hrt_mm_mdp, MASTER_HRT_MM_MDP, 0, MASTER_HRT_MMSYS);
+DEFINE_MNODE(hrt_dbgif, MASTER_HRT_DBGIF, 0, SLAVE_HRT_DDR_EMI);
+
+static struct mtk_icc_node *mt8183_icc_nodes[] = {
+	[MT8183_SLAVE_DDR_EMI] = &ddr_emi,
+	[MT8183_MASTER_MCUSYS] = &mcusys,
+	[MT8183_MASTER_GPU] = &gpu,
+	[MT8183_MASTER_MMSYS] = &mmsys,
+	[MT8183_MASTER_MM_VPU] = &mm_vpu,
+	[MT8183_MASTER_MM_DISP] = &mm_disp,
+	[MT8183_MASTER_MM_VDEC] = &mm_vdec,
+	[MT8183_MASTER_MM_VENC] = &mm_venc,
+	[MT8183_MASTER_MM_CAM] = &mm_cam,
+	[MT8183_MASTER_MM_IMG] = &mm_img,
+	[MT8183_MASTER_MM_MDP] = &mm_mdp,
+};
+
+static const struct mtk_icc_desc mt8183_icc = {
+	.nodes = mt8183_icc_nodes,
+	.num_nodes = ARRAY_SIZE(mt8183_icc_nodes),
+};
+
+static struct mtk_icc_node *mt6873_icc_nodes[] = {
+	[MT6873_SLAVE_DDR_EMI] = &ddr_emi,
+	[MT6873_MASTER_MCUSYS] = &mcusys,
+	[MT6873_MASTER_GPUSYS] = &gpu,
+	[MT6873_MASTER_MMSYS] = &mmsys,
+	[MT6873_MASTER_MM_VPU] = &mm_vpu,
+	[MT6873_MASTER_MM_DISP] = &mm_disp,
+	[MT6873_MASTER_MM_VDEC] = &mm_vdec,
+	[MT6873_MASTER_MM_VENC] = &mm_venc,
+	[MT6873_MASTER_MM_CAM] = &mm_cam,
+	[MT6873_MASTER_MM_IMG] = &mm_img,
+	[MT6873_MASTER_MM_MDP] = &mm_mdp,
+	[MT6873_MASTER_VPUSYS] = &vpusys,
+	[MT6873_MASTER_VPU_0] = &vpu_port_0,
+	[MT6873_MASTER_VPU_1] = &vpu_port_1,
+	[MT6873_MASTER_MDLASYS] = &mdlasys,
+	[MT6873_MASTER_MDLA_0] = &mdla_port_0,
+	[MT6873_MASTER_UFS] = &ufs,
+	[MT6873_MASTER_PCIE] = &pcie,
+	[MT6873_MASTER_USB] = &usb,
+	[MT6873_MASTER_WIFI] = &wifi,
+	[MT6873_MASTER_BT] = &bt,
+	[MT6873_MASTER_NETSYS] = &netsys,
+	[MT6873_MASTER_DBGIF] = &dbgif,
+
+	[MT6873_SLAVE_HRT_DDR_EMI] = &hrt_ddr_emi,
+	[MT6873_MASTER_HRT_MMSYS] = &hrt_mmsys,
+	[MT6873_MASTER_HRT_MM_DISP] = &hrt_mm_disp,
+	[MT6873_MASTER_HRT_MM_VDEC] = &hrt_mm_vdec,
+	[MT6873_MASTER_HRT_MM_VENC] = &hrt_mm_venc,
+	[MT6873_MASTER_HRT_MM_CAM] = &hrt_mm_cam,
+	[MT6873_MASTER_HRT_MM_IMG] = &hrt_mm_img,
+	[MT6873_MASTER_HRT_MM_MDP] = &hrt_mm_mdp,
+	[MT6873_MASTER_HRT_DBGIF] = &hrt_dbgif,
+};
+
+static struct mtk_icc_desc mt6873_icc = {
+	.nodes = mt6873_icc_nodes,
+	.num_nodes = ARRAY_SIZE(mt6873_icc_nodes),
+};
+
+static const struct of_device_id emi_icc_of_match[] = {
+	{ .compatible = "mediatek,mt8183-dvfsrc", .data = &mt8183_icc },
+	{ .compatible = "mediatek,mt8192-dvfsrc", .data = &mt6873_icc },
+	{ .compatible = "mediatek,mt6873-dvfsrc", .data = &mt6873_icc },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, emi_icc_of_match);
+
+static int emi_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+			     u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	struct mtk_icc_node *in;
+
+	in = node->data;
+
+	*agg_avg += avg_bw;
+	*agg_peak = max_t(u32, *agg_peak, peak_bw);
+
+	in->sum_avg = *agg_avg;
+	in->max_peak = *agg_peak;
+
+	return 0;
+}
+
+static int emi_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	int ret = 0;
+	struct mtk_icc_node *node;
+
+	node = dst->data;
+
+	if (node->ep == 1) {
+		mtk_dvfsrc_send_request(src->provider->dev,
+					MTK_DVFSRC_CMD_PEAK_BW_REQUEST,
+					node->max_peak);
+		mtk_dvfsrc_send_request(src->provider->dev,
+					MTK_DVFSRC_CMD_BW_REQUEST,
+					node->sum_avg);
+	} else if (node->ep == 2) {
+		mtk_dvfsrc_send_request(src->provider->dev,
+					MTK_DVFSRC_CMD_HRTBW_REQUEST,
+					node->sum_avg);
+	}
+
+	return ret;
+}
+
+static int emi_icc_remove(struct platform_device *pdev);
+static int emi_icc_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	const struct mtk_icc_desc *desc;
+	struct device *dev = &pdev->dev;
+	struct icc_node *node;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	struct mtk_icc_node **mnodes;
+	size_t num_nodes, i, j;
+	int ret;
+
+	match = of_match_node(emi_icc_of_match, dev->parent->of_node);
+
+	if (!match) {
+		dev_err(dev, "invalid compatible string\n");
+		return -ENODEV;
+	}
+
+	desc = match->data;
+	mnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
+	if (!provider)
+		return -ENOMEM;
+
+	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	provider->dev = pdev->dev.parent;
+	provider->set = emi_icc_set;
+	provider->aggregate = emi_icc_aggregate;
+	provider->xlate = of_icc_xlate_onecell;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->data = data;
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(&pdev->dev, "error adding interconnect provider\n");
+		return ret;
+	}
+
+	for (i = 0; i < num_nodes; i++) {
+		node = icc_node_create(mnodes[i]->id);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = mnodes[i]->name;
+		node->data = mnodes[i];
+		icc_node_add(node, provider);
+
+		for (j = 0; j < mnodes[i]->num_links; j++)
+			icc_link_create(node, mnodes[i]->links[j]);
+
+		data->nodes[i] = node;
+	}
+	data->num_nodes = num_nodes;
+
+	platform_set_drvdata(pdev, provider);
+
+	return 0;
+err:
+	icc_nodes_remove(provider);
+	icc_provider_del(provider);
+	return ret;
+}
+
+static int emi_icc_remove(struct platform_device *pdev)
+{
+	struct icc_provider *provider = platform_get_drvdata(pdev);
+
+	icc_nodes_remove(provider);
+	return icc_provider_del(provider);
+}
+
+static struct platform_driver emi_icc_driver = {
+	.probe = emi_icc_probe,
+	.remove = emi_icc_remove,
+	.driver = {
+		.name = "mediatek-emi-icc",
+	},
+};
+
+static int __init mtk_emi_icc_init(void)
+{
+	return platform_driver_register(&emi_icc_driver);
+}
+subsys_initcall(mtk_emi_icc_init);
+
+static void __exit mtk_emi_icc_exit(void)
+{
+	platform_driver_unregister(&emi_icc_driver);
+}
+module_exit(mtk_emi_icc_exit);
+
+MODULE_AUTHOR("Henry Chen <henryc.chen@mediatek.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1

