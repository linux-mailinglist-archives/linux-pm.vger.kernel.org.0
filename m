Return-Path: <linux-pm+bounces-31520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9F5B14031
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E513BFD5D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6C0279359;
	Mon, 28 Jul 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s24qwQ/h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC89274B44;
	Mon, 28 Jul 2025 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719578; cv=none; b=BiQ1w3wGyZyVEgeIaq6rBcPVsXQ2A/XpKBNmxYYIEH+xK2oj3bC2GAtWuY59muGChxk0m5OWrautbjkHpiHqTug2wSxpGbYq1xgJEiQiALMlJiDhA2SA+oHHr0imY8PMxISjtMfTy0D5GkrAe1Qs/97mjuWB4q8RypZYFevcKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719578; c=relaxed/simple;
	bh=jQi+mXuUzQah1hpB0ZmxZMKEYCV600U42oolJxyRpS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMIHracvJzhngu4wQDXi//hh/WYRwyDQAge8b8VdF6sYjU/3+ZxirnJrZ7UoceT9jAUtQjriZGuNkO03avzk2OOEGm0khm9wG6MTiuiQZMTPhTdgyfk6LJsvqzlGPxxqkFV/yNQJ9amB0KGeLwE2CiIVnGueV1hufkRGaNTBV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s24qwQ/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F56C4CEEF;
	Mon, 28 Jul 2025 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719577;
	bh=jQi+mXuUzQah1hpB0ZmxZMKEYCV600U42oolJxyRpS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s24qwQ/htiwfp0NOFgFLv3vM7Xckzrq1Dv7PVgT9P10wFh88GdeyNf1R0onrt0wF/
	 7RFELWG5Gkj3TiH4im0fYgZ8iRGOlQHp27GtRRIBdYnq/X6nADgG3Z9ktA8YSH1Dad
	 lyJ9siDMB09VJi5oOLlWcavYhtyIb+3XWtDy3YC5GfQm+y9Rfsc1e9ZlrR0+Ssx3uF
	 MnRazqAkPDhYiPmEk/DF9lq7i0FLyVe+Sps5D7dnB1L7f7uCeKl7+3SmlJms4LYbc+
	 xLsJlwnsdfCuDYiCcnc9CVqQDJT60sdeIZDJQ7eBfcUQa/0Kp/Jps2kQmyiGOdkuxa
	 beCA2D5RljB1Q==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:24 +0200
Subject: [PATCH RFC 24/24] arm64: dts: qcom: x1e80100: Describe GPU_CC
 power plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-24-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=1029;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=sXUTyRKeh4DSCEHRkfxr2jS5yhoSyHaN3wcwxWm//xQ=;
 b=uHNiZMtCHnfwiDJByl5EwurECRMfeNH3gWVfdKWL2D954TtfqM4Ve58ycDVCM5o20THjZCPmb
 4NC4Qwq2o3tCPfVgM+BjaLiZOCUIzwUTswiIr/GfAShZ2dRUSAHnphI
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..6620517fbb0f3ed715c4901ec53dcbc6235be88f 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3928,6 +3928,12 @@ gpucc: clock-controller@3d90000 {
 			clocks = <&bi_tcxo_div2>,
 				 <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_GFX>,
+					<&rpmhpd RPMHPD_GMXC>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.50.1


