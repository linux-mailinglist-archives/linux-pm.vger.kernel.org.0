Return-Path: <linux-pm+bounces-23602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2A5A55EF2
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E80D165C2B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D301A3164;
	Fri,  7 Mar 2025 03:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bFCdijrc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD031C84B1;
	Fri,  7 Mar 2025 03:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319124; cv=none; b=h+RHtpT2hs/EUyAFmqeuxsfDuQ2Z6lA0d0N762LTbSoHdk/8vx/PzPieOfCoQ4dpLVzVANt+BbhV/RKD96b/q3SpE7lRIx6jFENBBxEpXb70pcTqeBvsbqdbFjEciBPin6YWTSbPULPKGgovL+cw9AMwccxrcD0S00rB+tRsJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319124; c=relaxed/simple;
	bh=p12yr5PVT9SpzuvmYYeVw9cW02ceoqsyKFWxgZRCoW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rsy6Vs6qDFrAJBwsAfM9IXMIb2gYdwdxkwe3a7jUYM5ipYoQwteyltkZHPjVue/HZzELuuZupPiqCkw18sMVZR0T0pk52yS+iuc4YxNg+aWRKIXyRpv3MGhdN1yT4SoquKJKTUkpYri9VvUQw8P84WkYOCFfUmhNuFs/EQxbc7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bFCdijrc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 95443cd8fb0611efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qumIpB+kVpG6gvbiFFQaY5Jw4ejkYJF4eb7SNbkp7Us=;
	b=bFCdijrc3wbdphgEXi99el15lx9gB7db5Wj3ZJU5QQCcbPAOyu2/NP5UCzGjkRi01xtTIG/olDznrTi8omspFnSprIexJATid2jP8qHYgoN9iP+5ElK+USF7ShGs5z0nxs/E4pH9D45uLIwehs2TBA3NZ/d4PCMPuTZh8e7eG88=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:168e263e-0254-4df9-92d6-bfa36f5da0a4,IP:0,UR
	L:25,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:ae8e21ce-23b9-4c94-add0-e827a7999e28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,
	IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 95443cd8fb0611efaae1fd9735fae912-20250307
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 891763110; Fri, 07 Mar 2025 11:45:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:45:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:45:06 +0800
From: Guangjie Song <guangjie.song@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, Guangjie Song <guangjie.song@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 12/13] dt-bindings: power: mediatek: Add new MT8196 power domain
Date: Fri, 7 Mar 2025 11:44:36 +0800
Message-ID: <20250307034454.12243-13-guangjie.song@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250307034454.12243-1-guangjie.song@mediatek.com>
References: <20250307034454.12243-1-guangjie.song@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the binding documentation for power domain on MediaTek MT8196.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 .../mediatek,mt8196-power-controller.yaml     | 74 +++++++++++++++++++
 include/dt-bindings/power/mt8196-power.h      | 57 ++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml
 create mode 100644 include/dt-bindings/power/mt8196-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml
