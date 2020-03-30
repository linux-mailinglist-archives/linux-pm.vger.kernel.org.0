Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CFE197F0E
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 16:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgC3OyC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 10:54:02 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46344 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgC3OyB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 10:54:01 -0400
Received: by mail-qv1-f66.google.com with SMTP id bu9so3026298qvb.13
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2020 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ku5iL1N6RANAABzr84iAJg9CN/CMxTxUbEuZrAn7SbU=;
        b=L9/0Hme32NofXz992b6CsrXgGCn+cAPnw0YKmlXlaEVc2EdsrME7DA1dyG6E68jsb5
         +lEdHtcSG+Jh7vGSwM5eL03dAWRakzA5SVmGtw1s2vdArPYrqPo9j0GoPl6NzQSn0anC
         p4aaijoNZEDfjF9IzjVZRsWMrtm3Wi7rG/HP1SQ1OUc+hOa1qJouNTG9FTkRYpAKjZAD
         jhfcB0SpfkiH+Ycu3+SACdv1LE7IqPq71vnEZTCTWrRZ1ugePDlBu4g5uFUam58Vel0g
         pSywvkBrhQ2WvVjiobH6uT7Uyh8skIVlfpqAsGNhIiHl+BWEc20xyZzQrscHnvgbbkWb
         yJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ku5iL1N6RANAABzr84iAJg9CN/CMxTxUbEuZrAn7SbU=;
        b=JD0Ua/0EoQ7AJ54w6SeL65EHbBxOXzW2XJ1YHJ0VR4uBB5+xK3GF7D+8H91O6aglE1
         3eAQvhCdAuat7FeRPjXWKTsAixfLVFn39/P7IvJJyc7gwW/DexRwlZaAVskl2KQW1Lil
         5oKCpPjLgT+WxtKyAqX0a0C/G1iTkzI8kh1U87TIk9fNY1dCTBf8QSi4EDRFYNRCdMcM
         9jal6N3BgcKuEub4gCHNUTDG7GqYlruock4XI9g1M60ammPj0hoWvPN25FXJTW+EFdsD
         u2QPWnwkYw/LUJTgH431b7PfOP1Lg6sxgW4WNn7VA/mFqLDbkUoJMTLLOcgn2ag4pvOB
         7y1Q==
X-Gm-Message-State: ANhLgQ0j5B9VdYLf4Gg7ZF36pyoB9VkbW2ZWEfqhkWn0XGKCMZL/Gm7/
        xnmkK71GJfUl2fqXLaQp+65kdA==
X-Google-Smtp-Source: ADFU+vvnZVsf13I2tKyzEPZbzZSTUzrSmDWcuIiitXTu0rbnYah/+4rhMe7ysN6LuRmkXvkXtRCo3Q==
X-Received: by 2002:a0c:e08d:: with SMTP id l13mr12253135qvk.216.1585580040023;
        Mon, 30 Mar 2020 07:54:00 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id 73sm10651439qkf.82.2020.03.30.07.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 07:53:59 -0700 (PDT)
Subject: Re: [Patch v5 4/6] soc: qcom: Extend RPMh power controller driver to
 register warming devices.
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, agross@kernel.org, robh@kernel.org,
        amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
 <20200320014107.26087-5-thara.gopinath@linaro.org>
 <20200327225345.GH5063@builder>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <f20b4940-11ad-82b1-6ece-661a1b033df8@linaro.org>
