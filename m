Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0236E987
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfGSQqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 12:46:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45320 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfGSQqX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 12:46:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so22161054lfm.12;
        Fri, 19 Jul 2019 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BC+wMl1J+1a3vYFsMgUzwTvvzp8GNJcOPDZyzys4fN8=;
        b=GVq51blNfC+1H5bqBS8Kd+n0zbPrzypkhsYA2uISQ1O7/L5ACRECJcdVj8+AKJrg5I
         6SwF9FB/WZnW5488UpP4jo/UVAUpky+GQ5zBHtUt0ZQDnxrKUVAlWptjyJ2GQDWRz6i7
         WorunaqZJnAAGL5jgdrRnOx/TtAg5o+XTldbJeUUy6XzMHPxnRavGInf3BYj1xxT7HTd
         2HaVkB8jCCSvUs+Sm+OSsniSJ1pNmmAexrRIfDeUBCCTaRasOGdnZuOuQoT7aUoFyIqw
         Unc5KZW3PeJqTVl5ygUcxqhAPSUFb0VERXdCnhMa/kCSkeI4yKZIutrvfE50jyBcEsph
         s0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BC+wMl1J+1a3vYFsMgUzwTvvzp8GNJcOPDZyzys4fN8=;
        b=Q16XyImXeWviB0fa/h2iTCSI942IU0J0EfqqeM0TV6l8GFxB2g1X3XLs4qjP0gzfvu
         JXRHDZNcUW2qKkcvLqrCgtShXhpb5FRxsVXhLx6KnkmzT2Hr9Yjj2xvv5QlASar/rFPD
         btlncTdc75uHzOVm6atgCEwZRbfCCmc5fnj5n+fpWh9OooniIw/I7wqQ6U3s1clvt7sc
         uJtI0j+GJ4jefjIQ8PQl7U363M+EwmSF87yxcbr1AmCqutSLg13pOPgaEfEc8oEk6lJK
         7mK17Ltkv4/U1WloE1C6SBuS2+OZALK9ZHDZF9OsPeSPvKKZBtdoayXb9M3gniRCZHSm
         odxA==
X-Gm-Message-State: APjAAAV6JzM5t57IfXkLPBjD2mY3AgDSeerQYpdW8L3EedDqM/Y1JUV/
        aFXNwlKAHMXILkZ3/BiaX1WWMhm5
X-Google-Smtp-Source: APXvYqyFc2gfPTarelhEQEUXeuELGCcDPUMpuvXxifyeE3PxIMsHWXW0o1ytuduHaDPIASGE4HWm6g==
X-Received: by 2002:a19:750b:: with SMTP id y11mr24628098lfe.16.1563554780341;
        Fri, 19 Jul 2019 09:46:20 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id 63sm5886552ljs.84.2019.07.19.09.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 09:46:19 -0700 (PDT)
Subject: Re: [PATCH v4 21/24] PM / devfreq: tegra30: Synchronize average count
 on target's update
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223619epcas4p3dea48e3e09983cd2a76af39fbf7bf99b@epcas4p3.samsung.com>
 <20190707223303.6755-22-digetx@gmail.com>
 <f83fb873-9214-9649-9435-9f211c4cba9e@samsung.com>
 <20190719033152.1d4c3003@dimatab>
 <eed89254-9960-7572-635c-12b114821e85@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fc9cacc8-aa89-803a-dd82-7506965f987a@gmail.com>
Date:   Fri, 19 Jul 2019 19:46:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <eed89254-9960-7572-635c-12b114821e85@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.07.2019 4:40, Chanwoo Choi пишет:
> On 19. 7. 19. 오전 9:31, Dmitry Osipenko wrote:
>> В Thu, 18 Jul 2019 19:15:54 +0900
>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>
>>> On 19. 7. 8. 오전 7:33, Dmitry Osipenko wrote:
>>>> The average count may get out of sync if interrupt was disabled /
>>>> avoided for a long time due to upper watermark optimization, hence
>>>> it should be re-synced on each target's update to ensure that
>>>> watermarks are set up correctly on EMC rate-change notification and
>>>> that a correct frequency is selected for device.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/devfreq/tegra30-devfreq.c | 30
>>>> ++++++++++++++++++++++++++++++ 1 file changed, 30 insertions(+)
>>>>
>>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>>> b/drivers/devfreq/tegra30-devfreq.c index
>>>> 4d582809acb6..8a674fad26be 100644 ---
>>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>>> b/drivers/devfreq/tegra30-devfreq.c @@ -466,11 +466,41 @@ static
>>>> void actmon_isr_device(struct tegra_devfreq *tegra,
>>>> dev->boost_freq, cpufreq_get(0)); }
>>>>  
>>>> +static void tegra_devfreq_sync_avg_count(struct tegra_devfreq
>>>> *tegra,
>>>> +					 struct
>>>> tegra_devfreq_device *dev) +{
>>>> +	u32 avg_count, avg_freq, old_upper, new_upper;
>>>> +
>>>> +	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>>>> +	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
>>>> +
>>>> +	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
>>>> +	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
>>>> +
>>>> +	/* similar to ISR, see comments in actmon_isr_device() */
>>>> +	if (old_upper != new_upper) {
>>>> +		dev->avg_freq = avg_freq;
>>>> +		dev->boost_freq = 0;
>>>> +	}
>>>> +}
>>>> +
>>>>  static unsigned long actmon_update_target(struct tegra_devfreq
>>>> *tegra, struct tegra_devfreq_device *dev)
>>>>  {
>>>>  	unsigned long target_freq;
>>>>  
>>>> +	/*
>>>> +	 * The avg_count / avg_freq is getting snapshoted on
>>>> device's
>>>> +	 * interrupt, but there are cases where actual value need
>>>> to
>>>> +	 * be utilized on target's update, like CPUFreq boosting
>>>> and
>>>> +	 * overriding the min freq
>>>> via /sys/class/devfreq/devfreq0/min_freq
>>>> +	 * because we're optimizing the upper watermark based on
>>>> the
>>>> +	 * actual EMC frequency. This means that interrupt may be
>>>> +	 * inactive for a long time and thus making snapshoted
>>>> value
>>>> +	 * outdated.
>>>> +	 */
>>>> +	tegra_devfreq_sync_avg_count(tegra, dev);  
>>>
>>> I think that you don't need to add the separate function to calculate
>>> the 'dev->avg_freq'. It is enough with your detailed comment to add
>>> this code in this function.
>>
>> The separate function is indeed not mandatory here, but I'm finding that
>> it usually makes easier to read and follow the code when it is properly
>> split up into logical blocks. Don't you agree?
> 
> It is right to make the separate function if function is too long or 
> function is called on the multiple points.
> 
> But, in this case, I think that it is enough to add this code
> to the actmon_update_target() because you already added the detailed comment. 
> 
> It is enough to understand the role of this code with your comment.

That's another personal preference, but I'm fine with yours variant as
well. Will change this in the next version.

>>
>>>> +
>>>>  	target_freq = min(dev->avg_freq + dev->boost_freq,
>>>> KHZ_MAX); target_freq = tegra_actmon_account_cpu_freq(tegra, dev,
>>>> target_freq); 
>>>>   
>>>
>>> And also, is it impossible to squash this patch with patch19/patch20?
>>>
>>
>> It should be possible to squash this patch with #20, but wouldn't
>> be better to keep changes in the chronological order? It's also better
>> to keep changes separate simply to aid bisection in case of a problem.
>>
>>
>>
> 
> 

