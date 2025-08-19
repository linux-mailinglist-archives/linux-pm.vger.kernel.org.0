Return-Path: <linux-pm+bounces-32634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C66B2C3AD
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 14:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18859581D94
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D2B2C11FC;
	Tue, 19 Aug 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLwnu4UB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0382C11EA
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606467; cv=none; b=VNwKByQ+MnMpMeeABSm2EAR5MWMDjXDVy0ciSVw4vsK/+yOyoh+biKQiGDW3p4qaYaQ1V25FS0fU9qyyCeQPUimZLSyvODiL/2FpVOotjXr4Ii+FNHjndM4DrkdGpD9yliY3OJ00R9N3CvypHFysOi62Y7qe+5q3zitJHFkz+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606467; c=relaxed/simple;
	bh=Nv1pjUoOXSZoynilhAmAiRkhImajQkD3cwyCqkQSFdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzhQwiAHv4LDo39MT8DnxxCUpbaXBFZo5EcEKxqtCHq+TqHKUATjtM9XPymR2RbXjigX+QnynZhipH7H53msaXcbYEQUb6j2WNzubOZh1lUrGIdgamfKAw0VEDQBrxamAbhO0LFuAQAlBtVpoVjifM6XxTxXKhK5u9twdWriAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLwnu4UB; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e934c8f9757so2230406276.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606464; x=1756211264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TQJ9/fQYlFZB7BHFOxhE5rqON71LQpmFE+5hRcesI34=;
        b=XLwnu4UB/tjlTYDfWQlmTs5F64e8gESNq+mtrDvQ+/6D3AoAunnxWkOh5tnSBkHbyH
         +polz83DIAOnhlT8dduYky8acG83SSPNGzopy1SGBjqSzcPt9sDpYAHEjqsj1pXrFOC3
         GT67M11579NCcx7q328g0NZNQNEAzVj27xYmOtSwfbVlU6CnbBHyebP0lgBLV27Civv7
         Lkg5+dLhPP6s6k52KCZ6RbtozRp1BideOEClV158dVScJrR1ScFBfJJmcHFf/IpS3CYN
         xkIhjc51yoAVfORcsAbblZQCX23om4f48f+Fpw6O7xVPdK6/aguRBIXoLTCt+PK9ZUdu
         1IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606464; x=1756211264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQJ9/fQYlFZB7BHFOxhE5rqON71LQpmFE+5hRcesI34=;
        b=RIssRph/9sBekqueIBCRG3LYg+xLJSWwCV0kfhMEdDMT0I1Wm89CQjeLjXAeLFHicy
         eZO2OwqVaDylZDqMUXcA2VddVufitrTXf+viDrGLFv1pzY6In0RITHp4HWV6ZtaTpmoO
         bBWmIeV2+Z9AZYxKoiDmaZbUTjRRWq8MZBGSao8BhSvPSW7H6D4IaXrRIeZukPx0imOL
         kRGMfjfRwUCA7nUx7vF9jHX+ZY82KnZpo9jGyWZQFCaRxVGXBnXICkmRxBuI5KX0M9WW
         MWMrBkfwJsi0u5ZmZK/3ndXXJzj9LrkX5K7rnkgj81vj1iPaWSFvRa12QJ8OnlaZNV/U
         5gBg==
X-Forwarded-Encrypted: i=1; AJvYcCVayLozOd4j+bjGf4gI6KLKIG9/3v1FPZOoUXDUX4Zok6eVS3rSaVw7bFzz3+vWPqBifk9QSp9tMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh0o8yvKoey5Uz+B/vc6bInAPaigPbCzOc3R9iBlitvFbDeAOH
	wwHLv/rAPMu2V6ObJDOwMHa7iUcgvVO2HmMzg5x4vTj+fvDles9IDW82gTJyco/3lG/TPRbuNyS
	i4EN8YbmoMa06p2/L+8GFGdH2MGfAe0BgodepR1sf6A==
X-Gm-Gg: ASbGnctKkRHkJjIOG9CNItRUuke0sZDSlVkMvC1T9JX010BaVG5oooc0yOzKBwVo1OJ
	5nj9taOiixXv/2LEIPJmpCxZ9JJQ4xhvSo8hGRSxhHWYF+RTNvfOJD3uGEJVMd9kNGv6MjwCLNc
	8Mbc88vkOedFWlNGgZnXQA4hL4/XaSzqAoeTIK5L6WqPH6wV39Sj2IkWZ+1x0zrXzjrXCBpXSrc
	9eng1GTewAk/sB5Vw==
