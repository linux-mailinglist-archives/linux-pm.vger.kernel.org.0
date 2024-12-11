Return-Path: <linux-pm+bounces-19028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEAD9ECEAB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45A8167A40
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250B61D9688;
	Wed, 11 Dec 2024 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z6c9wyt9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A91ABEA8;
	Wed, 11 Dec 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927454; cv=none; b=gJbqI5CUeHyflGFnJX6+nswfLin0krLfPuiPsMztYKOLMfnhvX1XU8WS5Ynsp8rL0Wv8gTIboxhbKdHvjWysr6jasdMBSt2j26xPNbH3Ktro1C8Z4enrbwl9ZdI8kP8HDg1M1jMHGSU2msLN9e+MNk7wrfezEr9ZB9LAD+b3Rgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927454; c=relaxed/simple;
	bh=ranP3eXOeNssPSnVjEbAv85sgFiOZwuDBoPC679vEyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jr/MxtHBcK56WQ5EkQ3UD6RwHOtjlaaZfRILLJUR2hmj39njTzooxRubHTzI4KkJDNdEaEwIQdBXAivjwbZ+xlAtffE1mcPX2aPb/M4djvqPL1p6dBFJRY1r185zL6E4tA0Ni9MkeqYOwXUPxfr4XeeBpFM81zAEUv+6VsbAdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z6c9wyt9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733927446;
	bh=ranP3eXOeNssPSnVjEbAv85sgFiOZwuDBoPC679vEyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6c9wyt9rZNJ8ExZUuJg5eEhuZyB2fdhpFtbuyeIJhipHxPgw12ImMNMzF0tEAvko
	 6vbg688vK8fCDAVTMU1eR61nBWyq9gdYEqKn/38sv6PgDanOxJPtyPxI0HEx7jp7sc
	 eaLuGO+l24BZaeNmQ+8TNx+TIaLpPv/nzeuZPuXWgq9x1MsQUSLxjq0hq1DGRmFvWO
	 80xVXMynQ+2WNJ8pKsEKvz2M7n064kMzYuUu2jqeYZl9FqEcFrB7Lw6Zz53xu8qj0T
	 YD4l4OmxsyubWnbugfRceKXFpXKbcjc+YjANMArjZN0SL0Ps3AoL9e3cKehXs8ZxpQ
	 B5dhbk3bz8lTQ==
Received: from jupiter.universe (dyndsl-091-248-215-089.ewe-ip-backbone.de [91.248.215.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B01217E3781;
	Wed, 11 Dec 2024 15:30:46 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 83DA548CC91; Wed, 11 Dec 2024 15:30:45 +0100 (CET)
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
Subject: [PATCH v5 7/7] arm64: dts: rockchip: Add GPU power domain regulator dependency for RK3588
Date: Wed, 11 Dec 2024 15:26:52 +0100
Message-ID: <20241211143044.9550-8-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211143044.9550-1-sebastian.reichel@collabora.com>
References: <20241211143044.9550-1-sebastian.reichel@collabora.com>
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
Tested-by: Heiko Stuebner <heiko@sntech.de>
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
 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts             | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts        | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts      | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts         | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts            | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts              | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts              | 4 ++++
 25 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
index 08f09053a066..676f3e71dbe2 100644
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
index 8cfa30837ce7..ef16e1fab4f3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -864,7 +864,7 @@ power-domain@RK3588_PD_NPU2 {
 				};
 			};
 			/* These power domains are grouped by VD_GPU */
-			power-domain@RK3588_PD_GPU {
+			pd_gpu: power-domain@RK3588_PD_GPU {
 				reg = <RK3588_PD_GPU>;
 				clocks = <&cru CLK_GPU>,
 					 <&cru CLK_GPU_COREGROUP>,
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index 71ed680621b8..cc37f082adea 100644
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
index 5e72d0eff0e0..8a783dc64c0e 100644
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
index d6e464cdc536..12c72c0592d0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -459,6 +459,10 @@ &pcie3x4 {
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
index 390051317389..4331cdc70f97 100644
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
index 90f823b2c219..f9fdb5fc6e4a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -451,6 +451,10 @@ &pcie3x4 {
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
index cb350727d116..a0f57cc1e7fc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -565,6 +565,10 @@ &pcie3x4 {
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
index 1c0851b45eb8..fbe1d5c06d90 100644
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
index 9f5a38b290bf..b83ea0db4fba 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -455,6 +455,10 @@ &pcie3x4 {
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
index 088cfade6f6f..b46abdc27c71 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -347,6 +347,10 @@ rgmii_phy: ethernet-phy@1 {
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
index 6d68f70284e4..eaa2e527a918 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -564,6 +564,10 @@ &pcie3x4 {
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
index d597112f1d5b..12474098acf6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -376,6 +376,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 81a6a05ce13b..92682f269eef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -336,6 +336,10 @@ &pcie3x4 {
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
index 3cbee5b97470..5a428e00ab93 100644
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
index 6bc46734cc14..711ac4f2c7cb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -287,6 +287,10 @@ &pcie3x4 {
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
index 9c394f733bbf..e2ba35299f83 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -361,6 +361,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
index bc4077575beb..5b3de53630c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
@@ -340,6 +340,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	audio {
 		hp_detect: headphone-detect {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
index 812bba0aef1a..8f70c00a46d3 100644
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
index 4a3aa80f2226..887ea6ace971 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -455,6 +455,10 @@ &pcie2x1l2 {
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
index ac48e7fd3923..88a5e822ed17 100644
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
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts
index 8f034c6d494c..729f187c9f10 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts
@@ -433,6 +433,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	lcd {
 		lcd_pwren: lcd-pwren {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 70a43432bdc5..19141b576e5f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -359,6 +359,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	leds {
 		io_led: io-led {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
index 9b14d5383cdc..b336b0ee4e57 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
@@ -425,6 +425,10 @@ &pcie2x1l2 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	leds {
 		led_pins: led-pins {
-- 
2.45.2


