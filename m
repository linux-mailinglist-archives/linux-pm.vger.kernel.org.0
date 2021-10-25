Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED67439E1A
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 20:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhJYSIr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 14:08:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41226 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhJYSIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 14:08:42 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19PI6GoQ129135;
        Mon, 25 Oct 2021 13:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635185176;
        bh=mS8BVLRlIi7fwktbrsMtNlnR3R2mN79nOjRs1Jeh88s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zWILxkFkZPyydRUHLtR9F+n+DsUHljLXWtVdGs7Xm5TSP7CDr3LH9JLI4bPx15T3W
         T/3OSv4UZBJmxhQlQo6yns/heByGg7sZCF+lFJ+R88mfGugDFggzUqCMQi8NRNRCA3
         trOAoph8p79+C3DfPViGtbfSAJwNAQgBzqtr5Rk4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19PI6G8w053412
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Oct 2021 13:06:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Oct 2021 13:06:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Oct 2021 13:06:16 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19PI65CV056165;
        Mon, 25 Oct 2021 13:06:13 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] arm64: dts: ti: j721e: Add VTM node
Date:   Mon, 25 Oct 2021 23:36:01 +0530
Message-ID: <20211025180603.22290-3-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025180603.22290-1-j-keerthy@ti.com>
References: <20211025180603.22290-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VTM stands for Voltage Thermal Management

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  | 73 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  4 +
 3 files changed, 86 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index d2dceda72fe9..fafc07848f86 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -390,4 +390,13 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	wkup_vtm0: wkup_vtm0@42040000 {
+		compatible = "ti,j721e-vtm";
+		reg = <0x0 0x42040000 0x0 0x350>,
+			<0x0 0x42050000 0x0 0x350>,
+			<0x0 0x43000300 0x0 0x10>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
new file mode 100644
index 000000000000..e922042f356f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+wkup_thermal: wkup_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 0>;
+
+	trips {
+		wkup_crit: wkup_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+mpu_thermal: mpu_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 1>;
+
+	trips {
+		mpu_crit: mpu_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+c7x_thermal: c7x_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 2>;
+
+	trips {
+		c7x_crit: c7x_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+gpu_thermal: gpu_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 3>;
+
+	trips {
+		gpu_crit: gpu_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+r5f_thermal: r5f_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 4>;
+
+	trips {
+		r5f_crit: r5f_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index f0587fde147e..20e26a359aaf 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -177,6 +177,10 @@
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-j721e-thermal.dtsi"
+	};
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.17.1

