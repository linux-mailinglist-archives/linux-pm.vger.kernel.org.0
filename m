Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4290562C85
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiGAHXO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 03:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiGAHXM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 03:23:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1811611836
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 00:23:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb34so2386139ejc.11
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 00:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NtCWNBdxsNIXQ2rUguLIy4qA0OP4W7EvzMXhx3Pf4yk=;
        b=PXrZPHygCfppWrM76d8bNxLtSPtwSI6Yl3cL070Jw7F8g+v/ba88d6TK7Eb8WMfL/F
         M4EF08zGnAWIHYW/wsCJC29gbPyw9im+CMBvjf2qCfsS5xcQxUCswNqJ8jYlOGb2EdZ2
         Y09HItXrpg7L7UbR8gbykYErH7Ll2QuDHy7FLv9Nlg2MGEewTJYw0LGosEV082tS+fx6
         7E2LnqbKOipJeqqVoVXrvJIGm+2y4JexamAGfXFeXeQcZIpsqCrvX6MCIp+rPMOwaHOG
         lx+lJWnbDS2pSFAXcQrWawUQe3DCv+zaLE1qfLrFcaEDd3M3q1pf86De53jGYwvyHBKs
         M33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NtCWNBdxsNIXQ2rUguLIy4qA0OP4W7EvzMXhx3Pf4yk=;
        b=CkAF4iq5GSBDRQTYW5pGuFELAf7OHjoRq4Z6mHEDzABvhyT68vfVypk3kmW2M8icu/
         4rpjnA9LO+P7/PizYFR9ubapqt3OMlG3Ca1YCD4PyNzxA8b5W/CNxMNp/CwP1LsPFkvz
         lYYgb5MktVbNpXgbZkQBFf+RNH9ECvQguUCpEv12mX/N4m72q6xwwYSk7KK3o1SoyFjf
         UIr2EC7fUBrV96gyeHXHdGVCbqpmjiSRMjoUvXO1d7GRnMzGv/DlAQoFUd4QK3dCTuBG
         KfzAjTRRf11tY78cmu4djYw+Dmcm8qlLw3TeKTtudOPKwqwPrY85rqqpFAPB7U3BAxvz
         t0CQ==
X-Gm-Message-State: AJIora/lvVSqu/eMH9W5i4Z46ze+F3xwz+2acBk+uAqPzD5UvhnlF4QD
        OmagoGaDRcVS2uD/KkafP1oPFA==
X-Google-Smtp-Source: AGRyM1vke7tDLQ7V6xjkmNvjREL24jVF+ebKzZh+L86yFZGxSnoYBWAMx9yy8Ro5a12YfhaFDLs+PA==
X-Received: by 2002:a17:907:8a25:b0:726:c9f2:2f5e with SMTP id sc37-20020a1709078a2500b00726c9f22f5emr12622718ejc.286.1656660188577;
        Fri, 01 Jul 2022 00:23:08 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w2-20020a170906384200b00722f8d02928sm10199555ejc.174.2022.07.01.00.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 00:23:07 -0700 (PDT)
Message-ID: <99a5d9ac-9c20-b441-44af-26772a0e989d@linaro.org>
Date:   Fri, 1 Jul 2022 09:23:06 +0200
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
 <1576e17a-add4-83b4-3847-458fea9fd831@linaro.org>
 <0f4eb095-efc2-f7cf-af84-1c381d53382a@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0f4eb095-efc2-f7cf-af84-1c381d53382a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/06/2022 21:37, Anjelique Melendez wrote:
> 
> 
> On 6/29/2022 3:35 AM, Krzysztof Kozlowski wrote:
>> On 28/06/2022 03:58, Anjelique Melendez wrote:
>>> From: David Collins <quic_collinsd@quicinc.com>
>>>
>>> Update the description of "reg" property to add the PON_PBS base
>>> address along with PON_HLOS base address.  Also add "reg-names"
>>> property description.
>>>
>>> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>> ---
>>>
>>> New patch series to sperate this patch from applied patches.
>>> Last comments from original patch series can be found
>>> https://lore.kernel.org/linux-arm-msm/27515993-18f3-8891-4835-9b6a8d7f86b0@quicinc.com/
>>>
>>> changes since v1:
>>>   - Updated path which was missing Documention/devicetree prefix
>>>   - Updated CC list
>>>   
>>>  ../bindings/power/reset/qcom,pon.yaml | 20 +++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>>> index 353f155d..1d8cf900 100644
>>> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>>> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>>> @@ -26,8 +26,26 @@ properties:
>>>        - qcom,pm8998-pon
>>>  
>>>    reg:
>>> -    maxItems: 1
>>> +    description: |
>>> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
>>> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
>>> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
>>> +      peripherals.  In that case, the PON_PBS address needs to be specified to
>>> +      facilitate software debouncing on some PMICs.
>>
>> You need separate compatibles for that and constraints (allOf:if:then)
>> for each variant.
>>
> So I have been looking into using the separate compatible strings however
> have run into a few problems.
> 
> The compatible strings in this binding relate to the parent pon device,
> while gen1/gen2/gen3 relate to the children devices.
> For example, qcom,pm8941-resin/qcpm,pm8941-pwrkey are gen1/gen2 children
> and defined under a parent pon device with the "qcom,pm8998-pon" compatible string
> but qcom,pmk8350-resin/pmk8350-resin are gen3 children and would also be defined
> under a parent pon device with the "qcom,pm8998-pon" compatible string.
> Currently the children do not define their own "reg" property and will use the
> register(s) address(es) defined for their parent[1].
> Because of this we are unable to use the compatibles to separate the constraints
> for gen1/gen2 vs gen3.
> 
> There are two possible suggestions we came up with that could solve this.
> 1. Add a new compatible string to this binding such as "qcom,pmk8350-pon". We would then
> place all gen3 children devices under this compatible string thus being able to use
> allOf:if:then for the constraints.This would also require a few changes within
> driver/power/supply/qcom,pon.c.

Usually more compatibles allows more flexibility. In this case it
clearly looks like qcom,pm8998-pon is too generic, because it covers
devices with different programming model, although it is more of
programming model of children. Anyway you need the new compatible.

The problem is that b2de43136058 ("arm64: dts: qcom: pmk8350: Add
peripherals for pmk8350")
 introduced DTS with old compatible, so keep it backwards compatible -
you now need a pmk8350-pon with fallback to pm8998.

> 
> 2. reg-names is not consumed by anything but rather used for clarification
> for users as what the register(s) address relates to. We could get rid of
> the property and simply have "reg" with minItem:1 and maxItem:2.

We can remove them, but the my last comment about fixed order remains.
If you remove reg-names, I expect that reg has items with description,
in a fixed order. I don't know how it would look like since you have
there two items and three items at the same time and description is
confusing on its own.


Best regards,
Krzysztof
