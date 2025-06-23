Return-Path: <linux-pm+bounces-29295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 548EBAE3F59
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D54518949B0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F05267B65;
	Mon, 23 Jun 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XPhXWw34"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C97D26658F;
	Mon, 23 Jun 2025 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680133; cv=none; b=ZFzevgNugJeDWMkoSf5qqWcJQk9u/mabwhrnIevHW8kx8vHT0X1+mFq5sYR0eu34QmqioRVGd0uRY5w5aZI7q0GiIFmLlTghIjhcWpt/YL4qcLgULUnXH9FathbOBSOyJQzRoQs1vLrfByiH2WhFIti+EVmIJrsTo02am/2q7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680133; c=relaxed/simple;
	bh=iSItSl5/0ffWI4wH9aEQ9sF1KhyqHm5P1wqhMe1EEnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1esw3Yim4Dae6AzjHZKWwX7HTwXBZ//xqLjwGD0XlO6UHrbZh7TXJIDFOTNYTl0dbSYyfC/JTjqKvEbRAa9Hk/ewktDJ8qS7Qwu4cB96yAGogQ98zbjo4/IXWfUnDf5jBr5barNBrXXvmUpZX2XDvk5RTYbfli5wz5sEx8mkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XPhXWw34; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680128;
	bh=iSItSl5/0ffWI4wH9aEQ9sF1KhyqHm5P1wqhMe1EEnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPhXWw34PtNPkG/nHZhuOtt30cpvMLltrkggDY0MvOA7WQ1yVOmuKxExtcqqaqhyU
	 UXLv41sN9QErrYPcnzg96vL0kW1nPeDVSJesxrZOstpKRH5XEJayr8UtEIZXaLIwMO
	 jIJ/w43YfYMJL9zYXsf6aUBSdk92eIugpI1hwWwc4yqTsgeqjNTQ5/E7z06uKepxUH
	 2pmUChHPcV2DpVHqMq8VRKyI/bM1IfFTXXtekeq/PxBLfQVbn6974gNouRZjINA5iS
	 XnOR2GyJI3sW9/tW4+16p4sVNOQZEm7iIHhwxP6bb5PpOoOBHt4iJl+QV31m+4pmQx
	 4hr+jpbR9/Jqg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BA76917E0202;
	Mon, 23 Jun 2025 14:02:07 +0200 (CEST)
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
	kernel@collabora.com
Subject: [PATCH v1 10/13] arm64: dts: mediatek: Convert all SoCs to use mediatek,bus-protection
Date: Mon, 23 Jun 2025 14:01:51 +0200
Message-ID: <20250623120154.109429-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
References: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power controller now accepts a global mediatek,bus-protection
property instead of iterating through all of the power domains to
check for each custom property.

