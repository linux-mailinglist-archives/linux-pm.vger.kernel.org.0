Return-Path: <linux-pm+bounces-27838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B69AC891D
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E1B189C3D4
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9D621FF4C;
	Fri, 30 May 2025 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELiztn5I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742521E08B;
	Fri, 30 May 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748590542; cv=none; b=Wf5P9WqaRDv/0j4laYNmM9JYxaDFlsQG22DK5/JFFNsnlTgZAsbeojbzywnFeBxe9wH9xwSX/deknJxIEORljLE9tj1o6YH3veNZ54n0H4ruSjzqp8yPMJLbX1E31ub2iARV1ewqaSu36fcc0pAhdhwt8Drc2rUTunQYBofb3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748590542; c=relaxed/simple;
	bh=c1Kgnkn3omq/NMFoaeT8ErRn6AuQRpmtsAZYiwa2iKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcTQ3Nvrh0RCovwgoQG60UCbiM09SXZAQs9A4REl3OAanhzLnLDFM0iGqsFBlr2N6TVmo/MCFSDX3Dkcm0WIXDM22z0c+21ponZB14jkpZpQwrBSjPpeMDSJVzA7IU+ievBlKl92K7s3Hxw/TeSKt1d91HXPLmdCCEfQCiqIBcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELiztn5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6230C113D0;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748590540;
	bh=c1Kgnkn3omq/NMFoaeT8ErRn6AuQRpmtsAZYiwa2iKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ELiztn5I6YBBIJgkTstguPjTwdUmQjDdevydGpBAtpSManoJHjWQ5IL19kA/UZORl
	 1gpQb2u2BjZFluXfgur0mGQYbIGcP0m9Gf7jGpbtf0BX9UvDQBy5G0RS7P9OeIrfjq
	 6mvZ5r5lUDjx4V56g2INCbVoV1JKd66DOdtJRLf6kxGo3t18FC462EdFnEqqqyBvb8
	 wBhvYP1QmeDnh4Fv+Isq2NbJ/L9Jcni8q8esFBQ1yClpZb0eDcTZZpGBCYRuuAotpQ
	 QvAY/1Ic1thvZ2TmIvO6IWLp70QGmmq7h6zdlU5lgWJ9zrO7R9kqJAHZA6J8d3IXGQ
	 EgHctsOCHThSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE8AC5B553;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 30 May 2025 15:35:13 +0800
Subject: [PATCH v2 8/8] arm64: dts: qcom: x1*: Remove
 qcom,sm8550-pmic-glink fallback
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-qcom_battmgr_update-v2-8-9e377193a656@oss.qualcomm.com>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
In-Reply-To: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748590538; l=5982;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=X+TxGqrGeFrGC5fjW0b/Inx80/aw7X040xs1XjnqxDs=;
 b=qHgEdC5OU8ylreHSrnO+egnVmDr9kOZjDds1IVuJodwglo7n4ia5wFKiddXxdkBJOd4TRLVh9
 8/brQverAAhBj5C76rTsuAtOsC+J8ctUGyATyP0MA/vPbEcj5D+ja17
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

The "qcom,x1e80100-pmic-glink" is not longer a fallback compatible
string of "qcom,sm8550-pmic-glink", so remove "qcom,sm8550-pmic-glink"
in x1* platform pmic-glink device nodes.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                        | 1 -
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                | 1 -
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 1 -
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts     | 1 -
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts       | 1 -
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts       | 1 -
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts    | 1 -
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi    | 1 -
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                   | 1 -
 9 files changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index c9f0d505267081af66b0973fe6c1e33832a2c86b..33d908c8011abe7bbbaca539bb9724f12c679c68 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -74,7 +74,6 @@ switch-lid {
 
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
-			     "qcom,sm8550-pmic-glink",
 			     "qcom,pmic-glink";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 2d9627e6c7983daedba87619ba01074ee22b43c9..d6ad762b8f30cc586761fc75ba95608301b3f599 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -51,7 +51,6 @@ chosen {
 
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
-			     "qcom,sm8550-pmic-glink",
 			     "qcom,pmic-glink";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index ac1dddf27da30e6a9f7e1d1ecbd5192bf2d0671e..00e6009e3e4e89e4ca45c2d1b1f20e8caaa85bbf 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -64,7 +64,6 @@ switch-lid {
 
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
-			     "qcom,sm8550-pmic-glink",
 			     "qcom,pmic-glink";
 		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
 				    <&tlmm 123 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index 71b2cc6c392fef9edd19477e4aab6e28699e1eb7..e278997c98e99b1791eb2e0a9dd25ec01b40563b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -39,7 +39,6 @@ switch-lid {
 
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
-			     "qcom,sm8550-pmic-glink",
 			     "qcom,pmic-glink";
 		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
 				    <&tlmm 123 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 967f6dba0878b51a985fd7c9570b8c4e71afe57d..e6f1f72505a8dff5b1ffed5f93614973f649e275 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -59,7 +59,6 @@ led-camera-indicator {
 
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
-			     "qcom,sm8550-pmic-glink",
 			     "qcom,pmic-glink";
 		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
 				    <&tlmm 123 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
index 10b3af5e79fb6493cd6b6c661de6a801e40092f7..8057a5dadabcbf16426ba0088a13eb9c35ffff61 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
@@ -83,7 +83,6 @@ switch-lid {
 
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
-			     "qcom,sm8550-pmic-glink",
 			     "qcom,pmic-glink";
 		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
 				    <&tlmm 123 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index dad0f11e8e8583df6fd8aeec5be2af86739d85fb..aee38ead38a94ddca525b55004d8b8655e8484df 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -41,7 +41,6 @@ switch-lid {
 
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
-			     "qcom,sm8550-pmic-glink",
 			     "qcom,pmic-glink";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 0fd8516580b2679ee425438cb73fd4078cb20581..d2bce79c4a4146c57602cf48fbb42446004f48e2 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -94,7 +94,6 @@ led-camera-indicator {
 
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
-			     "qcom,sm8550-pmic-glink",
 			     "qcom,pmic-glink";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 4dfba835af6a064dbc5ad65671cb8a6e4df79758..2845a8929f80f9f9921568fb76cba79e60ebcd42 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -52,7 +52,6 @@ chosen {
 
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
-			     "qcom,sm8550-pmic-glink",
 			     "qcom,pmic-glink";
 		#address-cells = <1>;
 		#size-cells = <0>;

-- 
2.34.1



