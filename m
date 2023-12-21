Return-Path: <linux-pm+bounces-1472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24EF81AF1E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 08:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8168A1F23561
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 07:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6FBA38;
	Thu, 21 Dec 2023 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PY7vT8jZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60361C143
	for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5cd81e76164so5460447b3.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2023 23:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703142483; x=1703747283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x3mqWSg4PAag/N8HBMk+GPM7NiqUuxDSinfcR+EyoZg=;
        b=PY7vT8jZP3nkYNsSaZr+1CtHZHTrAPvNAr8kHQKXpZLxFWykaWFxaCKscuXveJmzMV
         KpziNfR0yUSvW7CK4Z2r/y36JDiiWVIrs55BRK6Q+3ezQBM/LOb50mU0PGkbqm7jTS6p
         7MYG1KI+jb7bKv/0IMCKD8Kid2pzBMK4EzrlSAmrX0HyAK2RRHGFYvBRoZCNSLI3cQsI
         fx0gpJ0/5u2hAr4IxGWS2/AiSGUaWB22RGtztsYZvnObgc41o0C3XR9ra9ydKdkgGCg8
         5Fo9TrSVp8DCE6M4IXAzsFMNX6wbZM9C/aezuMy+ilIad444lFzy/x9f19spYMmz+6ly
         hiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703142483; x=1703747283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3mqWSg4PAag/N8HBMk+GPM7NiqUuxDSinfcR+EyoZg=;
        b=Kw1wEYl4eC8Y3jxkS6/5rkLuXFbWhMieVpWPUO+YhgOWNB2QdOZtE7sx8b6yno8Qj/
         0GPzpBlD7W4RlDb3635wo/32GqZq2PEADQ92SSOWcxSbYQDG2vUv/u5OE19E63cVnhpn
         mo9/SPsrV8nxNZJbXSkUDKazcA28lFpYTXVMVxxkPPU1ZoQNrfIKfS41qL5lEaUl6BWD
         34VL9OdFniG/vCuCUgV+WLwQ/vYNnksmdTDG8QP/DV5xpnqvKMyuXs3jwt/i7+OxBDUh
         +tRRegk+2oF/RkbYDltLVxchJiQG68A8ymysRYlPrezmuMWJXRN+QPsK9/XmacMnrZTS
         aSoA==
X-Gm-Message-State: AOJu0YxPYuYYFT74F48pMxh8xi5WlSejwIOkLQm0su3c3d3ucAlx82Ua
	04C1pf9cWh99b6egPDCJ976TZ9JE7dQHJz8KtwOH5g==
X-Google-Smtp-Source: AGHT+IEy0v0j3VMzWFJEqCyweVJbc+4811KR4XpQHk1zdeDXZP1XX8jNHrM0RyvmA9HQo1q0RhUDGFVGgq/WrXEKAH4=
X-Received: by 2002:a81:9215:0:b0:5d7:1940:dd71 with SMTP id
 j21-20020a819215000000b005d71940dd71mr851157ywg.71.1703142483496; Wed, 20 Dec
 2023 23:08:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com> <20231220-sa8295p-gpu-v1-6-d8cdf2257f97@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v1-6-d8cdf2257f97@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 09:07:52 +0200
Message-ID: <CAA8EJprUobs=EJWTMK5=U-=5rU_L0RWRgjFjBZZX1mQWMiW4_w@mail.gmail.com>
Subject: Re: [PATCH 6/8] arm64: dts: qcom: sa8295p-adp: add max20411
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 05:52, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> From: Bjorn Andersson <andersson@kernel.org>
>
> The SA8295P ADP has a MAX20411 LDO regulator on I2C 12, supplying the
> VDD_GFX pads. Enable the bus and add the maxim,max20411 device on the
> bus.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 40 ++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index fd253942e5e5..e16406c9c19d 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -266,6 +266,26 @@ &dispcc1 {
>         status = "okay";
>  };
>
> +&i2c12 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&qup1_i2c4_state>;
> +
> +       status = "okay";
> +
> +       vdd_gfx: regulator@39 {
> +               compatible = "maxim,max20411";
> +               reg = <0x39>;
> +
> +               regulator-min-microvolt = <800000>;
> +               regulator-max-microvolt = <968750>;
> +
> +               enable-gpios = <&pmm8540a_gpios 2 GPIO_ACTIVE_HIGH>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&max20411_en>;
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
> @@ -728,4 +752,20 @@ wake-n-pins {
>                         bias-pull-up;
>                 };
>         };
> +
> +       qup1_i2c4_state: qup1-i2c4-state {
> +               pins = "gpio0", "gpio1";
> +               function = "qup12";
> +
> +               drive-strength = <2>;
> +               bias-pull-up;
> +       };
> +};
> +
> +&pmm8540a_gpios {

I think pmm8540a_gpios comes before tlmm in the dictionary order.
Other than that LGTM

> +       max20411_en: max20411-en-state {
> +               pins = "gpio2";
> +               function = "normal";
> +               output-enable;
> +       };
>  };



-- 
With best wishes
Dmitry

