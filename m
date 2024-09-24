Return-Path: <linux-pm+bounces-14605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6E99842A0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 11:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D33B1F21A1B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C316F827;
	Tue, 24 Sep 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cjn+qqAs"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661181AB6;
	Tue, 24 Sep 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171488; cv=none; b=WcGVnoDAtNCz4hdwat0Kix2DrRxJdPm5I58OLIMqP3kbZia8MKOt89G+cH7qmWmmQ2xfIVcR/ZssviPpZClkdMAzf5YaoHv/IU3lrwWMaMxj2nltskEpH95wF1JOpPKseYWdoHSTassGwpbdFuL0LrDTbHRzi90OifRHPyThnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171488; c=relaxed/simple;
	bh=VnrBJBrjcf3aALLSxOaCd0GOye6p5E+Bvu2I81GeIwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cyOmZjst0UGKbISCp+Za9he5qfAaGI5AUl+GIuBTpWQR1eUBdtUwCaVKMHVXXy6aruQ3vnHdYReEsHBazxBuPkcbr4DR6ZJgxUOZTDTSJEYbzmyxDZIjHmsHpKn/QVtuGT8G5y42r2ib6xWmu3NBayQ/7qb/qLrFXgyMGGIVzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cjn+qqAs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48O9p7bZ120010;
	Tue, 24 Sep 2024 04:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727171467;
	bh=+nInyqhFC3BdNTlgq3xlhiMTc4jzcWvJSd9GJ9RnehM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=cjn+qqAsZbDMkkAO2jWCpcPrttUHLzwC02kLuXveAlq1qiWmpBtnI7jyUaqfsqfE0
	 AO2ENLisis981dSEq61QVaRp67nVgF7iU97jWfdEfUsgJGvE8tohm8xSndZZ86dXEz
	 VXjHbiyQMVCwFW4tD7jIA1zy+4np99ut2XbY/vlk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48O9p7L0000919
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 04:51:07 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 04:51:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 04:51:06 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O9owSq017217;
	Tue, 24 Sep 2024 04:51:03 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 24 Sep 2024 15:20:41 +0530
Subject: [PATCH v5 1/6] arm64: dts: ti: k3-am62a: add opp frequencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240924-ti-cpufreq-fixes-v5-v5-1-cbe16b9ddb1b@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727171458; l=3780;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=h4Lsswdhctun8wxkRbSRUFWd5uwJNN09QzsFaxwDKNE=;
 b=A/wCvjDQDDRtnZQgHYDMhGRnoMMBksTv2YryY/5MJ+iEL+xCkzXIY3ssgHHBD6jlbdoXgg9Rt
 WioPGYrsD7CC/pjzneGQXFy64U1XDkGWzInHmax6iQV/EdoJ01R/yM0
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


