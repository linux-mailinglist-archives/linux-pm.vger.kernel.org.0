Return-Path: <linux-pm+bounces-19617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8BE9F9D34
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 00:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BD416BC9B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 23:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4EF229B23;
	Fri, 20 Dec 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="XDcfCn/z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C748229156;
	Fri, 20 Dec 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738079; cv=none; b=HeZsfijMkm7cMJ2f6Ih6FxC9E/rg3TiSR1yAN6PWUvOje7TNfmKD7ngPobHtvdef9eKQAwiAHCq7ziedTeWVa4uABZ4CYlVNWV9ODH84J/fMjRZk23uOb9GuR8TMRBirV0ltrfqbaoa6V/tRNnSrzMMWwdLm4bJHyaaOHMPaPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738079; c=relaxed/simple;
	bh=yRrTth08180QfeHsiXKzN5bNhMrXGVQ/EVyPD3V4GyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkW/ygQq2ue3fHa3K10QWcEC43Z55acxirQA/ORpZ9+pyIt7BYnzqxzFIlgfpAFRztxqBki8P3uyrcHaqxm4Era8lnsXLnayrQubt/vmrpr8BkuF7i0wHQNTX1oj07x57sBLdVX8jGlfXTHfFkzI0iz5Mx43M/WEl8pt5Y7sJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=XDcfCn/z; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.30.162] (254C14D2.nat.pool.telekom.hu [37.76.20.210])
	by mail.mainlining.org (Postfix) with ESMTPSA id 10B38E483B;
	Fri, 20 Dec 2024 23:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1734738074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQcWQj/wwnb5q+l0OdYD5VX4MPg+1aI9rfTFTUBDwbY=;
	b=XDcfCn/zhRf9cww5tgo6wOD8MoZu594eUeFUEiOrf5t6D7nGm3cRULMHScXt3ip30kOiKh
	CkipudUxj0uvL0xz/zw1UAF0mkRVkkbY7/XfM2q03aRJR6WOaeES5dqKPNdzN0fFeCbZiw
	a9u0jVPwp6s640DQEAMa/FX4VVTnKdrPYD+chaG/Ini4241swWADkhKSeSLpHo6+co+1Hi
	vUvqzLecD6R3WTU4hJ02lYnm8jkPOTSQbdlo3mtIIzNZkJeYATRHMdLDzw+FikHsKHfGEr
	ds+vOSczDOadhFZ/mpFI69g54ImEdutgGTVWmg5Kpxl4Xzn9b2Ax3gzlXQEv0Q==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 21 Dec 2024 00:40:51 +0100
Subject: [PATCH v11 4/4] arm64: dts: qcom: Add Xiaomi Redmi 5A
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241221-msm8917-v11-4-901a74db4805@mainlining.org>
References: <20241221-msm8917-v11-0-901a74db4805@mainlining.org>
In-Reply-To: <20241221-msm8917-v11-0-901a74db4805@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734738064; l=8999;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=yRrTth08180QfeHsiXKzN5bNhMrXGVQ/EVyPD3V4GyQ=;
 b=EjGVw7i57I2qFGqVemyh80alnIt+SNxyism+iCPXYvjWLAOZurJpkyyOVkMmoT6boYAtMhmBI
 FggN3ddemfrCawfoGWe5cEvhO7nwl0q1LNi0ZDqZ4wFq8pyloT8CfFl
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add initial support for Xiaomi Redmi 5A (riva).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 arch/arm64/boot/dts/qcom/Makefile                |   1 +
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 333 +++++++++++++++++++++++
 2 files changed, 334 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 4686f2a8ddd897227360b4de48a0618499ad463e..ee9b262b0e0fc3ec9d6515174c33f8b69b524842 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt86518.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt86528.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8917-xiaomi-riva.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8929-wingtech-wt82918hd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
