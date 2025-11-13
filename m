Return-Path: <linux-pm+bounces-37911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FBEC55F4B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 07:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BC7A4E30BA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FEA32252E;
	Thu, 13 Nov 2025 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KOUexU7/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327013233E8
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016055; cv=none; b=RsWoXeTBcKmkvsvgQjnQNdBQ2Nsx0k9SLh5G39+bAOoyjmVgwBwmvrP1jm3gqS7fWi6X61Cj9qdHMutLM6RCQN2OoNt6nENgJHFgNqIangCaF2+mBwdbYm5bPmeUYrHpSfEwikW52wy+o/n/tD/FouJLvoZU5KhOrpQ+syvz/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016055; c=relaxed/simple;
	bh=eTitH3sxBoDaItmzDu6SIR3IkqzEw5Ru6ivPesHhW6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=GtJDCHOQK4c4p7hQ+y+exFMgFfzaeDWYxlcQEEThYBVAlcdYwnwUMLZ9HbHmnXjpyvpAze3BrwFmq7iReBuH5eFb/134LfeQ6lAcXy5VRwGXF9Kf7RyInuzQxWuEbPlAzYMB0PvrjSdoWFUo1rPi+duMWH8ZNXGiYyFIGrBkdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KOUexU7/; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251113064051epoutp03793ef691007ddc52e7e9a45ea3acfd6e~3fcIEThOV0265902659epoutp03B
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:40:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251113064051epoutp03793ef691007ddc52e7e9a45ea3acfd6e~3fcIEThOV0265902659epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763016051;
	bh=Cj5WcnpC6VXVJQMWzMDepRZ3rmr4nIs6MtyZFP6Agoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOUexU7/LH7gMbxnGsUAHrN0VhOmHfKGnznZPxQ1VhqvL/BHmisI1lKiVwz8K4tkM
	 i1Jip6xEY7vgFb0yjUhJaeSpZXFuveYEcS+K1yrdBzsBCCmXWSTTiuYgtOOsreMzKa
	 +Ri2ILLWnYdrw+ebowrx6V5GqCanlOKCHIBZZf9o=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20251113064050epcas2p3cd42bc0aa11291347d38af6f8899b32f~3fcHdz--h1139111391epcas2p3S;
	Thu, 13 Nov 2025 06:40:50 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.203]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4d6Vyp2wzkz6B9m7; Thu, 13 Nov
	2025 06:40:50 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20251113064049epcas2p2194df7393ea60912eec18077bbddf637~3fcGSpbyE1513415134epcas2p2_;
	Thu, 13 Nov 2025 06:40:49 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113064049epsmtip2faeabf7d30c2a5e75b52971a6d4173b1~3fcGMfose0165401654epsmtip2i;
	Thu, 13 Nov 2025 06:40:49 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Henrik Grimler <henrik@grimler.se>, Shin Son <shin.son@samsung.com>,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 RESEND 3/3] arm64: dts: exynosautov920: Add multiple
 sensors
Date: Thu, 13 Nov 2025 15:40:22 +0900
Message-ID: <20251113064022.2701578-4-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113064022.2701578-1-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113064049epcas2p2194df7393ea60912eec18077bbddf637
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113064049epcas2p2194df7393ea60912eec18077bbddf637
References: <20251113064022.2701578-1-shin.son@samsung.com>
	<CGME20251113064049epcas2p2194df7393ea60912eec18077bbddf637@epcas2p2.samsung.com>

Create a new exynosautov920-tmu.dtsi describing new TMU hardware
and include it from exynosautov920.dtsi.

The exynosautov920-tmu node uses the misc clock as its source.

This TMU binding defines multiple thermal zones with a critical trip point
at 125 degrees:

tmu_top : cpus0-0, cpus0-1, cpus0-2, cpus0-3,
          cpus1-0, cpus1-1, cpus1-2, cpus1-3,
	  cpus1-4, cpus1-5, cpus1-6, cpus1-7

tmu_sub0: cpus0-4, cpus0-5, cpus0-6, cpus0-7,
          cpus2-0, cpus2-1, cpus2-2, cpus2-3

tmu_sub1: gpu0, gpu1, gpu2, gpu3, npu0, npu1

Signed-off-by: Shin Son <shin.son@samsung.com>
---
 .../boot/dts/exynos/exynosautov920-tmu.dtsi   | 377 ++++++++++++++++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  31 ++
 2 files changed, 408 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi

diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
new file mode 100644
index 000000000000..641d142e0eeb
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's ExynosAuto920 TMU configurations device tree source
+ *
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *
+ * Samsung's ExynosAuto920 SoC TMU(Thermal Managemenut Unit) are listed as
+ * device tree nodes in this file.
+ */
+
+/ {
+	thermal-zones {
+		cpus0-0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 9>;
+
+			trips {
+				cpus0_0_critical: cpus0-0-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus0-1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 10>;
+
+			trips {
+				cpus0_1_critical: cpus0-1-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus0-2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 11>;
+
+			trips {
+				cpus0_2_critical: cpus0-2-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus0-3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 12>;
+
+			trips {
+				cpus0_3_critical: cpus0-3-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus0-4-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 7>;
+
+			trips {
+				cpus0_4_critical: cpus0-4-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus0-5-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 8>;
+
+			trips {
+				cpus0_5_critical: cpus0-5-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus0-6-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 9>;
+
+			trips {
+				cpus0_6_critical: cpus0-6-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus0-7-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 10>;
+
+			trips {
+				cpus0_7_critical: cpus0-7-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus1-0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 1>;
+
+			trips {
+				cpus1_0_critical: cpus1-0-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus1-1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 2>;
+
+			trips {
+				cpus1_1_critical: cpus1-1-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus1-2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 3>;
+
+			trips {
+				cpus1_2_critical: cpus1-2-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus1-3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 4>;
+
+			trips {
+				cpus1_3_critical: cpus1-3-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus1-4-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 5>;
+
+			trips {
+				cpus1_4_critical: cpus1-4-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus1-5-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 6>;
+
+			trips {
+				cpus1_5_critical: cpus1-5-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus1-6-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 7>;
+
+			trips {
+				cpus1_6_critical: cpus1-6-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus1-7-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 8>;
+
+			trips {
+				cpus1_7_critical: cpus1-7-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus2-0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 3>;
+
+			trips {
+				cpus2_0_critical: cpus2-0-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus2-1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 4>;
+
+			trips {
+				cpus2_1_critical: cpus2-1-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus2-2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 5>;
+
+			trips {
+				cpus2_2_critical: cpus2-2-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpus2-3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 6>;
+
+			trips {
+				cpus2_3_critical: cpus2-3-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		gpu0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub1 1>;
+
+			trips {
+				gpu0_critical: gpu0-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		gpu1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub1 2>;
+
+			trips {
+				gpu1_critical: gpu1-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		gpu2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub1 3>;
+
+			trips {
+				gpu2_critical: gpu2-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		gpu3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub1 4>;
+
+			trips {
+				gpu3_critical: gpu3-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		npu0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub1 6>;
+
+			trips {
+				npu0_critical: npu0-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		npu1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub1 7>;
+
+			trips {
+				npu1_critical: npu1-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
index 6ee74d260776..e52f4abb0eb3 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
@@ -330,6 +330,36 @@ watchdog_cl1: watchdog@10070000 {
 			samsung,cluster-index = <1>;
 		};
 
+		tmu_top: tmu@100a0000 {
+			compatible = "samsung,exynosautov920-tmu";
+			reg = <0x100a0000 0x1000>;
+			interrupts = <GIC_SPI 951 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+			clocks = <&cmu_misc CLK_DOUT_MISC_NOCP>;
+			clock-names = "tmu_apbif";
+			samsung,sensors = <12>;
+		};
+
+		tmu_sub0: tmu@100b0000 {
+			compatible = "samsung,exynosautov920-tmu";
+			reg = <0x100b0000 0x1000>;
+			interrupts = <GIC_SPI 950 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+			clocks = <&cmu_misc CLK_DOUT_MISC_NOCP>;
+			clock-names = "tmu_apbif";
+			samsung,sensors = <10>;
+		};
+
+		tmu_sub1: tmu@100c0000 {
+			compatible = "samsung,exynosautov920-tmu";
+			reg = <0x100c0000 0x1000>;
+			interrupts = <GIC_SPI 949 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+			clocks = <&cmu_misc CLK_DOUT_MISC_NOCP>;
+			clock-names = "tmu_apbif";
+			samsung,sensors = <7>;
+		};
+
 		gic: interrupt-controller@10400000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
@@ -1533,3 +1563,4 @@ timer {
 };
 
 #include "exynosautov920-pinctrl.dtsi"
+#include "exynosautov920-tmu.dtsi"
-- 
2.50.1


