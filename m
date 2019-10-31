Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937B5EBA2B
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 00:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfJaXIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 19:08:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32774 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaXIn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 19:08:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so5958489lfc.0;
        Thu, 31 Oct 2019 16:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LfMOpqmh3hu4Z0wFflv+lBYdascyk2HUnFcBRiRArs4=;
        b=FxiEt0AS2hRxphbCFALjC5ZMg7ZgfrX+51lx7kWvtynPV9O+EVDTn6Xx0yNwMV+vzC
         giwNAosbCwUnjbCq25rzROkZ371EOw4za9kBbNAZuO9TE827sW2C5XMkk9mFHzxZBrEf
         03MpFOYMhWjS1gzCBUBqBvE0rcUFxu59U0jXyBrCMFlHIA/MlaEOQyGp8PDy8YrmsRQU
         FkSGFNpFj+BNOKm73Y1Nam1eu6C61i3lfupzcc68sHtNWpAh3VXgXnFdp8IDo3eP49/U
         CMSCQSE1dSsgK0tDDNITLPgwpUW3WfaKrzkxAAFGKLAmK+qOzF/zvoLdxt+6PVE5FjhY
         IMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfMOpqmh3hu4Z0wFflv+lBYdascyk2HUnFcBRiRArs4=;
        b=cOoWZBCeV/Q2DYum81KvwU323J057yCLfrF+7ZXgch0GwBX6Mr93CBhrPU41w9/Qx3
         IzvbnP+bjmoPomQGk3wd2hbut60w6hegkk5SlKvb3p5q5BVf4UVFc6ODmYcrRlB7/HKA
         HcGcETyiShePIaiEMvlyQJzs62MCPx0yiRb8Rj/a09xC736vR89qBWKKv0C3FvuAlEfH
         qwxswEtqqvK9+7m1B+Wn+Iv9Ma87+p2LmL/b+rEiwfPoNHc4Hg4op7sM9Rm0PSJt8Vm8
         zf6g1JERlNvCFYGE3eZR6sUZSJ/x6fdiyVviZztmrodChOO/JFkG60t0SMkhy/4Kq8VO
         8PqA==
X-Gm-Message-State: APjAAAWUeUJDigckv6At0go4yWoOZ1ydx8Dun08b8HAdTtimAL9guMPb
        00bpsjVM3BWM/GtMiDmpH+5ABh1b
X-Google-Smtp-Source: APXvYqzr4lcKOeeVIXl/TUk97eKlvMi5f7vvojFIvFqqpJBsMZ3XNcFMBuKn8gDJS40l/nML/Qikhg==
X-Received: by 2002:ac2:41d2:: with SMTP id d18mr5098329lfi.92.1572563320400;
        Thu, 31 Oct 2019 16:08:40 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id b2sm1832519ljk.64.2019.10.31.16.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 16:08:39 -0700 (PDT)
Subject: Re: [PATCH v7 06/19] PM / devfreq: tegra30: Use kHz units uniformly
 in the code
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191029220019.26773-1-digetx@gmail.com>
 <CGME20191029220734epcas1p42b635ee1c85a9480cecbaf7a1a41db25@epcas1p4.samsung.com>
 <20191029220019.26773-7-digetx@gmail.com>
 <a8ce6d98-26aa-b6eb-56ea-4bf960fc533d@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f0f64310-e2b0-9b02-fc6e-ccc23054d3de@gmail.com>
Date:   Fri, 1 Nov 2019 02:08:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a8ce6d98-26aa-b6eb-56ea-4bf960fc533d@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.10.2019 07:44, Chanwoo Choi пишет:
> On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
>> Part of the code uses Hz units and the other kHz, let's switch to kHz
>> everywhere for consistency. A small benefit from this change (besides
>> code's cleanup) is that now powertop utility correctly displays devfreq's
>> stats, for some reason it expects them to be in kHz.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 1d22f5239cd5..06c5376a7201 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -448,7 +448,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>  	rate = dev_pm_opp_get_freq(opp);
>>  	dev_pm_opp_put(opp);
>>  
>> -	err = clk_set_min_rate(tegra->emc_clock, rate);
>> +	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
>>  	if (err)
>>  		return err;
>>  
>> @@ -477,7 +477,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  	stat->private_data = tegra;
>>  
>>  	/* The below are to be used by the other governors */
>> -	stat->current_frequency = cur_freq * KHZ;
>> +	stat->current_frequency = cur_freq;
>>  
>>  	actmon_dev = &tegra->devices[MCALL];
>>  
>> @@ -527,7 +527,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>>  		target_freq = max(target_freq, dev->target_freq);
>>  	}
>>  
>> -	*freq = target_freq * KHZ;
>> +	*freq = target_freq;
>>  
>>  	return 0;
>>  }
>> @@ -663,7 +663,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  			goto remove_opps;
>>  		}
>>  
>> -		err = dev_pm_opp_add(&pdev->dev, rate, 0);
>> +		err = dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
>>  		if (err) {
>>  			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
>>  			goto remove_opps;
>> @@ -686,7 +686,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  		goto unreg_notifier;
>>  	}
>>  
>> -	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
>> +	tegra_devfreq_profile.initial_freq = tegra->cur_freq;
>> +
>>  	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>>  				     "tegra_actmon", NULL);
>>  	if (IS_ERR(devfreq)) {
>>
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Thank you, looking forward to the comments to the rest of the patches.
Will be nice if this series could get ready for 5.5.
