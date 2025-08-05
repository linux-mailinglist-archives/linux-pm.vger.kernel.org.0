Return-Path: <linux-pm+bounces-31944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65650B1AFBE
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CD217DC5D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81D6261581;
	Tue,  5 Aug 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="awWISSYv"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0A25A326;
	Tue,  5 Aug 2025 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380130; cv=none; b=SWeqKKAbtNeMn2/DThDgkCzzy0uzthUUC+YG7JhPYzz2VAe1VyquOwCAPPw68bdLdrECM33yGJ9WOq55LXeQZRxL+rfeaB9GjyrBSpPov+lSumUdc0nvQk9LyQtzPdqw1lbEpDyMGzaqdaQNwHsNo7aIWaLcUzKPWQXhxPXadt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380130; c=relaxed/simple;
	bh=/BkI8k/KgL4m3b+IyapmC6gAsF/x/DK6lwkWm/hd1as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw8wZtPRCjIafAJnQVxO20qTQ5y+XS/mMCKbBhldU34YH6+NWe1er/8N6aWRDa0cHlTeAt61CfMtmO3WasQsgiLOrYaR90jjzHrdtkcVnThEHfkAOhbh/YjmaxO7SVb5yu+zMVHO6TXHOJO14tlJBvL8kQIzbpS3oc8R1rRBlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=awWISSYv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754380126;
	bh=/BkI8k/KgL4m3b+IyapmC6gAsF/x/DK6lwkWm/hd1as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awWISSYvrr6zdVG38IxUon8MRqLQXRgDmR5DHS17z2ih9Oy4n7sVoSABnJC6/QSHV
	 qkzYo+lTvEKL4UioAtMsASUWqLKz5TAi6u/uwgAkJ0qd99wDP4bg38Q6dNsHQX+PNU
	 YhTwNReNTFqGM35VnuEjNTXJCGUtTFnH+pMQjLGfqwmFwE1Ft2pSJ0cB9TS52BlzqK
	 s2aUfkRB2oI6jKY0k+RYOMZ46xvG81vLrJye3ScAiyg14EQfWPA3zglL/l0QPQ2vGH
	 zzeuZ80wAtAwo4IdIGTvXjobloQq4+wmggQrfb6MLP6apRCnhlGiz7d+GhnsVf7cTG
	 oVPGxwaXWPGXQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4727017E0DD0;
	Tue,  5 Aug 2025 09:48:45 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	y.oudjana@protonmail.com,
	fshao@chromium.org,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3 10/10] arm64: dts: mediatek: Convert all SoCs to use access-controllers
Date: Tue,  5 Aug 2025 09:47:46 +0200
Message-ID: <20250805074746.29457-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The power controller now accepts a global access-controllers
property instead of iterating through all of the power domains to
check for each custom property.

