Return-Path: <linux-pm+bounces-39383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A2CB1A67
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 02:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 734D130E24EC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 01:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749A23B628;
	Wed, 10 Dec 2025 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="tShlD28W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AE239072
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331072; cv=none; b=Ccx7vQjsdmxPOVblF5Odw9KFrxKidYBF3eYfvOFTxvoa7nfSB05cNKoF4BWZsT18QGiC7iCozjnZuBXdQMnhREgx86ZjfOhR0IW0ZEWXsmD0OsqZ94utZip7gXMDegULfTdNsMaJV4oX0SLhM9KGCJr8o0TgUpOKm/E8DcG3iZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331072; c=relaxed/simple;
	bh=dQvpXyrMYNrV6758bacgoGHBnAGoyVS3u4Zw6ofPsuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2M8JFtnqskvPiG9urnUXriX20BY1jvEjdW1Ej12EABXLNrAw8aT3DvJaj9qBpJgAv++TmFfwSunmZF0A8ctUqVihaUlXCVyBFW8Ol7JkNeGRhcOga2XEyNpaKPaNPAdhAnX/iecf0nGzairr2oj4GttK+IbNzHk+TZVxGsCps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=tShlD28W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso64401335e9.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 17:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1765331066; x=1765935866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ok2St7iCWb016O4iwS/tee7WIdAqalHq7Bq+aPg/wgA=;
        b=tShlD28Wa7SAoJx8mPdTtcXB82l46UZZqeSPmpshJre1odYcs+tOb6ACmh+Ur2rhjM
         P6MUfgsgPaK9fHFB9+s22PYNpx9QT72D+flcM9m5G0qV42aZjRBpfovw8XxJ+GXrKU0E
         V8bTOmkx0nx8g7mEtEui0mOjCMninBO2A/BoD0TlDkM9+cFU+4lUKyg9FIHEzvLln5bf
         PsoTeokXntYMk+nZrzeDw7wiuntCZUmcTjnoOr65/4CNJAR0FU5wMwg2z6ijR3CxTYt8
         4G4BecfYOiqawF/H4jbw9uKHLl0xFv+q6xpTSU8FZ4dZ123lmfh/p+rD6V5H7R/qZlOX
         yGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765331066; x=1765935866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ok2St7iCWb016O4iwS/tee7WIdAqalHq7Bq+aPg/wgA=;
        b=dChgX/4Z56oWFUm3otkFLNDANkFHNVRYt1oDshiDrxQPB3TafL9YxCjmWXLFsZaYLx
         LSydX2NeBblH5yBIYotzXIF5FJdIaD4J+bft2HA6Rn6me7caB4ZCKXK++4zWhkndm/qm
         E/ldRIOrl7qma6FWjSVJXe2lWICO9l9gtPZFMwFcNpqOF2nLubwa0Ln79v6yw0FUSDL7
         aD9Er51IOy709lx6CunTTnXOqHrQeqctU5ByzXsIBrPaUnxeu7+LnwqsLe7mtkW+WOH3
         Hf/43TMmkg8d0tCq2Y0C9s8bgulwx2JJo6/Z36u2bBGWmIJnnCHNHdlkpKjjLOFdEQoi
         6gXA==
X-Forwarded-Encrypted: i=1; AJvYcCXI70u8DYT2LEjtlqiid/UWxop+v7am3RqKR5kcA73rfugWJ5O5YtQWxQVh9r37cUb5AkzkzwK5yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwboShjNOn6CggpCfTopFMF3f2N0Wa9R4wPfv0RJBF5iG3tZ+1X
	XOoKmho2hxqNAmuO5jzSQeUYaRx/CUm8fOEYgBOudcqkrT5R8Lv2/cFeFVuILpQPaUE=
