Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2167910AA29
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 06:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfK0FaV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 00:30:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37304 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfK0FaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 00:30:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id bb5so9227110plb.4;
        Tue, 26 Nov 2019 21:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=es+5okh9NS8TG2ZO2TIeJ4gr7E8aOMvh1xmhynBOxJ0=;
        b=fYLCla6VxiSdLxhIX+tOV9FiLnql2QSoN0V37eLRAwt/jUaz1fVC07pqIjcXCWloxI
         jc7L9C4W2UhhYd/QumnwLyI3s1blAn/R7lDsICqQ0uWV5vLr8HiKZYIh+UOo9XIhCV6c
         jOwWm8ctIIjtZLWE3H4I8upcwgZWEPKm/NMv5mAEmkFzyoXAFjyZDO0mPEDs7uqyipPU
         ohTlRSE54YOCLys+z02lkvZiIC9VEagy8yJquEBXKgHAwGdyGdhGoGBBX4sETQCpoDLn
         3DDREwO2KDrLy14DRMK49F+qJrg1el63Ci5fOnB4tUbVrYnGS9bEKfIa+4jQ5Dgc/MyX
         jx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=es+5okh9NS8TG2ZO2TIeJ4gr7E8aOMvh1xmhynBOxJ0=;
        b=KUG6EITOmst5/v3rfPF/jkO4RuC5Sk16Xv0dOY1pp7obkh8/wCRGwWmkFuZSfLFyfV
         jYuNmE07QXQ529KfB/oKKgvcFZZyJ5Ax/UAihdLBDhpH+X2tXqNzUDVlHDNdE/5De/J3
         xJqG47Du9C+vy5MEXXuxPxYJfm38Y9rF7oZ2btvRktE/YJq5uKjJjpMje1O86TI1tZlh
         GDqr2TpS3B2KF8z3EDlQr4dVLc5xSHEusjS7QlpRnpIaeJRK9QSDCJ5kABzNGKXKZA5a
         O3QiZIY92+b7bC4iW72OXXHjrtPY74+cpuE3n/1U1JvdZNMpQb2vHDA24ihFRKc1iWYe
         KTww==
X-Gm-Message-State: APjAAAUK+Z5WKLWJx1xUZfQDPiZfavvRtK20tuFeihC9TEkYauhzu7z5
        DtF0oxw11fLv4eHIrpO9FJM=
X-Google-Smtp-Source: APXvYqxqWeCIs+6yPmdynGT8mgYF35CDJXNWdDsV9G7Ufe6WhLxoqDLju9vn+6ZrizPnQ0hgDtcZsg==
X-Received: by 2002:a17:90a:a607:: with SMTP id c7mr3716982pjq.61.1574832607717;
        Tue, 26 Nov 2019 21:30:07 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id p38sm4360825pjp.27.2019.11.26.21.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:30:07 -0800 (PST)
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
Subject: [PATCH v6 6/7] arm64: dts: allwinner: sun50i-h6: Add thermal sensor and thermal zones
Date:   Tue, 26 Nov 2019 21:29:34 -0800
Message-Id: <20191127052935.1719897-7-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127052935.1719897-1-anarsoul@gmail.com>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
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
index 0d5ea19336a1..18288387762f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/reset/sun50i-h6-ccu.h>
 #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -210,6 +211,12 @@
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun50i-h6-sid";
 			reg = <0x03006000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@14 {
+				reg = <0x14 0x6>;
+			};
 		};
 
 		watchdog: watchdog@30090a0 {
@@ -792,5 +799,31 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		ths: ths@5070400 {
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
2.24.0

