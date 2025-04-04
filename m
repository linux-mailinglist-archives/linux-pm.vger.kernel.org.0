Return-Path: <linux-pm+bounces-24776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9963DA7B61A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7CB3B8EF6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65803167DB7;
	Fri,  4 Apr 2025 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUkDnjSM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F1B1624C9;
	Fri,  4 Apr 2025 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735585; cv=none; b=MKsMEiL/huPkKrXjAkh9cWw38Z4FDRHIb9eUz5F2kHxoezZQUVMUA5hYZkQDpw5QRjYSV0LByX1ZEhKRuXZxRyKM+EMpnxRGP5lTE3BV94t/LPhQh1QNsl3sZ4c/8d1m8GGvHGPhY95P3YmbXDQVE23KtXJSFLXbMD4oXKJGP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735585; c=relaxed/simple;
	bh=TR8856X/yXYP9UKEhMkJp7m8f9J+E8ChQGwtop6ZgA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e54X88oZxnDXtjG+6i6bdkl+i3u/j6Si43gWPUE8o58Oh677VWOKpWa4aKdUb9zMLZzEDy2Bu7bAhYvcyAZgs/NM/2X00pD4aiGI4Bvou/p2PAynL6QUrg9+ZqSYuY7ee/abX6fowiDF2NdMf92nl4yE0g380IPpCHsETks84M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUkDnjSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CD0C4AF09;
	Fri,  4 Apr 2025 02:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735584;
	bh=TR8856X/yXYP9UKEhMkJp7m8f9J+E8ChQGwtop6ZgA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DUkDnjSM63kRZnwvM0O4CQNp4fGHP7NjHc0kMEGoFudbMbZwd7akrMVPzA7z4fsP/
	 LbzLYWMYPxL/Vp+jaNCT4G1kQQzfAPiLVe4GRnL7kHU6DyYihy7ZNO+Y43TX8Bnp/E
	 SQu6P3nGqwmxa0ZwYvgvpIfC7S8pOEGp4HN86eV4rekb6QVHa59ZiQ86gFvXN16cYI
	 ucq6IBizPqNpMPbRYiTdJeylxn6GfB6XEj6dMKmNQaF7mrRz9hp4c59gvk5IxjrbBn
	 Mw/HuaEhMQ/esGlKPERqAE7RhxCvANISjn9KUarZ5Qu46dIXeGUrJsVuY8dHYWwh96
	 LEIua7+H5rxVg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:24 -0500
Subject: [PATCH 03/19] arm64: dts: morello: Fix-up cache nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-3-076be7171a85@kernel.org>
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

There's no need include the CPU number in the L2 cache node names as
the names are local to the CPU nodes. The documented node name is
also just "l2-cache".

The L3 cache is not part of cpu@0/l2-cache as it is shared among all
cores. Move it to /cpus node which is the typical place for shared
caches.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/arm/morello.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/morello.dtsi b/arch/arm64/boot/dts/arm/morello.dtsi
index 0bab0b3ea969..5bc1c725dc86 100644
--- a/arch/arm64/boot/dts/arm/morello.dtsi
+++ b/arch/arm64/boot/dts/arm/morello.dtsi
@@ -44,7 +44,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&l2_0>;
 			clocks = <&scmi_dvfs 0>;
 
-			l2_0: l2-cache-0 {
+			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				/* 8 ways set associative */
@@ -53,13 +53,6 @@ l2_0: l2-cache-0 {
 				cache-sets = <2048>;
 				cache-unified;
 				next-level-cache = <&l3_0>;
-
-				l3_0: l3-cache {
-					compatible = "cache";
-					cache-level = <3>;
-					cache-size = <0x100000>;
-					cache-unified;
-				};
 			};
 		};
 
@@ -78,7 +71,7 @@ cpu1: cpu@100 {
 			next-level-cache = <&l2_1>;
 			clocks = <&scmi_dvfs 0>;
 
-			l2_1: l2-cache-1 {
+			l2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				/* 8 ways set associative */
@@ -105,7 +98,7 @@ cpu2: cpu@10000 {
 			next-level-cache = <&l2_2>;
 			clocks = <&scmi_dvfs 1>;
 
-			l2_2: l2-cache-2 {
+			l2_2: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				/* 8 ways set associative */
@@ -132,7 +125,7 @@ cpu3: cpu@10100 {
 			next-level-cache = <&l2_3>;
 			clocks = <&scmi_dvfs 1>;
 
-			l2_3: l2-cache-3 {
+			l2_3: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				/* 8 ways set associative */
@@ -143,6 +136,13 @@ l2_3: l2-cache-3 {
 				next-level-cache = <&l3_0>;
 			};
 		};
+
+		l3_0: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <0x100000>;
+			cache-unified;
+		};
 	};
 
 	firmware {

-- 
2.47.2


