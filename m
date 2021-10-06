Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE49A4249FC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 00:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhJFWog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 18:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhJFWof (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 18:44:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05447C061746
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 15:42:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so16654090lfu.5
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1xXQ7biViM7VYMIiajvvcNfznDeF3gC+OJ0VfX5MSM=;
        b=L0KNNkiUBUvyAp5aAgreYsp+YwxPIBMkfw8RztG0AJP+dzLBdZZHZCydm+TyNyXjOF
         6AFzQD05l6bd8ygWclpwkjg401Y2XbS1Hiea1QLoRR5beIMBVaurnAPllJlowvpLuNSW
         c2S2+JzGRVSlGgYDBdd0NsE2oLzbNROKgcJwWjAWV5klMLr9AqkIOox33/Mj81fMiNlZ
         30jJcKwMtNNJQ6zn3wYbLnnS1AtmPZFB7jCFiKEb7azT+qL9BfpxjpktGqha0kCRRPHQ
         i2eZFmr4CVIa7Je01D8rZTYlPL5U+36p68L5MBpKP3bSzZkgMCLrCSQGZApByUcPX+0p
         8/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1xXQ7biViM7VYMIiajvvcNfznDeF3gC+OJ0VfX5MSM=;
        b=RLpTYEMsX5O9FiBmwDZ1RNLto5ObjWNM0q/kqLdQzYQ29Re68ZJJ8/BZtvsDOLv+81
         7yrGFksEWCcIV2cnCw0m5Cxnyej8fnrvHQRixuCYS09E6Wp6c5q419/Wzsx7/5DKxPxf
         ptP41J9yT4C4t31iVPyfGHNPj8M8ZM7rqtfcCN78hTYvvzxZvDOXI68bL2VjhkO8ZeDj
         drO/veCuWHNJh8lB232/HeAHnczOv9NEIUHsvoJ6oarFJ7lCuRgvZ9TvcBC/jisU9cEz
         k8vinW5NbpoPnjY4WZEyHV1IRJzGKhxJjm/9cTaruzUrC4yT/BW77CmXYQOEuFG6axI3
         XpPg==
X-Gm-Message-State: AOAM530lQVWCTUbpNiC1oPan72T+1av+iqJPkszJanaFFQ/gAdz/Of0w
        9N0DUEF1dyA/eTgOYjsXUdMIcA==
X-Google-Smtp-Source: ABdhPJw3MoampPu2CzIYimy0hmgQzlCvjiJo9eTMXEstjyIzV/dlnWsdOd6j8SQMFBz0Whs13gJ7wg==
X-Received: by 2002:a2e:80d9:: with SMTP id r25mr839218ljg.104.1633560160876;
        Wed, 06 Oct 2021 15:42:40 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g7sm2368103lfc.123.2021.10.06.15.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:42:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] ARM: dts: ux500: Switch battery nodes to standard
Date:   Thu,  7 Oct 2021 00:40:08 +0200
Message-Id: <20211006224008.394191-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006224008.394191-1-linus.walleij@linaro.org>
References: <20211006224008.394191-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This force-converts the per-device battery node into the standard
properties using "simple-battery" for the HREF machines and the
corresponding Samsung battery for the mobile phones.

This is fine to do since the battery data in the DTS files has never
been deployed or used. In commit a1149ae97554
"ARM: ux500: Disable Power Supply and Battery Management by default"
it was turned off and has not been switched back on since. In
the meantime standardized bindings for batteries have appeared
making the old AB8500 battery bindings obsolete.

