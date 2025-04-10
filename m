Return-Path: <linux-pm+bounces-25140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741DA84897
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E235D1BA131E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F1E28F928;
	Thu, 10 Apr 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQOmjXnq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8928EA7E;
	Thu, 10 Apr 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300077; cv=none; b=D0gmKwZqviduPXhfXz/pfKwXtMTUaJUHEqdm7CUCGlw6bl28e6lVXit4Y1PbdGz6+P9hH1t6QCPISxZwFuVebhPRLngFk6z3l6JM6ihW1zAufUdt5cGe6qoo8reRkVrK+aOJJEE/ZC9zEB9OZLulr/nUQKZmPwQTvlsqilr8VU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300077; c=relaxed/simple;
	bh=xMgbsjBv9Kef+UFcQ6l0JsE73pnNHHIi5V3EKTVvKZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwJ/iBPAG7pAHWuNFTGlzPMFm/ILDhsxH6h5biFn6iJ1WQp6TeYVO0zuWGOdBXsb6GlP2ofiN9uT6hbwqddTaIiMY30Wdi/hgStEBdFi7WJumQl6lWInIiaN5VmOrDjOvuMvP+E1bJmPlEIN7r9VtzsN1Cp/ybwIT3MVQKRzCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQOmjXnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26405C4CEDD;
	Thu, 10 Apr 2025 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300077;
	bh=xMgbsjBv9Kef+UFcQ6l0JsE73pnNHHIi5V3EKTVvKZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aQOmjXnqnWK8Nld/ZGzxs4xNkx46h21EaRICn25BYXuFTFYoPBcPH3fp3tvu0Nz5s
	 DLQmHkmLKQSHWzVXzLYg1566gLijWI2uFV+/OxcMmmm5GGFBbPXAOn7CBBfAYiz3Dm
	 ttkmY5t4PXSe+qDyQmwyn6h7ywO+0uVpG+0D9wT+B9VJVpTF3CbsTHHp8472LTaLe5
	 WiIXKlohnsSpd2Jf62u1AJY/4jfhKtNb/DwQp2ZMlbYzdoBx+uyJgl1ed9s9yw8tKC
	 uCvtb5UGywK4j8VEQe2SHf/jJ6zxxP5rn3JjytQgQkC1EyugBS6VwnFHhl7++QWwkE
	 rVo3Wdgs4jZtw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:29 -0500
Subject: [PATCH v2 08/17] arm/arm64: dts: imx: Drop redundant CPU
 "clock-latency"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-8-63d7dc9ddd0a@kernel.org>
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
"clock-latency-ns". The OPP tables have values of 150000, so it can be
removed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi      | 1 -
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 4 ----
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 4 ----
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ----
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ----
 5 files changed, 17 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 2629968001a7..9235dd7e93bb 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -73,7 +73,6 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0>;
 			clock-frequency = <792000000>;
-			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks IMX7D_CLK_ARM>;
 			cpu-idle-states = <&cpu_sleep_wait>;
 			operating-points-v2 = <&cpu0_opp_table>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4de3bf22902b..cfebaa01217e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -62,7 +62,6 @@ A53_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
-			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MM_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -83,7 +82,6 @@ A53_1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
-			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MM_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -102,7 +100,6 @@ A53_2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
-			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MM_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -121,7 +118,6 @@ A53_3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
-			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MM_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a5f9cfb46e5d..848ba5e46ee6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -62,7 +62,6 @@ A53_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
-			clock-latency = <61036>;
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -83,7 +82,6 @@ A53_1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
-			clock-latency = <61036>;
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -102,7 +100,6 @@ A53_2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
-			clock-latency = <61036>;
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -121,7 +118,6 @@ A53_3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
-			clock-latency = <61036>;
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index ce6793b2d57e..f8afdba71c36 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -65,7 +65,6 @@ A53_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
-			clock-latency = <61036>;
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -86,7 +85,6 @@ A53_1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
-			clock-latency = <61036>;
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -105,7 +103,6 @@ A53_2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
-			clock-latency = <61036>;
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -124,7 +121,6 @@ A53_3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
-			clock-latency = <61036>;
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d51de8d899b2..d27b824995eb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -106,7 +106,6 @@ A53_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
-			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MQ_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -126,7 +125,6 @@ A53_1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
-			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MQ_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -144,7 +142,6 @@ A53_2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
-			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MQ_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -162,7 +159,6 @@ A53_3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
-			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clk IMX8MQ_CLK_ARM>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;

-- 
2.47.2


