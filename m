Return-Path: <linux-pm+bounces-14916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E9F989B8A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 09:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63D91C215C6
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67836156F3C;
	Mon, 30 Sep 2024 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gWmFQxiP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0B13D8A4;
	Mon, 30 Sep 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681615; cv=none; b=byUme7oqJoU9aIAJkubP7DxhqXIN7FN4B4jtGk9KPC51+K/ZWSCZFhVBkGm7SY41bJv5HxQZsKZ/3RtdbbCTw0P3mg/pF+Kfp3FD2+lBxMBbuO9xyYxIA07WPPuC1Xrn5cyyyz/sBHqfjt5eWPJeWdY4D9T19GSGsbWLPNXtoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681615; c=relaxed/simple;
	bh=2kUuEFQUl5B2eNq61qTOn/tI/N1cOAn4CvOrHdbmdgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ep+YOyVp73jJjsxk92JrZemJK58Fd98m1uC2pMhCmCLfvZYv3+tklMqWQdRnUTMji/tBd6xV4ThZ30LRMOGzvmLBfiLog4tR5tC6S62kiNwnUZqn/JE9qVLTHpZGvoYTIY2RTVZejpdCkSm9OulW1dazFArUk3XIlAI6jFsxSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gWmFQxiP; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 47893aae7efe11ef8b96093e013ec31c-20240930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KwWXCGAW/ByfoA2er9EQDpwMhHapKsGPkQ088kaxyr0=;
	b=gWmFQxiPxXRBZWxF6/VUcY6rT+gYITJ1itSSHxJmn+z77BIBRG4HeYUJJ37Ka16O+4E7JfrJ419TiENlu4+ahXUN7VQdUByFhk4KQ3MICsw+LEUj9huPoDwAgceF5L0zdfT48cMRH8KOvtNtrV09zRoZRjfwpR0yyjsb3aWgFm8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:58bba1e5-f74a-44c7-a7e6-38c213dae9cd,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:05c4fad0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 47893aae7efe11ef8b96093e013ec31c-20240930
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1730998133; Mon, 30 Sep 2024 15:33:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Sep 2024 15:33:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Sep 2024 15:33:24 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones
	<lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu
	<sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin
	<macpaul.lin@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian
 Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-sound@vger.kernel.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v7 2/3] ASoC: dt-bindings: mt6358: Convert to DT Schema
Date: Mon, 30 Sep 2024 15:33:10 +0800
Message-ID: <20240930073311.1486-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240930073311.1486-1-macpaul.lin@mediatek.com>
References: <20240930073311.1486-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Convert the MediaTek MT6358 Audio CODEC bindings to DT schema.

This change implements the following updates:
1. Compatible property: Added the const 'mediatek,mt6358-sound'
   to ensure alignment with the schema in the actual (DTS) file
   "mt8186-corsola.dtsi" with 'mediatek,mt6366-sound'.
2. Example: Removed the example section, as it should be relocated to
   the MT6397 PMIC file 'mfd/mediatek,mt6397.yaml'.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../devicetree/bindings/sound/mt6358.txt      | 26 ------------
 .../devicetree/bindings/sound/mt6358.yaml     | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt6358.yaml

Changess for v1~v6:
 - It was not in the origin patch set.

Changes for v7:
 - It is seperated from the origin patch set (2/2, v6).
   It could simplifies the audio-codec node in next patch (3/3, v7)
   of 'mfd/mediatek,mt6397.yaml'

diff --git a/Documentation/devicetree/bindings/sound/mt6358.txt b/Documentation/devicetree/bindings/sound/mt6358.txt
deleted file mode 100644
index fbe9e55c68f5..000000000000
--- a/Documentation/devicetree/bindings/sound/mt6358.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Mediatek MT6358 Audio Codec
-
-The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
-For more detail, please visit Mediatek PMIC wrapper documentation.
-
-Must be a child node of PMIC wrapper.
-
-Required properties:
-
-- compatible - "string" - One of:
-    "mediatek,mt6358-sound"
-    "mediatek,mt6366-sound"
-- Avdd-supply : power source of AVDD
-
-Optional properties:
-- mediatek,dmic-mode : Indicates how many data pins are used to transmit two
-	channels of PDM signal. 0 means two wires, 1 means one wire. Default
-	value is 0.
-
-Example:
-
-mt6358_snd {
-	compatible = "mediatek,mt6358-sound";
-	Avdd-supply = <&mt6358_vaud28_reg>;
-	mediatek,dmic-mode = <0>;
-};
diff --git a/Documentation/devicetree/bindings/sound/mt6358.yaml b/Documentation/devicetree/bindings/sound/mt6358.yaml
new file mode 100644
index 000000000000..5f7611e26a89
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt6358.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mt6358.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT6358 Audio Codec
+
+maintainers:
+  - Jiaxin Yu <jiaxin.yu@mediatek.com>
+  - Macpaul Lin <macpaul.lin@mediatek.com>
+
+description: |
+  The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
+  For more detail, please visit Mediatek PMIC wrapper documentation.
+  Must be a child node of PMIC wrapper.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6366-sound
+      - mediatek,mt6358-sound
+    const: mediatek,mt6358-sound
+
+  Avdd-supply:
+    description: Power source of AVDD
+
+  mediatek,dmic-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Indicates how many data pins are used to transmit two channels of PDM
+      signal. 0 means two wires, 1 means one wire. Default value is 0.
+    enum:
+      - 0 # two wires
+      - 1 # one wire
+
+required:
+  - compatible
+  - Avdd-supply
+
+additionalProperties: false
-- 
2.45.2


