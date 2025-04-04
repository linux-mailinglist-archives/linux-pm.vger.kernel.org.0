Return-Path: <linux-pm+bounces-24774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D5AA7B60C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 04:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451C03B8866
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CC3137930;
	Fri,  4 Apr 2025 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiI7QF4Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8C4315A;
	Fri,  4 Apr 2025 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735582; cv=none; b=rry8xRT6GOb4tg5bx0Ieg5l+sKnUaiB/8wuIV/QDzAR+QSEcu+Kwxkty2dYOGRbzgCy3YRzXEUq4DQfUPAnUXJds4aoH2qbm4Jf+3GgETrsiGV0DJsppfhWAhDgFKANKSLHoqsdinaYzwBOnAGPgem8vC+M9GqkasUIbWZ0yykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735582; c=relaxed/simple;
	bh=5rtDQ0pe7WShvacxxNJLUqvyINRo/AXE5vD1stW6jE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2GmcHzQOr8EXL/QFtI90QujtX5m8SrQNKiTEkJiKA14r+PKdlN1fIBZhx+20FyAivBLvwqyr/5+qbBgjQk3XwRg/uyKScPXFnGRvoVzFIfnpAbiA6EEjDcgIG0oNySuj+2WGBNULE+LVA1bo2oRzosJnI9GAaP8L0Cdxq3HJt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiI7QF4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EE0C4CEE7;
	Fri,  4 Apr 2025 02:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735581;
	bh=5rtDQ0pe7WShvacxxNJLUqvyINRo/AXE5vD1stW6jE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RiI7QF4QKTnEWoFPph74b7vTTM/C0H5U/et9pNcxSlU59KyGPZFNV+brPyXwaepz9
	 KLVDwu3w2hDzi/J6nmwnrAUCMbyIJUNguH4ZwmXy7GY3k34plvSw0apXzHjtbL/JiB
	 fHNKWkKHWfVX6kKZAkXCeaCuVd3YVWKwvmfjXf+eCSUKsqRLiSyyjTzKvwC48Fgl/N
	 66plYdx2J+E8uU09r4TVAJ84N2SBEaXKVQQscPog8/6dDfqp2eL2fR2J2DXkp7XQC5
	 VoVJj3czjxbBwKonugcBm3JgGhq2hncnAlD4K3x2D04gPtAliniMLLFtRSWpExAY+v
	 iavi1HrZP7Thg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:22 -0500
Subject: [PATCH 01/19] arm64: dts: allwinner: h5/h6: Drop spurious
 'clock-latency-ns' properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-1-076be7171a85@kernel.org>
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

'clock-latency-ns' is not a valid property for CPU nodes. It belongs in
OPP table (which has it). Drop them from the CPU nodes.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 4 ----
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index d3caf27b6a55..48802bf02f3b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -16,7 +16,6 @@ cpu0: cpu@0 {
 			reg = <0>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 		};
 
@@ -26,7 +25,6 @@ cpu1: cpu@1 {
 			reg = <1>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 		};
 
@@ -36,7 +34,6 @@ cpu2: cpu@2 {
 			reg = <2>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 		};
 
@@ -46,7 +43,6 @@ cpu3: cpu@3 {
 			reg = <3>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 2301c59b41b1..73e8604315c5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -27,7 +27,6 @@ cpu0: cpu@0 {
 			reg = <0>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
@@ -44,7 +43,6 @@ cpu1: cpu@1 {
 			reg = <1>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
@@ -61,7 +59,6 @@ cpu2: cpu@2 {
 			reg = <2>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
@@ -78,7 +75,6 @@ cpu3: cpu@3 {
 			reg = <3>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;

-- 
2.47.2


