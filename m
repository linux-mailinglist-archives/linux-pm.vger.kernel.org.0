Return-Path: <linux-pm+bounces-14345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D256C97A4F4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 17:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539DF1F22844
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D415A864;
	Mon, 16 Sep 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gNTd6lIR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F0158DB9;
	Mon, 16 Sep 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499512; cv=none; b=XtVKC262KpGihzIGUUFVmvFqF6HKnmmBiK1XWodykVtyAbiWaEjL3PlNseAR013d20KtCLbn9esAwCDZTnCaq4FPW1+Qo0V+Lu3tFcJ4yHjTtztvXhE4S4SN4u2UuBQdLGHIVrR320h3aCK0LKKr0fJ+0jh2eAlw3TXjN71vDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499512; c=relaxed/simple;
	bh=yvVfd/7euSqF8cY2F+jCcr0j6OaI07JCiafybuO4u5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVK45Qlax+xspTDlAQAyV1dM7KX9nljW6PXETPw/D12NJRHIjeTQ4/E5sA0oDRcBnOlggeJV2DLyBQK5f6AjfnxXB4SQ9JkaoQI6TyPkL+nsLxZhuelNuEWTMRXp/XCup9QAaA1dYeT+zLQD4ltBIZqXNAU4GmKILh3FrcDS0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gNTd6lIR; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: faefe7ee743d11efb66947d174671e26-20240916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fDb8GageY0J6SFHos0kdBsDFYKXlbdO+4O9uWY7vMls=;
	b=gNTd6lIRwFXh9gpg7bgKmQM8A43sVX2pf7ph1qObMhnlEkbrOs5r5N76wGuOyBQ/FQkjo8M+ic4DQ3Hv68ypxnAXTkNaUojmFEbrX/6OuwYAtNX8M8ddW9RHPuWFuelwZmTS7VdZEtZd5bfrViPiXiWWVfZmEtUbZxDD5t6B1Kw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:12f68258-5bdb-435e-8c5e-d55aa208c0fc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:f4774ad0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: faefe7ee743d11efb66947d174671e26-20240916
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1138255172; Mon, 16 Sep 2024 23:11:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Sep 2024 08:11:40 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Sep 2024 23:11:40 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sean Wang
	<sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>, Macpaul Lin
	<macpaul.lin@mediatek.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee
 Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Chen Zhong <chen.zhong@mediatek.com>,
	<linux-input@vger.kernel.org>, <linux-leds@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v5 3/3] regulator: dt-bindings: mt6397: move examples to parent PMIC mt6397
Date: Mon, 16 Sep 2024 23:11:32 +0800
Message-ID: <20240916151132.32321-3-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240916151132.32321-1-macpaul.lin@mediatek.com>
References: <20240916151132.32321-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Since the DT schema of multiple function PMIC mt6397 has been converted,
move the examples in "mediatek,mt6397-regulator.yaml" to the parent schema
"mediatek,mt6397.yaml".

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../regulator/mediatek,mt6397-regulator.yaml  | 173 ------------------
 1 file changed, 173 deletions(-)

Changes for v1 and v2:
 - This is the first version of converting rtc-mt6397.txt.
   This is because converting rtc-mt6397 together
   with mfd/mediatek,mt6397.yaml, so we've create a patch set
   instead of submitting single patch for each subdevice.
 - This patch has been made base on linux-next/master git repo.

Changes for v3:
 - Re-order this patch since other patches for removing text DT bindings
   in v2 qill be squash into MFD patch.

Changes for v4:
 - No change.

Changes for v5:
 - No change. Fix the belonging to the same patch set.

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


