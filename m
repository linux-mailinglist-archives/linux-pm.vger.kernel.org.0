Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81CE1D364B
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgENQTW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 12:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgENQTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 12:19:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4478BC061A0C
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 09:19:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b8so1427103pgi.11
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IZFq+OV8X9ybJ95xPcu20VKH4NTXwjmArng6i1uk+WE=;
        b=kNJfl4wEGLC+9STQi+GaSMazNyX52OxiJfk8zL6ULWz7vECrLDJ7l9ufY/bmulavc8
         sxfOV8FRFS1XhJcI9r6Zi5tXefkcKlJ5snm0FO38awYr/5AYMBW22rmfdFddmaJD3UfQ
         PH9N4RnyHVkr6LfGT8cR4N85CAZks4SzTV4/i/wm7eNn0Q8ce1N7+Ggr0Low0RyAeqGV
         kh693L1voUxCnC4CP3PDmXmW81sqbzTuf+NQwi2olbjSIIP0GTqglJhAQEOMBO2mTegZ
         POfWW0/eug6Jlbn2Krd3fWjyCyjXsxMYgLRIvAUaMMyfRtCHDRXgc53/XRh3+F8p+d+b
         nn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IZFq+OV8X9ybJ95xPcu20VKH4NTXwjmArng6i1uk+WE=;
        b=ASMVn85OxyIO4Qa/mnppsBNPEMsuUSyKaopIOxdJhDrdDzDs9mqKj+RHLdc5S3dQVM
         9y8svJJOruOh5I9OvdCzkV1LekyPLG2VcFJJEG1ys7SK5mKe9iLz3y98IkjpFsyK8lbp
         6243h/DDouYajN+D9pLOiuDMDBTrW39mpLaeplX2ndc33h4lOLATL8cKD8Aofq4xLW4d
         FpojdZt1yeaDVXnKzodhUmSCS5LLMUOWnVw7YNZrm/h3j6x9DK8Q4iHZjkF6iETQCnt1
         J+W0k07068pnSL6dl21LvMm5L7hPHDAHhZMBV/C5QafD2A8VEn7tcgx0sjdIlffDzeOB
         W5pQ==
X-Gm-Message-State: AOAM53258syeoXwTZnJT5lAeifDBvHhTbyaNvRFSv3d/BfAgoZnH8cw8
        FPHAZmSlncC9ROb5J5hAUmzPRE/LtDU=
X-Google-Smtp-Source: ABdhPJwN0Eq01nw6ktwJDVuLM1E1+55Q/h4lhDGWm4L4J4BtkyQXRU8mQf0VXlPv5REobU/rvdmx4w==
X-Received: by 2002:a65:5287:: with SMTP id y7mr4512138pgp.86.1589473160033;
        Thu, 14 May 2020 09:19:20 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:85e7:ddeb:bb07:3741? ([2605:e000:100e:8c61:85e7:ddeb:bb07:3741])
        by smtp.gmail.com with ESMTPSA id k6sm1785515pfp.111.2020.05.14.09.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 09:19:18 -0700 (PDT)
Subject: Re: 5.7 sleep/wake regression
To:     Chris Murphy <chris@colorremedies.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
 <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com>
 <CAJCQCtTxQw=P43wHM2ENX600Jm+BXU+f+=Wv09ijjiqWZoWsiQ@mail.gmail.com>
 <7163502.2kdGmH96AJ@kreacher>
 <CAJCQCtRAMgH4Qwfo7xqO2PQYedLSKBD9wmbj-T9aBvVYa2MGPQ@mail.gmail.com>
 <b4527188-5189-49f8-c776-74d47186fc35@kernel.dk>
 <CAJCQCtTMWGwiH5ztmV+w3PHhQdr8XO_909Jqf-nCiNc6sJURDg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aee1f1df-39c2-0b3c-a3cb-fab648cc3f3a@kernel.dk>
Date:   Thu, 14 May 2020 10:19:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTMWGwiH5ztmV+w3PHhQdr8XO_909Jqf-nCiNc6sJURDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/14/20 10:02 AM, Chris Murphy wrote:
> On Wed, May 13, 2020 at 8:09 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 5/13/20 12:11 AM, Chris Murphy wrote:
>>> On Tue, May 12, 2020 at 6:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>
>>>> On Monday, May 11, 2020 7:37:04 PM CEST Chris Murphy wrote:
>>>>> On Mon, May 11, 2020 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
>>>>>>>
>>>>>>> Got an older Macbook Pro that does suspend to RAM and wake OK with
>>>>>>> 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
>>>>>>> it has a black screen, gets hot, fans go to high, and it turns into a
>>>>>>> hair dryer. So it's a regression.
>>>>>>
>>>>>> There is a known issue addressed by this patch:
>>>>>>
>>>>>> https://patchwork.kernel.org/patch/11538065/
>>>>>>
>>>>>> so can you please try it?
>>>>>
>>>>> Patch applied, but the problem remains.
>>>>>
>>>>> CPU is i7-2820QM and dmesg for the working sleep+wake case:
>>>>> https://paste.centos.org/view/ea5b913d
>>>>>
>>>>> In the failed wake case, I note the following: the fade-in/out sleep
>>>>> indicator light on the laptop is pulsing, suggests it did actually
>>>>> enter sleep OK. When waking by spacebar press, this sleep indicator
>>>>> light stops pulsing, the backlight does not come on, the laptop does
>>>>> not respond to either ssh or ping. Following  a power reset and
>>>>> reboot, the journal's last line is
>>>>>
>>>>> [   61.678347] fmac.local kernel: PM: suspend entry (deep)
>>>>>
>>>>> Let me know if I should resume bisect.
>>>>
>>>> Please first try to revert commit
>>>>
>>>> 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
>>>> objects for ASL create_field() operator")
>>>
>>> Still fails. Bisect says
>>>
>>> $ git bisect good
>>> b41e98524e424d104aa7851d54fd65820759875a is the first bad commit
>>> commit b41e98524e424d104aa7851d54fd65820759875a
>>> Author: Jens Axboe <axboe@kernel.dk>
>>> Date:   Mon Feb 17 09:52:41 2020 -0700
>>>
>>>     io_uring: add per-task callback handler
>>
>> Yeah, it's definitely not that...
>>
>>> I'm not that great at git bisect so I'm not sure how to narrow it
>>> down; offhand that doesn't seem a likely culprit.
>>
>> How reliable is the test you use to deem a given commit good or
>> bad? It sucks in terms of time, but it may be useful to re-run
>> the bisection and ensure that you don't ever have false positives.
> 
> 100%. This laptop never fails to wake from S3. Dozens of sleep/wake
> cycles on 5.6, 5.5, going way back. It's 100% fail on all 5.7 rc's.

Reason I ask is unless you're active using io_uring, then there's way
that the io_uring commit is implicated in this particular issue.  And
that would lead me to believe that perhaps there's some false positives
here, where you sometimes resume fine with the broken commit there. This
would skew your bisection results, and ultimately result in a bogus
result.

Hence my suggestion would be to redo the bisection, and perhaps do more
suspend+wake cycles on each commit to be sure that you're definitely
going to flag the offending commit every time.

-- 
Jens Axboe

