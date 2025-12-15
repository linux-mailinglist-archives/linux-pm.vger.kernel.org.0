Return-Path: <linux-pm+bounces-39497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA1CBC5CD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 04:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 325A83005FF1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 03:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E303731A554;
	Mon, 15 Dec 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qwoQzAkc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE4F2D1303;
	Mon, 15 Dec 2025 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770608; cv=none; b=UnfUyxfDSRSksNxMw2k7vrhxW8DBbOoy+LMH23fMgfnl0acc1FmNZ3xPBia68fKTRXwLJ9xLrYrRZjcxyIhTRFdLgWhJO7FvcKanuQBT5zeI7lSNGdFREMbA81pQz7NpENidAYoZJyJhJUkwlGBI0r8nWkFeh3ZTgxgPCPLss8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770608; c=relaxed/simple;
	bh=qpCHQwk5EAwlgwVvvAIKWkbsUDUiVBaoGuPGzjzVT/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIX3fgMU0Nz6gGZKuBJ9Fxq4Q73sYs0B+jw7jgfP9j/g8aC53eA8OANEqjUUc6NDgG92UgFJM6Gg+QDv1ZJU38ZlA1FI5pWCdyHNKeYbE3xd6LjqmLDmJrRSZtuvZsRgafsmpWLho6HyOH0C/X4zwsh/SAHTcOsfn6fgnKVlBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qwoQzAkc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1ccda784d96911f0b2bf0b349165d6e0-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ky1zZSMuLCXdFrRW4pfETufvBbUtfeJ1wcUYAYF3cTY=;
	b=qwoQzAkcABgQCvCuC1SARkY5n+LJDldmlX2f/GvC5bIc4Q8rFNjSy0AjG06XMXfBAcWeqrVtbGMtKArQcigOcDREX0ij5Oeq0peRCcxMdxWGPd31ZCc5uu078pKP/bLQ07V5SVr1VWxNAnCTfFzwn6c8Nb3a75cn/G5nZJvdmLI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a80e4931-6da7-4ae7-890f-e8fedf162106,IP:0,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:bc078528-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:1,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1ccda784d96911f0b2bf0b349165d6e0-20251215
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1460289980; Mon, 15 Dec 2025 11:49:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 11:49:51 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 11:49:51 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Richard Cochran <richardcochran@gmail.com>
CC: Qiqi Wang <qiqi.wang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <irving-ch.lin@mediatek.com>
Subject: [PATCH v4 02/21] dt-bindings: power: mediatek: Add MT8189 power domain definitions
Date: Mon, 15 Dec 2025 11:49:11 +0800
Message-ID: <20251215034944.2973003-3-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251215034944.2973003-1-irving-ch.lin@mediatek.com>
References: <20251215034944.2973003-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add device tree bindings for the power domains of MediaTek MT8189 SoC.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 .../power/mediatek,power-controller.yaml      |  1 +
 .../dt-bindings/power/mediatek,mt8189-power.h | 38 +++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index f8a13928f615..443c227c0e51 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -31,6 +31,7 @@ properties:
       - mediatek,mt8183-power-controller
       - mediatek,mt8186-power-controller
       - mediatek,mt8188-power-controller
+      - mediatek,mt8189-power-controller
       - mediatek,mt8192-power-controller
       - mediatek,mt8195-power-controller
       - mediatek,mt8196-hwv-hfrp-power-controller
diff --git a/include/dt-bindings/power/mediatek,mt8189-power.h b/include/dt-bindings/power/mediatek,mt8189-power.h
new file mode 100644
index 000000000000..70a8c2113457
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt8189-power.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8189_POWER_H
+#define _DT_BINDINGS_POWER_MT8189_POWER_H
+
+/* SPM */
+#define MT8189_POWER_DOMAIN_CONN			0
+#define MT8189_POWER_DOMAIN_AUDIO			1
+#define MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT		2
+#define MT8189_POWER_DOMAIN_ADSP_INFRA			3
+#define MT8189_POWER_DOMAIN_ADSP_AO			4
+#define MT8189_POWER_DOMAIN_MM_INFRA			5
+#define MT8189_POWER_DOMAIN_ISP_IMG1			6
+#define MT8189_POWER_DOMAIN_ISP_IMG2			7
+#define MT8189_POWER_DOMAIN_ISP_IPE			8
+#define MT8189_POWER_DOMAIN_VDE0			9
+#define MT8189_POWER_DOMAIN_VEN0			10
+#define MT8189_POWER_DOMAIN_CAM_MAIN			11
+#define MT8189_POWER_DOMAIN_CAM_SUBA			12
+#define MT8189_POWER_DOMAIN_CAM_SUBB			13
+#define MT8189_POWER_DOMAIN_MDP0			14
+#define MT8189_POWER_DOMAIN_DISP			15
+#define MT8189_POWER_DOMAIN_DP_TX			16
+#define MT8189_POWER_DOMAIN_CSI_RX			17
+#define MT8189_POWER_DOMAIN_SSUSB			18
+#define MT8189_POWER_DOMAIN_MFG0			19
+#define MT8189_POWER_DOMAIN_MFG1			20
+#define MT8189_POWER_DOMAIN_MFG2			21
+#define MT8189_POWER_DOMAIN_MFG3			22
+#define MT8189_POWER_DOMAIN_EDP_TX_DORMANT		23
+#define MT8189_POWER_DOMAIN_PCIE			24
+#define MT8189_POWER_DOMAIN_PCIE_PHY			25
+
+#endif /* _DT_BINDINGS_POWER_MT8189_POWER_H */
-- 
2.45.2


