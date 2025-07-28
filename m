Return-Path: <linux-pm+bounces-31510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04134B13FFA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8473A17DA9F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098227603B;
	Mon, 28 Jul 2025 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0C4XL2q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84F274FCD;
	Mon, 28 Jul 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719494; cv=none; b=Ii1jzSVZ9QiOUMf2I9CzsKJkssuBeQ7gpBREz62MEM0/wVobHEdRGFG6H069Lc9JUTSflCiyZ/VpxO1CgEFKz/x4Utm1R8NubPdP228psPk7wbwW9D41rROIkCxBn/G4GVmG+Pio4upBE6AkBaaL9Qe5M+AQNmBTeSsQpK4Z7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719494; c=relaxed/simple;
	bh=+PbVLbsab8OwPngXo6br3NoOOqoAR2bzAI0j7TFfbjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lq+NUjKYe2ONlv6t6ZG0Ckmx47LU+5T0mObZkLGag3VYNw60leGfNS/+chAoiXAbYyINryGNxOmkXdjHV4XZ8TOKzbenwn3A0wNDf/s3X6f17MxtoDZWRGG6Jo9E9sKpgMz6af0yJgpvPpljVfzRnZMeil/55Taya4+75DixQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0C4XL2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC313C4CEE7;
	Mon, 28 Jul 2025 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719493;
	bh=+PbVLbsab8OwPngXo6br3NoOOqoAR2bzAI0j7TFfbjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l0C4XL2qfL+rvhvD7/DvtE1xSRFgwA88a+GShb1ESlEW7xo8RS4Xmrj6T3xM7KI/k
	 rAVo8MJ4eWVH43BuJ0OpMgehYRLFRnTT39oKoVKNT2ekgC9vdrVh2weuvHp9+bHtmx
	 y6/JhWSR29Zo62IyDvhYAd0j04L84IqTAaSuUwQ3+gIddiFwahMDnMYgsdonvLllyu
	 4ABIj3AyxR9M1q9/bDHczgDfbnNpzVC4+qmW+S7T/0q0VR7af9CqZ5KXqaT79/DIXF
	 BN9CFHz1BLJ33VAHvkS0gVSQtoT14be7i+qNvY4bYjtcP7gubk2vI5MzG94hAAsaZc
	 1rNaYzQlIDhhQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:14 +0200
Subject: [PATCH RFC 14/24] arm64: dts: qcom: sdm670: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-14-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=924;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=PASW3oIMsS8lLtuLdyhXzJYTKfB341DwDSiXXABvqRE=;
 b=8iKJHhDlDTczWf7l6F9csZGW2K8w4UnKkRXytD8vZC9/JIrTlhdQ2rCpgMawf92XNdH4qm8Wl
 5lImRDdjJmlC1lefafWioJjEhxosPgyApgyNnoVrl/3e2MDcoU3sPv7
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: cd89483a1327 ("arm64: dts: qcom: sdm670: add gpu")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index c33f3de779f6ef457a3336fa4fbe39175c378cce..82356319508615be959443f75c2eacf324691589 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1521,6 +1521,10 @@ gpucc: clock-controller@5090000 {
 			clock-names = "bi_tcxo",
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
+
+			power-domains = <&rpmhpd SDM670_CX>,
+					<&rpmhpd SDM670_MX>,
+					<&rpmhpd SDM670_GFX>;
 		};
 
 		usb_1_hsphy: phy@88e2000 {

-- 
2.50.1


