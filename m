Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F0313170C
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 18:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgAFRqq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 12:46:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36518 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFRqq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 12:46:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so27285183pfb.3;
        Mon, 06 Jan 2020 09:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EiXC/MriP+cdpOhem11vYI94GWNz0CCSOZkGZBL2d9U=;
        b=UaFPkDcsmqcQKqX3+FYyaP9kZ89B9Q3kyv4mqMnp/Jm8+bImb4IYLtjvkl80f8bXUh
         1f8UPPP63XiKkYuEnJaX9ZtGFspbz/vMd06l0aTs+BN8Jo/W/5gXW/IXAUSbZm0CHq7J
         8JTR+1I5hdf9CRStbAS5cAUI/wAcG8hFXl+HxcAJZLUe5c80zANFiwcOfx9/mICBeypY
         MXEDARX/OLFgTLuELG4sdsv4aV06RkdtQ9AB4nwrNDzw+FUUKopybwhrQyccBhDNcQEZ
         SGeOiBSMvTGMHOnbiCYU+UqKqCiou19nibQ1jnRZCEwYMsoz4KmGd3IyouMy8hWypYJW
         cO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EiXC/MriP+cdpOhem11vYI94GWNz0CCSOZkGZBL2d9U=;
        b=iZl5DPTplBWMac7Oih7oQMc2K/wu8t2eTqZ4J3QwIYlM4X6l6pEki6qMGo92bl6r1E
         afOwrojtCjjOr5icJtygmBfvfB5WHBbd8l8NyJuyQaz47EcdsML2n+QZxOD/C954H0cv
         v93E1pi7zyGYlXvCj9SJKiDEr7khjrjfHMli+ghjcD5yW+QpgeIFJh/u2HHTFogGvJuA
         lMn/9g+vzUJ5hNs2GL5HwYqjP+BsMBxK+lBI73hG2j6TeBmvYjNKagr42mXGYM1LqZ7q
         SJ5j2K2D1ZPSYBnjlOBPxvbnGW3iIJJVtaeyF3fDHBaWZeb8BFztJi2Gr1/KGfFsXA4M
         Xhvw==
X-Gm-Message-State: APjAAAWinLYsFcR8O/6UwQRQ+sg89MdwefneO2sSxAeDF2TZQlWCziIR
        fvEFMoO+tH3ajQ3NRxycSnY=
X-Google-Smtp-Source: APXvYqzsNn60tFIDS08//elWhClHXWYYTqFBsfumM81M+fXB1pfEhQnuBltx+uVuXKE/434H9TCGeg==
X-Received: by 2002:aa7:96f9:: with SMTP id i25mr111741807pfq.161.1578332805413;
        Mon, 06 Jan 2020 09:46:45 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id l2sm59166879pff.59.2020.01.06.09.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 09:46:44 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org, anarsoul@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        megous@megous.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 2/2] ARM: dts: sun8i-r40: Add thermal sensor and thermal zones
Date:   Mon,  6 Jan 2020 17:46:39 +0000
Message-Id: <20200106174639.20862-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106174639.20862-1-tiny.windzz@gmail.com>
References: <20200106174639.20862-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are two sensors, sensor0 for CPU, sensor1 for GPU.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-r40-bananapi-m2-ultra
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 421dfbbfd7ee..8ccda5cb873f 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -46,6 +46,7 @@
 #include <dt-bindings/clock/sun8i-r40-ccu.h>
 #include <dt-bindings/reset/sun8i-r40-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	#address-cells = <1>;
@@ -109,6 +110,22 @@
 		status = "disabled";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu0-thermal {
+			/* milliseconds */
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
+
+		gpu_thermal: gpu-thermal {
+			/* milliseconds */
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 1>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -421,6 +438,17 @@
 			clocks = <&osc24M>;
 		};
 
+		ths: thermal-sensor@1c24c00 {
+			compatible = "allwinner,sun8i-r40-ths";
+			reg = <0x01c24c00 0x100>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_BUS_THS>;
+			/* TODO: add nvmem-cells for calibration */
+			#thermal-sensor-cells = <1>;
+		};
+
 		uart0: serial@1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.17.1

