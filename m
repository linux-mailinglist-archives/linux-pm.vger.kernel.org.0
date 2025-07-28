Return-Path: <linux-pm+bounces-31514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C163B14011
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1BB18C0EB3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30DA2777F3;
	Mon, 28 Jul 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QosliDdy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349E27511B;
	Mon, 28 Jul 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719527; cv=none; b=i6jQ8g46JLks6rWY65jUFL9FC+trPTGPdq/KOUmVEb4HyvgORMJskFZtRPuR7JAwesGlEyssvyhUHftMRNRW66+Tb4vMyA+/jcOBqbpqB5l1dTXV0yjyoVXrXhc14afkw7TlmoHyPxauczCPUDb+4kALZgc7A0yLBg2kKnuOxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719527; c=relaxed/simple;
	bh=sgHG105ovCBXFzF5BzByZClWFWFgEOEZQjNaiFBSDYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZdzWDLhs984r+X8FE1irQV9cB+kHZ+HKQfMsDBfouy0sBnPVB8/ilOjUAjTA8Wyou2JpsouYeLFFAnpH/8JuywBOEFoQhqCPB2bfk/VJSgbc6bYXiYrZ10gMOts2lS3sOhVyXjjV0uPrru47pEHxnefZNoXlnoTsNLc0lynNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QosliDdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09FEC4CEE7;
	Mon, 28 Jul 2025 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719527;
	bh=sgHG105ovCBXFzF5BzByZClWFWFgEOEZQjNaiFBSDYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QosliDdy/3+5H/f3QIsH4WMDW/gkCKg0fyoZyLeH0lhlh7RV00EakoQK21ppRa49Z
	 JUuIebwpiQCoSkCRu356dY3sMGbJ2r1CH5SblV2JY1Zy8iUB+yrUB5C9mRCF+et/Sn
	 HQVXe77nmdTkYKX13vb1ALaUKnJwV6ABN7sXiNoswuQ97vsb98YGebSHlc4mAxg7+a
	 rmaUzbjA71gyrpcwYwBrmnaWGFzdKGJCNRM9pUxx02FV6YPu7Zzj8WqGkoCQczURbS
	 4kNUQsWL0kXBCQ7PGYYlIaNbkjT/tHr5bcYTeOtXaQ4GdiLNo2oeNo8B2A71xF0cli
	 ZTMJU+3F5MU8Q==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:18 +0200
Subject: [PATCH RFC 18/24] arm64: dts: qcom: sm8150: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-18-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=1493;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=2dwNHJS81VpjRGaFvEyDUzk7e5QGc+DheDtnPTAjquk=;
 b=Sf0gnuGCZg5xs25di8e0LVROhtkmhavfTzK8oa+qaIoEpXOnfzchfs9mjNFs4AxOgvoWqr6/E
 +wB9nHzjZmRAKauB3Uizs5LGX/mbntDu/YY/Ve8VwlRRm5kfoUPnF9d
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: f30ac26def18 ("arm64: dts: qcom: add sm8150 GPU nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8155p.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
index d678ed822378b54418e4c93787f5678cf4e2a798..40d827b7959dd6a5c5ae72f2e91a0249d8398872 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
@@ -17,6 +17,12 @@ &dispcc {
 	power-domains = <&rpmhpd SA8155P_CX>;
 };
 
+&gpucc {
+	power-domains = <&rpmhpd SA8155P_CX>,
+			<&rpmhpd SA8155P_MX>,
+			<&rpmhpd SA8155P_GFX>;
+};
+
 &mdss_dsi0 {
 	power-domains = <&rpmhpd SA8155P_CX>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index abf12e10d33f1ce5c74e3e9136585bcb0a578492..4febadabb3ecf4c76e1733b02b10036c57670b25 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2351,6 +2351,10 @@ gpucc: clock-controller@2c90000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+
+			power-domains = <&rpmhpd SM8150_CX>,
+					<&rpmhpd SM8150_MX>,
+					<&rpmhpd SM8150_GFX>;
 		};
 
 		adreno_smmu: iommu@2ca0000 {

-- 
2.50.1


