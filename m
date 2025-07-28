Return-Path: <linux-pm+bounces-31496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B316B13FB2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7323717D26B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B999D274670;
	Mon, 28 Jul 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSreTgP8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A912741DA;
	Mon, 28 Jul 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719380; cv=none; b=UfwWRzKMyjern/Igxk/hQ9s+cYUb4NE2NgzZ3KB8ZZ60qYJ+ICE/+KoM5B0dSsmgYZHVVMv4Vp6lZqcRhek94apGFojWxj521JIXQwJ7TAs4GydiOVf1xHZmqfx+PJLsrYjRGNixaXehb+KhrZ8a4/3vofzwTc/tny6RLG/nB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719380; c=relaxed/simple;
	bh=4dSevmpDXXvsWiL9Hu0X0i84/6KCVfmYhJp3n259wZQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cCe0eCnqJd+tw7Dr2zfFN8rgodCiJ7UdqzTiab7+8CTd39mEQEU2/Rj/E24P6U+vJhVgvFQcFTtmL42sbC959hYeeBf9BClb15WMvM9LQjQcwz65bzupXLWwNqecwrvkr2JcxNfZ43tt8/TGDUOLRbvbKINV/QDS7eGZQp8LONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSreTgP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74861C4CEF7;
	Mon, 28 Jul 2025 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719379;
	bh=4dSevmpDXXvsWiL9Hu0X0i84/6KCVfmYhJp3n259wZQ=;
	h=From:Subject:Date:To:Cc:From;
	b=rSreTgP8NNA967dpSRFLRfwASsfRsODU31GqHxbMjNpqPYkOlHak+8mVJfVhh9bzm
	 0YSxae/JaGfCmSjw5sHwaEps4TbbFNoK00Zr2vgkZ++RgR0sHuUsNl2EThlQ1Pif2k
	 HdXFhe0kv+WIJ4eOK9jQ+r8LbqEK0+zcmhzCDuNq86zeP1SWB1NnLmEpAm3KonZVYs
	 Mq+kqgYybka8MnhbTC9d4XorUkv0Wst0O4vQsBKLpbQPwlAyWG9PaBj7yt61qpSZDr
	 WePjvTltob83ofOrNELtTF8yI/TtTskw7oxJW+WPxwABxgFR7cicTCsn+Zc7k/NMq+
	 1le8AXePqQx1g==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [RFC PATCH 00/24] GPU_CC power requirements reality check
Date: Mon, 28 Jul 2025 18:16:00 +0200
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAECih2gC/x3MSwqDMBAA0KvIrA3oUD94FRHR6RgHNBmS2gri3
 Q1dvs27IHIQjtBlFwT+ShTvEso8A1onZ9nIOxmwwKposDUfr0LG6kE0qv9xGHU79lmcNfWrxqa
 amJBmSIEGXuT85/1w3w/5tG9+bAAAAA==
X-Change-ID: 20250728-topic-gpucc_power_plumbing-646275aec2cb
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719370; l=4105;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=4dSevmpDXXvsWiL9Hu0X0i84/6KCVfmYhJp3n259wZQ=;
 b=9MujO0KNKtHf3X06AAVxcysRg6EhZzCdHVgRpeDP6tnzLTTG9Rq+qyFx1uNZ6/b4wj6gDigtY
 0or/aFG+gmhB71N1BiXNMxS9G1RpowjsggA5ENpMYVROuitsUp1Gxph
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

In an effort parallel to [1], the GPU clock controller requires more
than 0/1 power domains to function properly.
Describe these dependencies to ensure the hardware can always power on
safely.

Patches 1 & 2 are separate (but related) fixes,  which need to be
merged before the DT change for SC8280XP.

Posting as RFC since I only got to test it on SC8280XP(-crd).

[1] https://lore.kernel.org/all/20250530-videocc-pll-multi-pd-voting-v5-0-02303b3a582d@quicinc.com/

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (24):
      dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
      pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
      dt-bindings: clock: qcom,gpucc: Merge in sm8450-gpucc.yaml
      dt-bindings: clock: qcom,gpucc: Describe actual power domain plumbing
      dt-bindings: clock: qcom,gpucc: Sort out SA8540P constraints
      arm64: dts: qcom: qcs8300: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sa8540p: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sa8775p: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sar2130p: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sc7180: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sc7280: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sc8180x: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sc8280xp: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sdm670: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sdm845: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sm4450: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sm6350: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sm8150: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sm8250: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sm8350: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sm8450: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sm8550: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: sm8650: Describe GPU_CC power plumbing requirements
      arm64: dts: qcom: x1e80100: Describe GPU_CC power plumbing requirements

 .../devicetree/bindings/clock/qcom,gpucc.yaml      | 155 ++++++++++++++++++---
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |  75 ----------
 arch/arm64/boot/dts/qcom/qcs8300.dtsi              |   6 +
 arch/arm64/boot/dts/qcom/sa8155p.dtsi              |   6 +
 arch/arm64/boot/dts/qcom/sa8540p.dtsi              |   6 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              |   5 +
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             |   5 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   5 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   5 +
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |   5 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   6 +-
 arch/arm64/boot/dts/qcom/sdm670.dtsi               |   4 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   4 +
 arch/arm64/boot/dts/qcom/sm4450.dtsi               |   4 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |   4 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   4 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   5 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   6 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |   6 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |   6 +
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |   5 +
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             |   6 +
 drivers/pmdomain/qcom/rpmhpd.c                     |   4 +
 include/dt-bindings/power/qcom-rpmpd.h             |   1 +
 24 files changed, 240 insertions(+), 98 deletions(-)
---
base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
change-id: 20250728-topic-gpucc_power_plumbing-646275aec2cb

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


