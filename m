Return-Path: <linux-pm+bounces-39053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 604DAC9ACE4
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 10:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 234E24E3418
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDA630ACE6;
	Tue,  2 Dec 2025 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dwEpPBch"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421BD3081CA;
	Tue,  2 Dec 2025 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666721; cv=none; b=EwWR0x8uCYrDxOFfyVWy9TqzvgxsbdZv2XFh1qz43F6vlQQjdi+2eEuqR+iphUUmZl0G0DvoK3HWAiP0kFUWF4zSjIz/wvCGtEvzYpp/OUy5A/3B+7tjAi1njWCFiRePfIHZGpqN1KEhujt82vDog9x6HuB52O9qaCNjcrMbCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666721; c=relaxed/simple;
	bh=Z/pkoBIByNshDdcUZO6mjPnzSi9NmM9M4LTPMfi5mhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5SBzUE0i4VihGB4RVjYubkSkZ3bJCVVZCPMKaxXtdw0+vLOtk7ngADxuKgbHI2no6BnKSX2PoeQuWZ+mAjLCxfmkouqo/ux7iKUc41Of9/YBXj6rYvB4IKe0ded7owv4wAjZ1oQE5F63d3l5LtLIPhIvvHJco1Pc0RfAc3396Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dwEpPBch; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f1df01f8cf5e11f0b2bf0b349165d6e0-20251202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bysoBCjAnrkoe4Pzetvj/PacsOGbSB5otn6Vy8Aw52o=;
	b=dwEpPBchhRv/Bo2q2s1DuMeTYebrNHb1b6/ZSDAggKKF0vWYfTYeItjOvXEPWy5vtKgu+RJqs1MDyf4dQY+3afnciejaxLZ/GN+/IWL5Y+36tk3TkSCo0K6iCqAd2uOcCBNm8uQ5zqn93rZVqUzdyorm0ZJ5yFpB9FPhn8IcZdg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c4a743e7-7416-4249-876d-0dec9c2a3293,IP:0,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:f8df4f02-1fa9-44eb-b231-4afc61466396,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:1|19,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1df01f8cf5e11f0b2bf0b349165d6e0-20251202
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <hanchien.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1126379099; Tue, 02 Dec 2025 17:11:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 2 Dec 2025 17:11:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 2 Dec 2025 17:11:52 +0800
From: Hanchien Lin <hanchien.lin@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Balsam
 CHIHI <bchihi@baylibre.com>
CC: <Hanchien.lin@mediatek.com>, <Irving-CH.lin@mediatek.com>, Jh Hsu
	<Jh.Hsu@mediatek.com>, WH Wu <vincent.wu@mediatek.com>, Raymond Sun
	<Raymond.Sun@mediatek.com>, Sirius Wang <Sirius.Wang@mediatek.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Hanchien Lin
	<hanchien.lin@mediatek.com>
Subject: [PATCH v3 1/2] dt-bindings: thermal: mediatek: Add MT8189 LVTS thermal controller bindings
Date: Tue, 2 Dec 2025 17:10:55 +0800
Message-ID: <20251202091056.1761229-2-hanchien.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251202091056.1761229-1-hanchien.lin@mediatek.com>
References: <20251202091056.1761229-1-hanchien.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for the MediaTek MT8189 LVTS thermal controller to the device tree bindings.
This includes new compatible strings and required properties for MT8189.

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


