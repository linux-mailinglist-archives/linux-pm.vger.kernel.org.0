Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3418B7F5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 14:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCSNgx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 09:36:53 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54236 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgCSNgw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 09:36:52 -0400
Received: by mail-wm1-f46.google.com with SMTP id 25so2406626wmk.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uEd9IVodt6fa58bsyLHIrVxIAopcFc2wB37Cyaqmow4=;
        b=VxtC05fWVlvcHihiVKFYmJhn/wlPWp3Xybqk6gt7lcl6FeX+sfeDhn1sGbpcgJbu3d
         kExv/0oyrfd8F/S+V2EZPxliE1pxk090HamF6dAh3KVNCalRwqa6Aqa2m751TYYj62yS
         DQ6VeD+GFIzm2Da8/hcBN829yACx/Jai0btH7LCpiVPXyA+x1l4lG0Xpqj0Xs4VDv0Nd
         Vs3iWw+tvI62xadbMi8flMMy/sWOI9CLG8Xj02ndVoQ6L9G/PsUOZ6SG+hk4/wApbc+l
         1r8+19uE/cSGlIiMLGl9mZfFbB9kcO0yADLZ2Ofc08ul8zZzIgMSRohrPPy4bvaZ4XJm
         vHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uEd9IVodt6fa58bsyLHIrVxIAopcFc2wB37Cyaqmow4=;
        b=pQANJ/xHCO4PeTMm+N8Kg8VndNKSJYspB9jgWlXN6YgN/MUBwvmITjj03iuRVZiU0l
         Bd9NzNojxUjuPRp9BB5gAVzLb3pj29oNNUDkNbRFwM2dacoJXGtwXtpcgPw5+QiuXwb+
         bU/lijXL40Z5WD0hXB5zUc4QRlmJexHj9j2ZZ0k+iiS1Pd+V23JOUf/Yzyg2FN0FtIw7
         Msi9i9NszhRnhVeBMBK5B37LnrvuxVMppajqH0Yq4E+sPaxsWhDxX1ysslTvJ2AB2/Jp
         S//LMq7tab5PZG8+cmLl1c/IPvHn8klm3oaUASUM0DwrW6lesjQhtATVDWZ0xeY7+lEQ
         cXnQ==
X-Gm-Message-State: ANhLgQ3Zc4w6i9FT8XGiMCCZ4k2Kjf+ZpYuV9t+6k5KutaWO83WHlYGK
        1tQD3171Rce7oTFeNFqmIY1z3A==
X-Google-Smtp-Source: ADFU+vu1dFag4U4oZYG0BReV/F50kZwKNoJprOTG8xcl9vorDq/ViGEh+iUQkaBJbZrxgjhqXjyXWA==
X-Received: by 2002:a1c:9d41:: with SMTP id g62mr3937974wme.131.1584625010128;
        Thu, 19 Mar 2020 06:36:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7? ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.googlemail.com with ESMTPSA id e5sm3553535wru.92.2020.03.19.06.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 06:36:49 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 2/4] thermal: k3: Add support for bandgap
 sensors
To:     Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
References: <20200318083028.9984-1-j-keerthy@ti.com>
 <20200318083028.9984-3-j-keerthy@ti.com>
 <ea3b34dc-42e3-0b10-4b89-faf2621a4ee2@linaro.org>
 <03b837de-ff25-2308-8a56-15bc3377cd5f@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d8bff098-f852-4c55-0afc-d7fd043dd10a@linaro.org>
Date:   Thu, 19 Mar 2020 14:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <03b837de-ff25-2308-8a56-15bc3377cd5f@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/03/2020 13:52, Keerthy wrote:
> 
> 
> On 19/03/20 6:08 pm, Daniel Lezcano wrote:
>> On 18/03/2020 09:30, Keerthy wrote:
>>> The bandgap provides current and voltage reference for its internal
>>> circuits and other analog IP blocks. The analog-to-digital
>>> converter (ADC) produces an output value that is proportional
>>> to the silicon temperature.
>>>
>>> Currently reading temperatures and creating work to periodically
>>> read temperatures from the zones are supported.
>>> There are no active/passive cooling agent supported.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---

[ ... ]

>>> +static const int k3_adc_to_temp[] = {
>>> +    -40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600,

[ ... ]

>>> 123000,
>>> +    123400, 123800, 124200, 124600, 124900, 125000,
>>> +};
>>
>> Can be this array replaced by an initialization array with a formula?
>>
>> Why do we have most of the time a step of 400 then suddenly 500 and 400
>> again? eg. 30600, 31000, 31400, 31900, 32500, 33000, 33400
> 
> This has come from a polynomial equation which i do not want to
> calculate every time we read the temperature. Hence prefer Look up table.

Agree, it makes sense to not calculate every time the temperature is read.

I was suggesting to fill the array at init time with this polynomial
formula instead of hardcoding it.

[ ... ]

>>> +
>>> +    /* Get the sensor count in the VTM */
>>> +    val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
>>> +    cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
>>> +    cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
>>> +
>>> +    data = devm_kcalloc(dev, cnt, sizeof(*data), GFP_KERNEL);
>>> +    if (!data) {
>>> +        ret = -ENOMEM;
>>> +        goto err_alloc;
>>> +    }
>>> +
>>> +    /* Register the thermal sensors */
>>> +    for (id = 0; id < cnt; id++) {
>>> +        data[id].sensor_id = id;
>>> +        data[id].bgp = bgp;
>>> +        data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET +
>>> +                    id * K3_VTM_REGS_PER_TS;
>>> +        data[id].stat_offset = data[id].ctrl_offset + 0x8;
>>> +        INIT_WORK(&data[id].thermal_wq, k3_thermal_work);
>>
>>         What is supposed to do ?
> 
> Periodically poll temperature. I know there is no passive cooling agent
> like cpufreq at the moment but i do have a critical trip do you
> recommend to remove that?

Actually I was referring to the workq which is initialized, the callback
set but it is never called. It can be removed.

Please take also the opportunity to wrap the calls to the register with
an explicit helper function name.

And remove reg_cnt which is unused.

Thanks

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

