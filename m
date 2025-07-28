Return-Path: <linux-pm+bounces-31515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B213B14015
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6536D17DEC8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A0728506C;
	Mon, 28 Jul 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG3extrH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF1275845;
	Mon, 28 Jul 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719535; cv=none; b=LVcEJ6MdIFhu8VW8hKmYIwX5h7JWo5X/Kep+LwQSWu6hhQL/qPeADHIr30q7td77Rj1JcivN1p4xtFh4sIqSF4dati5WLoO1IO5vt49/rO3PZw+XBfTiY5F7IbEFsQwyABMMXpZJsOWCFX6swucjqMofd5bcxTVSQ63UflmVtLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719535; c=relaxed/simple;
	bh=HH60zZjWTlU0wXnZ4z6VnifKgFvC6d2XlKykWosTVdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0vhnFRMagrXzWSyrq1wQi+ira5QO3L6fz7fzI48i6/tCMB2ANVwqfsb16++rQQFve3o2fQr0pldDMcl5xe15R8KW81qU1hSU0Lr3SYcpCynepcij1SrNBgDeku5CjbSSzwVWmoBVnGiX4juN/TlwhP2x2DO33O43JH5Dwt4+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sG3extrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47B8C4CEF4;
	Mon, 28 Jul 2025 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719535;
	bh=HH60zZjWTlU0wXnZ4z6VnifKgFvC6d2XlKykWosTVdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sG3extrHDwEy5zR66PeD+aaPfXQ2FF8LXMRBYQUhSYY9LIrh0Um2CJ9dsooe/OuAS
	 XBEyXC+s8M6j0zmqlzYlW1RnPtUUwzwhxryFGiINbygjWmpaYqnDuMIipZG6E1lAgi
	 39UWwku7/NjpwiA++9EI6TGAmefqy9eFXSvro9my13tyZQ9l28tbFcXgHuELpbCVXm
	 w2Re9/BXbVx2n8LQqBpj+rDIAjwqL/yEEVE6gbRuuDkEnAcCHuMBUp8lpe66Zzntwa
	 /kPywEjmptHei359pvm+CJXXqKxmJnbMOKREgFomNvfUYP2NVuyFfJBpxadbJ9slOq
	 jtZUmedKn8YvA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:19 +0200
Subject: [PATCH RFC 19/24] arm64: dts: qcom: sm8250: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-19-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=974;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=peafDtLK0uREysirFOc12PPjt5MnpMzr/vebIO6eSFU=;
 b=ycLehC+EwcdkNgvNHjF7sLAH14ookDw8z230UCP3td0zyqJint90ziFqF55MIiBeVBDQjnHlI
 vC71UXI7/iYDyAsHpAQ5ZVrmWRMv5rx9FmPSxecN+y7Oweir8kLJN8X
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: 04a3605b184e ("arm64: dts: qcom: add sm8250 GPU nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index b0197602c677d49f7833f31d71f72436499bfe84..2e600ee18b58fef6e479f9cab5c2af0324d453cb 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3044,6 +3044,11 @@ gpucc: clock-controller@3d90000 {
 			clock-names = "bi_tcxo",
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_GFX>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.50.1


