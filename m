Return-Path: <linux-pm+bounces-31512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F60B1400D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4DC7ADE3F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F251277013;
	Mon, 28 Jul 2025 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQPTa5Hp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E42750E8;
	Mon, 28 Jul 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719511; cv=none; b=DGRuICti4kRb+GZqYlF6tW6LPklOQxiv0vDBBlIA30xK0+BO3oFsUt2a5NqMAAFcYczV0k9ZbNwaVgI4c7+FSlO2JKSBaD4c1o4jg2hroACmJfBK56f9nC0iAqVXjxGDlrqty2w0zJcgKRzmD6Q/BJzrkqRWSH1N3Vj4IAbYouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719511; c=relaxed/simple;
	bh=rbsxuOCDE4xlWATneD6GeNmDtQOgqjrtC2cuqV9Mb9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pfp1T6dBFBFLhe+A2nsWuMjOzNjDu9/JE8RApoMa1BH8/pnDe0VVZELeAv8XTnls1Hv9SZUmmF2fVhGxw7+SNyz1xCFtwb8Wv/FQjNwLb0x35uWzROLRX1oaGILA6PWhDoMdrP4bLd3/2zh5uNv9M2IZMNKWNLEkh5PsMdwHqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQPTa5Hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42ECAC4CEE7;
	Mon, 28 Jul 2025 16:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719510;
	bh=rbsxuOCDE4xlWATneD6GeNmDtQOgqjrtC2cuqV9Mb9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NQPTa5HppscN6zN09sxsBQ1YZsd29YVYTxwRBZul8asEaDk3TkL/d6sP2r2lsJdPa
	 ntWIdeXbw9ysD4synkiFFo9zlaqYk3+9KrUIkCVLY15lAZgg0Wufoxm1HFnociLnYv
	 V8MDx7r4AN7SXuehXGwhT5X3PxuZC4GGnZtysz9bmTF1kWFFm+YlKhJb6ybgH0zGEv
	 csATq8PnwtoWalcB7FgrQdpCnY63Ap+TbSqfySRZgDOWjsw9LP8PfPKWyFSEYMkLfF
	 pbKd9VL9EoTaox81dharrqXLxRVAp77Nkyc4/WW7Ncfl4bV5tnRJZx8JCXGgWRO5Nr
	 3daEZ3mGNC7aw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:16 +0200
Subject: [PATCH RFC 16/24] arm64: dts: qcom: sm4450: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-16-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=982;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=1aO9Dfr6ph9yLVOQ2rMp8gFTofFwFGCush9wb6f02Iw=;
 b=xkItYRRLgcIIidBnLZeZA6HiNAaTEAn4W3YS1V9o5DSPn5OvKECFfPZZuiIB9Yh2/3hrkUtu1
 nR7N9XacS6gD7pnV+mugH8Aqgyue+LOtnxAk4xVu6lRQcwNZVquVzuH
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: b87b8df9c0e4 ("arm64: dts: qcom: sm4450: add camera, display and gpu clock controller")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm4450.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
index d217d922811e84420f0f31008e939337b07bc38b..59d86bccf892bd282cec6e59a60192e4847da6d2 100644
--- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
@@ -433,6 +433,10 @@ gpucc: clock-controller@3d90000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.50.1


