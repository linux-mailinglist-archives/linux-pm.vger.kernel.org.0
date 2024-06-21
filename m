Return-Path: <linux-pm+bounces-9774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0BC912B90
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E5E1F27069
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D53616B736;
	Fri, 21 Jun 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b+974Ov7"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DB1684AD;
	Fri, 21 Jun 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988000; cv=none; b=O2m0FGSQMNei9CUQ+5UAZwX2NjjL+TVN3H6I1G7d6nxGksend/a5qZbffRee9ED9egX6TPOCvNZNXwawdEIRrj0go+GNd1y9eW+NQb2K80/NfDOBa/eCQOOT8VCyj1pxoPjn3frZi8+nYTpmDPYPmHZinpbCwSgfe1NSp1e9V+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988000; c=relaxed/simple;
	bh=hWo1gVxlWo8njHZbS2+ISUJ4MaU/Z08cT/W2pZCsCxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WHUlpg2E7bJujLPk36hH/JrP7pA7ujBxJbwdfSAlHGOyHLLsQmpNIksjEQvTu1SpuYW9FPVi3njlOQj3at4SaT3MQN0/JoAdc4C7JvDUwDcDdBrKHHpkUnfKz7SUVYI/H2g0SmsUC/B0JqfSVYq5KL77qOBPPuJe2Yoj0E3lstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b+974Ov7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdknq091082;
	Fri, 21 Jun 2024 11:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718987986;
	bh=D1lHDBEabw6iFa5eoXj6w/4O8h6lIdgdEQcuBn3HstE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=b+974Ov7Tplz+TfybU4x/oWH/5Qkn3xsa2QeiF4ALxQ7OhYww8pFjgSSS/bb22aL7
	 jCaeV7jsS65c1NesFKAWeIZdyV2+omZRvUTuGVgGXpVLp9H3uYuOPqpej7tBFECD/t
	 Na2n3Vof6rZrMiwRHpiktA9SGGyxDZ/UYIvc4p6Y=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LGdkjk062054
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 11:39:46 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 11:39:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 11:39:46 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdkLB057989;
	Fri, 21 Jun 2024 11:39:46 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 21 Jun 2024 11:39:41 -0500
Subject: [PATCH v3 5/5] DONOTMERGE: arm64: dts: ti: k3-am62a: add in opp
 table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240621-ti-opp-updates-v3-5-d857be6dac8b@ti.com>
References: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
In-Reply-To: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: Vibhore Vardhan <vibhore@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3806; i=bb@ti.com;
 h=from:subject:message-id; bh=hWo1gVxlWo8njHZbS2+ISUJ4MaU/Z08cT/W2pZCsCxE=;
 b=owNCWmg5MUFZJlNZePdFTQAAZn////9v/+fr/cz+zxG/l6san/7qz/X17+vLU0+89xNp//ewA
 Rs21kABiMgDTQ0aAAaA0wmmmjRpoDCaADQyAAyYQaZDCADQYjCAPUYjIyb1EHqaMIA0GhoAANDR
 owhoDQaGhoAA0aGmgyGho09IA9ENNBpoeiNHqYyIGQaNDNSPUMnqNGg0NPSMgHqDTQaaBo0ABoA
 DQAaAAAADQADQaeoNAaeoeoD1PU9TNQMMcTgTLHM7eN6CfPu7Dj3lCeHPLTtFdDxro+OwRa/5uy
 O0LQOZUMKp4WYy6t/fUZ98garnzMFFSG8Xes20ot2UoZ5oQDEXPVA8zjM6dGSVjiuA+DO9X4ZnE
 NkBUcl24TP0ACmUZXKu4M5Gd+hkrZXm0ut3BAOjMcsuhXbFZVxq3mQ9bEZz3lSa1997fHX5nQ0U
 B0+UK8+xQA787wRoOxgmsLz44DXTuv/F/7hYLJrRu+RbgMFPsnRZPMesSESUsdJZ4DE0haQjSki
 CazNMvijCgstlyslLaMwBZEeYiEI4rljzW+BeW8w9VebXLOWthRCiZDR0KEC3DuAnmmiEX+ECvV
 N+ODLE3BYkP3QLSQamAaye2ClXNLdigFMfnI+MBWUKTKJEYZf20tq4soonZ/v1DH4ppvEBYoiwA
 Upwj04DigC7kinChIPHuipo
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

To help reduce power consumption, reduce the frequency of the CPU cores
when they sit idle by specifying their supported OPP entries.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     |  9 +++++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi       | 51 +++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 98043e9aa316b..bf16b29c3953b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -13,6 +13,11 @@ wkup_conf: syscon@43000000 {
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x43000000 0x20000>;
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index f241637a5642a..852a066585d6d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -59,6 +59,15 @@ wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
 		};
 	};
 
+	opp-table {
+		/* Add 1.4GHz OPP for am62p5-sk board. Requires VDD_CORE at 0v85 */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
 	vmain_pd: regulator-0 {
 		/* TPS25750 PD CONTROLLER OUTPUT */
 		compatible = "regulator-fixed";
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
index f86a23404e6dd..6c99221beb6bd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
@@ -48,6 +48,8 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 135 0>;
 		};
 
 		cpu1: cpu@1 {
@@ -62,6 +64,8 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 136 0>;
 		};
 
 		cpu2: cpu@2 {
@@ -76,6 +80,8 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 137 0>;
 		};
 
 		cpu3: cpu@3 {
@@ -90,6 +96,51 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 138 0>;
+		};
+	};
+
+	a53_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		opp-shared;
+		syscon = <&opp_efuse_table>;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x01 0x0006>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+			opp-suspend;
 		};
 	};
 

-- 
2.45.2


