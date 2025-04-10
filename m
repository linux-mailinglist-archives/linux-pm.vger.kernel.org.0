Return-Path: <linux-pm+bounces-25141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA85FA8489D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803B13B7520
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54AC28F930;
	Thu, 10 Apr 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG2TpuqM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A128EA7F;
	Thu, 10 Apr 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300077; cv=none; b=qhcORsP1VxRoi4wRtrPJFnrBGJpI72oGh8TUklHILb5mN+dYjn4cIRfvtJgRucIjGOgCD4+8v/7iFwcE2SOjSdo6GMPHqNWBRVRDhZ1+Lr2AzZTIy2J5mUpS8Q9UZHEQ5ac1vVDBUcZU3Nl1eappS/NZJmgNJs8qhXhlo/HPqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300077; c=relaxed/simple;
	bh=w8D/oQlbjYFMA654Kfwwvab2rVq8372zGCPcqKW1Iu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVSxWQul8mRTcH4cdvjnyylSeqD4HXdcq20LU//2dW5GCX2NePYYFhlmVqI0QupN3Uaa4LcqgWXmzqDCMBLEfYyVuJJnYSM8vDzdXRntb0VjFRjTP9cDiERQMz3IjQGp1VMjU36WkkY9sWyJqjPY+5aXfXoMq8gJgUOrRh80/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG2TpuqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3ADC4CEE8;
	Thu, 10 Apr 2025 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300076;
	bh=w8D/oQlbjYFMA654Kfwwvab2rVq8372zGCPcqKW1Iu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fG2TpuqMMHHyYZtykHxBYOOreDpwV+ldhF4Z5Qy+/+1VXWQ49leBhORYlyDtMvG/U
	 s0WqonhwLJRWz0RL+p1Pn0QquD9o35gsf+po8VW6kll00ijBpV0kRkUFtAN8tW/UPD
	 qYfRXrcQ1KCnPHN8qNAPaYn7F+b8tWIiL4aR0n5C3a6Fq7S12sz5nXEnBcuZFyvaGn
	 cSuVuT01eLQbeYBv51ckvqUHv3N9rjCw/uF9DlZTS4EKdamYhxQ4/Zh/EJtAFERtPU
	 FFNHgAu3/FaAT+jqRU1sI5ZiGte/aL2KnKPX5eJUdd2+unfwIwf6LeZPkclUmONFY7
	 wOKwYMsAvfkSA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:28 -0500
Subject: [PATCH v2 07/17] arm: dts: qcom: sdx55/sdx65: Fix CPU
 power-domain-names
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-7-63d7dc9ddd0a@kernel.org>
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
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15-dev

"rpmhpd" is not documented nor used anywhere. The power-domain is used
for performance scaling (cpufreq), so "perf" is the correct name to use.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Use "perf" instead of "psci"
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 2 +-
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 39530eb580ea..20fdae9825e0 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -57,7 +57,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			clocks = <&apcs>;
 			power-domains = <&rpmhpd SDX55_CX>;
-			power-domain-names = "rpmhpd";
+			power-domain-names = "perf";
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 	};
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index 6b23ee676c9e..c8e312dcd26b 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -58,7 +58,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			clocks = <&apcs>;
 			power-domains = <&rpmhpd SDX65_CX_AO>;
-			power-domain-names = "rpmhpd";
+			power-domain-names = "perf";
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 	};

-- 
2.47.2


