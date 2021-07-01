Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C816C3B9936
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhGAXbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhGAXbX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:23 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05ABC061764;
        Thu,  1 Jul 2021 16:28:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a6so10821652ljq.3;
        Thu, 01 Jul 2021 16:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCq1/xucXMfxy6KuJS6UigbbLtLczYZrhwjUwenCvMQ=;
        b=oej+3mMn0LzaiIxdRLEt+p3q+BBHspc0PeVt9h7I0rhre8tzfM+6RNSjISFN2E/Icw
         3fxts9jYiZSofsc9Bn7mbZ9rhXnhw25QCXwG5vpb7b/4lBWJkLfJVw+7X0IPAE4ietpr
         ZNSKlhoCQvIOaMFKqB8GVgLBm7MkwtqdNEB6EO4O/36ocqL1LH08Uf9YnIVir5W+XVW5
         Lb8TGYGQxpjyEndc4MZRyAWUM65B0XXLEsxw64kns0ie0PEZr8Yh8my4RuJg7TFpUP6+
         zecZODQoH2KISkByfCLlkBdageQEs98BbukKcia63zwHScxeb/yvzYf132Dxrwibry95
         jzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCq1/xucXMfxy6KuJS6UigbbLtLczYZrhwjUwenCvMQ=;
        b=Opi7+F0/UsZaXTPJIUMjvbwxuN+aXGw6f+LBNoLh0mcpS4i5ls1pDI+wro6YC2iqdB
         dpFvmTvbpDH3FBi/xzoOlIpZgNgrngoUfh7iAZVb13Kwj7XVJW/bH74iWrZC9zgtaumM
         3lJQ0ao0kCvHa/9rpWawsJ0t3PlLaZLkQBPD+1dYhKBYoEaTdj/mpBbZruWCjlUKZ6jc
         Dbo8F6rzsxZwAvx6WH0HlarL8KM0wgX+T17FjEed+6u49S3+f8LF0m5BF0qhKRzjnDGF
         oPcugkx8pzQmhnGMXoQmEHrdFkL2G0x8SPfJriN5z9gc5s5u6qVerW+pF1tph4E3fZ/G
         MTBA==
X-Gm-Message-State: AOAM532G4oXR3Gys7MN9RKTWaCISL6tqPeDlqvpUEzzSXHmck7T/HvbL
        JFTmYrC2xNw9WMxIMBsDVks=
X-Google-Smtp-Source: ABdhPJx9at6BtUxmCDsmLjvi8kTgr094iK1aOTVf01wNcYUE6x3MuysyeNwFfgPlkw+YqLTWQBJCAg==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr1498265ljn.406.1625182129866;
        Thu, 01 Jul 2021 16:28:49 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 33/37] ARM: tegra: Add OPP tables and power domains to Tegra20 device-trees
