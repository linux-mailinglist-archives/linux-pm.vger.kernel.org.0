Return-Path: <linux-pm+bounces-9024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4823C9058FC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E74B213BA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9EE181332;
	Wed, 12 Jun 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iegxmR6o"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00241D55D;
	Wed, 12 Jun 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210542; cv=none; b=iCQMe/LHcRRyZsetOuCoHL7y1QMFNNnpLEQMBia8M/xdgh8qhfWYxcVzyU6eAodGD1/87SqnjkF3zHOniJcmeP8iocxBPfv3KPscB426WcODMS1cejlwjbrq5FnrpBa4QTr241nCN7K4H7dAnT7tZrBmFzjBG38PV/g6weBpDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210542; c=relaxed/simple;
	bh=bsU/uSufwYkHHioRdRIW2VKG45iABEGGxk+o7JmN7xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I5PwozldBiKr+p4cL9gP2NdBa7BEEPnKQdrYe2pPbStxPIjkIAgq3RLXWM2JS77ZYaBUQ0XpbQtXPSL83G5eFxctTKnyd7JSnCo5yszFXnjjKuZD2guGIQawGSHkfUUFSia2yLb6zqCpNxbudQJUskds/3zpW+Yy9jlJ7jL6hqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iegxmR6o; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgBPn039622;
	Wed, 12 Jun 2024 11:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718210531;
	bh=41la4WrGvritz6KJ0djgZf2nYLv9pbYtJnXCQHs8xKk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=iegxmR6oks254Rtf/CNlXqQdbFaLR4ZWZuMCszJ8JSJvlorkC3L6IhCZ08Lb/1r8+
	 Crr9P1pNuZdLMHMJ4Kz5unAVFsAUuQl0RbTRSQNkgoGl6WihAi1rv/6RhtXwbOh0nC
	 KNBWrgSSUtPVm4wTSPfUW6+W6MhNROzTTEe1CkNI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CGgBXF002741
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 11:42:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 11:42:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 11:42:10 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgBRk099386;
	Wed, 12 Jun 2024 11:42:11 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 12 Jun 2024 11:41:53 -0500
Subject: [PATCH 4/5] DONOTMERGE: arm64: dts: ti: k3-am62p: add in opp
 tables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-ti-opp-updates-v1-4-3551c31d9872@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3899; i=bb@ti.com;
 h=from:subject:message-id; bh=bsU/uSufwYkHHioRdRIW2VKG45iABEGGxk+o7JmN7xk=;
 b=owNCWmg5MUFZJlNZkMuWPAAAXf///r99v7uzvPbvy2sr23/39rlybIbL+9/vfH//7jf9/8ywA
 RswIeoGho0A0AAaNogaBkDQA0DQ0GjTQDQaDQAaMgGjQDIA00aDI2hG1NG0ynpEDI0A0BoGjCDJ
 oNA9BDJk00AwIBoZDIA2oAaZMmmhoGmTQBo0ZBo0AZBkyHTTaIZMg0aNGRkGI0yaGhkZAyaAwQA
 0Bo0D1AGRiAAyaNGjQNMmgyGhiAAAAHUJUh78MLEjC9iSD/ag2iEzqAbDBC/QElAoOZIAkex3Wv
 5wCAhyRmodIv2wl0EFESd+TL02k/Zl2fR6ED7FodS8z3yDJKH4bepxRobu/4NMDXII+HL97oGZT
 HYnlBdHo7+CHMcXNSOtYuqiQzlwgBGyoOvgsuMBTq/s/Z+durXJq9soyczkpICtAFvvP+0GChfM
 opymdiJoNbDMTYSU+cTON1IWthFywI12HBBV6O1Utk90tSTDLP9VK3kLdsp0DGI5MIViADAYIiC
 teHBQVosC1kB0HbbpFcKuoB1Bl8hJFce8kzdU1LlGDMjiFGm57khGAyEuydGJtmyMnm4BW8+kJ0
 MP9QAY6VP3/KMEeX4z4zq25SR8YuAIisXfuHHjQX3iuRhyITjpFFIVXMQpyakapVT6seAaq3Ic2
 oA2bByT+0Tkt/i7kinChISGXLHg
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

To help reduce power consumption, reduce the frequency of the CPU cores
when they sit idle by specifying their supported OPP entries.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi |  6 ++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts     |  9 ++++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi       | 47 +++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
index c71d9624ea277..8392c8cde2cd4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
@@ -19,6 +19,11 @@ chipid: chipid@14 {
 			bootph-all;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		usb0_phy_ctrl: syscon@4008 {
 			compatible = "ti,am62-usb-phy-ctrl", "syscon";
 			reg = <0x4008 0x4>;
@@ -28,6 +33,7 @@ usb1_phy_ctrl: syscon@4018 {
 			compatible = "ti,am62-usb-phy-ctrl", "syscon";
 			reg = <0x4018 0x4>;
 		};
+
 	};
 
 	wkup_uart0: serial@2b300000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 6983ec1b57cbd..08956ac1eaead 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -128,6 +128,15 @@ led-0 {
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
 	tlv320_mclk: clk-0 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
index 41f479dca4555..140587d02e88e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
@@ -47,6 +47,7 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 135 0>;
 		};
 
@@ -62,6 +63,7 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 136 0>;
 		};
 
@@ -77,6 +79,7 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 137 0>;
 		};
 
@@ -92,10 +95,54 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 138 0>;
 		};
 	};
 
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
+		};
+	};
+
 	l2_0: l2-cache0 {
 		compatible = "cache";
 		cache-unified;

-- 
2.45.2


