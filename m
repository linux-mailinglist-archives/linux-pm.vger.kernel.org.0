Return-Path: <linux-pm+bounces-38507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9AC82969
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 22:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD2FC347BE3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9B330312;
	Mon, 24 Nov 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HByVrdvK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548B32FA04;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021219; cv=none; b=ae4ioQgW0eZW1cOLduhwGplvXg7R8pM6Ww+yyiwKkMdiwNdx3jMAXtYAxsYSGMjBPq1kP96gGZxB8+v7Xs4o0TDliY+AIL1wWCUypyRJdLggjEbgAxZYcDguGtuVLkMRNeOQBhe7e/f99+a4k2uVvywg7JLI5pTuURXbZOFTJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021219; c=relaxed/simple;
	bh=UZCDBsnIgF6i1ponotY8rKoFIZRImebHaODX1X7uydk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbwvvDcrEf599sBdMvS8cg2+APuOyHCqZpdFAmH2EPCb8nLHzgccHw3YA+OMOUJ9FIYeXJk3YLe/dSznk0IiVSydN3u+FNZm7PKdS+PyoOGi4H71BYv+2v0UwneC+aGIqpTofkDCwZTf5BJcNa30iRcMxNevmWE7mHjzp/GfijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HByVrdvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A58D0C19423;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021218;
	bh=UZCDBsnIgF6i1ponotY8rKoFIZRImebHaODX1X7uydk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HByVrdvKJ2l3/KJQrVU93kcRmq097VNuyxwDIFchD4RR8+N+x6gQSen9D9sDNlABP
	 OxNJsVMLayxpgMqOu+5sBs17ndMM4blDrDJiXLXTe7RvJM1mTQoyHFv78BmX5wWxxZ
	 288t1z32gUsUoA/M43nf3rdLzkLc6clx19yNr14d6wFcCtAdCp9bXeLkn69IgI40WP
	 uDXY+wWD0SsL6GxaoRk5rOv8kk+vCyOktzbnkf9aJmFM0mG+vPxl9WyYl5FyuWGS5N
	 W7RB48n8ZZ7n/ddHwzdVmWnQVR4IHL3DaiQhV6tVntc1++4ATJm+6HHjzRHZxdb/U4
	 4zvZO5Pw7L/Yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99634CFD362;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Nov 2025 22:53:40 +0100
Subject: [PATCH RFC 7/8] arm64: dts: qcom: sdm660-xiaomi-lavender: Enable
 support for battery
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pmi8998_fuel_gauge-v1-7-dd3791f61478@ixit.cz>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Casey Connolly <casey@connolly.tech>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=//aqcSpHZqCf7Mxnh6vHuPIwTM+lRyzwo555sjaHWYQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpJNPgrjHhAZgGkJRJFtjUg8tuRv4ka4Q3yB3je
 dyrZooQwrmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaSTT4AAKCRBgAj/E00kg
 chwTD/4/GOvibHB+A6jj1nlegYxO1fobQm020Fk2yy+lZ+X7zYV3IAd3dAJcIJIMHcPa4/ZAyDl
 nnclreUzuijV8H0Rj8MFp7B25J5XNUPa+ZE9kwrOTNp6uWVrRo25ft1/cS6AnxVWc86DS+3MQ3T
 oEmy56/52kuKyL2kZkVa1gcpZADRqSvi965KuhHYKZlTZenqfWUQBFybCO/yQER7f1LAdwjFbNC
 67OIvlVKhIoLq2zPLu/7Daxf6KypaLTHMnA5jt1sQRW598WEaEKmXx0GJNR2tZYpu3lmuLaV5eS
 l/rEkvpOkwFioU/R7oWsPy52dkaMW5gHC7MZ6uRHsFOCPLCuqENkKANHJm9rV/R/E1h+jXX4B6p
 HbZ+uDifRd1IPxgIc4+QRhMfYz+czqHv2YzcWkzCX5rIQJwVXx300XkA2y/xpL8TBbANFEqRIUm
 qsTSZTWA4uD+jQC8B9RKiOa2NpDORvD9XPwV3hjdaT0sTYXndKmBOi9RpTQ+v6sMek3cMRI9hK4
 ps3fLHKSx5UOV/Ox2nCftygviLdL9efjTNnIjCpCvhpbsSmCEL1UU3s6vHrTrXecxfqz7hOG73z
 PeOpDuJVSWELW4mcTv3G/cx6/XC1OjdrmUS3IV95D0qUIeRAzWRC/LcVF5Yegpz7nQwyaCqOWgk
 1AfBNTow9k3tiQQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Alexey Minnekhanov <alexeymin@postmarketos.org>

Add support for battery, fuelgauge and charger.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
index a9926ad6c6f9f..cb89b88d887d1 100644
--- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
+++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
@@ -38,6 +38,14 @@ framebuffer0: framebuffer@9d400000 {
 		};
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+
+		charge-full-design-microamp-hours = <4000000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4400000>;
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -93,6 +101,23 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&pm660_charger {
+	monitored-battery = <&battery>;
+
+	status = "okay";
+};
+
+&pm660_fg {
+	monitored-battery = <&battery>;
+	power-supplies = <&pm660_charger>;
+
+	status = "okay";
+};
+
+&pm660_rradc {
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };

-- 
2.51.0



