Return-Path: <linux-pm+bounces-30491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA7BAFEE23
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651057AD442
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283152E9725;
	Wed,  9 Jul 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG1dnL7n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62F23B60A;
	Wed,  9 Jul 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076427; cv=none; b=I+CMo4YYzAmpVmgZTNVJeCdwPU1mSM4i4L0kby9MHg98afk/+hE/U+/Q4N7DjgUputsMUSNZQOqtpXCDz/73btulxik20y+Lu+tecAfhneLYAEG3hGGaOdXCP0cqYEdKWnc7XA6O9MLV5jDMK40iL3FNjqf5y1QMPUZPM4jcaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076427; c=relaxed/simple;
	bh=auLp4VPpxKVh9axnEXKMdMv55v6kyflUZ74PwOJ/8jI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bseqt6vshyt1pkPoOh4nfy8BP/FuJCbmxbYPy6VderZ28uX1qZM7UDmwAI9RpV4zxjpGcSvs7t3VrxEtL+bDJd2YjSDincJV4N+EgTTVYtQqziegTVF80U8oBg5lnVVsST6S1Nn75gotzdB/kNOVIiKsYAxvyJEaAqXRFVqm4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG1dnL7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD4CC4CEF1;
	Wed,  9 Jul 2025 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076426;
	bh=auLp4VPpxKVh9axnEXKMdMv55v6kyflUZ74PwOJ/8jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LG1dnL7nG4nUS3ck9K7yd8b+l1y6z5ShY5H86pQPSZSjlx5yUkdgGMC4c+lLZKmkL
	 rcY2xYW7ZdP3a+dPejo0S5Qrk+wwzEX9HO0pc8m6wJZ4mHqM6cEYkS78AVjUrC/FIA
	 B/DdrJPbYb+7C50teX7uiTZfhdkR9FEDuCLh5vQA1oDbK4iX5Nv5PTyzei/w4DJ/hn
	 1p+joPPlAt8JeaCEjOOSo0CalTl1AejkZi50+79N7Fck+E4blkD74VptzBQtW5GeDh
	 /Hw50Ptt0/pymZz/DTIDXipeRl4/YHZC+lofDlBWvicZR9JiYe8joTTmblaQarbIKr
	 1FnG7jaXZgT9g==
Received: by wens.tw (Postfix, from userid 1000)
	id 51A1C5FF71; Wed,  9 Jul 2025 23:53:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 4/4] arm64: dts: allwinner: a523: Add power controller device nodes
Date: Wed,  9 Jul 2025 23:53:43 +0800
Message-Id: <20250709155343.3765227-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709155343.3765227-1-wens@kernel.org>
References: <20250709155343.3765227-1-wens@kernel.org>
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
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index cf0bc39aab04..dd6fa22f960f 100644
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


