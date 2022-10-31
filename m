Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FBC6141BA
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 00:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJaX1i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Oct 2022 19:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJaX1c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2022 19:27:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA412AB5;
        Mon, 31 Oct 2022 16:27:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGZY092621;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=zrG9w02JnVRZZt0ciyWlc0+Fr/UocYsC+JZnx4gz+Fc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=osN2iagWhZ21t+3MnIb8dhxKrgDGu+9Ca9VXDCFimJNFuzQf9uTsN8GcP2fxzMI+Q
         igk96UIcg9kwsPuavjZCOy0Md6/x8bwbdBWlM0AK97Vg9f1ddwCpH8s5Ux6UKzqt3y
         cpvfJ9tjDS651UG7lyV4OozcVftQuwsLwM8ZBpS8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGKn115393
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGug037187;
        Mon, 31 Oct 2022 18:27:16 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 09/11] arm64: dts: ti: k3-j721e-mcu-wakeup: add VTM node
Date:   Mon, 31 Oct 2022 18:27:00 -0500
Message-ID: <20221031232702.10339-10-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3842; h=from:subject; bh=vlkzNaHkJyVHTvJvk+O1jhmqXAYXIkCfkx3XmZoRK9Y=; b=owNCWmg5MUFZJlNZmNFxbgAAa3////9dv+8s237e+nV+/1fmz486/Sb7vfd53Wq/n7Fw//2wARlo HagANAAA0BiA00NAHqGgA0A000A0NDQA0DQyADQ9Q0MgyMho9RsmkxpNlDoaNDQAYmmmgDIaMmEaMI AGhiMjJkxNGTBMRiGCA0NGQBoyAAGjQ0yABwnqGjIMmgyZAaG1DQMmnqZNMhoGgAAAAaZA09JoaGTR oaAyaaaYTEGhkNAaAAAYDa+ByTgES8s4aKeTtqslzBcbaXHuh2hcQCmDIx1sVJiEXUJqg7Go9AQ3ol KEXQQSejEPqlOpIn0vyCVMeR+DDXZ/msc8r0JBp37A7TyahD1nd3SzJ7oNOWRhAvtnpsrEQNdkqbxI KlPuAgySySIWqhWilMigMhIsdkeWpwWEjCKmiIp4szhVxd5e+t2QCpuWBM9ikv/M39DmIzacWIyRRS ADD+f71okKvwBNxor26exrOq/JCeXDegLUt8RrESgCcW5hCrpqS+WBWnqPz/plbB/SiBRhBv6f8Ryi gA+KtBMHag6cZNolnOMBC7cfTYunsCa0W69RJORCg54fuLfKUqMImIbtk47HmeAwGVhmLARADM/X48 mXUi1gwyXraGwBL9zCkuv8uVzWkFtEitXJGhvEIYeKwWBBIBrGM7HGHqk/4u5IpwoSExouLcA=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The j721e supports a single Voltage and Thermal Management (VTM) module
located in the wakeup domain with five associated temperature monitors
located in various hot spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  | 75 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  3 +
 3 files changed, 87 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index df08724bbf1c5..9a09f66c51c01 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -418,4 +418,13 @@ mcu_mcan1: can@40568000 {
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 	};
+
+	vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j721e-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+		      <0x00 0x42050000 0x00 0x350>,
+		      <0x00 0x43000300 0x00 0x10>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
new file mode 100644
index 0000000000000..79641927a9092
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	wkup_thermal: wkup-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 0>;
+
+		trips {
+			wkup_crit: wkup-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	mpu_thermal: mpu-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 1>;
+
+		trips {
+			mpu_crit: mpu-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	c7x_thermal: c7x-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 2>;
+
+		trips {
+			c7x_crit: c7x-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	gpu_thermal: gpu-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 3>;
+
+		trips {
+			gpu_crit: gpu-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	r5f_thermal: r5f-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 4>;
+
+		trips {
+			r5f_crit: r5f-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 0e23886c9fd1d..cfab10e2455c4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -181,6 +181,9 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
 		};
 	};
+
+	#include "k3-j721e-thermal.dtsi"
+
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.38.1