X-Gm-Gg: ASbGncvdj+7jg55qHnyEkBSsz0fVTwsBpeZaRwD7q+dxYjpPCOJmyxFLUmbzQs05kmb
	1EZhTCF9Lxn+2wTDAJ5BzALglklEdW5sbXEOrPsMQM0blngTK4FlxLuDyV139dJ7gV+OLbg3w3P
	s54do8qH6rxWhWz+P+/qdDao0cwknOYMniYReAlOSnLL68/u5w0zVGeAMm20pqhJK30wdsxmXcp
	ZcPCneBJb9iuHKRHpl5shO0kUXL+DEaRX7zhr5+E7uVycqG+3hidcMl/X9MRUNNqjo9i5diiFvq
	KsjANtVpMilTF3L4v+zZU0XZRmurXxpC++oz5WiZ5/tC6CG1hB0FolZ7Uz713HJJuSA1Ro9F8pU
	c2vcdbs66JLWAcIF1LNXrDLgwJmoARBHbmolQkfn4tQsPrZMXbaSh+bqtd7HafdBksSRakDP0jS
	gGu9oT6TVAxBR5F98cKp2m6hdan1xG/wPPrp22ywWJtCSqZKkKzw==
X-Google-Smtp-Source: AGHT+IHqtyB10IwXCu3lHnMQ3k/4txY/HuST/zDnQr4JWwMIBHIGOQQcRsdHWTibXy8Al3BlUxBK3w==
X-Received: by 2002:a05:600c:524a:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47a8380b074mr6192695e9.3.1765331066356;
        Tue, 09 Dec 2025 17:44:26 -0800 (PST)
