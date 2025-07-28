Return-Path: <linux-pm+bounces-31504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA0B13FDD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8824F189D8DD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A3277C9B;
	Mon, 28 Jul 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WITDD31d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1058E275865;
	Mon, 28 Jul 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719446; cv=none; b=nmwVG/61OB3t2nsJGUFEUTC3JBgCHSbOCDA3AT4XbnJIXrSzpMTpwCoFfRXNiA6IZKRafgCSeoHZASx2PObbGMimxcYgsh3fT1VbNOiAQrdt8xIU4Ly4cgtqZWWo+ZnjuWGI5hOkeftazVgyiDbTm7SiqDpkNMZBCpc3+2ctdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719446; c=relaxed/simple;
	bh=WQiLF4oNL52tEZUXketgbn7whPQvO+IVuG1wXQ49UGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lWbnJYaRGrgQQ+Lr5pbnlu8eD28BF6PjtBEQUq6Kou0f7GMLOI05ReZRehOeAwm5ht9vwWBB2zH3X3t1zDfrQEFnVD4CzFCucQlH4wAFXW5s0YeH2+e+CktonTAvmjiSEKFH1gH3sYDca2FnxlvUKU/CsaHcJ6vLKQfOZVjbT90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WITDD31d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2FEC4CEE7;
	Mon, 28 Jul 2025 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719445;
	bh=WQiLF4oNL52tEZUXketgbn7whPQvO+IVuG1wXQ49UGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WITDD31dU9CRxZsbVrmyuzNV586jl/V9UrywGdkgBLkvOwb8scR4UoB8GGp3vP4P+
	 C3QWBmxWtTL0v2pxlqfI3hXn5rp7xrqE9rQYaDosbgL73OdzGNS/tK8PvnumNvOBiO
	 +PQ4mPBFQjLBy9R56T8IBBCeXD8r6+uAav9iY88Y+rUuYU3e2CS+iLW7WsBBeoqZ//
	 MB28baLVArkCLErwRh9mWZle2V6tBHS3M1fIg5aw3i6r9wAGXKmWyD9qmSUsJbtSXo
	 n5tN4cahoW95U00KPB8D69HoO38TVLG+cJs6T6iwdBmvP0mFGY1wugKZ4shhZ50q7G
	 ylLFrou0Mm1RA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:08 +0200
Subject: [PATCH RFC 08/24] arm64: dts: qcom: sa8775p: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-8-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=1031;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=FH1O5JI5TeBP2cM1w4bq8m0nN436vpBhDWts6De3o58=;
 b=5OBZoy5ZrenUlKKi+6uNcFF2fQfiLdQNFWO7JVIN16LpTsx5fDI0hCyCv7pWxUotGIt4Q4o0Y
 e//W8dQEHZuAX1EZKLVj0afWH1bz5fdNm4rXN5FQZn5+h5/CzLEBzhz
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: 597cfc178829 ("arm64: dts: qcom: sa8775p: add the GPU clock controller node")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9997a29901f57d7894dc1eacb6a809caa427c6c4..e41972af604b328cf964997dde5a7d10b2727fa8 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -4089,6 +4089,11 @@ gpucc: clock-controller@3d90000 {
 			clock-names = "bi_tcxo",
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
+
+			power-domains = <&rpmhpd SA8775P_CX>,
+					<&rpmhpd SA8775P_MX>,
+					<&rpmhpd SA8775P_GFX>,
+					<&rpmhpd SA8775P_MXC>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.50.1


