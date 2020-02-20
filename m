Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2CC165A9F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 10:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgBTJ47 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 04:56:59 -0500
Received: from foss.arm.com ([217.140.110.172]:39222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgBTJ46 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Feb 2020 04:56:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C20D30E;
        Thu, 20 Feb 2020 01:56:58 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CA033F703;
        Thu, 20 Feb 2020 01:56:55 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [RESEND PATCH v2 1/2] ARM: dts: exynos: Add dynamic-power-coefficient to Exynos5422 CPUs
Date:   Thu, 20 Feb 2020 09:56:35 +0000
Message-Id: <20200220095636.29469-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220095636.29469-1-lukasz.luba@arm.com>
References: <20200220095636.29469-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To use Energy Aware Scheduler (EAS) the Energy Model (EM) should be
registered for CPUs. Add dynamic-power-coefficient into CPU nodes which
let CPUFreq subsystem register the EM structures. This will increase
energy efficiency of big.LITTLE platforms.

The 'dynamic-power-coefficient' values have been obtained experimenting
with different workloads. The power measurements taken from big CPU
Cluster and LITTLE CPU Cluster has been compared with official documents
and synthetic workloads estimations. The effective power ratio between
Cortex-A7 and Cortex-A15 CPUs (~3x) is also aligned with documentation.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index 1b8605cf2407..4b641b9b8179 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -31,6 +31,7 @@
 			operating-points-v2 = <&cluster_a7_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
+			dynamic-power-coefficient = <90>;
 		};
 
 		cpu1: cpu@101 {
@@ -43,6 +44,7 @@
 			operating-points-v2 = <&cluster_a7_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
+			dynamic-power-coefficient = <90>;
 		};
 
 		cpu2: cpu@102 {
@@ -55,6 +57,7 @@
 			operating-points-v2 = <&cluster_a7_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
+			dynamic-power-coefficient = <90>;
 		};
 
 		cpu3: cpu@103 {
@@ -67,6 +70,7 @@
 			operating-points-v2 = <&cluster_a7_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <539>;
+			dynamic-power-coefficient = <90>;
 		};
 
 		cpu4: cpu@0 {
@@ -79,6 +83,7 @@
 			operating-points-v2 = <&cluster_a15_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <310>;
 		};
 
 		cpu5: cpu@1 {
@@ -91,6 +96,7 @@
 			operating-points-v2 = <&cluster_a15_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <310>;
 		};
 
 		cpu6: cpu@2 {
@@ -103,6 +109,7 @@
 			operating-points-v2 = <&cluster_a15_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <310>;
 		};
 
 		cpu7: cpu@3 {
@@ -115,6 +122,7 @@
 			operating-points-v2 = <&cluster_a15_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <310>;
 		};
 	};
 };
-- 
2.17.1