X-Google-Smtp-Source: AGHT+IFRBAMqbjVrBOTdcqCFqxd0nH4dT+3B6E2uJUNFB6x6KANXkZyugb9RUsQkwMq/iR7D246ApID8/zxfeOWdOJ0=
X-Received: by 2002:a05:690c:688c:b0:71a:1234:3529 with SMTP id
 00721157ae682-71f9d532028mr22641667b3.21.1755606463949; Tue, 19 Aug 2025
 05:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 19 Aug 2025 14:27:08 +0200
X-Gm-Features: Ac12FXwryiFxmL3QF8klQ7lK3nu4VpQFZS0iCSqAffd276Bc50rHoj93F3N9QSM
Message-ID: <CAPDyKFqOBJxnNWWQvrFLy=w2FWb9bh0EvQ4_3d3zRBaDMWF03w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/24] GPU_CC power requirements reality check
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Douglas Anderson <dianders@chromium.org>, 
	Vinod Koul <vkoul@kernel.org>, Richard Acayan <mailingradian@gmail.com>, 
	Andy Gross <andy.gross@linaro.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Luca Weiss <luca.weiss@fairphone.com>, Jonathan Marek <jonathan@marek.ca>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Akhil P Oommen <akhilpo@oss.qualcomm.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 18:16, Konrad Dybcio <konradybcio@kernel.org> wrote:
>
> In an effort parallel to [1], the GPU clock controller requires more
> than 0/1 power domains to function properly.
> Describe these dependencies to ensure the hardware can always power on
> safely.
>
> Patches 1 & 2 are separate (but related) fixes,  which need to be
> merged before the DT change for SC8280XP.
>
> Posting as RFC since I only got to test it on SC8280XP(-crd).
>
> [1] https://lore.kernel.org/all/20250530-videocc-pll-multi-pd-voting-v5-0-02303b3a582d@quicinc.com/
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This doesn't apply, as I have just queued up a series from Dmitry [1]
that requires this to be re-based on top of my next branch. Please
submit a new version.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com/


> ---
> Konrad Dybcio (24):
>       dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
>       pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
>       dt-bindings: clock: qcom,gpucc: Merge in sm8450-gpucc.yaml
>       dt-bindings: clock: qcom,gpucc: Describe actual power domain plumbing
>       dt-bindings: clock: qcom,gpucc: Sort out SA8540P constraints
>       arm64: dts: qcom: qcs8300: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sa8540p: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sa8775p: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sar2130p: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sc7180: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sc7280: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sc8180x: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sc8280xp: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sdm670: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sdm845: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sm4450: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sm6350: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sm8150: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sm8250: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sm8350: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sm8450: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sm8550: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: sm8650: Describe GPU_CC power plumbing requirements
>       arm64: dts: qcom: x1e80100: Describe GPU_CC power plumbing requirements
>
>  .../devicetree/bindings/clock/qcom,gpucc.yaml      | 155 ++++++++++++++++++---
>  .../bindings/clock/qcom,sm8450-gpucc.yaml          |  75 ----------
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi              |   6 +
>  arch/arm64/boot/dts/qcom/sa8155p.dtsi              |   6 +
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi              |   6 +-
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi              |   5 +
>  arch/arm64/boot/dts/qcom/sar2130p.dtsi             |   5 +
>  arch/arm64/boot/dts/qcom/sc7180.dtsi               |   5 +
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |   5 +
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi              |   5 +
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   6 +-
>  arch/arm64/boot/dts/qcom/sdm670.dtsi               |   4 +
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |   4 +
>  arch/arm64/boot/dts/qcom/sm4450.dtsi               |   4 +
>  arch/arm64/boot/dts/qcom/sm6350.dtsi               |   4 +
>  arch/arm64/boot/dts/qcom/sm8150.dtsi               |   4 +
>  arch/arm64/boot/dts/qcom/sm8250.dtsi               |   5 +
>  arch/arm64/boot/dts/qcom/sm8350.dtsi               |   6 +
>  arch/arm64/boot/dts/qcom/sm8450.dtsi               |   6 +
>  arch/arm64/boot/dts/qcom/sm8550.dtsi               |   6 +
>  arch/arm64/boot/dts/qcom/sm8650.dtsi               |   5 +
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi             |   6 +
>  drivers/pmdomain/qcom/rpmhpd.c                     |   4 +
>  include/dt-bindings/power/qcom-rpmpd.h             |   1 +
>  24 files changed, 240 insertions(+), 98 deletions(-)
> ---
> base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
> change-id: 20250728-topic-gpucc_power_plumbing-646275aec2cb
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>