Where possible, cleanup all of the power controllers nodes in all
of the currently supported SoCs to remove `mediatek,infracfg`,
`mediatek,infracfg-nao` and `mediatek,smi` properties from the
single power domains and add the phandles to some or all of those
in the access-controllers property at the root of the power
controller node.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi |  5 +++--
 arch/arm64/boot/dts/mediatek/mt8167.dtsi |  6 ++----
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |  4 ++--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 17 +++--------------
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 12 ++----------
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 23 ++---------------------
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 13 ++-----------
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 20 ++------------------
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 16 ++++------------
 9 files changed, 22 insertions(+), 94 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index e5e269a660b1..51f6209420be 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -275,6 +275,7 @@ topckgen: syscon@10000000 {
 		infracfg: syscon@10001000 {
 			compatible = "mediatek,mt6795-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
+			#access-controller-cells = <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
@@ -295,8 +296,10 @@ scpsys: syscon@10006000 {
 			spm: power-controller {
 				compatible = "mediatek,mt6795-power-controller";
 				#address-cells = <1>;
+
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				access-controllers = <&infracfg>;
 
 				/* power domains of the SoC */
 				power-domain@MT6795_POWER_DOMAIN_VDEC {
@@ -324,7 +327,6 @@ power-domain@MT6795_POWER_DOMAIN_MM {
 					clocks = <&topckgen CLK_TOP_MM_SEL>;
 					clock-names = "mm";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				power-domain@MT6795_POWER_DOMAIN_MJC {
@@ -357,7 +359,6 @@ power-domain@MT6795_POWER_DOMAIN_MFG_2D {
 						power-domain@MT6795_POWER_DOMAIN_MFG {
 							reg = <MT6795_POWER_DOMAIN_MFG>;
 							#power-domain-cells = <0>;
-							mediatek,infracfg = <&infracfg>;
 						};
 					};
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 2374c0953057..3fb114c10e73 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -26,6 +26,7 @@ topckgen: topckgen@10000000 {
 		infracfg: infracfg@10001000 {
 			compatible = "mediatek,mt8167-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
+			#access-controller-cells = <0>;
 			#clock-cells = <1>;
 		};
 
@@ -44,6 +45,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				access-controllers = <&infracfg>;
 
 				/* power domains of the SoC */
 				power-domain@MT8167_POWER_DOMAIN_MM {
@@ -51,7 +53,6 @@ power-domain@MT8167_POWER_DOMAIN_MM {
 					clocks = <&topckgen CLK_TOP_SMI_MM>;
 					clock-names = "mm";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				power-domain@MT8167_POWER_DOMAIN_VDEC {
@@ -77,7 +78,6 @@ power-domain@MT8167_POWER_DOMAIN_MFG_ASYNC {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
-					mediatek,infracfg = <&infracfg>;
 
 					power-domain@MT8167_POWER_DOMAIN_MFG_2D {
 						reg = <MT8167_POWER_DOMAIN_MFG_2D>;
@@ -88,7 +88,6 @@ power-domain@MT8167_POWER_DOMAIN_MFG_2D {
 						power-domain@MT8167_POWER_DOMAIN_MFG {
 							reg = <MT8167_POWER_DOMAIN_MFG>;
 							#power-domain-cells = <0>;
-							mediatek,infracfg = <&infracfg>;
 						};
 					};
 				};
@@ -96,7 +95,6 @@ power-domain@MT8167_POWER_DOMAIN_MFG {
 				power-domain@MT8167_POWER_DOMAIN_CONN {
 					reg = <MT8167_POWER_DOMAIN_CONN>;
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 122a57c3780b..d44977a01981 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -363,6 +363,7 @@ topckgen: clock-controller@10000000 {
 		infracfg: clock-controller@10001000 {
 			compatible = "mediatek,mt8173-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
+			#access-controller-cells = <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
@@ -460,6 +461,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				access-controllers = <&infracfg>;
 
 				/* power domains of the SoC */
 				power-domain@MT8173_POWER_DOMAIN_VDEC {
@@ -486,7 +488,6 @@ power-domain@MT8173_POWER_DOMAIN_MM {
 					clocks = <&topckgen CLK_TOP_MM_SEL>;
 					clock-names = "mm";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 				power-domain@MT8173_POWER_DOMAIN_VENC_LT {
 					reg = <MT8173_POWER_DOMAIN_VENC_LT>;
@@ -520,7 +521,6 @@ power-domain@MT8173_POWER_DOMAIN_MFG_2D {
 						power-domain@MT8173_POWER_DOMAIN_MFG {
 							reg = <MT8173_POWER_DOMAIN_MFG>;
 							#power-domain-cells = <0>;
-							mediatek,infracfg = <&infracfg>;
 						};
 					};
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 3c1fe80e64b9..47b8425ba326 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -809,6 +809,7 @@ topckgen: syscon@10000000 {
 		infracfg: syscon@10001000 {
 			compatible = "mediatek,mt8183-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
+			#access-controller-cells = <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
@@ -853,6 +854,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				access-controllers = <&infracfg>, <&smi_common>;
 
 				/* power domain of the SoC */
 				power-domain@MT8183_POWER_DOMAIN_AUDIO {
@@ -866,7 +868,6 @@ power-domain@MT8183_POWER_DOMAIN_AUDIO {
 
 				power-domain@MT8183_POWER_DOMAIN_CONN {
 					reg = <MT8183_POWER_DOMAIN_CONN>;
-					mediatek,infracfg = <&infracfg>;
 					#power-domain-cells = <0>;
 				};
 
@@ -894,7 +895,6 @@ power-domain@MT8183_POWER_DOMAIN_MFG_CORE1 {
 
 						power-domain@MT8183_POWER_DOMAIN_MFG_2D {
 							reg = <MT8183_POWER_DOMAIN_MFG_2D>;
-							mediatek,infracfg = <&infracfg>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -916,8 +916,6 @@ power-domain@MT8183_POWER_DOMAIN_DISP {
 					clock-names = "mm", "mm-0", "mm-1", "mm-2", "mm-3",
 						      "mm-4", "mm-5", "mm-6", "mm-7",
 						      "mm-8", "mm-9";
-					mediatek,infracfg = <&infracfg>;
-					mediatek,smi = <&smi_common>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -935,8 +933,6 @@ power-domain@MT8183_POWER_DOMAIN_CAM {
 						clock-names = "cam", "cam-0", "cam-1",
 							      "cam-2", "cam-3", "cam-4",
 							      "cam-5", "cam-6";
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
 						#power-domain-cells = <0>;
 					};
 
@@ -946,20 +942,16 @@ power-domain@MT8183_POWER_DOMAIN_ISP {
 							 <&imgsys CLK_IMG_LARB5>,
 							 <&imgsys CLK_IMG_LARB2>;
 						clock-names = "isp", "isp-0", "isp-1";
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
 						#power-domain-cells = <0>;
 					};
 
 					power-domain@MT8183_POWER_DOMAIN_VDEC {
 						reg = <MT8183_POWER_DOMAIN_VDEC>;
-						mediatek,smi = <&smi_common>;
 						#power-domain-cells = <0>;
 					};
 
 					power-domain@MT8183_POWER_DOMAIN_VENC {
 						reg = <MT8183_POWER_DOMAIN_VENC>;
-						mediatek,smi = <&smi_common>;
 						#power-domain-cells = <0>;
 					};
 
@@ -975,8 +967,6 @@ power-domain@MT8183_POWER_DOMAIN_VPU_TOP {
 							 <&ipu_conn CLK_IPU_CONN_IMG_ADL>;
 						clock-names = "vpu", "vpu1", "vpu-0", "vpu-1",
 							      "vpu-2", "vpu-3", "vpu-4", "vpu-5";
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -985,7 +975,6 @@ power-domain@MT8183_POWER_DOMAIN_VPU_CORE0 {
 							reg = <MT8183_POWER_DOMAIN_VPU_CORE0>;
 							clocks = <&topckgen CLK_TOP_MUX_DSP1>;
 							clock-names = "vpu2";
-							mediatek,infracfg = <&infracfg>;
 							#power-domain-cells = <0>;
 						};
 
@@ -993,7 +982,6 @@ power-domain@MT8183_POWER_DOMAIN_VPU_CORE1 {
 							reg = <MT8183_POWER_DOMAIN_VPU_CORE1>;
 							clocks = <&topckgen CLK_TOP_MUX_DSP2>;
 							clock-names = "vpu3";
-							mediatek,infracfg = <&infracfg>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -1887,6 +1875,7 @@ smi_common: smi@14019000 {
 				 <&mmsys CLK_MM_GALS_COMM1>;
 			clock-names = "apb", "smi", "gals0", "gals1";
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			#access-controller-cells = <0>;
 		};
 
 		mdp3-ccorr@1401c000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index b91f88ffae0e..3fa85185e2c8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -861,6 +861,7 @@ topckgen: syscon@10000000 {
 		infracfg_ao: syscon@10001000 {
 			compatible = "mediatek,mt8186-infracfg_ao", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
+			#access-controller-cells = <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
@@ -900,6 +901,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				access-controllers = <&infracfg_ao>;
 
 				/* power domain of the SoC */
 				mfg0: power-domain@MT8186_POWER_DOMAIN_MFG0 {
@@ -912,7 +914,6 @@ mfg0: power-domain@MT8186_POWER_DOMAIN_MFG0 {
 
 					mfg1: power-domain@MT8186_POWER_DOMAIN_MFG1 {
 						reg = <MT8186_POWER_DOMAIN_MFG1>;
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -972,7 +973,6 @@ power-domain@MT8186_POWER_DOMAIN_ADSP_INFRA {
 
 						power-domain@MT8186_POWER_DOMAIN_ADSP_TOP {
 							reg = <MT8186_POWER_DOMAIN_ADSP_TOP>;
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -980,7 +980,6 @@ power-domain@MT8186_POWER_DOMAIN_ADSP_TOP {
 
 				power-domain@MT8186_POWER_DOMAIN_CONN_ON {
 					reg = <MT8186_POWER_DOMAIN_CONN_ON>;
-					mediatek,infracfg = <&infracfg_ao>;
 					#power-domain-cells = <0>;
 				};
 
@@ -997,7 +996,6 @@ power-domain@MT8186_POWER_DOMAIN_DIS {
 						      "subsys-smi-common",
 						      "subsys-smi-gals",
 						      "subsys-smi-iommu";
-					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -1007,7 +1005,6 @@ power-domain@MT8186_POWER_DOMAIN_VDEC {
 						clocks = <&topckgen CLK_TOP_VDEC>,
 							 <&vdecsys CLK_VDEC_LARB1_CKEN>;
 						clock-names = "vdec0", "larb";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 
@@ -1024,7 +1021,6 @@ power-domain@MT8186_POWER_DOMAIN_CAM {
 							      "cam3", "gals",
 							      "subsys-cam-tm",
 							      "subsys-cam-top";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1045,7 +1041,6 @@ power-domain@MT8186_POWER_DOMAIN_IMG {
 						clocks = <&imgsys1 CLK_IMG1_GALS_IMG1>,
 							 <&topckgen CLK_TOP_IMG1>;
 						clock-names = "gals", "subsys-img-top";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1068,7 +1063,6 @@ power-domain@MT8186_POWER_DOMAIN_IPE {
 							      "subsys-ipe-larb1",
 							      "subsys-ipe-smi",
 							      "subsys-ipe-gals";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 
@@ -1077,7 +1071,6 @@ power-domain@MT8186_POWER_DOMAIN_VENC {
 						clocks = <&topckgen CLK_TOP_VENC>,
 							 <&vencsys CLK_VENC_CKE1_VENC>;
 						clock-names = "venc0", "subsys-larb";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 
@@ -1089,7 +1082,6 @@ power-domain@MT8186_POWER_DOMAIN_WPE {
 						clock-names = "wpe0",
 							      "subsys-larb-ck",
 							      "subsys-larb-pclk";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 202478407727..13d6fda96e84 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -964,6 +964,7 @@ topckgen: syscon@10000000 {
 		infracfg_ao: syscon@10001000 {
 			compatible = "mediatek,mt8188-infracfg-ao", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
+			#access-controller-cells = <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
@@ -1002,6 +1003,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				access-controllers = <&infracfg_ao>;
 
 				/* power domain of the SoC */
 				mfg0: power-domain@MT8188_POWER_DOMAIN_MFG0 {
@@ -1015,7 +1017,6 @@ mfg1: power-domain@MT8188_POWER_DOMAIN_MFG1 {
 						clocks = <&apmixedsys CLK_APMIXED_MFGPLL>,
 							 <&topckgen CLK_TOP_MFG_CORE_TMP>;
 						clock-names = "mfg", "alt";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1076,7 +1077,6 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS0 {
 						      "ss-emi", "ss-subcmn-rdr", "ss-rsi",
 						      "ss-cmn-l4", "ss-vdec1", "ss-wpe",
 						      "ss-cvdo-ve1";
-					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -1095,7 +1095,6 @@ power-domain@MT8188_POWER_DOMAIN_VDOSYS0 {
 						clock-names = "cfgck", "cfgxo", "ss-gals",
 							      "ss-cmn", "ss-emi", "ss-iommu",
 							      "ss-larb", "ss-rsi", "ss-bus";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1111,7 +1110,6 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS1 {
 							clock-names = "cfgck", "cfgxo",
 								      "ss-vpp1-g5", "ss-vpp1-g6",
 								      "ss-vpp1-l5", "ss-vpp1-l6";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -1119,7 +1117,6 @@ power-domain@MT8188_POWER_DOMAIN_VDEC0 {
 							reg = <MT8188_POWER_DOMAIN_VDEC0>;
 							clocks = <&vdecsys_soc CLK_VDEC1_SOC_LARB1>;
 							clock-names = "ss-vdec1-soc-l1";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -1128,7 +1125,6 @@ power-domain@MT8188_POWER_DOMAIN_VDEC1 {
 								reg = <MT8188_POWER_DOMAIN_VDEC1>;
 								clocks = <&vdecsys CLK_VDEC2_LARB1>;
 								clock-names = "ss-vdec2-l1";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -1140,7 +1136,6 @@ cam_vcore: power-domain@MT8188_POWER_DOMAIN_CAM_VCORE {
 								 <&topckgen CLK_TOP_CCU_AHB>,
 								 <&topckgen CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS>;
 							clock-names = "cam", "ccu", "bus", "cfgck";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -1155,7 +1150,6 @@ power-domain@MT8188_POWER_DOMAIN_CAM_MAIN {
 								clock-names= "ss-cam-l13", "ss-cam-l14",
 									     "ss-cam-mm0", "ss-cam-mm1",
 									     "ss-camsys";
-								mediatek,infracfg = <&infracfg_ao>;
 								#address-cells = <1>;
 								#size-cells = <0>;
 								#power-domain-cells = <1>;
@@ -1193,7 +1187,6 @@ power-domain@MT8188_POWER_DOMAIN_VDOSYS1 {
 								 <&vdosys1 CLK_VDO1_GALS>;
 							clock-names = "cfgck", "cfgxo", "ss-larb2",
 								      "ss-larb3", "ss-gals";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -1203,19 +1196,16 @@ power-domain@MT8188_POWER_DOMAIN_HDMI_TX {
 								clocks = <&topckgen CLK_TOP_HDMI_APB>,
 									 <&topckgen CLK_TOP_HDCP_24M>;
 								clock-names = "bus", "hdcp";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 
 							power-domain@MT8188_POWER_DOMAIN_DP_TX {
 								reg = <MT8188_POWER_DOMAIN_DP_TX>;
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 
 							power-domain@MT8188_POWER_DOMAIN_EDP_TX {
 								reg = <MT8188_POWER_DOMAIN_EDP_TX>;
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -1228,7 +1218,6 @@ power-domain@MT8188_POWER_DOMAIN_VENC {
 								 <&vencsys CLK_VENC1_GALS_SRAM>;
 							clock-names = "ss-ve1-larb", "ss-ve1-core",
 								      "ss-ve1-gals", "ss-ve1-sram";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -1237,7 +1226,6 @@ power-domain@MT8188_POWER_DOMAIN_WPE {
 							clocks = <&wpesys CLK_WPE_TOP_SMI_LARB7>,
 								 <&wpesys CLK_WPE_TOP_SMI_LARB7_PCLK_EN>;
 							clock-names = "ss-wpe-l7", "ss-wpe-l7pce";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -1245,7 +1233,6 @@ power-domain@MT8188_POWER_DOMAIN_WPE {
 
 				power-domain@MT8188_POWER_DOMAIN_PEXTP_MAC_P0 {
 					reg = <MT8188_POWER_DOMAIN_PEXTP_MAC_P0>;
-					mediatek,infracfg = <&infracfg_ao>;
 					clocks = <&pericfg_ao CLK_PERI_AO_PCIE_P0_FMEM>;
 					clock-names = "ss-pextp-fmem";
 					#power-domain-cells = <0>;
@@ -1269,14 +1256,12 @@ power-domain@MT8188_POWER_DOMAIN_ADSP_AO {
 					clocks = <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>,
 						 <&topckgen CLK_TOP_ADSP>;
 					clock-names = "bus", "main";
-					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
 
 					power-domain@MT8188_POWER_DOMAIN_ADSP_INFRA {
 						reg = <MT8188_POWER_DOMAIN_ADSP_INFRA>;
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1285,7 +1270,6 @@ power-domain@MT8188_POWER_DOMAIN_AUDIO_ASRC {
 							reg = <MT8188_POWER_DOMAIN_AUDIO_ASRC>;
 							clocks = <&topckgen CLK_TOP_ASM_H>;
 							clock-names = "asm";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -1295,13 +1279,11 @@ power-domain@MT8188_POWER_DOMAIN_AUDIO {
 								 <&topckgen CLK_TOP_AUD_INTBUS>,
 								 <&adsp_audio26m CLK_AUDIODSP_AUDIO26M>;
 							clock-names = "a1sys", "intbus", "adspck";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
 						power-domain@MT8188_POWER_DOMAIN_ADSP {
 							reg = <MT8188_POWER_DOMAIN_ADSP>;
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -1311,7 +1293,6 @@ power-domain@MT8188_POWER_DOMAIN_ETHER {
 					reg = <MT8188_POWER_DOMAIN_ETHER>;
 					clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET_MAC>;
 					clock-names = "ethermac";
-					mediatek,infracfg = <&infracfg_ao>;
 					#power-domain-cells = <0>;
 				};
 			};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 47dea10dd3b8..56e4dd00e004 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -459,6 +459,7 @@ topckgen: syscon@10000000 {
 		infracfg: syscon@10001000 {
 			compatible = "mediatek,mt8192-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
+			#access-controller-cells = <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
@@ -504,6 +505,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				access-controllers = <&infracfg>;
 
 				/* power domain of the SoC */
 				power-domain@MT8192_POWER_DOMAIN_AUDIO {
@@ -512,7 +514,6 @@ power-domain@MT8192_POWER_DOMAIN_AUDIO {
 						 <&infracfg CLK_INFRA_AUDIO_26M_B>,
 						 <&infracfg CLK_INFRA_AUDIO>;
 					clock-names = "audio", "audio1", "audio2";
-					mediatek,infracfg = <&infracfg>;
 					#power-domain-cells = <0>;
 				};
 
@@ -520,7 +521,6 @@ power-domain@MT8192_POWER_DOMAIN_CONN {
 					reg = <MT8192_POWER_DOMAIN_CONN>;
 					clocks = <&infracfg CLK_INFRA_PMIC_CONN>;
 					clock-names = "conn";
-					mediatek,infracfg = <&infracfg>;
 					#power-domain-cells = <0>;
 				};
 
@@ -535,7 +535,6 @@ mfg0: power-domain@MT8192_POWER_DOMAIN_MFG0 {
 
 					mfg1: power-domain@MT8192_POWER_DOMAIN_MFG1 {
 						reg = <MT8192_POWER_DOMAIN_MFG1>;
-						mediatek,infracfg = <&infracfg>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -576,7 +575,6 @@ power-domain@MT8192_POWER_DOMAIN_DISP {
 						 <&mmsys CLK_MM_SMI_IOMMU>;
 					clock-names = "disp", "disp-0", "disp-1", "disp-2",
 						      "disp-3";
-					mediatek,infracfg = <&infracfg>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -590,7 +588,6 @@ power-domain@MT8192_POWER_DOMAIN_IPE {
 							 <&ipesys CLK_IPE_GALS>;
 						clock-names = "ipe", "ipe-0", "ipe-1", "ipe-2",
 							      "ipe-3";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -600,7 +597,6 @@ power-domain@MT8192_POWER_DOMAIN_ISP {
 							 <&imgsys CLK_IMG_LARB9>,
 							 <&imgsys CLK_IMG_GALS>;
 						clock-names = "isp", "isp-0", "isp-1";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -610,7 +606,6 @@ power-domain@MT8192_POWER_DOMAIN_ISP2 {
 							 <&imgsys2 CLK_IMG2_LARB11>,
 							 <&imgsys2 CLK_IMG2_GALS>;
 						clock-names = "isp2", "isp2-0", "isp2-1";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -619,7 +614,6 @@ power-domain@MT8192_POWER_DOMAIN_MDP {
 						clocks = <&topckgen CLK_TOP_MDP_SEL>,
 							 <&mdpsys CLK_MDP_SMI0>;
 						clock-names = "mdp", "mdp-0";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -628,7 +622,6 @@ power-domain@MT8192_POWER_DOMAIN_VENC {
 						clocks = <&topckgen CLK_TOP_VENC_SEL>,
 							 <&vencsys CLK_VENC_SET1_VENC>;
 						clock-names = "venc", "venc-0";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -639,7 +632,6 @@ power-domain@MT8192_POWER_DOMAIN_VDEC {
 							 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
 							 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
 						clock-names = "vdec", "vdec-0", "vdec-1", "vdec-2";
-						mediatek,infracfg = <&infracfg>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -664,7 +656,6 @@ power-domain@MT8192_POWER_DOMAIN_CAM {
 							 <&camsys CLK_CAM_CAM2MM_GALS>;
 						clock-names = "cam", "cam-0", "cam-1", "cam-2",
 							      "cam-3";
-						mediatek,infracfg = <&infracfg>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8877953ce292..6d1aeca07331 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -489,6 +489,7 @@ topckgen: syscon@10000000 {
 		infracfg_ao: syscon@10001000 {
 			compatible = "mediatek,mt8195-infracfg_ao", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
+			#access-controller-cells = <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
@@ -530,6 +531,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				access-controllers = <&infracfg_ao>;
 
 				/* power domain of the SoC */
 				mfg0: power-domain@MT8195_POWER_DOMAIN_MFG0 {
@@ -543,7 +545,6 @@ mfg1: power-domain@MT8195_POWER_DOMAIN_MFG1 {
 						clocks = <&apmixedsys CLK_APMIXED_MFGPLL>,
 							 <&topckgen CLK_TOP_MFG_CORE_TMP>;
 						clock-names = "mfg", "alt";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -612,7 +613,6 @@ power-domain@MT8195_POWER_DOMAIN_VPPSYS0 {
 						      "vppsys0-12", "vppsys0-13", "vppsys0-14",
 						      "vppsys0-15", "vppsys0-16", "vppsys0-17",
 						      "vppsys0-18";
-					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -629,7 +629,6 @@ power-domain@MT8195_POWER_DOMAIN_VDOSYS0 {
 						clock-names = "vdosys0", "vdosys0-0", "vdosys0-1",
 							      "vdosys0-2", "vdosys0-3",
 							      "vdosys0-4", "vdosys0-5";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -641,7 +640,6 @@ power-domain@MT8195_POWER_DOMAIN_VPPSYS1 {
 								 <&vppsys1 CLK_VPP1_VPPSYS1_LARB>;
 							clock-names = "vppsys1", "vppsys1-0",
 								      "vppsys1-1";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -653,7 +651,6 @@ power-domain@MT8195_POWER_DOMAIN_WPESYS {
 								 <&wpesys CLK_WPE_SMI_LARB8_P>;
 							clock-names = "wepsys-0", "wepsys-1", "wepsys-2",
 								      "wepsys-3";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -661,7 +658,6 @@ power-domain@MT8195_POWER_DOMAIN_VDEC0 {
 							reg = <MT8195_POWER_DOMAIN_VDEC0>;
 							clocks = <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
 							clock-names = "vdec0-0";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <0>;
@@ -670,7 +666,6 @@ power-domain@MT8195_POWER_DOMAIN_VDEC1 {
 								reg = <MT8195_POWER_DOMAIN_VDEC1>;
 								clocks = <&vdecsys CLK_VDEC_LARB1>;
 								clock-names = "vdec1-0";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 
@@ -678,7 +673,6 @@ power-domain@MT8195_POWER_DOMAIN_VDEC2 {
 								reg = <MT8195_POWER_DOMAIN_VDEC2>;
 								clocks = <&vdecsys_core1 CLK_VDEC_CORE1_LARB1>;
 								clock-names = "vdec2-0";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -687,7 +681,6 @@ power-domain@MT8195_POWER_DOMAIN_VENC {
 							reg = <MT8195_POWER_DOMAIN_VENC>;
 							clocks = <&vencsys CLK_VENC_LARB>;
 							clock-names = "venc0-larb";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <0>;
@@ -696,7 +689,6 @@ power-domain@MT8195_POWER_DOMAIN_VENC_CORE1 {
 								reg = <MT8195_POWER_DOMAIN_VENC_CORE1>;
 								clocks = <&vencsys_core1 CLK_VENC_CORE1_LARB>;
 								clock-names = "venc1-larb";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -709,20 +701,17 @@ power-domain@MT8195_POWER_DOMAIN_VDOSYS1 {
 								 <&vdosys1 CLK_VDO1_GALS>;
 							clock-names = "vdosys1", "vdosys1-0",
 								      "vdosys1-1", "vdosys1-2";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
 
 							power-domain@MT8195_POWER_DOMAIN_DP_TX {
 								reg = <MT8195_POWER_DOMAIN_DP_TX>;
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 
 							power-domain@MT8195_POWER_DOMAIN_EPD_TX {
 								reg = <MT8195_POWER_DOMAIN_EPD_TX>;
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 
@@ -739,7 +728,6 @@ power-domain@MT8195_POWER_DOMAIN_IMG {
 							clocks = <&imgsys CLK_IMG_LARB9>,
 								 <&imgsys CLK_IMG_GALS>;
 							clock-names = "img-0", "img-1";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -755,7 +743,6 @@ power-domain@MT8195_POWER_DOMAIN_IPE {
 									 <&imgsys CLK_IMG_IPE>,
 									 <&ipesys CLK_IPE_SMI_LARB12>;
 								clock-names = "ipe", "ipe-0", "ipe-1";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -769,7 +756,6 @@ power-domain@MT8195_POWER_DOMAIN_CAM {
 								 <&camsys CLK_CAM_CAM2SYS_GALS>;
 							clock-names = "cam-0", "cam-1", "cam-2", "cam-3",
 								      "cam-4";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -836,7 +822,6 @@ power-domain@MT8195_POWER_DOMAIN_ADSP {
 					clock-names = "adsp", "adsp1";
 					#address-cells = <1>;
 					#size-cells = <0>;
-					mediatek,infracfg = <&infracfg_ao>;
 					#power-domain-cells = <1>;
 
 					power-domain@MT8195_POWER_DOMAIN_AUDIO {
@@ -847,7 +832,6 @@ power-domain@MT8195_POWER_DOMAIN_AUDIO {
 							 <&infracfg_ao CLK_INFRA_AO_AUDIO_26M_B>;
 						clock-names = "audio", "audio1", "audio2",
 							      "audio3";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index e6d2b3221a3b..3ed53e906482 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -301,6 +301,7 @@ topckgen: syscon@10000000 {
 		infracfg: syscon@10001000 {
 			compatible = "mediatek,mt8365-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
+			#access-controller-cells = <0>;
 			#clock-cells = <1>;
 		};
 
@@ -325,6 +326,8 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				access-controllers = <&infracfg>, <&infracfg_nao>,
+						     <&smi_common>;
 
 				/* power domains of the SoC */
 				power-domain@MT8365_POWER_DOMAIN_MM {
@@ -337,8 +340,6 @@ power-domain@MT8365_POWER_DOMAIN_MM {
 					clock-names = "mm", "mm-0", "mm-1",
 						      "mm-2", "mm-3";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
-					mediatek,infracfg-nao = <&infracfg_nao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -354,20 +355,16 @@ power-domain@MT8365_POWER_DOMAIN_CAM {
 							      "cam-2", "cam-3",
 							      "cam-4", "cam-5";
 						#power-domain-cells = <0>;
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VDEC {
 						reg = <MT8365_POWER_DOMAIN_VDEC>;
 						#power-domain-cells = <0>;
-						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VENC {
 						reg = <MT8365_POWER_DOMAIN_VENC>;
 						#power-domain-cells = <0>;
-						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_APU {
@@ -384,8 +381,6 @@ power-domain@MT8365_POWER_DOMAIN_APU {
 							      "apu-3", "apu-4",
 							      "apu-5";
 						#power-domain-cells = <0>;
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
 					};
 				};
 
@@ -395,7 +390,6 @@ power-domain@MT8365_POWER_DOMAIN_CONN {
 						 <&topckgen CLK_TOP_CONN_26M>;
 					clock-names = "conn", "conn1";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				power-domain@MT8365_POWER_DOMAIN_MFG {
@@ -403,7 +397,6 @@ power-domain@MT8365_POWER_DOMAIN_MFG {
 					clocks = <&topckgen CLK_TOP_MFG_SEL>;
 					clock-names = "mfg";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				power-domain@MT8365_POWER_DOMAIN_AUDIO {
@@ -413,7 +406,6 @@ power-domain@MT8365_POWER_DOMAIN_AUDIO {
 						 <&infracfg CLK_IFR_AUD_26M_BK>;
 					clock-names = "audio", "audio1", "audio2";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				power-domain@MT8365_POWER_DOMAIN_DSP {
@@ -422,7 +414,6 @@ power-domain@MT8365_POWER_DOMAIN_DSP {
 						 <&topckgen CLK_TOP_DSP_26M>;
 					clock-names = "dsp", "dsp1";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 			};
 		};
@@ -795,6 +786,7 @@ smi_common: smi@14002000 {
 				 <&mmsys CLK_MM_MM_SMI_COMM1>;
 			clock-names = "apb", "smi", "gals0", "gals1";
 			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+			#access-controller-cells = <0>;
 		};
 
 		larb0: larb@14003000 {
-- 
2.50.1


