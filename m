Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBDF646B3B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 09:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLHI7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 03:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLHI7b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 03:59:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750DD48743
        for <linux-pm@vger.kernel.org>; Thu,  8 Dec 2022 00:59:30 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b13so1050281lfo.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2022 00:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tydSjWpRvASEylrj7lgLwaBMTJwOnmS8BCH73tzadaI=;
        b=Zl46YC9PXbJa4rPKgDfkUEVbAm3F2rHn9Tx7G9B7riEQ8IKFz0vBBD9+ZbwX3eY8VQ
         z/cBDve1xXeuXR91tDVVecjVZsnhxs7Qq/tWJdMdwwgDz6gHvURIqRP14MTst3+Le/Ey
         iwoFGxxrkA5tF3lvavhQWnKpneuBlhKhY2F9Z1QKZxQFwNcofGXGE69wO8owSGTqcdnV
         7jjqFdvPckkUehotlwG7r/diYDP+BH8XywBE4gcJhHgvtbZt3vw4n3571FCgfY0sxOgx
         tkbHfNYcmsdBSJ/j4akFW9O+AnU0zSkmum9SZ5JAaAhocyFdLaV6WEWb3BGGEsjKc7+p
         ULaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tydSjWpRvASEylrj7lgLwaBMTJwOnmS8BCH73tzadaI=;
        b=bZjXw02kdfDd3U6+7IT512fL+bAO57qTay0dME28JL/UUh9fqJTlq3hCmXY2gVBova
         5zvtUQIlLpj9bApliJyXvBFG19EaRZIuG56NxlJdUqmB+d5J233ExQyl6SNL/czhtRmQ
         vTvq5ESOLqRZFlMf4QF59dYSeK6Q9kHX4itwUuVvRaViZyL2U19SbQH1znZeF3WUvnVC
         a6UQVr/CfVwMrDZbpxLl+aeRPtlIaHFqU9/qlA4cpNjWO6gQVIdStYwJ5IjhW9TlxK1I
         tHINQWemfxmqoIbQJKw5i88AHBLcxplCeOZ5/Y1dD2J3OndgkaFe5UEEKOCYrgSnASUv
         7Gkw==
X-Gm-Message-State: ANoB5pkQ4JGKnVPkTy1Pe0RuNn0Je5QknCxIsmf9RZvoEKjBk6Ajozfk
        BgCGOrKNf0g3cHTEyYJGSXH4+Q==
X-Google-Smtp-Source: AA0mqf557QBudXkUTrEdl0SSFEXGqPr0sabFkkGlQnXdACcs3ThYOLOVf1i14U7d4+89QLusHaeEdg==
X-Received: by 2002:a05:6512:a84:b0:4b5:827:3cac with SMTP id m4-20020a0565120a8400b004b508273cacmr19243928lfu.154.1670489968832;
        Thu, 08 Dec 2022 00:59:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651c131100b00279f213302bsm1400931lja.57.2022.12.08.00.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:59:28 -0800 (PST)
Message-ID: <d0226fa9-9253-72fc-2fb0-5bfbbcba5d86@linaro.org>
Date:   Thu, 8 Dec 2022 09:59:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RESEND PATCH v2 1/3] dt-bindings: power: Add starfive,jh71xx-pmu
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221208084523.9733-1-walker.chen@starfivetech.com>
 <20221208084523.9733-2-walker.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208084523.9733-2-walker.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/12/2022 09:45, Walker Chen wrote:
> Add bindings for Power Management Unit (PMU) on the StarFive JH71XX SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../bindings/power/starfive,jh71xx-pmu.yaml   | 45 +++++++++++++++++++
>  .../dt-bindings/power/starfive,jh7110-pmu.h   | 17 +++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml

Filename matching compatible, so:
starfive,jh7110-pmu.yaml


>  create mode 100644 include/dt-bindings/power/starfive,jh7110-pmu.h
> 
> diff --git a/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml b/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml
> new file mode 100644
> index 000000000000..f308ae136a57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/starfive,jh71xx-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH71xx Power Management Unit
> +
> +maintainers:
> +  - Walker Chen <walker.chen@starfivetech.com>
> +
> +description: |
> +  StarFive JH71xx SoCs include support for multiple power domains which can be
> +  powered on/off by software based on different application scenes to save power.
> +
> +properties:
> +  compatible:
> +      - enum:

Wrong indentation.

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +          - starfive,jh7110-pmu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#power-domain-cells"
> +

Best regards,
Krzysztof

