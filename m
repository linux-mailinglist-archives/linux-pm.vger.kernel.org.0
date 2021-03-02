Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37A232A29F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Mar 2021 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376852AbhCBIPk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 03:15:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41032 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1574553AbhCBDrt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 22:47:49 -0500
X-UUID: af1f8da6480c4134a3f641f1d6ad1bdf-20210302
X-UUID: af1f8da6480c4134a3f641f1d6ad1bdf-20210302
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1901152504; Tue, 02 Mar 2021 11:47:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Mar 2021 11:47:45 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Mar 2021 11:47:45 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V9 07/12] dt-bindings: interconnect: add MT6873 interconnect dt-bindings
Date:   Tue, 2 Mar 2021 11:47:38 +0800
Message-ID: <1614656863-8530-8-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614656863-8530-1-git-send-email-henryc.chen@mediatek.com>
References: <1614656863-8530-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect provider dt-bindings for MT6873.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 include/dt-bindings/interconnect/mtk,mt6873-emi.h | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/mtk,mt6873-emi.h

diff --git a/include/dt-bindings/interconnect/mtk,mt6873-emi.h b/include/dt-bindings/interconnect/mtk,mt6873-emi.h
new file mode 100644
index 0000000..0b20011
--- /dev/null
+++ b/include/dt-bindings/interconnect/mtk,mt6873-emi.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_MTK_MT6873_EMI_H
+#define __DT_BINDINGS_INTERCONNECT_MTK_MT6873_EMI_H
+
+#define MT6873_SLAVE_DDR_EMI		0
+#define MT6873_MASTER_MCUSYS		1
+#define MT6873_MASTER_GPUSYS		2
+#define MT6873_MASTER_MMSYS		3
+#define MT6873_MASTER_MM_VPU		4
+#define MT6873_MASTER_MM_DISP		5
+#define MT6873_MASTER_MM_VDEC		6
+#define MT6873_MASTER_MM_VENC		7
+#define MT6873_MASTER_MM_CAM		8
+#define MT6873_MASTER_MM_IMG		9
+#define MT6873_MASTER_MM_MDP		10
+#define MT6873_MASTER_VPUSYS		11
+#define MT6873_MASTER_VPU_0		12
+#define MT6873_MASTER_VPU_1		13
+#define MT6873_MASTER_MDLASYS		14
+#define MT6873_MASTER_MDLA_0		15
+#define MT6873_MASTER_UFS		16
+#define MT6873_MASTER_PCIE		17
+#define MT6873_MASTER_USB		18
+#define MT6873_MASTER_DBGIF		19
+#define MT6873_SLAVE_HRT_DDR_EMI	20
+#define MT6873_MASTER_HRT_MMSYS		21
+#define MT6873_MASTER_HRT_MM_DISP	22
+#define MT6873_MASTER_HRT_MM_VDEC	23
+#define MT6873_MASTER_HRT_MM_VENC	24
+#define MT6873_MASTER_HRT_MM_CAM	25
+#define MT6873_MASTER_HRT_MM_IMG	26
+#define MT6873_MASTER_HRT_MM_MDP	27
+#define MT6873_MASTER_HRT_DBGIF		28
+#define MT6873_MASTER_WIFI		29
+#define MT6873_MASTER_BT		30
+#define MT6873_MASTER_NETSYS		31
+#endif
-- 
1.9.1

