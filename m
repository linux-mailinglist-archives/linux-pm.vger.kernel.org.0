Return-Path: <linux-pm+bounces-24782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7415A7B638
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9258A17782F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB019F48D;
	Fri,  4 Apr 2025 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdLsVFPS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8919F10A;
	Fri,  4 Apr 2025 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735594; cv=none; b=LJSv96gKStWGIH0i46vZAvk2qWN7SzWsBWnq/y4eTOXqI6/PnKObsTWXxSIvj5UDQtQqntNPIwCmHhXbUrAkN8T/RgD5icVW5TUmZ2cWGxiqoqNBvqirJeMBiDqFLGpvrl4BsxGorQrCeQydlqoum0090iquV5MEEM1dHfhyMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735594; c=relaxed/simple;
	bh=1W6pnPI2cQreK/3+uRQUHI1ov/YAXvY/bkfHhelXghU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfeWP8b7m/hzLTyRmJ37Oz/Ro9KQrwT73PtpsEXa+rU02LDjw5fiXYl4VV7U3NRa4NerczdSLUlCOAO5t7cql+/GO0cmZsGaKr0YkxnqZ/mqjOm6UW9CtpgMfWoT49HeNqqrrXSHyW8SOpHhg7OZVp8wxk178aeqh44XhbPCnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdLsVFPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C76AC4CEE3;
	Fri,  4 Apr 2025 02:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735593;
	bh=1W6pnPI2cQreK/3+uRQUHI1ov/YAXvY/bkfHhelXghU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GdLsVFPSPAzYBAvq539ZzBXsdV331WjtxuwM2qUxhzUdt56UPc33KEAtCXWymZboA
	 Xqnktp3sh/XpKkjPwQ3eobyzfRsUtvBVCoQS5qeq/6fsr3BXauJ/ePBcaokzPWlWiy
	 G9iMmBqkj5xkX4YVCwshcoXdrU4KiF7VJnZtxyww2fsu52Fu/eTEx7rax/36xxr7lB
	 th/RHNX1p6qaubojJKCMRYZz+neBX6eJgKCm6pR6/ACSKgrfLr31J+RCRvDXXEI7fo
	 5PBzr7JXyURO63S0RDpJfsN2CzW3IYZC4xYP3ghIso/ijjEJBp1c/zraQoVAZ8ptE9
	 S1lLwK2TnC1fQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:30 -0500
Subject: [PATCH 09/19] arm: dts: qcom: sdx55/sdx65: Fix CPU
 power-domain-names
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-9-076be7171a85@kernel.org>
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

"rpmhpd" is not documented nor used anywhere. As the enable-method is
"psci" use "psci" for the power-domain name.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 2 +-
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 39530eb580ea..64d9858b4248 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -57,7 +57,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			clocks = <&apcs>;
 			power-domains = <&rpmhpd SDX55_CX>;
-			power-domain-names = "rpmhpd";
+			power-domain-names = "psci";
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 	};
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index 6b23ee676c9e..bfd04e53c5a8 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -58,7 +58,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			clocks = <&apcs>;
 			power-domains = <&rpmhpd SDX65_CX_AO>;
-			power-domain-names = "rpmhpd";
+			power-domain-names = "psci";
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 	};

-- 
2.47.2


