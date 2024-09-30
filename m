Return-Path: <linux-pm+bounces-14918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533DF989B9A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 09:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E077281F1B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 07:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD04174EF0;
	Mon, 30 Sep 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d7Wljr6W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DAE21105;
	Mon, 30 Sep 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681617; cv=none; b=pgiLdk3TRqi4KfRVtvAxa3cOvVCPzEIideoMb+kCF1nRQ2m1Biz0JdLBoEIRLDaMdRjKmDc5TJE5kCQLAQZsiM0kbQ2TOidOxGbG8gujIywpzTx31byg70l97oPY6VFkAUffxfYy6kKf0Hiz4BK/z9LQSob5Qa2PmVsg3RdDd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681617; c=relaxed/simple;
	bh=ulb7SVi7+4GKBH6JW/SE2/fwBqEZHiY9eWeuIzy4fG8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h7LDNqeoc0LTdRS2eElS3dZ9x1Xli7UO6+WDXY3ohK5IeKdHSWVqCa9klCSMuPtt+DuWg07JHKritJWC5876qm6fAlDnXRyceL/tXNdyxpZTFM1QzrHimYZAMc7jzCG5oT/pUogcmui13GoMnoC6HR5iKECkGGJYnm3Cv4jTbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=d7Wljr6W; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 49014af27efe11efb66947d174671e26-20240930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yL9JqR+BFvINtlYz9jX9qN8EvegSyLh4KUmuDwRbc1E=;
	b=d7Wljr6Wm9eXmXiNPmiHa7xggL/KrdbM5VET/9d4xVl1mHUDCRXESlXgSY4KyiqzYiEwFaADjLtYoPVWH8+gPQJOMsLKzKxFKJMSMWevo5ioYSKDtoTdUP9q6Ix5IX9wXGb05r0YICbDt3eod8oW3uHFn8RQAhaI1inzaal5THM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:dd8485f6-8990-4b26-ac41-06987fa337c8,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:2ec4fad0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 49014af27efe11efb66947d174671e26-20240930
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2018959055; Mon, 30 Sep 2024 15:33:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Sep 2024 15:33:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Sep 2024 15:33:24 +0800
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
Subject: [PATCH v7 1/3] regulator: dt-bindings: mt6323: Convert to DT schema
Date: Mon, 30 Sep 2024 15:33:09 +0800
Message-ID: <20240930073311.1486-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.775800-8.000000
X-TMASE-MatchedRID: rqAGkD2w4rALazoQyrpm0ooLoibgjVEXh8Ytn75ClDPOxDyJFXIPjmm0
	zqcSNzI+8iNHpqH9BdjTpx8mj0GpKQHvpLYTRPZ4Y1bQMCMvmn4wCmrLlx+Sdd9RlPzeVuQQMKw
	CZ7huGiEtIcNCL+1lT0qohIki/gPvkp3MQm5vY0TBHegFRxbaY7LiLKO9VZOifOWG5jDwmxMz+z
	kqltke7OmWBKsiZNKd3veZzBQV6KiPIr9Wpu0YXDCaEJt46PppKx5ICGp/WtGbcemyPxDuGskmY
	eWQx/93hLY3PF3U/qHY07Y6b1ctIAAwGIAo3Shb71Wx2uUbPLcK3n1SHen81XrSpK2Q9yJIlAb6
	jlt7Eoqb5RM17I4NiRLddYGwB868IFwS3+Vi9Qv0GVr4t9dXB3nL427v8Q463ciIxvnzzhUAUV2
	q3c18v91TeFi3Fi9wgDLqnrRlXra/ZOFeDeXHgN0H8LFZNFG7hqz53n/yPnr3J15GPtQSEsIVJJ
	jLKVtu9Go/tRqCKEROsiAIDA495HaZp1RYI3/x
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.775800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2BEDFE244C3F732BF9B161E571D9799ECD431959D14DA502898D3E36593E37EC2000:8
X-MTK: N