new file mode 100644
index 0000000000000000000000000000000000000000..f1d22535fedd94467ba3f0a88b2110ce5360e7e1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Barnabas Czeman
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "msm8917.dtsi"
+#include "pm8937.dtsi"
+
+/delete-node/ &qseecom_mem;
+
+/ {
+	model = "Xiaomi Redmi 5A (riva)";
+	compatible = "xiaomi,riva", "qcom,msm8917";
+	chassis-type = "handset";
+
+	qcom,msm-id = <QCOM_ID_MSM8917 0>;
+	qcom,board-id = <0x1000b 2>, <0x2000b 2>;
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3000000>;
+		energy-full-design-microwatt-hours = <11500000>;
+		constant-charge-current-max-microamp = <1000000>;
+		constant-charge-voltage-max-microvolt = <4400000>;
+		precharge-current-microamp = <256000>;
+		charge-term-current-microamp = <60000>;
+		voltage-min-design-microvolt = <3400000>;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "framebuffer0";
+
+		framebuffer0: framebuffer@90001000 {
+			compatible = "simple-framebuffer";
+			reg = <0x0 0x90001000 0x0 (720 * 1280 * 3)>;
+			width = <720>;
+			height = <1280>;
+			stride = <(720 * 3)>;
+			format = "r8g8b8";
+
+			clocks = <&gcc GCC_MDSS_AHB_CLK>,
+				 <&gcc GCC_MDSS_AXI_CLK>,
+				 <&gcc GCC_MDSS_VSYNC_CLK>,
+				 <&gcc GCC_MDSS_MDP_CLK>,
+				 <&gcc GCC_MDSS_BYTE0_CLK>,
+				 <&gcc GCC_MDSS_PCLK0_CLK>,
+				 <&gcc GCC_MDSS_ESC0_CLK>;
+			power-domains = <&gcc MDSS_GDSC>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+
+		key-volup {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+		};
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reserved-memory {
+		qseecom_mem: qseecom@84a00000 {
+			reg = <0x0 0x84a00000 0x0 0x1900000>;
+			no-map;
+		};
+
+		framebuffer_mem: memory@90001000 {
+			reg = <0x0 0x90001000 0x0 (720 * 1280 * 3)>;
+			no-map;
+		};
+	};
+};
+
+&blsp1_i2c3 {
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306";
+		reg = <0x38>;
+		interrupts-extended = <&tlmm 65 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&tsp_int_rst_default>;
+		pinctrl-names = "default";
+		vcc-supply = <&pm8937_l10>;
+		iovcc-supply = <&pm8937_l5>;
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1280>;
+	};
+};
+
+&blsp2_i2c1 {
+	status = "okay";
+
+	bq27426@55 {
+		compatible = "ti,bq27426";
+		reg = <0x55>;
+		monitored-battery = <&battery>;
+	};
+
+	bq25601@6b{
+		compatible = "ti,bq25601";
+		reg = <0x6b>;
+		interrupts-extended = <&tlmm 61 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-0 = <&bq25601_int_default>;
+		pinctrl-names = "default";
+		input-voltage-limit-microvolt = <4400000>;
+		input-current-limit-microamp = <1000000>;
+		monitored-battery = <&battery>;
+	};
+};
+
+&pm8937_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm8937-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+
+		vdd_l1_l19-supply = <&pm8937_s3>;
+		vdd_l2_l23-supply = <&pm8937_s3>;
+		vdd_l3-supply = <&pm8937_s3>;
+		vdd_l4_l5_l6_l7_l16-supply = <&pm8937_s4>;
+		vdd_l8_l11_l12_l17_l22-supply = <&vph_pwr>;
+		vdd_l9_l10_l13_l14_l15_l18-supply = <&vph_pwr>;
+
+		pm8937_s1: s1 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8937_s3: s3 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8937_s4: s4 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8937_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8937_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8937_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8937_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8937_l8: l8 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8937_l9: l9 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8937_l10: l10 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8937_l11: l11 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
+		};
+
+		pm8937_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8937_l13: l13 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8937_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8937_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8937_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8937_l17: l17 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8937_l19: l19 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8937_l22: l22 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		pm8937_l23: l23 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+	};
+
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8937_l8>;
+	vqmmc-supply = <&pm8937_l5>;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 67 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&pm8937_l11>;
+	vqmmc-supply = <&pm8937_l12>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32768>;
+};
+
+&tlmm {
+	bq25601_int_default: bq25601-int-default-state {
+		pins = "gpio61";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio91";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio67";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_rst_default: tsp-int-rst-default-state {
+		pins = "gpio64", "gpio65";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+};
+
+&wcnss {
+	vddpx-supply = <&pm8937_l5>;
+
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+	vddxo-supply = <&pm8937_l7>;
+	vddrfa-supply = <&pm8937_l19>;
+	vddpa-supply = <&pm8937_l9>;
+	vdddig-supply = <&pm8937_l5>;
+};
+
+&wcnss_mem {
+	status = "okay";
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};

-- 
2.47.1


