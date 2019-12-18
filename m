Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54B9123E6A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 05:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLREVd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 23:21:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35586 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfLREVc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 23:21:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so537940pgk.2;
        Tue, 17 Dec 2019 20:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PkNqtr4xDaqPvN6Vsjd/SlEQaI+42QLqvwGVf2EVSjU=;
        b=oDxvUotxmEnupXyRIMaKZb9E3c2EvhpTe0MkxDhUYMbTrig9phgJLAXLjKVoPr57GD
         QOVpKPOFlxOBxc1+Nzn5n7tQtmzSiQwpBNxCbmNOC8GVdrp5McZBQbtJoOpQ0/7NPROz
         Fv1POekWpX8Np2TcRBtsDRA3ohyQA6lPJemVWtsnSqk5ilvOrME0rniXZPXoYMoZeBO6
         C9epm3/dwt7YlCEl5KxY2zxnrD5NkW0YuEsHwJ6WCIm0LKg26l6cIIj3QqFTisDNrWvu
         2O3OcLCKd+LPlNPaKdjznGI+Q5sD31Sz1itjaOvnwHerMHQXGjP/8YmLDQYUxzaiDbvi
         ouMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkNqtr4xDaqPvN6Vsjd/SlEQaI+42QLqvwGVf2EVSjU=;
        b=eIkSBGnMNmous5i2hEVzMm0yLc+5jFXh8vDB9GgXxtLLlZNsEeLGxKBzQfQ1bgTjtN
         4BCad/gI9qjeXnymnUVE+zOGzczcNZXgH40wX0McR9tbBUgmdPTdyYz4b4LixGnsiHAI
         peBIjrjrmcqYWhIOIggJ3Y2pCNR4svQc/AgOBkkmRqreKNlXj8zG56hPC4771v8iIdsX
         5o2mkjl+729++teaY6Oe8FQKdu8pAsnZQvYNEhx0+urxew/mOnrpHQGs31eNlc5OBtN4
         A2DFQrGhxmzyxw/uQfudZPIlWyeAI9Hjev/priVMevkUKDXJhromH3zhVoy3kZxLVf8n
         fAPQ==
X-Gm-Message-State: APjAAAXwqQ6YfFJ0VbFfgNdN+6jM7mHwNcSWtGbcnaVw8BlDagwCo4Dn
        CnLbdAnDabTQ/lL9RGbICZzJiCo6ihw=
X-Google-Smtp-Source: APXvYqyaLIhC1zlYgDPB3PJwRcp6N6iXGD7adEnC/8FzIjMzlcznWf5ZIojHmwGv0rifSIQZS00k9w==
X-Received: by 2002:a63:504f:: with SMTP id q15mr636016pgl.8.1576642891885;
        Tue, 17 Dec 2019 20:21:31 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id g17sm775380pfb.180.2019.12.17.20.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:21:31 -0800 (PST)
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
Subject: [PATCH v7 4/7] ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
Date:   Tue, 17 Dec 2019 20:21:18 -0800
Message-Id: <20191218042121.1471954-5-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218042121.1471954-1-anarsoul@gmail.com>
References: <20191218042121.1471954-1-anarsoul@gmail.com>
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

