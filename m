Return-Path: <linux-pm+bounces-38712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 087FDC89EB1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 14:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDF9E4E5D55
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4872139CE;
	Wed, 26 Nov 2025 13:05:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490451DF254;
	Wed, 26 Nov 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162324; cv=none; b=SWnogxR9u2Sz86X84Aw62S+LlYxXBoFW/qxHviNi0wE92T+2jAwUxeZw45DCdRBjYRqS1pqOjgh81peBY83oDt8Mjqdwml71uOFPYh1kz6hBmkCleYV6ZOGh52455DcMT3QetUNfIs+lZ3cxheshDlJb0EXAgAQCqEmXeYapWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162324; c=relaxed/simple;
	bh=dCxGVXgrNmiUWIIRS4W+ffmBeZIJ0fnk2b4Rdl0mECg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRjj2ro8wB+d2hJxSkDyCcb3bTypk2vZt8UYfwwfAjStiHhEOmj8dBKjx4DxDD1K6P0FwD9cZ46lZABYuAm1Ujn9vgC1+KRNx934a2G1j0cYqwi2wVphE3sNnJlfDQSdSGEJ5/jBlU4Y2MoPC0YdoyECwZcRtG/7sNtEikks0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: hf+NBYPLT+ixOgXFVZVW2A==
X-CSE-MsgGUID: h9KrqPrcREqIf+5DXkXDGg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Nov 2025 22:05:21 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.98])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8EEF6400EF74;
	Wed, 26 Nov 2025 22:05:16 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 6/9] arm64: dts: renesas: r9a09g077: add OPP table
Date: Wed, 26 Nov 2025 15:03:53 +0200
Message-ID: <20251126130356.2768625-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add OPP table for RZ/T2H SoC.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
V3:
 * no changes

V2:
 * no changes

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index f5fa6ca06409..ca61f7846c5e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -14,6 +14,17 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -24,6 +35,8 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_CA55C0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu@100 {
@@ -32,6 +45,8 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_CA55C1>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu@200 {
@@ -40,6 +55,8 @@ cpu2: cpu@200 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_CA55C2>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu3: cpu@300 {
@@ -48,6 +65,8 @@ cpu3: cpu@300 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_CA55C3>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		L3_CA55: cache-controller-0 {
-- 
2.52.0


