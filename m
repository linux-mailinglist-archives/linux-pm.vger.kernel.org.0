Return-Path: <linux-pm+bounces-33687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54292B416D3
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 09:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573C9547825
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425B2DE71A;
	Wed,  3 Sep 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mMIes7F9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275E2DCBEB
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885021; cv=none; b=LYY5H+Y5SVnb60/1T/nt8KSWXZ4ISCR8LqGlN2hZzeNo0Hqo1ZfsHW/TtNtU08UbDxd6Teu4pi1UA00U4CGiVyLtGz6zDJLj5cpCj3iBhlCSKRO3oQhszoo8oVh1Y4+xUvCw1hco6iStb4zYHrMMr2AaFq33OqlBTmhvKnz5P90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885021; c=relaxed/simple;
	bh=wmwFnX/4LAHinkHU5D+kQBEzh05EfP1qhhvkUjlqssY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=fWWPE9KIWVzZ/APGZXPpHMpr91gXESEPCG5oSG/OCaFBilrd02um86KJzuvuDVdqVPlWreE4UKajn73+FAy1XjhzF9Iy1JR12Rigqb/tErwxO+ogomoMzLs6oQ4SE456RKF0JuBEVdQYALUkrN3eQfq1xblcXsoOdOTBV9O3PSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mMIes7F9; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250903073656epoutp02eff9613dc1dea59e661d030f719d0211~htZ0r52NR0745607456epoutp02d
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 07:36:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250903073656epoutp02eff9613dc1dea59e661d030f719d0211~htZ0r52NR0745607456epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756885016;
	bh=QbAAN8lX9u7ye0RuKSQreAcwMv69aFgIjOskci50R+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMIes7F9rdAjB76H3SySa28SbU84vno/XKn5g+DiO1CeQE3QfqQu6KMHWbp+iytH7
	 o6zkvvHeEWr2hEi6bYjH32p8aAZzobyVtNEPH+++p3ZmmUWMWaJA9wPBQUI+5Hf8KV
	 zXq/36xE1NBtMOc5Mo07VhUCx7P9udcy9IRUjF7c=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20250903073654epcas2p3edea5f547b3a2f2bda7364d5b527d50b~htZzVfbhn1134111341epcas2p3B;
	Wed,  3 Sep 2025 07:36:54 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cGvZG29Rjz3hhT8; Wed,  3 Sep
	2025 07:36:54 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250903073653epcas2p4bd8e50a6bfc1f5935ff8a01addf3d835~htZyMgjtT0220702207epcas2p4I;
	Wed,  3 Sep 2025 07:36:53 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250903073653epsmtip20b983213ee13ab91c02b90ee8dbe90c7~htZyIDTUh3057830578epsmtip2z;
	Wed,  3 Sep 2025 07:36:53 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: exynosautov920: Add tmu hardware binding
Date: Wed,  3 Sep 2025 16:36:34 +0900
Message-ID: <20250903073634.1898865-4-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903073634.1898865-1-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250903073653epcas2p4bd8e50a6bfc1f5935ff8a01addf3d835
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903073653epcas2p4bd8e50a6bfc1f5935ff8a01addf3d835
References: <20250903073634.1898865-1-shin.son@samsung.com>
	<CGME20250903073653epcas2p4bd8e50a6bfc1f5935ff8a01addf3d835@epcas2p4.samsung.com>

Create a new exynosautov920-tmu.dtsi describing new TMU hardware
and include it from exynosautov920.dtsi.

The exynosautov920-tmu node uses the misc clock as its source
and exposes two new DT properties:

- samsung,hw-sensor-indices: defines valid sensors for the bitmap

This TMU binding defines six thermal zones with a critical trip point
at 125 degrees:

tmu_top : cpucl0-0, cpucl1
tmu_sub0: cpucl0-1, cpucl2
tmu_sub1: g3d, npu

Signed-off-by: Shin Son <shin.son@samsung.com>
---
 .../boot/dts/exynos/exynosautov920-tmu.dtsi   | 97 +++++++++++++++++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi | 31 ++++++
 2 files changed, 128 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi

diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
new file mode 100644
index 000000000000..eb1864e69bef
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
@@ -0,0 +1,97 @@
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
+		cpucl0-0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 0>;
+
+			trips {
+				cpucl0_0_critical: cpucl0-0-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpucl0-1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 0>;
+
+			trips {
+				cpucl0_1_critical: cpucl0-1-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpucl1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 1>;
+
+			trips {
+				cpucl1_critical: cpucl1-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		cpucl2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub0 1>;
+
+			trips {
+				cpucl2_critical: cpucl2-critical {
+					temperature = <125000>;	/* millicelsius */
+					hysteresis = <0>;	/* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		g3d-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub1 0>;
+
+			trips {
+				g3d_critical: g3d-critical {
+					temperature = <125000>; /* millicelsius */
+					hysteresis = <0>; /* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+
+		npu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_sub1 1>;
+
+			trips {
+				npu_critical: npu-critical {
+					temperature = <125000>; /* millicelsius */
+					hysteresis = <0>; /* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
index 0fdf2062930a..642f766d4106 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
@@ -330,6 +330,36 @@ watchdog_cl1: watchdog@10070000 {
 			samsung,cluster-index = <1>;
 		};
 
+		tmu_top: tmu@100a0000 {
+			compatible = "samsung,exynosautov920-tmu";
+			reg = <0x100A0000 0x1000>;
+			interrupts = <GIC_SPI 951 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+			clocks = <&cmu_misc CLK_DOUT_MISC_NOCP>;
+			clock-names = "tmu_apbif";
+			samsung,hw-sensor-indices = <1 2 3 4 5 6 7 8 9 10 11 12>;
+		};
+
+		tmu_sub0: tmu@100b0000 {
+			compatible = "samsung,exynosautov920-tmu";
+			reg = <0x100B0000 0x1000>;
+			interrupts = <GIC_SPI 950 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+			clocks = <&cmu_misc CLK_DOUT_MISC_NOCP>;
+			clock-names = "tmu_apbif";
+			samsung,hw-sensor-indices = <3 4 5 6 7 8 9 10>;
+		};
+
+		tmu_sub1: tmu@100c0000 {
+			compatible = "samsung,exynosautov920-tmu";
+			reg = <0x100C0000 0x1000>;
+			interrupts = <GIC_SPI 949 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+			clocks = <&cmu_misc CLK_DOUT_MISC_NOCP>;
+			clock-names = "tmu_apbif";
+			samsung,hw-sensor-indices = <1 2 3 4 6 7>;
+		};
+
 		gic: interrupt-controller@10400000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
@@ -1507,3 +1537,4 @@ timer {
 };
 
 #include "exynosautov920-pinctrl.dtsi"
+#include "exynosautov920-tmu.dtsi"
-- 
2.50.1


