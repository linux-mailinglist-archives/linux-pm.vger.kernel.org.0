Return-Path: <linux-pm+bounces-31914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05FAB1A4DF
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8936A3AA8DB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A298272E6F;
	Mon,  4 Aug 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDLoSEjz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64E271A9A;
	Mon,  4 Aug 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317522; cv=none; b=AkiUPgmVeKC2qjXRGxUzqx/NPR/IzxmpN8D4w/YWA/JKttZMQwtHNI8WbZBqjCClf6rWa84D4nVc/Q/eFvR9Eh+/JHI+1Bzeyi7WPS+FZkraxvaSHtNF6XlnMw+c05EhNUAGMQJmUjSrvW5b6UIlzDJ29tkhUs/dLeiD6FwXIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317522; c=relaxed/simple;
	bh=SUEmfllbxCfuPwlmfLNSQ5Zq6XjkIAA05us9mJD3pTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUUZa4V8NGpokc1MAWVJ+ggdQ/OfsIYDmn0nYH4CqStCM2pWjBuJ+6cny/48jihGAIEou6Yzx+kUWA8SYk9oICin78NekjiOJt7mBwSP1j4GAStx0OVF0ImIt68Aqpga395B1i2Xs/q6Ip1TNv/qcH+0iW/R1d74KfTZpIFZTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDLoSEjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57C23C4CEFA;
	Mon,  4 Aug 2025 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754317522;
	bh=SUEmfllbxCfuPwlmfLNSQ5Zq6XjkIAA05us9mJD3pTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uDLoSEjzgY7QQQV+umULTFZuwx+xylsxVX1YDLNRl4T1Q3WovI9DeTCl7qi+6lVsf
	 MblQfE/YyybwAGYTB6jGC+cJ2PNfeA03I+5Z9VHFKIIlWYJVnc0XL+wNMhb4eAizck
	 4J0GOUmZu1pKC+l+yP3chWK9We0LgfrhgM0/GA6Esp7lmOfYHJ2pqZ/E7xZC18Pxon
	 P7SV4YviMDVrP+FXbVHxmKgFlrr7O/wIJPGd85+c72A/UeictqJeWuVT7rpkhdnAwR
	 VSy1ORKB84K46Zb/iR9kBH25x/C8aCpOjfpSs7E9NrlbOprxhAvh+wpmFpAVWDQnyX
	 FxpBjkjaE4Bmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB71C87FCF;
	Mon,  4 Aug 2025 14:25:22 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 04 Aug 2025 16:26:41 +0200
Subject: [PATCH v5 4/4] arm64: dts: exynos: google: add Maxim MAX77759
 Fuel-gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-gs101_max77759_fg-v5-4-03a40e6c0e3d@uclouvain.be>
References: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be>
In-Reply-To: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754317658; l=4842;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=WF3EeuQVRCI8z8XyGntN8UgYyyixrVyY5uSQUCZ94dw=;
 b=v68T20khFe1UGQ2JyoNgy4ms6kbeJYjj9SRA+1t4Mx+n0o6kAgF3AMdV/EemaH96ywtN6rd6t
 EPtpPJzp0m8A2BonUtQTkzYgodWp+grRpoUrNC1z/wYrp6tl5qw45Kw
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

Add the node for the Maxim MAX77759 fuel gauge as a slave of the i2c.

The TODO is still applicable given there are other slaves on the
bus (e.g. PCA9468, other MAX77759 functions and the MAX20339 OVP).

For the device specific values (full design capacity and terminal
current), the device should check an EEPROM at address 0x50 of the
hsi2c_8 for a battery id stored in register 0x17. A set of parameters
for the initialization of the fuel gauge should be chosen based on
this id. Those sets are defined here:

Link: https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android15/arch/arm64/boot/dts/google/gs101-oriole-battery-data.dtsi
Link: https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android15/arch/arm64/boot/dts/google/gs101-raven-battery-data.dtsi

This does not seem to be a standard pattern in the kernel currently
so it is not implemented. Values observed on tested devices are
instead used. The driver or the devicetree should be should be
extended in the future to take versions into account.

The pinctrl name follows the convention proposed in
Link: https://lore.kernel.org/all/20250524-b4-max77759-mfd-dts-v2-2-b479542eb97d@linaro.org/

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 10 ++++++++
 .../boot/dts/exynos/google/gs101-pixel-common.dtsi | 30 ++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/google/gs101-raven.dts  | 11 ++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 8df42bedbc036b5e97f6238d64820370043ffef2..18d147f6ea4a1a76c375996557349c866b9dad72 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -13,6 +13,12 @@
 / {
 	model = "Oriole";
 	compatible = "google,gs101-oriole", "google,gs101";
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <4524000>;
+		charge-term-current-microamp = <45000>;
+	};
 };
 
 &cont_splash_mem {
@@ -27,3 +33,7 @@ &framebuffer0 {
 	format = "a8r8g8b8";
 	status = "okay";
 };
+
+&fuel_gauge {
+	monitored-battery = <&battery>;
+};
diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
index d6ddcc13f7b20c6dfbe92e86abafe965870d0c78..3362ad89ef6bacb7349259cf9e14452193ff7361 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/usb/pd.h>
 #include "gs101-pinctrl.h"
 #include "gs101.dtsi"
@@ -99,6 +100,16 @@ &hsi2c_8 {
 	eeprom: eeprom@50 {
 		compatible = "atmel,24c08";
 		reg = <0x50>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			fg_state: fgstate@42 {
+				reg = <0x42 0x17>;
+			};
+		};
 	};
 };
 
@@ -188,6 +199,18 @@ usbc0_role_sw: endpoint {
 			};
 		};
 	};
+
+	fuel_gauge: fuel-gauge@36 {
+		compatible = "maxim,max77759-fg";
+		reg = <0x36>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&if_pmic_fg_int>;
+		interrupt-parent = <&gpa9>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		shunt-resistor-micro-ohms = <5000>;
+		nvmem-cell-names = "fg_state";
+		nvmem-cells = <&fg_state>;
+	};
 };
 
 &pinctrl_far_alive {
@@ -214,6 +237,13 @@ typec_int: typec-int-pins {
 };
 
 &pinctrl_gpio_alive {
+	if_pmic_fg_int: if-pmic-fg-int-pins {
+		samsung,pins = "gpa9-3";
+		samsung,pin-function = <GS101_PIN_FUNC_EINT>;
+		samsung,pin-pud = <GS101_PIN_PULL_UP>;
+		samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
+	};
+
 	key_power: key-power-pins {
 		samsung,pins = "gpa10-1";
 		samsung,pin-function = <GS101_PIN_FUNC_EINT>;
diff --git a/arch/arm64/boot/dts/exynos/google/gs101-raven.dts b/arch/arm64/boot/dts/exynos/google/gs101-raven.dts
index 1e7e6b34b8649bc700a745c579a0268f0f6a9524..f91800879ea94b8fb0008c5e1f828072cabc1ac7 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-raven.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-raven.dts
@@ -13,6 +13,13 @@
 / {
 	model = "Raven";
 	compatible = "google,gs101-raven", "google,gs101";
+
+	battery: battery {
+		compatible = "simple-battery";
+
+		charge-full-design-microamp-hours = <4904000>;
+		charge-term-current-microamp = <49000>;
+	};
 };
 
 &cont_splash_mem {
@@ -27,3 +34,7 @@ &framebuffer0 {
 	format = "a8r8g8b8";
 	status = "okay";
 };
+
+&fuel_gauge {
+	monitored-battery = <&battery>;
+};

-- 
2.50.1



