Return-Path: <linux-pm+bounces-31513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C1FB1400A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101E517DD0B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C828136F;
	Mon, 28 Jul 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFMyQI2B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD997280CD5;
	Mon, 28 Jul 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719519; cv=none; b=jNRm8gAzlCbRW4Mbs+GQdDJEC2uH4srNXwbDmjzd/HvPK/wBN02gtWP3Au8P1R0S/CIm3JQSW7HovmtHJhApgioXdm5/JePxk360mAjMHXJG7qvV5i6YiQdxF9397v2KxfoS/d93SGZboz7+6YO25YbsBw0AqrBeHYPGN8d3FUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719519; c=relaxed/simple;
	bh=jx4Ska1TApY+aqqNZzEwwULA7D1iH4iodPDHkfJyDcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AM435G1u9wg+c2jI3cF+7bjgJLffBKd8YY7ONST/loQ1/URnzwlUFJw9+4p4AwFKE8LbDNmK2nIsHugUKuomJHzsGKOSK40li/wicF4fOzTZ56P3IDTYwYSKWPkCQn7lmSV8SVbdrmz3/Dd2Wj7ONFtN9HT9YTT6GzJlBNK3ha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFMyQI2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D01C4CEEF;
	Mon, 28 Jul 2025 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719519;
	bh=jx4Ska1TApY+aqqNZzEwwULA7D1iH4iodPDHkfJyDcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JFMyQI2BSLEtnv/jJ8P4/Yaejg2rCaZvwjIuqVQ0b8auIC1DCbne+jYevSSpA6Vj0
	 6OkSVEq3vZdhxFCxvbHTqAuEAyA3MYDq/FOIxAvPlzaw4357J6x7luyT4G+zr7jndv
	 UIhaSge8JaI87g0K8y6UR9Kr5Wnft1HRcnVJ0RbN4DLRNA0talLxCIhBh8LTHJ1cdJ
	 mWV6jqQSPbqkY5fSQIWcKbZG/Dl0x62rkqzorb1RByethEg5J6WHuqtGIhDm0G9+Qd
	 u57nbNo2rqppqaGzgGUB7I4rHqV0NtHVdRz+fMVizGPs3HmUNm7JTVRL7g6W80MFur
	 6DkxRmM2M2zJA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:17 +0200
Subject: [PATCH RFC 17/24] arm64: dts: qcom: sm6350: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-17-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=946;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=CBtu8RFLxTyY7nOpFcBDmcs+exc4fLLMq2Dopx58yFI=;
 b=7qs5tS/vtm36rg7RHf8y9Lgl9oelkhZmCDro9Pevn21QHuOTyU6zdIkjmD6+ve2yGNLHO1Oel
 bfTX5igFYbJBkagMrN+t+X8q0gbhb1oPfKkftDs6isZ3PTjO1b9MB3M
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: 75a511b1e5ff ("arm64: dts: qcom: sm6350: Add GPUCC node")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 2d891a5640dead6b60386006bcbbb9aad40a660b..e07131beb47bb9e1e0119713e0efc024725f2cd1 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1563,6 +1563,10 @@ gpucc: clock-controller@3d90000 {
 			clock-names = "bi_tcxo",
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
+
+			power-domains = <&rpmhpd SM6350_CX>,
+					<&rpmhpd SM6350_MX>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.50.1


