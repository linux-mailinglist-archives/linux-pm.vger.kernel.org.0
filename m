Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049F855FD62
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 12:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiF2Kfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiF2Kf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 06:35:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3312D3E0D1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 03:35:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n8so7598196eda.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vY4p/QAPg19sPi5ImWArjjbFuxo1U3puoYvgdtxt8T0=;
        b=lELhfgGR9McoWE6f1ERWJa06QpR/ZazNLSLSaeQRDuwZKUE5B00Yn09W6mHlISuE9N
         nn1ND1GY/j3WIKN6kz5bIApCdxxaecEz9IKIpB7PDRfrkuzwBaBcr1DxFT9Q3fFkC2VI
         r5Yf5fsupVpK1va+5xqQwwGM3jgJd9y5xgW/DWbnUJlevwROAFagv/xA27uyPnE+M5q8
         ShNt5DkwR1z9rjHUjFGPaUVcLmcGx5w6qolHk1uVi5Fdtkyzhpt385PtDI4hDeClS04a
         rB1sbr2rp59Hc2z2Zd2TUflfKt0ic9zLL1RiLwyj7JE2mRSuNKLYUlxdUNyjr7J/a+fy
         jGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vY4p/QAPg19sPi5ImWArjjbFuxo1U3puoYvgdtxt8T0=;
        b=hrE9Dga+/b/aEkhS0vBdw3heT5kHUo39kUOfEVX8vFZofi90wePijZ/5/8B+U0c1qh
         xsAXa1milwIOD8CdwM/5YNa1kpoxAx4HZc1swmPvJJsys8pOFj+lYHz6dzA2t3/cCKbd
         pFKKVmB3FCAKcbpS7lZCYYvyJxKnlP2OHxqWJ/26ikF0rlh8nc2PnlomOAPLcvucotjZ
         ibJiakWwcy0AW6ahp8EVBwpQ7lp0Lu/ktg2NRsV762bcGfkaelmxnwHSgNTJnqwSC2ud
         NKbygoSomkIK/P3viiB8e4PSNOYKyn9djaq897TFVE2+2C9s27SoaFO1G3bBuMuJLxhD
         qSvg==
X-Gm-Message-State: AJIora+wsjnGtRG5Yztm4VdRhcs7WlawYcWOsgGsqapYRvUN3FP1jfSZ
        mDLd9dmKRKpDZHhKaHXICKMGlA==
X-Google-Smtp-Source: AGRyM1vssCKrWeYDs4M4XrGn1Z+sIj1Md2+oxVQt+0L/JizDoMFKDmawMTDBgRGduYymXzyNsUHfOw==
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id ew4-20020a056402538400b004316d84b451mr3263534edb.46.1656498926722;
        Wed, 29 Jun 2022 03:35:26 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a27-20020a170906275b00b00722e57fa051sm7506540ejd.90.2022.06.29.03.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:35:25 -0700 (PDT)
Message-ID: <1576e17a-add4-83b4-3847-458fea9fd831@linaro.org>
Date:   Wed, 29 Jun 2022 12:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, corbet@lwn.net,
        sre@kernel.org, robh+dt@kernel.org
Cc:     vkoul@kernel.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        David Collins <quic_collinsd@quicinc.com>
References: <20220628015845.28751-1-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628015845.28751-1-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/06/2022 03:58, Anjelique Melendez wrote:
> From: David Collins <quic_collinsd@quicinc.com>
> 
> Update the description of "reg" property to add the PON_PBS base
> address along with PON_HLOS base address.  Also add "reg-names"
> property description.
> 
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
> 
> New patch series to sperate this patch from applied patches.
> Last comments from original patch series can be found
> https://lore.kernel.org/linux-arm-msm/27515993-18f3-8891-4835-9b6a8d7f86b0@quicinc.com/
> 
> changes since v1:
>   - Updated path which was missing Documention/devicetree prefix
>   - Updated CC list
>   
>  ../bindings/power/reset/qcom,pon.yaml | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 353f155d..1d8cf900 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -26,8 +26,26 @@ properties:
>        - qcom,pm8998-pon
>  
>    reg:
> -    maxItems: 1
> +    description: |
> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
> +      peripherals.  In that case, the PON_PBS address needs to be specified to
> +      facilitate software debouncing on some PMICs.

You need separate compatibles for that and constraints (allOf:if:then)
for each variant.

> +    minItems: 1
> +    maxItems: 2
>  
> +  reg-names:
> +    description: |
> +      For PON GEN1 and GEN2, it should be "pon". For PON GEN3 it should include
> +      "pon_hlos" and optionally "pon_pbs".
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      anyOf:
> +        - const: pon_hlos
> +        - const: pon_pbs
> +        - const: pon

First, you missed Rob's comment, that names should be without "pon" prefix.

Second, uUnfortunately this cannot be such flexible. Items have to be
strictly ordered. You mentioned in description something about gen1/2/3,
so probably what you want per-variant, specific list.

Best regards,
Krzysztof
