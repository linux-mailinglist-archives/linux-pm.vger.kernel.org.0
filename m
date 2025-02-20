Return-Path: <linux-pm+bounces-22570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECDBA3E496
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB99E4230FE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C589268FD6;
	Thu, 20 Feb 2025 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qz2I8oPm"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58F9267705;
	Thu, 20 Feb 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077922; cv=none; b=i1rXPtR8EdJiRjZHd+SC7QJk1c+A2vbJJYB0HqvpJdkRu2acOu7zB0XqemykUiwuFwhw/Xv8U6flwYxDx3EscmbYMg/tfcsdmeAeinn9kQRLZa4UdjjI/AA3jTK1P7log0vWs91VgLTbgZsDcNpLAa6dtFNVeGRG9+jpDx/pmPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077922; c=relaxed/simple;
	bh=0XXZ6OTodD2Jjb+29sa8Gg36H4Ft62btM1qoSWuiUUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgOAYM/D4Yj9SKtb+xC8uxMOUHGknOiBSoSXe0wG8zLE/ZOcTCSiSozKfXJhWLRWxnvPvfwxiMawYf8FNLfcCVUVNZDeDl/yTW1oKyI55H2dcbCvpcHt6ni8swDsqk1ZqW/zHJIGsFYjmuCROzoB8wzvmxk8/6ZL5U7TgF5d91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qz2I8oPm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740077913;
	bh=0XXZ6OTodD2Jjb+29sa8Gg36H4Ft62btM1qoSWuiUUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qz2I8oPmv75lwLjm3EYOLYH9rgmXMoryPpJgPiDTjWXNZOz22wBNk0lZB2MFp3L+T
	 yUYko1i8xoMc9W11759f8f71615ndGvXPW3iizSHUIgmRzoAX/fvN7d65sfixBxNJe
	 mdmRxDF7vNT5VXsDWCt0MtPYgumeeHdPf9vE2AbOxhHug2FWuUMkXtbwshVPQkOQyF
	 Nu/M0rX0eLBf3TdZRrV1QdTo1yEwFYMfb9UbXsliuI+VghAFCfauq8951z0mDpZhkX
	 P+CCqyAtH9YF3XEp9vxg35apjkPiIJpTsxmU5vxS0jHcGO5v8mZpyOa6/mT+A7pz0e
	 ylALWMlRrVj4g==
