Return-Path: <linux-pm+bounces-24773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2201DA7B606
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 04:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058E53B8810
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 02:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9828D84A2B;
	Fri,  4 Apr 2025 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DInFV6Zz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9A2940B;
	Fri,  4 Apr 2025 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735582; cv=none; b=QdCGRTlFKvqA0tTq79/yv41gWNPRuz+ghLFdkaun49H2SJ3syq8o69oZdzPl1KiYUN7lwo0zNauMv4lNa/viWN+5EnU9w9N7VTG22z3F/JmlE206S+XzfC7xB/wigaws8P48vs2+vV9r5Oi2ifmiWmgKyuyl2EqdW6PR2nCRMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735582; c=relaxed/simple;
	bh=R97K1edD4zHvzCCaN7fvUpcILyjz5fPxwxzTH3c208Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k3DG/IxuSLJ22FF19hOLr2kbkty9UYL4+uWPFPld1sj7EB9gTBLAT3YgNOXkpsuPNqy0fO31bVkwb0cVPFKQ3TAUpJAv72dHhUVW8/Jx84weWNCnGaCludFQIohFBrLkI7SWljZNHOOA9T4qfasrVekKCRmaTZaASK3yEvU+45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DInFV6Zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770AFC4CEE3;
	Fri,  4 Apr 2025 02:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735580;
	bh=R97K1edD4zHvzCCaN7fvUpcILyjz5fPxwxzTH3c208Y=;
	h=From:Subject:Date:To:Cc:From;
	b=DInFV6ZzZBtDCjprD0wNsyVhBlrl/OLVq59Qc8WDA3UnSu6pzYrn/+z8sAldu048T
	 ECwlYcs9UBoRPnPvxrGuu3EVcEF6J+/4r0wCEVgadFKl7SSEGWPQGtFvgKZ1uGx6Gw
	 NTLPe6lvFsgBfDYD7MVxeaup6ebGs1VhLDI2kWsioUB4+zEg5amoqw+NwiA92bLggV
	 DiTcm1B9ZIta65dj/bHTQlKbhzaJ+b8ojif64yPJtiGJ9m0NXcBKtR4YA89r3Wz/hE
	 JDizBDNh1vovQRv3FZYw5ee6m1E8APjoQChggwO8qym2IVuWiSgZhxgZi6eSXcB4yL
	 +O4eazKiulj1g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 00/19] Arm cpu schema clean-ups
Date: Thu, 03 Apr 2025 21:59:21 -0500
Message-Id: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAlL72cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNj3ZQS3eSCUt3i5IzU3ERdE4tUM7Nk8zSzREsDJaCegqLUtMwKsHn
 RsbW1AGXLomtfAAAA
X-Change-ID: 20250403-dt-cpu-schema-48e66c7f6a90
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

The Arm cpu.yaml schema fails to restrict allowed properties in 'cpu' 
nodes. The result, not surprisely, is a number of additional properties 
and errors in .dts files. This series resolves those issues.

There's still more properties in arm32 DTS files which I have not 
documented. Mostly yet more supply names and "fsl,soc-operating-points". 
What's a few more warnings on the 10000s of warnings...

The .dts files can be taken by the respective SoC maintainers. I will 
take the binding changes.

Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
---
Rob Herring (Arm) (19):
      arm64: dts: allwinner: h5/h6: Drop spurious 'clock-latency-ns' properties
      arm64: dts: broadcom: bcm2712: Use "l2-cache" for L2 cache node names
      arm64: dts: morello: Fix-up cache nodes
      arm64: dts: microchip: sparx5: Fix CPU node "enable-method" property dependencies
      arm64: dts: qcom: qdu1000: Fix qcom,freq-domain
      arm64: dts: qcom: msm8939: Fix CPU node "enable-method" property dependencies
      arm64: dts: qcom: msm8992-lg-h815: Fix CPU node "enable-method" property dependencies
      arm: dts: qcom: msm8916: Move "qcom,acc" and "qcom,saw" to 32-bit .dtsi
      arm: dts: qcom: sdx55/sdx65: Fix CPU power-domain-names
      arm/arm64: dts: imx: Drop redundant CPU "clock-latency"
      arm: dts: qcom: ipq4019: Drop redundant CPU "clock-latency"
      arm: dts: rockchip: Drop redundant CPU "clock-latency"
      arm64: dts: amlogic: Drop redundant CPU "clock-latency"
      dt-bindings: arm/cpus: Add schemas for "enable-method" dependencies
      dt-bindings: arm/cpus: Re-wrap 'description' entries
      dt-bindings: Reference opp-v1 schema in CPU schemas
      dt-bindings: arm/cpus: Add missing properties
      dt-bindings: arm/cpus: Add power-domains constraints
      dt-bindings: cpufreq: Drop redundant Mediatek binding

 Documentation/devicetree/bindings/arm/cpus.yaml    | 220 ++++++++++--------
 .../bindings/cpufreq/cpufreq-mediatek.txt          | 250 ---------------------
 Documentation/devicetree/bindings/mips/cpus.yaml   |   3 +-
 Documentation/devicetree/bindings/opp/opp-v1.yaml  |  18 +-
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi               |   1 -
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi           |   4 -
 arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi       |   8 +
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |   2 +-
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |   2 +-
 arch/arm/boot/dts/rockchip/rk3128.dtsi             |   8 +-
 arch/arm/boot/dts/rockchip/rk3188.dtsi             |   1 -
 arch/arm/boot/dts/rockchip/rk322x.dtsi             |   1 -
 arch/arm/boot/dts/rockchip/rk3288.dtsi             |   5 +-
 arch/arm/boot/dts/rockchip/rv1108.dtsi             |   1 -
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |   4 -
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |   4 -
 arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts  |   4 -
 .../boot/dts/amlogic/meson-g12a-radxa-zero.dts     |   4 -
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts  |   4 -
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts    |   4 -
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts |   4 -
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi        |   1 +
 .../dts/amlogic/meson-g12b-a311d-libretech-cc.dts  |   6 -
 arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi  |   2 +
 .../boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi  |   6 -
 .../boot/dts/amlogic/meson-g12b-bananapi.dtsi      |   6 -
 .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   |   6 -
 .../dts/amlogic/meson-g12b-odroid-go-ultra.dts     |   6 -
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi |   6 -
 .../boot/dts/amlogic/meson-g12b-radxa-zero2.dts    |   6 -
 arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi  |   2 +
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi   |   6 -
 arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi   |   4 -
 .../arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi |   4 -
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts    |   4 -
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi  |   4 -
 .../dts/amlogic/meson-sm1-s905d3-libretech-cc.dts  |   4 -
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts   |   4 -
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         |   1 +
 arch/arm64/boot/dts/arm/morello.dtsi               |  22 +-
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi          |   8 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   4 -
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |   4 -
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   4 -
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   4 -
 .../boot/dts/microchip/sparx5_pcb_common.dtsi      |   2 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   8 -
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  24 +-
 arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts       |   6 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |   8 +-
 50 files changed, 210 insertions(+), 514 deletions(-)
---
base-commit: a2cc6ff5ec8f91bc463fd3b0c26b61166a07eb11
change-id: 20250403-dt-cpu-schema-48e66c7f6a90

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


