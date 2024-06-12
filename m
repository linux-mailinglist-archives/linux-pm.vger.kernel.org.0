Return-Path: <linux-pm+bounces-9042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF608905F07
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 01:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C381C22A28
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 23:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3412D766;
	Wed, 12 Jun 2024 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bN3Y4QyU"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165E12CDA8;
	Wed, 12 Jun 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234275; cv=none; b=NtDBoBgT82mCoBlPsE0VBgsTRNbN1izqIgoZYLT3WGyn3Y9mwLFhDhiYQ9mpDObkyABs1VxPitwhnsnp9riVGXZILtRx5LMdrJDL9+lO+X+FACwsHEz5+kxdEEe3Ns4pjcTdRPeUdAkaoYszRatTec/69E0VgsAloEVUkmG2RQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234275; c=relaxed/simple;
	bh=FZHOMpGaEYP5IB+9r4ZvFHZhBO9oepJfS8PBFrnej8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LiaN0oH0aT8ZBFfUeNW59V3d/NOeBHtmbV6ZTGI0a3f55U5ccYXrwsIXS6FvH+gTF8q4yr5SJjfAvlyaao3OS8FB2YFch8SEbghUIze6vZWIrppgYiUGNJow6RjVlxSa7tRYJdsB4BVgI9WI2YSWe9ngOnNno7t+gHl5XLd+RYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bN3Y4QyU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHfsO128870;
	Wed, 12 Jun 2024 18:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718234261;
	bh=pIKhvca1G0LsgNQvLd70jtD8/EP9eisPHDT+bocufdE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=bN3Y4QyUcx9TDpIi7+u3gxXna3UIG0WWYuZl/CwQmP8R7nv93lOxG5cMDFZdOzq8v
	 j7mPhJAkfYch2vu9hNFxZGQIPVRsw3vgxI2pnlr5WCuufxIRhTZVgMqynyWTdqhiN2
	 MxErtEzX2WqiwFLzi0Iv2IUzk0JMw5Yy8p+HmK+0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CNHe90017773
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 18:17:41 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 18:17:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 18:17:40 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHehH019518;
	Wed, 12 Jun 2024 18:17:40 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 12 Jun 2024 18:17:38 -0500
Subject: [PATCH v2 5/5] DONOTMERGE: arm64: dts: ti: k3-am62a: add in opp
 table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-ti-opp-updates-v2-5-422b6747a254@ti.com>
References: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
In-Reply-To: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
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
 b=owNCWmg5MUFZJlNZD7ydNQAAbH///7/ffz83//+/3/5/+9+br5X7f/xi+2qf9Y7/z1Hq7nYwA
 RsbCDRoGhkBo00yAADINMRiDQABkZBk0yZNAANDEBppo0aZDQaAaNGIaBppkyMgGUA00AAAPUPU
 AAANDQ9QAaAGgGmh6gD1NAGjQaaNNBpoHqZoTQ2p6QNA0NAAaIfqh6mhoDTTagAaaaANAZAGmga
 AyGgaAAAAAaGQA0AAGgAaA0AaNqeSZ6oIIkJ0jJf3wjY0ICkKoXGGU4ok/JpGLFGBEqAlqczVTl
 MAJdCXkvkClCbU09aoDPFBl70PLrudeiHcFbIZ5A80B4ShsdLJubf7RRnQrS3WkLndIx7oEZok4
 tFGOCsN3oFdER9YhIKIwhL1hvZhtBLC/iV8UqhB/pQnN4Z8EG339vVZTxXwJVEK6pMhGy06FaAT
 gVM7n2qCJadwsAs5gdhNxiBNWvDUh1c22PapNGCNYqkC4i1cs5lmg34l19S9MhytNV1dd44ZTbt
 vzu12tXutEnYGzfmNo29QMJErO/vBK7XZr0AtUEC0JAxJEVH7zSpwZi38qNu+05rzg6OB+D4sQk
 SJtJLXtRnCUhNePseisccCwKuaym8CK6DevqsnbQCMIB93YGMSqzrTkUx0yIQVPwS5auFfl4Hg8
 dJBUBCmCh/xdyRThQkA+8nTUA==
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


