Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57026AA60
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 19:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgIORTo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgIORPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:15:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051EEC06121D;
        Tue, 15 Sep 2020 10:01:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id q8so3875183lfb.6;
        Tue, 15 Sep 2020 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H0YZs1pPwgJd7Ktmm4myWmRtfPUsH5VHa1+aQx55PSk=;
        b=RVIyTl6cn7mdnTle5r2TB8rk6Z5oEtnLJ5ScwkQx8hgwsXp9QUmXVRlwB4uojEMlyK
         ro4ICaJFazaA1mm+EfgVBI9hxAPzmmhJ64lz4e9XRqr/CqvyDMSlTIi0Jq4DCY/1tT26
         lZ90elCBfhc46rgjopy+NisYGA97eLI+mgA9sV8BwFl4VzDJuGCE8wJmhnAMhcX+cwiK
         VVsJbNpykSo75U56Bmx3jdegHXN1gwtsHTK88BBJRkMJxUd4BcjpwaHbCwYnGYPU7epw
         ghh2waPDId+IGm4+zWuFtbnEpr9oY8ZzoiInt5wUgHUlgJNe36Jd/6L2agHbfAUq3+tf
         QEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H0YZs1pPwgJd7Ktmm4myWmRtfPUsH5VHa1+aQx55PSk=;
        b=bG3u3U/NzMoA2SlC2NYfKMb9JR4n9dYN62mECR7PXWeLewrEiHSYmDyFz081Ga7Dwi
         kYzxc8eAsmhy9oh5IIVH7xUCrJ5XfVyLa5ZxDXPbcQGaLJBgllIIhKyYOgevauOl8czE
         odjs96X2Fpr7EfCZN/x+IbeWqz22P5u2u56Cm44yy79AI35bWZ+kfwc24ylmW7vu29YU
         O2GmhrUx/Nlvy2OJTaN2cq6/68H2/sIKhR/br+xlP24ZboDB+iVgZeU2JQScZA1WNso/
         pPZK9B09XxJ1Y9E1Gr8+ZPa4ETDBwHAiypA+afcYZIym7NAQs/IDvVVs/tudcbj0jGjt
         Dfiw==
X-Gm-Message-State: AOAM531h1IaJWGWVbIeK09n92welCNQsoh4XmPGYmQ7crPAXnthwRxXf
        7CfjdeMWA/xp7BG1HZ0co4maNSpPW1w=
X-Google-Smtp-Source: ABdhPJwQLpjsE+qFpvuqxasOzAcBnwJF7tP1y9VybOqTsRjgyc1k0GY6l9M7N7DZMzsiWYmMb1c9Zg==
X-Received: by 2002:ac2:548d:: with SMTP id t13mr6603232lfk.602.1600189274348;
        Tue, 15 Sep 2020 10:01:14 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id 73sm4011754lff.118.2020.09.15.10.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:01:13 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5aac4d59-5e06-25a6-3de1-6a5a586b9e34@gmail.com>
Date:   Tue, 15 Sep 2020 20:01:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2573cd77-1175-d194-7bfc-24d28b276846@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.09.2020 05:13, Chanwoo Choi пишет:
> On 9/15/20 11:00 AM, Chanwoo Choi wrote:
>> Hi Dmitry,
>>
>> On 9/14/20 10:56 PM, Dmitry Osipenko wrote:
>>> 14.09.2020 10:09, Chanwoo Choi пишет:
>>>> Hi,
>>>>
>>>> On 9/8/20 4:25 PM, Dan Carpenter wrote:
>>>>> This error path needs to call clk_disable_unprepare().
>>>>>
>>>>> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
>>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>> ---
>>>>> ---
>>>>>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>>>> index e94a27804c20..dedd39de7367 100644
>>>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>>>> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>>>>  	if (rate < 0) {
>>>>>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>>>>> -		return rate;
>>>>> +		err = rate;
>>>>> +		goto disable_clk;
>>>>>  	}
>>>>>  
>>>>>  	tegra->max_freq = rate / KHZ;
>>>>> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>>>>>  
>>>>>  	reset_control_reset(tegra->reset);
>>>>> +disable_clk:
>>>>>  	clk_disable_unprepare(tegra->clock);
>>>>
>>>> Is it doesn't need to reset with reset_contrl_reset()?
>>>
>>> Hello, Chanwoo!
>>>
>>> It's reset just before the clk_round_rate() invocation, hence there
>>> shouldn't be a need to reset it second time.
>>
>> Do you mean that reset is deasserted automatically
>> when invoke clk_round_rate() on tegra?

I only mean that the tegra30-devfreq driver deasserts the reset before
the clk_round_rate():

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/devfreq/tegra30-devfreq.c?h=v5.9-rc5#n834

>> If tree, I think that 'reset_control_reset(tegra->reset)' invocation
> 
> I'm sorry for my typo. s/tree/true.
> 
>> is not needed on 'remove_opp:' goto. Because already reset deassertion
>> is invoked by clk_round_rate(), it seems that doesn't need to invoke
>> anymore during exception case.
>>
>> Actually, it is not clear in my case.

The reset_control_reset() in the error path of the driver probe function
is placed that way to make the tear-down order match the driver removal
order. Perhaps the reset could be moved before the remove_opp, but this
change won't make any real difference, hence it already should be good
as-is.
