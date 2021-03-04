Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A3532CC6E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 07:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhCDGKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 01:10:02 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2997 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhCDGJi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 01:09:38 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604079540004>; Wed, 03 Mar 2021 22:08:21 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 06:08:20 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:20 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <daniel.lezcano@linaro.org>,
        <robh+dt@kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v1 5/5] arm64: dts: tegra194: Add CPU idle states
Date:   Wed, 3 Mar 2021 22:08:12 -0800
Message-ID: <1614838092-30398-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614838101; bh=RzsRJmF/fyXlMNdfcnWNDfADO93LDhVHrFuKPCvUYIY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=AnvZFBIIXacAaimPcUM/bxF8QJBfikH/qg3ymiHv6yiRdkcDIqzbGM+rWJ/9T9mD0
         8O921BI+nIfkbf+qhLilZeW9/97Iwp/rHu8zQQzTmBdREUSzcVlySlrKjdSHau0h++
         Rxt7STuDiIJK1J+U9xdsU9UBVtg6liBr78m6MhY3OfLZu/WCPBBbjveKqeZIz6agSH
         mK/g4U3E2MnXeda/U4mMnBBUSP+/XyWSwfCfAbGuZPKdrRDrxM6Sk2hZWbLEWn/ypT
         n9njpPu8U97bHrhuH3vSbKYTBbVftESmMWI6dvFuYbc41e7Hj1D3O8Sq1MP8MF8OBZ
         pJtcycV91fIdw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds CPU core and cluster idle states to Tegra194
device tree

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 9449156..f9c2731 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2155,12 +2155,14 @@
 		nvidia,bpmp = <&bpmp>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		cluster-deepest-power-state = <0x6>;
 
 		cpu0_0: cpu@0 {
 			compatible = "nvidia,tegra194-carmel";
 			device_type = "cpu";
 			reg = <0x000>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2175,6 +2177,7 @@
 			device_type = "cpu";
 			reg = <0x001>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2189,6 +2192,7 @@
 			device_type = "cpu";
 			reg = <0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2203,6 +2207,7 @@
 			device_type = "cpu";
 			reg = <0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2217,6 +2222,7 @@
 			device_type = "cpu";
 			reg = <0x200>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2231,6 +2237,7 @@
 			device_type = "cpu";
 			reg = <0x201>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2245,6 +2252,7 @@
 			device_type = "cpu";
 			reg = <0x300>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2259,6 +2267,7 @@
 			device_type = "cpu";
 			reg = <0x301>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2343,12 +2352,31 @@
 			cache-line-size = <64>;
 			cache-sets = <4096>;
 		};
+
+		cpu_core_power_states {
+			C6: c6 {
+				compatible = "nvidia,tegra194-cpuidle-core";
+				idle-state-name = "CPU powergated, state retained";
+				wakeup-latency-us = <2000>;
+				min-residency-us = <30000>;
+				arm,psci-suspend-param = <0x6>;
+				status = "okay";
+			};
+		};
+
+		cpu_crossover_thresholds {
+			thresholds {
+				crossover_c1_c6 = <30000>;
+				crossover_cc1_cc6 = <80000>;
+			};
+		};
 	};
 
 	psci {
 		compatible = "arm,psci-1.0";
 		status = "okay";
 		method = "smc";
+		cpu_suspend = <0xC4000001>;
 	};
 
 	sound {
-- 
2.7.4

