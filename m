Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB76C730476
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbjFNQBs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245220AbjFNQBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 12:01:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E142961
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 09:01:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5187a752745so2644116a12.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686758481; x=1689350481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNbgQbNKkSZCTur4DZ3YDNCz53Me32F/+LyHmSO9PDw=;
        b=TY7E7JVzNdnEZf822votxXCkJPx0W5Dhm/mKMXOqJXr5OZun1oMYeERzgzhwrZEM0E
         BXWRBBCX0+5C3qapJkwUHmcpOIVEMBYGv5T3gFiKAG/GrfGkx6HHcQxtWGpgNf/ylnSb
         onU6YlCl2v5sUncjaNPXNR/4Qlx21KBklII06xb5pBSR3Hfsw+yx0mSKCBaUJL9L1ur4
         0vQqMI+dQkmw3JDaW7a0uQybn4KqVs+cf+x8fYSOFAQH0mHqtIQm4ZW4Bd7sXekCRTKY
         +u59fY+KmW85ZIqjzf6vMxLib+tvx1p5XwV8gfqFbzLXq8DVlmMZtyienAaVzwrnTMNZ
         ZFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686758481; x=1689350481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNbgQbNKkSZCTur4DZ3YDNCz53Me32F/+LyHmSO9PDw=;
        b=bH/e672lADA/gphfHccfCkb69+3avc3mRH8BhoFL8PnXHhJe6X2BgdLyWfDtV86Nse
         qoB1dguW30fap0zgXrlux105p7WmnqCiT5qH0NnpTMk50Fa0x/w50fgVjHl3PSwaO5VE
         wnp7sPUHan0RiD6VMTtKQh8VFE3+QDE3kgVVR/iQ8D19oQo15OLAeMdpdF986ChSaHP5
         6v4gz+QN55JOgZYwfK3YyRRKo2I7tfZtRuLGY5Z/JLev+S3kFJ6sR8Ya2gXSoRWwtJ0p
         ajlHWU7NUW+v2Sm7zKmvJ/AFKlTHgpYxgJb1alt32VkY1sO2dOrdxuxzuIXrPK8iTzTX
         Fecg==
X-Gm-Message-State: AC+VfDxZs76WiS6jgdNF60vPtsyhkuAV6EWWBKI4fFjAzNQeeTk0L/WK
        anfQiK01EyCCq69KzEkxrISQiA==
X-Google-Smtp-Source: ACHHUZ5I77n4d7gtcpBZBcck4x02BeFRGaX7ZYoHtLBFpQnH4wU3604D/gjE4prMV6tzDiPQyis0aQ==
X-Received: by 2002:a17:906:d54b:b0:978:94b1:25ac with SMTP id cr11-20020a170906d54b00b0097894b125acmr19410499ejc.40.1686758480656;
        Wed, 14 Jun 2023 09:01:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709062e9a00b009823d630ca8sm2489771eji.216.2023.06.14.09.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:01:20 -0700 (PDT)
Message-ID: <5c750c6a-a0f8-c6f7-64fe-716da434d819@linaro.org>
Date:   Wed, 14 Jun 2023 18:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/18] dt-bindings: opp: opp-v2-kryo-cpu: support Qualcomm
 Krait SoCs
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <20230612053922.3284394-2-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612053922.3284394-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/06/2023 07:39, Dmitry Baryshkov wrote:
> Exted the opp-v2-kryo-cpu.yaml to support defining OPP tables for the
> previous generation of Qualcomm CPUs, 32-bit Krait-based platforms.
> 
> It makes no sense to use 'operating-points-v2-kryo-cpu' compatibility
> node for the Krait cores. Add support for the Krait-specific
> 'operating-points-v2-krait-cpu' compatibility string and the relevant
> opp-microvolt subclasses properties.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml      | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index bbbad31ae4ca..93ec778bf333 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -26,7 +26,9 @@ description: |
>  
>  properties:
>    compatible:
> -    const: operating-points-v2-kryo-cpu
> +    enum:
> +      - operating-points-v2-krait-cpu
> +      - operating-points-v2-kryo-cpu
>  
>    nvmem-cells:
>      description: |
> @@ -63,14 +65,15 @@ patternProperties:
>            5:  MSM8996SG, speedbin 1
>            6:  MSM8996SG, speedbin 2
>            7-31:  unused
> -        enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
> -               0x9, 0xd, 0xe, 0xf,
> -               0x10, 0x20, 0x30, 0x70]

Why?

> +        $ref: /schemas/types.yaml#/definitions/uint32

You are changing the type. No. It should be fixed instead (enum applies
to items).

>  
>        clock-latency-ns: true
>  
>        required-opps: true
>  
> +    patternProperties:
> +      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$': true

I don't think it is a common property, so it needs description and
specific type. Specifically "pvs[0-9]" something entirely new.



Best regards,
Krzysztof

