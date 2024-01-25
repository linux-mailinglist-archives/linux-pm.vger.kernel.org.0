Return-Path: <linux-pm+bounces-2782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31DF83CF5D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 23:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6F31C23C7F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 22:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D944813B7A7;
	Thu, 25 Jan 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTFidCax"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11F13B7B3
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221793; cv=none; b=AITyVxEp5E/FI5StsFhJx4JQ/wsFkjeYMnqWrw7uQDmBQtAgo2xX41+ZL4gaSFhXHH8APS1FTJJKstZJKlcFb99vH/bf8qegx30zNiSBFxbha0BE2kUHr5UdbC1qPBdgOIMaua12uLnbJkSDUUzHoRz3g8mLa+BDeDNBeJprKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221793; c=relaxed/simple;
	bh=pdmqitTeaF84l4GLBECsFls/XdMw2AE1xh/qLajhugI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sia844IyaICLOLhRjsUf5u5IM+3OAyFKt9ORQLqmHYrF8npkeblcMXTQd/euVBJqR7R9w+fs291ak1+vahm1qJZqkrPB9q+tGhQUx015XLg7al0x81R1oeN+vzP52ldrVlToMQUhnNJ13J4uEarDAzAZEL0V39B4dgj1su7Xw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTFidCax; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc22ae44595so6849164276.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 14:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706221791; x=1706826591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qj1aarYcNCRPMpfcILtapIIFfoDQsiP4fM6MW/nqV0=;
        b=eTFidCaxsOw3f3pz74qAqEMl3M5gbAgocD6v2alejncgRQTq+gXP7C/vfJsyQDhQcz
         VOw1GiSIOUSaEuZ3WTYfOIyCuNeKnEPyMkCQBsGk37WUCS89KWQFEwR1+h6Y0vI/1TG3
         YcBBxYRca1SQAy9KxFafty2au49wZi9XpgMKZzQ0OaedagalbQ3KbBY0ccwY+RagfAo0
         UMFWS0ZZ71TR3UmJYqgs4X4fASpPNPCnxjtBcF+MXJDNBpuOn3fMzJ4HY7ZijHhwAayz
         a2Ax7LpiZSCfgivTJaITOY1taRRLwG1ADiPH5P8BJPt3rvWy/Srm0+TNwmJdr4UjxaSv
         55aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706221791; x=1706826591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qj1aarYcNCRPMpfcILtapIIFfoDQsiP4fM6MW/nqV0=;
        b=YvVkHIskwvbst4bfc9z+vfSx/+stdacjgME+egrrA2xaopS1x2QUZB3yMgwXcKO8lu
         B8oSq2LHBZ4ZD4cukCVE6bxstZNm4eAC4D+vYtppeK0rwyx2t1PLsXb6b6/N+NwKyWSm
         8H/vnueFHxsxpNWgG2D3K2vH5M4+CPbLfGmgBgBqtvm4c0QbTHgt+uARj8yaUFZyt1u5
         loZz4TtKhvIMqWqhCkVNAqGv7WA6FLDAWIbyboy5PPD2jJ6UYzI7NOAr2/ZGwkZioadq
         wmVMGZRkL+m062LCgToAzCqxhEq3zVUZpMVyaYJSGQjJ+H95FcxfSN7+8e+4S9sVfbH8
         1ENQ==
X-Gm-Message-State: AOJu0YzuNQAZn5eS5c+UqpX5gkwaUSbEu8UkqxWyaF/mvIHNAlDuHhVb
	o8BOdBDXmgglsrUujL47eNMktz/cNjGucq8I8Ve+jQOJPmTrGpL+KzIMvkYIaaFVPeKtfDTyTjq
	+eExqaI+xSFwjxPJ9wxX9p+dzF37TMltt9XPI0w==
X-Google-Smtp-Source: AGHT+IEIrXiJz/BJm8XfspLPa6VXYTY6QIWf67Zf9KppnCLv1hYViKn5F1vUW8HIv7famATu3qJ7JAubWNKmRV2MlZo=
X-Received: by 2002:a25:ab34:0:b0:dc2:1fa9:5329 with SMTP id
 u49-20020a25ab34000000b00dc21fa95329mr496445ybi.29.1706221791148; Thu, 25 Jan
 2024 14:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com> <20240125-sa8295p-gpu-v4-6-7011c2a63037@quicinc.com>
In-Reply-To: <20240125-sa8295p-gpu-v4-6-7011c2a63037@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 26 Jan 2024 00:29:40 +0200
Message-ID: <CAA8EJprR74VGm4djFdZvVA8xtqHvbFypwacmxqcMZhOLUo6XSQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: qcom: sa8295p-adp: add max20411
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 23:06, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> From: Bjorn Andersson <andersson@kernel.org>
>
> The SA8295P ADP has a MAX20411 LDO regulator on I2C 12, supplying the
> VDD_GFX pads. Enable the bus and add the maxim,max20411 device on the
> bus.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This doesn't match the From header.

> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 39 ++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index fd253942e5e5..bd0962f39fc5 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -266,6 +266,26 @@ &dispcc1 {
>         status = "okay";
>  };
>
> +&i2c12 {
> +       pinctrl-0 = <&qup1_i2c4_state>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +
> +       vdd_gfx: regulator@39 {
> +               compatible = "maxim,max20411";
> +               reg = <0x39>;
> +
> +               regulator-min-microvolt = <800000>;
> +               regulator-max-microvolt = <800000>;
> +
> +               enable-gpios = <&pmm8540a_gpios 2 GPIO_ACTIVE_HIGH>;
> +
> +               pinctrl-0 = <&max20411_en>;
> +               pinctrl-names = "default";
> +       };
> +};
> +
>  &mdss0 {
>         status = "okay";
>  };
> @@ -476,6 +496,10 @@ &pcie4_phy {
>         status = "okay";
>  };
>
> +&qup1 {
> +       status = "okay";
> +};
> +
>  &qup2 {
>         status = "okay";
>  };
> @@ -636,6 +660,14 @@ &xo_board_clk {
>
>  /* PINCTRL */
>
> +&pmm8540a_gpios {
> +       max20411_en: max20411-en-state {
> +               pins = "gpio2";
> +               function = "normal";
> +               output-enable;
> +       };
> +};
> +
>  &tlmm {
>         pcie2a_default: pcie2a-default-state {
>                 clkreq-n-pins {
> @@ -728,4 +760,11 @@ wake-n-pins {
>                         bias-pull-up;
>                 };
>         };
> +
> +       qup1_i2c4_state: qup1-i2c4-state {
> +               pins = "gpio0", "gpio1";
> +               function = "qup12";
> +               drive-strength = <2>;
> +               bias-pull-up;
> +       };
>  };
>
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

