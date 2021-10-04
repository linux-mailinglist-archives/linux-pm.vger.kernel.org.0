Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43130420AEB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhJDMdk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 08:33:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56238 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhJDMdi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 08:33:38 -0400
X-Greylist: delayed 3934 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Oct 2021 08:33:38 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 194BQGWE045291;
        Mon, 4 Oct 2021 06:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633346776;
        bh=Oc4kovP/NYg0BhPcPGQz4tvGA6N0DSPOAm11vK+OoBI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ftFB3VYNmVWNT9Irir2Xn7MFRMCqGdDYksztUgGxj52u3ZjdCghqbpaVAsFAP4gRU
         m2LCCJSuhG1ArO6u6i79lDb2wcAUDtlY+uKCz/RU8fo1omFfgaZFpiITp1Av6qJUJi
         pZVlu3j/9fJAfW9MwHwimDgyyh5upsG1bOOUJLfo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 194BQGbm023276
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Oct 2021 06:26:16 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 4
 Oct 2021 06:26:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 4 Oct 2021 06:26:16 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 194BQ384065426;
        Mon, 4 Oct 2021 06:26:13 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] arm64: dts: ti: j7200: Add VTM node
Date:   Mon, 4 Oct 2021 16:55:49 +0530
Message-ID: <20211004112550.27546-4-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004112550.27546-1-j-keerthy@ti.com>
References: <20211004112550.27546-1-j-keerthy@ti.com>
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

