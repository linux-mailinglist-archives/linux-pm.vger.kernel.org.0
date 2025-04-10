Return-Path: <linux-pm+bounces-25143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B27BA848A6
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBD19C3ADE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940C28FFF3;
	Thu, 10 Apr 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auwxjw2t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5F28FFE1;
	Thu, 10 Apr 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300080; cv=none; b=cBjpqt4OWdOWipnTJFCjRx5hcohZulKGaYEuOH2BC22mDLIJRFEPvTLaSqngbF0GCXmRyz+XQxdbnSJJMGqgpS0Foaju7CCRnUUXaph3tSTWFDzbq3YhWai/9/7AnNtiaIl6VdoBVmWTuX8h9CRLILVxZP7240SdBy4jLiaJrFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300080; c=relaxed/simple;
	bh=xnnf/JMo7g8hotGpKUR0IYT07WFDf4YWzcm+WUwyUKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYNGcuJh9mnlMdFyk2ukjZCHZ+jUM314G34wuCHYEdHOlIUmZYfnvLMnHBCl3UmOkU5xFpQG+kqGR7YG+eFOcgwmmRhxonuh8x3g0fEKj2JwV56nmHi7TgH1hkLGEZyZtX+NE8aO0/UWpo/AiKNji0efL08XXquCriwwXQdTWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auwxjw2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F236DC4CEE8;
	Thu, 10 Apr 2025 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300080;
	bh=xnnf/JMo7g8hotGpKUR0IYT07WFDf4YWzcm+WUwyUKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=auwxjw2tabmR3j6czYfHJ2Ftx0bKAKDvpJxupRWC3c3TooP0NGWSQTloRzerUXGyv
	 cfV6ImAGjJSXKtGcuw3EH5yL2wgpZXbxCANR0W1x+AEowm2XbBlWkt897w8kxAYQUj
	 pjywt414Q8DCrFX7/Lh37dovG8HQP0Fwr3j4q7+cRXh0vc1Tw1bWEE3F4kJD6pVDsP
	 lTBOxqtO0hvjHrjEDjGZJrl9Fk7jOp/w+J+3uygbgezRqH+/qhJi1nbkNms7BtaNxe
	 P7Vo36xuI0vQZ+X2eI37RniaVxDAaQ6RbJHm7EIIH1KLd0nAIQ4OxiA5WlXx7bHGLT
	 XueIeaIeEtOxg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:31 -0500
Subject: [PATCH v2 10/17] arm: dts: rockchip: Drop redundant CPU
 "clock-latency"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-10-63d7dc9ddd0a@kernel.org>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
In-Reply-To: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Conor Dooley <conor@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Andy Gross <agross@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15-dev

The "clock-latency" property is part of the deprecated opp-v1 binding
and is redundant if the opp-v2 table has equal or larger values in any
"clock-latency-ns". Add any missing "clock-latency-ns" properties and
remove "clock-latency".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 8 +++++++-
 arch/arm/boot/dts/rockchip/rk3188.dtsi | 1 -
 arch/arm/boot/dts/rockchip/rk322x.dtsi | 1 -
 arch/arm/boot/dts/rockchip/rk3288.dtsi | 5 +----
 arch/arm/boot/dts/rockchip/rv1108.dtsi | 1 -
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index d4572146d135..c49099954c28 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -48,7 +48,6 @@ cpu0: cpu@f00 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf00>;
-			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			resets = <&cru SRST_CORE0>;
 			operating-points-v2 = <&cpu_opp_table>;
@@ -87,31 +86,38 @@ cpu_opp_table: opp-table-0 {
 		opp-216000000 {
 			opp-hz = /bits/ 64 <216000000>;
 			opp-microvolt = <950000 950000 1325000>;
+			clock-latency-ns = <40000>;
 		};
 		opp-408000000 {
 			opp-hz = /bits/ 64 <408000000>;
 			opp-microvolt = <950000 950000 1325000>;
+			clock-latency-ns = <40000>;
 		};
 		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <950000 950000 1325000>;
+			clock-latency-ns = <40000>;
 		};
 		opp-696000000 {
 			opp-hz = /bits/ 64 <696000000>;
 			opp-microvolt = <975000 975000 1325000>;
+			clock-latency-ns = <40000>;
 		};
 		opp-816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1075000 1075000 1325000>;
 			opp-suspend;
+			clock-latency-ns = <40000>;
 		};
 		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000 1200000 1325000>;
+			clock-latency-ns = <40000>;
 		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1325000 1325000 1325000>;
+			clock-latency-ns = <40000>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/rockchip/rk3188.dtsi b/arch/arm/boot/dts/rockchip/rk3188.dtsi
index 44b54af0bbf9..850bd6e67895 100644
--- a/arch/arm/boot/dts/rockchip/rk3188.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3188.dtsi
@@ -23,7 +23,6 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x0>;
-			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			resets = <&cru SRST_CORE0>;
diff --git a/arch/arm/boot/dts/rockchip/rk322x.dtsi b/arch/arm/boot/dts/rockchip/rk322x.dtsi
index 96421355c274..cd11a018105b 100644
--- a/arch/arm/boot/dts/rockchip/rk322x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk322x.dtsi
@@ -36,7 +36,6 @@ cpu0: cpu@f00 {
 			resets = <&cru SRST_CORE0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
-			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			enable-method = "psci";
 		};
diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
index 3f1d640afafa..42d705b544ec 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -70,7 +70,6 @@ cpu0: cpu@500 {
 			resets = <&cru SRST_CORE0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
-			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			dynamic-power-coefficient = <370>;
 		};
@@ -81,7 +80,6 @@ cpu1: cpu@501 {
 			resets = <&cru SRST_CORE1>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
-			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			dynamic-power-coefficient = <370>;
 		};
@@ -92,7 +90,6 @@ cpu2: cpu@502 {
 			resets = <&cru SRST_CORE2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
-			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			dynamic-power-coefficient = <370>;
 		};
@@ -103,7 +100,6 @@ cpu3: cpu@503 {
 			resets = <&cru SRST_CORE3>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
-			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			dynamic-power-coefficient = <370>;
 		};
@@ -116,6 +112,7 @@ cpu_opp_table: opp-table-0 {
 		opp-126000000 {
 			opp-hz = /bits/ 64 <126000000>;
 			opp-microvolt = <900000>;
+			clock-latency-ns = <40000>;
 		};
 		opp-216000000 {
 			opp-hz = /bits/ 64 <216000000>;
diff --git a/arch/arm/boot/dts/rockchip/rv1108.dtsi b/arch/arm/boot/dts/rockchip/rv1108.dtsi
index f3291f3bbc6f..42a4d72597a5 100644
--- a/arch/arm/boot/dts/rockchip/rv1108.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1108.dtsi
@@ -32,7 +32,6 @@ cpu0: cpu@f00 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf00>;
-			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <75>;

-- 
2.47.2


