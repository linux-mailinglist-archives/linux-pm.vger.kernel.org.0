Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4403C42C3F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502111AbfFLQ2e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 12:28:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33327 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502106AbfFLQ2e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 12:28:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so9996710pfq.0;
        Wed, 12 Jun 2019 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ucWxJ6q9SaBb2GtuoCWauKcHmhMhNM9AVCq4M27NX8=;
        b=TOsdq0zEKlm1ovsLqsofSlAHa6P17YnxyTYaU0SrWx35AJQLEaLkF0+3Vu7rnet7kS
         QxkXWuUBzC5I9Ox8e5luKErNSTypQjGJ2Q1wWrmjeitE7qA8Jvi71xrtaEX1rh4Qwc+Y
         h3wSFAIKRAqmDhfys8Bm9Yu9mIrnwNwBvtrZcam657nib4HkVXSKKjfVlbGt3aFtYFGJ
         MyXlAAGV88Qyq+89N2CFLXgheOeSe6fDhHox3L8iSsiYAy77Lx7pUWaFRD3RCZ0tarbX
         Dxl6n6xUNhXMgoht0Lghj/t1sfKCR8htND5N8NfMAgKGBNPavYBTzy3lGAZJvT27clHh
         ugtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ucWxJ6q9SaBb2GtuoCWauKcHmhMhNM9AVCq4M27NX8=;
        b=GKThGho7yNNl0yMTbduTJXshIEJZkZVCDeHNuuGxhejfznnhQS6JrIeAYHZysSP06m
         jKNzmdz7BoUI5bf1OQrXqPGoBo4kLjfSI93M1jLD9r/D2BXLtRr1lHX//JUFIh7Ty/+L
         3FFG6TQZmzf3kI91hZZ1dqIWuZ3Dhr5KnyUrQHeT7nRsVGST+ER5/LH3pI5UCS6CkK7a
         jL1aeFNrpIpqq6ydg3BY02ZS2f18XHb7AW2rOW7va7Xc2quQDMf4aBALyEvsywPUBgjV
         NIqzOWQJigYl2mQR9taUFQo6h1S7UR02qXpxlUmWzDwsjBeVYgGehJHId/FqAuQeqbmc
         wQHw==
X-Gm-Message-State: APjAAAXxjpFEg2ZifIOnvzZJXAFX1c2qGYmo06TVrhW/rVxEezpc1ABD
        Pp/JP1Fn8nGAc18++X+Zpfw=
X-Google-Smtp-Source: APXvYqx4AUVnFpEL1E+Qnsfwj4SRiJmLXGwFXB2fvIYC6OXMoah2zJ2Tiz3sgHkbW+X9oMz7oXpZhg==
X-Received: by 2002:a63:610d:: with SMTP id v13mr25531305pgb.341.1560356912884;
        Wed, 12 Jun 2019 09:28:32 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 201sm70299pfz.24.2019.06.12.09.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 09:28:32 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND, PATCH v4 2/2] dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
Date:   Wed, 12 Jun 2019 12:28:16 -0400
Message-Id: <20190612162816.31713-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190612162816.31713-1-tiny.windzz@gmail.com>
References: <20190612162816.31713-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allwinner Process Voltage Scaling Tables defines the voltage and
frequency value based on the speedbin blown in the efuse combination.
The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
provide the OPP framework with required information.
This is used to determine the voltage and frequency value for each
OPP of operating-points-v2 table when it is parsed by the OPP framework.

The "allwinner,sun50i-h6-operating-points" DT extends the
"operating-points-v2"
with following parameters:
- nvmem-cells (NVMEM area containig the speedbin information)
- opp-microvolt-<name>: voltage in micro Volts.
  At runtime, the platform can pick a <name> and matching
  opp-microvolt-<name> property.
                        HW:             <name>:
                        sun50i-h6      speed0 speed1 speed2

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
new file mode 100644
index 000000000000..7deae57a587b
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
@@ -0,0 +1,167 @@
+Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
+===================================
+
+For some SoCs, the CPU frequency subset and voltage value of each OPP
+varies based on the silicon variant in use. Allwinner Process Voltage
+Scaling Tables defines the voltage and frequency value based on the
+speedbin blown in the efuse combination. The sun50i-cpufreq-nvmem driver
+reads the efuse value from the SoC to provide the OPP framework with
+required information.
+
+Required properties:
+--------------------
+In 'cpus' nodes:
+- operating-points-v2: Phandle to the operating-points-v2 table to use.
+
+In 'operating-points-v2' table:
+- compatible: Should be
+	- 'allwinner,sun50i-h6-operating-points'.
+- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
+		efuse registers that has information about the speedbin
+		that is used to select the right frequency/voltage value
+		pair. Please refer the for nvmem-cells bindings
+		Documentation/devicetree/bindings/nvmem/nvmem.txt and
+		also examples below.
+
+In every OPP node:
+- opp-microvolt-<name>: Voltage in micro Volts.
+			At runtime, the platform can pick a <name> and
+			matching opp-microvolt-<name> property.
+			[See: opp.txt]
+			HW:		<name>:
+			sun50i-h6	speed0 speed1 speed2
+
+Example 1:
+---------
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0>;
+			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <1>;
+			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <2>;
+			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <3>;
+			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+        };
+
+        cpu_opp_table: opp_table {
+                compatible = "allwinner,sun50i-h6-operating-points";
+                nvmem-cells = <&speedbin_efuse>;
+                opp-shared;
+
+                opp@480000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <480000000>;
+
+                        opp-microvolt-speed0 = <880000>;
+                        opp-microvolt-speed1 = <820000>;
+                        opp-microvolt-speed2 = <800000>;
+                };
+
+                opp@720000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <720000000>;
+
+                        opp-microvolt-speed0 = <880000>;
+                        opp-microvolt-speed1 = <820000>;
+                        opp-microvolt-speed2 = <800000>;
+                };
+
+                opp@816000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <816000000>;
+
+                        opp-microvolt-speed0 = <880000>;
+                        opp-microvolt-speed1 = <820000>;
+                        opp-microvolt-speed2 = <800000>;
+                };
+
+                opp@888000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <888000000>;
+
+                        opp-microvolt-speed0 = <940000>;
+                        opp-microvolt-speed1 = <820000>;
+                        opp-microvolt-speed2 = <800000>;
+                };
+
+                opp@1080000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <1080000000>;
+
+                        opp-microvolt-speed0 = <1060000>;
+                        opp-microvolt-speed1 = <880000>;
+                        opp-microvolt-speed2 = <840000>;
+                };
+
+                opp@1320000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <1320000000>;
+
+                        opp-microvolt-speed0 = <1160000>;
+                        opp-microvolt-speed1 = <940000>;
+                        opp-microvolt-speed2 = <900000>;
+                };
+
+                opp@1488000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <1488000000>;
+
+                        opp-microvolt-speed0 = <1160000>;
+                        opp-microvolt-speed1 = <1000000>;
+                        opp-microvolt-speed2 = <960000>;
+                };
+        };
+....
+soc {
+....
+	sid: sid@3006000 {
+		compatible = "allwinner,sun50i-h6-sid";
+		reg = <0x03006000 0x400>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		....
+		speedbin_efuse: speed@1c {
+			reg = <0x1c 4>;
+		};
+        };
+};
-- 
2.17.0

