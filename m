Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318E33EA165
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhHLJBE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 05:01:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59856 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235673AbhHLJAx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 05:00:53 -0400
X-UUID: e64626d5736242249cb9de2e36a5cf71-20210812
X-UUID: e64626d5736242249cb9de2e36a5cf71-20210812
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2095382644; Thu, 12 Aug 2021 17:00:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 17:00:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 17:00:23 +0800
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
        Dawei Chien <dawei.chien@mediatek.com>
Subject: [V11,PATCH 13/19] interconnect: mediatek: add support for mt8195
Date:   Thu, 12 Aug 2021 16:58:40 +0800
Message-ID: <20210812085846.2628-14-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210812085846.2628-1-dawei.chien@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

add platform data of mt8195

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 drivers/interconnect/mediatek/mtk-emi.c | 51 +++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/mediatek/mtk-emi.c b/drivers/interconnect/mediatek/mtk-emi.c
index 8d650be62b90..379dab77ebfd 100644
--- a/drivers/interconnect/mediatek/mtk-emi.c
+++ b/drivers/interconnect/mediatek/mtk-emi.c
@@ -12,6 +12,7 @@
 #include <linux/soc/mediatek/mtk_dvfsrc.h>
 #include <dt-bindings/interconnect/mtk,mt6873-emi.h>
 #include <dt-bindings/interconnect/mtk,mt8183-emi.h>
+#include <dt-bindings/interconnect/mtk,mt8195-emi.h>
 
 enum mtk_icc_name {
 	SLAVE_DDR_EMI,
@@ -31,7 +32,8 @@ enum mtk_icc_name {
 	MASTER_MDLASYS,
 	MASTER_MDLA_PORT_0,
 	MASTER_UFS,
-	MASTER_PCIE,
+	MASTER_PCIE_0,
+	MASTER_PCIE_1,
 	MASTER_USB,
 	MASTER_WIFI,
 	MASTER_BT,
@@ -102,7 +104,8 @@ DEFINE_MNODE(vpu_port_1, MASTER_VPU_PORT_1, 0, MASTER_VPUSYS);
 DEFINE_MNODE(mdlasys, MASTER_MDLASYS, 0, SLAVE_DDR_EMI);
 DEFINE_MNODE(mdla_port_0, MASTER_MDLA_PORT_0, 0, MASTER_MDLASYS);
 DEFINE_MNODE(ufs, MASTER_UFS, 0, SLAVE_DDR_EMI);
-DEFINE_MNODE(pcie, MASTER_PCIE, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(pcie_0, MASTER_PCIE_0, 0, SLAVE_DDR_EMI);
+DEFINE_MNODE(pcie_1, MASTER_PCIE_1, 0, SLAVE_DDR_EMI);
 DEFINE_MNODE(usb, MASTER_USB, 0, SLAVE_DDR_EMI);
 DEFINE_MNODE(wifi, MASTER_WIFI, 0, SLAVE_DDR_EMI);
 DEFINE_MNODE(bt, MASTER_BT, 0, SLAVE_DDR_EMI);
@@ -156,7 +159,7 @@ static struct mtk_icc_node *mt6873_icc_nodes[] = {
 	[MT6873_MASTER_MDLASYS] = &mdlasys,
 	[MT6873_MASTER_MDLA_0] = &mdla_port_0,
 	[MT6873_MASTER_UFS] = &ufs,
-	[MT6873_MASTER_PCIE] = &pcie,
+	[MT6873_MASTER_PCIE] = &pcie_0,
 	[MT6873_MASTER_USB] = &usb,
 	[MT6873_MASTER_WIFI] = &wifi,
 	[MT6873_MASTER_BT] = &bt,
@@ -179,10 +182,52 @@ static struct mtk_icc_desc mt6873_icc = {
 	.num_nodes = ARRAY_SIZE(mt6873_icc_nodes),
 };
 
+static struct mtk_icc_node *mt8195_icc_nodes[] = {
+	[MT8195_SLAVE_DDR_EMI] = &ddr_emi,
+	[MT8195_MASTER_MCUSYS] = &mcusys,
+	[MT8195_MASTER_GPUSYS] = &gpu,
+	[MT8195_MASTER_MMSYS] = &mmsys,
+	[MT8195_MASTER_MM_VPU] = &mm_vpu,
+	[MT8195_MASTER_MM_DISP] = &mm_disp,
+	[MT8195_MASTER_MM_VDEC] = &mm_vdec,
+	[MT8195_MASTER_MM_VENC] = &mm_venc,
+	[MT8195_MASTER_MM_CAM] = &mm_cam,
+	[MT8195_MASTER_MM_IMG] = &mm_img,
+	[MT8195_MASTER_MM_MDP] = &mm_mdp,
+	[MT8195_MASTER_VPUSYS] = &vpusys,
+	[MT8195_MASTER_VPU_0] = &vpu_port_0,
+	[MT8195_MASTER_VPU_1] = &vpu_port_1,
+	[MT8195_MASTER_MDLASYS] = &mdlasys,
+	[MT8195_MASTER_MDLA_0] = &mdla_port_0,
+	[MT8195_MASTER_UFS] = &ufs,
+	[MT8195_MASTER_PCIE_0] = &pcie_0,
+	[MT8195_MASTER_PCIE_1] = &pcie_1,
+	[MT8195_MASTER_USB] = &usb,
+	[MT8195_MASTER_WIFI] = &wifi,
+	[MT8195_MASTER_BT] = &bt,
+	[MT8195_MASTER_NETSYS] = &netsys,
+	[MT8195_MASTER_DBGIF] = &dbgif,
+	[MT8195_SLAVE_HRT_DDR_EMI] = &hrt_ddr_emi,
+	[MT8195_MASTER_HRT_MMSYS] = &hrt_mmsys,
+	[MT8195_MASTER_HRT_MM_DISP] = &hrt_mm_disp,
+	[MT8195_MASTER_HRT_MM_VDEC] = &hrt_mm_vdec,
+	[MT8195_MASTER_HRT_MM_VENC] = &hrt_mm_venc,
+	[MT8195_MASTER_HRT_MM_CAM] = &hrt_mm_cam,
+	[MT8195_MASTER_HRT_MM_IMG] = &hrt_mm_img,
+	[MT8195_MASTER_HRT_MM_MDP] = &hrt_mm_mdp,
+	[MT8195_MASTER_HRT_DBGIF] = &hrt_dbgif,
+};
+
+static struct mtk_icc_desc mt8195_icc = {
+	.nodes = mt8195_icc_nodes,
+	.num_nodes = ARRAY_SIZE(mt8195_icc_nodes),
+};
+
 static const struct of_device_id emi_icc_of_match[] = {
 	{ .compatible = "mediatek,mt8183-dvfsrc", .data = &mt8183_icc },
 	{ .compatible = "mediatek,mt8192-dvfsrc", .data = &mt6873_icc },
 	{ .compatible = "mediatek,mt6873-dvfsrc", .data = &mt6873_icc },
+	{ .compatible = "mediatek,mt8195-dvfsrc", .data = &mt8195_icc },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, emi_icc_of_match);
-- 
2.14.1

