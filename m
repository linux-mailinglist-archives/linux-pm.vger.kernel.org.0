Return-Path: <linux-pm+bounces-15333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2A994F32
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55FB280D76
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1C1E04A9;
	Tue,  8 Oct 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kMvbVmfv"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A201DF724;
	Tue,  8 Oct 2024 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393817; cv=none; b=uCwlOhdFh1GMouXdH9XB9pETf4G5t+I41hejdsNVTNAjNO8ubNiS2GADdjs66tsbzqZVF0Ov8rXDE+fgsiRVim+wuuwu3wA8Vr6fGf2ZVZPZcrk8X+Ge5w9WFROcGrTK4wLHfBSdnZ3uBLQ8THTl2EVlQL6mImt+RbMV3Dm78Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393817; c=relaxed/simple;
	bh=wqPQuHbhKv4rbzJNxhFK1J3eXBcR+OlBK+gCRy0PAoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkPw/vmIWmzWf8EU0Y86pGdTNi900P+J1dJuSW85Ep+1+B8Bb8+6zPX8D7TrTILhM/aq0INUgQWyR3NwA5UWl7VMGRyBbcy+eHl8M5d/c39U1oC6TLGL1YTDfF9bXD4LOc6QLuf59wGMtqmwyIY9UGBu6zmbQqXTIzUu0dxXbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kMvbVmfv; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 498DNU7A089967;
	Tue, 8 Oct 2024 08:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728393810;
	bh=4niss5kr0/Q+OFy6g/XNmhMGlJTtPOnZT3SJxQ8f0iw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kMvbVmfvfYX1m+SiHyRqKHpumB8qK8f/x5hvygq3R0i0RdH65kAOpc9/p+EV43etI
	 H4rzZJ/kfAHEmHrObZ0IO10fx50R7IjWdkqA2hHlBVs+e7jaKk4ekBsR4qezJ6ADiR
	 6ETDzYr5gl5gdoKS3D9tNMsdPGWxz65GAC+8CnTw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 498DNUYR058231
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Oct 2024 08:23:30 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Oct 2024 08:23:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Oct 2024 08:23:30 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 498DN82F098273;
	Tue, 8 Oct 2024 08:23:27 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dhruva Gole <d-gole@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH V8 3/4] arm64: dts: ti: k3-am62p: add opp frequencies
Date: Tue, 8 Oct 2024 18:50:52 +0530
Message-ID: <20241008132052.407994-4-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008132052.407994-1-d-gole@ti.com>
References: <20241008132052.407994-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 .../dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 ++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         | 47 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
index 315d0092e736..6f32135f00a5 100644
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
index 41f479dca455..140587d02e88 100644
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


