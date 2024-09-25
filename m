Return-Path: <linux-pm+bounces-14683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE70986212
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98AE1F2AE3C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD0118800B;
	Wed, 25 Sep 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lptLDK1e"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7CF187FF2;
	Wed, 25 Sep 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276093; cv=none; b=KXOdbG7nwumPgIwDFBnowu24ZR94UC3erIi2uUUfup8wMqAUkkG4UNa65CsGVmnl2aY9Ch366QVuCtRUEarzMsOOS7f7Ed7XrNb2EOKsJzCqAh5UiMoU4b0HssMOvkRn8lBUAu84oQr2dYcT+CwrA7NWP9KezWx+eM83Fdgr8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276093; c=relaxed/simple;
	bh=VnrBJBrjcf3aALLSxOaCd0GOye6p5E+Bvu2I81GeIwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pjycAyDHzSn7f+tjLRRC2EWIw3oqYOkMnq0YcCz9woYis7jO4aQgmzxxpecflWsRUUEN9iirCzSOfgd3E5Zd83W7/NWAByqb5NXsQeFsg6cQ+YVDB+PBangRFZSGS4srYya7mQ9iZ17lTL50Tg0dyjnv2//qbUvZuc6+lrZNG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lptLDK1e; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PEsiIt019874;
	Wed, 25 Sep 2024 09:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727276084;
	bh=+nInyqhFC3BdNTlgq3xlhiMTc4jzcWvJSd9GJ9RnehM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=lptLDK1ehW793tio6hxoNjpKLVbCxI0sIpuFrAue55J5l57fEsKkvtvenJtEpxLHz
	 /4KjJ2oQU4LwBFpUkouuwSxj3zSqQycqRu8xdzJKtBQctQaC/4xig9helIYBuMbJYD
	 UzEyGwgb+K60FHCs86M+EdEhgn+xbnnX3Ew5vqSs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48PEsh4H091833
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Sep 2024 09:54:43 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 09:54:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 09:54:43 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PEsYCi110564;
	Wed, 25 Sep 2024 09:54:39 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Wed, 25 Sep 2024 20:24:15 +0530
Subject: [PATCH v6 1/6] arm64: dts: ti: k3-am62a: add opp frequencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-ti-cpufreq-fixes-v5-v6-1-46f41a903e01@ti.com>
References: <20240925-ti-cpufreq-fixes-v5-v6-0-46f41a903e01@ti.com>
In-Reply-To: <20240925-ti-cpufreq-fixes-v5-v6-0-46f41a903e01@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727276075; l=3780;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=h4Lsswdhctun8wxkRbSRUFWd5uwJNN09QzsFaxwDKNE=;
 b=neBvRmpaoiH5bR5BrMbYNBXtdJ9VRDdan67hMh+LFdPbVDLL0gFT/rxAUMJERZz9YX610sSeU
 W9AUIHowtrECbs1s2lagyzpUzexC8O/deODm5bVzGgQi/bO4WcJYB4B
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Bryan Brattlof <bb@ti.com>

One power management technique available to the Cortex-A53s is their
ability to dynamically scale their frequency across the device's
Operating Performance Points (OPP)

The OPPs available for the Cortex-A53s on the AM62Ax can vary based on
the silicon variant used. The SoC variant is encoded into the
WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register which is used to limit
to only OPP entries the variant supports. A table of all these variants
can be found in it's data sheet[0] for the AM62Ax family.

Add the OPP table into the SoC's fdti file along with the syscon node to
describe the WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register to detect
the SoC variant.

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi       | 51 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index f5ac101a04dfa0bdae8ac4f43b01473725433c51..0b1dd5390cd3f42b0ec56bab042388722b4c22a1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -17,6 +17,11 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@200 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x200 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
index f86a23404e6dde3ca90e41ac0efdb378948e6d50..6c99221beb6bd8e5ad93888e6b659cc6e08fb679 100644
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
2.34.1


