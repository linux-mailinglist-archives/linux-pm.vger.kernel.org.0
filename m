Return-Path: <linux-pm+bounces-16010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB609A4D54
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA2FB233AF
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F241E104F;
	Sat, 19 Oct 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Q2hAG+P4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B9B1E0B86;
	Sat, 19 Oct 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338654; cv=none; b=qo/YlXxsrStfsFguvBiLvHHuLdeC/Gh9Px0ClpSAekIKvM1Sz7ImP+hyDAUAyI4cyDKKAD94qjGIJjH2mmSLlDWRQC3bpDiAAH1j1lD9JedE96ekDCHjSumagmyPHRZKtXhYFR6CWcNIorEG/iKpJ2c5yVsvitC60sbOyt35SOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338654; c=relaxed/simple;
	bh=pGdE3JbMnx8RRxsOjP5sqLKvgYxJu9uHccWmmEz1BBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUOLzVBMCWdxfZ+31NaVG7z9FcKB0E1UWU4jsPIaAJhY7/4h6uYf4QIabnxK44u9TGjafujK375ZANR332cDINKo+EBUL+ouwv3KzfQkTVUrhCfo55FLJw77Y2890S73ngoYTtNp7J50NTrk3B6Tj6xf9u2NJYKCQb46MK3n2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Q2hAG+P4; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id 828B3E45A1;
	Sat, 19 Oct 2024 11:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQ9PPHmGUCj1OfdVnwY9QeNORTy83vI8ai4ibJSzc/c=;
	b=Q2hAG+P4c8TrGbiSjBC1zGAbkAkJ3yNjfwStF1K0OGwtR+Ofw5hydon04iBcqFnG4DI+JV
	r490OspTQWNiA5aAOrmXjQTRSgc/KVB7qJBHReU0xNYKDrVDdLjCZef3mu+HbNRKpJ/iqW
	BLDmiYstEtZnsHcYf3SCAwEHq2uNxfbMZfWL25BinwQ7QN8ANYvvHnIhLswnhSAattReI0
	OsCRjzpj6hyMxq/JHG2FUGnFikoeV3NNEwNvThy5w0RLaCa/aOvFy72ks2lbseXaiNHrqq
	jejsk1uadvIhEN5093WeFPy3DRdzHeHp/hJn9Um+JD6kK3Zz76WH57yhFq/QTQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:42 +0200
Subject: [PATCH RFC 05/14] arm64: dts: qcom: Add PM8937 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-5-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
In-Reply-To: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Dang Huynh <danct12@riseup.net>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=5605;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=lHNnzvmjpc3j5FxTFCw87+ln8lcsQMaGeUUUPNMlpb0=;
 b=O0m30iyb8Hz6BbiCNwy6EFGh5ivkIuduYzKXzebEytblgLjuwVv44KEwNqTpwjFfDAo181g9d
 kwKYqLpPPxaAlU9UGBZGSbsDLmWkqzx6Ehr9aXSKA5tJZIEsyK62vuH
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

From: Dang Huynh <danct12@riseup.net>

The PM8937 features integrated peripherals like ADC, GPIO controller,
MPPs, PON keys and others.

Add the device tree so that any boards with this PMIC can use it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Dang Huynh <danct12@riseup.net>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 arch/arm64/boot/dts/qcom/pm8937.dtsi | 216 +++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8937.dtsi b/arch/arm64/boot/dts/qcom/pm8937.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..34e2b4cd0d5f4f92c16bb20f53e4520544a644bc
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8937.dtsi
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
+ */
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm8937-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8937_temp>;
+
+			trips {
+				trip0 {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pmic@0 {
+		compatible = "qcom,pm8937", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pon@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pm8937_pwrkey: pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+
+			pm8937_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
+		};
+
+		pm8937_gpios: gpio@c000 {
+			compatible = "qcom,pm8937-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8937_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pm8937_mpps: mpps@a000 {
+			compatible = "qcom,pm8937-mpp", "qcom,spmi-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			gpio-ranges = <&pm8937_mpps 0 0 4>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pm8937_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8937_vadc VADC_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8937_vadc: adc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0 0x31 0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			channel@5 {
+				reg = <VADC_VCOIN>;
+				qcom,pre-scaling = <1 1>;
+				label = "vcoin";
+			};
+
+			channel@7 {
+				reg = <VADC_VSYS>;
+				qcom,pre-scaling = <1 1>;
+				label = "vph_pwr";
+			};
+
+			channel@8 {
+				reg = <VADC_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+
+			channel@9 {
+				reg = <VADC_REF_625MV>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_625mv";
+			};
+
+			channel@a {
+				reg = <VADC_REF_1250MV>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_1250mv";
+			};
+
+			channel@c {
+				reg = <VADC_SPARE1>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_buf_625mv";
+			};
+
+			channel@e {
+				reg = <VADC_GND_REF>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			channel@f {
+				reg = <VADC_VDD_VADC>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_vdd";
+			};
+
+			channel@11 {
+				reg = <VADC_P_MUX2_1_1>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				label = "pa_therm1";
+			};
+
+			channel@13 {
+				reg = <VADC_P_MUX4_1_1>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				label = "case_therm";
+			};
+
+			channel@32 {
+				reg = <VADC_LR_MUX3_XO_THERM>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				label = "xo_therm";
+			};
+
+			channel@36 {
+				reg = <VADC_LR_MUX7_HW_ID>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				label = "pa_therm0";
+			};
+
+			channel@3c {
+				reg = <VADC_LR_MUX3_BUF_XO_THERM>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				label = "xo_therm_buf";
+			};
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pm8937", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8937_spmi_regulators: regulators {
+			compatible = "qcom,pm8937-regulators";
+		};
+	};
+};

-- 
2.47.0


