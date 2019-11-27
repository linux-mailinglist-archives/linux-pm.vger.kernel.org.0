Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF89C10AA20
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 06:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfK0FaP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 00:30:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33759 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfK0FaJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 00:30:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so5667315pgk.0;
        Tue, 26 Nov 2019 21:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/g/N4KzHVV4RuzvNHUGZqmzy45B3KGb/OK0/1dB9T8=;
        b=Gxdw2rKqQP1tFFYTh/7YkqTFLDu3h8wGRO7A1pwADtbKv2Icos2XLtwyzFORJg/COV
         TGLg+lJEUAZMQtn6c/DFzattserk6a18kPE5ZaGOBFHdH+5MrZecQxb6/iQh3dbUrT8u
         hdlMKJw3tj/OITbVx3catDXjgCa6Lb2AWMv0s/4UQzk91IWq2EN3SZQILiAtMa4BcQ2g
         CEBOf6ALxwOV0q2OndJ+0UwkdUHDI7Nu3zV/2kzhFWqRZQPfCP4rUcgLPteBn5Fxh/24
         jDN2vJM4bRSFNsu0p62O3obzwE92hYEy7tibnNz/X2KCALhL0CwRtQDB/Tb7pBcvQ0be
         wNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/g/N4KzHVV4RuzvNHUGZqmzy45B3KGb/OK0/1dB9T8=;
        b=oiOLqhLHR+2n6qhdMV4fhBr8fQci/Vten/w50JtPe6o+c+JpPddWRw6ElpTTA6NQI/
         Yxol+UoFSUoxg2/jQUp+U0GEVzWxEFClPV9sagar36l8oD2ySr3hfOqeon8gIWHcv4El
         m4WSzfd0mXYZCwv67YOF3dna/gIbCB184lV4Pxi+PURKgYUse77IFZZuw1XANCDnlQ3G
         VCeRnjuT0CnfoOpQEkUKKCWukf3OdjBF8IROyh/psSPAKP2AtGzxyJn77SikdVYHuM47
         IIUaGk/kpmXe1ZECXbsXnrLEG8KRWr3mcnb7XIGYRMx3OR6bVA5PBf55jN4NKi+g6WAb
         UAUA==
X-Gm-Message-State: APjAAAVUgH5hm6VKo9ARufkbqAF8nvthgWH2BDyUjWu/2oU9ii0RAUXI
        gV7TYpgBnjar6GjKWQm0XiI=
X-Google-Smtp-Source: APXvYqytlD1vXHcdOuDq5LuRIkSh1p/G+80uJlZCuAO/WdysYgSu7XidkxJyqo2lBaGefFezyXGcUA==
X-Received: by 2002:aa7:8517:: with SMTP id v23mr44949740pfn.75.1574832608526;
        Tue, 26 Nov 2019 21:30:08 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id p38sm4360825pjp.27.2019.11.26.21.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:30:08 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
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
Subject: [PATCH v6 7/7] arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
Date:   Tue, 26 Nov 2019 21:29:35 -0800
Message-Id: <20191127052935.1719897-8-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127052935.1719897-1-anarsoul@gmail.com>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
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
index 70f4cce6be43..59ef6410c6e0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -49,6 +49,7 @@
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun8i-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -202,6 +203,29 @@
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
@@ -476,6 +500,12 @@
 		sid: eeprom@1c14000 {
 			compatible = "allwinner,sun50i-a64-sid";
 			reg = <0x1c14000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@34 {
+				reg = <0x34 0x6>;
+			};
 		};
 
 		usb_otg: usb@1c19000 {
@@ -792,6 +822,18 @@
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
2.24.0

