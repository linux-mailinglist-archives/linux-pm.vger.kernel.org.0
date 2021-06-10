Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0710D3A2BCD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 14:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFJMnl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 08:43:41 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37452 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhFJMnl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 08:43:41 -0400
Received: by mail-lf1-f42.google.com with SMTP id p7so3026385lfg.4
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9GTMqOXMzmRTvDvHxm6+Se4ETluKcj7GUfbg2SHXm8=;
        b=aOwKXTB+xjFL+Z+W9pzjvMPI0ondEQou4VIrrwycbLhvR3HJW4ArPNNko0VQlAPdbo
         XQHmUSFLlTGnrShlUGSZWa1RtGx3px//lOuTRyrY3daR8HLFWi+Ey89ge7QEapv4zjrg
         +7zbb1BxAZ2NPAZ6qBhdXqx8N2SflSCeCxBLEACF9D0sC/FYIFxXgLAc0F74tbuD5oAr
         twKkYxQqqyuTH2kjQ2luX64gjhXjvEAYYtb4xZVwecx6rPdgQZU6JLJu96u14roLnw6N
         OnIH5ffDKwvJv57Qg731VTDnTYODKaKr32O1du3BiFQFBW3hlAy37cs9xiBImbf2ZVR1
         Mfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9GTMqOXMzmRTvDvHxm6+Se4ETluKcj7GUfbg2SHXm8=;
        b=Kgy7Ki+y58jDXOPupn2IawGlCWf4xMz2HJN28KKDar3XDf8GDDryo9VsCe2g9RwVzE
         sgkqkeYB6EmDxAJlg/4J7GmCX0O4GTQwwWzjmAJk0Hgv0IKvKj7R046HsVkSCoOyav5F
         53rZQiH3E9eS89DAhBVlszSaQOerj1pUdU1Q0snuShHgkhhllC0X3XpreU2UCe5d41fG
         Z/Y27tK8NhzuoRxm3LCrnFlK5M6RvgUT0xuYnMUGcP6LTrOB/jFAojc+35OrTdIaXpd7
         QtiHxv8ZyuDRTEcBfrZoBPR31t9JetJ2BM/4/Cq2d6/FUgi73jjQ8WiVUZ0T09rdTNxR
         qeKQ==
X-Gm-Message-State: AOAM5314RwMik3m/3sqEzAPcUAhu6Y/WaesVC2ar/8uH3E7peBGT6w5Q
        JoDQU7LhUTL74NMGe3Y+Ea0YMDynv3HNZnauUTh7jA==
X-Google-Smtp-Source: ABdhPJzqqRmuWZBnW38f20ywqx99Uh+wq0Jh0gy0oyNQUNhdETu33NoyHJsnUGF72Kkc7eYhHO0PkOiUrOPyYSqhOzA=
X-Received: by 2002:ac2:5fc7:: with SMTP id q7mr1839577lfg.286.1623328844135;
 Thu, 10 Jun 2021 05:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210604080954.13915-1-lukasz.luba@arm.com> <20210604080954.13915-2-lukasz.luba@arm.com>
 <2f2fc758-92c6-5023-4fcb-f9558bf3369e@arm.com> <905f1d29-50f9-32be-4199-fc17eab79d04@arm.com>
 <3cfa5690-644b-ba80-3fc3-7c5a3f292e70@arm.com> <c77d00b9-d7a3-0e8a-a528-ab0c1773496f@arm.com>
 <CAKfTPtAc62gyjxSiSY2vD_qr-WjqbC91_GF-LXgNXh8T0Xx-yw@mail.gmail.com> <d4383b7a-a5e7-18ca-14ed-c533b4d43f62@arm.com>
In-Reply-To: <d4383b7a-a5e7-18ca-14ed-c533b4d43f62@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jun 2021 14:40:32 +0200
Message-ID: <CAKfTPtBD2qa3qwpoLuLNuF-hZAGpDvsahx6Tx_enLT2DAs4fiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Jun 2021 at 14:30, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/10/21 1:19 PM, Vincent Guittot wrote:
> > On Thu, 10 Jun 2021 at 12:37, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 6/10/21 11:07 AM, Dietmar Eggemann wrote:
> >>> On 10/06/2021 11:04, Lukasz Luba wrote:
> >>>>
> >>
> >> [snip]
> >>
> >>>> Not always, it depends on thermal governor decision, workload and
> >>>> 'power actors' (in IPA naming convention). Then it depends when and how
> >>>> hard you clamp the CPUs. They (CPUs) don't have to be always
> >>>> overutilized, they might be even 50-70% utilized but the GPU reduced
> >>>> power budget by 2 Watts, so CPUs left with only 1W. Which is still OK
> >>>> for the CPUs, since they are only 'feeding' the GPU with new 'jobs'.
> >>>
> >>> All this pretty much confines the usefulness of you proposed change. A
> >>> precise description of it with the patches is necessary to allow people
> >>> to start from there while exploring your patches.
> >>
> >> OK, I see your point.
> >>
> >> [snip]
> >>
> >>>> True, I hope this description above would help to understand the
> >>>> scenario.
> >>>
> >>> This description belongs in the patch header. The scenario in which your
> >>> functionality would improve things has to be clear.
> >>> I'm sure that not everybody looking at this patches is immediately aware
> >>> on how IPA setups work and which specific setup you have in mind here.
> >>
> >> Agree. I will add this description into the patch header for v3.
> >>
> >> [snip]
> >>
> >>>>
> >>>> Yes, this code implementation tries to address those issues.
> >>>
> >>> The point I was making here is: why using the PELT signal
> >>> thermal_load_avg() and not per_cpu(thermal_pressure, cpu) directly,
> >>> given the fact that the latter perfectly represents the frequency clamping?
> >>>
> >>
> >> Good question. I wanted to be aligned with other parts in the fair.c
> >> like cpu_capacity() and all it's users. The CPU capacity is reduced by
> >> RT, DL, IRQ and thermal load avg, not the 'raw' value from the
> >> per-cpu variable.
> >>
> >> TBH I cannot recall what was the argument back then
> >> when thermal pressure geometric series was introduced.
> >> Maybe to have a better control how fast it raises and decays
> >> so other mechanisms in the scheduler will see the change in thermal
> >> as not so sharp... (?)
> >>
> >>
> >> Vincent do you remember the motivation to have geometric series
> >> in thermal pressure and not use just the 'raw' value from per-cpu?
> >
> > In order to have thermal pressure  synced with other metrics used by
> > the scheduler like util/rt/dl_avg. As an example, when thermal
> > pressure will decrease because thermal capping is removed, the
> > utilization will increase at the same pace as thermal will decrease
> > and it will not create some fake spare cycle. util_avg is the average
> > expected utilization of the cpu, thermal pressure reflects the average
> > stolen capacity for the same averaging time scale but this can be the
> > result of a toggle between several OPP
> >
> > Using current capping is quite volatile to make a decision as it might
> > have changed by the time you apply your decision.
> >
>
> So for this scenario, where we want to just align EAS with SchedUtil
> frequency decision, which is instantaneous and has 'raw' value
> of capping from policy->max, shouldn't we use:
>
> thermal_pressure = arch_scale_thermal_pressure(cpu_id)

Yes you should probably use arch_scale_thermal_pressure(cpu) instead
of thermal_load_avg(rq) in this case



>
> instead of geometric series thermal_pressure signal?
>
> This would avoid the hassling with idle CPUs and not updated
> thermal signal.
