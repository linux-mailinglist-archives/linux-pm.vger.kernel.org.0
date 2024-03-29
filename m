Return-Path: <linux-pm+bounces-5683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CC4891FC8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 16:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526A21F2EF66
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69C1482EC;
	Fri, 29 Mar 2024 14:13:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D042147C8B;
	Fri, 29 Mar 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721636; cv=none; b=NQO91ubvaEwVCeCWmn4UkFGBjrw5PAIymYyZ2RXajD25w5NMzxgFStrIW4I33yL1MGNWw+3jZLqbzaOJoQn1rATwL77kN7zDC8/L2/qZ4k2XfxxPToefFd5oXCoRw+1SUdB+jJWKzBn+DW+SH0Uwt3kJQKRQ/uBd0DjoPt/LAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721636; c=relaxed/simple;
	bh=ZppV+1dZfFfssbDNMqb+eUnarKSe+iJNHu62CYhG5Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DtrzvzpQS0L/fUrmB+aV+BbaBuvCZFgCVp4w9UbhATPQfx65itq/T68Sxu23f4CXf89RKllkK7572ypC+1eQj2VgCkJkLrJAmG2CgUQYvwM/kjMEhlEqudaV+3CakyzIL14jLI63qLHkkmxNNxRALsXx2YGRJNugWdltpGN1le4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF31812FC;
	Fri, 29 Mar 2024 07:14:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDBB63F64C;
	Fri, 29 Mar 2024 07:13:50 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v4 7/8] arm64: dts: allwinner: h616: Add CPU OPPs table
Date: Fri, 29 Mar 2024 14:13:10 +0000
Message-Id: <20240329141311.27158-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240329141311.27158-1-andre.przywara@arm.com>
References: <20240329141311.27158-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Botka <martin.botka@somainline.org>

Add an Operating Performance Points table for the CPU cores to enable
Dynamic Voltage & Frequency Scaling (DVFS) on the H616.
The values were taken from the BSP sources. The (newer) H700 chips we
have seen seem to use a separate speed bin, its OPP values were taken
from a live system and added to the mix.

Also add the needed cpu_speed_grade nvmem cell and the cooling cells
properties, to enable passive cooling.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
[Andre: rework to minimise opp-microvolt properties]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 125 ++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |   8 ++
 2 files changed, 133 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
new file mode 100644
index 0000000000000..6073fdf672592
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2023 Martin Botka <martin@somainline.org>
+
+/ {
+	cpu_opp_table: opp-table-cpu {
+		compatible = "allwinner,sun50i-h616-operating-points";
+		nvmem-cells = <&cpu_speed_grade>;
+		opp-shared;
+
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x3f>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x12>;
+		};
+
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x2d>;
+		};
+
+		opp-792000000 {
+			opp-hz = /bits/ 64 <792000000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed4 = <940000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x12>;
+		};
+
+		opp-936000000 {
+			opp-hz = /bits/ 64 <936000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x0d>;
+		};
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt-speed0 = <950000>;
+			opp-microvolt-speed1 = <940000>;
+			opp-microvolt-speed2 = <950000>;
+			opp-microvolt-speed3 = <950000>;
+			opp-microvolt-speed4 = <1020000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1f>;
+		};
+
+		opp-10320000 {
+			opp-hz = /bits/ 64 <1032000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x20>;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt-speed0 = <1000000>;
+			opp-microvolt-speed2 = <1000000>;
+			opp-microvolt-speed3 = <1000000>;
+			opp-microvolt-speed5 = <950000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x2d>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-speed0 = <1050000>;
+			opp-microvolt-speed1 = <1020000>;
+			opp-microvolt-speed2 = <1050000>;
+			opp-microvolt-speed3 = <1050000>;
+			opp-microvolt-speed4 = <1100000>;
+			opp-microvolt-speed5 = <1020000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x3f>;
+		};
+
+		opp-1320000000 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1d>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x2d>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt-speed1 = <1100000>;
+			opp-microvolt-speed3 = <1100000>;
+			opp-microvolt-speed5 = <1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x2a>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index b2e85e52d1a12..c0fa466fa9f07 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -26,6 +26,7 @@ cpu0: cpu@0 {
 			reg = <0>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -34,6 +35,7 @@ cpu1: cpu@1 {
 			reg = <1>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -42,6 +44,7 @@ cpu2: cpu@2 {
 			reg = <2>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -50,6 +53,7 @@ cpu3: cpu@3 {
 			reg = <3>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -156,6 +160,10 @@ sid: efuse@3006000 {
 			ths_calibration: thermal-sensor-calibration@14 {
 				reg = <0x14 0x8>;
 			};
+
+			cpu_speed_grade: cpu-speed-grade@0 {
+				reg = <0x0 2>;
+			};
 		};
 
 		watchdog: watchdog@30090a0 {
-- 
2.35.8


