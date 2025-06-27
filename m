Return-Path: <linux-pm+bounces-29677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE36AEBBC4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 17:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8998D564106
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9860A2E9EC5;
	Fri, 27 Jun 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WenOP8PH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938D2E9EB2;
	Fri, 27 Jun 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038170; cv=none; b=swUSA9h1EhCt5iaQK0xOm0a3MmOXt8M+lPdZOPxsKwPFa+ZPWxysRrNHLgqN8D4ebjQd04XBZoO+5d0rMeUwQR1ye9Xsv1S9iGC38PactKQbUNMVw1ypfJ9jI7nyZMQ5RkC50yNqh0fi4sUPfV03LKQhCU6FjW7GaQcCv3fToI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038170; c=relaxed/simple;
	bh=LsM/oKAoyeVrerWCsGQ8qkJnLZGaVDxv1+0mdy8Bbow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQHgHcELMr9Sq95dMXwbORS7g6oROrew99TpqiCOxmM8e5d7HkWSbn0V+630F7Vh2WDYhT8+ow27YJsZAtZxlz5ml30Sv+TxcfMz2DxDNh6BqOWbS9Y/Tbfd6k7xJb61SSHipSffsKpJmh1os783Z+6FVEtaDNSsojtahkx1vBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WenOP8PH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3042C4CEF3;
	Fri, 27 Jun 2025 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751038170;
	bh=LsM/oKAoyeVrerWCsGQ8qkJnLZGaVDxv1+0mdy8Bbow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WenOP8PHK54BpguPCGqN18tbpif+eHEwWcahV5qmVT/6mzlrR/UYs8eZWUf0uLGtq
	 ctzHnFY1AEgvkiJK9SH+iK7T9KOLa6BATLbG9HoNaJBpMNgf7gAoUjtKEdMEBc/BIH
	 T1knLPaUKHZCXMfvmFEcLximJTRYKJQtJTm/IDxB3fIn1sKOt/4QMPnSWjQYH6jvec
	 WaTHuq6PK8059ndMHc9Zvkp0gkP0dzAiM7D0Q9d+bYY4JGXAhJLO2NeImTPRjU1tJD
	 tM0ug3rBiz9+ymzGK6y71ZPG8D9V+qkqInbENL3CrVZibO+YbGArB3Wd8nJsVvfUU0
	 8dP1I/pq56IBg==
Received: by wens.tw (Postfix, from userid 1000)
	id 456665FFC8; Fri, 27 Jun 2025 23:29:27 +0800 (CST)
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
Subject: [PATCH 4/4] arm64: dts: allwinner: a523: Add power controller device nodes
Date: Fri, 27 Jun 2025 23:29:18 +0800
Message-Id: <20250627152918.2606728-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250627152918.2606728-1-wens@kernel.org>
References: <20250627152918.2606728-1-wens@kernel.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 6f62201fd739..255e0ef98219 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -7,6 +7,8 @@
 #include <dt-bindings/clock/sun55i-a523-r-ccu.h>
 #include <dt-bindings/reset/sun55i-a523-ccu.h>
 #include <dt-bindings/reset/sun55i-a523-r-ccu.h>
+#include <dt-bindings/power/allwinner,sun55i-a523-ppu.h>
+#include <dt-bindings/power/allwinner,sun55i-a523-pck600.h>
 
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


