Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011C726C95E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgIPTIF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgIPTHv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 15:07:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED56C06174A;
        Wed, 16 Sep 2020 12:07:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so6849946ljg.9;
        Wed, 16 Sep 2020 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QihZ8Xz8SWvem6yekgcSVMIjh2NsmhJScWGu6NS+TEk=;
        b=MjEFJzceOxDmHnZTXQpUriaxu7YZuYPh9ri7J4wMEmqYn62mY5W3Ir4+zMzkboPdV/
         hij4RfkJbfESMIVrEsEq/ItYHrytO0JPLYerI14dkQvnC5SMw/3rahxv1q14TtPJeOLa
         84/J/UKGojO41P/yW9EdEXjb/l55mIG+xE3bl3NkRu6jtr+vRaASQpxUdLILm30uGPzE
         mjT+C/fSdJMJGx6zBVxdoRlboMKsPllVZhFDyhj9vvpf/+iA9ya8XOXpMad0aukZ+i3M
         Gq6Lmx5u0G7PLryBoqvNU5CDB4BJ5KowGaa5QxjkIaTSxiASbO+Q09ykKfCXh0qg7DnW
         /d1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QihZ8Xz8SWvem6yekgcSVMIjh2NsmhJScWGu6NS+TEk=;
        b=RXhvS7ZfLbBaWmzLmhmi8b1FS8kaNonp8hNQmH3clJlG4Z/T3YgIxfdc2Ut5ST7O2C
         yogiVPE2T9AWKBmFWnwKSTr988S8qaolUjB5KCXn2n3BUnWoJ87uEnZhhZ5f9/LR/xmO
         dECvbAlG5O90lZytFyzkwHMTABQJ/P41eF7Z8nIkwpSto7RljzmU5zzXByK/T5n05H5Z
         nQF/eVjUW7zt9sGtMq8gtUGa5rXkyRQiACzzilrSJZMpS3B7Km3UH0REpPX868qu71t2
         RQm8f+VoYsNZWH+pKdwlwFTurmK8RNp/GNtCgSqEEtzMU4b6kj7M+8ScZQxnBAXFgeZP
         xYrA==
X-Gm-Message-State: AOAM531EuacXdktUrALxyVJUFyt4e6+0cGHR+RGf4LpiCE+BwFWUYFvw
        9pAOi8aCQhKrFQkEGFzRSQUqbgrYVDE=
X-Google-Smtp-Source: ABdhPJwLeJRJDNQ4ngutlFWCR9878+7Mq3GY8kKayy8m4NAmTnIKCJTR95DZytNYtYS+rulcgvIq4g==
X-Received: by 2002:a2e:8956:: with SMTP id b22mr8844646ljk.85.1600283268428;
        Wed, 16 Sep 2020 12:07:48 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id d18sm4722662lfm.178.2020.09.16.12.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 12:07:47 -0700 (PDT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
 <20200908072557.GC294938@mwanda>
 <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
 <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
 <e45c8ffc-ea24-1178-7bfa-62ca6bedbb3b@samsung.com>
 <2573cd77-1175-d194-7bfc-24d28b276846@samsung.com>
 <5aac4d59-5e06-25a6-3de1-6a5a586b9e34@gmail.com>
 <bccb08ef-7e48-0cc7-08b5-7177b84a5763@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <887f4b2d-9181-356c-5f09-23be30d2480c@gmail.com>
Date:   Wed, 16 Sep 2020 22:07:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bccb08ef-7e48-0cc7-08b5-7177b84a5763@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.09.2020 05:38, Chanwoo Choi пишет:
> On 9/16/20 2:01 AM, Dmitry Osipenko wrote:
>> 15.09.2020 05:13, Chanwoo Choi пишет:
>>> On 9/15/20 11:00 AM, Chanwoo Choi wrote:
>>>> Hi Dmitry,
>>>>
>>>> On 9/14/20 10:56 PM, Dmitry Osipenko wrote:
>>>>> 14.09.2020 10:09, Chanwoo Choi пишет:
>>>>>> Hi,
>>>>>>
>>>>>> On 9/8/20 4:25 PM, Dan Carpenter wrote:
>>>>>>> This error path needs to call clk_disable_unprepare().
>>>>>>>
>>>>>>> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
>>>>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>>>> ---
>>>>>>> ---
>>>>>>>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>>>>>> index e94a27804c20..dedd39de7367 100644
>>>>>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>>>>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>>>>>> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>>>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>>>>>>  	if (rate < 0) {
>>>>>>>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>>>>>>> -		return rate;
>>>>>>> +		err = rate;
>>>>>>> +		goto disable_clk;
>>>>>>>  	}
>>>>>>>  
>>>>>>>  	tegra->max_freq = rate / KHZ;
>>>>>>> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>>>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>>>>>>>  
>>>>>>>  	reset_control_reset(tegra->reset);
>>>>>>> +disable_clk:
>>>>>>>  	clk_disable_unprepare(tegra->clock);
>>>>>>
>>>>>> Is it doesn't need to reset with reset_contrl_reset()?
>>>>>
>>>>> Hello, Chanwoo!
>>>>>
>>>>> It's reset just before the clk_round_rate() invocation, hence there
>>>>> shouldn't be a need to reset it second time.
>>>>
>>>> Do you mean that reset is deasserted automatically
>>>> when invoke clk_round_rate() on tegra?
>>
>> I only mean that the tegra30-devfreq driver deasserts the reset before
>> the clk_round_rate():
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/devfreq/tegra30-devfreq.c?h=v5.9-rc5#n834
>>
>>>> If tree, I think that 'reset_control_reset(tegra->reset)' invocation
>>>
>>> I'm sorry for my typo. s/tree/true.
>>>
>>>> is not needed on 'remove_opp:' goto. Because already reset deassertion
>>>> is invoked by clk_round_rate(), it seems that doesn't need to invoke
>>>> anymore during exception case.
>>>>
>>>> Actually, it is not clear in my case.
>>
>> The reset_control_reset() in the error path of the driver probe function
>> is placed that way to make the tear-down order match the driver removal
>> order. Perhaps the reset could be moved before the remove_opp, but this
>> change won't make any real difference, hence it already should be good
>> as-is.
>>
>>
> 
> I have one more question.
> When failed to enable clock on line829[1],
> does it need any reset_control invocation?
> In this case on line829, just return without any restoration 
> about reset control.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/devfreq/tegra30-devfreq.c?h=v5.9-rc5#n829
> 

There is no need to deassert the reset if clk-enable fails because reset
control of tegra30-devfreq is exclusive, i.e it isn't shared with any
other peripherals, and thus, reset control could asserted/deasserted at
any time by the devfreq driver. If clk-enable fails, then reset will
stay asserted and it will be fine to re-assert it again.
