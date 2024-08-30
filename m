Return-Path: <linux-pm+bounces-13232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5E96603F
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 13:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1C8283667
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734461B1D6F;
	Fri, 30 Aug 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VjHZeoP5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824321AF4F6;
	Fri, 30 Aug 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016130; cv=none; b=rYm2KefX0x7pZqHDdi4WJ2uzsKKvlCsDMi02L7IXavyZE8Kk7g5AUOG/48LqDK/HT2J5chziBKBw6UDqs7fycIr+UpNvMwMt5VFAMHeBm2nowUHAeLw0DedZYOKyrBhZcyMhLYbmws0PHINeWEHmiPB5ZLi2ZG2bKNUNDIOJzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016130; c=relaxed/simple;
	bh=OskdadYSBniy59J/B8pssmzHKi1W6jxxpM+Kpb6xMAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hJRg5PyD7ZTRq25JHt1ua5ktQfkgZgIGsQO6+OFxlDqGbIMzpekNGMbIhXCY0QIMVLMka1D2xYIv9HddpgyuC++I0ZkYKD5/uiSLOGMoMlqilYJ+giUKOTYVt8omI4X8WW7twPZJ9osaxYwdK7Yg72hoquid33dXsdtxLx9XvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VjHZeoP5; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f177d8866c011ef8593d301e5c8a9c0-20240830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+ZuaROA05xOwCgrg04nVtZlCJoL6KxuioAV548mb4iY=;
	b=VjHZeoP54mVXeljjcrfhM2RnMv0vzaMMlzf/mkhUMz3EPu/KTaWVwm46pMHRMJGGpSh5vfbxSr169UH9rrisroC+xVnIy966/AHR0375vhW2kSnjdaRpe1pb2APqBvefRffcYEBWnjyUuUiVwGFxEFWRaNsEZsyd4hwAmm1uno0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:74057d2e-326c-408d-85c2-177caa42b983,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:7b840d15-737d-40b3-9394-11d4ad6e91a1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2f177d8866c011ef8593d301e5c8a9c0-20240830
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1642187719; Fri, 30 Aug 2024 19:08:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 30 Aug 2024 19:08:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 30 Aug 2024 19:08:27 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-leds@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pavel Machek
	<pavel@ucw.cz>, Sean Wang <sean.wang@mediatek.com>, Lee Jones
	<lee@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>, Flora Fu
	<flora.fu@mediatek.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, "Sen
 Chu" <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 1/7] regulator: dt-bindings: mt6323: Convert to DT schema
Date: Fri, 30 Aug 2024 19:07:26 +0800
Message-ID: <20240830110732.30080-1-macpaul.lin@mediatek.com>
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
X-TM-AS-Result: No-10--4.091500-8.000000
X-TMASE-MatchedRID: RW3m2Qp1xFwvRbVu13x7nlPjo7D4SFg4sEf8CpnIYtl94pGHg55PylNU
	LV2RZwualTJXKqh1ne1M8qdoCvOVvms/tFw6ZTQWcX5PeMxy2v7tHf8AgB256HX+rbovv1tMEXF
	HklABLo7C9TF0oEZxDBEDiHAifYwNjZZBLO7fNfcVglQa/gMvfPFx/IAdCCsIw1fpjG5NXlPidW
	eecA3MU90WfWtP9mSp87a7Bu2IJjQwz9CL2iwNjev8QGaI25e3ecvjbu/xDjrdyIjG+fPOFQBRX
	ardzXy/3VN4WLcWL3CAMuqetGVetr9k4V4N5ceA3QfwsVk0UbsIoUKaF27lxcQe/TIqw3r0dk1n
	RhTthZYKarVqF8KXqPraJkfnyRmOra8oL3QbfoHTgs+SgeKJSC3P1ZDD2vxYNPuvbxytpP5yohc
	6UMvtn2mnnl9kOWyvfhxj8HsmpdphnVHs1efQx0GaYJdwrIUUnqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.091500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6A3AF234029412BE79B3B58FF620F809531CA447479DF10AA1BA799CFEF1F9572000:8
X-MTK: N

Convert this from the old style text based binding to the new DT schema
style.

The examples have been trimmed down and move to parent schema
mfd/mediatek,mt6397.yaml.

Add new maintainers and submitter from MediaTek.

Signed-off-by: Sen Chu <sen.chu@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../regulator/mediatek,mt6323-regulator.yaml  |  84 +++++++
 .../bindings/regulator/mt6323-regulator.txt   | 237 ------------------
 2 files changed, 84 insertions(+), 237 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6323-regulator.txt

Changes for v1 and v2:
 - This is the first version of converting mt6323-regulator.
   This is because converting mt6323-regulator together
   with mfd/mediatek,mt6397.yaml, so we've create a patch set
   instead of single patch for each skydives.
 - This patch has been made base on linux-next/master git repo.

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
new file mode 100644
index 0000000..f7c2a03
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
@@ -0,0 +1,84 @@
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
+description:
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
+  "^(buck_)?v(pa|proc|sys)$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?v(camio|cn18)$":
+    description: LDO with fixed 1.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?v((io|rf)18)$":
+    description: LDOs with fixed 1.825V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?v(a|rtc|tcxo|(cn|io)28)$":
+    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?vusb$":
+    description: LDOs with fixed 3.3V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?v(cn33_(bt|wifi))$":
+    description: LDOs with variable 3.3V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?v(cama|camaf|camd|emc3v3|gp[123]|ibr|m|mc|mch|sim[12])$":
+    description: LDOs with variable output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
deleted file mode 100644
index a48749d..0000000
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


