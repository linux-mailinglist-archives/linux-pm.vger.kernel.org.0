Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675141316AE
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 18:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAFRXF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 12:23:05 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56297 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgAFRXE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 12:23:04 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so7814543pjz.5;
        Mon, 06 Jan 2020 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=EiXC/MriP+cdpOhem11vYI94GWNz0CCSOZkGZBL2d9U=;
        b=Fgih5/mKhpixJHIO6J5wKEuJKm7z0uNcQcfAvNH/An3WxxPmMy+MsVfGvWH8F+G/kE
         WnSgM2VT95YfTuvide3gtMzFG/e77mch7xQ6DXG5Dd6MU7yQ7Mg9L88UWJjVqL6LXspH
         5mccJdFyoViN6VNicTG6d8NEZTWBvn0Qm/hIjWml5LQybFMWwhm14A/QjTDh3n7pduR2
         7QPR24Lz9HK6h1nCe6ViwF/6q1GCbvWBsxkQ9HQySVnsjBAhGUzJQGme1O4YhNy6r/Nw
         DlKd8fVdqt/hSSddPfkyoSPWamfinzb6SOrmEbMSN8wx4Egu0xkOK0E1xEvuNrZUIxef
         kTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=EiXC/MriP+cdpOhem11vYI94GWNz0CCSOZkGZBL2d9U=;
        b=FYvbBRlWLqFYGh76v5EuZ4axyW2lGQNCtVcDiy1MPddGUNUH5eAau20AOXfsWvSxGK
         oRBe+npTCO2x/E44evFum8b/8DE36HZKCQV67Q12/CEk5upZhkkbI+ZXtqXGSlhPqiux
         JXzuFlIds1t3eWpbvbtfik3PDaID9XkDNUmTTr8t+O9+2AFobZUcwS8BIRuLmqAXH/I2
         nu43VAunQSiYuB8uFxfmBCHjufDbeArcyGbjCaP1QR7eOkLSLBGZJgSvqXltoL7Mdz9I
         uQCnGchWmvDFmC2McLRjZs9+6GvGBp6+zfuvW3GUQoD3z4xVkgHUXN+38q3MmBWB7sfq
         Xn7g==
X-Gm-Message-State: APjAAAVZJ4MvEKdzuzpVbts395PrkuK+vLE0Uu1Av0+k9wUbl8AzQtBV
        /KM7gFj2m3Kx7N2qlRLuSlE=
X-Google-Smtp-Source: APXvYqyB4iG4q1U/Odr0v3tivcHOlY4azofIJDFUH6PdH0VjXjYafHAzGQBMVo8AxD5sE0fqJl7dFA==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr110322875plr.16.1578331383886;
        Mon, 06 Jan 2020 09:23:03 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id f9sm76869387pfd.141.2020.01.06.09.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 09:23:03 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org, anarsoul@gmail.com, tiny.windzz@gmail.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: sun8i-r40: Add thermal sensor and thermal zones
Date:   Mon,  6 Jan 2020 17:22:54 +0000
Message-Id: <20200106172254.20271-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106172254.20271-1-tiny.windzz@gmail.com>
References: <20200106172254.20271-1-tiny.windzz@gmail.com>
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

