Return-Path: <linux-pm+bounces-38512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B065C8297E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 22:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CFDB4E3B4D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA2D331203;
	Mon, 24 Nov 2025 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDXdOcni"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2732FA32;
	Mon, 24 Nov 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021219; cv=none; b=hBQjsOQGnQZ5MCzOxtq0muJPXaIhab0XNvi63hglk8x6qMMBvd8xzw09/A26qit/5IP78hROp98OpkaVNvfKerwGQyP1BSTjBr6xcaWtMDD42U+HheKVb1/ivjyVtsFrxVwb/nH7zFL+ifqqQhbpDoipQGQI6HUXrsktGSB8QQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021219; c=relaxed/simple;
	bh=3IKw0nkX63RBBXH8cToT4cBaJzlDdChJSInpUsVpcyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9c26mA5ngu/Yhull065WHhITt5V8aVEC4eDhku4CKTwmip/ZtWEPqS5DuyB+GqPOY8Q40ZScFMrpflHbjQvE8Z8SlehQ/M+ANd6jCf+HsMaRwGY4yEd9ktz58lhAlLPe9UErYXbZVVPCfXcjayxIBHLt68Jefitp283jxumqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDXdOcni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B76C1C19421;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021218;
	bh=3IKw0nkX63RBBXH8cToT4cBaJzlDdChJSInpUsVpcyA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RDXdOcni3FSC5b1r8qwe7fWzs8w/k1cc3XcJOA67qh+HB37tYBXn0LdBvjwvpPKMo
	 rN1i0/hrd5gXDi0cnNWSkw4lGVOjWWqX4ubXjcMTOP4fppmJRt3RoeKjMK1utDybuF
	 7PoXV4LGJISTG51fIvP3NM2mshUH/v8TlRgXhgljLQ87i9R/Z7MzOUAOqSfcmk5HND
	 uDbHEu4aJoo3QEzNWs2sO4oPosUrx8HMv7KySqQyAmHjhljG4L8sqkRbUrQ5ZzacIy
	 tu4qrA+NSG3GTR1rP+c4kh/FWuDCjcTSp+RMsMqeK5WKzbogNSHtWEHtHdvSzhfreO
	 I3gsb4uJY2qSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6BDCFD360;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Nov 2025 22:53:41 +0100
Subject: [PATCH RFC 8/8] arm64: dts: qcom: sdm670-google-sargo: Enable fuel
 gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pmi8998_fuel_gauge-v1-8-dd3791f61478@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=SyGBCL9VTEPA+aAWTUKzUH7OLMbCTKZV+KFoRbFN9oM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpJNPgenmWLfuDKhq15mBg6v1tJzJPi9mONOtDK
 +nbgiB4RcSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaSTT4AAKCRBgAj/E00kg
 ct3+D/9FOzgDdTeSSuMnpUerlqxXHRc7EteoshYCabmOBQfZkQfTUgC+p7Nnbujn8EyVH35kHb2
 04thXEH3bbZXwDcQ37886myN5Mtm7HRNkGg2/FzE3FYSClXrJoIo+9XdzSWRFTqh7jgLHGYW7bW
 IKK/9Qq3KPlvhlmiYyhegZSxWdKzhbxFMBprU2gcomvExFvuT9mFU4A8UjddL9SxgXLlmXhn1vC
 7Mbvfvd7eBwQ3/n/T4jqKkb7mw5V5ZX3KaSade6jOq3tjcv9pVH/Ui8Ds8BenYgsOYKYPbyIGvT
 K4W6HBLQfUd3Y2CBEPSGB7wUZW58vhoRNjDUz26iBZ8ofu/gdimjAjo84FQtLpq89gvQpot+2do
 nJkFJVFN4uDf6Oh4/AaEk3bysrf2gZ0QaeGAMyL0yasVutQO2bELurmwmfVVBGvPVi1Ri0CpYF9
 dqxm8E8uvzWkxcRFsi9OymhD9I+WIUN5tdCFlvyihsMMlOSGpOyJoEVJ6kgfCmYBNbmPiWfPyHS
 xDH5NX8mvn0rQcchS2DL04az9PEzKLSgvyHVl/+StqKya6kPzZGnlsJteKA63dlWzhDCgg/hr2f
 ej8jQ1LL8+E+bTikNcpcJfR1nUt1P8VPgayWzBhDG2UHB7465QB9YCfpV2U8+zTqpCxJer7NCAF
 BVXLpg4Ve72CGEw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Richard Acayan <mailingradian@gmail.com>

The PM660 fuel gauge determines the battery charge. Enable it for full
battery support.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
index ed55646ca419d..a8e0e85c42cd2 100644
--- a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
@@ -490,6 +490,13 @@ &pm660_charger {
 	status = "okay";
 };
 
+&pm660_fg {
+	monitored-battery = <&battery>;
+	power-supplies = <&pm660_charger>;
+
+	status = "okay";
+};
+
 &pm660_rradc {
 	status = "okay";
 };

-- 
2.51.0



