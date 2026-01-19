Return-Path: <linux-pm+bounces-41091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E2D3A815
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA2A83035067
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D32359710;
	Mon, 19 Jan 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmGSB0M1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DBF359F94
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824543; cv=none; b=Rc9mtwo1DC1reTXJTuB82B6lzw4HeF6SL25hHE6oDlnPKLX0fvvLFqk1wCuB+LnawR0YmudzwZeuxKx08PX0EBer6SZ+GkM15qjM61NPjG5GbbGW31y+SaAGDpITMWIhfpyLbPZJBGS9s/AHNJXuyFuzIpBn/YQpm3Cwc582Y4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824543; c=relaxed/simple;
	bh=FbDNXAgPAAbLgVJFNLv0wQaisif895tAwODlc1nDIio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0vX/b+yeDCrIB9NaH0FmOpCxrmhueChi8rq4viSzgqIYUbZban/QgzJcUaF8qoHam8i5AYHcKezf6po3/XCspU65bwl+yzUCabiCeBGFj9ixL7iAocPmHrtN56NucwJviGsmQ8Z1cN75784GVY560hFuiEPxMFLIAG6ovqKyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mmGSB0M1; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so3765432f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 04:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768824538; x=1769429338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMrVLGsKM8H03VwAW6ImvO14/hjO88Z7BKgUWYt5ZPY=;
        b=mmGSB0M1ECP8wo1fmg+I42iwRAr56gsO/wbhyPb1t+v02M2ANI1V8UOPkeZYCrXoOA
         RnnIZSLd8NFrS0Hvb/Vp7Lbw5SdOKmFRzRqFulXz36/aw++HEW+MsTL/41yXvekYqTaD
         tr4UFT47Y6GpEWUmNTQ2vbVq/ttKeunGkVgrjOiSyyf68GR1RXfaMn2pdiWe29NjCDXI
         GigNak3/u1Pq9gZO38Iq7XkgL7xUyBXZpoTltcgcnZeQbiHmBrXwhBfoMH+TzzA4hEM5
         SYPMSgGpBJXpzGu2cIYq3EC8YZ7SwVLR5hiUjQBWEQfuYGN8GYX/lMwyQ1TjbO7B/Ele
         hw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768824538; x=1769429338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cMrVLGsKM8H03VwAW6ImvO14/hjO88Z7BKgUWYt5ZPY=;
        b=HCBDazSmM5v8ndtV6xqnoTjo55QYmbRtYrPu4kMy7jzLf+g2jAA3vrkfwQWOXYlWrB
         vTY8BR8KZcg2TrESbV5qHsSPAKnDAmX1dBPWa2kyDKsnBRrQiGPxBoIzwWz4DIcA/gjA
         vMhMkPTNi3y4s1Iqeko4IdmmV/3hqwhOT8S4XnWR2ZbC2hlWeG49OZ8yw+n9WtBVcKFh
         4Rowf65iNK0VY/0pRHoSE9yqd2vL8GQkCuzif7KuoBmEp2oPHTel1u76dc0oHXIwgTFa
         PVyQCioF4MgvKhRNCFKCTE10Rdh8cjbmfzLSFD6q8/ZnJvffbu2jIYqA59jSgHK9nv32
         GYSw==
X-Forwarded-Encrypted: i=1; AJvYcCXvfe2jzKJ1pdb9iQ5yvDAQG0DsQf+owJDEKJSsNkV5/6i0QDRgWys6BTt9z7+NMvcYJAjrV1qcww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT64azuZ1/NN51hhEtJmMfarHVMOKDJpdt1i10iIaDtUQxODi6
	wTOoyXBBHD4eUCwUDssUFVaGVyYn2SSpGauAxJ3zPPGJa1HUI4FGOZ9IVHM35R3jl9M=
X-Gm-Gg: AZuq6aK0EhdzkjCB+YKyCcw1/1x2hRAZkHNNPdOgmKkKO8TWCgbxP1Vvm02EhlmJD6P
	Gayh52O9vyhcBacdpsW75K0NDYBKtHBLFnAkulqxegi6g+JGsCt5MEXSZVnUo39lQ8hiqMKe/zY
	Iviv5vhau3a2p6XWlNexvvCBldyLeQo0TTKa4UI4kCqhNDWtej9dVmKT0D0pe9uhKQlHfuafEoy
	DJOun6Dapt1XSoRfvr0e8IUq67fl+LxXhPCuvw0X4RxJLyneHbOaxfTR1v1d8pBIL9VFe59jBWn
	nhbpUPAVV4eMxzogGnd5cYrFyJQL9f4eHvS6eT07dZeykcNWjQYIcN2zrfoi8y1lAJMSQG72R+N
	3IPI7xwqvD4celE7tw64msylygIFEKXVErkypz5LfPoqFv+C/CNpb+LvAf68lWRnlf8azCuLJu8
	dAQI9KPZhFuipC2nP/Mjm2P0dwu/if0LRDR8dWiVwuVG/8xPfJgvQhhDx9KvwEgeBD7TBwUQ==
