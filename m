Return-Path: <linux-pm+bounces-37389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C42C32CE0
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 20:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F73A751F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 19:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DE92E03F0;
	Tue,  4 Nov 2025 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXt+YcxY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AC20E005;
	Tue,  4 Nov 2025 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284716; cv=none; b=V4c26lgugYh0SzzGaHBDBIF/enPa/6NYh2DqcLhmyH/K/hRlnVOW0A2ZwgW/oi5razLC84Tub6fWz36SRTxrWLccDH1DPHJ8TZHRY9X/LfOIimU3CILMVcAH53cKAEgEnr4hKaH6RYeBIOQ10Fmqwd8Y1IkV1RGpaEjI1I861m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284716; c=relaxed/simple;
	bh=Kl+wo+HN3lI8xkjGWNgfHJlbvzw0SuKTXMs2Srp2rsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PpA8Hjago2401glR3SKt1nByZBV6E9Qtcz1wjLo6Eie2BrUn/wn2s2wkcEW3ALwvAh3GuqaxIagE0+tf15GCuZSPKlWgCIQDIPsp28rBBBe+a7YR80Ho3Gs0bFSn+eykMoK9x9ZGPboeJqKoUmd1hU0Ic4Tmf1xXlg4NsbH/QuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXt+YcxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A29C4CEF7;
	Tue,  4 Nov 2025 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284716;
	bh=Kl+wo+HN3lI8xkjGWNgfHJlbvzw0SuKTXMs2Srp2rsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eXt+YcxYr8CIlHop3e5wilcbfiY/eajgAtd5Es9ss9kRoW5vD7iG5gvNvZ8DxX5Sv
	 QbwU2v56wxG9knfNT7PqoYSKO2leIW1DMyYhTMHlGprjDNhYs0ihdOiVDuK6KV0vvd
	 sqZc28ijZkPFvkTiKQVWvDxo2+Lh/M2yE8UL+QtB8i8e3WiryPl+SHjh7hMCl6chQv
	 ZZQiJ7J320wgmXeQ3uTyb3EugCVEJEDfvrfZ5ECpJwRxCEk6PtpP6z3QQQvB7FrtKi
	 39f/ep+Fx0DcpjtvOtUsRMr1qIhxh1zZZhQ8OaLumkDeaHmD4sNjqdAmudwQjQbs1I
	 60RxAzDEyz4ww==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 04 Nov 2025 20:31:10 +0100
Subject: [PATCH 5/5] arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-topic-8280_mxc-v1-5-df545af0ef94@oss.qualcomm.com>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
In-Reply-To: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762284668; l=1971;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=R7jt8NMoYhy9MTrvBoxRcnuCAEN/9bJ723qqQzOSQ94=;
 b=MQtgUK/V/ZNwy2PJTwVOCJytXboBAWmy3xyt8s0x1rzjSjOLrVz/jHLqzAE2+dkwzgGXOvxl/
 p+qx7jraZFyArfbEzcVafYwcdUvnOnbBy6L/MvLH1u+qdkk4XAmY6v3
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

To make sure that power rail is voted for, wire it up to its consumers.

Fixes: 9bd07f2c558f ("arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp")
Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 5334adebf278..643a61cc91b4 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4586,8 +4586,10 @@ camcc: clock-controller@ad00000 {
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>,
 				 <&sleep_clk>;
-			power-domains = <&rpmhpd SC8280XP_MMCX>;
-			required-opps = <&rpmhpd_opp_low_svs>;
+			power-domains = <&rpmhpd SC8280XP_MMCX>,
+					<&rpmhpd SC8280XP_MXC>;
+			required-opps = <&rpmhpd_opp_low_svs>,
+					<&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -5788,8 +5790,12 @@ remoteproc_nsp0: remoteproc@1b300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8280XP_NSP>;
-			power-domain-names = "nsp";
+			power-domains = <&rpmhpd SC8280XP_NSP>,
+					<&rpmhpd SC8280XP_CX>,
+					<&rpmhpd SC8280XP_MXC>;
+			power-domain-names = "nsp",
+					     "cx",
+					     "mxc";
 
 			memory-region = <&pil_nsp0_mem>;
 
@@ -5919,8 +5925,12 @@ remoteproc_nsp1: remoteproc@21300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8280XP_NSP>;
-			power-domain-names = "nsp";
+			power-domains = <&rpmhpd SC8280XP_NSP>,
+					<&rpmhpd SC8280XP_CX>,
+					<&rpmhpd SC8280XP_MXC>;
+			power-domain-names = "nsp",
+					     "cx",
+					     "mxc";
 
 			memory-region = <&pil_nsp1_mem>;
 

-- 
2.51.2