Date:   Fri,  2 Jul 2021 02:27:24 +0300
Message-Id: <20210701232728.23591-34-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add OPP tables and power domains to all peripheral devices which
support power management on Tegra20 SoC.

Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../boot/dts/tegra20-acer-a500-picasso.dts    |   1 +
 arch/arm/boot/dts/tegra20-colibri.dtsi        |   3 +-
 arch/arm/boot/dts/tegra20-harmony.dts         |   3 +-
 arch/arm/boot/dts/tegra20-paz00.dts           |   1 +
 .../arm/boot/dts/tegra20-peripherals-opp.dtsi | 941 ++++++++++++++++++
 arch/arm/boot/dts/tegra20-seaboard.dts        |   3 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |   3 +-
 arch/arm/boot/dts/tegra20-trimslice.dts       |   9 +
 arch/arm/boot/dts/tegra20-ventana.dts         |   1 +
 arch/arm/boot/dts/tegra20.dtsi                | 103 ++
 10 files changed, 1064 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index 1976c383912a..e58ef1e0dffa 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -705,6 +705,7 @@ pmc@7000e400 {
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <458>;
 		nvidia,sys-clock-req-active-high;
+		core-supply = <&vdd_core>;
 	};
 
 	usb@c5000000 {
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 585a5b441cf6..4ec403aa5f2e 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -495,7 +495,7 @@ reg_3v3_vsys: sys {
 					regulator-always-on;
 				};
 
-				sm0 {
+				vdd_core: sm0 {
 					regulator-name = "VDD_CORE_1.2V";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
@@ -601,6 +601,7 @@ pmc@7000e400 {
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <3875>;
 		nvidia,sys-clock-req-active-high;
+		core-supply = <&vdd_core>;
 
 		/* Set SLEEP MODE bit in SUPPLYENE register of TPS658643 PMIC */
 		i2c-thermtrip {
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index ae4312eedcbd..b21bab437ebd 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -339,7 +339,7 @@ sys_reg: sys {
 					regulator-always-on;
 				};
 
-				sm0 {
+				vdd_core: sm0 {
 					regulator-name = "vdd_sm0,vdd_core";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
@@ -565,6 +565,7 @@ pmc@7000e400 {
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <3875>;
 		nvidia,sys-clock-req-active-high;
+		core-supply = <&vdd_core>;
 	};
 
 	pcie@80003000 {
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 3180bff90756..082fbc56facc 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -515,6 +515,7 @@ pmc@7000e400 {
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <0>;
 		nvidia,sys-clock-req-active-high;
+		core-supply = <&core_vdd_reg>;
 	};
 
 	usb@c5000000 {
diff --git a/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
index ef3ad2e5f270..ff8c3dcba8e9 100644
--- a/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
+++ b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
@@ -1,6 +1,46 @@
 // SPDX-License-Identifier: GPL-2.0
 
 / {
+	core_opp_table: core-power-domain-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		core_opp_950: opp@950000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-level = <950000>;
+		};
+
+		core_opp_1000: opp@1000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-level = <1000000>;
+		};
+
+		core_opp_1100: opp@1100000 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-level = <1100000>;
+		};
+
+		core_opp_1200: opp@1200000 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-level = <1200000>;
+		};
+
+		core_opp_1225: opp@1225000 {
+			opp-microvolt = <1225000 1225000 1300000>;
+			opp-level = <1225000>;
+		};
+
+		core_opp_1275: opp@1275000 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-level = <1275000>;
+		};
+
+		core_opp_1300: opp@1300000 {
+			opp-microvolt = <1300000 1300000 1300000>;
+			opp-level = <1300000>;
+		};
+	};
+
 	emc_icc_dvfs_opp_table: emc-dvfs-opp-table {
 		compatible = "operating-points-v2";
 
@@ -8,66 +48,77 @@ opp@36000000 {
 			opp-microvolt = <950000 950000 1300000>;
 			opp-hz = /bits/ 64 <36000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
 		};
 
 		opp@47500000 {
 			opp-microvolt = <950000 950000 1300000>;
 			opp-hz = /bits/ 64 <47500000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
 		};
 
 		opp@50000000 {
 			opp-microvolt = <950000 950000 1300000>;
 			opp-hz = /bits/ 64 <50000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
 		};
 
 		opp@54000000 {
 			opp-microvolt = <950000 950000 1300000>;
 			opp-hz = /bits/ 64 <54000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
 		};
 
 		opp@57000000 {
 			opp-microvolt = <950000 950000 1300000>;
 			opp-hz = /bits/ 64 <57000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
 		};
 
 		opp@100000000 {
 			opp-microvolt = <1000000 1000000 1300000>;
 			opp-hz = /bits/ 64 <100000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
 		};
 
 		opp@108000000 {
 			opp-microvolt = <1000000 1000000 1300000>;
 			opp-hz = /bits/ 64 <108000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
 		};
 
 		opp@126666000 {
 			opp-microvolt = <1000000 1000000 1300000>;
 			opp-hz = /bits/ 64 <126666000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
 		};
 
 		opp@150000000 {
 			opp-microvolt = <1000000 1000000 1300000>;
 			opp-hz = /bits/ 64 <150000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
 		};
 
 		opp@190000000 {
 			opp-microvolt = <1000000 1000000 1300000>;
 			opp-hz = /bits/ 64 <190000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
 		};
 
 		opp@216000000 {
 			opp-microvolt = <1000000 1000000 1300000>;
 			opp-hz = /bits/ 64 <216000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
 			opp-suspend;
 		};
 
@@ -75,36 +126,926 @@ opp@300000000 {
 			opp-microvolt = <1000000 1000000 1300000>;
 			opp-hz = /bits/ 64 <300000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
 		};
 
 		opp@333000000 {
 			opp-microvolt = <1000000 1000000 1300000>;
 			opp-hz = /bits/ 64 <333000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
 		};
 
 		opp@380000000 {
 			opp-microvolt = <1100000 1100000 1300000>;
 			opp-hz = /bits/ 64 <380000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
 		};
 
 		opp@600000000 {
 			opp-microvolt = <1200000 1200000 1300000>;
 			opp-hz = /bits/ 64 <600000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1200>;
 		};
 
 		opp@666000000 {
 			opp-microvolt = <1200000 1200000 1300000>;
 			opp-hz = /bits/ 64 <666000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1200>;
 		};
 
 		opp@760000000 {
 			opp-microvolt = <1300000 1300000 1300000>;
 			opp-hz = /bits/ 64 <760000000>;
 			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1300>;
+		};
+	};
+
+	gr2d_dvfs_opp_table: gr2d-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@133000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <133000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@171000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <171000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@247000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <247000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@300000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1200>;
+		};
+	};
+
+	gr3d_dvfs_opp_table: gr3d-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@114000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <114000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@161500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <161500000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@161500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <161500000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@209000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <209000000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@218500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <218500000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@247000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <247000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@247000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <247000000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@256500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <256500000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@285000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <285000000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@285000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <285000000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@304000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <304000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@323000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <323000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@333500000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <333500000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1275>;
+		};
+
+		opp@333500000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <333500000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@351500000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <351500000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@361000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <361000000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1275>;
+		};
+
+		opp@380000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <380000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@400000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1275>;
+		};
+
+		opp@400000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1200>;
+		};
+	};
+
+	disp1_dvfs_opp_table: disp1-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@158000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <158000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@190000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <190000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+	};
+
+	disp2_dvfs_opp_table: disp2-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@158000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <158000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@190000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <190000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+	};
+
+	dsi_dvfs_opp_table: dsi-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@100000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <100000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@500000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <500000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1200>;
+		};
+	};
+
+	epp_dvfs_opp_table: epp-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@133000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <133000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@171000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <171000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@247000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <247000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@300000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1200>;
+		};
+	};
+
+	hdmi_dvfs_opp_table: hdmi-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@148500000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <148500000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1200>;
+		};
+	};
+
+	host1x_dvfs_opp_table: host1x-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@104500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <104500000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@133000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <133000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@166000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <166000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+	};
+
+	ide_dvfs_opp_table: ide-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@100000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <100000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+	};
+
+	mipi_dvfs_opp_table: mipi-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@40000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <40000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@60000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <60000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1275>;
+		};
+	};
+
+	mpe_dvfs_opp_table: mpe-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@104500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <104500000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@142500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <142500000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@152000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <152000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@190000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <190000000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@190000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <190000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@228000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <228000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@228000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <228000000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@237500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <237500000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@266000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <266000000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@275500000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <275500000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@300000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0003>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@300000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x000C>;
+			required-opps = <&core_opp_1100>;
+		};
+	};
+
+	ndflash_dvfs_opp_table: ndflash-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@130000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <130000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@150000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <150000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@158000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <158000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@164000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <164000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1200>;
+		};
+	};
+
+	nor_dvfs_opp_table: nor-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@92000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <92000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+	};
+
+	pcie_dvfs_opp_table: pcie-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@250000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <250000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1200>;
+		};
+	};
+
+	sdmmc1_dvfs_opp_table: sdmmc1-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@44000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <44000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@52000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <52000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+	};
+
+	sdmmc2_dvfs_opp_table: sdmmc2-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@44000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <44000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@52000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <52000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+	};
+
+	sdmmc3_dvfs_opp_table: sdmmc3-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@44000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <44000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@52000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <52000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+	};
+
+	sdmmc4_dvfs_opp_table: sdmmc4-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@44000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <44000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@52000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <52000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+	};
+
+	sclk_dvfs_opp_table: sclk-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@95000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <95000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@123500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <123500000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@133000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <133000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@152000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <152000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@159500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <159500000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@171000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <171000000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@180500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <180500000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@190000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <190000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@207000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <207000000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@218500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <218500000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@222500000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <222500000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@229500000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <229500000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@240000000,1225 {
+			opp-microvolt = <1225000 1225000 1300000>;
+			opp-hz = /bits/ 64 <240000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1225>;
+		};
+
+		opp@240000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <240000000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@247000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <247000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1275>;
+		};
+
+		opp@256500000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <256500000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@260000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <260000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@262000000,1300 {
+			opp-microvolt = <1300000 1300000 1300000>;
+			opp-hz = /bits/ 64 <262000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1300>;
+		};
+
+		opp@264000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <264000000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1275>;
+		};
+
+		opp@277500000,1300 {
+			opp-microvolt = <1300000 1300000 1300000>;
+			opp-hz = /bits/ 64 <277500000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1300>;
+		};
+
+		opp@285000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <285000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1275>;
+		};
+
+		opp@292500000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <292500000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@300000000,1300 {
+			opp-microvolt = <1300000 1300000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1300>;
+		};
+
+		opp@300000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1275>;
+		};
+	};
+
+	tvo_dvfs_opp_table: tvo-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@250000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <250000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1200>;
+		};
+	};
+
+	usbd_dvfs_opp_table: usbd-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@480000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <480000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+	};
+
+	usb2_dvfs_opp_table: usb2-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@480000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <480000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+	};
+
+	usb3_dvfs_opp_table: usb3-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@480000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <480000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
+		};
+	};
+
+	vde_dvfs_opp_table: vde-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@95000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <95000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@123500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <123500000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@123500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <123500000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@152000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <152000000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@152000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <152000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@171000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <171000000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@209000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <209000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@209000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <209000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@218500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <218500000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@237500000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <237500000>;
+			opp-supported-hw = <0x0002>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@275500000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <275500000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@285000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <285000000>;
+			opp-supported-hw = <0x0004>;
+			required-opps = <&core_opp_1100>;
+		};
+
+		opp@300000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0001>;
+			required-opps = <&core_opp_1275>;
+		};
+
+		opp@300000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0006>;
+			required-opps = <&core_opp_1200>;
+		};
+
+		opp@300000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1100>;
+		};
+	};
+
+	vi_dvfs_opp_table: vi-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@85000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <85000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_950>;
+		};
+
+		opp@100000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <100000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp@150000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <150000000>;
+			opp-supported-hw = <0x000F>;
+			required-opps = <&core_opp_1100>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 92d494b8c3d2..5aeb7bb6c415 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -444,7 +444,7 @@ sys_reg: sys {
 					regulator-always-on;
 				};
 
