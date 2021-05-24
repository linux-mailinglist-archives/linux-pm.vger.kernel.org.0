Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73438F1F0
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhEXRFF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 13:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhEXRFD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 13:05:03 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A4C06138A
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 10:03:35 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id f11so14604686vst.0
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrqSOYj5g/obDVKIYAxmyXoOnQCVk6QwshkTvwsi7m4=;
        b=XyizKqOVbO1O1kqzeiPXF8NjsBV2U9Z+KYkApDRPMhoQY9Wd7aF4XJyesh+GK1YVA5
         Ub6EukTa0vgpcTPIyPKsHpKh8SRsQbQFCcP+++VNYz1YXYz2lXhoZ9bBghOFurhlwHUk
         ntb6/JFWmPTTq0gQYS4pNRcJkazgXeDtfbxp9tzTP5JJPQigo4i7WjDXP7dQV6MLvvtw
         Qq5CbguJpgjiczI1re747pjjYIB5h37C9+mXIwbmORKayNQgqiFyUkiDzDaCY3IBenHt
         FoTmh0hk4Y2MQQcmxH9KYKLxjMIIAayyNq0B4tqy1nc2mlsNk7avsezzUrjOaV2gKEQJ
         ohfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrqSOYj5g/obDVKIYAxmyXoOnQCVk6QwshkTvwsi7m4=;
        b=hfTBL78kLViKWUqLErvgG64DVYemiuI5fxJ+hrkp9IcqYagmkwu4OFsXWIHXbp2OEA
         cvhoSk4h06EODeZMcUYSGQ2dq8ZThq4c7EWUgZYK2HHQdJlhkh6JIme7d2uEDotpKc9P
         BLYyX0ziDjdNovCA+xYGQWbwxDtu8qScPrrwlnT4QYgrh+zBigZlOWDjVYRlRLqxELKk
         Wq70GBKrzepBoiWVVHVZoEf6S/fvPePtRewGrXGN08xVbqc9z652kkBkthAbhV60dwTz
         LGOaa8Rz+RCnqeaKxeXfjmPGKI0/4kmuYqEARAPrGCu5dEFN6sGeX1gTZAHdmN+MzO0Q
         NXPg==
X-Gm-Message-State: AOAM532A6qtFH2TcYxkKpLvWcqX9i8nY4rGOdaGut0okM8lbfJYInAIR
        5mUfx8BvytYA7Ic7gzetsUD8V7AfdzMzUePriBcSpg==
X-Google-Smtp-Source: ABdhPJwH7kYxWSa0u/62FyAK1s59dR0TfrwpFa2o7rML8WoewkAZu/jGtDNEsxL3yqDKybD0PBSBisVCRwo/3Ef5YLg=
X-Received: by 2002:a05:6102:7b4:: with SMTP id x20mr23350062vsg.48.1621875814897;
 Mon, 24 May 2021 10:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210523231335.8238-1-digetx@gmail.com> <20210523231335.8238-13-digetx@gmail.com>
In-Reply-To: <20210523231335.8238-13-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 19:02:58 +0200
Message-ID: <CAPDyKFqp1TN1JUa9R3c2VZ3tyD+FRVhYEVc1rw76Uq5r8n9dWw@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] dt-bindings: soc: tegra-pmc: Document core power domain
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 24 May 2021 at 01:13, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> All NVIDIA Tegra SoCs have a core power domain where majority of hardware
> blocks reside. Document the new core power domain properties.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  .../arm/tegra/nvidia,tegra20-pmc.yaml         | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> index 43fd2f8927d0..0afec83cc723 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> @@ -301,6 +301,33 @@ patternProperties:
>
>      additionalProperties: false
>
> +  core-domain:
> +    type: object
> +    description: |
> +      The vast majority of hardware blocks of Tegra SoC belong to a
> +      Core power domain, which has a dedicated voltage rail that powers
> +      the blocks.
> +
> +    properties:
> +      operating-points-v2:
> +        description:
> +          Should contain level, voltages and opp-supported-hw property.
> +          The supported-hw is a bitfield indicating SoC speedo or process
> +          ID mask.
> +
> +      "#power-domain-cells":
> +        const: 0
> +
> +    required:
> +      - operating-points-v2
> +      - "#power-domain-cells"
> +
> +    additionalProperties: false
> +
> +  core-supply:
> +    description:
> +      Phandle to voltage regulator connected to the SoC Core power rail.
> +
>  required:
>    - compatible
>    - reg
> @@ -325,6 +352,7 @@ examples:
>      tegra_pmc: pmc@7000e400 {
>                compatible = "nvidia,tegra210-pmc";
>                reg = <0x7000e400 0x400>;
> +              core-supply = <&regulator>;
>                clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
>                clock-names = "pclk", "clk32k_in";
>                #clock-cells = <1>;
> @@ -338,17 +366,24 @@ examples:
>                nvidia,core-power-req-active-high;
>                nvidia,sys-clock-req-active-high;
>
> +              pd_core: core-domain {
> +                      operating-points-v2 = <&core_opp_table>;
> +                      #power-domain-cells = <0>;
> +              };
> +
>                powergates {
>                      pd_audio: aud {
>                              clocks = <&tegra_car TEGRA210_CLK_APE>,
>                                       <&tegra_car TEGRA210_CLK_APB2APE>;
>                              resets = <&tegra_car 198>;
> +                            power-domains = <&pd_core>;
>                              #power-domain-cells = <0>;
>                      };
>
>                      pd_xusbss: xusba {
>                              clocks = <&tegra_car TEGRA210_CLK_XUSB_SS>;
>                              resets = <&tegra_car TEGRA210_CLK_XUSB_SS>;
> +                            power-domains = <&pd_core>;
>                              #power-domain-cells = <0>;
>                      };
>                };
> --
> 2.30.2
>
