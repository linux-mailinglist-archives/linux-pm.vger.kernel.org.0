Return-Path: <linux-pm+bounces-31508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD925B13FF7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361BB7ABA1B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A448F275B0A;
	Mon, 28 Jul 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRXYgDKX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC712749C7;
	Mon, 28 Jul 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719478; cv=none; b=dEFK67sgupC/G5KSm+koSwSy3eNSdVGS5XE31rAW0sGSjfB+J6+neaHbPYMkevACGmcXibjBOX11zo6aKBaRzLsqSQYDTklmrw5KlBrpjhyebVM+SZQ3lej8LZzO5shMeJLUu/PVwIzARoH6wvgqcVGEvUBpRYiNWBL5lChbh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719478; c=relaxed/simple;
	bh=kDKXBSjhADULrqbCUDuaQPgtY7mj5fTXfpA7TPW/0G0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIMp/dTf1Ek0c7KpbVAXcJe+55v533vrOUcFSUQG56ci7GGx1bhKGwaG3tcAbzHxapUky/f1x6cbcZ9yJxDgJWyqnZQphfp45c+GYtO5dVgA9MIMI/RkuU9GDgKb1eY4mlib/yCerLPA3Xe+0G9rc0O7azlk8hRWe+caRtlgVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRXYgDKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579AAC4CEF8;
	Mon, 28 Jul 2025 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719478;
	bh=kDKXBSjhADULrqbCUDuaQPgtY7mj5fTXfpA7TPW/0G0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cRXYgDKXa9vqnF3q9JwTQRhbKYFMCF/Ygtwr18m0LtaOX+IKcSx+51Mmiq0i6riEB
	 9e7oXKmG6K5Q2XCv4pDNB72EnIeV9V10+MvM1PBzAbcNjydMaFb1XIYn8D+G3vtWhX
	 1yvG9SqBFLUIZpNgaEc6jRwwUJ/MtGaD1QL9fIxkoQ6kqlCl5LHmYATSi81k0Jamql
	 9XjXI3KT3tPaHWK7kUSqEcK5TF7x/eselCZKQYTAFy1EHF8TP6mw07TpSSEvAFrxEC
	 YOonoisqfSLA3nsOln6HZb9Q6UFOxFTYTnMYiRSgMizkbQKMvldJ2RR5cT2+KXxdGk
	 sJTVdHmdc2Nig==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:12 +0200
Subject: [PATCH RFC 12/24] arm64: dts: qcom: sc8180x: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-12-09c2480fe3e6@oss.qualcomm.com>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Douglas Anderson <dianders@chromium.org>, Vinod Koul <vkoul@kernel.org>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Andy Gross <andy.gross@linaro.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jonathan Marek <jonathan@marek.ca>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=996;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=RQY+mzOBvG5UHhfRcL0AXCtw72RNStz/Pz0eSYiBmew=;
 b=rLrvyYRQxtvida8FOMwxTjeFlsDZkDcmwimbcLomfethOc+vBL70lxE8kWn1jBP5F8QHbK5Nk
 m2dKXltm94cBlwijLofmNRKI7WxRA0Ec0tMz/DEdSx+01J4dXScxiGq
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index f4f1d6a11960c69055d001a34e893e696ae5ce77..47ddf542485a0faf140588e6888cf0cd48dd3110 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2366,6 +2366,11 @@ gpucc: clock-controller@2c90000 {
 			clock-names = "bi_tcxo",
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
+
+			power-domains = <&rpmhpd SC8180X_CX>,
+					<&rpmhpd SC8180X_MX>,
+					<&rpmhpd SC8180X_GFX>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.50.1


