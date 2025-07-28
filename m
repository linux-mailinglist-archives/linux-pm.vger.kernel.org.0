Return-Path: <linux-pm+bounces-31521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF6B14101
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 19:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC381189C42A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA643275873;
	Mon, 28 Jul 2025 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxAHBuzj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4D19066D
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722667; cv=none; b=QXrPmPeqN7SsA0xjZG4aVWWzBboq68UpCEMQuKKVm3pBJxufg9GYNeq1mBIp0w1qZbvXrDXLeQ+ecCZvA19MXHUcGld95ss36nSC0F8ildOtV1zte6YMnFADoRZlKg8g4FLgUCVf+zZFSJ6SBT8zH+syOVgOCZaJcSl7N5tTonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722667; c=relaxed/simple;
	bh=bKx7T1DLQcbdvNXKkdxjhh9o20FMdCO0YBI0USo5qRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mO9Qsk1kJCaXXxR7ToKtecfHFxt0PRV6Z+rI8EayxWmIKpHPF7xQdF+FQ/hTTei85zi5tHSi30SooVQ6tTBRA4A/o7RI2l24gE10NqMbLmZydYTEVPNGUxn0P7UjTGbp+UTSEQAtCV+61y+oyCJl3FCZ650Arr6qduNROH/v330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxAHBuzj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so948138466b.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753722664; x=1754327464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QR1arBx0XvaSp1oUXc3PyontAThuSk/8jS2zweGYDNE=;
        b=WxAHBuzj/5k9vPu0wCo7mPeSQvYKrJIm7erozXLuNjSfF4PmjuO+72WfufvbcrFhiI
         JfUCB+W8t0wtkf9OogyKUFcHiAMjTQlMAgG7sjW0DriH87kFpSC1Giv+5D+nB48ql+9+
         LdIc308cu3Sp7e28RA/kHTbHNOOXRRa/p6FIwlcFsTAqRg+4YHrfI2k6jMa7Yx/yZsPZ
         wmq351hrSbbf5sx7Ew3qor4YTG22RbC+GMvcKNkh1AOIj7xlED5HOJRQee9lNswW2Lhq
         fU3NaIbo3ZTejCgXB5oEn0Y8FTu4ImiZYjd7PnGzZ8bxvIF5URNuYTu5HrIIGStV9bQ7
         ywmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753722664; x=1754327464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR1arBx0XvaSp1oUXc3PyontAThuSk/8jS2zweGYDNE=;
        b=aFu/aDTR5pFvLjZq0bAIVsLXkT3eS6tzCyBNsXwGG0/mtxb+QPyq55aVNSo2c3Jxr6
         5TOrKrkH/Lm16tMUA+tt9pXbzYiUFM8C9am7RIDT0W4/+JJJrJ1ChU7wFkcVfkdjiQ9X
         0w5O3gODyzTThM1etnmFvDM+jtoJ3h7K2EnrneYgW8OUQXuxEWm2RY+Db/YH66fxH+Lx
         YYWmJI5JJPmkWVbJCDmgn8vhXjqarnuM7gtXs2bJXl3omo/w/2qU7edTRKWCxkOMtyO0
         Iwzz0fiX7m80OZrTtR8q1XW/exM58NQBs3HMf5NV20LX+q7QPxDlQ160kBR/aK7fqSQy
         Rl+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWJaB2qyKPici0PY7otbEGV7UxgCw+4dhOEiojqTwy9wWJLQbj17i942NT9+PwZSJZkbqNfyfrNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJkeYCBRR7DDNT+riovGnFyXIrFmJTMbm7fAmS/Obr527apI1
	2tvM9k8Nqh7jjrvicOSswq43RNvL1YMck2mGWm1XQs4JFktglXMdHGx8ls/5oAIU5yw=
X-Gm-Gg: ASbGncvR3k+OWdgjbF5Y1vudHdma7NGe/bb/fNUOBVndEg9tG8Y8QUgDyNN653MV9zU
	LNzey+XiXVxS3vwTKNWiXp2dAhSI0795xi80s7fzw/qUQoTKT87LnMuhme+j27q2bMIGkMhD5h6
	OE5qZYp20LsY8Zzctn23V8bjFUpHryi9VoTmHplkXXLB8aBK+i87FftgHZALnwYzNEgQigL4/+z
	JIpIOTw4JjrnKgEZrldfqpEqwCGxGPJDy8+S+RqpylIwRLYkaFLYHIthKTaXcIIu9p5p3PP9wQU
	mp0X9UUeVHmNQDJgco/dFE+knebRRVQEve8L5VqR+O0+EROk4VptvCbLRSrp1vXHqy5NZTLHHn+
	70cx4soarBVuWm9p/gjBxN8hEvzwSbMqBNw==
X-Google-Smtp-Source: AGHT+IFd/ukbJWEyAyiMoVr3cixjoIXsXy8y7hQtFjRtY748SHCa7Gi1Pqlg3oMU0d8uaJRO6rYQqw==
X-Received: by 2002:a17:907:1ca3:b0:ad4:d00f:b4ca with SMTP id a640c23a62f3a-af619a0795cmr1251448066b.50.1753722663537;
        Mon, 28 Jul 2025 10:11:03 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:e460:c4f3:f28e:97ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585ff5asm452983566b.11.2025.07.28.10.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 10:11:03 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:10:58 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Douglas Anderson <dianders@chromium.org>,
	Vinod Koul <vkoul@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Andy Gross <andy.gross@linaro.org>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC 24/24] arm64: dts: qcom: x1e80100: Describe GPU_CC
 power plumbing requirements
Message-ID: <aIevIuMDA5R8igmi@linaro.org>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-24-09c2480fe3e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-24-09c2480fe3e6@oss.qualcomm.com>

On Mon, Jul 28, 2025 at 06:16:24PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> A number of power rails must be powered on in order for GPU_CC to
> function. Ensure that's conveyed to the OS.
> 
> Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..6620517fbb0f3ed715c4901ec53dcbc6235be88f 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3928,6 +3928,12 @@ gpucc: clock-controller@3d90000 {
>  			clocks = <&bi_tcxo_div2>,
>  				 <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
>  				 <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
> +
> +			power-domains = <&rpmhpd RPMHPD_CX>,
> +					<&rpmhpd RPMHPD_MX>,
> +					<&rpmhpd RPMHPD_GFX>,
> +					<&rpmhpd RPMHPD_GMXC>;
> +
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> 

To repeat your own message from a couple of months back [1]:

> You shouldn't be messing with VDD_GFX on platforms with a GMU.
>
> Parts of the clock controller are backed by one of the MX rails,
> with some logic depending on CX/GFX, but handling of the latter is
> fully deferred to the GMU firmware.
>
> Konrad

Please describe somewhere in the cover letter or the individual patches
how this relates to the responsibilities of the GMU. I searched for
"GMU" in the patch series and couldn't find any note about this.

Also: How much is a plain "power on" votes (without a corresponding
"required-opps") really worth nowadays? An arbitrary low voltage level
on those rails won't be sufficient to make the GPU_CC actually
"function". Do you need "required-opps" here? In the videocc/camcc case
we have those.

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/2dae7d88-4b3e-452f-9555-05f10b42dabc@oss.qualcomm.com/

