Return-Path: <linux-pm+bounces-35013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4101B87C81
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 05:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E45C58101E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 03:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3E3257826;
	Fri, 19 Sep 2025 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHiL0BN5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462522D7A1;
	Fri, 19 Sep 2025 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251940; cv=none; b=WJCpG0TimDjGxt9qwJg56qXCCw5huQVfJSzZsoXMsW9RNkIW8IodBfVA2QFGUble+LKvznkWT7A2lIxNfCLz6D5dffBNyWCUOmxo0gAvJp7l/CncEQrDOC/pV9+EVzATNmDvaSfx0j408wa+FeuzW5zvUM1xAhQ5GmMsS3MLNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251940; c=relaxed/simple;
	bh=gAv/gWsQ2Cl0kOldV7g5ft4pBj0bRxTan5ynAs/Ai3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jonj/inv80gFcaStSKo75eWHgoefKDYGvIdzRJm1rVZsdL1tCNylXSHeysVY3fTOLNijfxyNGnRM48x+3d2y7aPmxXTtWUNsNkM9nq3iniPv55h5AFR67IsdboXgzMIHA+Z2h8VDcJHMO+24CcD7Xb0BvnG57gmb/0gHCLPHWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHiL0BN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED6C3C4CEF7;
	Fri, 19 Sep 2025 03:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758251940;
	bh=gAv/gWsQ2Cl0kOldV7g5ft4pBj0bRxTan5ynAs/Ai3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lHiL0BN5glP0kfHhMPE9I1M+DBjKGDaRXz5YWcsetzcdBK+RBA7XqKTpmDlPVAvep
	 jIsafS0RrYZerS48oAam5LFyXl7CCtOWu1yM69+UqtscGfJRt9zmRjrcu3qVmuHONw
	 TDgrUjRWO21+vR+Ih4L7aTZZ908/JSNvk1ElFXEDar58FutLgOby/L9pjFPDQIbUjv
	 IWIBJLJzGCZQ4L84BW9XfnV05PReYhBMNSCrhD7mRmR2iCBmcWHL4q+mKNTDv0p3Qb
	 J8/wK08Fh3xCp31XqaTIw5bS1nXhDxheO5ZlrfKNEj0xnBG5cFIRKkvmxeyXsOGaJw
	 0gtJljouzKYTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BA3CA1013;
	Fri, 19 Sep 2025 03:18:59 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 19 Sep 2025 11:18:50 +0800
Subject: [PATCH v6 1/2] arm64: dts: qcom: x1e80100-crd: Add charge limit
 nvmem
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-qcom_battmgr_update_new-v6-1-ed5c38867614@oss.qualcomm.com>
References: <20250919-qcom_battmgr_update_new-v6-0-ed5c38867614@oss.qualcomm.com>
In-Reply-To: <20250919-qcom_battmgr_update_new-v6-0-ed5c38867614@oss.qualcomm.com>
To: kernel@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758251938; l=2081;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=nPLGHoTJ5NTWoHSd8PH9bD21pqqTFHYPJjavOYsTnQM=;
 b=Qp3/B+LF3wqioqgmabrMHJVOowVh8ukpc4RgSqGleDq4wKLqjAuYJnP6TjFOGdig2SSHGFqzv
 rwXgC4/m20nCC4bkKA4hSx4apR2QwABRpioEVkbFdc4+s5MU9s9/qlq
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add nvmem cells for getting charge control thresholds if they have
been set previously.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1-crd.dtsi         |  7 +++++++
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index c9f0d505267081af66b0973fe6c1e33832a2c86b..cd3c071624ce66f8c28ee4521fe3db8b737757a6 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -82,6 +82,13 @@ pmic-glink {
 				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
 				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
 
+		nvmem-cells = <&charge_limit_en>,
+			      <&charge_limit_end>,
+			      <&charge_limit_delta>;
+		nvmem-cell-names = "charge_limit_en",
+				   "charge_limit_end",
+				   "charge_limit_delta";
+
 		/* Left-side rear port */
 		connector@0 {
 			compatible = "usb-c-connector";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
index e3888bc143a0aaae23c92d400d48ea94423e0366..cc4994f890f83540c4fb238811bc879ac9356256 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
@@ -240,6 +240,26 @@ reboot_reason: reboot-reason@48 {
 			};
 		};
 
+		pmk8550_sdam_15: nvram@7e00 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7e00>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7e00 0x100>;
+
+			charge_limit_en: charge-limit-en@73 {
+				reg = <0x73 0x1>;
+			};
+
+			charge_limit_end: charge-limit-end@75 {
+				reg = <0x75 0x1>;
+			};
+
+			charge_limit_delta: charge-limit-delta@76 {
+				reg = <0x76 0x1>;
+			};
+		};
+
 		pmk8550_gpios: gpio@8800 {
 			compatible = "qcom,pmk8550-gpio", "qcom,spmi-gpio";
 			reg = <0xb800>;

-- 
2.34.1



