Return-Path: <linux-pm+bounces-31511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC81EB13FFF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB5018C0EBB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2056B276051;
	Mon, 28 Jul 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhcOJ8x3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F1274FCD;
	Mon, 28 Jul 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719502; cv=none; b=ei1R2/QU43zG+1zuxGhPOhW1hAhxilVTOUso7eFpTqtyymZS2JkksdJbkKoY13S8XTl0ioyONYr1BTT8i2OyQjygQ9j9WX6+3WzX5iWlV0ei27Bmf27fJnxVGLcaC//HSkYBwhbHlRDYjD5RfT2MzwiC8Dwat3qYnWuNAUJzKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719502; c=relaxed/simple;
	bh=er4sNivZ+XZYOJ/cojDEZIiIA+kxvsnJWSy+/etPRqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBtmpSWiqnJY79pdR8nEKN41wRnvLjaPooNQxPui1UAI07Iw3d/D/oDBMM01NI0D2AciKpxHOIi/93tdfj3+39Iq04RaGOKRDjubfCuwT+WjrSRtUZui6ddwQOet+kLVmtEmeCWOR08YHF67UBXbbb4KE5RgrECSEp7cnp9+r/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhcOJ8x3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDFCC4CEEF;
	Mon, 28 Jul 2025 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719501;
	bh=er4sNivZ+XZYOJ/cojDEZIiIA+kxvsnJWSy+/etPRqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HhcOJ8x3QB++5DwdVpqK0spRAW5FEhmYSHEd0lXWJQlCiQ2A5MsI+4Tdh3O935wt9
	 acTZT/TxpgMKlPqANFLTogqwJG5qBSPzw749/xZxBMYXgolxBgCrd0b27bcIASVNab
	 IJH+tkApiGXg02t3aZb7o8kL43dpsB4l7fQBh2ewzhCGX9Yjdx2h74DpfS8wLRF3C5
	 WeUdpkbGrgxT7vprQObABW00YJwc+I/DlOaee8/JMtKkCU6jYRqtCg6fUIYQrKTMXk
	 PGca42ub/xzJwUlazzku304dMU9OWEJYZJmxMpuAfN/UxdWqi+O79FzR0vOQ0trnF8
	 Njz1Dw3LGSUTA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:15 +0200
Subject: [PATCH RFC 15/24] arm64: dts: qcom: sdm845: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-15-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=944;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=sNfOejmFll5EJJITkM6+N1pW72WMkf0hj0gPA6Kz4k0=;
 b=1D4L4LjQpAp2iLk+IygLYcvYrxtI9ajAMFgfNCcJ8oopfEDCcGT6Z0PFpGOfJVAWo7uX6qJis
 2uJZZDtGQhyAJnaIlAbTEiD4fNtSxsRjdVxdMzyE45ACUgtj3l/QTwC
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: 9aa4a27ec6b0 ("arm64: dts: sdm845: Add gpu clock controller node")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 828b55cb6baf10458feae8f53c04663ef958601e..7707f397a00730c1f4ec6d75ce87469f8fca9443 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3405,6 +3405,10 @@ gpucc: clock-controller@5090000 {
 			clock-names = "bi_tcxo",
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
+
+			power-domains = <&rpmhpd SDM845_CX>,
+					<&rpmhpd SDM845_MX>,
+					<&rpmhpd SDM845_GFX>;
 		};
 
 		slpi_pas: remoteproc@5c00000 {

-- 
2.50.1


