Return-Path: <linux-pm+bounces-28526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875EAD6829
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 08:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05724189D864
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 06:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6361F758F;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzwN99A7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890001E378C;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710810; cv=none; b=MmzMRam2GgGMtgOa45bQQw8vnx4VTYEXtcTTENI1UzXbitcCPWkk1tfi4ZFYhnNTPLAChcIDilUd3EcSt8IfNCY9yVJ/338C/HGY63b+2dOHrigivF6YJexSxqEGDzkOMDyEB0U8NuAIgE/4+X8O/OI2tVnvJgjmcfMKFNXE8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710810; c=relaxed/simple;
	bh=8tdgdYgfMaFIYKxuLPz3G1JT90EuYmnj28QnPFEq9YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXyxi48RT7TeauibGpY4IFAARa6opSc4gezQHXk1cZTONAmrqPeWuxtTQefBpQr6tRLcuKnhjJazVEKS5O815JGN79k/u/NON6+vl1W5u9nClI1qwb5aaWW+I3od7KUYu3jlIWAZ7c7P+sTEtMd/nHp9odP83fSH1TL0i9hwC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzwN99A7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22A02C4CEF0;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749710810;
	bh=8tdgdYgfMaFIYKxuLPz3G1JT90EuYmnj28QnPFEq9YU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rzwN99A7FaWXA8SCybauJwdq6kGfD4lJLaVAqDz4RuqWYTqt3AV60JT7jYrlyJgad
	 KVedWqihxkQX/mfpFe7nawjsca8JsclFiTbSmPaPQFg8a40zrIdofXSsgTtNbAMZVk
	 QAIbx0IQx1/YQzXZggaPYRc49XeeYQ6VAjHFQLN2PUf2JTyulLiMiCO8uhSO6BVOGD
	 76au7k0ul6nt+2N5mm+KCYqQrVdfCRbCzDsPmrULH8GOZWkx8zPXuQ+b0O49avNMQa
	 xQuDmDxCAA9XZz0GNrvq2rtSyMcPWZgnO2h/kcFYrpF/bDg43+xpDnHLUKJFL5x92d
	 jk5TEzPtNrGGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E58FC71136;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Thu, 12 Jun 2025 10:46:14 +0400
Subject: [PATCH v13 2/2] arm64: dts: qcom: ipq5018: Add tsens node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-ipq5018-tsens-v13-2-a210f3683240@outlook.com>
References: <20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com>
In-Reply-To: <20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com>
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749710807; l=5419;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=MsKWr8/oQjZxIGUe4c9vPMrH2HVq4c/DwY1iNr6WoVs=;
 b=B4oK/7A/MVXqMX7hGZTLTshh4CBlGG/3Z6xMK3hA7jSC7r8rTa0V2+GsDZt3fB/PcfAvO9A87
 x3wEfZoJtEICoQDS1EH4STHKXnbHtPgSY7f9lnMK0Qc2LUyZrB8v/W/
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
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 178 ++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 130360014c5e14c778e348d37e601f60325b0b14..1b33ccf1a1b1af721b9690ae2c35eb82985205f5 100644
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
@@ -631,6 +745,70 @@ pcie@0 {
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+
+				cpu_alert: cpu-passive {
+					temperature = <100000>;
+					hysteresis = <1000>;
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
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				gephy-critical {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				top-glue-critical {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		ubi32-thermal {
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				ubi32-critical {
+					temperature = <120000>;
+					hysteresis = <1000>;
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



