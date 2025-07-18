Return-Path: <linux-pm+bounces-31051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEA3B09CC2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 09:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5BF3B4A50
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 07:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9D26AAB7;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1hFQj3F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA7D269AFB;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824293; cv=none; b=DnNlZLCCVquMY1TVWgU9y//u8Jb3tpCjnHooHDEJjjx+Zp9OMTMhK4M085m4Sv8ZvlV6DzNFe3ezcm5Prcx2cyHN89UlnAx9rzCmeF3uhsD3nQqTcYPKT6/N49m7ROQTvUUH8L1cDiZi/K6EgDeLAVdkC0Zqns4JfRGTNgtAWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824293; c=relaxed/simple;
	bh=WjY6IyydNi+5JB/lny8B6ZDF5HeAFvckyWItEo3hAt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4jTJbRfJomxeS+X2FN3Fo+dS89A/KLP2MRxkzqpsk2rlHgBac4oBxMPncy0GqgfFUIWpo6NdHCZ9GVKpYxZmjzSC+fsuG9uDySDdm42N4944cqSNJS8jhf6AfwTtF0xjHyG2LqkIY1H8ggonYPTbbyuReKP+ptohryrMCYiNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1hFQj3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27B5FC4CEF5;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752824293;
	bh=WjY6IyydNi+5JB/lny8B6ZDF5HeAFvckyWItEo3hAt0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B1hFQj3FW4AkwlgzDbSNMX8u4nwhmy/GjOMvmzQPf8olo5KgMHyXkDVrzTN1xjtGQ
	 b5wSyvARaa1/zvFhgHJVy8XDwc1AHePwWDyXwnoUSKOSZSMvl1s+3xfM+QycnVf0tN
	 IAjbblhXUi/mj7ADBNjcv4WCosdez+jdxjZ9kUlxMxLYpDLs4gShOeHMUgDvIIPEqx
	 ow+bGnMLPSIpOd4ys9gvRpyPg8HL8UfSxYFuZWvOu7nhcyK+OFNNc+HrNKZkmWk2jT
	 4w6kfQq4M7Sbhym6EHNurbX5iQYlXbgsezWVLjQCtMg7JAdjodOFnwn23VPodfLVqH
	 B397Si4KDodoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17682C83F1A;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 18 Jul 2025 11:38:04 +0400
Subject: [PATCH v14 2/2] arm64: dts: qcom: ipq5018: Update tsens node and
 thermal zones
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-ipq5018-tsens-v14-2-28d8a2472418@outlook.com>
References: <20250718-ipq5018-tsens-v14-0-28d8a2472418@outlook.com>
In-Reply-To: <20250718-ipq5018-tsens-v14-0-28d8a2472418@outlook.com>
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
 Dmitry Baryshkov <lumag@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752824290; l=3848;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=SwJcY4cCvc+nIankAMt5+SCPwBFBGOQVItGhlf/eWGU=;
 b=GTCG1e6Toew3AUfHJHm9fwJ3pdtIkfCn7Hc6H/MDUo7DhW7lN6TNtlWiBmnIszihuvS55+XRT
 QC8elkaStAMAQ2KryJ8HLRI+nrydf4RXeSzSECjxfKU9qW6V/ucn/9q
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Remove qcom,tsens-v1 as fallback since this IP has no RPM and, as such,
must use its own init routine available in the driver.
Also adding a cooling device to the CPU thermal zone which uses CPU
frequency scaling.
In addition, remove superfluous polling-delay properties for which the
default is already set to zero, correctly set hysteresis properties
measured in milli Celsius as opposed to Celsius, and replace an
underscore in an alias with a hyphen to align with device tree coding
guidelines.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 41 +++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index ee0001741d211b187e89a39a3caaa576251aff03..1b33ccf1a1b1af721b9690ae2c35eb82985205f5 100644
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
@@ -255,9 +258,9 @@ tsens_s4_p2: s4-p2@254 {
 		};
 
 		tsens: thermal-sensor@4a9000 {
-			compatible = "qcom,ipq5018-tsens", "qcom,tsens-v1";
-			reg = <0x004a9000 0x1000>, /* TM */
-			      <0x004a8000 0x1000>; /* SROT */
+			compatible = "qcom,ipq5018-tsens";
+			reg = <0x004a9000 0x1000>,
+			      <0x004a8000 0x1000>;
 
 			nvmem-cells = <&tsens_mode>,
 				      <&tsens_base1>,
@@ -744,56 +747,62 @@ pcie@0 {
 
 	thermal-zones {
 		cpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 2>;
 
 			trips {
 				cpu-critical {
 					temperature = <120000>;
-					hysteresis = <2>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
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
 			};
 		};
 
 		gephy-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 4>;
 
 			trips {
 				gephy-critical {
 					temperature = <120000>;
-					hysteresis = <2>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
 		};
 
 		top-glue-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 3>;
 
 			trips {
-				top_glue-critical {
+				top-glue-critical {
 					temperature = <120000>;
-					hysteresis = <2>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
 		};
 
 		ubi32-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 1>;
 
 			trips {
 				ubi32-critical {
 					temperature = <120000>;
-					hysteresis = <2>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};

-- 
2.50.1



