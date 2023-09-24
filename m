Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759337AC715
	for <lists+linux-pm@lfdr.de>; Sun, 24 Sep 2023 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjIXH6V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Sep 2023 03:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjIXH6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Sep 2023 03:58:20 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C658C6
        for <linux-pm@vger.kernel.org>; Sun, 24 Sep 2023 00:58:14 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b5ef5b947so2614009eaf.0
        for <linux-pm@vger.kernel.org>; Sun, 24 Sep 2023 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695542293; x=1696147093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mTo7f1CgCZkEUanJg3zmzN0/UjYYMcy+TzrKDm8eNg8=;
        b=AcHEf1orQNrQUEcslQgJE6CusKoh/VSAK9TKr209PtpgBHl+TgAE3Z5iiimxwK1bJF
         tfuNYE45vzIJrnbFO1OeJKa/u6braJSnIPXKrKTdPAcDAZ1iM7XPpDpO0x1CkUKJQ6Oh
         EDL8Z/8nLkbg8rY1VRhFkxxqxsAlRLc2Uc0ZZrqzHNg7nZHJUsxMIYM2E/TA7iMOrXwr
         OP7MlpQ7m8FDTu/wkRai3Fx4z8L7sza/HCHszfmpR3PfOlZIuqCSg8joEKwsmfQIN1S2
         /wNcZuoyp+uIJt0/mzMy0mOlW1LWL5/4wb7mm+iVBhMPRNk0Z/55VY3dSojQgihsaMML
         rx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695542293; x=1696147093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTo7f1CgCZkEUanJg3zmzN0/UjYYMcy+TzrKDm8eNg8=;
        b=d9YLLBWaXIGNE/5XjTRV5UedNQ6jc5B4tqG/tvNkCAXAp4j3gXWToIzhny/TxYaqr0
         1RdHJCq8Hz5zMUj+dagKbvgi6pW1NcxX0pUE8b/fg7zOOjbjVM8Lknvp1oLI7gWBmsJH
         /hEjgeP58Td2roYnM1F+TwxD/PATa3k+oWK4ipibbfEgi+8Mi/OZlat4cQupkPvuGbvu
         uaBLV9esMzTKL4tQdD1jvkihkSP4uaLr7BOViGKTDV8E3XusvUWXjyISz7Ww2mWzAyw5
         jEiTiFWAjvEsDAwSm9tMUXyCbYxE7KL7/G/wwhXQTfyIdhdw8gVZ1i7mQPL6UAjTKFev
         C3dw==
X-Gm-Message-State: AOJu0YyxpQClkh2FOFrxZnW3pnN3OIBadK+N3GX1RpF4WjSIpAKoltKG
        9QQB1iUYwb6Gmblzdd6XT4w87Z1PNntFRTA9rJRdUA==
X-Google-Smtp-Source: AGHT+IEH5NKnQPK0DsnFu7JqpJsmcimqSaaxI7U3Ei495dDre5bN+1pgHkJqkVLyIdzLMY8qp6EAxixVcWSuIryTnjk=
X-Received: by 2002:a05:6358:41a1:b0:143:8574:4311 with SMTP id
 w33-20020a05635841a100b0014385744311mr5247958rwc.12.1695542293162; Sun, 24
 Sep 2023 00:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230820210640.585311-1-qyousef@layalina.io> <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
 <20230829163740.uadhv2jfjuumqk3w@airbuntu> <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu> <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
 <20230910174638.qe7jqq6mq36brh6o@airbuntu> <CAKfTPtBFAXO=CgqSJ1+y=2ppb5t4oErCtvV336fS6J2nSjBCkQ@mail.gmail.com>
 <20230916192509.bportepj7dbgp6ro@airbuntu>
