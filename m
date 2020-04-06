Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5D19F2F9
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgDFJxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 05:53:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33977 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgDFJxn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 05:53:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id c195so7430991wme.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2020 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Y8KYYSV67CMXMuBRVrsEZZ0Dkuuswu9PWACPReBAMA=;
        b=s9MvSctF6VhiZxmpezETuJqLWz6LiQ8GrJqpPtlj+GsurtNCV+FSmXOW/eBBmVDefy
         qB3LCwrPEcRbOOB8cUofONyVR5HOLZuHN8Lx1bOPcong/pn7vqzjjYTs6UhJyoNVb1Y5
         Q1z6Ks90GBFmZTL7EnyLzicSpHyoSS+IVCDnprUqf1lg5OUEvyWizrfVxOI+tpqlFJfJ
         qzIr2UVRf4oWdKXvAShyLKewnZDleK9lAd1dAeYmJxwAhWCZis8fsWFAIq2ZZ0MOsGyn
         EYHk1sOeM5SPbp8h1BGcw1Y2r0T94lMOuzboaipC8cyhCX6UmiToIGeeob7c8uN7SYVr
         bY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0Y8KYYSV67CMXMuBRVrsEZZ0Dkuuswu9PWACPReBAMA=;
        b=obh1x2meG0LGZACIhwzzj34cKrfGn3XJqSoVqVbF+oj6osG19hXvi4uV59tbgn2aMW
         KM1MFcLcyKIbqC3jmhrfELHZxcyiqT5dEolPJkO+owVkH7/DM/FM4JmlCBO8iImuNNyD
         dsDM0symFZ7UjbtGW6BS1jZaOZWiJK4DzmoLxJHZ8FbH8OCmXlK+ImhVslp1J/z4yFd6
         l+hCdU7wMRElNcjCLpxXqxJYN/lpZHXKSNYPwQRmORqgZ9Ucn951w3ho6bFgDvuB0ETy
         /xYFX6AMVN+W6QzLBVy4247/6lfpxgQexvmTvfZT8xm+C8bNIbYP7AVsgsRtbQDHQGmp
         B6zQ==
X-Gm-Message-State: AGi0PubD96HpD+MNRL0lqdNEGf+JB4Omz431UimQHjxxxCD/0nuBlhdj
        O6+NM2lMhJApDQDeNjj4u0hXHw==
X-Google-Smtp-Source: APiQypJeWRqP9iDhDf1jNiCXRuf5mXvCdy0pKJP/pq5t5y/BwYnRBjK6yqABQxZaq860YTwRrveEYQ==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr21481414wml.71.1586166819655;
        Mon, 06 Apr 2020 02:53:39 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b51c:42dc:1499:2880? ([2a01:e34:ed2f:f020:b51c:42dc:1499:2880])
        by smtp.googlemail.com with ESMTPSA id i2sm25867008wrx.22.2020.04.06.02.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 02:53:39 -0700 (PDT)
Subject: Re: [PATCH] thermal: core: Send a sysfs notification on trip points
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, vincent.whitchurch@axis.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <a7e8287d-72be-7ab0-697a-9de40eb3f81f@linaro.org>
 <20200402142116.22869-1-daniel.lezcano@linaro.org>
 <CAHLCerPOVouQfK4iqMc4xQpok=XTHj4d1hsLTsb9N5r=ZUBs8Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ea0a6c97-fe8e-d705-6ce9-b5ac60046d63@linaro.org>
Date:   Mon, 6 Apr 2020 11:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerPOVouQfK4iqMc4xQpok=XTHj4d1hsLTsb9N5r=ZUBs8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/04/2020 11:25, Amit Kucheria wrote:
> On Thu, Apr 2, 2020 at 7:53 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Currently the userspace has no easy way to get notified when a
>> specific trip point was crossed. There are a couple of
>> approaches:
>>
>> - the userspace polls the sysfs temperature with usually an
>> unacceptable delay between the trip temperature point crossing
>> and the moment it is detected, or a high polling rate with an
>> unacceptable number of wakeup events.
>>
>> - the thermal zone is set to be managed by an userspace governor
>> in order to receive the uevent even if the thermal zone needs to
>> be managed by another governor.
>>
>> These changes allow to send a sysfs notification on the
>> trip_point_*_temp when the temperature is getting higher than the
>> trip point temperature. By this way, the userspace can be
>> notified everytime when the trip point is crossed, this is useful
>> for the thermal Android HAL or for notification to be sent via
>> d-bus.
>>
>> That allows the userspace to manage the applications based on
>> specific alerts on different thermal zones to mitigate the skin
>> temperature, letting the kernel governors handle the high
>> temperature for hardware like the CPU, the GPU or the modem.
>>
>> The temperature can be oscillating around a trip point and the
>> event will be sent multiple times. It is up to the userspace to
>> deal with this situation.
>
> Thinking about this a bit more, userspace might want a
> notification when the temperature reduces and crosses the threshold
> on its way down too.
>
> Currently, we're only sending the notification on the way up. How
> should userspace know when to stop mitigation activity other than
> constantly polling the TZ temperature?

Assuming you want to monitor the temperature after a specific trip
point is reached:

 - the notification is sent way up

 - user space starts reading the temperature

 - the temperature goes below the trip point temperature

 - user space stops reading the temperature

Actually, I don't see the point of being notified and not read the
temperature after.

That is how is working the kernel side, especially with the interrupt
mode. The sensor fires an interrupt -> thermal zone update ->
temperature read -> trip point reached -> passive mode on ->
temperature polling -> temperature below trip point -> passive mode off.



>> The following userspace program allows to monitor those events:
>>
>> struct trip_data { int fd; int temperature; const char *path; };
>>
>
> [snip]
>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
