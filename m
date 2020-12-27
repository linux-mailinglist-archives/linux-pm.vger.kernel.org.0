Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869F22E321C
	for <lists+linux-pm@lfdr.de>; Sun, 27 Dec 2020 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgL0RXr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Dec 2020 12:23:47 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:45627 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgL0RXq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2020 12:23:46 -0500
Received: from [192.168.42.210] ([93.22.148.120])
        by mwinf5d09 with ME
        id 9VMz2400G2c5cNt03VN0zk; Sun, 27 Dec 2020 18:22:02 +0100
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Dec 2020 18:22:02 +0100
X-ME-IP: 93.22.148.120
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: Fix some resource leaks in
 the error handling path of the probe function
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjw@rjwysocki.net, f.fainelli@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20201219101751.181783-1-christophe.jaillet@wanadoo.fr>
 <20201222043505.rq3cmajc3mxv3p2z@vireshk-i7>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <a7e1f78c-b4c9-4ef5-7ca4-94a65fefd299@wanadoo.fr>
Date:   Sun, 27 Dec 2020 18:22:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201222043505.rq3cmajc3mxv3p2z@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le 22/12/2020 à 05:35, Viresh Kumar a écrit :
> On 19-12-20, 11:17, Christophe JAILLET wrote:
>> If 'cpufreq_register_driver()' fails, we must release the resources
>> allocated in 'brcm_avs_prepare_init()' as already done in the remove
>> function.
>>
>> To do that, introduce a new function 'brcm_avs_prepare_uninit()' in order
>> to avoid code duplication. This also makes the code more readable (IMHO).
>>
>> Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> I'm not sure that the existing error handling in the remove function is
>> correct and/or needed.
>> ---
>>   drivers/cpufreq/brcmstb-avs-cpufreq.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> index 3e31e5d28b79..750ca7cfccb0 100644
>> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> @@ -597,6 +597,16 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
>>   	return ret;
>>   }
>>   
>> +static void brcm_avs_prepare_uninit(struct platform_device *pdev)
>> +{
>> +	struct private_data *priv;
>> +
>> +	priv = platform_get_drvdata(pdev);
>> +
>> +	iounmap(priv->avs_intr_base);
>> +	iounmap(priv->base);
>> +}
>> +
>>   static int brcm_avs_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>   	struct cpufreq_frequency_table *freq_table;
>> @@ -732,21 +742,26 @@ static int brcm_avs_cpufreq_probe(struct platform_device *pdev)
>>   
>>   	brcm_avs_driver.driver_data = pdev;
>>   
>> -	return cpufreq_register_driver(&brcm_avs_driver);
>> +	ret = cpufreq_register_driver(&brcm_avs_driver);
>> +	if (ret)
>> +		goto err_uninit;
>> +
>> +	return 0;
>> +
>> +err_uninit:
>> +	brcm_avs_prepare_uninit(pdev);
>> +	return ret;
> 
> Maybe rewrite as:
> 
> 	ret = cpufreq_register_driver(&brcm_avs_driver);
> 	if (ret)
>                  brcm_avs_prepare_uninit(pdev);
> 	return ret;
> 

Personlaly, I prefer what I have proposed. Having a clear and dedicated 
error handling path is more future proff, IMHO.

>>   }
>>   
>>   static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
>>   {
>> -	struct private_data *priv;
>>   	int ret;
>>   
>>   	ret = cpufreq_unregister_driver(&brcm_avs_driver);
>>   	if (ret)
>>   		return ret;
> 
> Instead of returning here, it can be just WARN_ON(ret); and then go on and free
> the resources and this needs to be done in a separate patch.

Ok, I agree (see my comment below the --- in my patch).
I'll send a patch for it when the first patch will be applied, unless 
you prefer if I resend as a serie.

CJ

> 
>>   
>> -	priv = platform_get_drvdata(pdev);
>> -	iounmap(priv->base);
>> -	iounmap(priv->avs_intr_base);
>> +	brcm_avs_prepare_uninit(pdev);
>>   
>>   	return 0;
>>   }
> 