Received: from [10.200.8.8] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a7000c984sm705234a91.6.2025.12.09.17.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 17:44:25 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 10 Dec 2025 10:43:33 +0900
Subject: [PATCH v4 9/9] arm64: dts: qcom: Add The Fairphone (Gen. 6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-sm7635-fp6-initial-v4-9-b05fddd8b45c@fairphone.com>
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
In-Reply-To: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765331010; l=21055;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=dQvpXyrMYNrV6758bacgoGHBnAGoyVS3u4Zw6ofPsuc=;
 b=rHbfp4lTxD5+8kacAPdKXOlGPj+PIHoYhyMjyOOvV1IdEiEdpkHWlSSZxOR88UTt7Qz/U7gTm
 rk3KrJ14rP4Bbn5/CKocqSe8JT0LomUgQxqLr3mWG17e4jK5AmqCLmW
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
on the Milos/SM7635 SoC.

Supported functionality as of this initial submission:
* Debug UART
* Regulators (PM7550, PM8550VS, PMR735B, PM8008)
* Remoteprocs (ADSP, CDSP, MPSS, WPSS)
* Power Button, Volume Keys, Switch
* PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
* Camera flash/torch LED
* SD card
* USB

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/Makefile                |   1 +
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 790 +++++++++++++++++++++++
 2 files changed, 791 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6f34d5ed331c..4b061124d7af 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -37,6 +37,7 @@ lemans-evk-camera-dtbs	:= lemans-evk.dtb lemans-evk-camera.dtbo
 
 dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera-csi1-imx577.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= milos-fairphone-fp6.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
new file mode 100644
index 000000000000..52895dd9e4fa
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -0,0 +1,790 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+/dts-v1/;
+
+#define PMIV0104_SID 7
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "milos.dtsi"
+#include "pm7550.dtsi"
+#include "pm8550vs.dtsi"
+#include "pmiv0104.dtsi" /* PMIV0108 */
+#include "pmk8550.dtsi" /* PMK7635 */
+#include "pmr735b.dtsi"
+
+/ {
+	model = "The Fairphone (Gen. 6)";
+	compatible = "fairphone,fp6", "qcom,milos";
+	chassis-type = "handset";
+
+	aliases {
+		serial0 = &uart5;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&volume_up_default>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&pm7550_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		switch {
+			label = "Switch";
+			gpios = <&tlmm 107 GPIO_ACTIVE_HIGH>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_MUTE_DEVICE>;
+		};
+	};
+
+	pmic-glink {
+		compatible = "qcom,milos-pmic-glink",
+			     "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 131 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+			};
+		};
+	};
+
+	vreg_ff_afvdd_2p8: regulator-ff-afvdd-2p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "ff_afvdd_2p8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 93 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_bob>;
+	};
+
+	vreg_uw_afvdd_2p8: regulator-uw-afvdd-2p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "uw_afvdd_2p8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 23 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_bob>;
+	};
+
+	vreg_uw_dvdd: regulator-uw-dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "uw_dvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 28 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_s1b>;
+	};
+
+	vreg_ois_avdd0_1p8: regulator-ois-avdd0-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "ois_avdd0_1p8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_bob>;
+	};
+
+	vreg_ois_vdd: regulator-ois-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ois_vdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 24 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vph_pwr>;
+	};
+
+	vreg_oled_dvdd_1p2: regulator-oled-dvdd-1p2 {
+		compatible = "regulator-fixed";
+		regulator-name = "oled_dvdd_1p2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+
+		gpio = <&tlmm 54 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_s2b>;
+
+		regulator-boot-on;
+	};
+
+	vreg_s1j: regulator-pm3001a-s1j {
+		compatible = "regulator-fixed";
+		regulator-name = "pm3001a_s1j";
+		regulator-min-microvolt = <2200000>;
+		regulator-max-microvolt = <2200000>;
+		startup-delay-us = <1000>;
+
+		gpio = <&pmr735b_gpios 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vph_pwr>;
+
+		pinctrl-0 = <&s1j_enable_default>;
+		pinctrl-names = "default";
+	};
+
+	vreg_vtof_ldo_3p3: regulator-vtof-ldo-3p3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vtof_ldo_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100>;
+
+		gpio = <&tlmm 76 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vph_pwr>;
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	thermal-zones {
+		pm8008-thermal {
+			polling-delay-passive = <100>;
+			thermal-sensors = <&pm8008>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm7550-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s1b>;
+		vdd-l2-l3-supply = <&vreg_s3b>;
+		vdd-l4-l5-supply = <&vreg_s2b>;
+		vdd-l6-supply = <&vreg_s2b>;
+		vdd-l7-supply = <&vreg_s1b>;
+		vdd-l8-supply = <&vreg_s1b>;
+		vdd-l9-l10-supply = <&vreg_s1b>;
+		vdd-l11-supply = <&vreg_s1b>;
+		vdd-l12-l14-supply = <&vreg_bob>;
+		vdd-l13-l16-supply = <&vreg_bob>;
+		vdd-l15-l17-l18-l19-l20-l21-l22-l23-supply = <&vreg_bob>;
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+
+		qcom,pmic-id = "b";
+
+		vreg_s1b: smps1 {
+			regulator-name = "vreg_s1b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2080000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s2b: smps2 {
+			regulator-name = "vreg_s2b";
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1408000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s3b: smps3 {
+			regulator-name = "vreg_s3b";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <1040000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b: ldo2 {
+			regulator-name = "vreg_l2b";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3b: ldo3 {
+			regulator-name = "vreg_l3b";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4b: ldo4 {
+			regulator-name = "vreg_l4b";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5b: ldo5 {
+			regulator-name = "vreg_l5b";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b: ldo7 {
+			regulator-name = "vreg_l7b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8b: ldo8 {
+			regulator-name = "vreg_l8b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b: ldo9 {
+			regulator-name = "vreg_l9b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10b: ldo10 {
+			regulator-name = "vreg_l10b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11b: ldo11 {
+			regulator-name = "vreg_l11b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12b: ldo12 {
+			regulator-name = "vreg_l12b";
+			/*
+			 * Skip voltage voting for UFS VCC.
+			 */
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13b: ldo13 {
+			regulator-name = "vreg_l13b";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14b: ldo14 {
+			regulator-name = "vreg_l14b";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15b: ldo15 {
+			regulator-name = "vreg_l15b";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16b: ldo16 {
+			regulator-name = "vreg_l16b";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17b: ldo17 {
+			regulator-name = "vreg_l17b";
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18b: ldo18 {
+			regulator-name = "vreg_l18b";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l19b: ldo19 {
+			regulator-name = "vreg_l19b";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l20b: ldo20 {
+			regulator-name = "vreg_l20b";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l21b: ldo21 {
+			regulator-name = "vreg_l21b";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l22b: ldo22 {
+			regulator-name = "vreg_l22b";
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l23b: ldo23 {
+			regulator-name = "vreg_l23b";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+
+		vdd-l1-supply = <&vreg_s3b>;
+		vdd-l3-supply = <&vreg_s3b>;
+
+		qcom,pmic-id = "c";
+
+		vreg_l2c: ldo2 {
+			regulator-name = "vreg_l2c";
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <650000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pmr735b-rpmh-regulators";
+
+		vdd-l1-l2-supply= <&vreg_s3b>;
+		vdd-l3-supply= <&vreg_s3b>;
+		vdd-l4-supply= <&vreg_s1b>;
+		vdd-l5-supply= <&vreg_s2b>;
+		vdd-l6-supply= <&vreg_s2b>;
+		vdd-l7-l8-supply= <&vreg_s2b>;
+		vdd-l9-supply= <&vreg_s3b>;
+		vdd-l10-supply= <&vreg_s1b>;
+		vdd-l11-supply= <&vreg_s3b>;
+		vdd-l12-supply= <&vreg_s3b>;
+
+		qcom,pmic-id = "f";
+
+		vreg_l1f: ldo1 {
+			regulator-name = "vreg_l1f";
+			regulator-min-microvolt = <852000>;
+			regulator-max-microvolt = <950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f: ldo2 {
+			regulator-name = "vreg_l2f";
+			regulator-min-microvolt = <751000>;
+			regulator-max-microvolt = <824000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3f: ldo3 {
+			regulator-name = "vreg_l3f";
+			regulator-min-microvolt = <650000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4f: ldo4 {
+			regulator-name = "vreg_l4f";
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <1950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5f: ldo5 {
+			regulator-name = "vreg_l5f";
+			regulator-min-microvolt = <1140000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6f: ldo6 {
+			regulator-name = "vreg_l6f";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7f: ldo7 {
+			regulator-name = "vreg_l7f";
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1350000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8f: ldo8 {
+			regulator-name = "vreg_l8f";
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1320000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9f: ldo9 {
+			regulator-name = "vreg_l9f";
+			regulator-min-microvolt = <870000>;
+			regulator-max-microvolt = <970000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10f: ldo10 {
+			regulator-name = "vreg_l10f";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11f: ldo11 {
+			regulator-name = "vreg_l11f";
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <864000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&gcc {
+	protected-clocks = <GCC_PCIE_1_AUX_CLK>, <GCC_PCIE_1_AUX_CLK_SRC>,
+			   <GCC_PCIE_1_CFG_AHB_CLK>, <GCC_PCIE_1_MSTR_AXI_CLK>,
+			   <GCC_PCIE_1_PHY_RCHNG_CLK>, <GCC_PCIE_1_PHY_RCHNG_CLK_SRC>,
+			   <GCC_PCIE_1_PIPE_CLK>, <GCC_PCIE_1_PIPE_CLK_SRC>,
+			   <GCC_PCIE_1_PIPE_DIV2_CLK>, <GCC_PCIE_1_PIPE_DIV2_CLK_SRC>,
+			   <GCC_PCIE_1_SLV_AXI_CLK>, <GCC_PCIE_1_SLV_Q2A_AXI_CLK>;
+};
+
+&i2c1 {
+	/* Samsung NFC @ 0x27 */
+
+	status = "okay";
+};
+
+&i2c3 {
+	/* AW88261FCR amplifier (top) @ 0x34 */
+	/* AW88261FCR amplifier (bottom) @ 0x35 */
+
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+
+	pm8008: pmic@8 {
+		compatible = "qcom,pm8008";
+		reg = <0x8>;
+
+		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_RISING>;
+		reset-gpios = <&pmr735b_gpios 3 GPIO_ACTIVE_LOW>;
+
+		vdd-l1-l2-supply = <&vreg_s2b>;
+		vdd-l3-l4-supply = <&vreg_bob>;
+		vdd-l5-supply = <&vreg_bob>;
+		vdd-l6-supply = <&vreg_s1b>;
+		vdd-l7-supply = <&vreg_bob>;
+
+		pinctrl-0 = <&pm8008_int_default>, <&pm8008_reset_n_default>;
+		pinctrl-names = "default";
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pm8008 0 0 2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		#thermal-sensor-cells = <0>;
+
+		regulators {
+			vreg_l1p: ldo1 {
+				regulator-name = "vreg_l1p";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			vreg_l2p: ldo2 {
+				regulator-name = "vreg_l2p";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1144000>;
+			};
+
+			vreg_l3p: ldo3 {
+				regulator-name = "vreg_l3p";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			vreg_l4p: ldo4 {
+				regulator-name = "vreg_l4p";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <2900000>;
+			};
+
+			vreg_l5p: ldo5 {
+				regulator-name = "vreg_l5p";
+				regulator-min-microvolt = <2704000>;
+				regulator-max-microvolt = <2900000>;
+			};
+
+			vreg_l6p: ldo6 {
+				regulator-name = "vreg_l6p";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1896000>;
+			};
+
+			vreg_l7p: ldo7 {
+				regulator-name = "vreg_l7p";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3400000>;
+			};
+		};
+	};
+
+	/* VL53L3 ToF @ 0x29 */
+	/* AW86938FCR vibrator @ 0x5a */
+};
+
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pmiv0104_eusb2_repeater {
+	vdd18-supply = <&vreg_l7b>;
+	vdd3-supply = <&vreg_l17b>;
+
+	qcom,tune-res-fsdif = /bits/ 8 <0x5>;
+	qcom,tune-usb2-amplitude = /bits/ 8 <0x8>;
+	qcom,tune-usb2-disc-thres = /bits/ 8 <0x7>;
+	qcom,tune-usb2-preem = /bits/ 8 <0x6>;
+};
+
+&pmr735b_gpios {
+	s1j_enable_default: s1j-enable-default-state {
+		pins = "gpio1";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <0>;
+		bias-disable;
+		output-low;
+	};
+
+	pm8008_reset_n_default: pm8008-reset-n-default-state {
+		pins = "gpio3";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-pull-down;
+	};
+};
+
+&pm7550_gpios {
+	volume_up_default: volume-up-default-state {
+		pins = "gpio6";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <1>;
+		bias-pull-up;
+	};
+};
+
+&pm7550_flash {
+	status = "okay";
+
+	led-0 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>, <4>;
+		led-max-microamp = <350000>;
+		flash-max-microamp = <1500000>;
+		flash-max-timeout-us = <400000>;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/milos/fairphone/fp6/adsp.mbn",
+			"qcom/milos/fairphone/fp6/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/milos/fairphone/fp6/cdsp.mbn",
+			"qcom/milos/fairphone/fp6/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/milos/fairphone/fp6/modem.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/milos/fairphone/fp6/wpss.mbn";
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
+
+	vmmc-supply = <&vreg_l13b>;
+	vqmmc-supply = <&vreg_l23b>;
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>, <&sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep>, <&sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
+&spi0 {
+	/* Eswin EPH8621 touchscreen @ 0 */
+};
+
+&tlmm {
+	gpio-reserved-ranges = <8 4>, /* Fingerprint SPI */
+			       <13 1>, /* NC */
+			       <63 2>; /* WLAN UART */
+
+	sdc2_card_det_n: sdc2-card-det-state {
+		pins = "gpio65";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	pm8008_int_default: pm8008-int-default-state {
+		pins = "gpio125";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usb_1 {
+	dr_mode = "otg";
+
+	/* USB 2.0 only, HW does not support USB 3.x */
+	qcom,select-utmi-as-pipe-clk;
+
+	status = "okay";
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l2b>;
+	vdda12-supply = <&vreg_l4b>;
+
+	phys = <&pmiv0104_eusb2_repeater>;
+
+	status = "okay";
+};

-- 
2.52.0


