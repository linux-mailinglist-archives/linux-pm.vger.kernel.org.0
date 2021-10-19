Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E9433BB0
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJSQJK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 12:09:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50110 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhJSQJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 12:09:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19JG6quM011518;
        Tue, 19 Oct 2021 11:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634659612;
        bh=Oc4kovP/NYg0BhPcPGQz4tvGA6N0DSPOAm11vK+OoBI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IZvN/gd2jaS9uXS2TjoUVEYNIEk5GSA+/g5eD52/ffY9/tbiuw9UKydPF+s/jKxcT
         VApkHxA7Y9VTMqiqaRTckhZPMcEd8+2oIw5nw/bd0nyBtkns186Ql05EMkeeVUwyx+
         px3c+mEEa5R8uyDEqjO/7UlyWtVZzpav/TF77tx0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19JG6qQZ044089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Oct 2021 11:06:52 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Oct 2021 11:06:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Oct 2021 11:06:52 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19JG6cCq005621;
        Tue, 19 Oct 2021 11:06:49 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] arm64: dts: ti: j7200: Add VTM node
Date:   Tue, 19 Oct 2021 21:36:30 +0530
Message-ID: <20211019160631.31192-4-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019160631.31192-1-j-keerthy@ti.com>
References: <20211019160631.31192-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VTM stands for Voltage Thermal Management

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  9 ++++
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  | 45 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  4 ++
 3 files changed, 58 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 1044ec6c4b0d..2b5c570253cc 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -375,4 +375,13 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	wkup_vtm0: wkup_vtm0@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x0 0x42040000 0x0 0x350>,
+			<0x0 0x42050000 0x0 0x350>,
+			<0x0 0x43000300 0x0 0x10>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
new file mode 100644
index 000000000000..1f18f9dcd3e9
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+mcu_thermal: mcu_thermal {
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
+main_thermal: main_thermal {
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
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index b7005b803149..649d1d60f5c7 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -165,6 +165,10 @@
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3 */
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-j7200-thermal.dtsi"
+	};
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.17.1

