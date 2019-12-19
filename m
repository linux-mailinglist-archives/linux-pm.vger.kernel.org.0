Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5093E126809
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLSR2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:28:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47055 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfLSR2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:28:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so3452764pgb.13;
        Thu, 19 Dec 2019 09:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yf9x7J4CUf5atAEG5GNkhAPGZNNfFUTHbw0cShPeAGo=;
        b=lf4LeI/d3WIz5hIkRKhsC4D++BKhL5mFQ1ddsTVWfwYGLuI+zaGphyAfHXoQv7O9UJ
         JINyc3ovjehf6FedEq0Vm1k1+eZg8UAFCGlFFII8H2g/T9fxn0FBsgumCApIJKgnvGnf
         P79O0u2LS8dv7/P3hvqJcUPoWzC2Zun4hZPcrBB3uidhZnrfBg8ho61fcbTNEQw2ag1v
         1EiYl204ha212XtwhHHeJs9eYXaiXeOA7845p7UWu0H6G7eyDDnz8uX913Zvg/zhuTJ3
         4Vz0e614YSnXnm9Qu+msVxoNkH5G3MNW6uthvgdyxJaYMu9cHJVpteAqIaBaSFBiwhIy
         0oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yf9x7J4CUf5atAEG5GNkhAPGZNNfFUTHbw0cShPeAGo=;
        b=LZyJh63EZ44k9BSXaoJgBwgzWrK9XH52lyn+yp+EAjVZXKMq+ZyGGLYvPQ73EZM2r7
         OCYrJ3ITXHaVrXVPx5LcvcL7G2dtVabUw1pgp75qSZEVvJrP/YQYAn4gALqFLCrEtzGr
         6q+lslALUB8dlkMRmG9anfc3s+Q6L/Z4y3hcPcccteboQQYqpLqgIcJP7Nc/oDcdQo5C
         FGmU5kWOeW+IuLemHHqbDl9rWJSAI91awuomZhGvUihP3f9A34u/XRMXx/i35XZXWtms
         E3MXWDENPGR+PuSRGqA93qeP58WK34hCxI9UeUVc/z3ScvC7gOBunzZsfvXcz0o8uMUd
         HGjw==
X-Gm-Message-State: APjAAAVV4AmkTrEHKyw7kHoXIeeP/1rQKlEuSyBLysNA174pM5RG31f/
        MHe1lfnjC0Fl10aaa98W7Kg=
X-Google-Smtp-Source: APXvYqwGLD0638hkg+H61q0hZkuVBkX9PZVyf2VbtSBiRWlWhG2C5kOYGaK/AsGEtYD6+crgshGN/w==
X-Received: by 2002:a62:3343:: with SMTP id z64mr10556181pfz.150.1576776520564;
        Thu, 19 Dec 2019 09:28:40 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v143sm536209pfc.71.2019.12.19.09.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:28:40 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megous@megous.com>,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v8 7/7] arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
Date:   Thu, 19 Dec 2019 09:28:23 -0800
Message-Id: <20191219172823.1652600-8-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219172823.1652600-1-anarsoul@gmail.com>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A64 has 3 thermal sensors: 1 for CPU, 2 for GPU.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 27e48234f1c2..5e3f16c3b706 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -49,6 +49,7 @@
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun8i-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -211,6 +212,29 @@ timer {
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu0-thermal {
+			/* milliseconds */
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
+
+		gpu0_thermal: gpu0-thermal {
+			/* milliseconds */
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 1>;
+		};
+
+		gpu1_thermal: gpu1-thermal {
+			/* milliseconds */
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 2>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -485,6 +509,12 @@ mmc2: mmc@1c11000 {
 		sid: eeprom@1c14000 {
 			compatible = "allwinner,sun50i-a64-sid";
 			reg = <0x1c14000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@34 {
+				reg = <0x34 0x8>;
+			};
 		};
 
 		crypto: crypto@1c15000 {
@@ -810,6 +840,18 @@ codec: codec@1c22e00 {
 			status = "disabled";
 		};
 
+		ths: thermal-sensor@1c25000 {
+			compatible = "allwinner,sun50i-a64-ths";
+			reg = <0x01c25000 0x100>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <1>;
+		};
+
 		uart0: serial@1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.24.1