Received: from jupiter.universe (dyndsl-091-248-085-196.ewe-ip-backbone.de [91.248.85.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C498617E1576;
	Thu, 20 Feb 2025 19:58:33 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 1458648003F; Thu, 20 Feb 2025 19:58:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 20 Feb 2025 19:58:11 +0100
Subject: [PATCH v6 8/8] arm64: dts: rockchip: Add GPU power domain
 regulator dependency for RK3588
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250220-rk3588-gpu-pwr-domain-regulator-v6-8-a4f9c24e5b81@kernel.org>
References: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
In-Reply-To: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
To: Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 =?utf-8?q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Peter Geis <pgwipeout@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Vignesh Raman <vignesh.raman@collabora.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18621; i=sre@kernel.org;
 h=from:subject:message-id; bh=0XXZ6OTodD2Jjb+29sa8Gg36H4Ft62btM1qoSWuiUUk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe3e1h94nh3wLbXrLsbxc/wXHiJB2kcOrdCt
 p76tKEh/HHA5okCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnt3tYAAoJENju1/PI
 O/qa+/EQAIqvXCigjgbgMieR1LCJ1Kw0rX1V1uKsUMhlue8MnnzTrq/vgpJKoaON3k2ENoZRiO3
 pjezBGNZSN/TzgZ6tXgtvP1vEQpzc9eQUr7aCoQzFO4aJYm2+fmHbUWJ/KUEcRJtaipPRJ+NKzG
 lNwjUc60pT/fgpe1CSRmhdjVheRoLVA+zw+mWHOKSCrQEDRt5dZiMo4QY2yAndMe7fURzrshfoj
 qf7AOy22GddWvP5J7xcWf3UL7mu8e+hsOzgxrrm/yGEe+Hu93LxJkFqqfWRHIpDF18EFmS73kgG
 SRRkDqMOHss88O75r+pTCLbTcF0qqIgcEHYhRZaCK56S/8E+7AcyTxRbOAdTwWJoAvn62QMo6Sy
 /ubJH4NMBNmJKZYqRsiTw3j3Cj26xVwwAiWBlI3OQ/C6+A6AuSTSYOg5fswz8F/xXTa7CR9UBkp
 X4nGjumgEW3IzlkaREsKoH4F7TnJZhGPN0ODtDpVlJcGyDiI0GC6yxCVfW9OKNF/gThqZqJItSx
 vNR/rUt7FvmmT2IVxNZVcrZ3MDu308b+os7FVPoeKJkVKUzaQKxWZ8d0Tgb/nsTv0E6NAEzCT+Q
 qYD/TXaL4lht2nFcQ67jh212nUXKQlvh6QkcNSMyM8N1ZoDY8FrwVaJqJGYu3rkRcwDz2wvzl1X
 NvicM2y5AGAji7W9W5FUxVA==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Enabling the GPU power domain requires that the GPU regulator is
enabled. The regulator is enabled at boot time, but gets disabled
automatically when there are no users.

This means the system might run into a failure state hanging the
whole system for the following use cases:

 * if the GPU driver is being probed late (e.g. build as a
   module and firmware is not in initramfs), the regulator
   might already have been disabled. In that case the power
   domain is enabled before the regulator.
 * unbinding the GPU driver will disable the PM domain and
   the regulator. When the driver is bound again, the PM
   domain will be enabled before the regulator and error
   appears.

Avoid this by adding an explicit regulator dependency to the
power domain.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Reported-by: Adrián Martínez Larumbe <adrian.larumbe@collabora.com>
Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts          | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                 | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts              | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi            | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi   | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi  | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts                | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi            | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts              | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi           | 4 ++++
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
 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts            | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi          | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts              | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts              | 4 ++++
 30 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi
index a3138d2d384c628ae2b518441145d12e73d19ee1..e44125e9a8fb6def6a87472884bdf990d49b1d5f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi
@@ -114,6 +114,10 @@ regulator-state-mem {
 	};
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &saradc {
 	vref-supply = <&avcc_1v8_s0>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
index b89888fe5d464cae642f34f97da70e9ae111188a..6a0fffaa26ee8d422d87ba528e707236bf99a042 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
@@ -318,6 +318,10 @@ &pcie3x4 {
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
index f937922cb8ef0d0761992f87e31561c948f54556..64b2e219d2e00ef67c1228d488158e9afb2e1263 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -859,7 +859,7 @@ power-domain@RK3588_PD_NPU2 {
 				};
 			};
 			/* These power domains are grouped by VD_GPU */
-			power-domain@RK3588_PD_GPU {
+			pd_gpu: power-domain@RK3588_PD_GPU {
 				reg = <RK3588_PD_GPU>;
 				clocks = <&cru CLK_GPU>,
 					 <&cru CLK_GPU_COREGROUP>,
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index 71ed680621b880dd2a001d5fa4f46d389f7ac5cd..cc37f082adea0f848e8e84b0bb780b1cf673355d 100644
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
index 5e72d0eff0e0f0a2bba718bc67dc2dc8f9ac183f..8a783dc64c0ef3d7c19358ae0d6e020eedfd2130 100644
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
index 3fd0665cde2ca15cd309919ff751b00e0f53a400..8c9ad21b0b3c280d22da23d0d462d311eb554804 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -519,6 +519,10 @@ &pcie3x4 {
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
index 3900513173892330d5bedf23dd20165f88ae6fcb..4331cdc70f973dc23fb494ac4dba2a569745e4a8 100644
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
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi
index 42c523b553c98b1a1952240e424db2fdc2976469..80e16ea4154c0ef06f2785005ca129f12fcbdfc9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-firefly-core-3588j.dtsi
@@ -108,6 +108,10 @@ regulator-state-mem {
 	};
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &sdhci {
 	bus-width = <8>;
 	no-sdio;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi
index e3a9598b99fca8873fb4d511f82b9e2af612b8f3..1af0a30866f619ae6f1db549f9158679135689ac 100644
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
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts b/arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts
index a0e685b55d21ac6bea9060a0593cfba3a11d38cf..73d8ce4fde2b8144b2e9cf4854e759141c20f119 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts
@@ -334,6 +334,10 @@ wifi: wifi@0,0 {
 	};
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 20b566d4168f038052a05e66e42db9a030792421..9a43e4fdc4f549a65d2767523beb9c880db6bf36 100644
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
index 0d9b5020acc099f84f89ef47a43d7a6cbb867719..bbe500cc924b4c4c1ddd833c32c39cf6c20b60e3 100644
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
index 1c0851b45eb8eef5e2626dfde8e6c145392754a9..fbe1d5c06d903340ee9faa6a34cc6f7289957a09 100644
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
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
index a98e804a09495c65454c5262c8c8ceebf06d0569..261655c7ccbfe7a89aa07d4df2d4483352687265 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
@@ -348,6 +348,10 @@ &pcie3x4 {
 	status = "okay";
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &saradc {
 	vref-supply = <&vcc_1v8_s0>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index 088cfade6f6f14b6383ab844fa174c69fa711fc0..b46abdc27c71deb58a3409a9e45b3b0e36315da3 100644
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
index 6d68f70284e450bb9f58e201ab53f46227345213..eaa2e527a918d46f638a061837f5808b859741f9 100644
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
index 5acec6b97a46a870e5437f15b1078b2bdf0143b8..b4f31b7d1c77f1459409a7ff6f0a929434a5f518 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -409,6 +409,10 @@ &pcie3x4 {
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
index e8fa449517c27c3be48324e91c033865416b2b2a..e079bf652071649fe3911f3d79e77b9de23bd9d2 100644
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
index 3cbee5b974700d1e687973566aea229ddc92174a..5a428e00ab938ee500561472d55d743f531d3039 100644
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
index 6bc46734cc1407833f1133dc640ef57f214d94db..711ac4f2c7cb66d97dc76320f9c87deefcc85dd2 100644
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
index f471baca6d3101ce7e850b666589587dc70d8a17..af4a4e52b5031832edbd72ce5c6216e1f94e604f 100644
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
index bc4077575beb6298917ff545ae5eb721bf1c4651..5b3de53630c6302fe678be5e2b85dd6979bbd2a7 100644
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
index 812bba0aef1a8b48488339162f232bde30077592..8f70c00a46d30170307f0eeb57cb1533d1d17834 100644
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
index 74a4f03e05e35138232f5393b75c6853fa05d7af..80a8dca4d6a3c83cd5c4c495752a1a634f387403 100644
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
index ac48e7fd3923f4222929afb03b608a647d2c2ed8..88a5e822ed17d4eae555b420f9eb3b75fa5b017e 100644
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
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
index cd47969fadba051a22fdb8118a232c1c124c00b2..fbf062ec3bf17ac6966318be55243e6f2b87a9aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
@@ -359,6 +359,10 @@ &pcie2x1l2 {
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
index 1463bd36b1b2e37dfa0da953b3837b33e4e9bf7e..a72063c55140105d5098f1cd7ebf79ad4e90e47c 100644
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
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
index 9e16960b87055a120b6208e75c7ec4189c0e0b4a..be0234d2257d469002e67f51d72c7ac075da4a7d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
@@ -365,6 +365,10 @@ rgmii_phy1: ethernet-phy@1 {
 	};
 };
 
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 676cc4fec269ef8955630680791231deb8a775cb..f894742b1ebef15e943e7f0894f7ae95ac03e40b 100644
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
index ef8ce10d8f50ba73f1c9b856355e559c6b76b75d..dd7317bab6135c266f5e767f5efc0fa7ae936183 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
@@ -455,6 +455,10 @@ &pcie2x1l2 {
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
2.47.2


