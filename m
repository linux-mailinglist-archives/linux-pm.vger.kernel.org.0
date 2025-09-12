Return-Path: <linux-pm+bounces-34549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88733B54CFE
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1923D164373
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36855310644;
	Fri, 12 Sep 2025 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GEY1p4Jh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8B30F52D;
	Fri, 12 Sep 2025 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678734; cv=none; b=YLyaX2yS4+GghUyq8qR9lJmY0865KoQ6ojN/NX6+Ut+qWLsmkMbRXY3EV7q/76iECip43v5tmQIwOzsyozcWiStQLZeU0e9rWvHLEAkFGzs7KdKtrQY4gNL22q5ekbkOxf8uLXGs0Xza6n4Y68qumX19KSYIaC2rtI5i6ewFMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678734; c=relaxed/simple;
	bh=lyqo58Y/5scZik5AufCwyekEQJ7YELOuwp9whW4r2X0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcDAB0OXxxuo36+lBSRX9PrDVwUqJaHytIs9rRQ14hHB8HpPqK2p1FR05urk6m7Jw/rsdt702Rk64ApdXUH6X+i/2x/zV8G8uhyXlNpY/9iHe9fiB3qNlAYVibySf6W55jYR2IwM2HSfNEKjs79nMMacjhrqDyxa618Fa1WWVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GEY1p4Jh; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c17aab028fd011f0b33aeb1e7f16c2b6-20250912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PGOeq4Spk0I0hBg16qA7n3LtACA8dH9IXI2vIvaYPUs=;
	b=GEY1p4Jh6pDnhzIY8vgJ65ScmapArEAv7p6PhX2/uckd3K5zjlgUh96SHSkKG0dumaq126jSBkklbzcqxZTZNBL0LFFsgQaUYqP04epjgW0UqrF9FzOQ47ZyCoRdLrkAJKp3zIDW8ej68lZbPyEfbdMTLjeSBnmSq+qx11zYalY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:a5a8d645-69a6-425b-bb6c-329d0b456f7a,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:1ca6b93,CLOUDID:05963bf8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:11|97|99|83|106|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c17aab028fd011f0b33aeb1e7f16c2b6-20250912
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 617917966; Fri, 12 Sep 2025 20:05:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 12 Sep 2025 20:05:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 12 Sep 2025 20:05:19 +0800
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
Subject: [PATCH v2 2/4] dt-bindings: power: mediatek: Add MT8189 power domain definitions
Date: Fri, 12 Sep 2025 20:04:51 +0800
Message-ID: <20250912120508.3180067-3-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
References: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-ch Lin <irving-ch.lin@mediatek.com>

Add device tree bindings for the power domains of MediaTek MT8189 SoC.
These definitions will be used to describe the power domain topology in
device tree sources.

Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
---
 .../mediatek,mt8189-power-controller.yaml     | 88 +++++++++++++++++++
 .../dt-bindings/power/mediatek,mt8189-power.h | 38 ++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
 create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
new file mode 100644
index 000000000000..71156f7edafe
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/mediatek,mt8189-power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Power Domains Controller for MT8189
+
+maintainers:
+  - Qiqi Wang <qiqi.wang@mediatek.com>
+
+description: |
+  MediaTek processors include support for multiple power domains which can be
+  powered up/down by software based on different application scenes to save power.
+
+  IP cores belonging to a power domain should contain a 'power-domains'
+  property that is a phandle for SCPSYS node representing the domain.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8189-scpsys
+
+  reg:
+    maxItems: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  clocks:
+    description: |
+      A number of phandles to clocks that need to be enabled during domain
+      power-up sequencing.
+
+  clock-names:
+    description: |
+      List of names of clocks, in order to match the power-up sequencing
+      for each power domain we need to group the clocks by name. BASIC
+      clocks need to be enabled before enabling the corresponding power
+      domain, and should not have a '-' in their name (i.e mm, mfg, venc).
+      SUSBYS clocks need to be enabled before releasing the bus protection,
+      and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
+
+      In order to follow properly the power-up sequencing, the clocks must
+      be specified by order, adding first the BASIC clocks followed by the
+      SUSBSYS clocks.
+
+patternProperties:
+  "^mfg[01]-supply$":
+    description: |
+      Regulator supply for mfg domain. With this attribute, scpsys can manage
+      mfg regulator in mtcmos control flow, to achieve low power scenario.
+
+required:
+  - compatible
+  - reg
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8189-clk.h>
+    #include <dt-bindings/power/mediatek,mt8189-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        scpsys: power-controller@1c001000 {
+            compatible = "mediatek,mt8189-scpsys";
+            reg = <0 0x1c001000 0 0x1000>;
+            #power-domain-cells = <1>;
+            clocks = /* MFG */
+                <&topckgen_clk CLK_TOP_MFG_REF_SEL>,
+                <&apmixedsys_clk CLK_APMIXED_MFGPLL>;
+            clock-names = "mfg", "mfg_top";
+            mfg0-supply = <&mt6359_vproc1_buck_reg>;
+            mfg1-supply = <&mt6359_vsram_proc1_ldo_reg>;
+        };
+
+        /* Example of module to register power domain */
+        gpu: gpu@13000000 {
+            reg = <0 0x13000000 0 0x4000>;
+            power-domains = <&scpsys MT8189_POWER_DOMAIN_MFG2>,
+                            <&scpsys MT8189_POWER_DOMAIN_MFG3>;
+            power-domain-names = "core0", "core1";
+        };
+    };
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


