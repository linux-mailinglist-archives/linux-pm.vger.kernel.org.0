Return-Path: <linux-pm+bounces-32536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFECB2A0FD
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 14:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C68B1701F8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2331CA54;
	Mon, 18 Aug 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PfqFXmYz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8C2E228E;
	Mon, 18 Aug 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518287; cv=none; b=cMB9R2deHk5ciHCzxGitjnI2IyJ85Mc9hSw0UkucctbjBLDQMzJvctvgjbN0p31mOe7n9c7B/COdm100TLqVUiPgk8F24HqM9EYArnW4tojM7UKwVAZnwIRb3svup941fdxTzNZFaB6iETG/JBBE/s+NeZv9ka06krNNjZYe6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518287; c=relaxed/simple;
	bh=YMdUmsBr9K3IFyLhq1F+TJ4XRdzUXjwh0B4mSGARz5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bn8NjeblQYOJR/ALxDZ14lA+Fd5y/GvJ1prss16aHJifcHTriKnb+6XFA8ZbEWyTuHOSMrGe6LfyBvG9OorWCdyUbmWucq4silT+r1zH8eZl1VRciXnXx2cyGrllVTIdjeh2HRtA8X7F36xsVLu6MJtl+rP5VtPQuIvK/DlXjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PfqFXmYz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 969afe5a7c2a11f0b33aeb1e7f16c2b6-20250818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HJ675xvY1PWuPSyC/B/bQZWRSZsn1mga7uIsxOCUypw=;
	b=PfqFXmYz50eQN0tExI4acsQ/V3p5ftqwQ3+oCs8XJ0rat8lJV3wcAsOImT5JitwG+ZsIci3XV14hjtFclQFbd/53ApKlTm/IGiLxcjNF4+Gq6Ei8gtPDzKWnaaikCJDL6Z67oViza28zqqe7yIR9eJdn1i03X/QKpdwkU1qedeg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:f11f6162-4e60-472d-8a39-cbf07d9ffc6a,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:f1326cf,CLOUDID:d50c417a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:11|97|99|83|106|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 969afe5a7c2a11f0b33aeb1e7f16c2b6-20250818
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 397038784; Mon, 18 Aug 2025 19:58:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 18 Aug 2025 19:57:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 18 Aug 2025 19:57:59 +0800
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
Subject: [PATCH 1/6] dt-bindings: clock: mediatek: Add new MT8189 clock
Date: Mon, 18 Aug 2025 19:57:29 +0800
Message-ID: <20250818115754.1067154-2-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
References: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-ch Lin <irving-ch.lin@mediatek.com>

Add the new binding documentation for system clock
and functional clock on MediaTek MT8189.

Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
---
 .../bindings/clock/mediatek,mt8189-clock.yaml | 89 +++++++++++++++++++
 .../clock/mediatek,mt8189-sys-clock.yaml      | 58 ++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
new file mode 100644
index 000000000000..d0d887861a49
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt8189-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Functional Clock Controller for MT8189
+
+maintainers:
+  - Qiqi Wang <qiqi.wang@mediatek.com>
+
+description: |
+  The clock architecture in MediaTek like below
+  PLLs -->
+          dividers -->
+                      muxes -->
+                               clock gate
+
+  The devices provide clock gate control in different IP blocks.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8189-camsys-main
+      - mediatek,mt8189-camsys-rawa
+      - mediatek,mt8189-camsys-rawb
+      - mediatek,mt8189-dbg-ao
+      - mediatek,mt8189-dem
+      - mediatek,mt8189-dispsys
+      - mediatek,mt8189-dvfsrc-top
+      - mediatek,mt8189-gce-d
+      - mediatek,mt8189-gce-m
+      - mediatek,mt8189-iic-wrap-e
+      - mediatek,mt8189-iic-wrap-en
+      - mediatek,mt8189-iic-wrap-s
+      - mediatek,mt8189-iic-wrap-ws
+      - mediatek,mt8189-imgsys1
+      - mediatek,mt8189-imgsys2
+      - mediatek,mt8189-infra-ao
+      - mediatek,mt8189-ipesys
+      - mediatek,mt8189-mdpsys
+      - mediatek,mt8189-mfgcfg
+      - mediatek,mt8189-mm-infra
+      - mediatek,mt8189-peri-ao
+      - mediatek,mt8189-scp-clk
+      - mediatek,mt8189-scp-i2c-clk
+      - mediatek,mt8189-ufscfg-ao
+      - mediatek,mt8189-ufscfg-pdn
+      - mediatek,mt8189-vdec-core
+      - mediatek,mt8189-venc
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8189-peri-ao
+              - mediatek,mt8189-ufscfg-ao
+              - mediatek,mt8189-ufscfg-pdn
+
+    then:
+      required:
+        - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    imp_iic_wrap_ws_clk@11b21000 {
+        compatible = "mediatek,mt8189-iic-wrap-ws";
+        reg = <0 0x11b21000 0 0x1000>;
+        #clock-cells = <1>;
+    };
+
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml
new file mode 100644
index 000000000000..0d27ff807e79
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt8189-sys-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek System Clock Controller for MT8189
+
+maintainers:
+  - Qiqi Wang <qiqi.wang@mediatek.com>
+
+description: |
+  The clock architecture in MediaTek like below
+  PLLs -->
+          dividers -->
+                      muxes -->
+                               clock gate
+
+  The apmixedsys provides most of PLLs which generated from SoC 26m.
+  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
+  The infracfg_ao provides clock gate in peripheral and infrastructure IP blocks.
+  The mcusys provides mux control to select the clock source in AP MCU.
+  The device nodes also provide the system control capacity for configuration.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8189-apmixedsys
+          - mediatek,mt8189-topckgen
+          - mediatek,mt8189-vlp-ckgen
+          - mediatek,mt8189-vlp-ao-ckgen
+          - mediatek,mt8189-vlpcfg-reg-bus
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    topckgen_clk@10000000 {
+        compatible = "mediatek,mt8189-topckgen", "syscon";
+        reg = <0 0x10000000 0 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.45.2


