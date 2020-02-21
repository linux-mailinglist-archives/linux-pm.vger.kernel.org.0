Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34ACD168806
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 21:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgBUUCf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 15:02:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40632 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBUUCe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 15:02:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so3365759wru.7
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 12:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QMFSTlTPjLBfSui6L2zdxg1P34hDUVJ2NwPge2oTR74=;
        b=vf90FXYn61hSrHYOIAzw2IilQDxYKsi0UVJF8a3GVZ33EF7XGSS/KvBLBZqXV7+pF+
         n88DAFHD05ztPkH0RjhsdMR9m9nMX0nHVUlCEYdSFIAJkpYXN8l+dhi9X0sPUWreWPKN
         uUP+GfatS9TdIkFYnlhp7XXFwXGDUe3/xB8av/WJcdyDtngteCEjixnOaQ9A7tVhujJk
         j02r4yOFXgaFTVj4ReiWrFXRyh/ZyvBqXQbEKTbNEWh2RPI/OLL82UklfPsNH+4lg2wv
         pmGq5cRBkqq575X+a4LRVfy6cxGSfF/WfYuiC1xwfwnApQxxbX0NtM1IQIyAe6mdPh5B
         dF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QMFSTlTPjLBfSui6L2zdxg1P34hDUVJ2NwPge2oTR74=;
        b=XGW71kHSGqQ95gKYKpLo+V5eJOWhpWuJyhKBqD9AycEF6tRrZ2IDuD92LNLRpYNT1r
         suyB0YV5WmgzITOuL0iQihZvEvLirbZDFMagIn3hc6cAiCBZUKwaj/LEKVXHP6BjZaST
         9CJ/9TEIx5yYxGTD7s37YMPD/HciQRG5zk2TrwddM5IIpH3YsSddOa2rR6EiWbLJnPNE
         U8FRRfnGoZ/uyVHFlf0pyVOy0LM8cVSb6TPc3dsiEFxHPMhoH42HmNWcoh2/qi/dyjar
         /jpng/IYMcPhBRnJjf3y3M5zhKKpUdOzHNFwVw3a9LegyIS10H0PHmpvFYhLFptvBXrX
         EmsA==
X-Gm-Message-State: APjAAAXzY3qDQmHKw7LgYroy6A6n5x5ih9Q04OlTo23H7qypU7dSPE7N
        L1KFMtmTSwyZE5dsS3PMbM+cig==
X-Google-Smtp-Source: APXvYqxdVnOssSKqDR/d+Vg12u3Rv/ituklkALgVEaR4PW1C2gXHCP3q5AVQOl4z5G19SaNiDojvwA==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr51667342wrv.9.1582315352290;
        Fri, 21 Feb 2020 12:02:32 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:903b:a048:f296:e3ae? ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.googlemail.com with ESMTPSA id o77sm5483841wme.34.2020.02.21.12.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 12:02:31 -0800 (PST)
Subject: Re: [PATCH v9 09/17] arm: tegra20: cpuidle: Handle case where
 secondary CPU hangs on entering LP2
To:     Dmitry Osipenko <digetx@gmail.com>
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f27481cf-ca5e-df47-932b-fcb4713f0d78@linaro.org>
Date:   Fri, 21 Feb 2020 21:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b51f3f6b-8287-5ce8-fcaa-77cbab507618@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/02/2020 19:19, Dmitry Osipenko wrote:
> 21.02.2020 20:36, Daniel Lezcano пишет:
>> On Fri, Feb 21, 2020 at 07:56:51PM +0300, Dmitry Osipenko wrote:
>>> Hello Daniel,
>>>
>>> 21.02.2020 18:43, Daniel Lezcano пишет:
>>>> On Thu, Feb 13, 2020 at 02:51:26AM +0300, Dmitry Osipenko wrote:
>>>>> It is possible that something may go wrong with the secondary CPU, in that
>>>>> case it is much nicer to get a dump of the flow-controller state before
>>>>> hanging machine.
>>>>>
>>>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>>>> Tested-by: Jasper Korten <jja2000@gmail.com>
>>>>> Tested-by: David Heidelberg <david@ixit.cz>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>
>> [ ... ]
>>
>>>>> +static int tegra20_wait_for_secondary_cpu_parking(void)
>>>>> +{
>>>>> +	unsigned int retries = 3;
>>>>> +
>>>>> +	while (retries--) {
>>>>> +		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
>>>>
>>>> Oops I missed this one. Do not use ktime_get() in this code path, use jiffies.
>>>
>>> Could you please explain what benefits jiffies have over the ktime_get()?
>>
>> ktime_get() is very slow, jiffies is updated every tick.
> 
> But how jiffies are supposed to be updated if interrupts are disabled?

Yeah, other cpus must not be idle in this.

> Aren't jiffies actually slower than ktime_get() because jiffies are
> updating every 10/1ms (depending on CONFIG_HZ)?

They are no slower, they have a lower resolution which is 10ms or 4ms.

Given the 500ms timeout, it is fine.

> We're kinda interesting here in getting into deep-idling state as quick
> as possible. I was checking how much time takes the busy-loop below and
> it takes ~40-150us in average, which is good enough.

ktime_get() gets a seq lock and it is very slow.

>>>>> +
>>>>> +		/*
>>>>> +		 * The primary CPU0 core shall wait for the secondaries
>>>>> +		 * shutdown in order to power-off CPU's cluster safely.
>>>>> +		 * The timeout value depends on the current CPU frequency,
>>>>> +		 * it takes about 40-150us  in average and over 1000us in
>>>>> +		 * a worst case scenario.
>>>>> +		 */
>>>>> +		do {
>>>>> +			if (tegra_cpu_rail_off_ready())
>>>>> +				return 0;
>>>>> +
>>>>> +		} while (ktime_before(ktime_get(), timeout));
>>>>
>>>> So this loop will aggresively call tegra_cpu_rail_off_ready() and retry 3
>>>> times. The tegra_cpu_rail_off_ready() function can be called thoushand of times
>>>> here but the function will hang 1.5s :/
>>>>
>>>> I suggest something like:
>>>>
>>>> 	while (retries--i && !tegra_cpu_rail_off_ready()) 
>>>> 		udelay(100);
>>>>
>>>> So <retries> calls to tegra_cpu_rail_off_ready() and 100us x <retries> maximum
>>>> impact.
>>> But udelay() also results into CPU spinning in a busy-loop, and thus,
>>> what's the difference?
>>
>> busy looping instead of register reads with all the hardware things involved behind.
> 
> Please notice that this code runs only on an older Cortex-A9/A15, which
> doesn't support WFE for the delaying, and thus, CPU always busy-loops
> inside udelay().
> 
> What about if I'll add cpu_relax() to the loop? Do you think it it could
> have any positive effect?

I think udelay() has a call to cpu_relax().




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

