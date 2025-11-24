Return-Path: <linux-pm+bounces-38509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A96E6C82981
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 22:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BD9C3481FD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F3E330D27;
	Mon, 24 Nov 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVVBQRVH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E2E32FA1E;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021219; cv=none; b=jJbI0rG8NJnoCUOfpmRFbUd4vDShaCMRbppTiihEDjRfPBke2a+X61swO6QsYozSM/jOC5kM+yAZp75af/FyXR+MV90vZTDqeNidOxFCv7etOlbAIi0YGaDjc0y8oO8qZzqSFsmaf0RmLjVG8AvSsO7CN83//tsDbeAhS/MPFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021219; c=relaxed/simple;
	bh=BgrQ+EjDTzWVK+qCh810+qg1MEmEBST6Ww23QYqcyQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbcP55AyebIYAl1bNT7RPGF56kLaqkWxzvplk8dgB65OrJyTTf7OaIJq06W49JM7ewO1FZAJJmw5+z//gyx8HYdXcz3qmjdY8flWI4uqmSK8DLXZ+T4Y8gUFRVgxDTcwYohzPnVpRx1wS+WnctlqBeaLivlYEe7NJTGlqlAHTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVVBQRVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69A7CC2BC9E;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021218;
	bh=BgrQ+EjDTzWVK+qCh810+qg1MEmEBST6Ww23QYqcyQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tVVBQRVHbO1R/FPNz6in3gw3Sud80nBqDYUFKHImH1kYiOKFQhKojgKKBBc1EsPHt
	 eB3hCcHfApNj8edDcFJU40ljsa3rHWBiUjYIfm1e1oBAzlq5NfNH/Lg6ZBWM08AKk8
	 3noTKMjodxtbaq5O8x+KblJmnKsjwUVzEPd7jxvUXh6jRUCZHAV1T9dBjvQYY2GPIM
	 OwVtUyvqDMZRseP7GFksBkRAI9LB0X/aBwm1b0V9oBz5yYuQ8zaQCjDrxPgb4TokFZ
	 AWINgHe2TDpEsIb8JWk5ojSwECzXFvOn+kFMKBqHuhp52QHno5cpQOhmjZCQpWde5S
	 lIeFpbN8GtW/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC04CFD363;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Nov 2025 22:53:37 +0100
Subject: [PATCH RFC 4/8] arm64: dts: qcom: pm660: Add fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pmi8998_fuel_gauge-v1-4-dd3791f61478@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Oehd4AB8jVMo0BM0kTNmlPXaU9PB0xpePJ4WKe1viNY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpJNPgIuRTPoGf/YpDS0NtfGU0NfB4vzFgHeiCl
 kqK2+FlNR2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaSTT4AAKCRBgAj/E00kg
 cvyeEACBX6kgWzktd3wBY99dGZqC7osuD5Wg2AiGpJRcnNwSaQTQonaHdhzPFzf4TtuABXY+87s
 YrQzr+S2gZioisyz7ppEo9usGCi+zvsZx6hxMHTfst5/jHcX9OhY5KbNnXdlzLRcwmeJcJ1Wb2w
 TZeEk9PAMW/+730BKlpyvN0QnA3nOYqMlQSlS2y6F1vr2k/tV9o+3I25OUV/XPEtw+KC/5H68z1
 y6wtapPz97VeKBbgFgqTrxyjBnyaN82X2CI6yDPJ/p7ny2lNLUJeRtNk2OU/WCwmKHz69JaxbJ0
 YGJc6iiJFzGPBVIiZwAhHXwI1AZ4pyKQ/2erQKcjb5H5RQMaebVYPy4EIkk37uuybRBapAzs0z1
 mIQIT05vG1pgKcrzX5Rv88/dFHl1XUfFRJ+NKWQSuuQSRrcNpX6kn9mMpmZ1T68TO5QUnAikFM0
 p9dU2pPNYhmEEH2Ogg+sCHaVz5feAmylgwolATlXzMDxFBqzaBXVHAv8psAZR2IkkJ6u3I1VUi8
 wkmB6os8ufY9ANh0qgLoLrIMd9cVFWkSiohKjBzXy2xs/rXCiHJ+ynnBBtT0S/yx1Pr635JXgb0
 qTqnrNHGizhfOasey+avZmNQ8YZ1P8j21AUIF+jc/1HyDBT0JtKqmLlZB4D+V3Yl3zNhZ8koUKU
 LBX3bGntOl+3Veg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Richard Acayan <mailingradian@gmail.com>

The PM660 has the same fuel gauge as PMI8998. Add support for
PM660 battery monitoring.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/pm660.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 156b2ddff0dcb..ce53f5ddc4bdf 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -197,6 +197,16 @@ channel@85 {
 			};
 		};
 
+		pm660_fg: fuel-gauge@4000 {
+			compatible = "qcom,pmi8998-fg";
+			reg = <0x4000>;
+
+			interrupts = <0x0 0x40 0x3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "soc-delta";
+
+			status = "disabled";
+		};
+
 		pm660_rradc: adc@4500 {
 			compatible = "qcom,pm660-rradc";
 			reg = <0x4500>;

-- 
2.51.0



