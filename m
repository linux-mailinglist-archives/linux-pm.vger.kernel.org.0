Return-Path: <linux-pm+bounces-24779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2ADA7B62F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4537C3B94E9
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22D1917D0;
	Fri,  4 Apr 2025 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5AlyHo+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908641624C9;
	Fri,  4 Apr 2025 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735588; cv=none; b=GqTczs088wgNW3HKo4O86ZqwGzOTPfuNiZZCnJCrbX9b/wlPc7470cIf9gpNrjK84qANi8ZmMPtxOAXI5m98b14bGgA1fYlEmRnOdnIKqnvzxfhPCFN2HncPZjBrEYtaUi6bWrHCXkG214h5HAPWZblvSLpB+VMAAunhxUHx2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735588; c=relaxed/simple;
	bh=gxonXFhgUAPjWh8ts8EKS+oHyduTymt0daNZo0ExVAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7lQawviuQFbhcyhg9/WHOLUij979Gzjv3VT0KxiBBh1S3aJakxnjL9i5Db1JMx8XjhCPHzKw+GmWk1noqMDc2tyL6pHNJERT35yBAy35QcTWXYUuwvoi5Zp1G/uZUMHu9OdjsYHObfxbYVFjcEx6PUXHVr6TEfvcCMoGlz9uvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5AlyHo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ABBC4CEE7;
	Fri,  4 Apr 2025 02:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735588;
	bh=gxonXFhgUAPjWh8ts8EKS+oHyduTymt0daNZo0ExVAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q5AlyHo+mQj3kurh2xUoSRYFq+1yRj9H+a7Gmn4LnwFHLR3AnDO/JaVceXofqiY/3
	 /xQ+f5of5Hm4HbuSD27xDVrwkVEIeMMW4VTsN9M/FKQTp1fK9AAZ1eNnJHWa5EVcch
	 1YuoXfohfyZI1t8ysMs/oJtbRtc/lXOx22hjlh62miVS8jEZ76LPU2rDV7Ip7Sp4hP
	 1k08hbFngCdFOvEVrao83FuUXXn8xaBe6pMb28raR8ttL4HJfNlJ9x1l7dFVwdX5Po
	 4DdcqBBRZFzRhTz4d6M83O7pVB3CLQkueenV35FwvKPcQwLGetut/o2MUhYhZQg6e7
	 ZVrW1lHWld3gQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:27 -0500
Subject: [PATCH 06/19] arm64: dts: qcom: msm8939: Fix CPU node
 "enable-method" property dependencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-6-076be7171a85@kernel.org>
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
In-Reply-To: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
 Conor Dooley <conor@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org, 
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15-dev

The "qcom,acc" and "qcom,saw" properties aren't valid with "spin-table"
enable-method nor are they used on 64-bit kernels, so they can be
dropped.

The "spin-table" enable-method requires "cpu-release-addr" property,
so add a dummy entry. It is assumed the bootloader will fill in the
correct values.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 7cd5660de1b3..36f2ba3fb81c 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -46,10 +46,9 @@ cpu0: cpu@100 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x100>;
 			next-level-cache = <&l2_1>;
-			qcom,acc = <&acc0>;
-			qcom,saw = <&saw0>;
 			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs1_mbox>;
 			#cooling-cells = <2>;
@@ -64,10 +63,9 @@ cpu1: cpu@101 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x101>;
 			next-level-cache = <&l2_1>;
-			qcom,acc = <&acc1>;
-			qcom,saw = <&saw1>;
 			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs1_mbox>;
 			#cooling-cells = <2>;
@@ -77,10 +75,9 @@ cpu2: cpu@102 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x102>;
 			next-level-cache = <&l2_1>;
-			qcom,acc = <&acc2>;
-			qcom,saw = <&saw2>;
 			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs1_mbox>;
 			#cooling-cells = <2>;
@@ -90,10 +87,9 @@ cpu3: cpu@103 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x103>;
 			next-level-cache = <&l2_1>;
-			qcom,acc = <&acc3>;
-			qcom,saw = <&saw3>;
 			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs1_mbox>;
 			#cooling-cells = <2>;
@@ -103,9 +99,8 @@ cpu4: cpu@0 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x0>;
-			qcom,acc = <&acc4>;
-			qcom,saw = <&saw4>;
 			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs0_mbox>;
 			#cooling-cells = <2>;
@@ -121,10 +116,9 @@ cpu5: cpu@1 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x1>;
 			next-level-cache = <&l2_0>;
-			qcom,acc = <&acc5>;
-			qcom,saw = <&saw5>;
 			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs0_mbox>;
 			#cooling-cells = <2>;
@@ -134,10 +128,9 @@ cpu6: cpu@2 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x2>;
 			next-level-cache = <&l2_0>;
-			qcom,acc = <&acc6>;
-			qcom,saw = <&saw6>;
 			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs0_mbox>;
 			#cooling-cells = <2>;
@@ -147,10 +140,9 @@ cpu7: cpu@3 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x3>;
 			next-level-cache = <&l2_0>;
-			qcom,acc = <&acc7>;
-			qcom,saw = <&saw7>;
 			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs0_mbox>;
 			#cooling-cells = <2>;

-- 
2.47.2


