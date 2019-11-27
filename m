Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC77F10AA2E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 06:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfK0FaG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 00:30:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41347 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfK0FaF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 00:30:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id l26so60549pgb.8;
        Tue, 26 Nov 2019 21:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irJ5JXDAAWtDIqC+IX6BV3MY5DktCoDeX+ljdjsD0XI=;
        b=mhEmJx9hcwu5d1h9HTaGxnILMXdc/7kSoKUUBfqVL0r1k5OXwgnv8wBTxtEFm7Osky
         BFg1rZoQso8y0b6302pp7BaU6+l+veKvr2d2k2iM9ye60J0mT9tzXyyvA0jRbtNO2KzX
         lOq5tGLsjneCg9GQMW/nq6V5gV7PSiMxUD0S2YbTNYlq5pZ+mCIMmN+GQPRZdXawACG0
         St975uAtwxmbBvx8FfOv9jB0VDJXxkgm+CeqXCFg+Klenk6sTyMuIFK/ADzAwSy0H6bG
         CFgWgJacIFBmfjca5oLZD5f4LJyyKsjICugTWvcXlMJPGHkJ33kkPALH0jtrNDtwIcPz
         YEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irJ5JXDAAWtDIqC+IX6BV3MY5DktCoDeX+ljdjsD0XI=;
        b=HfasC3yCll+lZTH537H9OtK5cheipYXWDEL8snloZPFZ2um8QnTKJYTVKWpe6XCtt9
         F/BagAjKPS5F2akhIhEDcVHXaICByQT4WrP+94aQZGMwlkVFWwRDilW8cmpg07VuraO/
         59vuFWd7vbyynU2Lh7ZH97XVWfcY8ze3iIGJJ2kMsZSYQJNjrq5CTvU+92Av0GPpR7ae
         Lx6YNs7bowqyPTJw/TGL3F3hk8aTpEdEOpMIpMkADSXYrr/CFsf0i4Fs5VO3Y+utmKeh
         O80WMrSANj/y6Rx9EtRwD6t6ggJTC+ccI4rHJ/Ly1Gjd/BG8Od9oWmq2pCj4D1FFooki
         WVNg==
X-Gm-Message-State: APjAAAW1GJecPZsAdWNZ5Xn501jC7Rv+RrCciGQUOqL+MRyRcnB8zflH
        EhRstXcefj7tqDl3G2AQ/So=
X-Google-Smtp-Source: APXvYqz8sVivaA2EbLiosDrKvBFKz+ssRSlkYw2TUmhAhOCKERRFiVZSgC2YBw7AstdoX0IbBoWQPg==
X-Received: by 2002:a63:2b51:: with SMTP id r78mr2801429pgr.4.1574832605006;
        Tue, 26 Nov 2019 21:30:05 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id p38sm4360825pjp.27.2019.11.26.21.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:30:04 -0800 (PST)
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
Subject: [PATCH v6 3/7] ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
Date:   Tue, 26 Nov 2019 21:29:31 -0800
Message-Id: <20191127052935.1719897-4-anarsoul@gmail.com>
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

There are three sensors, two for each CPU cluster, one for GPU.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 74bb053cf23c..902fee8be688 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -50,6 +50,7 @@
 #include <dt-bindings/reset/sun8i-a83t-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun8i-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -581,6 +582,12 @@
 		sid: eeprom@1c14000 {
 			compatible = "allwinner,sun8i-a83t-sid";
 			reg = <0x1c14000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@34 {
+				reg = <0x34 8>;
+			};
 		};
 
 		usb_otg: usb@1c19000 {
@@ -1156,5 +1163,34 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		ths: ths@1f04000 {
+			compatible = "allwinner,sun8i-a83t-ths";
+			reg = <0x01f04000 0x100>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
+
+		cpu1_thermal: cpu1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 1>;
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 2>;
+		};
 	};
 };
-- 
2.24.0

