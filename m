Return-Path: <linux-pm+bounces-30716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C17B029B5
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 09:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3357B7E8E
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F3E221DAE;
	Sat, 12 Jul 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK0Zw/U0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310A1BEF8C;
	Sat, 12 Jul 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752306046; cv=none; b=t5Pi/rvF+SNVbOyT779teoUnABlDeUTIlSP+liB2bTuHDNDaGp2zIF8GVbgSJEujuWiI+tgKBdLER8/3PLxUh+Yx/fgiZZqeFVwaLA0QVioy86WQ7HJ32k0qdOaljQuQPOQ4+h/KKRLR8yaQ4WSbKy+0VEkRb3Y1cnHaGGdsdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752306046; c=relaxed/simple;
	bh=Q6nAgSUeScunA7Cy3L5NXY072V+uXnej/Z2sR3Zl66U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Shi/wBPklWHBPVjeHnS4hD0+1MXmYVMW/I/WZ6nv+07CRmi4edO2tRBXKESl3amh9XNoqf81vlvjwkNs8B6dyMbc2Fqz1c0RU2ThjIovH82e/yCKiu3C4XYnyrEhjNU1/3VRqWM7Jw1HKHg3YMo0+LdZuAs52r+MOZPCppKVJvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK0Zw/U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6A2C4CEF4;
	Sat, 12 Jul 2025 07:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752306045;
	bh=Q6nAgSUeScunA7Cy3L5NXY072V+uXnej/Z2sR3Zl66U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jK0Zw/U0hjtPWLjojRMurFzl7NBY1lwGSl9bxABYDqnkVy49Y5AbPiq4vmbQcnG0K
	 BVsnmuEznH36Y65UXGM1DHpmPfVhsnWf7gsNwoYpJY6DKr0HfgEnFc3dGOUaQs8A4t
	 kRRa7VKcYRwAQd4M0XIumlRD2KkooOc1PB7uGzkEzIZyKeCkEBjLjnM9JfaMkdzvQ8
	 Ick0/v0ciqMHuVAMKHGmxd3IOvHnsV4vNmamV/UEITLvKYeVbFPsfhQo2ZYj4Tki7T
	 E/9zs0IdmvmhPs85b+SXWaX5y7K2qCAJ+9zl6Mlwr26Lej9Eiu5XFO66612y46Tlq1
	 t4F1KIvEqCIrg==
Received: by wens.tw (Postfix, from userid 1000)
	id 9ED7D5FB60; Sat, 12 Jul 2025 15:40:42 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: allwinner: a523: Add power controller device nodes
Date: Sat, 12 Jul 2025 15:40:21 +0800
Message-Id: <20250712074021.805953-6-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712074021.805953-1-wens@kernel.org>
References: <20250712074021.805953-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The A523 SoC family has two power controllers, one based on the existing
PPU, and one newer one based on ARM's PCK-600.

Add device nodes for both of them.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---
Changes since v2:
- Fixed pck-600 header path
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index cf0bc39aab04..2ac6580b2497 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -7,6 +7,8 @@
 #include <dt-bindings/clock/sun55i-a523-r-ccu.h>
 #include <dt-bindings/reset/sun55i-a523-ccu.h>
 #include <dt-bindings/reset/sun55i-a523-r-ccu.h>
+#include <dt-bindings/power/allwinner,sun55i-a523-ppu.h>
+#include <dt-bindings/power/allwinner,sun55i-a523-pck-600.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -576,6 +578,14 @@ mdio0: mdio {
 			};
 		};
 
+		ppu: power-controller@7001400 {
+			compatible = "allwinner,sun55i-a523-ppu";
+			reg = <0x07001400 0x400>;
+			clocks = <&r_ccu CLK_BUS_R_PPU1>;
+			resets = <&r_ccu RST_BUS_R_PPU1>;
+			#power-domain-cells = <1>;
+		};
+
 		r_ccu: clock-controller@7010000 {
 			compatible = "allwinner,sun55i-a523-r-ccu";
 			reg = <0x7010000 0x250>;
@@ -622,6 +632,14 @@ r_i2c_pins: r-i2c-pins {
 			};
 		};
 
+		pck600: power-controller@7060000 {
+			compatible = "allwinner,sun55i-a523-pck-600";
+			reg = <0x07060000 0x8000>;
+			clocks = <&r_ccu CLK_BUS_R_PPU0>;
+			resets = <&r_ccu RST_BUS_R_PPU0>;
+			#power-domain-cells = <1>;
+		};
+
 		r_i2c0: i2c@7081400 {
 			compatible = "allwinner,sun55i-a523-i2c",
 				     "allwinner,sun8i-v536-i2c",
-- 
2.39.5


