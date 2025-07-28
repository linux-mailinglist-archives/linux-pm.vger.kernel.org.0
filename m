Return-Path: <linux-pm+bounces-31518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D12B1402B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F6C17F118
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFA2874E4;
	Mon, 28 Jul 2025 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNDey2X4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0928727C;
	Mon, 28 Jul 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719561; cv=none; b=dzF4U/dZNkW0gIRZl0me7w9qPJ9nVqNrLPG4eo/iS5NO5P9gjx571LfJkwtkZ+VZ0hp8Ham2ek/sXvjpmrK8a0Lr0BBcFxMOnP3EtFXyymSV+6WnAUehrRsQp/Tmp9bzkvTkQEbDMVxz2SBorWkZqw8PHjkvYKeB9MJjIMHEZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719561; c=relaxed/simple;
	bh=LdL92/yOKAh4miDBFZiejc+tSp5S8V1HH0dCPLiAENo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1g2wuMeFamowvqdxeIanTpBsoy88ETzPV+ZaChI+Npr/p2C0ENRHWSwuB42qWsfqu6w/SDeEGU+DdvbPAANdgwNKXfVERtRbWm6RXsllB0se2s9ZIi9ZmaYoyz+C6tt3KLWZMgL4LWJ0IyElw5loaie1fAyG+wMjqPj8Q2MSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNDey2X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66C3C4CEEF;
	Mon, 28 Jul 2025 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719561;
	bh=LdL92/yOKAh4miDBFZiejc+tSp5S8V1HH0dCPLiAENo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WNDey2X4L6DaF9tEVdBlvmE0VwuSIr/T+8Tr4WgDvM+A50rsxeVGs1oAsTPAh3n6d
	 WwPi/2eDIMoMoX1KK0AEsqTYdsloGZqEAD7U+tJM9sQ2/pOqg06qrGNJy9vGmlrptz
	 fRMU0ENPUNq7Sijxb1Nf4+VhtOAdzlb/oAJC3g0PNQD/yBSh2EM8JJleNVtD0WJ9QH
	 nky7xAHE3EpSWPJZ7KJWA3wE0ZVxlQ1F2fiz9BXxMy0Fln0fug/QIXQz6VdC5xIeRY
	 hxJ+TO+Bc7eSHu+zX8/a2oWJlin+v4xjHM3EjlbNIhLMeDVSinNHzx+MKhbgNbF610
	 2zf3b0tIwNdew==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:22 +0200
Subject: [PATCH RFC 22/24] arm64: dts: qcom: sm8550: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-22-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=1022;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=vuLLKb704aE8th6aWRIisE2W3yIvt2ooobOFgZTAovg=;
 b=mGjLRbn0GsddWmRzmmPBb7LlNrbrYRX5WWa4sWP/V4quZPlMGw0bTH7fgBWQmLPV6fRB0gYZF
 DBfY8E37rqYCQjWIWDvskTjb+jaqn5qm+zlnCq6NJz95wD3ni5mOFKO
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: 9f7579423d2d ("arm64: dts: qcom: sm8550: Add graphics clock controller")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 45713d46f3c52487d2638b7ab194c111f58679ce..28eade49526dc9bb0a7b211f96dd350873489029 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2572,6 +2572,12 @@ gpucc: clock-controller@3d90000 {
 			clocks = <&bi_tcxo_div2>,
 				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_GFX>,
+					<&rpmhpd RPMHPD_MXC>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.50.1


