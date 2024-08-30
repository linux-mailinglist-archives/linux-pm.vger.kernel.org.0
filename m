Return-Path: <linux-pm+bounces-13227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D1796601A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA62281252
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D771A4ADF;
	Fri, 30 Aug 2024 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dic4pOi+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5917BB05;
	Fri, 30 Aug 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016120; cv=none; b=KW6npBgziMyO4zD5KL1z+7NfkXyZ/tLvai00Ah6AL2/LiCeaZeb5dEXv3FriJaEcLZF+9YEf1sVEQojuJTvObk/d/MrxouDpuAkmm08t+zSwW8dfxqD1u8fkTLjekayBMLR8qUlPVm1Onj01mQ51/iKQon7wxgjNiPg0wfke7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016120; c=relaxed/simple;
	bh=qOC4TBOBuW6HCGLzt3qzrbqGIA9efWutGacPlUcdpZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMJSzEkHlSErKwC8xeWHHqimV1wVxGki/mz5rTAU3b024xCfchlDoBmQosbqO1GPlalkOu382aaTpKtaqqz7WOMfQKDnEmCJnipmQYr63YGQVMbxk/iLpPnvG5wx4KlKY5kN8YehezUDq2tP0nvJKAQOvyGapCLwq5tTVBHm1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dic4pOi+; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2fc9594a66c011ef8b96093e013ec31c-20240830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JWhruOowdkt/xBKckPdvEO46w+VbVE01+k4IFay5Duo=;
	b=dic4pOi+/CGinFmEVVrfKGicVEXmHYtQaraZtaWqLNVGAGIsVdWaRp9OdPHxnQky1GiVqfyfSE1FwI0g2sXQt1OiGbjV7+QHfPQ3zAGLky0dooUEpz//YoBeYWPyNKOfsSh2rU2g1YTxeqDUNg6uTs5dHBoG8K2fn5UF0+RD8FE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ca1ca494-e93e-415a-94c7-33e2146bc35c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:21356fcf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2fc9594a66c011ef8b96093e013ec31c-20240830
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1657210181; Fri, 30 Aug 2024 19:08:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 30 Aug 2024 19:08:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 30 Aug 2024 19:08:28 +0800
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
Subject: [PATCH v2 4/7] regulator: dt-bindings: mt6397: move examples to parent PMIC mt6397
Date: Fri, 30 Aug 2024 19:07:29 +0800
Message-ID: <20240830110732.30080-4-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240830110732.30080-1-macpaul.lin@mediatek.com>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.489100-8.000000
X-TMASE-MatchedRID: TppObWSVeSiPrjM/ltMU+Y+emiGnyeDRVF5mUd6sIMbfUZT83lbkEBtA
	A+CBZv6P43HhQBEsO8hLaej5cOCHCX1GcR5AeEs7jtK7dC6UBnnBDQIKmpUdLA6QlBHhBZuwRNV
	ChCiT7kXi8zVgXoAltsIJ+4gwXrEtWBd6ltyXuvuzqv2VdKUl4FE3sN7Nviwbly5S0NU4MuKBVz
	1+3BoxSbEsIkxFFKdNGE8UYfOPeBLxLPoefjwkXf5US5F30eUjAq3Qx0stoeaElVGWRzS6/kYFe
	h7KssddUGjjbmeia+IPZN5fBGmCHKL6Q11UB8yDftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.489100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	243F2C20DAC08D69B20AF17960D5A3ADDE63DC1516FD9DED60C26D6642384E772000:8
X-MTK: N

Since the DT schema of multiple function PMIC mt6397 has been converted,
move the examples in "mediatek,mt6397-regulator.yaml" to the parent schema
"mediatek,mt6397.yaml".

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../regulator/mediatek,mt6397-regulator.yaml  | 173 ------------------
 1 file changed, 173 deletions(-)

Changes for v1 and v2:
 - This is because reviewer suggest complete examples in parent device (MFD)
   as could as possible. Hence we've just move the examples to parent
   mfd/mediatek,mt6397.yaml. So we've create a patch set
   instead of submitting single patch for each subdevice.
 - This patch has been made base on linux-next/master git repo.

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
index 50db678..337ac58 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
@@ -63,176 +63,3 @@ required:
 
 additionalProperties: false
 
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-    mt6397_regulators: regulators {
-        compatible = "mediatek,mt6397-regulator";
-
-        mt6397_vpca15_reg: buck_vpca15 {
-            regulator-name = "vpca15";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <200>;
-        };
-
-        mt6397_vpca7_reg: buck_vpca7 {
-            regulator-name = "vpca7";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vsramca15_reg: buck_vsramca15 {
-            regulator-name = "vsramca15";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vsramca7_reg: buck_vsramca7 {
-            regulator-name = "vsramca7";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vcore_reg: buck_vcore {
-            regulator-name = "vcore";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vgpu_reg: buck_vgpu {
-            regulator-name = "vgpu";
-            regulator-min-microvolt = < 700000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vdrm_reg: buck_vdrm {
-            regulator-name = "vdrm";
-            regulator-min-microvolt = < 800000>;
-            regulator-max-microvolt = <1400000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <500>;
-        };
-
-        mt6397_vio18_reg: buck_vio18 {
-            regulator-name = "vio18";
-            regulator-min-microvolt = <1500000>;
-            regulator-max-microvolt = <2120000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <500>;
-        };
-
-        mt6397_vtcxo_reg: ldo_vtcxo {
-            regulator-name = "vtcxo";
-            regulator-min-microvolt = <2800000>;
-            regulator-max-microvolt = <2800000>;
-            regulator-enable-ramp-delay = <90>;
-        };
-
-        mt6397_va28_reg: ldo_va28 {
-            regulator-name = "va28";
-            /* fixed output 2.8 V */
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vcama_reg: ldo_vcama {
-            regulator-name = "vcama";
-            regulator-min-microvolt = <1500000>;
-            regulator-max-microvolt = <2800000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vio28_reg: ldo_vio28 {
-            regulator-name = "vio28";
-            /* fixed output 2.8 V */
-            regulator-enable-ramp-delay = <240>;
-        };
-
-        mt6397_usb_reg: ldo_vusb {
-            regulator-name = "vusb";
-            /* fixed output 3.3 V */
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vmc_reg: ldo_vmc {
-            regulator-name = "vmc";
-            regulator-min-microvolt = <1800000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vmch_reg: ldo_vmch {
-            regulator-name = "vmch";
-            regulator-min-microvolt = <3000000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vemc_3v3_reg: ldo_vemc3v3 {
-            regulator-name = "vemc_3v3";
-            regulator-min-microvolt = <3000000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp1_reg: ldo_vgp1 {
-            regulator-name = "vcamd";
-            regulator-min-microvolt = <1220000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <240>;
-        };
-
-        mt6397_vgp2_reg: ldo_vgp2 {
-            regulator-name = "vcamio";
-            regulator-min-microvolt = <1000000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp3_reg: ldo_vgp3 {
-            regulator-name = "vcamaf";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp4_reg: ldo_vgp4 {
-            regulator-name = "vgp4";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp5_reg: ldo_vgp5 {
-            regulator-name = "vgp5";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3000000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp6_reg: ldo_vgp6 {
-            regulator-name = "vgp6";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vibr_reg: ldo_vibr {
-            regulator-name = "vibr";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-    };
-- 
2.45.2


