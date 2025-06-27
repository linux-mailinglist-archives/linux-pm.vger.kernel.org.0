Return-Path: <linux-pm+bounces-29699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E70AEC01D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38A36A2B90
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058382E8DEC;
	Fri, 27 Jun 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INT7etxG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D1920B80B;
	Fri, 27 Jun 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053103; cv=none; b=SLIQFW2Wws5LdAXUw2tBRDtPP2Dm+pCPPs+UCqh3vzJa8zc3ZhBGThtVbwiUub2fayUIwrUWi4vpFtmO905uPrxsu0GcC6t3/O3ZTevr4ssf8so9C8F/pIfWWM0DbVjQlLxAKehReanqNKhmZJA4KLpPh2Uz81O71edQCxPXR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053103; c=relaxed/simple;
	bh=Ei93rz/3bC4MEpPR5AqqOif6tnZ3n01iyhdfKf0JuA0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E71voIl6xxKyVe+tIWjm2+60KL9+hv1hupbNsr09MLLUjxFIbi1KlDwjPGv6sZWGn6iRfa4IRlFhcxsyxL+s8XX6Tg4EXcV0dz/Q10UfIukO9Cn1gG2Uubu7hoJm1UNJs4ScuuZahkwh1s8JS9PY0+P/Cs0bt/V8933GxnrTFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INT7etxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2716C4CEF3;
	Fri, 27 Jun 2025 19:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053103;
	bh=Ei93rz/3bC4MEpPR5AqqOif6tnZ3n01iyhdfKf0JuA0=;
	h=From:Subject:Date:To:Cc:From;
	b=INT7etxG+PjsdkDAUbqqypaXVxcvwGvTX9ZYnMFN1P9MMqaDOOu3z0BkeCE59zpaD
	 J+AN2Yxotuxt+cHknDTL/dNdvJJyJ9jp3+wn7lAZ51e2L933UvhBjCFgdLj8pJo224
	 Rn9VBvvOwWbyOnraRsYtg7qaPbb4YmfBorN0JEw2ROISnOdyHYYjUVKlTp28SS6ofD
	 e50SoQkGQVrOggqYUZZ7Wyk+MoZrVmJ7XQrQdkcdoBx9LOAZthizaM2maw7jGJpM3p
	 DTJTcgT18R1OO+/dYeLj958h33MkXLCc++Tkz9yYumdbid7+cNNw7IAXiaVlo6fd31
	 yFiskQIGXJQLQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/4] Bring the IP0 resource from ICC to clk-rpmh on QCS615
Date: Fri, 27 Jun 2025 21:37:54 +0200
Message-Id: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABLzXmgC/x3MTQqAIBBA4avErBNy6Ie6SoTINNZszDQiCO+et
 PwW772QOAonmKoXIt+S5PAFuq6Adus3VrIWAzbYNT0O6jqCkDop9bozQmQkWDXqUWPL7BwilDR
 EdvL823nJ+QPTEu9RZgAAAA==
X-Change-ID: 20250627-topic-qcs615_icc_ipa-919124eeff22
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-clk@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751053092; l=1143;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=Ei93rz/3bC4MEpPR5AqqOif6tnZ3n01iyhdfKf0JuA0=;
 b=9C80GFQSWwxi/L+hXS0gCqNXkFcTLk7U5mWvqULvO8DXIORXEVY0YsRtrgretQih52AKveX50
 xiOeTSexsP0BqO8PdXh2crlij2hJB5mFjIP0ZhUnyQHx4QFLb6ESHRS
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This is how it should have been right from the beginning, but it seems
like nobody took a good look at the initial submission.

This series is essentially the same as the previous [1] again.

Compile-tested only.

[1] https://lore.kernel.org/all/20230109002935.244320-1-dmitry.baryshkov@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (4):
      arm64: dts: qcom: qcs615: Drop IPA interconnects
      interconnect: qcom: qcs615: Drop IP0 interconnects
      dt-bindings: interconnect: qcom,qcs615-rpmh: Drop IPA interconnects
      clk: qcom: rpmh: Define RPMH_IPA_CLK on QCS615

 .../bindings/interconnect/qcom,qcs615-rpmh.yaml    |  2 --
 arch/arm64/boot/dts/qcom/qcs615.dtsi               |  6 ----
 drivers/clk/qcom/clk-rpmh.c                        |  1 +
 drivers/interconnect/qcom/qcs615.c                 | 42 ----------------------
 4 files changed, 1 insertion(+), 50 deletions(-)
---
base-commit: 2aeda9592360c200085898a258c4754bfe879921
change-id: 20250627-topic-qcs615_icc_ipa-919124eeff22

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


