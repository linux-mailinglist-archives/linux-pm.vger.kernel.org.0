Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C4F126817
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfLSR3G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:29:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44557 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfLSR2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:28:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id 195so2774097pfw.11;
        Thu, 19 Dec 2019 09:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KISpMLvHz5xVmytt7DhjjbLP2haRM0PkAgFQCpHv2Bk=;
        b=nFtibl5RU+x9j9Hq0TOVcdOAQ92sq7sVY9FDyJbqe0mba7+DJ8o/SMcCb/6ER0s2bo
         tKD1GRsCCkef81g/qyxVU23pdT6lEQ+cARXRKHfu9oHs2pQSpB327YxW/Ux/01QLeBUO
         vchOn/sOHhH7b5O2eu0Xan6AO/8yCJUgZGIKZSu8Naubpl5m09XTPZQcpPZULeTibpY3
         qM5ORWcFWEuDcuhmjL7I2vrVUp6KzDgX3YnVzR9meVxzqQLaM1Am71LQbMNR4AkP4Efs
         DQyGcsHfPmi5hoWZEjVtG3xEIUS0VAGeYo/mZM6rG6hsuJUbwrIW2WfF7euR2TO/v7tZ
         TR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KISpMLvHz5xVmytt7DhjjbLP2haRM0PkAgFQCpHv2Bk=;
        b=UWZ6XZdpHUgRhaCdEb4puCxggG7eGfInAejofREUTOl9be7BU2ZqBwpVwVTi+6h/nL
         SRpdzwkVe6CKeK3F0qEqq+Z0EaLN9X4f6LBlWoGoWshbdhvdKI5u0Wrdr8ZsV1+rrq/5
         xvoeB/l7OYtRg9rvV/Wip3nlaWLwY+fUo+uaB5StB8tcaZ1YeuYL9fLLqKkP+md94s5f
         LJdlGUSvpCO8l5Jyvji984kQvdkKUH7FtDkebSTEUTcr3/zvm0dpHNLkWjy4ClGWtxBd
         i4pdtd/Kw+srQR6PofjNXXrKyUNKCxcPsjVemDQfirHwTD81QmieS0ZiG+tKq0Dxlk1X
         6p2Q==
X-Gm-Message-State: APjAAAUKhMiQ3jpy0xbq/hUdsIjnqBUPd/Yf5cvE3f5lw2a9DA2xxg38
        42zkypUcRTTNr7sTQ4A1O1c=
X-Google-Smtp-Source: APXvYqzK6gGkt5I0FcQEWOCwDvdo44z01s61+lkF2gcVccoqFSE7MChiFt+vUdKPpanp9u+uJTfsqw==
X-Received: by 2002:aa7:9816:: with SMTP id e22mr11077760pfl.229.1576776516713;
        Thu, 19 Dec 2019 09:28:36 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v143sm536209pfc.71.2019.12.19.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:28:36 -0800 (PST)
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
Subject: [PATCH v8 3/7] ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
Date:   Thu, 19 Dec 2019 09:28:19 -0800
Message-Id: <20191219172823.1652600-4-anarsoul@gmail.com>
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

There are three sensors, two for each CPU cluster, one for GPU.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 53c38deb8a08..93a6df11cb18 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -50,6 +50,7 @@
 #include <dt-bindings/reset/sun8i-a83t-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun8i-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -581,6 +582,12 @@ mmc2: mmc@1c11000 {
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
 
 		crypto: crypto@1c15000 {
@@ -1165,5 +1172,34 @@ r_rsb: rsb@1f03400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		ths: thermal-sensor@1f04000 {
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
2.24.1

