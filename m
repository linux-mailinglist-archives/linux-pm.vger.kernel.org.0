Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E65B2166
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiIHO45 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiIHO4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 10:56:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D411CD5F
        for <linux-pm@vger.kernel.org>; Thu,  8 Sep 2022 07:56:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q21so13942463lfo.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2022 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AJmEg2q9mG/fH5ApWPAmlCUORJqYzRuMecwU+JJYy7c=;
        b=suOq8Nck//LIb2Gnt9WDdFc62Oa1zliaLTDmluGSK0yAsThsDajGtvT1vb7/t5lmT+
         NDwlzBJubLwCaH5bSfcRsTWNUUBTHXiuBEdnNHDulSIhZ4aIVxNAxoIcJn7+ujPAEbip
         fp02FhpK7pStd1ylxpORRmMBwt3GLxBkXjKTkRdvyket8yESMsaS1x6JyzYNj7uWXZ3I
         D5xye36d2w5N58E8UrW20Mo4CTAvJ4bhF8IeBOJsJSmYZmpbdC3DhbPMgyN+6+ar0phl
         9Eofd1cFuwdetf/TqOvjqas7aAmo/QSuEv6z0c8x3AKcMzRq1GQOO5KxFkzcFDWZc1CL
         9plA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AJmEg2q9mG/fH5ApWPAmlCUORJqYzRuMecwU+JJYy7c=;
        b=A+Hd4/Ze5hHk8Nun5DPetjixeqkgr+WpWeC7uamT2Di4OQPft6Z/zl1Y2KYqlgH5qU
         SVZ/u5OddklhLkgfQuCSGwhsIY1QkRl0S9kgxbs/J7CoQmAgPfVyqof/ov9wnOerIPdK
         VUre9S2jTXWSNPUYWyD3VPkuZGtme8f3KuFmTMmgz/RfR1l1Odmvl9/6FKsmNhzd9yTQ
         7pVfR5nFbrFnenPYhRx5YL6KjBL22crOIqrCBdzQqds81hB0DzCKwMdOXIcCAEeRsj21
         o6e0wchPWuldrFFLm7W7r2hIbfYj97e0GykP6EfH6JNEAyLvVrRl2oVu0uh575+dCCS8
         g3Xg==
X-Gm-Message-State: ACgBeo1u/COPHqt2S/iVgIwzpulJudINPkYJs1l7A6oUQsh69sVces6h
        WBAO6YXQofdnTuaEC1nnw1H/Bg==
X-Google-Smtp-Source: AA6agR4yKt8FR62+ocnlzY5Vvxm8+qFHQD1FMbhG0EjNVe96hMqaezOVpdGmxZD9fOf7oWOwxt/QjA==
X-Received: by 2002:a05:6512:3f19:b0:492:fdaa:b535 with SMTP id y25-20020a0565123f1900b00492fdaab535mr2611738lfa.267.1662649009795;
        Thu, 08 Sep 2022 07:56:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a9-20020ac25e69000000b00498ee99a749sm277218lfr.304.2022.09.08.07.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:56:49 -0700 (PDT)
Message-ID: <e0b13195-0aed-094d-c7af-4581b61d6453@linaro.org>
Date:   Thu, 8 Sep 2022 16:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/2] power: reset: qcom-pon: add support for
 qcom,pmk8350-pon compatible string
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, corbet@lwn.net,
        sre@kernel.org, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220725191314.19456-1-quic_amelende@quicinc.com>
 <20220725191314.19456-3-quic_amelende@quicinc.com>
 <57f8d9c4-6f49-ad3d-fc82-7a0f66d1775a@linaro.org>
 <f9853511-e64c-9daf-b4e3-e334035771a8@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f9853511-e64c-9daf-b4e3-e334035771a8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/08/2022 22:26, Anjelique Melendez wrote:
> 
> 
> On 7/26/2022 3:27 AM, Krzysztof Kozlowski wrote:
>> On 25/07/2022 21:13, Anjelique Melendez wrote:
>>> Add support for the new "qcom,pmk8350-pon" comptaible string.
>>>
>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>> ---
>>>  drivers/power/reset/qcom-pon.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
>>> index 4a688741a88a..16bc01738be9 100644
>>> --- a/drivers/power/reset/qcom-pon.c
>>> +++ b/drivers/power/reset/qcom-pon.c
>>> @@ -82,6 +82,7 @@ static const struct of_device_id pm8916_pon_id_table[] = {
>>>  	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
>>>  	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
>>>  	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
>>> +	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
>>>  	{ }
>>>  };
>>>  MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
>>
>> This is now confusing. The new device has entirely different first and
>> second IO address spaces, but you do not code here any differences.
>>
> 
> Based on previous responses to this patch series, it was decided that a new
> "qcom,pmk8350-pon" compatible string is needed to differentiate between gen1/gen2
> vs gen3 children pon devices. Currently the child handles obtaining the register
> address(es) from its parent's regmap in drivers/input/misc/pm8941-pwrkey.c
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/misc/pm8941-pwrkey.c?h=v6.0-rc1#n287).
> The patch that handled that change can be found at
> https://lore.kernel.org/linux-arm-msm/20220422191239.6271-4-quic_amelende@quicinc.com/.
> 
> This driver, as the parent, does not actually need any changes besides adding the
> new parent compatible string. Specifically this driver handles reboot mode support.
> Everything needed to handle reboot mode is in the first register and reboot mode
> is handled the same as a "qcom,pm8998-pon" parent. The split of the pon register
> in pmk8350 does not affect reboot mode. This is why before we added a new compatible
> string "qcom,pm8998-pon" still worked for gen3 children devices. Even though 2
> registers could be defined in the device tree, as a 2nd register is optional for gen3
> children devices,the fact that this driver uses of_property_read_u32() will ensure that
> the base address used for reboot mode comes from the first register.  
> 

Ah, makes sense.


Best regards,
Krzysztof
