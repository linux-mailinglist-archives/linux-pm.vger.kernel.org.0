Return-Path: <linux-pm+bounces-38450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A926DC801CB
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F05C4E406F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966A2FD1BE;
	Mon, 24 Nov 2025 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="DlCjuok2"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F72FF668;
	Mon, 24 Nov 2025 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982477; cv=pass; b=RwmedQyrYJGSLtvUaLq0MR8wvGOAn11XXh8vuiwcS9oj6P41hbnLP9EBrjGBlB5SusAPowL/wFZKVzQ9EGQ5RKfU1gA7Wh0onIxJ+N5aDuQ3Qsc2V+hzraMwduEb9IUX1xXONN1lWLfxFctg0jI2YLVY+0xXiN9DfEYlTlUsw+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982477; c=relaxed/simple;
	bh=ML/QbAT6wuODK9p64mxODmHtL+wQT+HxiQ+NdN8oXYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqSXyewyoNJ6apC/T9sJjPTnxzEPP4p2J7dHAs0zW59pPev0WtgN45TVrOZOkhQ34x89U4IgGxMZ0PGqE6KiyRguPx5qSb8CHyAEEE9wLgEM5T9KS0ZdBBomxuNWGM2xM0CbTx089b1yIDd0eDbMSsE1W5iIzixk19PoKWufRBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=DlCjuok2; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982455; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d1oDUos2HA5s5Qbyvbb1+z4ERO4MBk+x6v7aKIX6DD3mAPj3ncG0wBMiWlBLLprVTB8WkU3i3Ol/97HpcJ+l2oNCjEwAg7OgNi/fnFmJAaAvhvgPPc5pXwL/h9ZmurM9N4587/lAxDRxq9pTlAiQtqmpcSHgG3TC/Sr8kYMIakE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982455; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Iiq+HYCmnZ7TcdzmTbexqDQH56XfdBR2ZblfoMLBIoA=; 
	b=kVQHxJpV70E+mipZYoRedcBJu3o96p6imJHncUT9bsEOczmAA4D+niucFPItw4wALF74t6EfPWYBTLzL6MHoS2O4Qp3vDmRgBSrjDioZAmdvz0felAc4TCCZjTi6v6EOMRqZRhudTi8DpYY9ohkNIMqHpMVeKNCc0jIn0b+oJJk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982455;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Iiq+HYCmnZ7TcdzmTbexqDQH56XfdBR2ZblfoMLBIoA=;
	b=DlCjuok2x3mr2p2TjFTSvPF2ql7+rLYI2n0sUGdHTW2ytuFfBUaaGExuDL+0IbOU
	MJWt5D+90yb15xkrUU18KBVss4OinmjxZPLhK9FUhZMUYT7N6+2In/2GQJhGksv2Tmv
	nUjOEp56GLIHljWvxUaOMsP+Dzg1qB5kwyjv1aNg=
Received: by mx.zohomail.com with SMTPS id 1763982453777661.8440242348057;
	Mon, 24 Nov 2025 03:07:33 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:07:00 +0100
Subject: [PATCH v2 11/13] interconnect: mediatek: Add support for MediaTek
 MT8196 EMI ICC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-11-d9c1334db9f3@collabora.com>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
In-Reply-To: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add a new driver with data to register the External Memory
Interface (EMI) Interconnect on the MediaTek MT8196 Chromebook
SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/interconnect/mediatek/Kconfig  |   7 +
 drivers/interconnect/mediatek/Makefile |   1 +
 drivers/interconnect/mediatek/mt8196.c | 383 +++++++++++++++++++++++++++++++++
 3 files changed, 391 insertions(+)

diff --git a/drivers/interconnect/mediatek/Kconfig b/drivers/interconnect/mediatek/Kconfig
index 985c849efac3..9fd3f2170443 100644
--- a/drivers/interconnect/mediatek/Kconfig
+++ b/drivers/interconnect/mediatek/Kconfig
@@ -27,3 +27,10 @@ config INTERCONNECT_MTK_MT8195
 	help
 	  This is a driver for the MediaTek bus interconnect on MT8195-based
 	  platforms.
