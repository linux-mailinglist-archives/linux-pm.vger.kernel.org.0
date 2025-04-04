Return-Path: <linux-pm+bounces-24778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D21DA7B628
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C6A178FD6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5418C337;
	Fri,  4 Apr 2025 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngLHJxNx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2218BBAE;
	Fri,  4 Apr 2025 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735587; cv=none; b=PVitVn5mwQ+trZ1BC/KoT9GA9ZLh+CDtArxGUzwm+FyK9PdeBtE3FZnN/R0XOVSMMrjGJW5o/ctppzhUDPHejhQj5fIMPexqL/kFhSLbkFsgVSM9t5Igal7PRnu2nhDuABYDHYm6NR7LRgVW4alI310hLMbVnHfxSutxgXOHYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735587; c=relaxed/simple;
	bh=6GCFc3TOy1LAHhIH0FHC3IwyJd+TMm/GWKIlM1Cgt/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xwcj3M4bYb/Pkix0vHiMBN+wn4dW+LCKtK5O0+CyV98t8Whzu01g+edIpU0hgdzYKodx/3L0nJZdLycMWsNLjkIWpNaNrCQmeY+5oF9wmt30HZXTY40k8PzGglpZnCd0ZHoMeTPJzkgoj8JvykZCHWBh+3/9hSotpo7uGn0CO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngLHJxNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AC8C4CEE3;
	Fri,  4 Apr 2025 02:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735587;
	bh=6GCFc3TOy1LAHhIH0FHC3IwyJd+TMm/GWKIlM1Cgt/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ngLHJxNxnM7sSXQ/6PRU0/L8GowkeGVz0Ortjzfu1yG8wov4Gpm+9CtRA4A+TLiG4
	 bCFnTdm7eePjs27Jwo2iOOLCf9C0vJc14qGDQxWUpH51Jzq2AntWhJ5ymBtGZvNQM5
	 UOVBRJCOirbMZ6VBEwvR5DJnz4mNMbLs2JgfUfC+cZRb4F0YYVCbJoAPB2Z7qSiVhj
	 h7Ov7J5cOOmAEVS9IgbJr/thA2JvOUu8QffoaJQlg7noZ4NdGuPX9mhxF/OmZReIaP
	 N/HEf3FZg5HDKq2z+hCE1TRDsJW1iYSq+Hc0EkC+HchK0tEXoPYfIBHDYWOcRUnDsn
	 hraIn9sJZ6Tvw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:26 -0500
Subject: [PATCH 05/19] arm64: dts: qcom: qdu1000: Fix qcom,freq-domain
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-5-076be7171a85@kernel.org>
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

The correct property name is 'qcom,freq-domain', not
'qcom,freq-domains'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index f973aa8f7477..7c8d78fd7ebf 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -47,7 +47,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			power-domains = <&cpu_pd0>;
 			power-domain-names = "psci";
-			qcom,freq-domains = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&l2_0>;
 			l2_0: l2-cache {
 				compatible = "cache";
@@ -70,7 +70,7 @@ cpu1: cpu@100 {
 			enable-method = "psci";
 			power-domains = <&cpu_pd1>;
 			power-domain-names = "psci";
-			qcom,freq-domains = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&l2_100>;
 			l2_100: l2-cache {
 				compatible = "cache";
@@ -88,7 +88,7 @@ cpu2: cpu@200 {
 			enable-method = "psci";
 			power-domains = <&cpu_pd2>;
 			power-domain-names = "psci";
-			qcom,freq-domains = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&l2_200>;
 			l2_200: l2-cache {
 				compatible = "cache";
@@ -106,7 +106,7 @@ cpu3: cpu@300 {
 			enable-method = "psci";
 			power-domains = <&cpu_pd3>;
 			power-domain-names = "psci";
-			qcom,freq-domains = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			next-level-cache = <&l2_300>;
 			l2_300: l2-cache {
 				compatible = "cache";

-- 
2.47.2


