Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03ED168651
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 19:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgBUSUJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 13:20:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40700 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgBUSUJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 13:20:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id c23so2156530lfi.7;
        Fri, 21 Feb 2020 10:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FUjaUqxyiUgON33VsY6WWwS4Yfhr7OqQL1lnqu5PDUo=;
        b=XFlHOOblbqwr7y7riUWmwEqug0A3tmqiCYT1aImiWk4YIOXEdeoD8vDRyhLvAesFbJ
         akRSRq4jR2D7GgD9bmsCJDojb1LogbBFiY5WDLSvOLes334uvNJB6amLH3GZPtbQjMe+
         IlZt4Bn2QE0BmN1phR01KBoo1XjeBioy5KWyQpxE74izc0g7t+FJMB1ZaIfjR3cMibhI
         vOvYwQKz/qazCklv10E8xlMMReYXazO5IK28wAzAYEcycZcvDg76yMujWgMWo6GHFT/g
         Pl3AVbuCEmlMbno2SLg223SqN0wtrCwCUv0iG7F1kFFu8K/p5abwXgDxlOmsuQxqlw2X
         HCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FUjaUqxyiUgON33VsY6WWwS4Yfhr7OqQL1lnqu5PDUo=;
        b=rLoQzM/9meEiikkuEcmnvjNMZBhlkwyEQLgqbIWvkXJKOnIkhp6rNNiZKNJgZ5gHfz
         qx7x+0R6JMZit6V3NWP/etJfpB+xjeqy8UE/VCKfx1cjV/rZ18B15vjvGCHSN5fz0Tbk
         5QBuKKFmh+K4ddUzUGMdjEiEJ4fZKKQdPagXmJXdiHdoMVtDpLUjQ1DJQofto5jb3uA2
         SwQz0OL6l3Qk8bVtXXPlL3GJOTtNMacPru9i6coyB5h3F+8AYHE0Hc2pFPkqrHwQY2YB
         pK/Sjh9O43sOTlFBFWYEiUoEYw/vIvHscduC9FElraob4wfW784hOGADqyEdLlsfJt6l
         k9DQ==
X-Gm-Message-State: APjAAAXLQy9NQKaLEvVJZqGmMZMprn0vQnfx8g1OdzRgO2IO0iez6Ahb
        4IbdRxVUyxCogJKaMhXDGh07uBlt
X-Google-Smtp-Source: APXvYqyT3JSqBAYUvkzb+dwmrCpPPqoj21helZR6dyy6a3B/se73aYcbnsLf0Y0Lj0wzBasjk0VtMg==
X-Received: by 2002:ac2:434f:: with SMTP id o15mr3226832lfl.86.1582309206012;
        Fri, 21 Feb 2020 10:20:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d26sm2037966lfa.44.2020.02.21.10.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:20:05 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b51f3f6b-8287-5ce8-fcaa-77cbab507618@gmail.com>
Date:   Fri, 21 Feb 2020 21:19:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200221173649.GU10516@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.02.2020 20:36, Daniel Lezcano пишет:
> On Fri, Feb 21, 2020 at 07:56:51PM +0300, Dmitry Osipenko wrote:
>> Hello Daniel,
>>
>> 21.02.2020 18:43, Daniel Lezcano пишет:
>>> On Thu, Feb 13, 2020 at 02:51:26AM +0300, Dmitry Osipenko wrote:
>>>> It is possible that something may go wrong with the secondary CPU, in that
>>>> case it is much nicer to get a dump of the flow-controller state before
>>>> hanging machine.
>>>>
>>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>>> Tested-by: Jasper Korten <jja2000@gmail.com>
>>>> Tested-by: David Heidelberg <david@ixit.cz>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
> 
> [ ... ]
> 
>>>> +static int tegra20_wait_for_secondary_cpu_parking(void)
>>>> +{
>>>> +	unsigned int retries = 3;
>>>> +
>>>> +	while (retries--) {
>>>> +		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
>>>
>>> Oops I missed this one. Do not use ktime_get() in this code path, use jiffies.
>>
>> Could you please explain what benefits jiffies have over the ktime_get()?
> 
> ktime_get() is very slow, jiffies is updated every tick.

But how jiffies are supposed to be updated if interrupts are disabled?

Aren't jiffies actually slower than ktime_get() because jiffies are
updating every 10/1ms (depending on CONFIG_HZ)?

We're kinda interesting here in getting into deep-idling state as quick
as possible. I was checking how much time takes the busy-loop below and
it takes ~40-150us in average, which is good enough.

>>>> +
>>>> +		/*
>>>> +		 * The primary CPU0 core shall wait for the secondaries
>>>> +		 * shutdown in order to power-off CPU's cluster safely.
>>>> +		 * The timeout value depends on the current CPU frequency,
>>>> +		 * it takes about 40-150us  in average and over 1000us in
>>>> +		 * a worst case scenario.
>>>> +		 */
>>>> +		do {
>>>> +			if (tegra_cpu_rail_off_ready())
>>>> +				return 0;
>>>> +
>>>> +		} while (ktime_before(ktime_get(), timeout));
>>>
>>> So this loop will aggresively call tegra_cpu_rail_off_ready() and retry 3
>>> times. The tegra_cpu_rail_off_ready() function can be called thoushand of times
>>> here but the function will hang 1.5s :/
>>>
>>> I suggest something like:
>>>
>>> 	while (retries--i && !tegra_cpu_rail_off_ready()) 
>>> 		udelay(100);
>>>
>>> So <retries> calls to tegra_cpu_rail_off_ready() and 100us x <retries> maximum
>>> impact.
>> But udelay() also results into CPU spinning in a busy-loop, and thus,
>> what's the difference?
> 
> busy looping instead of register reads with all the hardware things involved behind.

Please notice that this code runs only on an older Cortex-A9/A15, which
doesn't support WFE for the delaying, and thus, CPU always busy-loops
inside udelay().

What about if I'll add cpu_relax() to the loop? Do you think it it could
have any positive effect?
