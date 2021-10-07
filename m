Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F544250C6
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbhJGKNV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 06:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbhJGKNP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 06:13:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD0DC061746;
        Thu,  7 Oct 2021 03:11:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y26so22938019lfa.11;
        Thu, 07 Oct 2021 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gAsO5CGDd+Gl/+s+z+h8owFe4pxvJKVtZk+XjdJj9Hg=;
        b=JpI+ZgQThl3v74t8a5dCSw2TfKJCMMwkfXdQTKZ3mz21GBvG1s+0LvJAYoTkUj2iu1
         vtvflnbnIhWaQwrfPL5UIRs71n1tf3JJvnXJ5jWwdxyUJ+kc0X1dLxbSawE3rwmEEjYu
         EiLyCzpLQ1hxPlVrpcf1ykwNfMiOUrN/6LD3DQyanR29+2SkAZQOqjIJG7TSjolOO8xq
         oxYX7BNQKwsrPcbpsVTtWqfxJ+PQkVqBBai4W2Uc//UV3W/kWOpxmBF11RHQjD/cLTv6
         YljLfnt2e1vdrE4a7RQ4bSZYiiQpOYF1Knk2BBSjVGNqMfKTRYvdcpw1oqTMQBxthdOV
         eukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gAsO5CGDd+Gl/+s+z+h8owFe4pxvJKVtZk+XjdJj9Hg=;
        b=QVI9zF6N71OwGH0ssm4LjCsATQEJCfadkTmCdBhWD5GPi74K+nhE1lv7bLd5uynbfe
         dLJopQJkEv1pVcU3DJY1SGkaNUVnAhAN0E9vLrMIv1j5eN13iVMcsuJ6JF6DNZEqya/r
         dhJuAnuGXWZqu0kRKu3RqYnEf8OynNXSsCBVEHLwLfuMfTUEoryfil5fVM8pkvBJa/nf
         xr44e6DHbzqZ7DIl7M9IR/hqdpU4XRs9BpQfd0T5IWPeqTJVak5ouGcB6LvC3/WN+fo2
         0w/tQvw1Zs/zf+AD7P0ayirphuLVYd7VgdbBSbuNwgVd10uIOvPzNeof/d/J/lGq5Row
         XeDA==
X-Gm-Message-State: AOAM530NHODXB2xo5XMuThLAVRFnpXOVIynKFkIR22DZNXmac7zBybp/
        Dcch+wYibUyRkvBsyPKceKSyBovMjkU=
X-Google-Smtp-Source: ABdhPJzS/9lNiRXorykyaMPF2frSJSeqRPBB2y8Ryzu2InchB+s0YRrpJax64rfsMScVWYkoSgckiw==
X-Received: by 2002:a2e:a7d5:: with SMTP id x21mr3670821ljp.8.1633601480253;
        Thu, 07 Oct 2021 03:11:20 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.googlemail.com with ESMTPSA id f4sm2507075lfr.43.2021.10.07.03.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 03:11:19 -0700 (PDT)
Subject: Re: [PATCH v1 0/6] Introduce power off call chain API
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20211007060253.17049-1-digetx@gmail.com>
 <CAHp75VeHC5M-Rv+wvJQEvmtfX0k7fP6uremGHFMnd8kEqPnBpw@mail.gmail.com>
 <e7763b75-205c-4e9f-ecdc-a32571a4b822@gmail.com>
 <YV65qsQPtQfWvE9W@smile.fi.intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <54c7b83e-22ae-2521-1f44-ec9b2e21464e@gmail.com>
Date:   Thu, 7 Oct 2021 13:11:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV65qsQPtQfWvE9W@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.10.2021 12:11, Andy Shevchenko пишет:
> On Thu, Oct 07, 2021 at 11:52:46AM +0300, Dmitry Osipenko wrote:
>> 07.10.2021 10:18, Andy Shevchenko пишет:
>>> On Thu, Oct 7, 2021 at 9:05 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> 
> ...
> 
>>>> This
>>>> is a somewhat simplified version which doesn't try to convert whole kernel
>>>> to the new API at once, but solves immediate practical problem that we
>>>
>>> problems
>>>
>>>> have on Nexus 7 Android tablet where device needs to chain power off
>>>
>>> tablets where the device
>>
>> Thank you for the corrections, so far there is one problem and one tablet :)
> 
> Then use "the Nexus 7 Android tablet" :-)
> 
>>> Immediate question here is how do you see the plan of spreading this.
>>> I.o.w. can you put an explanation that you have checked, let's say
>>>> 80% current users, and they may be converted like [example
>>> placeholder] without any special tricks?
>>
>> The rough plan is:
>>
>> 1. Add new API.
>> 2. Convert drivers to the new API per subsystem.
> 
> I would suggest to show that you are actually into it by converting a couple of
> the subsystems for the starter.

Noted

>> 3. Expose do_kernel_restart().
>> 4. Replace pm_power_off() with do_kernel_poweroff() per arch/, making
>> power off similar to the restart that uses do_kernel_restart().
>> 5. Remove do_kernel_restart() from kernel/reboot.c
>>
>> Majority of pm_power_off() users shouldn't need the chaining and
>> pm_power_off() doesn't conflict with the new API, so there is no need to
>> rush the conversion.
>>
>> The single-link chain users could be converted to the new API directly,
>> this will remove some global variables. But at first should be better to
>> gain more users who actually need the chained power off since they may
>> have very specific requirements not covered by the current variant of
>> the API and will be easier to evolve API with less users.
> 
> All above in one or another form should be in cover letter.

Alright, apparently I overestimated a tad awareness about the current
status. I'll extend the cover letter next time, thanks.
