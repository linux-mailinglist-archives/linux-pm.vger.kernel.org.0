Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22DC63A8CB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 13:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiK1M5B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 07:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiK1M5B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 07:57:01 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B1915FE3
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 04:56:59 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r12so17235467lfp.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 04:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdJ3YLGKg8Jwilc7Kq/N45SqMZfSlGNhcVTI/iJvoKg=;
        b=LYIz1wYbCeNtkUBcsulZO9XsFMo4xD+mYQ4GH1pF83hbD3cFMydqv2GivmfvgAZes4
         NHXc1mvyKKYKxEk8hKX/esfGoEMNc1/Jr0i44lnNRZGeFBkX2zvJGh2Q5JxTfxpO7UY9
         CoD+f82UpLzilMSlWAYC65A4gBhAY0Hq0/LHCMeDXKZTh82PVX8v3bh7OUVxCCKZvL4S
         YyFlF+2vyhf3X9amjAFUC9x+fUeCnoixJkuViA2YMRI7T8R7qAF/qBb3ezHgGfLqF5nZ
         Teebyn3uPQgD6hfW6ABZk5J637j2OGJIA2fCy2izJrWIyuAI6KmejAleA+WmOEwfH2zy
         I/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdJ3YLGKg8Jwilc7Kq/N45SqMZfSlGNhcVTI/iJvoKg=;
        b=zlPcZ7OqM8dhPH7+lhm+eFZIbnqRdY3LPRdcfw3uAQhF/UgLIYHuELFK3agdNtPIHb
         s32r8VM+XTlaxXrqPISgo2wcqS+vhTAtAk4eLGMhk2Et1jAiK5mDNWg0puvTqrg/t9lk
         FW4Cx2SKdjS+rIUgjEA7LfCIfnTEe2FQhGplImXZ+uBQ8I0Mpp1iLDCJiLLcSGs/jjnU
         umYpXbI81WWxc6vrTCM/J1Hgr5YjAHyYoCdsyvl/eVRlwff+LS/9cfXslC5d8Nxa0A39
         EogVp9jHITTquz5b3A9V++wHobOm3zqUsk5aCQ73oIoT52cvlOY5ezEdk21QLDQUj91e
         AN/w==
X-Gm-Message-State: ANoB5pn/5xA57HFCZoW3oggUUIS54UMTW6J6zvPH1xgnmtubbQMnFYsD
        Cjbg4Ma329AkjCuAgZmjThCcCQ==
X-Google-Smtp-Source: AA0mqf4dnL/op6s/uiJLLPfcg0d+W4XM4/p87Cp/V69AwGslhviznzpSXNOtaEjUlxpQCT6CWfg89A==
X-Received: by 2002:ac2:4e14:0:b0:4af:f5a0:8786 with SMTP id e20-20020ac24e14000000b004aff5a08786mr15821017lfr.265.1669640217687;
        Mon, 28 Nov 2022 04:56:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z25-20020a195e59000000b004aa14caf6e9sm1739206lfi.58.2022.11.28.04.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 04:56:57 -0800 (PST)
Message-ID: <0b608b1e-e7a0-0084-e691-6e957028dd90@linaro.org>
Date:   Mon, 28 Nov 2022 13:56:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221128124216.13477-1-marcan@marcan.st>
 <20221128124216.13477-3-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128124216.13477-3-marcan@marcan.st>
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

On 28/11/2022 13:42, Hector Martin wrote:
> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
> The hardware has an independent controller per CPU cluster, and we
> represent them as unique nodes in order to accurately describe the
> hardware. The driver is responsible for binding them as a single cpufreq
> device (in the Linux cpufreq model).
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../cpufreq/apple,cluster-cpufreq.yaml        | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> new file mode 100644
> index 000000000000..a21271f73fc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/apple,cluster-cpufreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC cluster cpufreq device
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  Apple SoCs (e.g. M1) have a per-cpu-cluster DVFS controller that is part of
> +  the cluster management register block. This binding uses the standard
> +  operating-points-v2 table to define the CPU performance states, with the
> +  opp-level property specifying the hardware p-state index for that level.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - oneOf:

This is enum.

Any other changes? Your cover letter say quite unspecific "minor review
feedback"...

Best regards,
Krzysztof

