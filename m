Return-Path: <linux-pm+bounces-37706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D6C45C3D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 10:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48291885979
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42E1301475;
	Mon, 10 Nov 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pXJ+QqkS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6F267B15;
	Mon, 10 Nov 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768600; cv=none; b=FYAWJIH/upPBtV6w4G+Q8Gu7GX/wFKuY+bqeY6FJ+xu2C3EJ2NJquPM6D/8YusjE/Yrmd1tWfz1DhHD56gXHpRqIY5OGxXGq9w81RqSQ9GoMrR5o13fKuq5aXVP2HoccWJf81O9xoZTa5Mp5qw5EZ7yPiqeF/Htfed8zOvYq4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768600; c=relaxed/simple;
	bh=swW7TOBMmKcgpkmEdMUi1YfPPrfBJeDOkqoyf2cMsUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiEAD+PW7RhxY7sf1xpKK/idfSSqFLj/mGOTbVddBg+Lv4GIfJGAqcIhON9QlPeozGCLxG/Je1FVeyGE8Au6f7WKtIa/eo6OAAjptHywy+PZokJqHl7sJawbmH/g2SF5DUhFyAY2jPzF+0qOlj5/tr/P5YUPSSTXmojIDGj/UXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pXJ+QqkS; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6da623b8be1911f08ac0a938fc7cd336-20251110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ic475uJbFcT8+E9COGM5NCJGCeZj28Xt3Kt3L0wn1y0=;
	b=pXJ+QqkSAS1iTWyZuIaNiOekj/flL/NJ4rLGOKGGUXon1TmrkUKP0CiXRFUF4mvNnAOKQU/BiJfZc2cIAPFwvZkw/Bb7sh6Ohr06G0w91C786oU0M7tcvH2mRv+PDMpDTlc2y6dhmc4cwgYYWGGz81CoPLd2uFk66iuBX2bjyFM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5ac79c94-51d4-4ed7-ad9e-5f381876254d,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:9be67a82-b6af-4b29-9981-6bf838f9504d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6da623b8be1911f08ac0a938fc7cd336-20251110
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <hanchien.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1507956883; Mon, 10 Nov 2025 17:41:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 10 Nov 2025 17:41:22 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 10 Nov 2025 17:41:22 +0800
From: Hanchien Lin <hanchien.lin@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Balsam
 CHIHI <bchihi@baylibre.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <hanchien.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<raymond.sun@mediatek.com>, <Irving-CH.lin@mediatek.com>
Subject: [PATCH 1/2] arm64: dts: mediatek: mt8189: Add thermal controller node
Date: Mon, 10 Nov 2025 17:40:38 +0800
Message-ID: <20251110094113.3965182-2-hanchien.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251110094113.3965182-1-hanchien.lin@mediatek.com>
References: <20251110094113.3965182-1-hanchien.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add device tree node for the thermal controller on MediaTek MT8189 SoC.

Signed-off-by: Hanchien Lin <hanchien.lin@mediatek.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        | 27 +++++++++++++++++--
 .../thermal/mediatek,lvts-thermal.h           | 20 ++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index 0259cd3ce9c5..0f7fd69f5fdf 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -22,6 +22,8 @@ properties:
       - mediatek,mt8186-lvts
       - mediatek,mt8188-lvts-ap
       - mediatek,mt8188-lvts-mcu
+      - mediatek,mt8189-lvts-ap
+      - mediatek,mt8189-lvts-mcu
       - mediatek,mt8192-lvts-ap
       - mediatek,mt8192-lvts-mcu
       - mediatek,mt8195-lvts-ap
@@ -58,6 +60,21 @@ properties:
 allOf:
   - $ref: thermal-sensor.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8189-lvts-ap
+              - mediatek,mt8189-lvts-mcu
+    then:
+      properties:
+        nvmem-cells:
+          minItems: 2
+
+        nvmem-cell-names:
+          minItems: 2
+
   - if:
       properties:
         compatible:
@@ -75,6 +92,10 @@ allOf:
         nvmem-cell-names:
           maxItems: 1
 
+      required:
+        - clocks
+        - resets
+
   - if:
       properties:
         compatible:
@@ -91,12 +112,14 @@ allOf:
         nvmem-cell-names:
           minItems: 2
 
+      required:
+        - clocks
+        - resets
+
 required:
   - compatible
   - reg
   - interrupts
-  - clocks
-  - resets
   - nvmem-cells
   - nvmem-cell-names
 
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index ddc7302a510a..6c9103dfdc2d 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -42,6 +42,26 @@
 #define MT8188_AP_CAM1		6
 #define MT8188_AP_CAM2		7
 
+#define MT8189_MCU_BIG_CPU1     0
+#define MT8189_MCU_BIG_CPU2     1
+#define MT8189_MCU_BIG_CPU3     2
+#define MT8189_MCU_BIG_CPU4     3
+#define MT8189_MCU_LITTLE_CPU1  4
+#define MT8189_MCU_LITTLE_CPU2  5
+#define MT8189_MCU_LITTLE_CPU3  6
+#define MT8189_MCU_LITTLE_CPU4  7
+#define MT8189_MCU_LITTLE_CPU5  8
+#define MT8189_MCU_LITTLE_CPU6  9
+#define MT8189_MCU_LITTLE_CPU7  10
+#define MT8189_MCU_LITTLE_CPU8  11
+
+#define MT8189_AP_SOC1          12
+#define MT8189_AP_SOC2          13
+#define MT8189_AP_SOC3          14
+#define MT8189_AP_APU           15
+#define MT8189_AP_GPU1          16
+#define MT8189_AP_GPU2          17
+
 #define MT8195_MCU_BIG_CPU0     0
 #define MT8195_MCU_BIG_CPU1     1
 #define MT8195_MCU_BIG_CPU2     2
-- 
2.45.2