new file mode 100644
index 000000000000..6c2867b25967
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/mediatek,mt8196-power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT8196 Power Domains Controller
+
+maintainers:
+  - Guangjie Song <guangjie.song@mediatek.com>
+
+description: |
+  Mediatek processors include support for multiple power domains which can be
+  powered up/down by software based on different application scenes to save power.
+
+properties:
+  $nodename:
+    pattern: '^power-controller(@[0-9a-f]+)?$'
+
+  compatible:
+    enum:
+      - mediatek,mt8196-scpsys
+      - mediatek,mt8196-hfrpsys
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    description: Address range of the power controller.
+
+  clocks:
+    description: |
+      A number of phandles to clocks that need to be enabled during domain
+      power-up sequencing.
+
+  clock-names:
+    description: |
+      List of names of clock.
+
+  domain-supply:
+    description: domain regulator supply.
+
+  spm:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the device containing the spm register range.
+
+  mmpc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the device containing the mmpc register range.
+
+  vote-regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the device containing the vote register range.
+
+  mm-vote-regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the device containing the mm-vote register range.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/power/mt8196-power.h>
+
+    scpsys: power-controller@1c004000 {
+      compatible = "mediatek,mt8196-scpsys", "syscon";
+      reg = <0 0x1c004000 0 0x1000>;
+      #power-domain-cells = <1>;
+      spm = <&scpsys_bus>;
+      vote-regmap = <&vote>;
+    };
diff --git a/include/dt-bindings/power/mt8196-power.h b/include/dt-bindings/power/mt8196-power.h
new file mode 100644
index 000000000000..b0db89cc435d
--- /dev/null
+++ b/include/dt-bindings/power/mt8196-power.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Chong-ming Wei <chong-ming.wei@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8196_POWER_H
+#define _DT_BINDINGS_POWER_MT8196_POWER_H
+
+/* SPM */
+#define MT8196_POWER_DOMAIN_CONN			0
+#define MT8196_POWER_DOMAIN_SSUSB_P0			1
+#define MT8196_POWER_DOMAIN_SSUSB_DP_PHY_P0		2
+#define MT8196_POWER_DOMAIN_SSUSB_P1			3
+#define MT8196_POWER_DOMAIN_SSUSB_P23			4
+#define MT8196_POWER_DOMAIN_SSUSB_PHY_P2		5
+#define MT8196_POWER_DOMAIN_PEXTP_MAC0			6
+#define MT8196_POWER_DOMAIN_PEXTP_MAC1			7
+#define MT8196_POWER_DOMAIN_PEXTP_MAC2			8
+#define MT8196_POWER_DOMAIN_PEXTP_PHY0			9
+#define MT8196_POWER_DOMAIN_PEXTP_PHY1			10
+#define MT8196_POWER_DOMAIN_PEXTP_PHY2			11
+#define MT8196_POWER_DOMAIN_ADSP_AO			12
+#define MT8196_POWER_DOMAIN_ADSP_INFRA			13
+#define MT8196_POWER_DOMAIN_AUDIO			14
+#define MT8196_POWER_DOMAIN_ADSP_TOP_DORMANT		15
+#define MT8196_POWER_DOMAIN_MM_PROC_DORMANT		16
+#define MT8196_POWER_DOMAIN_SSR				17
+#define MT8196_SPM_POWER_DOMAIN_NR			18
+
+/* MMPC */
+#define MT8196_POWER_DOMAIN_MM_INFRA_AO			0
+#define MT8196_POWER_DOMAIN_MM_INFRA0			1
+#define MT8196_POWER_DOMAIN_MM_INFRA1			2
+#define MT8196_POWER_DOMAIN_VDE_VCORE0			3
+#define MT8196_POWER_DOMAIN_VDE0			4
+#define MT8196_POWER_DOMAIN_VDE1			5
+#define MT8196_POWER_DOMAIN_VEN0			6
+#define MT8196_POWER_DOMAIN_VEN1			7
+#define MT8196_POWER_DOMAIN_VEN2			8
+#define MT8196_POWER_DOMAIN_DISP_VCORE			9
+#define MT8196_POWER_DOMAIN_DIS0_DORMANT		10
+#define MT8196_POWER_DOMAIN_DIS1_DORMANT		11
+#define MT8196_POWER_DOMAIN_OVL0_DORMANT		12
+#define MT8196_POWER_DOMAIN_OVL1_DORMANT		13
+#define MT8196_POWER_DOMAIN_DISP_EDPTX_DORMANT		14
+#define MT8196_POWER_DOMAIN_DISP_DPTX_DORMANT		15
+#define MT8196_POWER_DOMAIN_MML0_SHUTDOWN		16
+#define MT8196_POWER_DOMAIN_MML1_SHUTDOWN		17
+#define MT8196_POWER_DOMAIN_CSI_BS_RX			18
+#define MT8196_POWER_DOMAIN_CSI_LS_RX			19
+#define MT8196_POWER_DOMAIN_DSI_PHY0			20
+#define MT8196_POWER_DOMAIN_DSI_PHY1			21
+#define MT8196_POWER_DOMAIN_DSI_PHY2			22
+#define MT8196_MMPC_POWER_DOMAIN_NR			23
+
+#endif /* _DT_BINDINGS_POWER_MT8196_POWER_H */
-- 
2.45.2


