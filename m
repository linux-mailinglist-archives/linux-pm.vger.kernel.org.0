Return-Path: <linux-pm+bounces-25142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7600A848A1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB858A4CB3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4DE28F95F;
	Thu, 10 Apr 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIQUvuA3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23E28F95A;
	Thu, 10 Apr 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300079; cv=none; b=IiplnWLOdbzRKRwp5VnXT29aPEB9DqtnxSNpdSRDze0hipEyfQZ6Uj2Ugx+eUGJEpIaYl4zdSASgJHrNmvKjm/ZUmskQy3ROPPS7zjwviF8POmjZnewZY+lM5uMaWPMEXBAQbcrCraIuTijn5qVTuWstFPchgi2xojfcYRg6sEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300079; c=relaxed/simple;
	bh=rxpmdQ00QIobReD/bCkMksNDeC2yXxfKVAGTAYhvgkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3z9N4D5hr9gESpXh3zdGyfpeRRlexJZP0MPWLylqtVU7TrUXduaMQ9Pj2B6pKnizCY9Z/KL0Ay4BOjqgU4eZsR+Y3Eyy+sFuue7mBVXDKQ8aH5nMg9iAiQXB3wg2Hx3aiPAK7CknvM+G6ilL09kiWxNgSUlrt9GGpcTd7wLwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIQUvuA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F97AC4CEDD;
	Thu, 10 Apr 2025 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300078;
	bh=rxpmdQ00QIobReD/bCkMksNDeC2yXxfKVAGTAYhvgkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iIQUvuA3gCshAauWH6zqRI+XnRTwwMXV9I3TGGqvy/FEER7QJ7uNg9cI44qlxasr5
	 R+ZaP9NiVZ34J1QGpo5SeLFChNsPeTgAxjM27nsqqT4e3WUqtyKOsQLY/aVPEunLoj
	 m/wI1Hh9QqYtsFJ6rwrqHfViwqaTpORKlJy6QsjVkjPiSww29Trsj7jmsrdWY+hlSg
	 MiLq+RXW8Pv/nuX92JbMAqgRxs026LTnIx1WqmLlezoEukSV6ShwHIzhAlypfoJq23
	 zgY8buBGUkvYk1b+aZru6NhR15CWbwZqMBVTjo/NhBVD9EaxYG/+4t0ydMjHFfl1S1
	 js7HvMT+iaIqQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:30 -0500
Subject: [PATCH v2 09/17] arm: dts: qcom: ipq4019: Drop redundant CPU
 "clock-latency"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-9-63d7dc9ddd0a@kernel.org>
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

The "clock-latency" property is part of the deprecated opp-v1 binding
and is redundant if the opp-v2 table has equal or larger values in any
"clock-latency-ns". The OPP table has values of 256000, so it can be
removed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index 06b20c196faf..fceb2f5f5482 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -53,7 +53,6 @@ cpu@0 {
 			reg = <0x0>;
 			clocks = <&gcc GCC_APPS_CLK_SRC>;
 			clock-frequency = <0>;
-			clock-latency = <256000>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
@@ -67,7 +66,6 @@ cpu@1 {
 			reg = <0x1>;
 			clocks = <&gcc GCC_APPS_CLK_SRC>;
 			clock-frequency = <0>;
-			clock-latency = <256000>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
@@ -81,7 +79,6 @@ cpu@2 {
 			reg = <0x2>;
 			clocks = <&gcc GCC_APPS_CLK_SRC>;
 			clock-frequency = <0>;
-			clock-latency = <256000>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
@@ -95,7 +92,6 @@ cpu@3 {
 			reg = <0x3>;
 			clocks = <&gcc GCC_APPS_CLK_SRC>;
 			clock-frequency = <0>;
-			clock-latency = <256000>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 

-- 
2.47.2