Where possible, cleanup all of the power controllers nodes in all
of the currently supported SoCs to remove `mediatek,infracfg`,
`mediatek,infracfg-nao` and `mediatek,smi` properties from the
single power domains and add the phandles to some or all of those
in the mediatek,bus-protection property at the root of the power
controller node.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi |  4 ++--
 arch/arm64/boot/dts/mediatek/mt6893.dtsi | 11 +----------
 arch/arm64/boot/dts/mediatek/mt8167.dtsi |  5 +----
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |  3 +--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 15 +--------------
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 11 +----------
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 22 +---------------------
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 +-----------
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 21 +--------------------
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 14 ++------------
 10 files changed, 12 insertions(+), 106 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index e5e269a660b1..b187a0a3a16f 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -295,8 +295,10 @@ scpsys: syscon@10006000 {
 			spm: power-controller {
 				compatible = "mediatek,mt6795-power-controller";
 				#address-cells = <1>;
+
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg>;
 
 				/* power domains of the SoC */
 				power-domain@MT6795_POWER_DOMAIN_VDEC {
@@ -324,7 +326,6 @@ power-domain@MT6795_POWER_DOMAIN_MM {
 					clocks = <&topckgen CLK_TOP_MM_SEL>;
 					clock-names = "mm";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				power-domain@MT6795_POWER_DOMAIN_MJC {
@@ -357,7 +358,6 @@ power-domain@MT6795_POWER_DOMAIN_MFG_2D {
 						power-domain@MT6795_POWER_DOMAIN_MFG {
 							reg = <MT6795_POWER_DOMAIN_MFG>;
 							#power-domain-cells = <0>;
-							mediatek,infracfg = <&infracfg>;
 						};
 					};
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt6893.dtsi b/arch/arm64/boot/dts/mediatek/mt6893.dtsi
index 2980677b5082..bb7dc4a467b7 100644
--- a/arch/arm64/boot/dts/mediatek/mt6893.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6893.dtsi
@@ -515,13 +515,13 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg>;
 
 				/* power domain of the SoC */
 				power-domain@MT6893_POWER_DOMAIN_CONN {
 					reg = <MT6893_POWER_DOMAIN_CONN>;
 					clocks = <&infracfg CLK_INFRA_PMIC_CONN>;
 					clock-names = "conn";
-					mediatek,infracfg = <&infracfg>;
 					#power-domain-cells = <0>;
 				};
 
@@ -535,7 +535,6 @@ mfg1: power-domain@MT6893_POWER_DOMAIN_MFG1 {
 						reg = <MT6893_POWER_DOMAIN_MFG1>;
 						clocks = <&apmixedsys CLK_TOP_MFG_SEL>;
 						clock-names = "mfg";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -576,7 +575,6 @@ power-domain@MT6893_POWER_DOMAIN_DISP {
 						 <&mmsys CLK_MM_SMI_IOMMU>;
 					clock-names = "disp", "ss-disp-ifr", "ss-disp-cmn",
 						      "ss-disp-gals", "ss-disp-iommu";
-					mediatek,infracfg = <&infracfg>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -589,7 +587,6 @@ power-domain@MT6893_POWER_DOMAIN_MDP {
 							 <&mdpsys CLK_MDP_SMI2>;
 						clock-names = "mdp", "ss-mdp-smi0", "ss-mdp-smi1",
 							      "ss-mdp-smi2";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -598,14 +595,12 @@ power-domain@MT6893_POWER_DOMAIN_VENC0 {
 						clocks = <&topckgen CLK_TOP_VENC_SEL>,
 							 <&vencsys0 CLK_VENC0_SET1_VENC>;
 						clock-names = "venc0", "subsys-venc0";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 
 						power-domain@MT6893_POWER_DOMAIN_VENC1 {
 							reg = <MT6893_POWER_DOMAIN_VENC1>;
 							clocks = <&vencsys1 CLK_VENC1_SET1_VENC>;
 							clock-names = "subsys-venc1";
-							mediatek,infracfg = <&infracfg>;
 							#power-domain-cells = <0>;
 						}
 					};
@@ -618,7 +613,6 @@ power-domain@MT6893_POWER_DOMAIN_VDEC0 {
 							 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
 						clock-names = "vdec0", "ss-vdec0-core",
 							      "ss-vdec0-lat", "ss-vdec0-larb";
-						mediatek,infracfg = <&infracfg>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -637,7 +631,6 @@ power-domain@MT6893_POWER_DOMAIN_VDEC1 {
 
 					power-domain@MT6893_POWER_DOMAIN_DP_TX {
 						reg = <MT6893_POWER_DOMAIN_DP_TX>;
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 				};
@@ -648,7 +641,6 @@ power-domain@MT6893_POWER_DOMAIN_AUDIO {
 						 <&infracfg CLK_INFRA_AO_AUDIO_26M_BCLK>,
 						 <&infracfg CLK_INFRA_AO_AUDIO>;
 					clock-names = "audio", "audio1", "audio2";
-					mediatek,infracfg = <&infracfg>;
 					#power-domain-cells = <0>;
 				};
 
@@ -656,7 +648,6 @@ power-domain@MT6893_POWER_DOMAIN_ADSP {
 					reg = <MT6893_POWER_DOMAIN_ADSP>;
 					clocks = <&topckgen CLK_TOP_ADSP_SEL>;
 					clock-names = "adsp";
-					mediatek,infracfg = <&infracfg>;
 					#power-domain-cells = <0>;
 				};
 			};
diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 2374c0953057..836237f8ec1b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -44,6 +44,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg>;
 
 				/* power domains of the SoC */
 				power-domain@MT8167_POWER_DOMAIN_MM {
@@ -51,7 +52,6 @@ power-domain@MT8167_POWER_DOMAIN_MM {
 					clocks = <&topckgen CLK_TOP_SMI_MM>;
 					clock-names = "mm";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				power-domain@MT8167_POWER_DOMAIN_VDEC {
@@ -77,7 +77,6 @@ power-domain@MT8167_POWER_DOMAIN_MFG_ASYNC {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
-					mediatek,infracfg = <&infracfg>;
 
 					power-domain@MT8167_POWER_DOMAIN_MFG_2D {
 						reg = <MT8167_POWER_DOMAIN_MFG_2D>;
@@ -88,7 +87,6 @@ power-domain@MT8167_POWER_DOMAIN_MFG_2D {
 						power-domain@MT8167_POWER_DOMAIN_MFG {
 							reg = <MT8167_POWER_DOMAIN_MFG>;
 							#power-domain-cells = <0>;
-							mediatek,infracfg = <&infracfg>;
 						};
 					};
 				};
@@ -96,7 +94,6 @@ power-domain@MT8167_POWER_DOMAIN_MFG {
 				power-domain@MT8167_POWER_DOMAIN_CONN {
 					reg = <MT8167_POWER_DOMAIN_CONN>;
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 6d1d8877b43f..c1f9ee9bfe54 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -452,6 +452,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg>;
 
 				/* power domains of the SoC */
 				power-domain@MT8173_POWER_DOMAIN_VDEC {
@@ -478,7 +479,6 @@ power-domain@MT8173_POWER_DOMAIN_MM {
 					clocks = <&topckgen CLK_TOP_MM_SEL>;
 					clock-names = "mm";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 				power-domain@MT8173_POWER_DOMAIN_VENC_LT {
 					reg = <MT8173_POWER_DOMAIN_VENC_LT>;
@@ -512,7 +512,6 @@ power-domain@MT8173_POWER_DOMAIN_MFG_2D {
 						power-domain@MT8173_POWER_DOMAIN_MFG {
 							reg = <MT8173_POWER_DOMAIN_MFG>;
 							#power-domain-cells = <0>;
-							mediatek,infracfg = <&infracfg>;
 						};
 					};
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 3c1fe80e64b9..02e9633f6b8b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -853,6 +853,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg>, <&smi_common>;
 
 				/* power domain of the SoC */
 				power-domain@MT8183_POWER_DOMAIN_AUDIO {
@@ -866,7 +867,6 @@ power-domain@MT8183_POWER_DOMAIN_AUDIO {
 
 				power-domain@MT8183_POWER_DOMAIN_CONN {
 					reg = <MT8183_POWER_DOMAIN_CONN>;
-					mediatek,infracfg = <&infracfg>;
 					#power-domain-cells = <0>;
 				};
 
@@ -894,7 +894,6 @@ power-domain@MT8183_POWER_DOMAIN_MFG_CORE1 {
 
 						power-domain@MT8183_POWER_DOMAIN_MFG_2D {
 							reg = <MT8183_POWER_DOMAIN_MFG_2D>;
-							mediatek,infracfg = <&infracfg>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -916,8 +915,6 @@ power-domain@MT8183_POWER_DOMAIN_DISP {
 					clock-names = "mm", "mm-0", "mm-1", "mm-2", "mm-3",
 						      "mm-4", "mm-5", "mm-6", "mm-7",
 						      "mm-8", "mm-9";
-					mediatek,infracfg = <&infracfg>;
-					mediatek,smi = <&smi_common>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -935,8 +932,6 @@ power-domain@MT8183_POWER_DOMAIN_CAM {
 						clock-names = "cam", "cam-0", "cam-1",
 							      "cam-2", "cam-3", "cam-4",
 							      "cam-5", "cam-6";
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
 						#power-domain-cells = <0>;
 					};
 
@@ -946,20 +941,16 @@ power-domain@MT8183_POWER_DOMAIN_ISP {
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
 
@@ -975,8 +966,6 @@ power-domain@MT8183_POWER_DOMAIN_VPU_TOP {
 							 <&ipu_conn CLK_IPU_CONN_IMG_ADL>;
 						clock-names = "vpu", "vpu1", "vpu-0", "vpu-1",
 							      "vpu-2", "vpu-3", "vpu-4", "vpu-5";
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -985,7 +974,6 @@ power-domain@MT8183_POWER_DOMAIN_VPU_CORE0 {
 							reg = <MT8183_POWER_DOMAIN_VPU_CORE0>;
 							clocks = <&topckgen CLK_TOP_MUX_DSP1>;
 							clock-names = "vpu2";
-							mediatek,infracfg = <&infracfg>;
 							#power-domain-cells = <0>;
 						};
 
@@ -993,7 +981,6 @@ power-domain@MT8183_POWER_DOMAIN_VPU_CORE1 {
 							reg = <MT8183_POWER_DOMAIN_VPU_CORE1>;
 							clocks = <&topckgen CLK_TOP_MUX_DSP2>;
 							clock-names = "vpu3";
-							mediatek,infracfg = <&infracfg>;
 							#power-domain-cells = <0>;
 						};
 					};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index b91f88ffae0e..2ef7fe741706 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -900,6 +900,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg_ao>;
 
 				/* power domain of the SoC */
 				mfg0: power-domain@MT8186_POWER_DOMAIN_MFG0 {
@@ -912,7 +913,6 @@ mfg0: power-domain@MT8186_POWER_DOMAIN_MFG0 {
 
 					mfg1: power-domain@MT8186_POWER_DOMAIN_MFG1 {
 						reg = <MT8186_POWER_DOMAIN_MFG1>;
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -972,7 +972,6 @@ power-domain@MT8186_POWER_DOMAIN_ADSP_INFRA {
 
 						power-domain@MT8186_POWER_DOMAIN_ADSP_TOP {
 							reg = <MT8186_POWER_DOMAIN_ADSP_TOP>;
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -980,7 +979,6 @@ power-domain@MT8186_POWER_DOMAIN_ADSP_TOP {
 
 				power-domain@MT8186_POWER_DOMAIN_CONN_ON {
 					reg = <MT8186_POWER_DOMAIN_CONN_ON>;
-					mediatek,infracfg = <&infracfg_ao>;
 					#power-domain-cells = <0>;
 				};
 
@@ -997,7 +995,6 @@ power-domain@MT8186_POWER_DOMAIN_DIS {
 						      "subsys-smi-common",
 						      "subsys-smi-gals",
 						      "subsys-smi-iommu";
-					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -1007,7 +1004,6 @@ power-domain@MT8186_POWER_DOMAIN_VDEC {
 						clocks = <&topckgen CLK_TOP_VDEC>,
 							 <&vdecsys CLK_VDEC_LARB1_CKEN>;
 						clock-names = "vdec0", "larb";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 
@@ -1024,7 +1020,6 @@ power-domain@MT8186_POWER_DOMAIN_CAM {
 							      "cam3", "gals",
 							      "subsys-cam-tm",
 							      "subsys-cam-top";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1045,7 +1040,6 @@ power-domain@MT8186_POWER_DOMAIN_IMG {
 						clocks = <&imgsys1 CLK_IMG1_GALS_IMG1>,
 							 <&topckgen CLK_TOP_IMG1>;
 						clock-names = "gals", "subsys-img-top";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1068,7 +1062,6 @@ power-domain@MT8186_POWER_DOMAIN_IPE {
 							      "subsys-ipe-larb1",
 							      "subsys-ipe-smi",
 							      "subsys-ipe-gals";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 
@@ -1077,7 +1070,6 @@ power-domain@MT8186_POWER_DOMAIN_VENC {
 						clocks = <&topckgen CLK_TOP_VENC>,
 							 <&vencsys CLK_VENC_CKE1_VENC>;
 						clock-names = "venc0", "subsys-larb";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 
@@ -1089,7 +1081,6 @@ power-domain@MT8186_POWER_DOMAIN_WPE {
 						clock-names = "wpe0",
 							      "subsys-larb-ck",
 							      "subsys-larb-pclk";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index afd1f0ce6d24..0585e2a392d0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1003,6 +1003,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg_ao>;
 
 				/* power domain of the SoC */
 				mfg0: power-domain@MT8188_POWER_DOMAIN_MFG0 {
@@ -1016,7 +1017,6 @@ mfg1: power-domain@MT8188_POWER_DOMAIN_MFG1 {
 						clocks = <&apmixedsys CLK_APMIXED_MFGPLL>,
 							 <&topckgen CLK_TOP_MFG_CORE_TMP>;
 						clock-names = "mfg", "alt";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1077,7 +1077,6 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS0 {
 						      "ss-emi", "ss-subcmn-rdr", "ss-rsi",
 						      "ss-cmn-l4", "ss-vdec1", "ss-wpe",
 						      "ss-cvdo-ve1";
-					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -1096,7 +1095,6 @@ power-domain@MT8188_POWER_DOMAIN_VDOSYS0 {
 						clock-names = "cfgck", "cfgxo", "ss-gals",
 							      "ss-cmn", "ss-emi", "ss-iommu",
 							      "ss-larb", "ss-rsi", "ss-bus";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1112,7 +1110,6 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS1 {
 							clock-names = "cfgck", "cfgxo",
 								      "ss-vpp1-g5", "ss-vpp1-g6",
 								      "ss-vpp1-l5", "ss-vpp1-l6";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -1120,7 +1117,6 @@ power-domain@MT8188_POWER_DOMAIN_VDEC0 {
 							reg = <MT8188_POWER_DOMAIN_VDEC0>;
 							clocks = <&vdecsys_soc CLK_VDEC1_SOC_LARB1>;
 							clock-names = "ss-vdec1-soc-l1";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -1129,7 +1125,6 @@ power-domain@MT8188_POWER_DOMAIN_VDEC1 {
 								reg = <MT8188_POWER_DOMAIN_VDEC1>;
 								clocks = <&vdecsys CLK_VDEC2_LARB1>;
 								clock-names = "ss-vdec2-l1";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -1141,7 +1136,6 @@ cam_vcore: power-domain@MT8188_POWER_DOMAIN_CAM_VCORE {
 								 <&topckgen CLK_TOP_CCU_AHB>,
 								 <&topckgen CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS>;
 							clock-names = "cam", "ccu", "bus", "cfgck";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -1156,7 +1150,6 @@ power-domain@MT8188_POWER_DOMAIN_CAM_MAIN {
 								clock-names= "ss-cam-l13", "ss-cam-l14",
 									     "ss-cam-mm0", "ss-cam-mm1",
 									     "ss-camsys";
-								mediatek,infracfg = <&infracfg_ao>;
 								#address-cells = <1>;
 								#size-cells = <0>;
 								#power-domain-cells = <1>;
@@ -1194,7 +1187,6 @@ power-domain@MT8188_POWER_DOMAIN_VDOSYS1 {
 								 <&vdosys1 CLK_VDO1_GALS>;
 							clock-names = "cfgck", "cfgxo", "ss-larb2",
 								      "ss-larb3", "ss-gals";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -1204,19 +1196,16 @@ power-domain@MT8188_POWER_DOMAIN_HDMI_TX {
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
@@ -1229,7 +1218,6 @@ power-domain@MT8188_POWER_DOMAIN_VENC {
 								 <&vencsys CLK_VENC1_GALS_SRAM>;
 							clock-names = "ss-ve1-larb", "ss-ve1-core",
 								      "ss-ve1-gals", "ss-ve1-sram";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -1238,7 +1226,6 @@ power-domain@MT8188_POWER_DOMAIN_WPE {
 							clocks = <&wpesys CLK_WPE_TOP_SMI_LARB7>,
 								 <&wpesys CLK_WPE_TOP_SMI_LARB7_PCLK_EN>;
 							clock-names = "ss-wpe-l7", "ss-wpe-l7pce";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -1246,7 +1233,6 @@ power-domain@MT8188_POWER_DOMAIN_WPE {
 
 				power-domain@MT8188_POWER_DOMAIN_PEXTP_MAC_P0 {
 					reg = <MT8188_POWER_DOMAIN_PEXTP_MAC_P0>;
-					mediatek,infracfg = <&infracfg_ao>;
 					clocks = <&pericfg_ao CLK_PERI_AO_PCIE_P0_FMEM>;
 					clock-names = "ss-pextp-fmem";
 					#power-domain-cells = <0>;
@@ -1270,14 +1256,12 @@ power-domain@MT8188_POWER_DOMAIN_ADSP_AO {
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
@@ -1286,7 +1270,6 @@ power-domain@MT8188_POWER_DOMAIN_AUDIO_ASRC {
 							reg = <MT8188_POWER_DOMAIN_AUDIO_ASRC>;
 							clocks = <&topckgen CLK_TOP_ASM_H>;
 							clock-names = "asm";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -1296,13 +1279,11 @@ power-domain@MT8188_POWER_DOMAIN_AUDIO {
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
@@ -1312,7 +1293,6 @@ power-domain@MT8188_POWER_DOMAIN_ETHER {
 					reg = <MT8188_POWER_DOMAIN_ETHER>;
 					clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET_MAC>;
 					clock-names = "ethermac";
-					mediatek,infracfg = <&infracfg_ao>;
 					#power-domain-cells = <0>;
 				};
 			};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 47dea10dd3b8..4fc4fb3bf9af 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -504,6 +504,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg>;
 
 				/* power domain of the SoC */
 				power-domain@MT8192_POWER_DOMAIN_AUDIO {
@@ -512,7 +513,6 @@ power-domain@MT8192_POWER_DOMAIN_AUDIO {
 						 <&infracfg CLK_INFRA_AUDIO_26M_B>,
 						 <&infracfg CLK_INFRA_AUDIO>;
 					clock-names = "audio", "audio1", "audio2";
-					mediatek,infracfg = <&infracfg>;
 					#power-domain-cells = <0>;
 				};
 
@@ -520,7 +520,6 @@ power-domain@MT8192_POWER_DOMAIN_CONN {
 					reg = <MT8192_POWER_DOMAIN_CONN>;
 					clocks = <&infracfg CLK_INFRA_PMIC_CONN>;
 					clock-names = "conn";
-					mediatek,infracfg = <&infracfg>;
 					#power-domain-cells = <0>;
 				};
 
@@ -535,7 +534,6 @@ mfg0: power-domain@MT8192_POWER_DOMAIN_MFG0 {
 
 					mfg1: power-domain@MT8192_POWER_DOMAIN_MFG1 {
 						reg = <MT8192_POWER_DOMAIN_MFG1>;
-						mediatek,infracfg = <&infracfg>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -576,7 +574,6 @@ power-domain@MT8192_POWER_DOMAIN_DISP {
 						 <&mmsys CLK_MM_SMI_IOMMU>;
 					clock-names = "disp", "disp-0", "disp-1", "disp-2",
 						      "disp-3";
-					mediatek,infracfg = <&infracfg>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -590,7 +587,6 @@ power-domain@MT8192_POWER_DOMAIN_IPE {
 							 <&ipesys CLK_IPE_GALS>;
 						clock-names = "ipe", "ipe-0", "ipe-1", "ipe-2",
 							      "ipe-3";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -600,7 +596,6 @@ power-domain@MT8192_POWER_DOMAIN_ISP {
 							 <&imgsys CLK_IMG_LARB9>,
 							 <&imgsys CLK_IMG_GALS>;
 						clock-names = "isp", "isp-0", "isp-1";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -610,7 +605,6 @@ power-domain@MT8192_POWER_DOMAIN_ISP2 {
 							 <&imgsys2 CLK_IMG2_LARB11>,
 							 <&imgsys2 CLK_IMG2_GALS>;
 						clock-names = "isp2", "isp2-0", "isp2-1";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -619,7 +613,6 @@ power-domain@MT8192_POWER_DOMAIN_MDP {
 						clocks = <&topckgen CLK_TOP_MDP_SEL>,
 							 <&mdpsys CLK_MDP_SMI0>;
 						clock-names = "mdp", "mdp-0";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -628,7 +621,6 @@ power-domain@MT8192_POWER_DOMAIN_VENC {
 						clocks = <&topckgen CLK_TOP_VENC_SEL>,
 							 <&vencsys CLK_VENC_SET1_VENC>;
 						clock-names = "venc", "venc-0";
-						mediatek,infracfg = <&infracfg>;
 						#power-domain-cells = <0>;
 					};
 
@@ -639,7 +631,6 @@ power-domain@MT8192_POWER_DOMAIN_VDEC {
 							 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
 							 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
 						clock-names = "vdec", "vdec-0", "vdec-1", "vdec-2";
-						mediatek,infracfg = <&infracfg>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -664,7 +655,6 @@ power-domain@MT8192_POWER_DOMAIN_CAM {
 							 <&camsys CLK_CAM_CAM2MM_GALS>;
 						clock-names = "cam", "cam-0", "cam-1", "cam-2",
 							      "cam-3";
-						mediatek,infracfg = <&infracfg>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 1433b3fa0915..78666a4c0323 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -532,6 +532,7 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg_ao>;
 
 				/* power domain of the SoC */
 				mfg0: power-domain@MT8195_POWER_DOMAIN_MFG0 {
@@ -545,7 +546,6 @@ mfg1: power-domain@MT8195_POWER_DOMAIN_MFG1 {
 						clocks = <&apmixedsys CLK_APMIXED_MFGPLL>,
 							 <&topckgen CLK_TOP_MFG_CORE_TMP>;
 						clock-names = "mfg", "alt";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -614,7 +614,6 @@ power-domain@MT8195_POWER_DOMAIN_VPPSYS0 {
 						      "vppsys0-12", "vppsys0-13", "vppsys0-14",
 						      "vppsys0-15", "vppsys0-16", "vppsys0-17",
 						      "vppsys0-18";
-					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -631,7 +630,6 @@ power-domain@MT8195_POWER_DOMAIN_VDOSYS0 {
 						clock-names = "vdosys0", "vdosys0-0", "vdosys0-1",
 							      "vdosys0-2", "vdosys0-3",
 							      "vdosys0-4", "vdosys0-5";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -643,7 +641,6 @@ power-domain@MT8195_POWER_DOMAIN_VPPSYS1 {
 								 <&vppsys1 CLK_VPP1_VPPSYS1_LARB>;
 							clock-names = "vppsys1", "vppsys1-0",
 								      "vppsys1-1";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -655,7 +652,6 @@ power-domain@MT8195_POWER_DOMAIN_WPESYS {
 								 <&wpesys CLK_WPE_SMI_LARB8_P>;
 							clock-names = "wepsys-0", "wepsys-1", "wepsys-2",
 								      "wepsys-3";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -663,7 +659,6 @@ power-domain@MT8195_POWER_DOMAIN_VDEC0 {
 							reg = <MT8195_POWER_DOMAIN_VDEC0>;
 							clocks = <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
 							clock-names = "vdec0-0";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <0>;
@@ -672,7 +667,6 @@ power-domain@MT8195_POWER_DOMAIN_VDEC1 {
 								reg = <MT8195_POWER_DOMAIN_VDEC1>;
 								clocks = <&vdecsys CLK_VDEC_LARB1>;
 								clock-names = "vdec1-0";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 
@@ -680,7 +674,6 @@ power-domain@MT8195_POWER_DOMAIN_VDEC2 {
 								reg = <MT8195_POWER_DOMAIN_VDEC2>;
 								clocks = <&vdecsys_core1 CLK_VDEC_CORE1_LARB1>;
 								clock-names = "vdec2-0";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -689,7 +682,6 @@ power-domain@MT8195_POWER_DOMAIN_VENC {
 							reg = <MT8195_POWER_DOMAIN_VENC>;
 							clocks = <&vencsys CLK_VENC_LARB>;
 							clock-names = "venc0-larb";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <0>;
@@ -698,7 +690,6 @@ power-domain@MT8195_POWER_DOMAIN_VENC_CORE1 {
 								reg = <MT8195_POWER_DOMAIN_VENC_CORE1>;
 								clocks = <&vencsys_core1 CLK_VENC_CORE1_LARB>;
 								clock-names = "venc1-larb";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -711,20 +702,17 @@ power-domain@MT8195_POWER_DOMAIN_VDOSYS1 {
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
 
@@ -741,7 +729,6 @@ power-domain@MT8195_POWER_DOMAIN_IMG {
 							clocks = <&imgsys CLK_IMG_LARB9>,
 								 <&imgsys CLK_IMG_GALS>;
 							clock-names = "img-0", "img-1";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -757,7 +744,6 @@ power-domain@MT8195_POWER_DOMAIN_IPE {
 									 <&imgsys CLK_IMG_IPE>,
 									 <&ipesys CLK_IPE_SMI_LARB12>;
 								clock-names = "ipe", "ipe-0", "ipe-1";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -771,7 +757,6 @@ power-domain@MT8195_POWER_DOMAIN_CAM {
 								 <&camsys CLK_CAM_CAM2SYS_GALS>;
 							clock-names = "cam-0", "cam-1", "cam-2", "cam-3",
 								      "cam-4";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -798,7 +783,6 @@ power-domain@MT8195_POWER_DOMAIN_PCIE_MAC_P0 {
 					reg = <MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
 					clocks = <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
 					clock-names = "ss-pextp0-mem";
-					mediatek,infracfg = <&infracfg_ao>;
 					#power-domain-cells = <0>;
 				};
 
@@ -806,7 +790,6 @@ power-domain@MT8195_POWER_DOMAIN_PCIE_MAC_P1 {
 					reg = <MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
 					clocks = <&pericfg_ao CLK_PERI_AO_PCIE_P1_MEM>;
 					clock-names = "ss-pextp1-mem";
-					mediatek,infracfg = <&infracfg_ao>;
 					#power-domain-cells = <0>;
 				};
 
@@ -842,7 +825,6 @@ power-domain@MT8195_POWER_DOMAIN_ADSP {
 					clock-names = "adsp", "adsp1";
 					#address-cells = <1>;
 					#size-cells = <0>;
-					mediatek,infracfg = <&infracfg_ao>;
 					#power-domain-cells = <1>;
 
 					power-domain@MT8195_POWER_DOMAIN_AUDIO {
@@ -853,7 +835,6 @@ power-domain@MT8195_POWER_DOMAIN_AUDIO {
 							 <&infracfg_ao CLK_INFRA_AO_AUDIO_26M_B>;
 						clock-names = "audio", "audio1", "audio2",
 							      "audio3";
-						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 67347baa3b04..d00aa45fdd04 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -364,6 +364,8 @@ spm: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
+				mediatek,bus-protection = <&infracfg>, <&infracfg_nao>,
+							  <&smi_common>;
 
 				/* power domains of the SoC */
 				power-domain@MT8365_POWER_DOMAIN_MM {
@@ -376,8 +378,6 @@ power-domain@MT8365_POWER_DOMAIN_MM {
 					clock-names = "mm", "mm-0", "mm-1",
 						      "mm-2", "mm-3";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
-					mediatek,infracfg-nao = <&infracfg_nao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -393,20 +393,16 @@ power-domain@MT8365_POWER_DOMAIN_CAM {
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
@@ -423,8 +419,6 @@ power-domain@MT8365_POWER_DOMAIN_APU {
 							      "apu-3", "apu-4",
 							      "apu-5";
 						#power-domain-cells = <0>;
-						mediatek,infracfg = <&infracfg>;
-						mediatek,smi = <&smi_common>;
 					};
 				};
 
@@ -434,7 +428,6 @@ power-domain@MT8365_POWER_DOMAIN_CONN {
 						 <&topckgen CLK_TOP_CONN_26M>;
 					clock-names = "conn", "conn1";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				mfg: power-domain@MT8365_POWER_DOMAIN_MFG {
@@ -442,7 +435,6 @@ mfg: power-domain@MT8365_POWER_DOMAIN_MFG {
 					clocks = <&topckgen CLK_TOP_MFG_SEL>;
 					clock-names = "mfg";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				power-domain@MT8365_POWER_DOMAIN_AUDIO {
@@ -452,7 +444,6 @@ power-domain@MT8365_POWER_DOMAIN_AUDIO {
 						 <&infracfg CLK_IFR_AUD_26M_BK>;
 					clock-names = "audio", "audio1", "audio2";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 
 				power-domain@MT8365_POWER_DOMAIN_DSP {
@@ -461,7 +452,6 @@ power-domain@MT8365_POWER_DOMAIN_DSP {
 						 <&topckgen CLK_TOP_DSP_26M>;
 					clock-names = "dsp", "dsp1";
 					#power-domain-cells = <0>;
-					mediatek,infracfg = <&infracfg>;
 				};
 			};
 		};
-- 
2.49.0


