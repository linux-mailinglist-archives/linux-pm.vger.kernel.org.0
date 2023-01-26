Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C921A67D057
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 16:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjAZPhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 10:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjAZPhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 10:37:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D97EFAF
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 07:37:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z5so2174592wrt.6
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 07:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIu+mxWdNJUsrvi9xRNkt+BBymodGN7DZvnTku8FBhM=;
        b=yD5BTlXOpJ6Hzs9Dck91DU4pOh8K0FDaUZ0KEcFsMKwptBaB1nnp881ttyXkeb0DqG
         dXw8jxGQ14PHAlHOmO1OldRwCuQJgd8vuiGXA0Bcbk+iCHc+nUaLjvijC0TmTfFiUx89
         V5RC7wgpQnLljOUkaRrwN3WqPrvyZ5gYL9vH0ucG0FeGAg8wB6I00pEntBuefheucGRG
         1KpVbsGiuDt5nyJmy/Vh2zXsMOxX5FNNaOF+Xb5UAEoCkB0LzIJ8SboWftAB7QWyZ3ub
         kQVzOFd582ywmdOwyH/ynIi5atSvc3bZP0MonE+fhVekLPFPWDk/jQ6xK6zmVgxRCMKz
         vrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIu+mxWdNJUsrvi9xRNkt+BBymodGN7DZvnTku8FBhM=;
        b=BIbzmQX4+7vhSZxbPnX8jC0tMGSnQDhLvdAVS/74tjDT+7mWf2uxlZEtOBz1p69NF9
         gJcLeGwffCp8Pv3XfU9FLuzOTd8Ty9sRAWBNER0SuFff6R6ye2ivJnMWA3NynSLDd2S2
         chxyKn2+iMj6mrmolV2P/j6kD0kEaCKl2YelkwSp4TeFXlNhWW9ZR8lNtmtKJXk/rEgo
         ybbAa17siE73v5OeJnZ+9dKq2EI099skXnNZVntK9Ld0k1KCqqpP2ieY/nmSYMSZ23Vm
         6XTgMq0Mv9GhH9XW4zJanrTnZoEeFg+1t+wvhdNpBwz0Ms5wT+AJz+7QstbAMFg7RyJB
         ZfxA==
X-Gm-Message-State: AFqh2koAkdtcwicqyTWLYhy3KuAD20JREkpWozN0Wvd22GZuNoaFSTFM
        0LodA6XXVLaflVfQKJh8CQhJFw==
X-Google-Smtp-Source: AMrXdXtaC7G8MzUnGzoywTq1B88ssXXh0aT8RJOiRHsHPA1jxPZmEt45aPHQpEHi0LPaBuEulQRAPw==
X-Received: by 2002:a5d:61c5:0:b0:2bf:9608:57ee with SMTP id q5-20020a5d61c5000000b002bf960857eemr21204904wrv.21.1674747459452;
        Thu, 26 Jan 2023 07:37:39 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j5-20020adff005000000b002bddd75a83fsm1649521wro.8.2023.01.26.07.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:37:39 -0800 (PST)
Message-ID: <810bf9e9-1428-be68-3bcf-93c332987959@linaro.org>
Date:   Thu, 26 Jan 2023 16:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: thermal/drivers/tegra: Getting rid of the get_thermal_instance()
 usage
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Wei Ni <wni@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Johan Hovold <johan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
 <Y9J4WAFyXyV/nqlG@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y9J4WAFyXyV/nqlG@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/01/2023 13:55, Thierry Reding wrote:
> On Tue, Jan 24, 2023 at 08:57:23PM +0100, Daniel Lezcano wrote:
>>
>> Hi,
>>
>> does anyone know what is the purpose of the get_thermal_instance() usage in
>> this code:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/tegra/soctherm.c?h=thermal/linux-next#n623
>>
>> The driver is using a function which is reserved for the thermal core. It
>> should not.
>>
>> Is the following change ok ?
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c
>> b/drivers/thermal/tegra/soctherm.c
>> index 220873298d77..5f552402d987 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -620,9 +620,8 @@ static int tegra_thermctl_set_trip_temp(struct
>> thermal_zone_device *tz, int trip
>>   				continue;
>>
>>   			cdev = ts->throt_cfgs[i].cdev;
>> -			if (get_thermal_instance(tz, cdev, trip_id))
>> -				stc = find_throttle_cfg_by_name(ts, cdev->type);
>> -			else
>> +			stc = find_throttle_cfg_by_name(ts, cdev->type);
>> +			if (!stc)
>>   				continue;
>>
>>   			return throttrip_program(dev, sg, stc, temp);
>> @@ -768,9 +767,9 @@ static int tegra_soctherm_set_hwtrips(struct device
>> *dev,
>>   			continue;
>>
>>   		cdev = ts->throt_cfgs[i].cdev;
>> -		if (get_thermal_instance(tz, cdev, trip))
>> -			stc = find_throttle_cfg_by_name(ts, cdev->type);
>> -		else
>> +
>> +		stc = find_throttle_cfg_by_name(ts, cdev->type);
>> +		if (!stc)
>>   			continue;
>>
>>   		ret = throttrip_program(dev, sg, stc, temperature);
> 
> There's a small difference in behavior after applying this patch. Prior
> to this I get (on Tegra210):
> 
> 	[   12.354091] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips, will use critical trips as shut down temp
> 	[   12.379009] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when cpu reaches 102500 mC
> 	[   12.388882] tegra_soctherm 700e2000.thermal-sensor: programming throttle for cpu to 102500
> 	[   12.401007] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when cpu reaches 102500 mC
> 	[   12.471041] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when gpu reaches 103000 mC
> 	[   12.482852] tegra_soctherm 700e2000.thermal-sensor: programming throttle for gpu to 103000
> 	[   12.482860] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when gpu reaches 103000 mC
> 	[   12.485357] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when pll reaches 103000 mC
> 	[   12.501774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when mem reaches 103000 mC
> 
> and after these changes, it turns into:
> 
> 	[   12.447113] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips, will use critical trips as shut down temp
> 	[   12.472300] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when cpu reaches 102500 mC
> 	[   12.481789] tegra_soctherm 700e2000.thermal-sensor: programming throttle for cpu to 102500
> 	[   12.495447] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when cpu reaches 102500 mC
> 	[   12.496514] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when gpu reaches 103000 mC
> 	[   12.510353] tegra_soctherm 700e2000.thermal-sensor: programming throttle for gpu to 103000
> 	[   12.526856] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when gpu reaches 103000 mC
> 	[   12.528774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when pll reaches 103000 mC
> 	[   12.569352] tegra_soctherm 700e2000.thermal-sensor: programming throttle for pll to 103000
> 	[   12.577635] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when pll reaches 103000 mC
> 	[   12.590952] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shut down when mem reaches 103000 mC
> 	[   12.600783] tegra_soctherm 700e2000.thermal-sensor: programming throttle for mem to 103000
> 	[   12.609204] tegra_soctherm 700e2000.thermal-sensor: throttrip: will throttle when mem reaches 103000 mC
> 
> The "programming throttle ..." messages are something I've added locally
> to trace what gets called. So it looks like for "pll" and "mem" thermal
> zones, we now program trip points whereas we previously didn't.

Hmm, yeah. I did go into the details of the driver but if there is no 
cooling device associated with a trip point it will result in a noop 
from the thermal framework POV. The check is done in the governors by 
going through the thermal zone device list and cdev.


> I'll take a closer look to see if we can replace the calls to
> get_thermal_instance() by something else.

That is great, thanks !



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