Date:   Mon, 30 Mar 2020 10:53:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327225345.GH5063@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/27/20 6:53 PM, Bjorn Andersson wrote:
> On Thu 19 Mar 18:41 PDT 2020, Thara Gopinath wrote:
> 
>> RPMh power control hosts power domains that can be used as
>> thermal warming devices. Register these power domains
>> with the generic power domain warming device thermal framework.
>>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v3->v4:
>> 	- Introduce a boolean value is_warming_dev in rpmhpd structure to
>> 	  indicate if a generic power domain can be used as a warming
>> 	  device or not.With this change, device tree no longer has to
>> 	  specify which power domain inside the rpmh power domain provider
>> 	  is a warming device.
>> 	- Move registering of warming devices into a late initcall to
>> 	  ensure that warming devices are registered after thermal
>> 	  framework is initialized.
> 
> This information is lost when we merge patches, as such I would like
> such design decisions to be described in the commit message itself.
> But...
> 
>>
>>   drivers/soc/qcom/rpmhpd.c | 37 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>> index 7142409a3b77..4e9c0bbb8826 100644
>> --- a/drivers/soc/qcom/rpmhpd.c
>> +++ b/drivers/soc/qcom/rpmhpd.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_opp.h>
>> +#include <linux/pd_warming.h>
>>   #include <soc/qcom/cmd-db.h>
>>   #include <soc/qcom/rpmh.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> @@ -48,6 +49,7 @@ struct rpmhpd {
>>   	bool		enabled;
>>   	const char	*res_name;
>>   	u32		addr;
>> +	bool		is_warming_dev;
>>   };
>>   
>>   struct rpmhpd_desc {
>> @@ -55,6 +57,8 @@ struct rpmhpd_desc {
>>   	size_t num_pds;
>>   };
>>   
>> +const struct rpmhpd_desc *global_desc;
>> +
>>   static DEFINE_MUTEX(rpmhpd_lock);
>>   
>>   /* SDM845 RPMH powerdomains */
>> @@ -89,6 +93,7 @@ static struct rpmhpd sdm845_mx = {
>>   	.pd = { .name = "mx", },
>>   	.peer = &sdm845_mx_ao,
>>   	.res_name = "mx.lvl",
>> +	.is_warming_dev = true,
>>   };
>>   
>>   static struct rpmhpd sdm845_mx_ao = {
>> @@ -452,7 +457,14 @@ static int rpmhpd_probe(struct platform_device *pdev)
>>   					       &rpmhpds[i]->pd);
>>   	}
>>   
>> -	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>> +	ret = of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	global_desc = desc;
>> +
>> +	return 0;
>>   }
>>   
>>   static struct platform_driver rpmhpd_driver = {
>> @@ -469,3 +481,26 @@ static int __init rpmhpd_init(void)
>>   	return platform_driver_register(&rpmhpd_driver);
>>   }
>>   core_initcall(rpmhpd_init);
>> +
>> +static int __init rpmhpd_init_warming_device(void)
>> +{
>> +	size_t num_pds;
>> +	struct rpmhpd **rpmhpds;
>> +	int i;
>> +
>> +	if (!global_desc)
>> +		return -EINVAL;
>> +
>> +	rpmhpds = global_desc->rpmhpds;
>> +	num_pds = global_desc->num_pds;
>> +
>> +	if (!of_find_property(rpmhpds[0]->dev->of_node, "#cooling-cells", NULL))
>> +		return 0;
>> +
>> +	for (i = 0; i < num_pds; i++)
>> +		if (rpmhpds[i]->is_warming_dev)
>> +			of_pd_warming_register(rpmhpds[i]->dev, i);
>> +
>> +	return 0;
>> +}
>> +late_initcall(rpmhpd_init_warming_device);
> 
> ...why can't this be done in rpmhpd_probe()?
> 
> In particular with the recent patches from John Stultz to allow rpmhpd
> to be built as a module I don't think there's any guarantees that
> rpmh_probe() will have succeeded before rpmhpd_init_warming_device()
> executes.

It is to take care of boot order.
So this has to happen after the thermal framework is initialized. 
Thermal framework is initialized with core_initcall. Can I move the 
rpmhpd init as a postcore_initcall ? Then I can get rid of this separate 
function and keep it as part of probe.

> 
> Regards,
> Bjorn
> 

-- 
Warm Regards
Thara
