Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679A43681D6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 15:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhDVNvE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 09:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbhDVNvD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 09:51:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD2C06138C
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 06:50:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a4so44894341wrr.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oHHIrNwlKJzcfE+FQHO0ug1i1bvvW4iwkAqPABTWDx8=;
        b=zM0XDyuSfWKqk8T2mOWATqJLBD9+YMYFOM50SXN/r8AChLMjV5otaPIEX3GoTpDd/6
         /P8O3EyBFs3BnjevYogqHiA404amx6PnyXGOusV0IwoOyvBfVdt3cW3by0wyodERpQb9
         0RYY0fhp3UYGR4mvofHhPyr9e9l9Wn+u7Ze9wzafF09BN0lLEH8WtALjQ6xF/mYvxHUG
         zFXVyb91Ty7DC+k4Eo9Se025Zgbk23QACt58LWvRy/SR6Xr/2ej1v3Fr4QqfA19iaWuX
         CAa2hgzpgaBFcOQ0gnPV9ZvNlV4COA0QiJOdeYks/HrT2Hd28JlAlLUhNv8sXkxI+v0n
         bhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oHHIrNwlKJzcfE+FQHO0ug1i1bvvW4iwkAqPABTWDx8=;
        b=iYTsoI7S5l3JybhkOwTs9KHnNDYNrQa/1ZcBG1PhtcnuYH992BKBqkJKTawx0zLtwP
         KFgQEvnJ5mfp9G5sFz8la/Zg2lzeoX2W1tt03GCiMPfTNmQwTpGb56dYhWBk81sqP9oE
         F7qQ/s+F60beb5OmsnILWOP924R0vowRvHpC8GFJocadJWosdKoWaUteSIBrQ3j24Cci
         iLxCFpo66sh1iKI6J15Su9T9vejxlOhFZ+BbST0thBgqYneRcsutsEw0I8AC2onfEzR+
         D/XOAh0ShtaxYepJ9GtFU9nubJxYM07c5O9UTZyiG4k/Y/fB70WLOOrUM8jocbY31nr+
         CqWQ==
X-Gm-Message-State: AOAM530ElGEPWYh1B2KNqSM9Xn9UaoTsXYx6BR6mNvjol6irgufpOXW7
        v2blbP4m5be2eNqDd4BQ4yO0KQ==
X-Google-Smtp-Source: ABdhPJz25Rlr80wY378JDir9MgjKiQXY7Ns4Ol4LX7W8HILcAyeWDo+USHtF9Fp2Uoxukt/6AnIdNw==
X-Received: by 2002:a5d:4251:: with SMTP id s17mr4298450wrr.174.1619099427307;
        Thu, 22 Apr 2021 06:50:27 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e88d:2580:c20:b786? ([2a01:e34:ed2f:f020:e88d:2580:c20:b786])
        by smtp.googlemail.com with ESMTPSA id h2sm3623846wmc.24.2021.04.22.06.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 06:50:26 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYzXSB0aGVybWFsOiB0aS1zb2MtdGhl?=
 =?UTF-8?Q?rmal=3a_Remove_unused_variable_=27val=27?=
To:     linruizhe <linruizhe@huawei.com>, Tony Lindgren <tony@atomide.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210421084256.57591-1-linruizhe@huawei.com>
 <YH/nK6xshH+lW7e0@kroah.com>
 <8e66040e-4330-d4f0-afbb-8cae62a5082e@linaro.org>
 <YH/yQ5Hd+30DH4p/@atomide.com>
 <3116672d-4ff3-a065-f76c-1ae820e1ff95@linaro.org>
 <7871516e6f824f35929c4ed87cbc08c4@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c7d67490-06cd-f15a-3972-3db4d5812a69@linaro.org>
Date:   Thu, 22 Apr 2021 15:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7871516e6f824f35929c4ed87cbc08c4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lin,


On 22/04/2021 14:39, linruizhe wrote:
> Hi Daniel,
> 
> Do I need to make more changes to this patch?

