Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4565AB25
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjAATTB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAATTA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:19:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5F326D5
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:18:52 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bt23so22194566lfb.5
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgkkQnvWl1FWFMur5dJDKHJDHKWzGhaBstntdd4wXBU=;
        b=D89K6sJplqOIFV5dxnJB+Y/CIBSrILXHFEVJgN5SVBA3Dg+lycfMSHkcVegtXL5sV2
         vqcVypUI3964JKV5I4x29Ryv1t2syIlZqAwN78gJvEmIpEROGooXyVtpYl6oQwpoVMdZ
         FCnpfXoZuq7la4eMEsiCva0rJ7dks4r/flJe+tKGts52+IOUcqY1xvl6DsJ0iUaZS68p
         /99aasVDf+t3+DwWS7sh1k51gl/zRf2VvHs503453+Z2W6lNRjVOQRfLg63okmOcMeFo
         UUS9GmKk4H95h9n3JKaF0tBlSQVpor1bgQdzagkubJ/iaevYdir1L/dlqrU/8eEIxsjC
         y/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgkkQnvWl1FWFMur5dJDKHJDHKWzGhaBstntdd4wXBU=;
        b=MaCwGm9TXxyY4+w8cUHx6BH4pwpPKMUc8pOceYRftBLJD19nAbKHVhZYDT/rjbiX7V
         S52BXQd++t4V21mm3PsDyJFPwgazZ61GW9K+y9Pi8BRyE3j7Iscbw3c0tgmrAXvsvMdv
         SqN59RBk448hDIgIcHmZq9/cK+tCPad7WygOSS0q3T2gqt2KZDAlqFzlVVXISDlhp6Dh
         oMhww3sEj+B3sXJ8XQWTidAgvzahzCuYYrLclE13aPwn8RwkojRqgD1xjBxK6t1sgLKU
         ke+fIqBQejGF9g/q7vkyz1sU6BxYOkuDOl57ht9oVQxM76xm0LxQpJ06wkTXxazRLoK4
         RgdA==
X-Gm-Message-State: AFqh2kr1nREs+Chkx/MJ+jRTeZUjs0lHpJUpTGUryHWZ97bgSgHDuC7i
        NtUNzWF22d2UJbZJO/4fkkUIYw==
X-Google-Smtp-Source: AMrXdXt8ekMQeh0rWYSrh/y7coRTmHpuE+Ada0F/mR3BwS4a6XkUyt8lfDdyG/VSijbZhfHKKOpt/g==
X-Received: by 2002:ac2:5226:0:b0:4b5:2ae5:d1fa with SMTP id i6-20020ac25226000000b004b52ae5d1famr10564680lfl.23.1672600730814;
        Sun, 01 Jan 2023 11:18:50 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512028a00b00499b1873d6dsm4211615lfp.269.2023.01.01.11.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 11:18:49 -0800 (PST)
Message-ID: <c879951f-9b66-d68a-77e2-228b5b13c683@linaro.org>
Date:   Sun, 1 Jan 2023 21:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 02/20] dt-bindings: thermal: tsens: support per-sensor
 calibration cells
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <74d22d8b-04b6-77ec-610e-d7f5844225a5@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <74d22d8b-04b6-77ec-610e-d7f5844225a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/01/2023 17:56, Krzysztof Kozlowski wrote:
> On 29/12/2022 12:49, Dmitry Baryshkov wrote:
>> On Thu, 29 Dec 2022 at 10:35, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 29/12/2022 04:00, Dmitry Baryshkov wrote:
>>>> Allow specifying the exact calibration mode and calibration data as nvmem
>>>> cells, rather than specifying just a single calibration data blob.
>>>>
>>>> Note, unlike the vendor kernel the calibration data uses hw_ids rather
>>>> than software sensor indices (to match actual tsens usage in
>>>> thermal zones).
>>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>   .../bindings/thermal/qcom-tsens.yaml          | 95 +++++++++++++++++--
>>>>   1 file changed, 85 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>> index f3660af0b3bf..4bb689f4602d 100644
>>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>> @@ -81,18 +81,63 @@ properties:
>>>>       maxItems: 2
>>>>
>>>>     nvmem-cells:
>>>> -    minItems: 1
>>>> -    maxItems: 2
>>>> -    description:
>>>> -      Reference to an nvmem node for the calibration data
>>>> +    oneOf:
>>>> +      - minItems: 1
>>>> +        maxItems: 2
>>>> +        description:
>>>> +          Reference to an nvmem node for the calibration data
>>>> +      - minItems: 5
>>>> +        maxItems: 35
>>>> +        description: |
>>>> +          Reference to nvmem cells for the calibration mode, two calibration
>>>> +          bases and two cells per each sensor
>>>>
>>>>     nvmem-cell-names:
>>>> -    minItems: 1
>>>> -    items:
>>>> -      - const: calib
>>>> -      - enum:
>>>> -          - calib_backup
>>>> -          - calib_sel
>>>> +    oneOf:
>>>> +      - minItems: 1
>>>> +        items:
>>>> +          - const: calib
>>>> +          - enum:
>>>> +              - calib_backup
>>>> +              - calib_sel
>>>> +      - minItems: 5
>>>> +        items:
>>>> +          enum:
>>>
>>> This should not be an enum but a list of const... unless "holes" are
>>> expected (e.g. s0_p1 and s5_p2, without ones in between).
>>
>> Yes, this is the case. See the msm8916.dtsi changes. There is no
>> sensor with hw_id 3, so the sequence is: ... s2_p1, s2_p2, s4_p1,
>> s4_p2,....
>>
>> Same applies to the msm8939 (no sensor #4).
>>
>> Note: if there was support for the prefixItems, I'd have probably
>> marked mode/base1/base2 to be the first items of the array.
> 
> Then how about list of const items and patterns? Would be similar number
> of lines, just a bit more complicated pattern instead of simple string
> to enum.

Ack, this sounds good. I'll send it in the v6.

BTW: do you know if there are any plans to add support for prefixItems?

> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

