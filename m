Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49794294FB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhJKRBI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 13:01:08 -0400
Received: from marcansoft.com ([212.63.210.85]:56868 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232940AbhJKRAp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Oct 2021 13:00:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0FAA9425E4;
        Mon, 11 Oct 2021 16:58:14 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 9/9] arm64: apple: Add CPU frequency scaling support for t8103
Date:   Tue, 12 Oct 2021 01:57:07 +0900
Message-Id: <20211011165707.138157-10-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011165707.138157-1-marcan@marcan.st>
References: <20211011165707.138157-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

- Proper CPU topology
- CPU capacities
  * The 714 value is based on the CoreMark benchmark [1]. This is
    roughly in line with other real-world test cases, like gzip. For
    some reason, Dhrystone gives a wildly different value of 326, but
    this doesn't seem representative of real-world workloads. This might
    be adjusted in the future.
- MCC instance to control memory controller performance
- MCC OPP for t8103 using config values from hardware/ADT
- E-Cluster and P-Cluster clock controllers for CPU frequency switching
- Cluster OPP tables, including latency values determined
  experimentally.

This relies on the generic cpufreq-dt driver to implement the cpufreq
side. It also assumes the bootloader did any required init (iBoot does
everything on firmware 12.0 and later; for 11.x we will have m1n1 do
what's missing).

[1] https://github.com/kdrag0n/linux-m1/commit/05c296604a42189cb61a0f7e8665566de192cbe9

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 255 ++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index a1e22a2ea2e5..5eec86917d72 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -20,68 +20,284 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		cpu0: cpu@0 {
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e0>;
+				};
+				core1 {
+					cpu = <&cpu_e1>;
+				};
+				core2 {
+					cpu = <&cpu_e2>;
+				};
+				core3 {
+					cpu = <&cpu_e3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p0>;
+				};
+				core1 {
+					cpu = <&cpu_p1>;
+				};
+				core2 {
+					cpu = <&cpu_p2>;
+				};
+				core3 {
+					cpu = <&cpu_p3>;
+				};
+			};
+		};
+
+		cpu_e0: cpu@0 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
 			reg = <0x0 0x0>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			clocks = <&clk_ecluster>;
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <714>;
 		};
 
-		cpu1: cpu@1 {
+		cpu_e1: cpu@1 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
 			reg = <0x0 0x1>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			clocks = <&clk_ecluster>;
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <714>;
 		};
 
-		cpu2: cpu@2 {
+		cpu_e2: cpu@2 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
 			reg = <0x0 0x2>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			clocks = <&clk_ecluster>;
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <714>;
 		};
 
