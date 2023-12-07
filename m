Return-Path: <linux-pm+bounces-790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5280869C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 12:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2B3283D6F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645A737D3C;
	Thu,  7 Dec 2023 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="Hoa7p5Rd"
X-Original-To: linux-pm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C11D5B;
	Thu,  7 Dec 2023 03:21:45 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 6280942BF9;
	Thu,  7 Dec 2023 16:21:32 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1701948093; bh=DBs7WSTRsWsDILHndJynPWxZbqbs68OouyDKWJNsV3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hoa7p5Rd2KrsNDYToioeGzMosAXV7/09a6h/s8R4LlgeC3Y30rZrpurXBXl9x3KwV
	 QXrAjwrbRMVpz1CBZ/eJZDRLADrNSlokhxEdlt/4ENQco2tgHQtRfMI++11UmOGXSm
	 cTbPqGDpd5LGzP4nJRGlAtMcBlvXvvI9U9AaQ19NI8aIEE5qqckgajA+3ggKCt8Of9
	 TlIl8FrHoCOpyuBcORakF4ikUA/AQEfGHXH7VHzq0YSQwI9NiEm4T+31L8wXYi1IFQ
	 KSFTyj9Nx88WD9AasjsYff4mWxfe5j9uk+Njcye1+YrOW0q3Zaj4VbgPkr7hfVSx3m
	 vgurVni9tPpdg==
From: Nikita Travkin <nikita@trvn.ru>
Date: Thu, 07 Dec 2023 16:20:16 +0500
Subject: [PATCH 3/3] arm64: dts: qcom: acer-aspire1: Add embedded
 controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-aspire1-ec-v1-3-ba9e1c227007@trvn.ru>
References: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
In-Reply-To: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=DBs7WSTRsWsDILHndJynPWxZbqbs68OouyDKWJNsV3g=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlcaq5lixDHcI7sL22tX5Fb/fuC6XCZ7nHDrS2U
 q1H48A8gwCJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZXGquQAKCRBDHOzuKBm/
 dTr0EACcFglXesnZoTHlKdBZhPYb1BP5An7F1fTIw0shv46k1t6TRjQgdj8a5A0iID3DaHg5ORL
 XCjyi+YNFNCj63sD/l2mWi+NV054o3NtfcPJB5hgxgHoenY62tSEVhnV0CeFLnoFUl6Hr64h1Gj
 GYWhtSL0/bqan02l5uYiRD8sK1nIplY5dYSgaqJSrhWe3xYYZWkmwTOr/TUMoeRSk5djCi1WPi+
 6brOb+p1MPxJJvKtDKOhk93MBj39KF2WHiYPGOUsuqkcAtyd6QzQfWETYA0nfIAiR9F3rxIvvx3
 nqcCTuU6YMpFf/FVHvKY+ugVuyvPVZ8HMXLQHswQTVbfs6Wvicb8Lvt4deDLHOrY7d9qgE3OTEe
 tm66QoI/jakdaTEfVB98k1s2D07vWIfIdciRQRtQSJG1XkCGRuBDqp+JBY8bv6Bhbsqie5q8G/O
 hLDz0xZIn8uOQr4v+0B4lxnN6y58lCBXpVqIT8Jl3AFjl6DpGtkkgre7n9OZ3ue1AIiuSacdznO
 GZOiP0Ad5yanbWgGlYGpmfs9I9RPJY06+DIl0gf6TLOMW5wOXd9tAvB36YYMMvud1GdrCfG/Jal
 XZPVmczk5jI2LVAuRVeCdGYNgf7KZK2yxigaQk97Ki9GmIyhkjIuRDEm6VQvTVnQTVHUd+urjQp
 Nq+AOrD8VoWggyA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

The laptop contains an embedded controller that provides a set of
features:

- Battery and charger monitoring
- USB Type-C DP alt mode HPD monitoring
- Lid status detection
- Small amount of keyboard configuration*

[*] The keyboard is handled by the same EC but it has a dedicated i2c
bus and is already enabled. This port only provides fn key behavior
configuration.

Add the EC to the device tree and describe the relationship between the
EC-managed type-c port and the SoC DisplayPort.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 40 +++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index dbb48934d499..a29f542fa612 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -147,7 +147,25 @@ &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	/* embedded-controller@76 */
+	embedded-controller@76 {
+		compatible = "acer,aspire1-ec";
+		reg = <0x76>;
+
+		interrupts-extended = <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ec_int_default>;
+		pinctrl-names = "default";
+
+		connector {
+			compatible = "usb-c-connector";
+
+			port {
+				ec_dp_in: endpoint {
+					remote-endpoint = <&mdss_dp_out>;
+				};
+			};
+		};
+	};
 };
 
 &i2c4 {
@@ -298,6 +316,19 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	data-lanes = <0 1>;
+
+	vdda-1p2-supply = <&vreg_l3c_1p2>;
+	vdda-0p9-supply = <&vreg_l4a_0p8>;
+
+	status = "okay";
+};
+
+&mdss_dp_out {
+	remote-endpoint = <&ec_dp_in>;
+};
+
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l3c_1p2>;
 	status = "okay";
@@ -687,6 +718,13 @@ codec_irq_default: codec-irq-deault-state {
 		bias-disable;
 	};
 
+	ec_int_default: ec-int-default-state {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	edp_bridge_irq_default: edp-bridge-irq-default-state {
 		pins = "gpio11";
 		function = "gpio";

-- 
2.43.0


