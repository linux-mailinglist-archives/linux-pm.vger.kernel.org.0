Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FFA1D1721
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 16:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbgEMOJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731192AbgEMOJz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 10:09:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA6AC061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 07:09:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p21so1975121pgm.13
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xF5kTHokLpYl2L1jlCgB/ZqtdDeVt/dOHQ6oLjNrJv4=;
        b=JtiwEOg2Oi7fR3mlQKHhEY/nSWgF1FKWs6se6f9pqIWXAOsilMm+iQjHW0jwIJNgHF
         LR7jn4MTG0YPtSEc/IFexbAd7SwkSwD/TsOEp6qFozFEI5+oZlHgTra/Yj7A7S3cbvs2
         8JOjYWDBFk2vyXbFRX/j5QXm7e9XdzjXg7spQ7KdMeljX1fC62rxfuDjIHCg1axI4ph+
         7Ey1w0K7oeM/bA+8wskw7zmfxW1f2pwizezW0lTTJuJsgvN+czLHrHDQzht2ACBcqJ6H
         EmoTY20kZ8kkLIDf57TkZZYXj5zvX9sqtR1NevJzVUs03HUkHLUWNOMHk/wmYC+vvFCN
         ijPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xF5kTHokLpYl2L1jlCgB/ZqtdDeVt/dOHQ6oLjNrJv4=;
        b=ZNHd/BAoF02L3BpNCwt6dNosgt98elaqnQEOOn+9bQJMhSn37jgm2zW4OD0jP+g/zw
         sambLVnxuET+VSRpdbUReyrEoVk1KEtYrMJSpoeYTupTrhsBPDtKX/dTH7f0VlYC/UF1
         Pz9cjCEKN4Wt03u24MZ0qXRRSzMsGsadSptnAiRoTc7X+BHgrHNOPoCWW0iRs22I0xcS
         Y5mD9xLZ70pVx3P3Jp2w2dPJha/uOyu3mRw+NDmCFLhvNgCA7xNyJ6RgWpXN/SKPWjhv
         Cy5DuXxLa0YbtBwUQQ0NHuhAoCYWpFg2xNov4G8raVxx2nuf4cuqf8VCxQDsCw1GehME
         bbsQ==
X-Gm-Message-State: AGi0PuaimY2nsFXEceOWCSE8o4373ebAvEQBz8nnopIZbm2Lu7QOI3oE
        dx6lHvcj8W4c3YzHPYXKyogh/vz9iR8=
X-Google-Smtp-Source: APiQypJWZjxmg3cfWMSwwV/KaUY6jzDD3nuw1t39553eg/F4RHwt9qkyFMQZhlNScIJjyeC17L0DBw==
X-Received: by 2002:aa7:979d:: with SMTP id o29mr26766917pfp.90.1589378994091;
        Wed, 13 May 2020 07:09:54 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:657d:4568:cffb:2c8a? ([2605:e000:100e:8c61:657d:4568:cffb:2c8a])
        by smtp.gmail.com with ESMTPSA id u45sm4691194pjb.7.2020.05.13.07.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 07:09:53 -0700 (PDT)
Subject: Re: 5.7 sleep/wake regression
To:     Chris Murphy <chris@colorremedies.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
 <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com>
 <CAJCQCtTxQw=P43wHM2ENX600Jm+BXU+f+=Wv09ijjiqWZoWsiQ@mail.gmail.com>
 <7163502.2kdGmH96AJ@kreacher>
 <CAJCQCtRAMgH4Qwfo7xqO2PQYedLSKBD9wmbj-T9aBvVYa2MGPQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4527188-5189-49f8-c776-74d47186fc35@kernel.dk>
Date:   Wed, 13 May 2020 08:09:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRAMgH4Qwfo7xqO2PQYedLSKBD9wmbj-T9aBvVYa2MGPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/13/20 12:11 AM, Chris Murphy wrote:
> On Tue, May 12, 2020 at 6:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> On Monday, May 11, 2020 7:37:04 PM CEST Chris Murphy wrote:
>>> On Mon, May 11, 2020 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
>>>>>
>>>>> Got an older Macbook Pro that does suspend to RAM and wake OK with
>>>>> 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
>>>>> it has a black screen, gets hot, fans go to high, and it turns into a
>>>>> hair dryer. So it's a regression.
>>>>
>>>> There is a known issue addressed by this patch:
>>>>
>>>> https://patchwork.kernel.org/patch/11538065/
>>>>
>>>> so can you please try it?
>>>
>>> Patch applied, but the problem remains.
>>>
>>> CPU is i7-2820QM and dmesg for the working sleep+wake case:
>>> https://paste.centos.org/view/ea5b913d
>>>
>>> In the failed wake case, I note the following: the fade-in/out sleep
>>> indicator light on the laptop is pulsing, suggests it did actually
>>> enter sleep OK. When waking by spacebar press, this sleep indicator
>>> light stops pulsing, the backlight does not come on, the laptop does
>>> not respond to either ssh or ping. Following  a power reset and
>>> reboot, the journal's last line is
>>>
>>> [   61.678347] fmac.local kernel: PM: suspend entry (deep)
>>>
>>> Let me know if I should resume bisect.
>>
>> Please first try to revert commit
>>
>> 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
>> objects for ASL create_field() operator")
> 
> Still fails. Bisect says
> 
> $ git bisect good
> b41e98524e424d104aa7851d54fd65820759875a is the first bad commit
> commit b41e98524e424d104aa7851d54fd65820759875a
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Feb 17 09:52:41 2020 -0700
> 
>     io_uring: add per-task callback handler

Yeah, it's definitely not that...

> I'm not that great at git bisect so I'm not sure how to narrow it
> down; offhand that doesn't seem a likely culprit.

How reliable is the test you use to deem a given commit good or
bad? It sucks in terms of time, but it may be useful to re-run
the bisection and ensure that you don't ever have false positives.

-- 
Jens Axboe

