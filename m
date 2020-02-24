Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E02C16A986
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 16:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgBXPM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 10:12:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38028 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXPM6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 10:12:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so7043226lfm.5;
        Mon, 24 Feb 2020 07:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NqBC/JTdN8Jhgh77Z/JOfc6onLMRt8x9FgCKxFMToSA=;
        b=DlXk+F01D5V+hjxzKQ+R4TXFvFhnIHeH8JPudsn9Hc5uGSSnb6hL1oOwSF/UQI8/5J
         LXgke8razdDXQKYoi13jw/YPN92bqblOlA6Y51aXxJPatFlpBnhusaYfudq1IN2rO8z/
         N/0rwF14JLfuEjEWDdWsx6Tgq+5ZfAswCl/t3G0enpLELlMWG2rXv3Gn0wYI88eGFUDW
         II2Pvqv05AVF2dhOocRWn2OoyrISiVGduHWJ5+WFIVWuHxxnd9mktzdNhVxRP9ZJ5yEC
         qRcrww1aDPyEeKhtFOMb8clpAZs/VbswkCfV44DrcV9DL0a01MW4WAk/DDbrDh4Am5at
         XGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqBC/JTdN8Jhgh77Z/JOfc6onLMRt8x9FgCKxFMToSA=;
        b=B4H0gCch1Zlvx922RNcWjmm/VNwsYGC+XPE+TWizWGymFDHX8F17c5FYH7MqLpSkht
         i54ucI+i/VnrKfwAX8PhrxEX5yWZe7LCba6q19fCRF8F429zwRIwVYGNk67AwDeZGZw3
         7KKj9cdoLmKCygJmabFIpDw0ykgKeiC1zCAWLko4y7qTGnzI5VH2BuTyYs3nk7h0Uke8
         5gmFuM102jlQ9nEqgLahkW44PlGB1NnGrStEtivtUWBaCm5a+AJXAd24d17UnIYhyimw
         mW59SLcXfUXTTd7jTIN1y67uH81UqpgmwNbmrGmlVGO9vhnHn/rGuPuOyVqIz5SHBhil
         WB4A==
X-Gm-Message-State: APjAAAVwtQ51s83HOA+BOTYO/FcEZglQR8mS7IW5VMCzlhrjYEJta777
        b5dUt6fSGggIA/9BrXvW8nFLTDeb
X-Google-Smtp-Source: APXvYqzNiy/vS3fXWyrrePfi6+dUliAV53R0cVwJ2gTrHQw97/0yz1u9lSVF6dvqPO04KR50qsFTlg==
X-Received: by 2002:a19:488c:: with SMTP id v134mr3302748lfa.66.1582557175316;
        Mon, 24 Feb 2020 07:12:55 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 23sm6428466ljw.31.2020.02.24.07.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 07:12:54 -0800 (PST)
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
 <c13aa8f9-092b-55ca-742e-17db0184649b@gmail.com>
 <f27e7974-f102-f9dc-6b48-9814b88465bf@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e818e844-a3b6-1493-b4d6-3bdac28f99c6@gmail.com>
Date:   Mon, 24 Feb 2020 18:12:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f27e7974-f102-f9dc-6b48-9814b88465bf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.02.2020 00:11, Daniel Lezcano пишет:
> On 21/02/2020 21:54, Dmitry Osipenko wrote:
>> 21.02.2020 23:48, Daniel Lezcano пишет:
>>> On 21/02/2020 21:21, Dmitry Osipenko wrote:
>>>> 21.02.2020 23:02, Daniel Lezcano пишет:
>>>
>>> [ ... ]
>>>
>>>>>>>>>> +
>>>>>>>>>> +		/*
>>>>>>>>>> +		 * The primary CPU0 core shall wait for the secondaries
>>>>>>>>>> +		 * shutdown in order to power-off CPU's cluster safely.
>>>>>>>>>> +		 * The timeout value depends on the current CPU frequency,
>>>>>>>>>> +		 * it takes about 40-150us  in average and over 1000us in
>>>>>>>>>> +		 * a worst case scenario.
>>>>>>>>>> +		 */
>>>>>>>>>> +		do {
>>>>>>>>>> +			if (tegra_cpu_rail_off_ready())
>>>>>>>>>> +				return 0;
>>>>>>>>>> +
>>>>>>>>>> +		} while (ktime_before(ktime_get(), timeout));
>>>>>>>>>
>>>>>>>>> So this loop will aggresively call tegra_cpu_rail_off_ready() and retry 3
>>>>>>>>> times. The tegra_cpu_rail_off_ready() function can be called thoushand of times
>>>>>>>>> here but the function will hang 1.5s :/
>>>>>>>>>
>>>>>>>>> I suggest something like:
>>>>>>>>>
>>>>>>>>> 	while (retries--i && !tegra_cpu_rail_off_ready()) 
>>>>>>>>> 		udelay(100);
>>>>>>>>>
>>>>>>>>> So <retries> calls to tegra_cpu_rail_off_ready() and 100us x <retries> maximum
>>>>>>>>> impact.
>>>>>>>> But udelay() also results into CPU spinning in a busy-loop, and thus,
>>>>>>>> what's the difference?
>>>>>>>
>>>>>>> busy looping instead of register reads with all the hardware things involved behind.
>>>>>>
>>>>>> Please notice that this code runs only on an older Cortex-A9/A15, which
>>>>>> doesn't support WFE for the delaying, and thus, CPU always busy-loops
>>>>>> inside udelay().
>>>>>>
>>>>>> What about if I'll add cpu_relax() to the loop? Do you think it it could
>>>>>> have any positive effect?
>>>>>
>>>>> I think udelay() has a call to cpu_relax().
>>>>
>>>> Yes, my point is that udelay() doesn't bring much benefit for us here
>>>> because:
>>>>
>>>> 1. we want to enter into power-gated state as quick as possible and
>>>> udelay() just adds an unnecessary delay
>>>>
>>>> 2. udelay() spins in a busy-loop until delay is expired, just like we're
>>>> doing it in this function already
>>>
>>> In this case why not remove ktime_get() and increase the number of retries?
>>
>> Because the busy-loop performance depends on CPU's frequency, so we
>> can't rely on a bare number of the retries.
> 
> Why not if computed in the worst case scenario?

There are always at least a few dozens of microseconds to wait, so
something like udelay(10) should be a bit better variant anyways.

> Anyway, I'll let you give a try.
Turned out that udelay(10) is noticeably better when system is running
on a lower freqs in comparison to ktime_get(). I'll switch to udelay in
v10, thank you very much for the suggestion!