In-Reply-To: <20230916192509.bportepj7dbgp6ro@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 24 Sep 2023 09:58:01 +0200
Message-ID: <CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 16 Sept 2023 at 21:25, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 09/12/23 18:03, Vincent Guittot wrote:
>
> > And it seems that what is done today doesn't work correctly for you.
> > Your proposal to include cpufreq headroom into the scheduler is not
> > correct IMO and it only applies for some cases. Then, the cpufreq
> > driver can have some really good reason to apply some headroom even
> > with an uclamp value but it can't make any decision.
> >
> > I think that we should use another way to fix your problem with how
> > uclamp than reordering how headroom is applied by cpufreq. Mixing
> > utilization and performance in one signal hide some differences that
> > cpufreq can make a good use of.
> >
> > As an example:
> >
> > cfs util = 650
> > cfs uclamp = 800
> > irq = 128
> >
> > cfs with headroom 650*1.25=812 is clamped to 800
> >
> > Final utilization will be : 800(1024-128)/1024+128*1.25=860 which is
> > above the target of 800.
> >
> > When we look at the detail, we have:
> >
> > cfs util once scaled to the full range is only 650(1024-128)/1024= 568
> >
> > After applying irq (even with some headroom) 568+128*1.25 = 728 which
> > is below the uclamp of 800 so shouldn't we stay at 800 in this case ?
>
> Shouldn't it be (568+128)*1.25 = 870? Which is almost the 860 above. We calmped
> the 812 to 800, with rounding errors that almost accounts for the 10 points
> difference between 870 and 860..

no I voluntarily use 568 + 128*1.25. I added dvfs headroom for irq
just to ensure that you will not raise that I removed the headroom for
irq and focus on the use case but it might have created more
confusion.

My example above demonstrate that only taking care of cases with null
irq pressure is not enough and you can still ends up above 800

IIUC you point with uclamp_max. It is a performance limit that you
don't want to cross because of CFS.This means that we should not go
above 800 in my example because of cfs utilization: Irq needs between
128 and CFS asks 568 so the system needs 696 which is below the 800
uclamp. Even if you add the dvfs headroom on irq, the system is still
below 800. Only when you add dfvs headroom to cfs then you go above
800 but it's not needed because uclamp say that you should not go
above 800 because of CFS so we should stay at 800 whereas both current
formula and your new formula return a value above 800

>
> I might have gotten the math wrong. But what I saw is that we have
>
>         util = (X + Y + Z) * A
>
> and what I did
>
>         util = AX + AY + AZ
>
> so maybe I missed something up, but I just did the multiplication with the
> headroom to each element individually rather than after the sum.
>
> So yeah, if I messed that part up, then that wasn't intentional and should be
> done differently. But I still can't see it.
>
> > >
> > > The main change being done here actually is to apply_dvfs_headroom() *before*
> > > doing uclamp_rq_util_with(). I am not sure how you see this mixing.
> >
> > Because dvfs_headroom is a cpufreq hints and you want to apply it
> > somewhere else.
>
> I am still not sure if you mean we are mixing up the code and we need better
> abstraction or something else.
>
> Beside the abstraction problem, which I agree with, I can't see what I am
> mixing up yet :( Sorry I think I need more helping hand to see it.

There is a mix between actual utilization and performance limit and
when we add both we then lose important information as highlighted by
my example. If the current formula is not correct because we can go
above uclamp_max value, your proposal is not better. And the root
cause is mainly coming from adding utilization with performance limit
(i.e. uclamp)

That's why I said that we need a new interface to enable cpufreq to
not blindly apply its headroom but to make smarter decision at cpufreq
level


>
> > > Current code performs apply_dvfs_headroom() *after*; which what causes the CPU
> > > to run at a performance level higher than rq->uclamp[UCLAMP_MAX].
> > >
> > > It doesn't matter how many tasks on the rq, if rq->uclamp[UCLAMP_MAX] is set to
> > > 800, then the CPU should not vote to max (assuminig all other pressures are 0).
> >
> > You can't remove the irq pressure from the picture. If
> > rq->uclamp[UCLAMP_MAX] is set to 800 means that cpu must not go above
> > 800, it should apply also after taking into account other inputs. At
> > least up to some level as described in my example above
>
> I was trying to simplify to understand what you mean as I don't think I see the
> problem you're highlighting still.
>
>
> Thanks!
>
> --
> Qais Yousef