The battery node which is now in the middle of an included file
is obviously a per-device piece of information so push this down
to each board. The HREF machines all have the same battery and can
share a single node in the HREF dtsi file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sebastian: I will merge this patch to the Ux500 tree when/if you
merge the two other patches, so all is fixed up in linux-next and
in the merge window.
---
 arch/arm/boot/dts/ste-ab8500.dtsi              | 13 ++++---------
 arch/arm/boot/dts/ste-ab8505.dtsi              | 13 ++++---------
 arch/arm/boot/dts/ste-href.dtsi                |  6 ++++++
 arch/arm/boot/dts/ste-snowball.dts             |  6 ++++++
 arch/arm/boot/dts/ste-ux500-samsung-codina.dts |  4 ++++
 arch/arm/boot/dts/ste-ux500-samsung-gavini.dts |  4 ++++
 arch/arm/boot/dts/ste-ux500-samsung-golden.dts |  4 ++++
 arch/arm/boot/dts/ste-ux500-samsung-janice.dts |  4 ++++
 arch/arm/boot/dts/ste-ux500-samsung-kyle.dts   |  4 ++++
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts |  4 ++++
 10 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/ste-ab8500.dtsi b/arch/arm/boot/dts/ste-ab8500.dtsi
index 9baf927f9b95..2cf19386a525 100644
--- a/arch/arm/boot/dts/ste-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-ab8500.dtsi
@@ -129,11 +129,6 @@ ab8500_temp {
 					io-channel-names = "aux1", "aux2";
 				};
 
