Return-Path: <linux-pm+bounces-16241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6599AB273
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1722FB22DE2
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87691BC09F;
	Tue, 22 Oct 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CC/m5DRh"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DB1B5EB0;
	Tue, 22 Oct 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611917; cv=none; b=Mxqs/hEiqEMmiI7KCSzfrYD2hL54U5n46munnx/xoQhtXlfAF9tfpoHkYw6Lajt85224x7uCoC62ec2CiqoEN2LZaqvmzOd6Is+vDAeUJVskIBf/3n2+ntZFUGJxzlh3IDY8Th2JvXa4PcYWQjgw3Iccazh8cRo/4njSlio+LXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611917; c=relaxed/simple;
	bh=513CsyhV/ZTzfO1CeBeYxWkSG45NVUF8T+D2EZPs0oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qs0VvbHY24KVD+irQg1x7YbcygAjUN6PLWHHPXuTxxqEi6PCvhjSynq0PMtERV6ArWMMFTcWih93w72RSr2g7Gms2EyrbnJJ0AghtHpjJlMPHsJWYkCwN5VMNKlTav8ITNctGQTJDZ80TofC2VjR3vEWQnGf8MOUcut4XHF0pNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CC/m5DRh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729611910;
	bh=513CsyhV/ZTzfO1CeBeYxWkSG45NVUF8T+D2EZPs0oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CC/m5DRhG0iwUnMMw1PaGiD4H0BA6tRi32e/7oE9sxnKGG2bUJ5K7OKn0FVT/Y/71
	 y7h42tCOYr/2R3R1x+TwuxoQ4aDelNOkhg1OPAgImjwFDqq5t8brUYEKxOzY5zHBuE
	 UU1PNjAPdQDyWT+DlRVBVvczx9fAUNuVJbJk7MAYCUrCNRzuScByrTiaBA8Cwikpg9
	 jO310doCik/ew9/OcqMj07G7Ylak2q8VX002+9AvFfBMfeTpsR6X8hGEoJEkWzIb2H
	 eZ2++lQLjCsS/UtNHbnvXMHbMkD1msEDIRSQ7B+1ys7MAfjZ44hBSWWcm3DuFcF6pJ
	 jp2Lx48iiAzLg==
Received: from jupiter.universe (dyndsl-091-248-085-026.ewe-ip-backbone.de [91.248.85.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EEE9A17E3684;
	Tue, 22 Oct 2024 17:45:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 71A22480100; Tue, 22 Oct 2024 17:45:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v3 7/7] arm64: dts: rockchip: Add GPU power domain regulator dependency for RK3588
Date: Tue, 22 Oct 2024 17:41:52 +0200
Message-ID: <20241022154508.63563-8-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022154508.63563-1-sebastian.reichel@collabora.com>
References: <20241022154508.63563-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enabling the GPU power domain requires that the GPU regulator is
enabled. The regulator is enabled at boot time, but automatically
gets disabled when there are no users.

If the GPU driver is not probed at boot time or rebound while
the system is running the system will try to enable the power
domain before the regulator is enabled resulting in a failure
hanging the whole system. Avoid this by adding an explicit
dependency.

Reported-by: Adrián Martínez Larumbe <adrian.larumbe@collabora.com>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts          | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                 | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts              | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi            | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi  | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts                | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi            | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts              | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts       | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts            | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi                | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts            | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts        | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts      | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts         | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts            | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts              | 4 ++++
 25 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
index c667704ba985..00a1cd96781d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
@@ -286,6 +286,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 811b15064851..a6b2855cda94 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -861,7 +861,7 @@ power-domain@RK3588_PD_NPU2 {
 				};
 			};
 			/* These power domains are grouped by VD_GPU */
-			power-domain@RK3588_PD_GPU {
+			pd_gpu: power-domain@RK3588_PD_GPU {
 				reg = <RK3588_PD_GPU>;
 				clocks = <&cru CLK_GPU>,
 					 <&cru CLK_GPU_COREGROUP>,
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index fde8b228f2c7..cf9d75159ba6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
@@ -277,6 +277,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
index 03fd193be253..381242c8d6db 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
@@ -126,6 +126,10 @@ regulator-state-mem {
 	};
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	leds {
 		led_user_en: led_user_en {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index 7dc3ee6e7eb4..142e685ae513 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -485,6 +485,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	audio {
 		hp_detect: headphone-detect {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi
index 47e64d547ea9..799a71da7157 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi
@@ -205,6 +205,10 @@ regulator-state-mem {
 	};
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	leds {
 		led_rgb_b: led-rgb-b {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi
index e3a9598b99fc..1af0a30866f6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi
@@ -256,6 +256,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	gpio-leds {
 		led_sys_pin: led-sys-pin {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 31d2f8994f85..3cefaf830229 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -403,6 +403,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	emmc {
 		emmc_reset: emmc-reset {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index fc131789b4c3..30a5e4e9e844 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -519,6 +519,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	gpio-leds {
 		sys_led_pin: sys-led-pin {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
index c2a08bdf09e8..a9c1fed929fd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
@@ -312,6 +312,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	pcie2 {
 		pcie2_0_rst: pcie2-0-rst {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index c3a6812cc93a..62863b6b1c88 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -389,6 +389,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index e4a20cda65ed..c8efe60e93ca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -348,6 +348,10 @@ rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
index d0b922b8d67e..0eadf4fb4ba4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -530,6 +530,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		rtc_int: rtc-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 8f7a59918db7..717504383d46 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -465,6 +465,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hdmirx {
 		hdmirx_hpd: hdmirx-5v-detection {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 615094bb8ba3..1b5c4a7fd5c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -317,6 +317,10 @@ &pcie3x4 {
 	reset-gpios = <&gpio3 RK_PB6 GPIO_ACTIVE_HIGH>;
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	emmc {
 		emmc_reset: emmc-reset {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts b/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts
index d0021524e7f9..69aadc6c8b74 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts
@@ -289,6 +289,10 @@ rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	rtl8211f {
 		rtl8211f_rst: rtl8211f-rst {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index dbaa94ca69f4..83fc7ff55157 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -229,6 +229,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	fan {
 		fan_int: fan-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 074c316a9a69..d938db0e2239 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -329,6 +329,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
index 467f69594089..9b02cea96cdb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
@@ -675,6 +675,10 @@ &pcie2x1l1 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	audio-amplifier {
 		headphone_amplifier_en: headphone-amplifier-en {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index d8c50fdcca3b..1126fb442516 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -416,6 +416,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	bluetooth-pins {
 		bt_reset: bt-reset {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb464..d29d404417ee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -233,6 +233,10 @@ hym8563: rtc@51 {
 	};
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	vdd_sd {
 		vdd_sd_en: vdd-sd-en {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
index 4fa644ae510c..3dd8372b2578 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
@@ -326,6 +326,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	gpio-key {
 		key1_pin: key1-pin {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts
index 63d91236ba9f..5f32a339f5c9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts
@@ -401,6 +401,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	lcd {
 		lcd_pwren: lcd-pwren {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
index feea6b20a6bf..ef3a721d1fc7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
@@ -297,6 +297,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	gpio-func {
 		leds_gpio: leds-gpio {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 294b99dd50da..a61864482f1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -317,6 +317,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	leds {
 		io_led: io-led {
-- 
2.45.2


