Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5091A1267FF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLSR2k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:28:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47053 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfLSR2i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:28:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so3452699pgb.13;
        Thu, 19 Dec 2019 09:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PkNqtr4xDaqPvN6Vsjd/SlEQaI+42QLqvwGVf2EVSjU=;
        b=A8WKkHjgMjO9lYnzetKkZVflOAc4LP08kIWqHRxOM86qXG7wzpd5ylfGwqBY3rTTtp
         XP8dNkC1cDopPzttDX7A+W+JaEhHDfnT9DhjE5EWa6JwrUDO1P9TIwW4Z0NbkbYFdfsP
         L3rOtzqHFgx1NPUo0h1mV3aoE4ZsJzesUIXVWR8tx3meyyu5le64yu2xjjWB2soI/pQn
         xqwwBVscx7C1W7s7/5LQ/wrG4B0JG47P/7Yn3HI3EpI2EY3MzwBgHZ0Zf5N8FO/t/ZbD
         HZXjRgkjJ6tH/svSMp4XlVVrEnloOwhA2Oco59k9F9F9V7he/qf9zMsjdkhXaxEU+X9J
         BWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkNqtr4xDaqPvN6Vsjd/SlEQaI+42QLqvwGVf2EVSjU=;
        b=YFXdB/CFxlzv2jjS/5jzYarv+TDuoLPuXinKBo7jaCllwWtej+aDftLaxOi9OQ0wSc
         nPo1PJypimXeRDoDJRWmVHJhtAugfAkyC5Q3if4V57S4pCsMLupLT1qgnGTNmt8GrM1s
         dEUI6rkMV4HQCqfM4ShmZqrh9KOeM+L3ZTfw1ThsnW6D7DgmmGNRZGF1tVLnc1zN1MdQ
         VkiPgtzA26KhCzo7Jw2ex85De8TX7ThorHpra0BdUYd4R+fEnFEiyqdsTTO6P3HCPduB
         h30ZgatqhmsrCkuDYfX2G4CPFJVH5RZa9HohNULunT4TVxvcRLNXBFijg/weO65bZI+y
         V6JQ==
X-Gm-Message-State: APjAAAXWx296wp433RwaHJ7rkBCEpDqesmteK6pZocMcMP8w/knp1mZe
        CFkewtAGEnb7mbOr7Cd6A/0=
X-Google-Smtp-Source: APXvYqzdaGLjH+p1iK/lsf/2RbMuIf5/AaD9ZMle/RdJ1ljBPI+3ZTkZaByhMP4ycU45gLNpiIdCaA==
X-Received: by 2002:aa7:8a8b:: with SMTP id a11mr11164923pfc.207.1576776517736;
        Thu, 19 Dec 2019 09:28:37 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v143sm536209pfc.71.2019.12.19.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:28:37 -0800 (PST)
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
Subject: [PATCH v8 4/7] ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
Date:   Thu, 19 Dec 2019 09:28:20 -0800
Message-Id: <20191219172823.1652600-5-anarsoul@gmail.com>
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

There is just one sensor for the CPU.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi    | 20 ++++++++++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index fe773c72a69b..be8f601ab8cf 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -199,6 +199,26 @@ mali: gpu@1c40000 {
 			assigned-clocks = <&ccu CLK_GPU>;
 			assigned-clock-rates = <384000000>;
 		};
+
+		ths: thermal-sensor@1c25000 {
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
 
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 0afea59486c2..6e68ed831015 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -231,6 +231,12 @@ mmc2: mmc@1c11000 {
 		sid: eeprom@1c14000 {
 			/* compatible is in per SoC .dtsi file */
 			reg = <0x1c14000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@34 {
+				reg = <0x34 4>;
+			};
 		};
 
 		usb_otg: usb@1c19000 {
-- 
2.24.1

