Return-Path: <linux-pm+bounces-14606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0409842AF
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386EFB26B1A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC42A17623A;
	Tue, 24 Sep 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i12wRdpn"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC8116DED5;
	Tue, 24 Sep 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171490; cv=none; b=U1I3Z8xO3E/Dh8eTnGtD09BnV19EbyHjWLbgFLd4BUMGJiofXelh7+VPmzTasKgCTrzFW4TI/kTSLfh61LitEbUuWS/9vBa6Rlb3iYOAwrXdVQZV+9p3Q+JaorjmRhICFjVLWsMewzvbv4igtnm4ldRmky6XN/wtzByrYNaYV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171490; c=relaxed/simple;
	bh=FzZjOPw1BD3qZNC2dIsjDN3y56BlWcGXa6l+cJcylGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lsHrNy19GXEbfs9O3NsUeA0cb7TDual1H6wdTSf3o+EtascK1QyfOJ5Ju1+EwB6en2dJs4YMSVayuno6A5yzCLEDJ6ennJWDONF6vmmdASZ/9OoLR8+Xv5vSrI+kKLuNw/IC5CA5E0Z/6EmWZmA9zzYZOrqWJJsSDPv8feUjmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i12wRdpn; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48O9pFmn071159;
	Tue, 24 Sep 2024 04:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727171475;
	bh=28nm6GciXd1Z/cAECj7/YWo0gE1W8fU4bL/W7b+3Ja8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=i12wRdpnF6JLyjuw/5i11mILiiXpCKBotEPaHuz/Y2jgvu3mhZiPU5OtjesuuT3gd
	 2OS6h22EcKv2t4WSGh7Z+tIhCP75Cie4x//brNKvW3tLSuLopzQDMG91jj3dG0ItDG
	 YT4WTcWJf5f3ZxEU2meVH0AS62LVcJdYd1cQkqjE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O9pFjG017136;
	Tue, 24 Sep 2024 04:51:15 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 04:51:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 04:51:15 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O9owSs017217;
	Tue, 24 Sep 2024 04:51:11 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 24 Sep 2024 15:20:43 +0530
Subject: [PATCH v5 3/6] arm64: dts: ti: k3-am62p: add opp frequencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240924-ti-cpufreq-fixes-v5-v5-3-cbe16b9ddb1b@ti.com>
References: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
In-Reply-To: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael
 J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>, Bryan Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727171458; l=3849;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=/9L7M8ngafoj6TyntikdD62vQqSW7r8Y6HKG3GFLThQ=;
 b=MJHh8NGKCbIUWuSIJq+jxDOxVAuJ6wyYIG9w6oITqejglwY2K1NrT8XymXVaINLp54fjybjTy
 83pRkHiSKuQBn9oxoVGERyfj2DvypJ4BIqh9u+l17NTYhgD4h3VERp9
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Bryan Brattlof <bb@ti.com>

One power management technique available to the Cortex-A53s is their
ability to dynamically scale their frequency across the device's
Operating Performance Points (OPP)

The OPPs available for the Cortex-A53s on the AM62Px can vary based on
the silicon variant used. The SoC variant is encoded into the
WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register which is used to limit
the OPP entries the SoC supports. A table of all these variants can be
found in its data sheet[0] for the AM62Px processor family.

Add the OPP table into the SoC's fdti file along with the syscon node to
describe the WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register to detect
the SoC variant.

[0] https://www.ti.com/lit/ds/symlink/am62p-q1.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 +++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 47 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
index 315d0092e73664416998cb34d9b9f5fa70a311c2..6f32135f00a551cfea4cc896fc03147271eab9b7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
@@ -20,6 +20,11 @@ chipid: chipid@14 {
 			bootph-all;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@200 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x200 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
index 41f479dca455567c91bbb3a0b75d13810ea11157..140587d02e88e9d391c41001643ec715d41bf262 100644
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
2.34.1


