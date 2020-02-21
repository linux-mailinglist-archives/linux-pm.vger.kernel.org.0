Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F39168869
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 21:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBUUmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 15:42:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40030 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgBUUmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 15:42:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id c23so2431947lfi.7;
        Fri, 21 Feb 2020 12:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SKqfGENhuUh9JXp3QwLMXUqy2Yo6FJdt0pkzmtsrFSo=;
        b=Td+6AI+osc7Fg4qJ7/o3q6MjhhuqHPC2fy+eE+9g+O1hJvjM4F0+CK3pLKAdFPnNZ1
         SYCYeJpSUJK1z3n4xp+4kx3i88qOJUyhevrDpOFeo+fZ6Ozw9mf8jqwwlbmt30TKtsov
         8iX11ioGWGPbkBG5x2k7Lq2a1ThooxkiZpgwZKvcCwvlludLjam5L470cDb9oG30Z6Gu
         3uKD5wEUpP0xgqlkMf04+tNi2WcJDtrmOD9A/G+/4h81M7Il+CPNEpqDRU//Wp5G16+4
         dUI3AtQfg24CzXvpe4qWy26X1Z7c0GRjGks6DLBcpa2FwZsUcK9xKG8TNei2YT5TMWY8
         a+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SKqfGENhuUh9JXp3QwLMXUqy2Yo6FJdt0pkzmtsrFSo=;
        b=KmC4mBKvTQF3EsRT3N1gikiCDoBsVYBadNajrJLZUqxDvYtRn2IBrRY10L3N0N4uao
         efz4ITi3OpveHSkj9uj58Gn1TO3FSogknxasgnDY5lXCFDibAYf3Tlav30Je36om6C4n
         Y85Kw16D4UBw+h3j42SFzlsT9f1QIEgz9nrSKILKCRIYt1jW8Fj8TOhPkCy6bQPaj+RX
         89D5+b/HzoRfli28ZzDHkc6U5GGtUyeFS/K86Rzg2SToDrKsJimNbrNZCyU5e5XawCRc
         DRBER7vPvHgqgCIbH6+8YoXgtIBnKuOcv3uGWUMq8xhyoRqAhNrDHnR32P7zV4wHq6fF
         nxFQ==
X-Gm-Message-State: APjAAAV6SGYflbnpfHIT9Tof4Uc1eva18Tf9exEYE6WZ83jooW/FD5B5
        BaKu7W5TfI3kTuhKnlwdz0pJ6gfp
X-Google-Smtp-Source: APXvYqxegOrmuGuQQkMpqBAe2dwplVay8/Z1dY6Vg/DXDXCDj768YJ6XA3AcmegcriMFaZibmTsU2A==
X-Received: by 2002:a05:6512:1047:: with SMTP id c7mr12125919lfb.78.1582317740696;
        Fri, 21 Feb 2020 12:42:20 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w9sm2225709ljh.106.2020.02.21.12.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 12:42:19 -0800 (PST)
Subject: Re: [PATCH v9 09/17] arm: tegra20: cpuidle: Handle case where
 secondary CPU hangs on entering LP2
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-10-digetx@gmail.com>
 <20200221154318.GO10516@linaro.org>
 <239a2b66-8da8-2e6c-d19d-9ed207ad0a64@gmail.com>
 <20200221173649.GU10516@linaro.org>
 <b51f3f6b-8287-5ce8-fcaa-77cbab507618@gmail.com>
 <f27481cf-ca5e-df47-932b-fcb4713f0d78@linaro.org>
 <50a8fb7c-f497-2234-c0b0-560aec1c5691@gmail.com>
