Return-Path: <linux-pm+bounces-25137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E29A84888
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC8218820CF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2928C5C9;
	Thu, 10 Apr 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp2pgYbw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1328C5A1;
	Thu, 10 Apr 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300072; cv=none; b=QySQ8T+8NmGc0l560uMqcholIr9JJJYVhNhMluh81aN6hEOpC5NONuNJ4v2ljutxzlyhP6oyzjxMn+6+Qm7CPGx6FgQBH9bdnJHQpT9Pu5re0VViY3keG95MXibu7IFcElF2zb1l1ha9idSfnG6TjxVpq0yrUbj6iT4mM0SIkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300072; c=relaxed/simple;
	bh=zdpdwCUxt4/JGxD9zT4n5tnKqmSCQRjKtGwRibbyTKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6sgO7u6q9lVb3cFwaoquVXV7E5KWaOZua7+SW0IgzPX4mPfhFQQgRM6uhZsxHUNg0cntYrC2I6EwyCh0O3QuzjirpkC4q+vwfKkVEHkvE/2qerIIOJp/HzyhfIGM3EejKhIBBwymrxxJhsGKw5UScnbttWAmMwI6EauBNhr7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp2pgYbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D35C4CEEB;
	Thu, 10 Apr 2025 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300071;
	bh=zdpdwCUxt4/JGxD9zT4n5tnKqmSCQRjKtGwRibbyTKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tp2pgYbwXQf4eNwmKaH2Y9ewJRXbwjukqmEfd7gasC1BhxcwjreBEF/j1FACoOJ3n
	 fKdwiHbTde/95llhHDX8LEPLU4Q4kNtch6X4Gtag9EjN2DFSU8oWDvoTpT/y2sS1Pn
	 YmTtSWsXG0o9T5Sg1Jk0GmoLLj5liyC4MKb2I4in0MtWDSMgjb7jQH7P54PdHi0Fge
	 /tyeSwBW8Wh77LfjdWWAOh6WEV2iDOQG5FKK3zDdiLTqnwsmbzSybdW8BOIUXAcbdX
	 0UJ7W6RDn1M45MgKlVI+3jHU6otRqGgsNJieEZO0dRqPBzL4/hTBj9ujca+//zyDCU
	 vOQslelhGs3xw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:25 -0500
Subject: [PATCH v2 04/17] arm64: dts: qcom: qdu1000: Fix qcom,freq-domain
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-4-63d7dc9ddd0a@kernel.org>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
In-Reply-To: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Conor Dooley <conor@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Andy Gross <agross@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev

The correct property name is 'qcom,freq-domain', not
'qcom,freq-domains'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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


