Return-Path: <linux-pm+bounces-24792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03703A7B688
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F24189E4A0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B201EA7E3;
	Fri,  4 Apr 2025 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzYCy357"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFE1EA7D3;
	Fri,  4 Apr 2025 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735608; cv=none; b=frHoOBV7NCnisA2+wTi4HiKeuSxTYqH/revKdfIvqSAs8HZtgCXQ9vOJclGu1uo7YHKA0VwJSvdian7OwFzV7gXY0v75xWdTVJLZPBRkZEonaKlEr/zhwEMVms0aqPPQSQ8/0g9e2hJhromRgqgj6QWYIWEpXxt4vHF9EcHWP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735608; c=relaxed/simple;
	bh=+bglFes+JWUyYqhoWvdBTyyAUTU6Hu68wW9iKCwLBnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3vzCW2csWyQQwS3YUVXhlHwsgdSP1pP5zga5dn5g/rM8iZ/laffF1ocfXgt7Yqnosc6LquwTtSq+u/SITm2gSE65OujzqnB2tnaPh5Yo51D4YaF6BtntGkuc9DsCR4dHLV0vi74CJjENCGN17TKddxpUME/aaLQHGA3DTt8ak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzYCy357; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F80C4CEE3;
	Fri,  4 Apr 2025 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735606;
	bh=+bglFes+JWUyYqhoWvdBTyyAUTU6Hu68wW9iKCwLBnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZzYCy3572wAcb8VXN5IFR/xxSAoz+Ll8686K4A7qg8wIFI38fvJ8QSFQwX/eI7L6g
	 9GswgwONrsiJoNkwsyrplALvNfCFcd8MaJKyb2kpDe/SMbAsiOEjmnUMrHu/+qEU44
	 fc6+c+FKbR7mO9dkD4/sTpNP2Yvqw5zu1a79e2a7C/Y3mq9VrjXacawISc3gE7kwgm
	 R1rrrZ20y/p8is2HZkHzkIPf4pvhIgTK1ctQnusjL0OrXjK1ZXlPMNFNLcVp0TxB9Z
	 E9pl1+SlJ/3xi8ckKlkbV5SPf06nhMkBkco7rmYFgKHjgOa8xRquq6E/AnK3C/a00M
	 T7EX1lGR7l7NQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:40 -0500
Subject: [PATCH 19/19] dt-bindings: cpufreq: Drop redundant Mediatek
 binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-19-076be7171a85@kernel.org>
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

The Mediatek CPUFreq binding document just describes properties from
the CPU node which the driver uses. This is redundant as all the
properties are described in the arm/cpus.yaml schema.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/cpufreq/cpufreq-mediatek.txt          | 250 ---------------------
 1 file changed, 250 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
