Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD42168876
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 21:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBUUyK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 15:54:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41995 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgBUUyJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 15:54:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id 83so2442963lfh.9;
        Fri, 21 Feb 2020 12:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TrycIB0Byl3AK0/v0YAATqy+JxvB3RPNOGJqr8JA/xw=;
        b=VcEXe+chIrvnVX6OZ7ZdBGQGCnkMJBzOwQxBBzVz6riu1k8SR4N8biCIZ6e1GpL+a5
         hIdlgF4jnQi7LetD8lBnZne8b7xm7PsVmdnXR2EsQCzU/BeJPaPWl9A+tYxSN80lizps
         6tRbqaKxTacjzhIitdni9e05xLTY48tZGFvU81weF0jrOOiP1tlX3w2lGwcHftvThtS3
         pOgwbrUy6E/dA/T/wGuGNfiVl4kgqxIjUdrHH2p2qmstUMIkqFgIU2SCpgqlRAjC0rSO
         hJR7KPy9heZuPm5pdyyzMpMAP1sjJsmG60uppPrFl8BzuBwJxmpAEoFtc0KqRIuswjAl
         +upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TrycIB0Byl3AK0/v0YAATqy+JxvB3RPNOGJqr8JA/xw=;
        b=ccRquuMyec5rRZLJsH9H9ItJ8tfR+6V1a2rrkOOexsGwMnslg6f4yMk3NUYMg9Yb1n
         gqYQlOZbjw3zlzmqxuXi96kW5JpK3yfuAAosr+mnnQDQ/l6E46IIiTpQhWjzgj45rxRR
         ieHTqvVWG2fH0ZplxL0hvzL5e7bNpb2g4fLAL0AmJDWRvGkspCIYDXhZvzyVIY67vttg
         6RGXL7Q7U5QsDmp0JpcI9o3tpRtHdJjDnbeXeDREsRYznYc+Br3wIdZ8WfalHixp1ssz
         lhkMfp9z88SOTZuU+i4IycWkdHEivUiyvlA6k1aaUegS+IiiwmGV4j3mOlSLhy0+46tf
         GI1g==
X-Gm-Message-State: APjAAAWaHR7zfoN+mV3XH91ib6TDRx/jsZDTL3AJILx7LLUcfPBjT/Fb
        T9hjfMTx1FxfPnXi/ovoInlIyYk5
X-Google-Smtp-Source: APXvYqxOt9u2fSIhWRTt2ibCHFzbfYqE6UBnnkMsKJycj6okTC+5hRtdU3Asa2jDkGJ1HO3o8FkkUw==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr20442508lfc.130.1582318446607;
        Fri, 21 Feb 2020 12:54:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r20sm2140722lfi.91.2020.02.21.12.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 12:54:05 -0800 (PST)
Subject: Re: [PATCH v9 09/17] arm: tegra20: cpuidle: Handle case where
 secondary CPU hangs on entering LP2
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
 <21e3cc35-cc6b-5452-da93-bdaac43716c5@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c13aa8f9-092b-55ca-742e-17db0184649b@gmail.com>
Date:   Fri, 21 Feb 2020 23:54:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <21e3cc35-cc6b-5452-da93-bdaac43716c5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.02.2020 23:48, Daniel Lezcano пишет:
> On 21/02/2020 21:21, Dmitry Osipenko wrote:
>> 21.02.2020 23:02, Daniel Lezcano пишет:
> 
> [ ... ]
> 
>>>>>>>> +
>>>>>>>> +		/*
>>>>>>>> +		 * The primary CPU0 core shall wait for the secondaries
>>>>>>>> +		 * shutdown in order to power-off CPU's cluster safely.
>>>>>>>> +		 * The timeout value depends on the current CPU frequency,
>>>>>>>> +		 * it takes about 40-150us  in average and over 1000us in
>>>>>>>> +		 * a worst case scenario.
>>>>>>>> +		 */
>>>>>>>> +		do {
>>>>>>>> +			if (tegra_cpu_rail_off_ready())
>>>>>>>> +				return 0;
>>>>>>>> +
>>>>>>>> +		} while (ktime_before(ktime_get(), timeout));
>>>>>>>
>>>>>>> So this loop will aggresively call tegra_cpu_rail_off_ready() and retry 3
>>>>>>> times. The tegra_cpu_rail_off_ready() function can be called thoushand of times
>>>>>>> here but the function will hang 1.5s :/
>>>>>>>
>>>>>>> I suggest something like:
>>>>>>>
>>>>>>> 	while (retries--i && !tegra_cpu_rail_off_ready()) 
>>>>>>> 		udelay(100);
>>>>>>>
>>>>>>> So <retries> calls to tegra_cpu_rail_off_ready() and 100us x <retries> maximum
>>>>>>> impact.
>>>>>> But udelay() also results into CPU spinning in a busy-loop, and thus,
>>>>>> what's the difference?
>>>>>
>>>>> busy looping instead of register reads with all the hardware things involved behind.
>>>>
>>>> Please notice that this code runs only on an older Cortex-A9/A15, which
>>>> doesn't support WFE for the delaying, and thus, CPU always busy-loops
>>>> inside udelay().
>>>>
>>>> What about if I'll add cpu_relax() to the loop? Do you think it it could
>>>> have any positive effect?
>>>
>>> I think udelay() has a call to cpu_relax().
>>
>> Yes, my point is that udelay() doesn't bring much benefit for us here
>> because:
>>
>> 1. we want to enter into power-gated state as quick as possible and
>> udelay() just adds an unnecessary delay
>>
>> 2. udelay() spins in a busy-loop until delay is expired, just like we're
>> doing it in this function already
> 
> In this case why not remove ktime_get() and increase the number of retries?

Because the busy-loop performance depends on CPU's frequency, so we
can't rely on a bare number of the retries.