X-Received: by 2002:a05:6000:2508:b0:42f:a025:92b3 with SMTP id ffacd0b85a97d-4356997f624mr13199095f8f.2.1768824537653;
        Mon, 19 Jan 2026 04:08:57 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm20698421f8f.30.2026.01.19.04.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:08:57 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 19 Jan 2026 12:08:52 +0000
Subject: [PATCH v2 6/7] arm64: dts: exynos: gs101: Add thermal management
 unit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-acpm-tmu-v2-6-e02a834f04c6@linaro.org>
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768824532; l=8775;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=FbDNXAgPAAbLgVJFNLv0wQaisif895tAwODlc1nDIio=;
 b=qx+povYGdT0SCFv279IfjgdUWsxoqkhWF6qHZZALvaE22fhrYKhuXAxLzfU98oDlk5mXUiVBU
 t7OehfZc22vAY1BC+MzyyBUIR9n0Zis/U51nv9beTQD7+vsnuAuPZdD
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the Thermal Management Unit (TMU) support for the Google GS101 SoC.

Describe the TMU using a consolidated SoC node that includes memory
resources for interrupt identification and a phandle to the ACPM IPC
interface for functional control.

Define thermal zones for the little, mid, and big CPU clusters, including
associated trip points and cooling-device maps to enable thermal
mitigation.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi | 209 +++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi     |  18 ++
 2 files changed, 227 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..6262c3b890aa2f7ad572c32b30bf926df804ec1e
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Google GS101 TMU configurations device tree source
+ *
+ * Copyright 2020 Samsung Electronics Co., Ltd.
+ * Copyright 2020 Google LLC.
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	thermal-zones {
+		cpucl2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 0>;
+
+			trips {
+				big_cold: big-cold {
+					temperature = <20000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				big_switch_on: big-switch-on {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				big_control_temp: big-control-temp {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				big_pre_switch_on: big-pre-switch-on {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				big_alert2: big-alert2 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				big_hw_throttling: big-hw-throttling {
+					temperature = <103000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				big_pause: big-pause {
+					temperature = <108000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				big_hot: big-hot {
+					temperature = <115000>;
+					hysteresis = <3000>;
+					type = "hot";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&big_control_temp>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
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
+				mid_cold: mid-cold {
+					temperature = <20000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				mid_switch_on: mid-switch-on {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				mid_control_temp: mid-control-temp {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				mid_pre_switch_on: mid-pre-switch-on {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				mid_alert2: mid-alert2 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				mid_hw_throttling: mid-hw-throttling {
+					temperature = <98000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				mid_pause: mid-pause {
+					temperature = <108000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				mid_hot: mid-hot {
+					temperature = <115000>;
+					hysteresis = <3000>;
+					type = "hot";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+				     trip = <&mid_control_temp>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			       };
+			};
+		};
+
+		cpucl0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 2>;
+
+			trips {
+				little_cold: little-cold {
+					temperature = <20000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				little_switch_on: little-switch-on {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				little_control_temp: little-control-temp {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				little_pre_switch_on: little-pre-switch-on {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				little_alert2: little-alert2 {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				little_alert5: little-alert5 {
+					temperature = <103000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				little_alert6: little-alert6 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				little_hot: little-hot {
+					temperature = <115000>;
+					hysteresis = <3000>;
+					type = "hot";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&little_control_temp>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d085f9fb0f62ac2f57b104c20880e64d885d0bee..4b8c7edaddb6fd49e61496f2f21f348db0b58f10 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -74,6 +74,7 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0000>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -86,6 +87,7 @@ cpu1: cpu@100 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0100>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -98,6 +100,7 @@ cpu2: cpu@200 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0200>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -110,6 +113,7 @@ cpu3: cpu@300 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0300>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -122,6 +126,7 @@ cpu4: cpu@400 {
 			compatible = "arm,cortex-a76";
 			reg = <0x0400>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL1>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
@@ -134,6 +139,7 @@ cpu5: cpu@500 {
 			compatible = "arm,cortex-a76";
 			reg = <0x0500>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL1>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
@@ -146,6 +152,7 @@ cpu6: cpu@600 {
 			compatible = "arm,cortex-x1";
 			reg = <0x0600>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL2>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
@@ -158,6 +165,7 @@ cpu7: cpu@700 {
 			compatible = "arm,cortex-x1";
 			reg = <0x0700>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL2>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
@@ -639,6 +647,15 @@ watchdog_cl1: watchdog@10070000 {
 			status = "disabled";
 		};
 
+		tmu_top: thermal-sensor@100a0000 {
+			compatible = "google,gs101-tmu-top";
+			reg = <0x100a0000 0x800>;
+			clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
+			interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
+			samsung,acpm-ipc = <&acpm_ipc>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		trng: rng@10141400 {
 			compatible = "google,gs101-trng",
 				     "samsung,exynos850-trng";
@@ -1861,3 +1878,4 @@ timer {
 };
 
 #include "gs101-pinctrl.dtsi"
+#include "gs101-tmu.dtsi"

-- 
2.52.0.457.g6b5491de43-goog


