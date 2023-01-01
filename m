Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB865AA7D
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 16:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjAAP5B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 10:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjAAP5A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 10:57:00 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6034FD7F
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 07:56:58 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s22so26983709ljp.5
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 07:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8WOYy3wB9J2+waZ/fTnF+QgXM8b1vl0mlMJvZFGPBQ=;
        b=yAgXcGblGr+ppUUxGs+IHS2AVdk2MFyylT8POztdRNAPWvNSWGn5SDtUel44U95S4/
         aSj2X9CfRmM5WHVPSqeFL2UKhGacFCyNpxDM4n6lupEp357PxIl2zIJ9TmUXv0Te63yy
         AoIRkhXAxkERIgFqxwmbzZ6G+Admbn8tZT1A0Cv6+vgGFHsnZKhlP40dMeJiVTiYmHIa
         QlBsdwdKmKlQGe1JOHcTHNVYBul4wBUx/zbtaauVLIDL6KPUyImlVaPowMdEDPwqbPzO
         7JgGEVGJKqZ3R3dtvdYAO2FxM1gArdEanB816VS7W+hNBBEP5YUZ3+kTzGGbQBTu8zO/
         17Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8WOYy3wB9J2+waZ/fTnF+QgXM8b1vl0mlMJvZFGPBQ=;
        b=IvnziW6A1lc7Dt0ZeyU28lr6Tz7URYFc2yRQBzRGAIsXFguZI1X4k9uVnNQOQXFf0b
         Eta+ovmX/OaIKdteSFdtWVt3TU4dAiSkHZcGum/v1qVJIXbfm9A6K4EScBA/kCJA5GMZ
         k7vvsE7XCCZF7Zd5BEoJnvmmxP37e8lnOSjTuDOrQvOLdP0xepbvGpMPQaLWncqBfPQi
         l7qBtTexeuL7h8W/9ocPPGRUe+jiWU0pY7ca3/pLxrVKJDahxBV3nbNJEl8pAsZse/Iu
         lnHgbyPp5d7slbweD+TStMCnGIpPIeCjTkrPs/ziad+3ukiGluuRgf+TAbhQF3SRz6Jo
         ngeg==
X-Gm-Message-State: AFqh2koBVFAjfuGdjo6lihNTtT6UfjJYMKMpxh1jMCNbOq0R+2Zn5jkK
        WigL+dPCtXN/K51anZvvbrx5J0DiUnaDH2AF
X-Google-Smtp-Source: AMrXdXv5Ct9sXU9i4M0QTsKIu0OMbu2eQ5HTSWZu/Tx0yqLnUE76WgGPZwMdHxn/NnUmzmw3A+A7dg==
X-Received: by 2002:a2e:a48a:0:b0:27f:dee0:2c69 with SMTP id h10-20020a2ea48a000000b0027fdee02c69mr2627749lji.53.1672588616723;
        Sun, 01 Jan 2023 07:56:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05651c0b9900b0027fbd4ee003sm2190535ljb.124.2023.01.01.07.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 07:56:56 -0800 (PST)
Message-ID: <74d22d8b-04b6-77ec-610e-d7f5844225a5@linaro.org>
Date:   Sun, 1 Jan 2023 16:56:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 02/20] dt-bindings: thermal: tsens: support per-sensor
 calibration cells
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
 <20221229030106.3303205-3-dmitry.baryshkov@linaro.org>
 <ef9d5f72-e39a-e32c-5d7d-4a6ee57101aa@linaro.org>
 <CAA8EJppp967vZNaMBDmB7HaU_EaCJfvUxFFHikb9oXRohGSCBg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJppp967vZNaMBDmB7HaU_EaCJfvUxFFHikb9oXRohGSCBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/12/2022 12:49, Dmitry Baryshkov wrote:
> On Thu, 29 Dec 2022 at 10:35, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 29/12/2022 04:00, Dmitry Baryshkov wrote:
>>> Allow specifying the exact calibration mode and calibration data as nvmem
>>> cells, rather than specifying just a single calibration data blob.
>>>
>>> Note, unlike the vendor kernel the calibration data uses hw_ids rather
>>> than software sensor indices (to match actual tsens usage in
>>> thermal zones).
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  .../bindings/thermal/qcom-tsens.yaml          | 95 +++++++++++++++++--
>>>  1 file changed, 85 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> index f3660af0b3bf..4bb689f4602d 100644
>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> @@ -81,18 +81,63 @@ properties:
>>>      maxItems: 2
>>>
>>>    nvmem-cells:
>>> -    minItems: 1
>>> -    maxItems: 2
>>> -    description:
>>> -      Reference to an nvmem node for the calibration data
>>> +    oneOf:
>>> +      - minItems: 1
>>> +        maxItems: 2
>>> +        description:
>>> +          Reference to an nvmem node for the calibration data
>>> +      - minItems: 5
>>> +        maxItems: 35
>>> +        description: |
>>> +          Reference to nvmem cells for the calibration mode, two calibration
>>> +          bases and two cells per each sensor
>>>
>>>    nvmem-cell-names:
>>> -    minItems: 1
>>> -    items:
>>> -      - const: calib
>>> -      - enum:
>>> -          - calib_backup
>>> -          - calib_sel
>>> +    oneOf:
>>> +      - minItems: 1
>>> +        items:
>>> +          - const: calib
>>> +          - enum:
>>> +              - calib_backup
>>> +              - calib_sel
>>> +      - minItems: 5
>>> +        items:
>>> +          enum:
>>
>> This should not be an enum but a list of const... unless "holes" are
>> expected (e.g. s0_p1 and s5_p2, without ones in between).
> 
> Yes, this is the case. See the msm8916.dtsi changes. There is no
> sensor with hw_id 3, so the sequence is: ... s2_p1, s2_p2, s4_p1,
> s4_p2,....
> 
> Same applies to the msm8939 (no sensor #4).
> 
> Note: if there was support for the prefixItems, I'd have probably
> marked mode/base1/base2 to be the first items of the array.

Then how about list of const items and patterns? Would be similar number
of lines, just a bit more complicated pattern instead of simple string
to enum.

Best regards,
Krzysztof

