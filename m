Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABEF401CCF
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbhIFOMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 10:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243169AbhIFOMf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 10:12:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6A1C061575;
        Mon,  6 Sep 2021 07:11:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f2so11598490ljn.1;
        Mon, 06 Sep 2021 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZggPjhx+8+aupkWFSxcS4wLcFNjdVmDJ+q9FbeStYM=;
        b=SENtr9O3Gx326nfrYlnyImNgmBzsv3Vtsvg9RfVcQ3HjaOkbL5JzZ25JAD16EbT4vl
         dWBiOKf4wtOUnbtqdSvKFUG1BpR9WyIluCpOifosq/O47vHh5KVBNpxbdE1BenGzkQHU
         /sGO+mBwXFAPScj/O6wDTW6QhCHF1baQFbMm4YgvMNG7TN4n0HhmtXwEnj0CVP3Xtfb1
         zaExjV4OLZDRgtp/aRe1OOF3zIfV49Bj5NZt8GYJC+vNtqUdiTCCmapJP4dqJZbuf6yP
         eQm1oow9QcvPnRhIM7MIVIz/MU1DsY4tmTu+TJ2GCWf4Mkc0e0hqDCBYT7MZKQR5gXkJ
         0pWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZggPjhx+8+aupkWFSxcS4wLcFNjdVmDJ+q9FbeStYM=;
        b=OWxfPcoFOiqQnR17Z9Di1sLNJfgLDO/NQVKqEH30b2EiRlwhUW7zGOa4pVyvFtg2ba
         xYTZ+SnhDx4R6wenNRG8uynYL67xmzQq56tkJOFxCuev2YkNc0p7CBnhhhaOZpWnkQfa
         mVVPM9ONWGJIzg1vla8HmI9qlEGXFOUKjYJ6HsxBbweaaxFsKjS0/LJ2LhuG8P4tGdbl
         a+Y7VLgTxDPGZDBYrwBTsVvfY/5aheLo8K01+WiUgt4jZbcTz61lZtz9zcUD/sywD15T
         Y3cOKXE6YsQhCGWTeHuIXeZ0TGGahB1U6DoTaPKEL8LbwdFiKyryoqrK+4U30OVngvyJ
         xRiA==
X-Gm-Message-State: AOAM531Mpn0zGYQOp2I3Xw5zFUt5uimv84bQC0h02fnZHtH0WFLIXeVG
        vo5nvX+nHi1MPOP7Mm8XQFZx0sAxzdE=
X-Google-Smtp-Source: ABdhPJzF5abV/WMXCGDW39/7j4zAz5FxR8KMOu7LYg7zcHQU0Wkq1Ug4jb1JInQVjCIgGrSq6W9Lng==
X-Received: by 2002:a05:651c:10a2:: with SMTP id k2mr11353085ljn.262.1630937488606;
        Mon, 06 Sep 2021 07:11:28 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id t20sm756427lfk.157.2021.09.06.07.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 07:11:27 -0700 (PDT)
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org>
 <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
 <CAPDyKFofrEj2LdqXh-L256b2Tcz=qYQgzTUBVuvx0rOR58SrVg@mail.gmail.com>
 <b597c805-e346-8c23-5014-cbb116e88075@gmail.com>
 <CAPDyKFrWofUKhbhvwTCjiFwJD8-Pzi8UMzU7ZjYLKm2j1HeeBg@mail.gmail.com>
 <6603212d-f36c-afff-6222-8125de5b7b79@gmail.com>
 <CAPDyKFoyszG2Wo3jbXK562XgpqXns_GPqm7nNu8WOdMCXYUOMQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <66fbbc69-3e16-e07c-4e25-48d59d69fd3c@gmail.com>
Date:   Mon, 6 Sep 2021 17:11:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoyszG2Wo3jbXK562XgpqXns_GPqm7nNu8WOdMCXYUOMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

