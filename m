Return-Path: <linux-pm+bounces-9026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E39058FF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 18:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3CA1C21EFC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EF7181BB7;
	Wed, 12 Jun 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XQ458FYO"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1E181B90;
	Wed, 12 Jun 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210544; cv=none; b=WUbba6j2CchPfJVD/qmfVGaBf+dOSI9E5AjROcKgU001hdsOcWBJKezivQZnCGtSGb9qfL9ghQJt3ftJfgN56y9/dj6biMr5SBGcaYv+xpJJzX+AtRAeCEfMFLejLwMgqA6e55JHYXAj0HKwKGuer0ygDIrrNPbrnRb93dgXf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210544; c=relaxed/simple;
	bh=FZHOMpGaEYP5IB+9r4ZvFHZhBO9oepJfS8PBFrnej8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jJvA3K4NiJqU1R0ONzJevOJm8tiRPAwwuOrN0umy2yidpBo3wSa4zNVZnn4W1yrcV4PUkp6vzwI1mGnXN8Bmy8+zldRMqRlCmJGq90zTdQxdN299kFMmksks3DG60hZmn2JR5JAsakcshChTxowYulo7REH6MKnwQ+NlXY5FbPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XQ458FYO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgBdP029403;
	Wed, 12 Jun 2024 11:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718210531;
	bh=pIKhvca1G0LsgNQvLd70jtD8/EP9eisPHDT+bocufdE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=XQ458FYOQ/hcjslKmWPvZNRpnx6J+5aHV+JEzjr8MGYVf0QP1f1xgt1nk3f1YWdq4
	 bJMRNEzEh//xkqaWx+gVv7jelPpon+uNhNhwnQzhD5wzIHYarRSbCHfidYvsPjVXMj
	 w4KfYFQD+zVFXJWuX3gwbVfmG0Dc+xl3QIU0ulQU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CGgBtp079736
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 11:42:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 11:42:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 11:42:10 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgBdW099389;
	Wed, 12 Jun 2024 11:42:11 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 12 Jun 2024 11:41:54 -0500
Subject: [PATCH 5/5] DONOTMERGE: arm64: dts: ti: k3-am62a: add in opp table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-ti-opp-updates-v1-5-3551c31d9872@ti.com>
References: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
In-Reply-To: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800; i=bb@ti.com;
 h=from:subject:message-id; bh=FZHOMpGaEYP5IB+9r4ZvFHZhBO9oepJfS8PBFrnej8M=;
 b=owNCWmg5MUFZJlNZuKejSQAAaP///vf5+2u0e9rzv/P3++//b/rn6dc/2/Mz/3vu197z62awA
 RsYkPRAAAAAADIGgAaAyANAABoGhoAAHqAAAAPUD1Gh6TJ6QGjaaTynkIgA0GgADQGgGgyNADQG
 h6gyDQABmoDTymhkAGmmTRtTIANADRtTQMmgPU0aPUOhkaNDQBppiaAyNMjTQNMg0yaaaGIAMgM
 jIAMmjRkDRkyANAA00GmQaGINDQAIE2CVISOBxmCSBwYWEix1m/Pnok2upFe4gWtDwwBK4agMx5
 UDlE0W4xlDAyDwSZUQJtkaMr1I0BHImeLOxRE4nWrCMpeqwyxAIEVRZFiY+2qQkFqXcnz5UudBm
 guPPcktcqNHd9YrXYgAuxQFky7xzWbD6CsSp51PSwJ+FenRJqoFDHw5Ncv1hm5vtRoCWdPQTQM1
 E7PlKdOt+IzmAJQhgLzCf59H0khUlGKJ/HFpUwkwwmcEb3ByZEGQMPQUT0o98IM4H4Ikyp+4vK7
 GTzbdwTDYKKQ4iX6xiqFwEZvLUJotOiS9AoYnaEIkMqUveaIRpqEfzjVdKCoKO/kLPqm85ZE2DB
 HoUn0rQfoB8b7q7lSAXwrEBy9nXXFwxxymYAwUbMkTz3Ykr6fcPCtYxJ6iLeV844LctcwrzZ+2U
 XLTBpJEAcyJ/i7kinChIXFPRpI=
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
index f86a23404e6dd..b77390b66efa5 100644
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
+		syscon = <&wkup_conf>;
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