Message-ID: <e5f25dc2-f96f-0108-e02f-0b0d32da3053@gmail.com>
Date:   Fri, 21 Feb 2020 23:42:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <50a8fb7c-f497-2234-c0b0-560aec1c5691@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.02.2020 23:21, Dmitry Osipenko пишет:
> 21.02.2020 23:02, Daniel Lezcano пишет:
>> On 21/02/2020 19:19, Dmitry Osipenko wrote:
>>> 21.02.2020 20:36, Daniel Lezcano пишет:
>>>> On Fri, Feb 21, 2020 at 07:56:51PM +0300, Dmitry Osipenko wrote:
>>>>> Hello Daniel,
>>>>>
>>>>> 21.02.2020 18:43, Daniel Lezcano пишет:
>>>>>> On Thu, Feb 13, 2020 at 02:51:26AM +0300, Dmitry Osipenko wrote:
>>>>>>> It is possible that something may go wrong with the secondary CPU, in that
>>>>>>> case it is much nicer to get a dump of the flow-controller state before
>>>>>>> hanging machine.
>>>>>>>
>>>>>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>>>>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>>>>>> Tested-by: Jasper Korten <jja2000@gmail.com>
>>>>>>> Tested-by: David Heidelberg <david@ixit.cz>
>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> ---
>>>>
>>>> [ ... ]
>>>>
>>>>>>> +static int tegra20_wait_for_secondary_cpu_parking(void)
>>>>>>> +{
>>>>>>> +	unsigned int retries = 3;
>>>>>>> +
>>>>>>> +	while (retries--) {
>>>>>>> +		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
>>>>>>
>>>>>> Oops I missed this one. Do not use ktime_get() in this code path, use jiffies.
>>>>>
>>>>> Could you please explain what benefits jiffies have over the ktime_get()?
>>>>
>>>> ktime_get() is very slow, jiffies is updated every tick.
>>>
>>> But how jiffies are supposed to be updated if interrupts are disabled?
>>
>> Yeah, other cpus must not be idle in this.
> 
> Okay, then jiffies can't be used here because this function is used for
> the coupled / power-gated state only. All CPUs are idling in this state.
> 
>>> Aren't jiffies actually slower than ktime_get() because jiffies are
>>> updating every 10/1ms (depending on CONFIG_HZ)?
>>
>> They are no slower, they have a lower resolution which is 10ms or 4ms.
>>
>> Given the 500ms timeout, it is fine.
>>
>>> We're kinda interesting here in getting into deep-idling state as quick
>>> as possible. I was checking how much time takes the busy-loop below and
>>> it takes ~40-150us in average, which is good enough.
>>
>> ktime_get() gets a seq lock and it is very slow.
> 
> Since all CPUs are idling here, the locking isn't a problem.
> 
> The wait_for_secondary_cpu_parking() function is called on CPU0, it
> waits for the secondary CPUs to enter into safe-state before CPU0 could
> power-gate the whole CPU cluster.
> 
>>>>>>> +
>>>>>>> +		/*
>>>>>>> +		 * The primary CPU0 core shall wait for the secondaries
>>>>>>> +		 * shutdown in order to power-off CPU's cluster safely.
>>>>>>> +		 * The timeout value depends on the current CPU frequency,
>>>>>>> +		 * it takes about 40-150us  in average and over 1000us in
>>>>>>> +		 * a worst case scenario.
>>>>>>> +		 */
>>>>>>> +		do {
>>>>>>> +			if (tegra_cpu_rail_off_ready())
>>>>>>> +				return 0;
>>>>>>> +
>>>>>>> +		} while (ktime_before(ktime_get(), timeout));
>>>>>>
>>>>>> So this loop will aggresively call tegra_cpu_rail_off_ready() and retry 3
>>>>>> times. The tegra_cpu_rail_off_ready() function can be called thoushand of times
>>>>>> here but the function will hang 1.5s :/
>>>>>>
>>>>>> I suggest something like:
>>>>>>
>>>>>> 	while (retries--i && !tegra_cpu_rail_off_ready()) 
>>>>>> 		udelay(100);
>>>>>>
>>>>>> So <retries> calls to tegra_cpu_rail_off_ready() and 100us x <retries> maximum
>>>>>> impact.
>>>>> But udelay() also results into CPU spinning in a busy-loop, and thus,
>>>>> what's the difference?
>>>>
>>>> busy looping instead of register reads with all the hardware things involved behind.
>>>
>>> Please notice that this code runs only on an older Cortex-A9/A15, which
>>> doesn't support WFE for the delaying, and thus, CPU always busy-loops
>>> inside udelay().
>>>
>>> What about if I'll add cpu_relax() to the loop? Do you think it it could
>>> have any positive effect?
>>
>> I think udelay() has a call to cpu_relax().
> 
> Yes, my point is that udelay() doesn't bring much benefit for us here
> because:
> 
> 1. we want to enter into power-gated state as quick as possible and
> udelay() just adds an unnecessary delay
> 
> 2. udelay() spins in a busy-loop until delay is expired, just like we're
> doing it in this function already

I'll try the udelay()-loop over the weekend and will see if it makes any
real difference, maybe I'm missing something.

If it doesn't make any difference, I'll leave this patch as-is, okay?