deleted file mode 100644
index e0a4ba599abc..000000000000
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ /dev/null
@@ -1,250 +0,0 @@
-Binding for MediaTek's CPUFreq driver
-=====================================
-
-Required properties:
-- clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
-- clock-names: Should contain the following:
-	"cpu"		- The multiplexer for clock input of CPU cluster.
-	"intermediate"	- A parent of "cpu" clock which is used as "intermediate" clock
-			  source (usually MAINPLL) when the original CPU PLL is under
-			  transition and not stable yet.
-	Please refer to Documentation/devicetree/bindings/clock/clock-bindings.txt for
-	generic clock consumer properties.
-- operating-points-v2: Please refer to Documentation/devicetree/bindings/opp/opp-v2.yaml
-	for detail.
-- proc-supply: Regulator for Vproc of CPU cluster.
-
-Optional properties:
-- sram-supply: Regulator for Vsram of CPU cluster. When present, the cpufreq driver
-	       needs to do "voltage tracking" to step by step scale up/down Vproc and
-	       Vsram to fit SoC specific needs. When absent, the voltage scaling
-	       flow is handled by hardware, hence no software "voltage tracking" is
-	       needed.
-- mediatek,cci:
-	Used to confirm the link status between cpufreq and mediatek cci. Because
-	cpufreq and mediatek cci could share the same regulator in some MediaTek SoCs.
-	To prevent the issue of high frequency and low voltage, we need to use this
-	property to make sure mediatek cci is ready.
-	For details of mediatek cci, please refer to
-	Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
-- #cooling-cells:
-	For details, please refer to
-	Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
-
-Example 1 (MT7623 SoC):
-
-	cpu_opp_table: opp_table {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-598000000 {
-			opp-hz = /bits/ 64 <598000000>;
-			opp-microvolt = <1050000>;
-		};
-
-		opp-747500000 {
-			opp-hz = /bits/ 64 <747500000>;
-			opp-microvolt = <1050000>;
-		};
-
-		opp-1040000000 {
-			opp-hz = /bits/ 64 <1040000000>;
-			opp-microvolt = <1150000>;
-		};
-
-		opp-1196000000 {
-			opp-hz = /bits/ 64 <1196000000>;
-			opp-microvolt = <1200000>;
-		};
-
-		opp-1300000000 {
-			opp-hz = /bits/ 64 <1300000000>;
-			opp-microvolt = <1300000>;
-		};
-	};
-
-	cpu0: cpu@0 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a7";
-		reg = <0x0>;
-		clocks = <&infracfg CLK_INFRA_CPUSEL>,
-			 <&apmixedsys CLK_APMIXED_MAINPLL>;
-		clock-names = "cpu", "intermediate";
-		operating-points-v2 = <&cpu_opp_table>;
-		#cooling-cells = <2>;
-	};
-	cpu@1 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a7";
-		reg = <0x1>;
-		operating-points-v2 = <&cpu_opp_table>;
-	};
-	cpu@2 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a7";
-		reg = <0x2>;
-		operating-points-v2 = <&cpu_opp_table>;
-	};
-	cpu@3 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a7";
-		reg = <0x3>;
-		operating-points-v2 = <&cpu_opp_table>;
-	};
-
-Example 2 (MT8173 SoC):
-	cpu_opp_table_a: opp_table_a {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-507000000 {
-			opp-hz = /bits/ 64 <507000000>;
-			opp-microvolt = <859000>;
-		};
-
-		opp-702000000 {
-			opp-hz = /bits/ 64 <702000000>;
-			opp-microvolt = <908000>;
-		};
-
-		opp-1001000000 {
-			opp-hz = /bits/ 64 <1001000000>;
-			opp-microvolt = <983000>;
-		};
-
-		opp-1105000000 {
-			opp-hz = /bits/ 64 <1105000000>;
-			opp-microvolt = <1009000>;
-		};
-
-		opp-1183000000 {
-			opp-hz = /bits/ 64 <1183000000>;
-			opp-microvolt = <1028000>;
-		};
-
-		opp-1404000000 {
-			opp-hz = /bits/ 64 <1404000000>;
-			opp-microvolt = <1083000>;
-		};
-
-		opp-1508000000 {
-			opp-hz = /bits/ 64 <1508000000>;
-			opp-microvolt = <1109000>;
-		};
-
-		opp-1573000000 {
-			opp-hz = /bits/ 64 <1573000000>;
-			opp-microvolt = <1125000>;
-		};
-	};
-
-	cpu_opp_table_b: opp_table_b {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-507000000 {
-			opp-hz = /bits/ 64 <507000000>;
-			opp-microvolt = <828000>;
-		};
-
-		opp-702000000 {
-			opp-hz = /bits/ 64 <702000000>;
-			opp-microvolt = <867000>;
-		};
-
-		opp-1001000000 {
-			opp-hz = /bits/ 64 <1001000000>;
-			opp-microvolt = <927000>;
-		};
-
-		opp-1209000000 {
-			opp-hz = /bits/ 64 <1209000000>;
-			opp-microvolt = <968000>;
-		};
-
-		opp-1404000000 {
-			opp-hz = /bits/ 64 <1007000000>;
-			opp-microvolt = <1028000>;
-		};
-
-		opp-1612000000 {
-			opp-hz = /bits/ 64 <1612000000>;
-			opp-microvolt = <1049000>;
-		};
-
-		opp-1807000000 {
-			opp-hz = /bits/ 64 <1807000000>;
-			opp-microvolt = <1089000>;
-		};
-
-		opp-1989000000 {
-			opp-hz = /bits/ 64 <1989000000>;
-			opp-microvolt = <1125000>;
-		};
-	};
-
-	cpu0: cpu@0 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a53";
-		reg = <0x000>;
-		enable-method = "psci";
-		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA53SEL>,
-			 <&apmixedsys CLK_APMIXED_MAINPLL>;
-		clock-names = "cpu", "intermediate";
-		operating-points-v2 = <&cpu_opp_table_a>;
-	};
-
-	cpu1: cpu@1 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a53";
-		reg = <0x001>;
-		enable-method = "psci";
-		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA53SEL>,
-			 <&apmixedsys CLK_APMIXED_MAINPLL>;
-		clock-names = "cpu", "intermediate";
-		operating-points-v2 = <&cpu_opp_table_a>;
-	};
-
-	cpu2: cpu@100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a72";
-		reg = <0x100>;
-		enable-method = "psci";
-		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA72SEL>,
-			 <&apmixedsys CLK_APMIXED_MAINPLL>;
-		clock-names = "cpu", "intermediate";
-		operating-points-v2 = <&cpu_opp_table_b>;
-	};
-
-	cpu3: cpu@101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a72";
-		reg = <0x101>;
-		enable-method = "psci";
-		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA72SEL>,
-			 <&apmixedsys CLK_APMIXED_MAINPLL>;
-		clock-names = "cpu", "intermediate";
-		operating-points-v2 = <&cpu_opp_table_b>;
-	};
-
-	&cpu0 {
-		proc-supply = <&mt6397_vpca15_reg>;
-	};
-
-	&cpu1 {
-		proc-supply = <&mt6397_vpca15_reg>;
-	};
-
-	&cpu2 {
-		proc-supply = <&da9211_vcpu_reg>;
-		sram-supply = <&mt6397_vsramca7_reg>;
-	};
-
-	&cpu3 {
-		proc-supply = <&da9211_vcpu_reg>;
-		sram-supply = <&mt6397_vsramca7_reg>;
-	};

-- 
2.47.2


