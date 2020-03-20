Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A183718D8E6
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 21:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgCTURz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 16:17:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51309 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTURy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 16:17:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id c187so7891728wme.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2020 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LV6ApGTr42oJIX2YFh/VOpIWSbKzphlhhfcf1BtR2SM=;
        b=OTesBOFyOkCqbqLwN08cjEqFh14QLs6p58T4qA/lI1x2f8hSlRdFMNxYPfMKDFd2Pl
         3w7xLCB7uY6banJgDOvWT9vougBqHGPHyqVZm7GRUTxmlP2GccJf1+A2G5Y3eif6yKu4
         5kvOd1/aug0IOP2OsFW/RD3TvaV1D6hew1qfQxZUfIutcdyWX8d7NYqSf3liyVOLytjI
         +zvSa7/e9nHE1HHvlW1agLGHyilP1FdqOjtZIiXCDwjOdsh+g6ep6S+W6tbS+L7C9hyO
         JOYJM2AAa8WE5VLxxAG36GQ0DxqQL+cNB0k9vGs+yO3AsI5f0pM2xHqJW6b1zWOa4uMQ
         zUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LV6ApGTr42oJIX2YFh/VOpIWSbKzphlhhfcf1BtR2SM=;
        b=nYZVFFQNFpoZWJtoZa0oVN6vI9BcPxqB1GmRIAJf4kB6N4t5f9G079VeLelcb7lSth
         prYfvGQk/qGBEovtKgE0c6euRSkIZ6NZaT1ANWPvYcDRD8+Bvl0r4lpv+2Boko1qtn9/
         vF3MnOGdgcsaIx+vJA1Re1VOpr7zTWQ0Iqg4UrS5lh71bUaylWaydceWdep23VuwvBas
         UMkkJk8OuKKdi6tZpb53um7OvscwaFlOlnfflTv1v/WB7VrvFWdoPSfV0s5Jim79RSUg
         Huz22fU6YTwNFoo+2wU7J3YDqPxnjD5wB9PHdAkskMJJkqXNXwmrbNvZ1gA2hNP6nCjN
         hLqg==
X-Gm-Message-State: ANhLgQ30wtF6olesgpaBz7nlCKnahLgDFSKO9JVWYH0zhVtVx+b07YOg
        ZYxo+vWf3v7B9cOGwFlzsgMbgg==
X-Google-Smtp-Source: ADFU+vvDSge2YFjzgKqQZ+zA3ijbVGp4x9rXMvWgc3aWA0hQNLT8SSRnJpj3EPOWcVOzKx2lealyeQ==
X-Received: by 2002:a1c:b642:: with SMTP id g63mr11725102wmf.108.1584735471557;
        Fri, 20 Mar 2020 13:17:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:38ed:576d:5a6c:770c? ([2a01:e34:ed2f:f020:38ed:576d:5a6c:770c])
        by smtp.googlemail.com with ESMTPSA id 127sm9500773wmd.38.2020.03.20.13.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 13:17:50 -0700 (PDT)
Subject: Re: weird cooling_device/cur_state sysfs behaviour
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20200320151055.h32rh5hpnv7xyuey@macmini.local>
 <bbdd32b7-c376-d44b-df2f-a50911592692@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <96f75e90-9c14-5908-e9e9-979c9d28a898@linaro.org>
Date:   Fri, 20 Mar 2020 21:17:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bbdd32b7-c376-d44b-df2f-a50911592692@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding Rafael,

On 20/03/2020 18:43, Daniel Lezcano wrote:
> On 20/03/2020 16:10, Willy Wolff wrote:
>> Hi all,
>> Hope you're doing well with the situation.
>>
>> I fill that my board get a cold too...
>>
>> When I write to a sysfs node, I have a weird behaviour about the function that is called behind.
>> This bug appears on an arm32 odroid-xu3, and only after v5.4, v5.3.18 behave correctly.
>>
>>
>> Here my modification to see what's going on:
>>
>> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
>> index aa99edb4dff7..a437ae3f4b9f 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -706,11 +706,22 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
> 
> [ ... ]
> 
>>         return result ? result : count;
>>  }
>>  
>> +
> 
> [ ... ]
> 
>>
>> As you can see, the function is recalled with one character less, until the "buffer is empty".
>> I don't understand why. Can anybody help me for this thing?
>> Many thanks in advance.
> 
> [ ... ]
> 
> Very likely the problem is coming from:
> 
>         result = cdev->ops->set_cur_state(cdev, state);
> 
> which returns '1' as showed by the traces:
> 
> drivers/thermal/thermal_sysfs.c:735:cur_state_store result = 1, count = 3
> 
> And because of the return condition above:
> 
> 	return result ? result : count;
> 
>  the function is returning result, so '1', which is interpreted by the
> sysfs as "I wrote one character', so it recalls the function with the
> two remaining characters, etc ...
> 
> The problem is from the governor AFAICT, which governor is it?

I went through the code and I believe the problem is coming from:

cpufreq_set_cur_state
 -> freq_qos_update_request
   -> freq_qos_apply
       -> pm_qos_update_target =>

" * This function returns 1 if the aggregated constraint value has changed,"

	freq_qos_apply() does:

		ret = pm_qos_update_target()
	...
	return ret;


At the first glance, it is related to commit 77751a466ebd1 (Nov 2019).




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

