Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168F4123E64
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 05:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLREVg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 23:21:36 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39310 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfLREVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 23:21:35 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so254130pjb.4;
        Tue, 17 Dec 2019 20:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2d+ahFeOkEATCdRxK9eTJRkU69hz2zRKJpFAKDhJEA=;
        b=D0pEVsIipKoUZRq4dcGZk3Ly+nbar7xAXTcPpuLieCLHUVMgyiUhlKh0E6P1ZHTrQR
         /NQXEVt0TVbHrfMVuqUI9miC+4UOUgnt7voHAwdg1AaO1YigjcFMrVgDrnvSt5xynUFB
         W8ssEW1T+skz8LNQay5lDS8ubvEy7mH+eS5kkL0Yzb98UGOubqvHlaamSZlbtOy94m7I
         QpvhPbwE+wHox1xSY7pxvf1Me9XnewU1PEo5Ei2KNhHr/iBSSHI2MrKUlbnnbYO40kjr
         osSjJjP5G0MZWaGwYExQtKpw090si9mTSRRZPLhxKb2J/R2CCq+E0YjnQBeyHf0oJ7+A
         qWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2d+ahFeOkEATCdRxK9eTJRkU69hz2zRKJpFAKDhJEA=;
        b=Td0y3AKgNs3oZbqS0r94Tw98SrP+7dm/nL2yQ42mpPgN8MFtgT8EKhC3J0sz1XHRWD
         4RF3HrsMjLgWo5O5veKt1wY5SQ6bi2Glh4uOvA66uZ3kSz4Sv6ourlqwEwuyo4GQ/s2V
         mQTr8Sxy3PDegGgJKoD7zys68sgopMeyfDL7h7OzFwrL889mFJ+HMyx6ogPtKYFrvLTQ
         wb5otR48uIeFx+yV9iDVbTUVgM/BnDPsk5+dyTjUH7Ju8rCejHbh4Cji0Tf6rHVYfrPp
         qQbPv/l1NUvhC1B06+otljGjZ/9WBJh1JOAecXg2hjnVPLE51WKi3fpVal8MUnYNPFuX
         NfSQ==
X-Gm-Message-State: APjAAAXXh8ObkNkeOzrcfhEHHyUGrvacHiqMTFxVP4d86uOKhhMJML/Q
        jHaF1m9xFYHecAZCaxlwP98=
X-Google-Smtp-Source: APXvYqxgn2rYYrjJ3k3VjIa+89rQz1elMpM1AwMjdLVAf5B6YfYs2+o275CoGDgufuj15z4XTuSpEg==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr287449plf.213.1576642894642;
        Tue, 17 Dec 2019 20:21:34 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id g17sm775380pfb.180.2019.12.17.20.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:21:34 -0800 (PST)
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
Subject: [PATCH v7 7/7] arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
Date:   Tue, 17 Dec 2019 20:21:21 -0800
Message-Id: <20191218042121.1471954-8-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218042121.1471954-1-anarsoul@gmail.com>
References: <20191218042121.1471954-1-anarsoul@gmail.com>
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
index 27e48234f1c2..e6556c6d7777 100644
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
+				reg = <0x34 0x6>;
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

