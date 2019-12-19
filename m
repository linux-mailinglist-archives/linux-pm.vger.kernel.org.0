Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCD012680F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLSR27 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:28:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36900 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLSR2k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:28:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so3641496pfn.4;
        Thu, 19 Dec 2019 09:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MwC4kiAoJwmEvvok2zeVWvSvfB/Rr1Rx679AfrnD9Mk=;
        b=SAAf6ZgbMdOKdv1GrrqnElwrVXywbB0KX9GusukNVriXEXoUlPXNyGUWbHBDJKNDFy
         smeLWJYyC5r6pORhVdlwNpn2s8Wr9uyBLVAGPwXUOOPEpB5zy5hjhosvEUzdeFMEIahD
         IzQgzG7uKN+ZaEAnpoPEv6RXeGydfJb6ZsLIAcw+F9AntFIxe5yacP16Iyd3b+l6kd+P
         UY/A3HeqsvHVamPiHdUiFl659pYsRy/mXBiWZf2G9rnCdQn63g+ITpcGABiOian4KTyI
         1wjegdG+s0JYrRhsrqKPaLu0KdGzkNJ1IVcoVkfdj8Q7E/ttSGMzcMI7JaRemh7DMOfN
         0xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwC4kiAoJwmEvvok2zeVWvSvfB/Rr1Rx679AfrnD9Mk=;
        b=muvNLIjPUQ9oglgray00H1OqqKW8eXBaid/vgAJbBlR7vccsqG4pMrK/7hy9yQGswB
         2AP8p6Yu8m/jB6OHCsTVOgacUGp7M8dLjhsmhYUy4mm6JZAIQeGJpua4iVACe9IObP2p
         dFDM8y7t+imo4bIzHH2UhZU+9x3suGXz6D8oKxPcs5GnHbsbJCBZ0w3fcBBZVuaERsWB
         8VwKRIQueEdOWdL3YOy2Czk9EYHUhOxtT1exNTa0L4q28RnfVJ8kcs2TtkB0uwN2mbWq
         Q3E5TR7kKBFAP9/0t9A6pWOWSgzvwdGByecc5g9AsicQTX7C5F3ZEJpmhekPyNP/TO4B
         agIw==
X-Gm-Message-State: APjAAAUV9WbI4+S2DdWZnON1OxRf9ExV/dTnImjIrJ3p7sKdov7B8pKl
        P/fbEOVTZLZS74CPX8bF0iE=
X-Google-Smtp-Source: APXvYqyVNvInPOQdrmBibp/K/kkCxmf5pOhmp0ulb+jo692+qlMdkERyFVpZr2PVs1LvheGU687kbw==
X-Received: by 2002:a63:d351:: with SMTP id u17mr9931490pgi.84.1576776519539;
        Thu, 19 Dec 2019 09:28:39 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v143sm536209pfc.71.2019.12.19.09.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:28:39 -0800 (PST)
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
Subject: [PATCH v8 6/7] arm64: dts: allwinner: h6: Add thermal sensor and thermal zones
Date:   Thu, 19 Dec 2019 09:28:22 -0800
Message-Id: <20191219172823.1652600-7-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219172823.1652600-1-anarsoul@gmail.com>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

There are two sensors, one for CPU, one for GPU.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 29824081b43b..345a4c851c8d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/reset/sun50i-h6-ccu.h>
 #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -233,6 +234,12 @@ dma: dma-controller@3002000 {
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun50i-h6-sid";
 			reg = <0x03006000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@14 {
+				reg = <0x14 0x8>;
+			};
 		};
 
 		watchdog: watchdog@30090a0 {
@@ -856,5 +863,31 @@ r_i2c: i2c@7081400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		ths: thermal-sensor@5070400 {
+			compatible = "allwinner,sun50i-h6-ths";
+			reg = <0x05070400 0x100>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 1>;
+		};
 	};
 };
-- 
2.24.1

