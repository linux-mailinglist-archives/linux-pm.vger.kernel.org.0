Return-Path: <linux-pm+bounces-17262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB5C9C2CA8
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA27282A4E
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B66F19B3DD;
	Sat,  9 Nov 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JRXclJRb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE719B5A9;
	Sat,  9 Nov 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731154111; cv=none; b=pWBsfkwQeKSJlhjagAaXy4sVwhbpIwZvVAOksGpFDrJynRvj9KyIZt5EH5DrxCBLtH4Yo2227E0jxsB6H8Z5Tysqa/fP65m2UkPrWLCQX33B+pc7Kqk1uN9sjPQ7XLoTpWVnjjL7DcDJbU7keX5BxgPM9is5ZMWE6m+OAT3SxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731154111; c=relaxed/simple;
	bh=VckbUL31Pd2FcReHeF/sNdgZ3yemo1YK4wGHdefvIng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JiY5c7QndwPdmjbMJbXEMDY4ZaBCEWa32jJ3UAfU6JbZmEBD+lb8/k7eWXf3cZ6Q66D2mk93rT4Bnb9BxH5ukTzQqJJPcJ7yRoALuQzmU5N/bPxFnZ2OWAmBfoSmG1oU4R7sZb7ehjajAssPKt9cCAKVikrz+QX0ZSEFqYZEkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JRXclJRb; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C229A.nat.pool.telekom.hu [37.76.34.154])
	by mail.mainlining.org (Postfix) with ESMTPSA id C3356E45BA;
	Sat,  9 Nov 2024 12:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731154108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrWG6kvrw892Zwuq3FzbeCZoxg7K72awOj8OxMICkAU=;
	b=JRXclJRb/8+MBBZ7Bo4XPrV3e2UgL0pOOEFUM2/7EKU9I2ry6QdjFFbGUngOFASpCKnsBK
	tdRaxr6Qm5UWk5P6XyOL+oGymaIoyHTU8k3SU3ltBSqtkldCs3hBMUedyUxmQmcIFAFdtt
	iGDgPX1VOEvrGjBSOO4mVBKNCXL/fzdQAuMhlhynKcGagOKjX8hW63LaJRHcCsLUPTQ4wR
	7DWbdBbbaMTQiZdSLb4Phj3h+tN5TmNsVfAhiWnu9KXlmaN7eg4o06NoEsXzYSqlS93DJZ
	uNt6kd/y8rIV9J2iEdm/Q1hiUYcc1OtxOaemKhJkYL8fuiOMiWl1AtHAM4rF8A==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 09 Nov 2024 13:08:12 +0100
Subject: [PATCH v4 10/10] arm64: dts: qcom: Add Xiaomi Redmi 5A
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241109-msm8917-v4-10-8be9904792ab@mainlining.org>
References: <20241109-msm8917-v4-0-8be9904792ab@mainlining.org>
In-Reply-To: <20241109-msm8917-v4-0-8be9904792ab@mainlining.org>
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
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731154089; l=8024;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=VckbUL31Pd2FcReHeF/sNdgZ3yemo1YK4wGHdefvIng=;
 b=W9CGNHXcweCEJpQzVSZqgQf3dD8VpD5LJ+RLNJPpDk2wbWAYgvTfi901sV+YET+WGFWq9JwvF
 HeaJ+H6aXl6CfzkS/gOS1PM8/2JjcY4U9/jlCl8DzgUeFnjZyMqbhOq
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add initial support for Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 arch/arm64/boot/dts/qcom/Makefile                |   1 +
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 297 +++++++++++++++++++++++
 2 files changed, 298 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 9bb8b191aeb517e8f1e3a11bca98a3d0c39c5398..7562406843cfd82397c4844d14a22e8bcf4bba74 100644
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
index 0000000000000000000000000000000000000000..df5fa0d27cde1dabacac98667fd6d4b8dd7533a6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Barnabas Czeman
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/leds/common.h>
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
+&blsp_i2c3 {
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306";
+		reg = <0x38>;
+		interrupts-extended = <&tlmm 65 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&pm8937_l10>;
+		iovcc-supply = <&pm8937_l5>;
+
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1280>;
+	};
+};
+
+&blsp_i2c5 {
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
+		monitored-battery = <&battery>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <61 IRQ_TYPE_EDGE_FALLING>;
+
+		input-voltage-limit-microvolt = <4400000>;
+		input-current-limit-microamp = <1000000>;
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
+
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32768>;
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
2.47.0


