Return-Path: <linux-pm+bounces-31517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEB8B14022
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E14818C1516
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F36277CBA;
	Mon, 28 Jul 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM6Gpy0Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FAC27467F;
	Mon, 28 Jul 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719553; cv=none; b=sSLNtKrGLy1TY29ls1qQDJG1lH+2MPjsM+dishDTa0brZEqSe13TgwJuqBHNc5K7uiuREc5HJ3nqbGMQn8cehxY/msxRdI/k/xcmczrpGI/Z9zWxyMmHvwO9t+yTiYRg0Z1qPPipUxWIi1PXeckD7OA3Pd/BG05vkB74HoGVfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719553; c=relaxed/simple;
	bh=7kCjRl185JbLw+QKgbbv0i3gISCAX6HFCKXw1ieDYWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2N2xNzLf37IHL9Y9Dv1kS2Pmupgga66STu1REgxlJnItoqWOP1B9pvxjBnU5jYgDi97SPW47Yc3fHqdrTTrBIjAtL21qHq8YNCF0mX36sjG2CC3NPdRxpHtBHfUZYLr5ZmtAr6ty5rOg+KkiQuLmqTUI9NHwpIio9I2EkTjNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM6Gpy0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5054C4CEE7;
	Mon, 28 Jul 2025 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719553;
	bh=7kCjRl185JbLw+QKgbbv0i3gISCAX6HFCKXw1ieDYWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FM6Gpy0Z7fu0zpCw4spYYJfFkU1I5A7SVomN+AEM41EBtGbSqCdeF5sVAi0vSARZk
	 rouYNosb/ocQYayzSwkIAqVjufHjlC9te5rvamj5yl6pBqiC+NUn3awRtXTrr1cZk3
	 eKOgrJeoX0vRowrA10Y8WLIWEs5FTV6SiAoK6MXuwendTIMOUQtN/MgvCoNlsa4Mgk
	 3PG9UOLyd218Ya6wYJhkiMJWHa8hJTVHq8cvOQ0uyH9DuhAXkhEnY5B71NWsmIZXTu
	 xyJ6xXDp/TnZWbTqUFGKTeZ7QNgd+HVM+TvBb+uPnb0tOy0s50rOmCcczA6MHagd3j
	 HQkd3PEjETydw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:21 +0200
Subject: [PATCH RFC 21/24] arm64: dts: qcom: sm8450: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-21-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=1013;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=u94ABntxT7rmNRtR5fzQAkG8fR5tMl60/+unK6PU6eY=;
 b=2tQ6uNONNndlEmpz3RelLsAGybJrUze8QJAb3pGOySJjA/cQvwGjnywIc075q+TjHWxEESVbh
 uE97q5K1yA0BWogIfIk6gWoYHTYo8M7OyOcBK8vCGY6R7BK2wwL54kM
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: 9810647a0436 ("arm64: dts: qcom: sm8450: Add GPU nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 33574ad706b915136546c7f92c7cd0b8a0d62b7e..5bec6bb4bf28a7c1356e96ba400ca9c0e182b105 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2561,6 +2561,12 @@ gpucc: clock-controller@3d90000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
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


