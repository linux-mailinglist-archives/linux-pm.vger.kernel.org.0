Return-Path: <linux-pm+bounces-24781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFDBA7B64F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435F9189C045
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8D119D886;
	Fri,  4 Apr 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGzlfMKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B313B2BB;
	Fri,  4 Apr 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735592; cv=none; b=SmBpb2xZXgTxTKDrxXr12pY31I620VjYsxWmXVCNecWRE2utAjIYIpEKMN6Mudf+EHwt7MiUNJ4CTQshs4k59yKs16xJr/3Q15XxAP0xuVdT8bxAUhnwSnSCXtGmw6dhcoeN6wxTUSxpncLnRw1xCuXOa9XPuDUPr3xCNsUDFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735592; c=relaxed/simple;
	bh=NXfOJoK0Dz0mef/BAq7y8KxDDG3duFbiuiL1Z6QJ9BI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=notKgkXuQIbGCaCqoPTV4WYTP0ZBMSu+PIwUyCbScNE4HGR5ll3CUb7cyuI0TJKcSi/s58xY++LxgoqaQm3U8pEkRu1hVQpHRC93u798+lN8IE/llJqOgcR+O4YNRo79My/6X5AFwOTTJuVfUMPoHwPRGOyzwai0T1CiffMzAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGzlfMKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE6DC4CEE7;
	Fri,  4 Apr 2025 02:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735592;
	bh=NXfOJoK0Dz0mef/BAq7y8KxDDG3duFbiuiL1Z6QJ9BI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sGzlfMKi1upb46KlxcbmpIatBcJlDA+lJRioYblOpv5TuMcIgUURlrFv/QVkqvcTU
	 cqjZ3jite7u9/lrkFPtYLaZQU+UPcpDjuKKwQKVdaz05Zt2Wg2bX8aD21CBMmgztP/
	 597TFjZnnA5cS1HbMOvLF6ZZO6RT4hAa1J+fA2rlUycXmgZf53mYjv6qE+Elqb9F7E
	 V6LVIXszs4tasfp/HFFOFuNBTRwJoQvjb168YTZBNWldrVQST227wqM+8fQaQlV3RP
	 O1V2tZKhlzmE6O5RVW6E9/CixcMg8/3k12lNJLB9F/Ieoqt9oPG0IvqU/qqu+JWsS6
	 zwQKoFaWCIVXQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:29 -0500
Subject: [PATCH 08/19] arm: dts: qcom: msm8916: Move "qcom,acc" and
 "qcom,saw" to 32-bit .dtsi
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-8-076be7171a85@kernel.org>
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
In-Reply-To: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
 Conor Dooley <conor@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org, 
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15-dev

The "qcom,acc" and "qcom,saw" properties are only used with 32-bit
kernels. Of course, booting a 64-bit or 32-bit kernel shouldn't matter
to the DTS, but the "enable-method" is already different for 32-bit.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi | 8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi        | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
index 94b7694eeeff..594cc4a3a78b 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
@@ -4,15 +4,23 @@ / {
 	cpus {
 		cpu@0 {
 			enable-method = "qcom,msm8916-smp";
+			qcom,acc = <&cpu0_acc>;
+			qcom,saw = <&cpu0_saw>;
 		};
 		cpu@1 {
 			enable-method = "qcom,msm8916-smp";
+			qcom,acc = <&cpu1_acc>;
+			qcom,saw = <&cpu1_saw>;
 		};
 		cpu@2 {
 			enable-method = "qcom,msm8916-smp";
+			qcom,acc = <&cpu2_acc>;
+			qcom,saw = <&cpu2_saw>;
 		};
 		cpu@3 {
 			enable-method = "qcom,msm8916-smp";
+			qcom,acc = <&cpu3_acc>;
+			qcom,saw = <&cpu3_saw>;
 		};
 
 		idle-states {
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8f35c9af1878..88e452752de6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -144,8 +144,6 @@ cpu0: cpu@0 {
 			#cooling-cells = <2>;
 			power-domains = <&cpu_pd0>;
 			power-domain-names = "psci";
-			qcom,acc = <&cpu0_acc>;
-			qcom,saw = <&cpu0_saw>;
 		};
 
 		cpu1: cpu@1 {
@@ -159,8 +157,6 @@ cpu1: cpu@1 {
 			#cooling-cells = <2>;
 			power-domains = <&cpu_pd1>;
 			power-domain-names = "psci";
-			qcom,acc = <&cpu1_acc>;
-			qcom,saw = <&cpu1_saw>;
 		};
 
 		cpu2: cpu@2 {
@@ -174,8 +170,6 @@ cpu2: cpu@2 {
 			#cooling-cells = <2>;
 			power-domains = <&cpu_pd2>;
 			power-domain-names = "psci";
-			qcom,acc = <&cpu2_acc>;
-			qcom,saw = <&cpu2_saw>;
 		};
 
 		cpu3: cpu@3 {
@@ -189,8 +183,6 @@ cpu3: cpu@3 {
 			#cooling-cells = <2>;
 			power-domains = <&cpu_pd3>;
 			power-domain-names = "psci";
-			qcom,acc = <&cpu3_acc>;
-			qcom,saw = <&cpu3_saw>;
 		};
 
 		l2_0: l2-cache {

-- 
2.47.2