-				sm0 {
+				vdd_core: sm0 {
 					regulator-name = "vdd_sm0,vdd_core";
 					regulator-min-microvolt = <1300000>;
 					regulator-max-microvolt = <1300000>;
@@ -689,6 +689,7 @@ pmc@7000e400 {
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <3875>;
 		nvidia,sys-clock-req-active-high;
+		core-supply = <&vdd_core>;
 	};
 
 	memory-controller@7000f400 {
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 95e6bccdb4f6..ff2fb335ad10 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -357,7 +357,7 @@ sys_reg: sys {
 					regulator-always-on;
 				};
 
-				sm0 {
+				vdd_core: sm0 {
 					regulator-name = "vdd_sys_sm0,vdd_core";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
@@ -477,6 +477,7 @@ pmc@7000e400 {
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <3875>;
 		nvidia,sys-clock-req-active-high;
+		core-supply = <&vdd_core>;
 	};
 
 	pcie@80003000 {
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 4bc87bc0c2a4..582dc7910ff8 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -321,6 +321,7 @@ pmc@7000e400 {
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <3875>;
 		nvidia,sys-clock-req-active-high;
+		core-supply = <&vdd_core>;
 	};
 
 	pcie@80003000 {
@@ -444,6 +445,14 @@ pci_vdd_reg: regulator@4 {
 		regulator-always-on;
 	};
 
+	vdd_core: regulator@5 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_core";
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-always-on;
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-trimslice";
 		nvidia,i2s-controller = <&tegra_i2s1>;
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 5a2578b3707f..e41ce1b1ec3f 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -544,6 +544,7 @@ pmc@7000e400 {
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <458>;
 		nvidia,sys-clock-req-active-high;
+		core-supply = <&vdd_core>;
 	};
 
 	usb@c5000000 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 6ce498178105..5c74cc76b5e3 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -42,6 +42,8 @@ host1x@50000000 {
 		clock-names = "host1x";
 		resets = <&tegra_car 28>;
 		reset-names = "host1x";
+		operating-points-v2 = <&host1x_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -55,6 +57,8 @@ mpe@54040000 {
 			clocks = <&tegra_car TEGRA20_CLK_MPE>;
 			resets = <&tegra_car 60>;
 			reset-names = "mpe";
+			operating-points-v2 = <&mpe_dvfs_opp_table>;
+			power-domains = <&pd_mpe>;
 		};
 
 		vi@54080000 {
@@ -64,6 +68,8 @@ vi@54080000 {
 			clocks = <&tegra_car TEGRA20_CLK_VI>;
 			resets = <&tegra_car 20>;
 			reset-names = "vi";
+			operating-points-v2 = <&vi_dvfs_opp_table>;
+			power-domains = <&pd_venc>;
 		};
 
 		epp@540c0000 {
@@ -73,6 +79,8 @@ epp@540c0000 {
 			clocks = <&tegra_car TEGRA20_CLK_EPP>;
 			resets = <&tegra_car 19>;
 			reset-names = "epp";
+			operating-points-v2 = <&epp_dvfs_opp_table>;
+			power-domains = <&pd_core>;
 		};
 
 		isp@54100000 {
@@ -82,6 +90,7 @@ isp@54100000 {
 			clocks = <&tegra_car TEGRA20_CLK_ISP>;
 			resets = <&tegra_car 23>;
 			reset-names = "isp";
+			power-domains = <&pd_venc>;
 		};
 
 		gr2d@54140000 {
@@ -91,6 +100,8 @@ gr2d@54140000 {
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
 			resets = <&tegra_car 21>;
 			reset-names = "2d";
+			operating-points-v2 = <&gr2d_dvfs_opp_table>;
+			power-domains = <&pd_core>;
 		};
 
 		gr3d@54180000 {
@@ -99,6 +110,8 @@ gr3d@54180000 {
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
 			resets = <&tegra_car 24>;
 			reset-names = "3d";
+			operating-points-v2 = <&gr3d_dvfs_opp_table>;
+			power-domains = <&pd_3d>;
 		};
 
 		dc@54200000 {
@@ -110,6 +123,8 @@ dc@54200000 {
 			clock-names = "dc", "parent";
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
+			operating-points-v2 = <&disp1_dvfs_opp_table>;
+			power-domains = <&pd_core>;
 
 			nvidia,head = <0>;
 
@@ -138,6 +153,8 @@ dc@54240000 {
 			clock-names = "dc", "parent";
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
+			operating-points-v2 = <&disp2_dvfs_opp_table>;
+			power-domains = <&pd_core>;
 
 			nvidia,head = <1>;
 
@@ -166,6 +183,8 @@ hdmi@54280000 {
 			clock-names = "hdmi", "parent";
 			resets = <&tegra_car 51>;
 			reset-names = "hdmi";
+			operating-points-v2 = <&hdmi_dvfs_opp_table>;
+			power-domains = <&pd_core>;
 			status = "disabled";
 		};
 
@@ -174,6 +193,8 @@ tvo@542c0000 {
 			reg = <0x542c0000 0x00040000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_TVO>;
+			operating-points-v2 = <&tvo_dvfs_opp_table>;
+			power-domains = <&pd_core>;
 			status = "disabled";
 		};
 
@@ -185,6 +206,8 @@ dsi@54300000 {
 			clock-names = "dsi", "parent";
 			resets = <&tegra_car 48>;
 			reset-names = "dsi";
+			operating-points-v2 = <&dsi_dvfs_opp_table>;
+			power-domains = <&pd_core>;
 			status = "disabled";
 		};
 	};
@@ -242,6 +265,16 @@ tegra_car: clock@60006000 {
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+
+		tegra-clocks {
+			sclk {
+				compatible = "nvidia,tegra20-sclk",
+					     "nvidia,tegra-clock";
+				operating-points-v2 = <&sclk_dvfs_opp_table>;
+				clocks = <&tegra_car TEGRA20_CLK_SCLK>;
+				power-domains = <&pd_core>;
+			};
+		};
 	};
 
 	flow-controller@60007000 {
@@ -319,6 +352,8 @@ vde@6001a000 {
 		clocks = <&tegra_car TEGRA20_CLK_VDE>;
 		reset-names = "vde", "mc";
 		resets = <&tegra_car 61>, <&mc TEGRA20_MC_RESET_VDE>;
+		operating-points-v2 = <&vde_dvfs_opp_table>;
+		power-domains = <&pd_vde>;
 	};
 
 	apbmisc@70000800 {
@@ -460,6 +495,8 @@ nand-controller@70008000 {
 		reset-names = "nand";
 		assigned-clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
 		assigned-clock-rates = <150000000>;
+		operating-points-v2 = <&ndflash_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 		status = "disabled";
 	};
 
@@ -473,6 +510,8 @@ gmi@70009000 {
 		clock-names = "gmi";
 		resets = <&tegra_car 42>;
 		reset-names = "gmi";
+		operating-points-v2 = <&nor_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 		status = "disabled";
 	};
 
@@ -643,6 +682,52 @@ tegra_pmc: pmc@7000e400 {
 		clocks = <&tegra_car TEGRA20_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
 		#clock-cells = <1>;
+
+		pd_core: core-domain {
+			operating-points-v2 = <&core_opp_table>;
+			#power-domain-cells = <0>;
+		};
+
+		powergates {
+			pd_3d: 3d {
+				clocks = <&tegra_car TEGRA20_CLK_GR3D>;
+				resets = <&mc TEGRA20_MC_RESET_3D>,
+					 <&tegra_car TEGRA20_CLK_GR3D>;
+				power-domains = <&pd_core>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_venc: venc {
+				clocks = <&tegra_car TEGRA20_CLK_ISP>,
+					 <&tegra_car TEGRA20_CLK_VI>,
+					 <&tegra_car TEGRA20_CLK_CSI>;
+				resets = <&mc TEGRA20_MC_RESET_ISP>,
+					 <&mc TEGRA20_MC_RESET_VI>,
+					 <&tegra_car TEGRA20_CLK_ISP>,
+					 <&tegra_car 20 /* VI */>,
+					 <&tegra_car TEGRA20_CLK_CSI>;
+				power-domains = <&pd_core>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_vde: vdec {
+				clocks = <&tegra_car TEGRA20_CLK_VDE>;
+				resets = <&mc TEGRA20_MC_RESET_VDE>,
+					 <&tegra_car TEGRA20_CLK_VDE>;
+				power-domains = <&pd_core>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_mpe: mpe {
+				clocks = <&tegra_car TEGRA20_CLK_MPE>;
+				resets = <&mc TEGRA20_MC_RESET_MPEA>,
+					 <&mc TEGRA20_MC_RESET_MPEB>,
+					 <&mc TEGRA20_MC_RESET_MPEC>,
+					 <&tegra_car TEGRA20_CLK_MPE>;
+				power-domains = <&pd_core>;
+				#power-domain-cells = <0>;
+			};
+		};
 	};
 
 	mc: memory-controller@7000f000 {
@@ -662,6 +747,7 @@ emc: memory-controller@7000f400 {
 		reg = <0x7000f400 0x400>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
+		power-domains = <&pd_core>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interconnect-cells = <0>;
@@ -712,6 +798,9 @@ pcie@80003000 {
 			 <&tegra_car 72>,
 			 <&tegra_car 74>;
 		reset-names = "pex", "afi", "pcie_x";
+		operating-points-v2 = <&pcie_dvfs_opp_table>;
+		power-domains = <&pd_core>;
+
 		status = "disabled";
 
 		pci@1,0 {
@@ -754,6 +843,8 @@ usb@c5000000 {
 		reset-names = "usb";
 		nvidia,needs-double-reset;
 		nvidia,phy = <&phy1>;
+		operating-points-v2 = <&usbd_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 		status = "disabled";
 	};
 
@@ -791,6 +882,8 @@ usb@c5004000 {
 		resets = <&tegra_car 58>;
 		reset-names = "usb";
 		nvidia,phy = <&phy2>;
+		operating-points-v2 = <&usb2_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 		status = "disabled";
 	};
 
@@ -817,6 +910,8 @@ usb@c5008000 {
 		resets = <&tegra_car 59>;
 		reset-names = "usb";
 		nvidia,phy = <&phy3>;
+		operating-points-v2 = <&usb3_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 		status = "disabled";
 	};
 
@@ -851,6 +946,8 @@ mmc@c8000000 {
 		clock-names = "sdhci";
 		resets = <&tegra_car 14>;
 		reset-names = "sdhci";
+		operating-points-v2 = <&sdmmc1_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 		status = "disabled";
 	};
 
@@ -862,6 +959,8 @@ mmc@c8000200 {
 		clock-names = "sdhci";
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
+		operating-points-v2 = <&sdmmc2_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 		status = "disabled";
 	};
 
@@ -873,6 +972,8 @@ mmc@c8000400 {
 		clock-names = "sdhci";
 		resets = <&tegra_car 69>;
 		reset-names = "sdhci";
+		operating-points-v2 = <&sdmmc3_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 		status = "disabled";
 	};
 
@@ -884,6 +985,8 @@ mmc@c8000600 {
 		clock-names = "sdhci";
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
+		operating-points-v2 = <&sdmmc4_dvfs_opp_table>;
+		power-domains = <&pd_core>;
 		status = "disabled";
 	};
 
-- 
2.30.2

