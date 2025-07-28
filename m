Return-Path: <linux-pm+bounces-31503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B1EB13FD7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C92B7AC8BD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A292750FD;
	Mon, 28 Jul 2025 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAWrDzLd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DC2750F0;
	Mon, 28 Jul 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719439; cv=none; b=hN78Ng1mRUqLtqxreHj7Gyn1UbnXNlep1uHN4IDT+dTF4lnYGvFysPHfBG2pmE6cuGm3Cu/G3/iL3fjjsDeloHacAga4rok7Biu0OOFHTwsLcr8Ch8OzCFGqO+ndSNUf966qsESAhb9cPsi9qhGrBmWRIH5faA3ZNUSFfr26hWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719439; c=relaxed/simple;
	bh=hOhV4mypG6u4IYwO8pHPqTUeBW0RFvMFXmaU59nzY/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYWWoBteIHl4H9hwnFLWC6su3pS9vHOirz9ea06l5e8l8IuarQF8CxWq5e7gyns1i0INZuuiKPRTn2i6Jog+M5M7qbhLvmA3ZHcZFvK+cVCYWDvyqYmPoK4i9Q52s0o0lOVCCxlHNYkpALW57cIqRuJpmphIeMkhV4uSsAPBvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAWrDzLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF69C4CEF9;
	Mon, 28 Jul 2025 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719437;
	bh=hOhV4mypG6u4IYwO8pHPqTUeBW0RFvMFXmaU59nzY/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XAWrDzLdgMMy7EwEIwRVn99LFHhZmKynxBKoeA+IszP6Ew3gTeu2akKzmfffkGM9n
	 l6UMeXGGvz707Avj22UlOUqB0H7vBgvuBAsDqC/meR/CciD00+EvuuotJMTT7g5PcO
	 B1zCQ7b3zClTyq+XNr8b+GCV06boDPWLklwhmeMiePB9odMhxfw5E5Hg2B3D5GA5AV
	 urqxmBf5NbFpdsYMfv50E7Br/qh+XJqFUvG/cSYv9t1AMqMkTRLu99+FQ7NB8OYWEn
	 hgdoMEWR1u67jYMrtM0QZ8efuvVKptLy42gBgYzXg4iEHGLrxvWk7P7KwcAZFwydRH
	 woQII/3MESR4w==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:07 +0200
Subject: [PATCH RFC 07/24] arm64: dts: qcom: sa8540p: Describe GPU_CC power
 plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-7-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=995;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=tQsiXqur9gEsOH0IW2Ct4Y9vpzqsGA90X/jmgFKSWm8=;
 b=Xp9S+1JfOflow/QTg3UNwrquZkVR4ASwRtvNwwrdqJjc6RtDSNa8fBA21I4Yz0MydNOpFu/2r
 xZCZppnxBfNAf5Rflz++d/KZk4fFjS+M0At/o5OUZVKVK4dZXzvhvwv
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: eec51ab2fd6f ("arm64: dts: qcom: sc8280xp: Add GPU related nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8540p.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 23888029cc117956d8531c423c3249e897ede0d9..96fac8b20cffcce2670d71499d5b9831dfcdcc94 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -168,8 +168,12 @@ opp-2592000000 {
 };
 
 &gpucc {
+	compatible = "qcom,sa8540p-gpucc", "qcom,sc8280xp-gpucc";
+
 	/* SA8295P and SA8540P doesn't provide gfx.lvl */
-	/delete-property/ power-domains;
+	power-domains = <&rpmhpd SC8280XP_CX>,
+			<&rpmhpd SC8280XP_MX>,
+			<&rpmhpd SC8280XP_MXC>;
 
 	status = "disabled";
 };

-- 
2.50.1


