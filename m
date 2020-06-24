Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995B9207263
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390652AbgFXLoU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 07:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389080AbgFXLoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 07:44:19 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ECCC061573
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 04:44:19 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id o15so1171457vsp.12
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 04:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16YY60PN6u62CsdqXTLtpXufTnOGYMQ6hrz0Z45FFTE=;
        b=qrkILIM/s15IymScgPDkRT1VNzSP3DtSXREEISXmBPELBhZGmSqntU6JBRWu3sHJV2
         fToYdChv2KKFGXEnrMeL89QCU6jJEtDxA0Gt7gZi/EnUZqjzEbnmxkZ0oZ0HbB0+JeHw
         WJ2FxT3ToAFsUdr0vBXqLoRihW0XMuGwLOO9Fc11lM6dL6BJJ+xeNRfpJsMokDdu990b
         0y0QtWK+mkLZIvYZ26xJhJlObd2NgjTOto02VWkKgel4YI6f87qhR5nSu7avR5ihmNN/
         73YFZspRgx0gdTYKjYwYIiC6wRRzPt0UDPy0+r2HrxjgM2OThCIvg8sWNqxr645btU2+
         0z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16YY60PN6u62CsdqXTLtpXufTnOGYMQ6hrz0Z45FFTE=;
        b=r06pNuSpf3UVFVp5nSOX+3wVWt3KkBFmPMS6alhVBAFsbgYYKs4qiscDfBfO+fN1Wz
         s0BzV0RnYECe14g2hJ0hoyQlujv3nAqDP+jo5TdmjzjPei27PH/SLCzkq8F1HMICNZmE
         XqyN+kj3D1Vnx6OAvIVazTHht0nrbOIQrkJq8em6lNOoeppfXnOT6QtIE60i8m7emEHj
         rK1Sc6ISRxi81UIqiU7/2W5ARrEe2105w+MVEX+sL+fxOPkd2vIG1ox9cmkgmEa4/6E/
         xOWpggUtjfFXuzcJtlN4ZGC+w7f4Wab66CODo/hj22tv0KV4ro0NLAX4pHYT0ZJDwcSY
         x4KA==
X-Gm-Message-State: AOAM530LtSuS8tmMrK8NXOEhwjQi3eM03dZNyODV8XXSRmazprXLHLMN
        oBxTkdGK1ZH6HnOD622ZLiZPuX851XxEKmsZVhdHdA==
X-Google-Smtp-Source: ABdhPJwSbBWkN2a607O0g2Tqflb4gBZwf9N00qj0wn7y+Nwy7jnGNQy5diTDA2kS6Fwm7lkEuJZI9MmVwAUK3tCIlRo=
X-Received: by 2002:a67:885:: with SMTP id 127mr23594427vsi.182.1592999058930;
 Wed, 24 Jun 2020 04:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200623180832.254163-1-konradybcio@gmail.com> <20200623180832.254163-4-konradybcio@gmail.com>
In-Reply-To: <20200623180832.254163-4-konradybcio@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 24 Jun 2020 17:14:08 +0530
Message-ID: <CAHLCerOAM5j+gZWP9MUuGZ+TQfBg4Z=GoEdUfxBTwtEs5TqUuw@mail.gmail.com>
Subject: Re: [PATCH 3/8] arm64: dts: qcom: sdm630: Add tsens node
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 23, 2020 at 11:39 PM Konrad Dybcio <konradybcio@gmail.com> wrote:
>
> Enable tsens on this SoC using tsens-v2 driver.
>
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.yaml       |  1 +
>  arch/arm64/boot/dts/qcom/sdm630.dtsi                  | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index d7be931b42d2..d89d5acd6e2a 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -39,6 +39,7 @@ properties:
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
>                - qcom,sc7180-tsens
> +              - qcom,sdm630-tsens
>                - qcom,sdm845-tsens
>            - const: qcom,tsens-v2
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index ea85f28032d2..92bf4ae6a590 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -566,6 +566,17 @@ anoc2_smmu: iommu@16c0000 {
>                                 <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> +               tsens: thermal-sensor@10ae000 {
> +                       compatible = "qcom,sdm630-tsens", "qcom,tsens-v2";
> +                       reg = <0x010ae000 0x1000>, /* TM */
> +                                 <0x010ad000 0x1000>; /* SROT */
> +                       #qcom,sensors = <12>;
> +                       interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +                                        <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "uplow", "critical";
> +                       #thermal-sensor-cells = <1>;
> +               };
> +

There should be 2 tsens controllers on this platform, the first at
0x010AA000, the other at 0x010AD000.

>                 tcsr_mutex_regs: syscon@1f40000 {
>                         compatible = "syscon";
>                         reg = <0x01f40000 0x20000>;
> --
> 2.27.0
>