-		cpu3: cpu@3 {
+		cpu_e3: cpu@3 {
 			compatible = "apple,icestorm";
 			device_type = "cpu";
 			reg = <0x0 0x3>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			clocks = <&clk_ecluster>;
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <714>;
 		};
 
-		cpu4: cpu@10100 {
+		cpu_p0: cpu@10100 {
 			compatible = "apple,firestorm";
 			device_type = "cpu";
 			reg = <0x0 0x10100>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			clocks = <&clk_pcluster>;
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
 		};
 
-		cpu5: cpu@10101 {
+		cpu_p1: cpu@10101 {
 			compatible = "apple,firestorm";
 			device_type = "cpu";
 			reg = <0x0 0x10101>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			clocks = <&clk_pcluster>;
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
 		};
 
-		cpu6: cpu@10102 {
+		cpu_p2: cpu@10102 {
 			compatible = "apple,firestorm";
 			device_type = "cpu";
 			reg = <0x0 0x10102>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			clocks = <&clk_pcluster>;
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
 		};
 
-		cpu7: cpu@10103 {
+		cpu_p3: cpu@10103 {
 			compatible = "apple,firestorm";
 			device_type = "cpu";
 			reg = <0x0 0x10103>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			clocks = <&clk_pcluster>;
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
+		};
+	};
+
+	ecluster_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <559000>;
+			opp-level = <1>;
+			clock-latency-ns = <7500>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <972000000>;
+			opp-microvolt = <628000>;
+			opp-level = <2>;
+			clock-latency-ns = <22000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1332000000>;
+			opp-microvolt = <684000>;
+			opp-level = <3>;
+			clock-latency-ns = <27000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <765000>;
+			opp-level = <4>;
+			clock-latency-ns = <33000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <2064000000>;
+			opp-microvolt = <868000>;
+			opp-level = <5>;
+			clock-latency-ns = <50000>;
+		};
+	};
+
+	pcluster_opp: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <781000>;
+			opp-level = <1>;
+			clock-latency-ns = <8000>;
+			required-opps = <&mcc_lowperf>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <828000000>;
+			opp-microvolt = <781000>;
+			opp-level = <2>;
+			clock-latency-ns = <19000>;
+			required-opps = <&mcc_lowperf>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <781000>;
+			opp-level = <3>;
+			clock-latency-ns = <21000>;
+			required-opps = <&mcc_lowperf>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1284000000>;
+			opp-microvolt = <800000>;
+			opp-level = <4>;
+			clock-latency-ns = <23000>;
+			required-opps = <&mcc_lowperf>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <821000>;
+			opp-level = <5>;
+			clock-latency-ns = <24000>;
+			required-opps = <&mcc_lowperf>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-microvolt = <831000>;
+			opp-level = <6>;
+			clock-latency-ns = <29000>;
+			required-opps = <&mcc_lowperf>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <1956000000>;
+			opp-microvolt = <865000>;
+			opp-level = <7>;
+			clock-latency-ns = <31000>;
+			required-opps = <&mcc_lowperf>;
+		};
+		opp08 {
+			opp-hz = /bits/ 64 <2184000000>;
+			opp-microvolt = <909000>;
+			opp-level = <8>;
+			clock-latency-ns = <34000>;
+			required-opps = <&mcc_highperf>;
+		};
+		opp09 {
+			opp-hz = /bits/ 64 <2388000000>;
+			opp-microvolt = <953000>;
+			opp-level = <9>;
+			clock-latency-ns = <36000>;
+			required-opps = <&mcc_highperf>;
+		};
+		opp10 {
+			opp-hz = /bits/ 64 <2592000000>;
+			opp-microvolt = <1003000>;
+			opp-level = <10>;
+			clock-latency-ns = <51000>;
+			required-opps = <&mcc_highperf>;
+		};
+		opp11 {
+			opp-hz = /bits/ 64 <2772000000>;
+			opp-microvolt = <1053000>;
+			opp-level = <11>;
+			clock-latency-ns = <54000>;
+			required-opps = <&mcc_highperf>;
+		};
+		opp12 {
+			opp-hz = /bits/ 64 <2988000000>;
+			opp-microvolt = <1081000>;
+			opp-level = <12>;
+			clock-latency-ns = <55000>;
+			required-opps = <&mcc_highperf>;
+		};
+		opp13 {
+			opp-hz = /bits/ 64 <3096000000>;
+			opp-microvolt = <1081000>;
+			opp-level = <13>;
+			clock-latency-ns = <55000>;
+			required-opps = <&mcc_highperf>;
+		};
+		opp14 {
+			opp-hz = /bits/ 64 <3144000000>;
+			opp-microvolt = <1081000>;
+			opp-level = <14>;
+			clock-latency-ns = <56000>;
+			required-opps = <&mcc_highperf>;
+		};
+		opp15 {
+			opp-hz = /bits/ 64 <3204000000>;
+			opp-microvolt = <1081000>;
+			opp-level = <15>;
+			clock-latency-ns = <56000>;
+			required-opps = <&mcc_highperf>;
+		};
+	};
+
+	mcc_opp: opp-table-2 {
+		compatible = "apple,mcc-operating-points";
+
+		mcc_lowperf: opp0 {
+			opp-level = <0>;
+			apple,memory-perf-config = <0x813057f 0x1800180>;
+		};
+		mcc_highperf: opp1 {
+			opp-level = <1>;
+			apple,memory-perf-config = <0x133 0x55555340>;
 		};
 	};
 
@@ -110,6 +326,29 @@ soc {
 		ranges;
 		nonposted-mmio;
 
+		mcc: memory-controller@200200000 {
+			compatible = "apple,t8103-mcc", "apple,mcc";
+			#power-domain-cells = <0>;
+			reg = <0x2 0x200000 0x0 0x200000>;
+			operating-points-v2 = <&mcc_opp>;
+			apple,num-channels = <8>;
+		};
+
+		clk_ecluster: clock-controller@210e20000 {
+			compatible = "apple,t8103-cluster-clk", "apple,cluster-clk";
+			#clock-cells = <0>;
+			reg = <0x2 0x10e20000 0x0 0x4000>;
+			operating-points-v2 = <&ecluster_opp>;
+		};
+
+		clk_pcluster: clock-controller@211e20000 {
+			compatible = "apple,t8103-cluster-clk", "apple,cluster-clk";
+			#clock-cells = <0>;
+			reg = <0x2 0x11e20000 0x0 0x4000>;
+			operating-points-v2 = <&pcluster_opp>;
+			power-domains = <&mcc>;
+		};
+
 		serial0: serial@235200000 {
 			compatible = "apple,s5l-uart";
 			reg = <0x2 0x35200000 0x0 0x1000>;
-- 
2.33.0

