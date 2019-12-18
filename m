Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF239123E74
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 05:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLREV4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 23:21:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51761 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLREVb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 23:21:31 -0500
Received: by mail-pj1-f67.google.com with SMTP id j11so261157pjs.1;
        Tue, 17 Dec 2019 20:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KISpMLvHz5xVmytt7DhjjbLP2haRM0PkAgFQCpHv2Bk=;
        b=D1O/XNqoZhFSe6At2GFzjWOZQKji8mS7q/uJADGXW995QW5W2bfDqAXNwrYFLBhuRt
         343GJ/jorl3lNoubrrzmfImFh5JpQmV3N+71pM3lYojO0m8xk/UfFLgyWPz9sSYm+fJB
         SZOpEeepYh3xl+sdOjJMSEiYg3auyD0gk9gqauTTSCMMR3lj303Ir7MNV3AUSf3Uh5Y+
         nrW9WLfMc1ebVi/3CZ7mMeb/0LISiLaiwgnh/4pBlWOPEDktcpeBJAfRN1sn/v0uc3Lo
         1UGEM7heCM+nIaFDJoI0HjvV3zjnvx+UFtZ1kryhe3eQdSdZ9fftYDk1uTYDHKJiK+E8
         Otdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KISpMLvHz5xVmytt7DhjjbLP2haRM0PkAgFQCpHv2Bk=;
        b=U0dgJGdFlwhES3gZgTFiaYlll7PPtUqELlapLUKzFmbEJannYFQAmDEe+T/E0MAzMN
         LPpHBLnAGQLFmgbJ0M9GXSIka9Tk5cmOwlr8KNc2hh7RTmhMteIKG/ZpPLxzxUz45s+C
         eQzN1jb5WpW6Ugq9Bf3vtwAy3er8mAPCPPsQvbz+SHmrdPN8d6slYqxX0pWCVU2sm4M+
         J5CvL3N9BO6YmhWTaM2OUbgUP2sl7xVndnQ39PEVaWVaPmX/ptI503EP3fCSf8zizTqv
         WdjgZNY9etFt6YzukMLPHDs6J3i7lhoIWFuWJwoloT8sagrW6bE+xFAjzIj/6Y5IpRtM
         dq9w==
X-Gm-Message-State: APjAAAWT15C/42IaP140JpON88QgFe7cygFCU4pptvFiqA+zQsJkaAqe
        Uxg+oYYIAYfU6ok1DVpSgjY=
X-Google-Smtp-Source: APXvYqxpQXSaBHFKvE0AQvKbWCbghFwFtWjDzqLzbpP3qGi8vq787Tb9uoBWWTtqPEr3U1c4cXYsjQ==
X-Received: by 2002:a17:90a:ec0f:: with SMTP id l15mr276822pjy.39.1576642890876;
        Tue, 17 Dec 2019 20:21:30 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id g17sm775380pfb.180.2019.12.17.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:21:30 -0800 (PST)
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
Subject: [PATCH v7 3/7] ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
Date:   Tue, 17 Dec 2019 20:21:17 -0800
Message-Id: <20191218042121.1471954-4-anarsoul@gmail.com>
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