+
+config INTERCONNECT_MTK_MT8196
+	tristate "MediaTek MT8196 interconnect driver"
+	depends on INTERCONNECT_MTK_DVFSRC_EMI
+	help
+	  This is a driver for the MediaTek bus interconnect on MT8196-based
+	  platforms.
diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 8e2283a9a5b5..6bd656668f5d 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
diff --git a/drivers/interconnect/mediatek/mt8196.c b/drivers/interconnect/mediatek/mt8196.c
new file mode 100644
index 000000000000..e9af32065be1
--- /dev/null
+++ b/drivers/interconnect/mediatek/mt8196.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/interconnect/mediatek,mt8196.h>
+
+#include "icc-emi.h"
+
+static struct mtk_icc_node ddr_emi = {
+	.name = "ddr-emi",
+	.id = SLAVE_DDR_EMI,
+	.ep = 1,
+};
+
+static struct mtk_icc_node mcusys = {
+	.name = "mcusys",
+	.id = MASTER_MCUSYS,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node mcu_port0 = {
+	.name = "mcu-port0",
+	.id = MASTER_MCU_0,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node mcu_port1 = {
+	.name = "mcu-port1",
+	.id = MASTER_MCU_1,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node mcu_port2 = {
+	.name = "mcu-port2",
+	.id = MASTER_MCU_2,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node mcu_port3 = {
+	.name = "mcu-port3",
+	.id = MASTER_MCU_3,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node mcu_port4 = {
+	.name = "mcu-port4",
+	.id = MASTER_MCU_4,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node gpu = {
+	.name = "gpu",
+	.id = MASTER_GPUSYS,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node mmsys = {
+	.name = "mmsys",
+	.id = MASTER_MMSYS,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node mm_vpu = {
+	.name = "mm-vpu",
+	.id = MASTER_MM_VPU,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_MMSYS }
+};
+
+static struct mtk_icc_node mm_disp = {
+	.name = "mm-disp",
+	.id = MASTER_MM_DISP,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_MMSYS }
+};
+
+static struct mtk_icc_node mm_vdec = {
+	.name = "mm-vdec",
+	.id = MASTER_MM_VDEC,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_MMSYS }
+};
+
+static struct mtk_icc_node mm_venc = {
+	.name = "mm-venc",
+	.id = MASTER_MM_VENC,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_MMSYS }
+};
+
+static struct mtk_icc_node mm_cam = {
+	.name = "mm-cam",
+	.id = MASTER_MM_CAM,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_MMSYS }
+};
+
+static struct mtk_icc_node mm_img = {
+	.name = "mm-img",
+	.id = MASTER_MM_IMG,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_MMSYS }
+};
+
+static struct mtk_icc_node mm_mdp = {
+	.name = "mm-mdp",
+	.id = MASTER_MM_MDP,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_MMSYS }
+};
+
+static struct mtk_icc_node vpusys = {
+	.name = "vpusys",
+	.id = MASTER_VPUSYS,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node vpu_port0 = {
+	.name = "vpu-port0",
+	.id = MASTER_VPU_0,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_VPUSYS }
+};
+
+static struct mtk_icc_node vpu_port1 = {
+	.name = "vpu-port1",
+	.id = MASTER_VPU_1,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_VPUSYS }
+};
+
+static struct mtk_icc_node mdlasys = {
+	.name = "mdlasys",
+	.id = MASTER_MDLASYS,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node mdla_port0 = {
+	.name = "mdla-port0",
+	.id = MASTER_MDLA_0,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_MDLASYS }
+};
+
+static struct mtk_icc_node ufs = {
+	.name = "ufs",
+	.id = MASTER_UFS,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node pcie = {
+	.name = "pcie",
+	.id = MASTER_PCIE,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node usb = {
+	.name = "usb",
+	.id = MASTER_USB,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node wifi = {
+	.name = "wifi",
+	.id = MASTER_WIFI,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node bt = {
+	.name = "bt",
+	.id = MASTER_BT,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node netsys = {
+	.name = "netsys",
+	.id = MASTER_NETSYS,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node dbgif = {
+	.name = "dbgif",
+	.id = MASTER_DBGIF,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_DDR_EMI }
+};
+
+static struct mtk_icc_node hrt_ddr_emi = {
+	.name = "hrt-ddr-emi",
+	.id = SLAVE_HRT_DDR_EMI,
+	.ep = 2,
+};
+
+static struct mtk_icc_node hrt_mmsys = {
+	.name = "hrt-mmsys",
+	.id = MASTER_HRT_MMSYS,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_HRT_DDR_EMI }
+};
+
+static struct mtk_icc_node hrt_mm_disp = {
+	.name = "hrt-mm-disp",
+	.id = MASTER_HRT_MM_DISP,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_HRT_MMSYS }
+};
+
+static struct mtk_icc_node hrt_mm_vdec = {
+	.name = "hrt-mm-vdec",
+	.id = MASTER_HRT_MM_VDEC,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_HRT_MMSYS }
+};
+
+static struct mtk_icc_node hrt_mm_venc = {
+	.name = "hrt-mm-venc",
+	.id = MASTER_HRT_MM_VENC,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_HRT_MMSYS }
+};
+
+static struct mtk_icc_node hrt_mm_cam = {
+	.name = "hrt-mm-cam",
+	.id = MASTER_HRT_MM_CAM,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_HRT_MMSYS }
+};
+
+static struct mtk_icc_node hrt_mm_img = {
+	.name = "hrt-mm-img",
+	.id = MASTER_HRT_MM_IMG,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_HRT_MMSYS }
+};
+
+static struct mtk_icc_node hrt_mm_mdp = {
+	.name = "hrt-mm-mdp",
+	.id = MASTER_HRT_MM_MDP,
+	.ep = 0,
+	.num_links = 1,
+	.links = { MASTER_HRT_MMSYS }
+};
+
+static struct mtk_icc_node hrt_adsp = {
+	.name = "hrt-adsp",
+	.id = MASTER_HRT_ADSP,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_HRT_DDR_EMI }
+};
+
+static struct mtk_icc_node hrt_dbgif = {
+	.name = "hrt-dbgif",
+	.id = MASTER_HRT_DBGIF,
+	.ep = 0,
+	.num_links = 1,
+	.links = { SLAVE_HRT_DDR_EMI }
+};
+
+static struct mtk_icc_node *mt8196_emi_icc_nodes[] = {
+	[SLAVE_DDR_EMI] = &ddr_emi,
+	[MASTER_MCUSYS] = &mcusys,
+	[MASTER_MCU_0] = &mcu_port0,
+	[MASTER_MCU_1] = &mcu_port1,
+	[MASTER_MCU_2] = &mcu_port2,
+	[MASTER_MCU_3] = &mcu_port3,
+	[MASTER_MCU_4] = &mcu_port4,
+	[MASTER_GPUSYS] = &gpu,
+	[MASTER_MMSYS] = &mmsys,
+	[MASTER_MM_VPU] = &mm_vpu,
+	[MASTER_MM_DISP] = &mm_disp,
+	[MASTER_MM_VDEC] = &mm_vdec,
+	[MASTER_MM_VENC] = &mm_venc,
+	[MASTER_MM_CAM] = &mm_cam,
+	[MASTER_MM_IMG] = &mm_img,
+	[MASTER_MM_MDP] = &mm_mdp,
+	[MASTER_VPUSYS] = &vpusys,
+	[MASTER_VPU_0] = &vpu_port0,
+	[MASTER_VPU_1] = &vpu_port1,
+	[MASTER_MDLASYS] = &mdlasys,
+	[MASTER_MDLA_0] = &mdla_port0,
+	[MASTER_UFS] = &ufs,
+	[MASTER_PCIE] = &pcie,
+	[MASTER_USB] = &usb,
+	[MASTER_WIFI] = &wifi,
+	[MASTER_BT] = &bt,
+	[MASTER_NETSYS] = &netsys,
+	[MASTER_DBGIF] = &dbgif,
+	[SLAVE_HRT_DDR_EMI] = &hrt_ddr_emi,
+	[MASTER_HRT_MMSYS] = &hrt_mmsys,
+	[MASTER_HRT_MM_DISP] = &hrt_mm_disp,
+	[MASTER_HRT_MM_VDEC] = &hrt_mm_vdec,
+	[MASTER_HRT_MM_VENC] = &hrt_mm_venc,
+	[MASTER_HRT_MM_CAM] = &hrt_mm_cam,
+	[MASTER_HRT_MM_IMG] = &hrt_mm_img,
+	[MASTER_HRT_MM_MDP] = &hrt_mm_mdp,
+	[MASTER_HRT_ADSP] = &hrt_adsp,
+	[MASTER_HRT_DBGIF] = &hrt_dbgif
+};
+
+static struct mtk_icc_desc mt8196_emi_icc = {
+	.nodes = mt8196_emi_icc_nodes,
+	.num_nodes = ARRAY_SIZE(mt8196_emi_icc_nodes),
+};
+
+static const struct of_device_id mtk_mt8196_emi_icc_of_match[] = {
+	{ .compatible = "mediatek,mt8196-emi", .data = &mt8196_emi_icc },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mtk_mt8196_emi_icc_of_match);
+
+static struct platform_driver mtk_emi_icc_mt8196_driver = {
+	.driver = {
+		.name = "emi-icc-mt8196",
+		.of_match_table = mtk_mt8196_emi_icc_of_match,
+		.sync_state = icc_sync_state,
+	},
+	.probe = mtk_emi_icc_probe,
+	.remove = mtk_emi_icc_remove,
+
+};
+module_platform_driver(mtk_emi_icc_mt8196_driver);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("MediaTek MT8196 EMI ICC driver");
+MODULE_LICENSE("GPL");

-- 
2.52.0


