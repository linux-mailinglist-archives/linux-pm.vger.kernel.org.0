Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE53EA148
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhHLJAy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 05:00:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59856 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235642AbhHLJAw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 05:00:52 -0400
X-UUID: 4f4b54ccfd684bd39521850dc22d145e-20210812
X-UUID: 4f4b54ccfd684bd39521850dc22d145e-20210812
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1248039440; Thu, 12 Aug 2021 17:00:23 +0800
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
Subject: [V11,PATCH 11/19] dt-bindings: interconnect: add MT8195 interconnect dt-bindings
Date:   Thu, 12 Aug 2021 16:58:38 +0800
Message-ID: <20210812085846.2628-12-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210812085846.2628-1-dawei.chien@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect provider dt-bindings for MT8195

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 include/dt-bindings/interconnect/mtk,mt8195-emi.h | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/mtk,mt8195-emi.h

diff --git a/include/dt-bindings/interconnect/mtk,mt8195-emi.h b/include/dt-bindings/interconnect/mtk,mt8195-emi.h
new file mode 100644
index 000000000000..c7e8b805f8bd
--- /dev/null
+++ b/include/dt-bindings/interconnect/mtk,mt8195-emi.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_MTK_MT8195_EMI_H
+#define __DT_BINDINGS_INTERCONNECT_MTK_MT8195_EMI_H
+
+#define MT8195_SLAVE_DDR_EMI		0
+#define MT8195_MASTER_MCUSYS		1
+#define MT8195_MASTER_GPUSYS		2
+#define MT8195_MASTER_MMSYS		3
+#define MT8195_MASTER_MM_VPU		4
+#define MT8195_MASTER_MM_DISP		5
+#define MT8195_MASTER_MM_VDEC		6
+#define MT8195_MASTER_MM_VENC		7
+#define MT8195_MASTER_MM_CAM		8
+#define MT8195_MASTER_MM_IMG		9
+#define MT8195_MASTER_MM_MDP		10
+#define MT8195_MASTER_VPUSYS		11
+#define MT8195_MASTER_VPU_0		12
+#define MT8195_MASTER_VPU_1		13
+#define MT8195_MASTER_MDLASYS		14
+#define MT8195_MASTER_MDLA_0		15
+#define MT8195_MASTER_UFS		16
+#define MT8195_MASTER_PCIE_0		17
+#define MT8195_MASTER_PCIE_1		18
+#define MT8195_MASTER_USB		19
+#define MT8195_MASTER_DBGIF		20
+#define MT8195_SLAVE_HRT_DDR_EMI	21
+#define MT8195_MASTER_HRT_MMSYS		22
+#define MT8195_MASTER_HRT_MM_DISP	23
+#define MT8195_MASTER_HRT_MM_VDEC	24
+#define MT8195_MASTER_HRT_MM_VENC	25
+#define MT8195_MASTER_HRT_MM_CAM	26
+#define MT8195_MASTER_HRT_MM_IMG	27
+#define MT8195_MASTER_HRT_MM_MDP	28
+#define MT8195_MASTER_HRT_DBGIF		29
+#define MT8195_MASTER_WIFI		30
+#define MT8195_MASTER_BT		31
+#define MT8195_MASTER_NETSYS		32
+#endif
-- 
2.14.1