Convert the MT6323 regulator binding from the old text-based format to
the new DT schema style. The property "regulator-name" has been added
as required property to reflect current usage in mt6323.dtsi.

Examples have been streamlined and relocated to the parent schema file:
  mfd/mediatek,mt6397.yaml.

Update maintainer and submitter information with new entries from MediaTek.

The reference document cited in "mediatek,mt7530.yaml" has been updated
to point to this new DT schema file

Signed-off-by: Sen Chu <sen.chu@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/net/dsa/mediatek,mt7530.yaml     |   4 +-
 .../regulator/mediatek,mt6323-regulator.yaml  | 119 +++++++++
 .../bindings/regulator/mt6323-regulator.txt   | 237 ------------------
 3 files changed, 121 insertions(+), 239 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6323-regulator.txt

Changes for v1 and v2:
 - This is the first version of converting mt6323-regulator.
   This is because converting mt6323-regulator together
   with mfd/mediatek,mt6397.yaml, so we've create a patch set
   instead of single patch for each skydives.
 - This patch has been made base on linux-next/master git repo.

Changes for v3:
 - Rebased on linux-next/master git repo near next-20240906.
 - Added 'regulator-name' to 'requried' property to reflect current usage.
 - replace ^(buck_)? and ^(ldo_)? to ^buck_ and ^ldo_ prefix.
 - Update file name of 'mediatek,mt6323-regulator.yaml' in
   'mediatek,mt7530.yaml'

Changes for v4:
 - No change.

Changes for v5:
 - Add "Reviewed-by" in commit message. Thanks for the review!
 - Remove a blank line at EOF whcih causes whitespace warning
   when 'git am' the patch.

Changes for v6:
 - No change.

Change for v7:
 - Add "Acked-by" tag, Thanks for the review.

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index ea979bcae1d6..413db386f090 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -129,8 +129,8 @@ properties:
   io-supply:
     description: |
       Phandle to the regulator node necessary for the I/O power.
-      See Documentation/devicetree/bindings/regulator/mt6323-regulator.txt for
-      details for the regulator setup on these boards.
+      See Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
+      for details for the regulator setup on these boards.
 
   mediatek,mcm:
     type: boolean
diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
new file mode 100644
index 000000000000..9bc9aa9a4eb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6323-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6323 Regulator
+
+maintainers:
+  - John Crispin <john@phrozen.org>
+  - Sen Chu <sen.chu@mediatek.com>
+  - Macpaul Lin <macpaul.lin@mediatek.com>
+
+description: |
+  Regulator node of the PMIC. This node should under the PMIC's device node.
+  All voltage regulators provided by the PMIC are described as sub-nodes of
+  this node.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt6323-regulator
+
+patternProperties:
+  "^buck_v(pa|proc|sys)$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(camio|cn18)$":
+    description: LDO with fixed 1.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v((io|rf)18)$":
+    description: LDOs with fixed 1.825V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(a|rtc|tcxo|(cn|io)28)$":
+    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(usb)$":
+    description: LDOs with fixed 3.3V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(cn33_(bt|wifi))$":
+    description: LDOs with variable 3.3V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(cama|camaf|camd|emc3v3|gp[123]|ibr|m|mc|mch|sim[12])$":
+    description: LDOs with variable output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
deleted file mode 100644
index a48749db4df3..000000000000
--- a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
+++ /dev/null
@@ -1,237 +0,0 @@
-Mediatek MT6323 Regulator
-
-All voltage regulators are defined as subnodes of the regulators node. A list
-of regulators provided by this controller are defined as subnodes of the
-PMIC's node. Each regulator is named according to its regulator type,
-buck_<name> and ldo_<name>. The definition for each of these nodes is defined
-using the standard binding for regulators at
-Documentation/devicetree/bindings/regulator/regulator.txt.
-
-The valid names for regulators are::
-BUCK:
-  buck_vproc, buck_vsys, buck_vpa
-LDO:
-  ldo_vtcxo, ldo_vcn28, ldo_vcn33_bt, ldo_vcn33_wifi, ldo_va, ldo_vcama,
-  ldo_vio28, ldo_vusb, ldo_vmc, ldo_vmch, ldo_vemc3v3, ldo_vgp1, ldo_vgp2,
-  ldo_vgp3, ldo_vcn18, ldo_vsim1, ldo_vsim2, ldo_vrtc, ldo_vcamaf, ldo_vibr,
-  ldo_vrf18, ldo_vm, ldo_vio18, ldo_vcamd, ldo_vcamio
-
-Example:
-
-	pmic: mt6323 {
-		mt6323regulator: regulators {
-			mt6323_vproc_reg: buck_vproc{
-				regulator-name = "vproc";
-				regulator-min-microvolt = < 700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <12500>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vsys_reg: buck_vsys{
-				regulator-name = "vsys";
-				regulator-min-microvolt = <1400000>;
-				regulator-max-microvolt = <2987500>;
-				regulator-ramp-delay = <25000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vpa_reg: buck_vpa{
-				regulator-name = "vpa";
-				regulator-min-microvolt = < 500000>;
-				regulator-max-microvolt = <3650000>;
-			};
-
-			mt6323_vtcxo_reg: ldo_vtcxo{
-				regulator-name = "vtcxo";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <90>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vcn28_reg: ldo_vcn28{
-				regulator-name = "vcn28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <185>;
-			};
-
-			mt6323_vcn33_bt_reg: ldo_vcn33_bt{
-				regulator-name = "vcn33_bt";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-enable-ramp-delay = <185>;
-			};
-
-			mt6323_vcn33_wifi_reg: ldo_vcn33_wifi{
-				regulator-name = "vcn33_wifi";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-enable-ramp-delay = <185>;
-			};
-
-			mt6323_va_reg: ldo_va{
-				regulator-name = "va";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vcama_reg: ldo_vcama{
-				regulator-name = "vcama";
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vio28_reg: ldo_vio28{
-				regulator-name = "vio28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vusb_reg: ldo_vusb{
-				regulator-name = "vusb";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-boot-on;
-			};
-
-			mt6323_vmc_reg: ldo_vmc{
-				regulator-name = "vmc";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <36>;
-				regulator-boot-on;
-			};
-
-			mt6323_vmch_reg: ldo_vmch{
-				regulator-name = "vmch";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <36>;
-				regulator-boot-on;
-			};
-
-			mt6323_vemc3v3_reg: ldo_vemc3v3{
-				regulator-name = "vemc3v3";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <36>;
-				regulator-boot-on;
-			};
-
-			mt6323_vgp1_reg: ldo_vgp1{
-				regulator-name = "vgp1";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vgp2_reg: ldo_vgp2{
-				regulator-name = "vgp2";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vgp3_reg: ldo_vgp3{
-				regulator-name = "vgp3";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vcn18_reg: ldo_vcn18{
-				regulator-name = "vcn18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vsim1_reg: ldo_vsim1{
-				regulator-name = "vsim1";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vsim2_reg: ldo_vsim2{
-				regulator-name = "vsim2";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vrtc_reg: ldo_vrtc{
-				regulator-name = "vrtc";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vcamaf_reg: ldo_vcamaf{
-				regulator-name = "vcamaf";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vibr_reg: ldo_vibr{
-				regulator-name = "vibr";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <36>;
-			};
-
-			mt6323_vrf18_reg: ldo_vrf18{
-				regulator-name = "vrf18";
-				regulator-min-microvolt = <1825000>;
-				regulator-max-microvolt = <1825000>;
-				regulator-enable-ramp-delay = <187>;
-			};
-
-			mt6323_vm_reg: ldo_vm{
-				regulator-name = "vm";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vio18_reg: ldo_vio18{
-				regulator-name = "vio18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vcamd_reg: ldo_vcamd{
-				regulator-name = "vcamd";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vcamio_reg: ldo_vcamio{
-				regulator-name = "vcamio";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-		};
-	};
-- 
2.45.2


