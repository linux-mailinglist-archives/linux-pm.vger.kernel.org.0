Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D732F10AA25
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 06:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK0FaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 00:30:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46306 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0FaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 00:30:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id k1so1837079pga.13;
        Tue, 26 Nov 2019 21:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhMu4ADnQOnOcJ6BIbNumeV+R111igTahrNXaoaT2bg=;
        b=JI9vifZO/hlNlsVdVbkQAosj4wct0Y/Ey9lvPG25NoShcDsu71L11PV96pOoMZL980
         5OITy+OqvSpfCMS4dHDjs+M9mEvAXpC1wPk0vzK5SAaM6xGy2F32057VuoCjH5P0Mz5I
         ksBf/dHPnPYiBp+jVZIbJmg4T7Zr0L6frm4tgTZYPA8/Vjnhg/Lif+jKoCRmIpVec24Z
         3nRW0I5i/LWRo5q9smCmOtu9ecJtC0384AvF8Fa+hGl43nnexUQHchB5yX3mvbZS9Ope
         U6ptKcW6pV6EGCxhP/yzZs150YOd+LEMO6ovqiDy1R75y2l6o8Jw8oWjT2MA1Im1z1b8
         XYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhMu4ADnQOnOcJ6BIbNumeV+R111igTahrNXaoaT2bg=;
        b=VNj6vkzPDe2c2aqnRYSD5sUBUN2yaYtLSXY9uD3jGNejFIgk3W9Ds87ErmVGfKAXU6
         //KBTWG3Y5vQgx/YQTEytwQO9kOzZXsov3swsKJbquLYe46Ty6wRnvUyvPIo2d5/4tdt
         44/lu6ue2mLkBgpGPN9QIdd9pVk+pot+I5g9j6md1cXH0IqL0a8NeNt5+EJ6Fmb1di54
         H4vI+hv8G50T/g2UHO6wHSf46D/FRGZVaswpxkDm4iWWkZBNQRo0mI1oz93z6VaeKaD8
         lclBZrmc0rfNocJmMZkkSOvWQ+mAOHilc2sA9NKgHDTRQTASPJUK9Fos+/6j8xiGcaIE
         77+g==
X-Gm-Message-State: APjAAAWognbgcMZR6V9Os3mUDX0cxSuwqGGfsLVhT6W5qaw+5AOVs+qY
        j90JjR9cD6vx8FDlDmtspIw=
X-Google-Smtp-Source: APXvYqzVeWRQSqkKyH0MFBGH6b0eZNxA9y0WDKi5fRr/9ehuoyu+hi9MIjxq+m8LFWvRCkkg2Ut39Q==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr44293621pfn.57.1574832605993;
        Tue, 26 Nov 2019 21:30:05 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id p38sm4360825pjp.27.2019.11.26.21.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:30:05 -0800 (PST)
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
Subject: [PATCH v6 4/7] ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
Date:   Tue, 26 Nov 2019 21:29:32 -0800
Message-Id: <20191127052935.1719897-5-anarsoul@gmail.com>
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

There is just one sensor for the CPU.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index e37c30e811d3..42fd0418d678 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -177,6 +177,26 @@
 			assigned-clocks = <&ccu CLK_GPU>;
 			assigned-clock-rates = <384000000>;
 		};
+
+		ths: ths@1c25000 {
+			compatible = "allwinner,sun8i-h3-ths";
+			reg = <0x01c25000 0x400>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_BUS_THS>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <0>;
+		};
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
 	};
 };
 
@@ -234,4 +254,10 @@
 
 &sid {
 	compatible = "allwinner,sun8i-h3-sid";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	ths_calibration: thermal-sensor-calibration@34 {
+		reg = <0x34 4>;
+	};
 };
-- 
2.24.0

