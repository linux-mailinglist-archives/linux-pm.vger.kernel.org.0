Return-Path: <linux-pm+bounces-28437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A992AD4A4E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA517B472
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1C92253FB;
	Wed, 11 Jun 2025 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O796kNJQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613020DD48;
	Wed, 11 Jun 2025 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618785; cv=none; b=azJwQ7PHVzRhamdeJEfIJy34jgIGlv+PUGh1ygsm9JYTo6LOtJpVzPP9ipuPQHJg9n4T87/UZg0o3LEGGMk+sTOjfy0WMd4pzndkznboSXceG0PhkqZjGM5TB6pcZ3RE2RHAEj/dWNKEVbd2RcUZOzQ55TW48SB/0gcjUkCVVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618785; c=relaxed/simple;
	bh=BkxTyX33gHEtjP2JawH8Psdf9hWjmqaryNkUQiqnx24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7pOXACfQ5zse/A69Ra2V7H1d4afetydmyvGzqb4WpTeCBXZDaI1sg4IoyOKEZ5QNthZGKcxgIv+Tglghq/+wfWQ24rMBayDvIdIKABLES9BtKoBXKG106FSs+OWW04VzvvCNLdZV2qOGh2IinKXPVkWmbYidUowsp1s5Xu6UJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O796kNJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C30F6C4CEF2;
	Wed, 11 Jun 2025 05:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749618784;
	bh=BkxTyX33gHEtjP2JawH8Psdf9hWjmqaryNkUQiqnx24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O796kNJQxYSE4m7qAahv1pwhGygVxfUhZ/KhkNpaypoMt4RBH5Lw9mjK19MrVYfo2
	 Iq/wz8ipzzXM+ND8LP/66ASI9ONG24solRtIQ6pmC7mT+YWvPnS7eeNnDmWvQPNzMY
	 NGnAsHuPQVguCFT1WD9qs15O+9jnKJg220qicd+TyjUo4VU+sPM70fGKLxbptCfrJg
	 8U177wPAw4SmLR+gd1qsHJrdkjdz16lbp0/reoZezErnFMNLPx/0X1a+iHruDCLgSP
	 rrJyXSJxarMSvejRks9930BG7UWdBFTRfqESzakzn0vIIVNWNM/j+oW7XpIoQ4GhxZ
	 3GdSIt2NXq6zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F5C71135;
	Wed, 11 Jun 2025 05:13:04 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 11 Jun 2025 09:12:46 +0400
Subject: [PATCH v11 2/2] arm64: dts: qcom: ipq5018: Add tsens node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ipq5018-tsens-v11-2-266566bfd16a@outlook.com>
References: <20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com>
In-Reply-To: <20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com>
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 George Moussalem <george.moussalem@outlook.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749618782; l=5540;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=8VbrGnbVEEGlTeBi9Ev67z9HvHAIvHkO/H7Vls/aG78=;
 b=uOrwg1pLM1xnBOdSnqUhLxR/M9QsRaBVSVdexIJRe/jspGlxZe9X9D+Ky/iFCkoTrB9DS2Uoh
 1QMLjyVpQXhBjoCEFc7DMSCUq4nLNgsG5mzSrx5QD6QiYB3nkLJ4WO0
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
There is no RPM, so tsens has to be manually enabled. Adding the tsens
and nvmem nodes and adding 4 thermal sensors (zones). The critical trip
temperature is set to 120'C with an action to reboot.

In addition, adding a cooling device to the CPU thermal zone which uses
CPU frequency scaling.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 182 ++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 130360014c5e14c778e348d37e601f60325b0b14..defeb697c8d89686e3aaf2e6f7b6cb7493219336 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
 #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -39,6 +40,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -49,6 +51,7 @@ cpu1: cpu@1 {
 			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		l2_0: l2-cache {
@@ -182,6 +185,117 @@ pcie0_phy: phy@86000 {
 			status = "disabled";
 		};
 
+		qfprom: qfprom@a0000 {
+			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
+			reg = <0x000a0000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			tsens_mode: mode@249 {
+				reg = <0x249 0x1>;
+				bits = <0 3>;
+			};
+
+			tsens_base1: base1@249 {
+				reg = <0x249 0x2>;
+				bits = <3 8>;
+			};
+
+			tsens_base2: base2@24a {
+				reg = <0x24a 0x2>;
+				bits = <3 8>;
+			};
+
+			tsens_s0_p1: s0-p1@24b {
+				reg = <0x24b 0x2>;
+				bits = <2 6>;
+			};
+
+			tsens_s0_p2: s0-p2@24c {
+				reg = <0x24c 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_s1_p1: s1-p1@24c {
+				reg = <0x24c 0x2>;
+				bits = <7 6>;
+			};
+
+			tsens_s1_p2: s1-p2@24d {
+				reg = <0x24d 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s2_p1: s2-p1@24e {
+				reg = <0x24e 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s2_p2: s2-p2@24f {
+				reg = <0x24f 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_s3_p1: s3-p1@24f {
+				reg = <0x24f 0x2>;
+				bits = <7 6>;
+			};
+
+			tsens_s3_p2: s3-p2@250 {
+				reg = <0x250 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s4_p1: s4-p1@251 {
+				reg = <0x251 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s4_p2: s4-p2@254 {
+				reg = <0x254 0x1>;
+				bits = <0 6>;
+			};
+		};
+
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq5018-tsens";
+			reg = <0x004a9000 0x1000>,
+			      <0x004a8000 0x1000>;
+
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>,
+				      <&tsens_base2>,
+				      <&tsens_s0_p1>,
+				      <&tsens_s0_p2>,
+				      <&tsens_s1_p1>,
+				      <&tsens_s1_p2>,
+				      <&tsens_s2_p1>,
+				      <&tsens_s2_p2>,
+				      <&tsens_s3_p1>,
+				      <&tsens_s3_p2>,
+				      <&tsens_s4_p1>,
+				      <&tsens_s4_p2>;
+
+			nvmem-cell-names = "mode",
+					   "base1",
+					   "base2",
+					   "s0_p1",
+					   "s0_p2",
+					   "s1_p1",
+					   "s1_p2",
+					   "s2_p1",
+					   "s2_p2",
+					   "s3_p1",
+					   "s3_p2",
+					   "s4_p1",
+					   "s4_p2";
+
+			interrupts = <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "uplow";
+			#qcom,sensors = <5>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -631,6 +745,74 @@ pcie@0 {
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <0>;
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+
+				cpu_alert: cpu-passive {
+					temperature = <100000>;
+					hysteresis = <2>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gephy-thermal {
+			polling-delay-passive = <0>;
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				gephy-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			polling-delay-passive = <0>;
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				top-glue-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		ubi32-thermal {
+			polling-delay-passive = <0>;
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				ubi32-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,

-- 
2.49.0



