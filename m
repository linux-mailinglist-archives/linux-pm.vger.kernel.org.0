Return-Path: <linux-pm+bounces-31502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F63B13FD2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66040189D820
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B3C2750E9;
	Mon, 28 Jul 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNssoZvU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851F274FF4;
	Mon, 28 Jul 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719428; cv=none; b=ovruVBug5O0szuDFlLmjxGcZP7VGN7DS0PbFdQC7ihAtZ8pedyxEJLUyOHlvk+llqHNowMXGHsGd75SoqOpockaHo91UfqCd1UhZXKiuBiCP7sAM13pYYciXtm1gYhj5ITH29RYBn5xKYRtU4aYZ2lXcEav2VCBS92AxH0P5Sio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719428; c=relaxed/simple;
	bh=wYFBDxaT1ZEoP6SKAn5uU1AV4A9UCEs90oGM5Vynf/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWXyL5GilNqdONuCQmWNBwwP+BOlvnWJ4/iR0ZF/VvK0+lI13QrKMjnpPiMdUGQFhT905QiOntBGP0FQ1MYJuvrV8JiM783Z2OW6vTQ1aoZVL2sGmIXKGAlPztPtfEMyQgNnWizlFD0/5aBthsKbcH5vwq/a6LwAUR/slci3i9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNssoZvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E9BC4CEE7;
	Mon, 28 Jul 2025 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719428;
	bh=wYFBDxaT1ZEoP6SKAn5uU1AV4A9UCEs90oGM5Vynf/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qNssoZvUcjFbyIxwnlVe7xORPw3CXNW+pN21VQbLJuiavQEUBWKGwmR7Dzg7bAuqB
	 cTvIKal34tEE7lx+9N0gF3f5J/wR7YWBGNVXPYW9EeFMD93oCNvfQRkYF4nX+SaC/Y
	 pj5eMGRW2Z50sGLuJnXiLC+qh1XNBRIHT+LWAaDA/I0R19WY8gN4MqtwpAkI4+BsAR
	 mzaQa09e3Lm5veYHf0x6BPwdDvLIUpB8mOP5Dqf9F8RVb40yNCFEAQsDRaUZu55SCn
	 l+w/sh3Ms5JK+5hkg3NoccH6gc8SHCq/sLRsrI24brBnQH4OmaYa92WIF1pXdJFr7J
	 k5nqgLUJIaErg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:06 +0200
Subject: [PATCH RFC 06/24] arm64: dts: qcom: qcs8300: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-6-09c2480fe3e6@oss.qualcomm.com>
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
 bh=NR75aUb3mTeXnDxCZL4BDL/27dUmMOHmhebBPUjn/uc=;
 b=h1kbPmSHBoQmqNWkApMR+yhCvyC9WMR7euAQln/XTIfUFOyW+GMKx+RiPCVb/CdL5+BfmLxxf
 3zp14p2el0RCsYmvS2Tj03FRVXm+aZkaM9Vx/kXF9uoIDYj6BxxS3y3
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: 795255cb4cd4 ("arm64: dts: qcom: qcs8300: Add support for clock controllers")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 7ada029c32c1f2d0488a3fd1be603887c64bf4f9..c4b1d9247ccb65db7396480d94f2ccec4c9e3e7b 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -3912,6 +3912,12 @@ gpucc: clock-controller@3d90000 {
 			clock-names = "bi_tcxo",
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
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


