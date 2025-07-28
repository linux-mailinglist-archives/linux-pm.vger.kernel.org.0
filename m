Return-Path: <linux-pm+bounces-31506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB76B13FE6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F733A789F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CDC279357;
	Mon, 28 Jul 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0Pwb2H+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC6274B39;
	Mon, 28 Jul 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719461; cv=none; b=CIb9cO5XmerJRJcO1R/Z1s7BYvrYUJuJGUnesqv0pDzKe6nIllBbxaHbJLjDvIx4d1WHnUx5qL1tnYslRz3nqbXXSyE1ATGlKgvewDvCV6g0EcqLYjMBMvn2FrUSjMl/VPss6mwASESy/c/DBo4cxCglsnaE+ODalc/Zpv5q8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719461; c=relaxed/simple;
	bh=PvtijDfZw/5q3K+Xnbh8XjGcGzfW709khWtltu/WHJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Im7QcS4FEoOOdUgApqdX688zOyFjRnXzQV53x+fcqbMVPT7H8x8A76qI6HyKiT0shWef6HSACHtjYFGXpShHwe+oxnkWQGDMt1THC2IpavQAAtce0tDQAGYxVaFsmEP/OV4H40f6KWiQLWxDxUVOZ1VJxC8ZxwnoXssUuSmJ/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0Pwb2H+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EC9C4CEF9;
	Mon, 28 Jul 2025 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719461;
	bh=PvtijDfZw/5q3K+Xnbh8XjGcGzfW709khWtltu/WHJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s0Pwb2H+o1/PkhXOSUec+F4Jc71cLlaOIuVgWfMJb7VXR0Ketf0n5cLiqkk3gQtwj
	 xUXFppi0LJYZRZTGc7WLhGdCdxppCyU82WWFporGJuBVoBu5S+U3uDrp5MZzjMdgnb
	 hAUjUzvzDZ9crsVeUo+LpUR33jKtLmeIAhlY+hWEntlXLKKyaH6tR/RynZ1JzJzq4F
	 z1HVDAWzDIsuF/hqJ8GdKi5dKXXVMC5L2tyRpipDJnVPW//kmTMAoYumCJ7rxUhEuK
	 9LIgSyqz/Wx9mKiUv33rn6Fkev3/7SUKVbW7BEs58Vq1AHseeNY4SMMJ/NCw0xZz7E
	 vw4fxpFgrwVSw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:10 +0200
Subject: [PATCH RFC 10/24] arm64: dts: qcom: sc7180: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-10-09c2480fe3e6@oss.qualcomm.com>
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
 bh=5ZuV7p3ud8r9dzx9mrDMbLo/CiAASGX6zXvwrhndNtg=;
 b=eJPPimcy66wEhjZOCjp9RfXiRk7Xx1N3o7Rt5kBgC0Otr3CxKNZAZt6FSixA6zAnUl5v8lhL9
 lKWXDk9ZGSZC8VnQOrrY6/RxgzVPHikj6AIzfaNTTZPKawsg2tCVRVZ
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: e07f83544e79 ("arm64: dts: sc7180: Add clock controller nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 8f827f1d8515d6113c85a2ecacf7ac364e195242..6a914378f8f09c2b037c49cdc29b97568b0314c2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2300,6 +2300,11 @@ gpucc: clock-controller@5090000 {
 			clock-names = "bi_tcxo",
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
+
+			power-domains = <&rpmhpd SC7180_CX>,
+					<&rpmhpd SC7180_MX>,
+					<&rpmhpd SC7180_GFX>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.50.1