No, it is fine. I've applied it.

Thanks

  -- Daniel


> Thanks
>  
>   -Lin Ruizhe
> 
> -----邮件原件-----
> 发件人: Daniel Lezcano [mailto:daniel.lezcano@linaro.org] 
> 发送时间: 2021年4月21日 19:37
> 收件人: Tony Lindgren <tony@atomide.com>
> 抄送: Greg KH <gregkh@linuxfoundation.org>; linruizhe <linruizhe@huawei.com>; rui.zhang@intel.com; edubezval@gmail.com; j-keerthy@ti.com; amitk@kernel.org; eballetbo@gmail.com; linux-pm@vger.kernel.org; linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org
> 主题: Re: [PATCH v3] thermal: ti-soc-thermal: Remove unused variable 'val'
> 
> 
> Hi Tony,
> 
> thanks for testing
> 
>   -- Daniel
> 
> On 21/04/2021 11:37, Tony Lindgren wrote:
>> * Daniel Lezcano <daniel.lezcano@linaro.org> [210421 09:07]:
>>> On 21/04/2021 10:49, Greg KH wrote:
>>>> On Wed, Apr 21, 2021 at 04:42:56PM +0800, Lin Ruizhe wrote:
>>>>> The variable 'val'in function ti_bandgap_restore_ctxt is the 
>>>>> register value of read bandgap registers. This function is to 
>>>>> restore the context. But there is no operation on the return value 
>>>>> of this register, so this block is redundant. Hulk robot scans this 
>>>>> warning.This commit remove the dead code.
>>>>>
>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>> Fixes: b87ea759a4cc ("staging: omap-thermal: fix context restore 
>>>>> function")
>>>>> Signed-off-by: Lin Ruizhe <linruizhe@huawei.com>
>>>>> ---
>>>>> v3:
>>>>> -Add Fixes tag and more accurate commit message in this patch.
>>>>> v2:
>>>>> -As suggest remove the whole unuesed block in fuction  
>>>>> ti_bandgap_restore_ctxt
>>>>>
>>>>>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 4 ----
>>>>>  1 file changed, 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c 
>>>>> b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>>>>> index d81af89166d2..684ffb645aa9 100644
>>>>> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>>>>> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>>>>> @@ -1142,14 +1142,10 @@ static int ti_bandgap_restore_ctxt(struct ti_bandgap *bgp)
>>>>>  	for (i = 0; i < bgp->conf->sensor_count; i++) {
>>>>>  		struct temp_sensor_registers *tsr;
>>>>>  		struct temp_sensor_regval *rval;
>>>>> -		u32 val = 0;
>>>>>  
>>>>>  		rval = &bgp->regval[i];
>>>>>  		tsr = bgp->conf->sensors[i].registers;
>>>>>  
>>>>> -		if (TI_BANDGAP_HAS(bgp, COUNTER))
>>>>> -			val = ti_bandgap_readl(bgp, tsr->bgap_counter);
>>>>
>>>> Are you sure that this hardware does not require this read to happen 
>>>> in order for it to work properly?
>>>
>>> Yes, initially we had the same concern but we were unable to find 
>>> anything specific in the history. The commit mentioned above removed 
>>> the user of the 'val' code but without removing this block of code.
>>>
>>> When looking at the current code, it really looks like an oversight.
>>
>> Yes so it seems.
>>
>>> There is nothing in the commit's changelog referring to a need of 
>>> reading the counter register but perhaps I'm wrong because I'm not 
>>> sure to understand correctly the changelog.
>>>
>>>> Lots of hardware does need this, have you tested this?
>>
>> I just tested this on omap3 logicpd torpedo devkit that can do off 
>> during idle and reading /sys/class/thermal/thermal_zone0/temp works. 
>> So feel free to add:
>>
>> Reviewed-by: Tony Lindgren <tony@atomide.com>
>> Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks for testing
> 
> 
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook | <http://twitter.com/#!/linaroorg> Twitter | <http://www.linaro.org/linaro-blog/> Blog
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
