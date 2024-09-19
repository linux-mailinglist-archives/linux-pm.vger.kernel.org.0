Return-Path: <linux-pm+bounces-14453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917C97C6D6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE041F26AF1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F92D19CCF4;
	Thu, 19 Sep 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iytJarHL"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8167819A2A3;
	Thu, 19 Sep 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737523; cv=none; b=iYwX/lz4xWmt347hMpKH4HYQ5L+K23PU7qEMoMMUjGmWwOHAFCzRCACIFCXtpa/MX6sMt0Yy9JFKKZHZQHc/SS7Tn3U3pg2KmmPZv9r/IwTVhp1Z3zubgjVBGCarGXl5nSnRgI4CQUCEpa6cwgG+c8wbGX+wdzkdsZq566eGmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737523; c=relaxed/simple;
	bh=O6Zi18XcTc367wDKXNZ/gGl9r6Y62ZVWpmASigwWTiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2OujxgHdOsKU2wdSr9UVk/wcKwKyFo3oozpWi40ZUNuT6zJls/z1wtQnQOelGt8abeNu4N9OX7TiyYmOuPU8QNTJIr1crO4CRk1rTTtoU0E3QsHYcxVO22PLGzySg2l4L0vjQeq+CioNHSqJWvP1+gSKEM/tDtX1IGlqyiav+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iytJarHL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726737516;
	bh=O6Zi18XcTc367wDKXNZ/gGl9r6Y62ZVWpmASigwWTiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iytJarHLvVRIeNUNsm4Zf6EsfBGwHBbnwqBgKjORK5mXvVP2BfgWewZrgfJWxv2uq
	 E+/VRJLRGn6SlILbP4tAI4eyeOn04mObP1s5dbpKGa4VOkxPeCsSS1is922GTdrhvu
	 Jn4ymI9Hy4vNjpAIWGqyvw2mK7glWIyypVYizYTb4HBMUNHTIeFFweOf24DckF6OrU
	 mCxp1oMtnuprenqWg4q5UqZbolugvyc28cjmHcLVV37el+2atbFOQ5VHkawqyAjp0e
	 hHtX5XGoZNF7+ZV8zxRQd/mu2MDbuqQvmHE/hfBCNhUrWaMpwu9GiMWQEcJ1Wabm6q
	 alu87jA/OiJEg==
Received: from jupiter.universe (dyndsl-091-248-208-160.ewe-ip-backbone.de [91.248.208.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B9F6317E10B5;
	Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 6153048008A; Thu, 19 Sep 2024 11:18:36 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 6/6] arm64: dts: rockchip: Add GPU power domain regulator dependency for RK3588
Date: Thu, 19 Sep 2024 11:12:47 +0200
Message-ID: <20240919091834.83572-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919091834.83572-1-sebastian.reichel@collabora.com>
References: <20240919091834.83572-1-sebastian.reichel@collabora.com>
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
 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts         | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi          | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts               | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts             | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts              | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi               | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts        | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts          | 4 ++++
 12 files changed, 45 insertions(+), 1 deletion(-)

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
index 905f37876c23..d82ac5a481b4 100644
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
-- 
2.45.2


