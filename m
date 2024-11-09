Return-Path: <linux-pm+bounces-17253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F37DF9C2C72
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4331282E07
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B15192D60;
	Sat,  9 Nov 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JsMqa4p5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEC1891B8;
	Sat,  9 Nov 2024 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731154096; cv=none; b=j0lL7zzc5Q7kVuvy1vDASVT38BQlHTqjz2wpY4DcJYL523iLeHs4DczL2GGj7Nw+G1MPjezZU+1pC6NZ4+1EpqZqDvSgPOa3PlVqywXRVX+vnqrsYWrLUuWQVhIz+aKXBrfrf4QCeX5/WEk0BFo3YIOTnlieYCvl0YTUxDeltiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731154096; c=relaxed/simple;
	bh=UjL9JXQQ119tJGWqiITE11zteO0vgLUycgawyHA9VGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5pbN8mhsFR1ESCtTrV1UEwYbWjRsGyzJeAClxDh/JruxjjDCpFwpoGK5xc+dWScE0K0D2zMe2VWeuOE4BlHZeZJtaj2bRWK3tai8D5/IsHOyZupuxEprubumlEyrfO0wnvnQ6TgiXWuy6gIoShQvbor3OAo08Yo1e+eYfmQqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JsMqa4p5; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C229A.nat.pool.telekom.hu [37.76.34.154])
	by mail.mainlining.org (Postfix) with ESMTPSA id 9C1A0E45C8;
	Sat,  9 Nov 2024 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731154093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4O09ZiSIv+mEo/bJ7pidfgYhpVOBMlebhOJxZ0ds7BQ=;
	b=JsMqa4p5LAorPPv++EBpsXOVN30eOiAOPfR1Sk38uryrmO3KIpIp6zkd7ozROgLs67BHut
	x67RLg2D3utixy3QxaQSjthvjuJETOOQxgg36eCfbdh9J3FkQTjA0/MDFVHjRopeNhStWK
	daVfppMx/3ppBuB0Sk1EX338PgrOhl5HZ2z048OPquiQejHazeKk6RErp24FrvkltYPB1J
	pEOXqs9l53o9DbF5FESHn3gAFNY08nNPPMzygF6a7TIqXIF2bDKSmdv6nMyi/j499q7wrT
	9dt0llgXKsznWzsdyYQL1UgzLjS4PZtde6kgwSz6C+lqVuPiYNlm7dm3i7iJ6Q==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 09 Nov 2024 13:08:03 +0100
Subject: [PATCH v4 01/10] arm64: dts: qcom: Add PM8937 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241109-msm8917-v4-1-8be9904792ab@mainlining.org>
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
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Dang Huynh <danct12@riseup.net>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731154089; l=4120;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=7USdc5qvUHeHbgBI+sq8tO9MUWKj31JWpFnlIkEMcdA=;
 b=ctXAnSb+vBgGMg3k6R0iokTUDr6HF4xNVEaCgBcqi0tZ5Tsp5auoadMzu1pEZW5W4uO927sGX
 oodX4Yvp9ikARHzloYZWLVKh61Ic8n11z8G718rq7aAlTQB70LLtESS
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
 arch/arm64/boot/dts/qcom/pm8937.dtsi | 152 +++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8937.dtsi b/arch/arm64/boot/dts/qcom/pm8937.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..38421e89e556eaaf318118175e8e2036029311a9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8937.dtsi
@@ -0,0 +1,152 @@
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
+			channel@8 {
+				reg = <VADC_DIE_TEMP>;
+			};
+
+			channel@9 {
+				reg = <VADC_REF_625MV>;
+			};
+
+			channel@a {
+				reg = <VADC_REF_1250MV>;
+			};
+
+			channel@c {
+				reg = <VADC_SPARE1>;
+			};
+
+			channel@e {
+				reg = <VADC_GND_REF>;
+			};
+
+			channel@f {
+				reg = <VADC_VDD_VADC>;
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


