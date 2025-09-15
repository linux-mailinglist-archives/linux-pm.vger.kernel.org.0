Return-Path: <linux-pm+bounces-34618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9E4B56F36
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 06:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA01176CEA
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 04:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F923275865;
	Mon, 15 Sep 2025 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VuE9qfTH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915627510E
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757909289; cv=none; b=PPjikOEPSmw9ZiYbfM4+3pFkTEPGkvtYVFwMg5ezQkTJs1sE4K7Jx+Bm6Wl7N3QN084YuMC2crFkwSCvBC9GqU07bH8DlSFObt+0vo9tz0wr+REKYL4bxMngtTaGVtTYPRVH1kgoZPF1FOJZi/bXHH9jlcpPa7vHrghkuDqLBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757909289; c=relaxed/simple;
	bh=PepzDCc4aRELAhb/htwpqiSAvReCqdi8n2Re4PUII2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=svivl0ur9QwhVmEErvyr8NQQlL9j1TF6N4jYWPxR6KvEgmKKnJxyeFRXm8iTdBatbHoRJUkKkCJ6mLoCm0JRazpaIEbMWJvCmlF/PTTJVN1+EFPswO3/DDD7Jv7c44ryMSyqR+gdkiy0sZ1DoOtpib9FTfElofX4/JZzEflOU/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VuE9qfTH; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250915040804epoutp02ec5a83cf6cc3fc6a9e1b167d113b7a43~lWS41i3XX2160521605epoutp02d
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 04:08:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250915040804epoutp02ec5a83cf6cc3fc6a9e1b167d113b7a43~lWS41i3XX2160521605epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757909284;
	bh=z9iDTz/wz2A0UPRayCSwE5t8XOUCEYP0H7Jq8XKk9g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuE9qfTHEzVJ/dw8OvBE7tzgAPEDdepondbGEAk9+Y9pwTKoAhreV/nLcpxmV0/0X
	 vQ+7CUkJNwQlKzF+WfGPTZ0PMuCy9RprLedVaV60jbfpjbdNvjYhZidtFMvroXWdPE
	 gP6goPA8Ttx6z6Je/qUP1BQUYD/Iv57QEKtXZs64=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250915040803epcas2p169010a77ccbb2f607ebd5b66cf842c04~lWS4F3JHt3061530615epcas2p1U;
	Mon, 15 Sep 2025 04:08:03 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.68]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cQBMl1QTHz3hhT8; Mon, 15 Sep
	2025 04:08:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250915040802epcas2p3bcc88e1958bf0f6cf4133e687c54b81c~lWS23WFUv2021920219epcas2p3e;
	Mon, 15 Sep 2025 04:08:02 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250915040802epsmtip1537010430008ba658a4e6f8800088156~lWS2rovCD0246802468epsmtip1a;
	Mon, 15 Sep 2025 04:08:02 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Henrik Grimler
	<henrik@grimler.se>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: exynosautov920: Add tmu hardware binding
Date: Mon, 15 Sep 2025 13:07:15 +0900
Message-ID: <20250915040715.486733-4-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915040715.486733-1-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250915040802epcas2p3bcc88e1958bf0f6cf4133e687c54b81c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250915040802epcas2p3bcc88e1958bf0f6cf4133e687c54b81c
References: <20250915040715.486733-1-shin.son@samsung.com>
	<CGME20250915040802epcas2p3bcc88e1958bf0f6cf4133e687c54b81c@epcas2p3.samsung.com>

Create a new exynosautov920-tmu.dtsi describing new TMU hardware
and include it from exynosautov920.dtsi.

The exynosautov920-tmu node uses the misc clock as its source
and exposes new DT property:

- samsung,hw-sensor-indices: List of hardware sensor indices physically
                             connected to this TMU block.

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


