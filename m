Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A791607536
	for <lists+linux-pm@lfdr.de>; Fri, 21 Oct 2022 12:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJUKlm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Oct 2022 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJUKlk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2022 06:41:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24EF25E0AD
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 03:41:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e18so4215969edj.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 03:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Wds6EmEDWnjWadbCZz/IqJvjUs/Znvf6K3VMrNRmD0=;
        b=GFa7MdOY6kvLGA+kA27qjY1/mEKJlMuM/YNP6qKH8fuTYDqQLjmS255d51snsENyHv
         10Si92guwi7NpdnzzFgSHZyyoKyUgnI8kMsZZrld+V5XqGb3bxLHMmYbV4Zhq4RMT59y
         /xlfrq8vonlRE+C/zzxdluQgWdVrYd8YkmZR4vSlamnEnxZ8lGThpXr3Ov3Cx62pFXKv
         St4F50O6qthbbSxpeYn1aqNlRbs6PsKcvgT5SV6Vkf4gO4yB0Rf9fUf0hgIror/w37TQ
         HMF1HkxS7BbRsUUvV9cqc5tH6g/+fPpBu3UkXsXZsKdZk4tB1gYrP4K2xIyqCyHvZrL4
         0BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Wds6EmEDWnjWadbCZz/IqJvjUs/Znvf6K3VMrNRmD0=;
        b=O7Jw3Wd50gfPt0cmCJ7XOXfmCNIy8aU7LDeXbJjvLoQdy6VMSdpBMagkb485i5QLKl
         wA+kOX6NIUAa8pfY+ZOqMhFF1wV+6UEbF0Dgs6OQx6J3j18QZWRYOTibN/tT1dJsD5q4
         /Q1+zH/NaTZSQsV57hmSf1FBvrCK9y+Xfu1cfwO1PRdPg9u7DWSO6BOEtMN3C+nMdgL5
         SthGLkfw7vZ3m8Jrc1MIFN1zKbzB6UQmQclnTFVnWwYZNfZXyc2JjsXc40sHsDou71MB
         voLNbtgVAVTjo5pkYrlQaMTcenT0R90D/VL5qZ1rdmsJ+pHsCEcrG9/OOsjk9Cyl5K8f
         EsuQ==
X-Gm-Message-State: ACrzQf0AQv2orKs+FHQBoxCNKoKJZCLQk6LJ4b2zY0UN7YdONOdd4Z4a
        NWpge9D/eXBl1i/yPAQJqB/Dpw==
X-Google-Smtp-Source: AMsMyM55oxaMdBexQcxK0v/CJ5c7lABgb0QzdYpynu+J+J3jtLkfCI5N60P1sNhac9N1+CT393qGnw==
X-Received: by 2002:a17:907:a429:b0:78d:b517:735 with SMTP id sg41-20020a170907a42900b0078db5170735mr15052211ejc.318.1666348897396;
        Fri, 21 Oct 2022 03:41:37 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:25b:e73e:85eb:ae6e? ([2a05:6e02:1041:c10:25b:e73e:85eb:ae6e])
        by smtp.googlemail.com with ESMTPSA id h9-20020a05640250c900b004591e6f7f47sm13736594edb.42.2022.10.21.03.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 03:41:36 -0700 (PDT)
Message-ID: <cbc7685a-2ab4-2c3f-2936-dc7b63dcfb87@linaro.org>
Date:   Fri, 21 Oct 2022 12:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/drivers/tegra: Fix crash when getting critical
 temp
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221010150311.40384-1-jonathanh@nvidia.com>
 <afe68b2d-72a4-3fa2-af63-4f71fa36f846@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <afe68b2d-72a4-3fa2-af63-4f71fa36f846@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/10/2022 11:49, Jon Hunter wrote:
> Hi Rafael,
> 
> On 10/10/2022 16:03, Jon Hunter wrote:
>> Commit 13bea86623be ("thermal/of: Remove of_thermal_get_crit_temp()")
>> removed the function of_thermal_get_crit_temp() and this is causing a
>> NULL pointer deference crash when attempting to call the 'get_crit_temp'
>> function pointer because this function pointer is no longer initialised.
>> Fix this by replacing the call to the 'get_crit_temp' function pointer
>> with a call to the function thermal_zone_get_crit_temp() instead.
>>
>> Fixes: 13bea86623be ("thermal/of: Remove of_thermal_get_crit_temp()")
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>   drivers/thermal/tegra/soctherm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c 
>> b/drivers/thermal/tegra/soctherm.c
>> index d2e454902689..4203e74e2f79 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -742,7 +742,7 @@ static int tegra_soctherm_set_hwtrips(struct 
>> device *dev,
>>       /* Get thermtrips. If missing, try to get critical trips. */
>>       temperature = tsensor_group_thermtrip_get(ts, sg->id);
>>       if (min_low_temp == temperature)
>> -        if (tz->ops->get_crit_temp(tz, &temperature))
>> +        if (thermal_zone_get_crit_temp(tz, &temperature))
>>               temperature = max_high_temp;
>>       ret = thermtrip_program(dev, sg, temperature);
> 

I'll take it


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