06.09.2021 13:24, Ulf Hansson пишет:
> On Sun, 5 Sept 2021 at 10:26, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 03.09.2021 17:03, Ulf Hansson пишет:
>>> On Fri, 3 Sept 2021 at 11:58, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 03.09.2021 11:22, Ulf Hansson пишет:
>>>>> On Fri, 3 Sept 2021 at 08:01, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>>
>>>>>> 02.09.2021 13:16, Ulf Hansson пишет:
>>>>>>> When a device is detached from its genpd, genpd loses track of the device,
>>>>>>> including its performance state vote that may have been requested for it.
>>>>>>>
>>>>>>> Rather than relying on the consumer driver to drop the performance state
>>>>>>> vote for its device, let's do it internally in genpd when the device is
>>>>>>> getting detached. In this way, we makes sure that the aggregation of the
>>>>>>> votes in genpd becomes correct.
>>>>>>
>>>>>> This is a dangerous behaviour in a case where performance state
>>>>>> represents voltage. If hardware is kept active on detachment, say it's
>>>>>> always-on, then it may be a disaster to drop the voltage for the active
>>>>>> hardware.
>>>>>>
>>>>>> It's safe to drop performance state only if you assume that there is a
>>>>>> firmware behind kernel which has its own layer of performance management
>>>>>> and it will prevent the disaster by saying 'nope, I'm not doing this'.
>>>>>>
>>>>>> The performance state should be persistent for a device and it should be
>>>>>> controlled in a conjunction with runtime PM. If platform wants to drop
>>>>>> performance state to zero on detachment, then this behaviour should be
>>>>>> specific to that platform.
>>>>>
>>>>> I understand your concern, but at this point, genpd can't help to fix this.
>>>>>
>>>>> Genpd has no information about the device, unless it's attached to it.
>>>>> For now and for these always on HWs, we simply need to make sure the
>>>>> device stays attached, in one way or the other.
>>>>
>>>> This indeed requires to redesign GENPD to make it more coupled with a
>>>> device, but this is not a real problem for any of the current API users
>>>> AFAIK. Ideally the state should be persistent to make API more universal.
>>>
>>> Right. In fact this has been discussed in the past. In principle, the
>>> idea was to attach to genpd at device registration, rather than at
>>> driver probe.
>>>
>>> Although, this is not very easy to implement - and it seems like the
>>> churns to do, have not been really worth it. At least so far.
>>>
>>>>
>>>> Since for today we assume that device should be suspended at the time of
>>>> the detachment (if the default OPP state isn't used), it may be better
>>>> to add a noisy warning message if pstate!=0, keeping the state untouched
>>>> if it's not zero.
>>>
>>> That would just be very silly in my opinion.
>>>
>>> When the device is detached (suspended or not), it may cause it's PM
>>> domain to be powered off - and there is really nothing we can do about
>>> that from the genpd point of view.
>>>
>>> As stated, the only current short term solution is to avoid detaching
>>> the device. Anything else, would just be papering of the issue.
>>
>> What about to re-evaluate the performance state of the domain after
>> detachment instead of setting the state to zero?
> 
> I am not suggesting to set the performance state of the genpd to zero,
> but to drop a potential vote for a performance state for the *device*
> that is about to be detached.

By removing the vote of the *device*, you will drop the performance
state of the genpd. If device is active and it's wrong to drop its
state, then you may cause the damage.

> Calling genpd_set_performance_state(dev, 0), during detach will have
> the same effect as triggering a re-evaluation of the performance state
> for the genpd, but after the detach.

Yes

>> This way PD driver may
>> take an action on detachment if performance isn't zero, before hardware
>> is crashed, for example it may emit a warning.
> 
> Not sure I got that. Exactly when do you want to emit a warning and
> for what reason?
> 
> Do you want to add a check somewhere to see if
> 'gpd_data->performance_state' is non zero - and then print a warning?

I want to check the 'gpd_data->performance_state' from the detachment
callback and emit the warning + lock further performance changes in the
PD driver since it's a error condition.
