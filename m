Return-Path: <linux-pm+bounces-6685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFA28A9ED8
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905171C22373
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89716F29F;
	Thu, 18 Apr 2024 15:44:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE604165FD9;
	Thu, 18 Apr 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455079; cv=none; b=Czo9FaNjqpzNy/PDcgIt3VIeb9QZbdGH8GE3GkVS+8qmoXP/BP6mIh3fRruxr54abrDP1Yes6yHm6i6PQH6LJb73ucfdqR53FOSAW45bI7zS4rLrIwCcJ3b0U7+PgwtQd48XlOjLR1UYEf3nZhwi2OwBMkLkYR4+MQeH+VjPi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455079; c=relaxed/simple;
	bh=d3jnjFgGmqsrKePcKsF2whgGP5L7COSbvGMRg/7CecI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GL3drTRYTbScsFKv6ux0gOrwMngkqnUovOJdgrf1YYvjYMJFr2NLfTGVYunaeMbMA26Eb25y+u7dJ3M/5ysKuFNJTAE5B9KydDiu4+6jGHr1I5QxhmwS2AXoGy0p9zSrGOD6nedEgKNe45fzgdnc2R+42vW/xXM433A6XQevVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A1351042;
	Thu, 18 Apr 2024 08:45:05 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4F93F738;
	Thu, 18 Apr 2024 08:44:34 -0700 (PDT)
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
Subject: [PATCH v5 7/8] arm64: dts: allwinner: h616: Add CPU OPPs table
Date: Thu, 18 Apr 2024 16:44:07 +0100
Message-Id: <20240418154408.1740047-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418154408.1740047-1-andre.przywara@arm.com>
References: <20240418154408.1740047-1-andre.przywara@arm.com>
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
The values were taken from the BSP sources. There is a separate OPP set
seen on some H700 devices, but they didn't really work out in testing, so
they are not included for now.

Also add the needed cpu_speed_grade nvmem cell and the cooling cells
properties, to enable passive cooling.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
[Andre: rework to minimise opp-microvolt properties]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 115 ++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |   8 ++
 2 files changed, 123 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
new file mode 100644
index 0000000000000..aca22a7f0191c
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
@@ -0,0 +1,115 @@
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
+			opp-supported-hw = <0x1f>;
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
+			opp-supported-hw = <0x0d>;
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
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt-speed0 = <1000000>;
+			opp-microvolt-speed2 = <1000000>;
+			opp-microvolt-speed3 = <1000000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x0d>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-speed0 = <1050000>;
+			opp-microvolt-speed1 = <1020000>;
+			opp-microvolt-speed2 = <1050000>;
+			opp-microvolt-speed3 = <1050000>;
+			opp-microvolt-speed4 = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1f>;
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
+			opp-supported-hw = <0x0d>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt-speed1 = <1100000>;
+			opp-microvolt-speed3 = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x0a>;
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
index a061b69c07c2c..670e267db713a 100644
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
2.25.1