-				ab8500_battery: ab8500_battery {
-					stericsson,battery-type = "LIPO";
-					thermistor-on-batctrl;
-				};
-
 				ab8500_fg {
 					compatible = "stericsson,ab8500-fg";
 					interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
@@ -146,7 +141,7 @@ ab8500_fg {
 							  "LOW_BAT_F",
 							  "CC_INT_CALIB",
 							  "CCEOC";
-					battery = <&ab8500_battery>;
+					monitored-battery = <&battery>;
 					io-channels = <&gpadc 0x08>;
 					io-channel-names = "main_bat_v";
 				};
@@ -163,7 +158,7 @@ ab8500_btemp {
 							  "BTEMP_HIGH",
 							  "BTEMP_LOW_MEDIUM",
 							  "BTEMP_MEDIUM_HIGH";
-					battery = <&ab8500_battery>;
+					monitored-battery = <&battery>;
 					io-channels = <&gpadc 0x02>,
 						      <&gpadc 0x01>;
 					io-channel-names = "btemp_ball",
@@ -200,7 +195,7 @@ ab8500_charger {
 							  "VBUS_OVV",
 							  "CH_WD_EXP",
 							  "VBUS_CH_DROP_END";
-					battery		= <&ab8500_battery>;
+					monitored-battery = <&battery>;
 					vddadc-supply	= <&ab8500_ldo_tvout_reg>;
 					io-channels = <&gpadc 0x03>,
 						      <&gpadc 0x0a>,
@@ -214,7 +209,7 @@ ab8500_charger {
 
 				ab8500_chargalg {
 					compatible	= "stericsson,ab8500-chargalg";
-					battery		= <&ab8500_battery>;
+					monitored-battery	= <&battery>;
 				};
 
 				ab8500_usb: ab8500_usb {
diff --git a/arch/arm/boot/dts/ste-ab8505.dtsi b/arch/arm/boot/dts/ste-ab8505.dtsi
index 8d018701a680..e98335e9d1cb 100644
--- a/arch/arm/boot/dts/ste-ab8505.dtsi
+++ b/arch/arm/boot/dts/ste-ab8505.dtsi
@@ -92,11 +92,6 @@ usb_id: channel@e {
 					};
 				};
 
-				ab8500_battery: ab8500_battery {
-					stericsson,battery-type = "LIPO";
-					thermistor-on-batctrl;
-				};
-
 				ab8500_fg {
 					status = "disabled";
 					compatible = "stericsson,ab8500-fg";
@@ -110,7 +105,7 @@ ab8500_fg {
 							  "LOW_BAT_F",
 							  "CC_INT_CALIB",
 							  "CCEOC";
-					battery = <&ab8500_battery>;
+					monitored-battery = <&battery>;
 					io-channels = <&gpadc 0x08>;
 					io-channel-names = "main_bat_v";
 				};
@@ -128,7 +123,7 @@ ab8500_btemp {
 							  "BTEMP_HIGH",
 							  "BTEMP_LOW_MEDIUM",
 							  "BTEMP_MEDIUM_HIGH";
-					battery = <&ab8500_battery>;
+					monitored-battery = <&battery>;
 					io-channels = <&gpadc 0x02>,
 						      <&gpadc 0x01>;
 					io-channel-names = "btemp_ball",
@@ -166,7 +161,7 @@ ab8500_charger {
 							  "VBUS_OVV",
 							  "CH_WD_EXP",
 							  "VBUS_CH_DROP_END";
-					battery = <&ab8500_battery>;
+					monitored-battery = <&battery>;
 					vddadc-supply = <&ab8500_ldo_adc_reg>;
 					io-channels = <&gpadc 0x09>,
 						      <&gpadc 0x0b>;
@@ -177,7 +172,7 @@ ab8500_charger {
 				ab8500_chargalg {
 					status = "disabled";
 					compatible = "stericsson,ab8500-chargalg";
-					battery = <&ab8500_battery>;
+					monitored-battery = <&battery>;
 				};
 
 				ab8500_usb: ab8500_usb {
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 961f2c7274ce..718752a0248e 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -13,6 +13,12 @@ memory {
 		reg = <0x00000000 0x20000000>;
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+		battery-type = "lithium-ion-polymer";
+		thermistor-on-batctrl;
+	};
+
 	soc {
 		uart@80120000 {
 			pinctrl-names = "default", "sleep";
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 934fc788fe1d..fb719c8a8eb2 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -17,6 +17,12 @@ memory {
 		reg = <0x00000000 0x20000000>;
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+		battery-type = "lithium-ion-polymer";
+		thermistor-on-batctrl;
+	};
+
 	en_3v3_reg: en_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "en-3v3-fixed-supply";
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-codina.dts b/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
index 952606e607ed..fbd60065542d 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
@@ -43,6 +43,10 @@ chosen {
 		stdout-path = &serial2;
 	};
 
+	battery: battery {
+		compatible = "samsung,eb425161lu";
+	};
+
 	/* TI TXS0206 level translator for 2.9 V */
 	sd_level_translator: regulator-gpio {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts b/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
index fabc390ccb0c..47bbf5ab267f 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
@@ -20,6 +20,10 @@ chosen {
 		stdout-path = &serial2;
 	};
 
+	battery: battery {
+		compatible = "samsung,eb585157lu";
+	};
+
 	/* TI TXS0206 level translator for 2.9 V */
 	sd_level_translator: regulator-gpio {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
index ee6379ab688c..fc4c5166d85b 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
@@ -25,6 +25,10 @@ chosen {
 		stdout-path = &serial2;
 	};
 
+	battery: battery {
+		compatible = "samsung,eb-l1m7flu";
+	};
+
 	i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		sda-gpios = <&gpio2 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-janice.dts b/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
index f14cf316a70a..2c914c58f8ba 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
@@ -20,6 +20,10 @@ chosen {
 		stdout-path = &serial2;
 	};
 
+	battery: battery {
+		compatible = "samsung,eb535151vu";
+	};
+
 	/* External LDO for eMMC LDO VMEM_3V3 controlled by GPIO6 */
 	ldo_3v3_reg: regulator-gpio-ldo-3v3 {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts b/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
index 3b825666d302..9ec3f85b1a18 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
@@ -24,6 +24,10 @@ chosen {
 		stdout-path = &serial2;
 	};
 
+	battery: battery {
+		compatible = "samsung,eb425161la";
+	};
+
 	/* TI TXS0206 level translator for 2.9 V */
 	sd_level_translator: regulator-gpio {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts b/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
index 264f3e9b5fce..37020127f6e7 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
@@ -20,6 +20,10 @@ chosen {
 		stdout-path = &serial2;
 	};
 
+	battery: battery {
+		compatible = "samsung,eb485159lu";
+	};
+
 	/* TI TXS0206 level translator for 2.9 V */
 	sd_level_translator: regulator-gpio {
 		compatible = "regulator-fixed";
-- 
2.31.1

