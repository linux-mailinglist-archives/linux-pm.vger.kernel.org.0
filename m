Return-Path: <linux-pm+bounces-15018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1898B9F4
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1AA8B2282A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF4B1BE85D;
	Tue,  1 Oct 2024 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t7pcaRrs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67121BD4FF;
	Tue,  1 Oct 2024 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779371; cv=none; b=sHeVtY8NOnecWCUgUI4qY2cELjpOSXUZ3KNMLHknT2wSVk2HvctlGIi7SwbhKbuU3LK9DpBP0/9azZPVUu7az1y/ojQA67/k0AibFBVufouhVfpGuavxezE9QZM02e4/HCc4qQisNOGqCTLH1nRdSTbbspnkS5+Vl9xoiVJk/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779371; c=relaxed/simple;
	bh=dJs6EcxL4K8pt1yMgHkUTHHoTrM4ZNUfe5zYSZbGF8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9ZXB+SBsl+Kujbayknt6eTSoDii/njScoEAs3UJdnsAnHoQN1W62gjD64jDk+B8fz7QaDCygm79vztmO6LB3UVleQxmXOZWBqS6suHKgEC2DqSQwZFpoyWKETCHeXcUhiVxtP9M5fmj08hie9rY9nvkYmOtOD7MhGAHClcB/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t7pcaRrs; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e29438da7fe111efb66947d174671e26-20241001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9h2AN7Pq2LenjUFdInGpO8HzlSkTBGgn5u5KpjpvMF4=;
	b=t7pcaRrsAqKeEW/zl4z7w4t7BFIROuOt7SVnpDgGRyGJNKY6euPTdNGtOJMuGbaFKe61FL02acDnPt2whmfaSeEfjw+1XiH4ZHO3C4lkQ76cObfoPOdMAzv9oMZyNiwt1F4OejCsJD/jFBe0DZHPfS/z6RIRRoW33H02RUKGXq8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:3e198948-bdfa-4d8e-8ed6-c02ee9eca8df,IP:0,U
	RL:25,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:c66c0dd1-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e29438da7fe111efb66947d174671e26-20241001
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 369096409; Tue, 01 Oct 2024 18:42:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Oct 2024 18:42:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Oct 2024 18:42:37 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones
	<lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	"AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>, Sen
 Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin
	<macpaul.lin@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Sebastian
 Reichel" <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
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
Subject: [PATCH v8 2/3] ASoC: dt-bindings: mt6358: Convert to DT Schema
Date: Tue, 1 Oct 2024 18:41:44 +0800
Message-ID: <20241001104145.24054-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241001104145.24054-1-macpaul.lin@mediatek.com>
References: <20241001104145.24054-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.258200-8.000000
X-TMASE-MatchedRID: JuwS8u+P+pA1BACrQFB3pa+dYEguu4aVklihY7W5fUxUjspoiX02Fwn9
	ofQNoBQFt+ki9vYAWeaIJs0Up7vkWKo77AcuQhw7dARARTk4h59U+YqtAU+F2SgVbxW7FDOVHi5
	rbi6X2h2JTSQ4G0hWQLL0CwDGT5MlADAYgCjdKFvvVbHa5Rs8t1ObpRiWjuVrIsN8PGi3TSwRZc
	CYVXElTpwCAg0q+xEsSr0hcvT6aq8EdG16FO0c4qngbqTYC4GHy3fMd7pCml7FHcwKL6UE/596w
	YYIuKaFfKdRUvnWmGDApfx+k77KMl3IljUA3Oevk3ewifG2MNN9LQinZ4QefIWH8POvJNOW9zw4
	lzv7RUmOhzOa6g8KrbTiaXyQDQEp0UbSnLRuekR0IPWaIbWG/t0CF3bDbbc2OCk+r9kDgUo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.258200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CBCD299509747FDA9833C30EF7C0EDCC9C5364A8636212AAA745C74A5B310BA42000:8
X-MTK: N

Convert the MediaTek MT6358 Audio CODEC bindings to DT schema.

This change implements the following updates:
1. Compatible property: Added the const 'mediatek,mt6358-sound'
   to ensure alignment with the schema in the actual (DTS) file
   "mt8186-corsola.dtsi" with 'mediatek,mt6366-sound'.
2. Example: Removed the example section, as it should be relocated to
   the MT6397 PMIC file 'mfd/mediatek,mt6397.yaml'.
3. Use filename 'mediatek,mt6358-sound.yaml' to align the compatible
   name.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../bindings/sound/mediatek,mt6358-sound.yaml | 44 +++++++++++++++++++
 .../devicetree/bindings/sound/mt6358.txt      | 26 -----------
 2 files changed, 44 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt6358-sound.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt

Changess for v1~v6:
 - It was not in the origin patch set.

Changes for v7:
 - It is seperated from the origin patch set (2/2, v6).
   It could simplifies the audio-codec node in next patch (3/3, v7)
   of 'mfd/mediatek,mt6397.yaml'

Changes for v8:
 - Update compatible property with 'oneOf:' and 'items' syntax.
   Thanks for the suggestion.
 - Replace 'mt6358.yaml' with 'mediatek,mt6358-sound.yaml' to align
   the compatible name.

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6358-sound.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6358-sound.yaml
new file mode 100644
index 000000000000..36eb111f5746
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt6358-sound.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt6358-sound.yaml#
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
+    oneOf:
+      - enum:
+          - mediatek,mt6358-sound
+      - items:
+          - enum:
+              - mediatek,mt6366-sound
+          - const: mediatek,mt6358-sound
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
-- 
2.45.2


