Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D93BA2E4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhGBPta (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jul 2021 11:49:30 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:40666 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhGBPta (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jul 2021 11:49:30 -0400
Received: by mail-oi1-f178.google.com with SMTP id l26so9166949oic.7
        for <linux-pm@vger.kernel.org>; Fri, 02 Jul 2021 08:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cVOUxWNsxbRD4WYy8Ms+uDIWeOHULoybsFCCTBRdoA=;
        b=d9c9wHsrK2ZxSqBbi0ukYM7TNy5sVJdb61rz3Y2ezEVoRcjSjdiAuJExZ2/Ov9RN2C
         LvD0oWSWZ+ae8/adTY7dJd0rLRoS2K5/s8BNT5NgDWI5Cl297Qzn9jexPz5wHVDDrEmK
         cK4YbcJ+1oBPyXBp5p0eBoxhkVKG3T2rhxdws3+79AbLyH17IryvEGAHfTULM+JcxaBg
         2hEFy3p2ulZs80zDf8TM9brEV7n9d5G8lQThzn7B02FvbaBYEShIx0t6dTUVmvYslIk4
         vwX2wr8p6cxS0gxdeJ9KQdZWc0tuiLUfse+8S7Bc2ArM9v982UUHy+RMofnpkllJmgJP
         Bhrw==
X-Gm-Message-State: AOAM530CQnRt5qVtJY9+eUBllm90nHLEPEqMletMx49hvnLcoQniGu02
        GjzsLYMBGITfoUkpbpOhjTLdqG3Sc3vaojyC0wU=
X-Google-Smtp-Source: ABdhPJyIDWyZtc0OrGhc9QtHsJv2YqNBQK+fhRO7XcSAnkvxIhV4GrNF9sxkrYkPdmuRaAOuYoVfaNDrJKaftSHPEZg=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr337989oiw.157.1625240816611;
 Fri, 02 Jul 2021 08:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210614072835.z2tjoaffcflry7pk@vireshk-i7> <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7> <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
 <20210615101706.mabloqrmakeiwcf5@vireshk-i7> <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
 <20210616073500.b5wazdssoa5djp5o@vireshk-i7> <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
 <20210616093127.lfpi4rje56b3dhwx@vireshk-i7> <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com>
 <20210616105327.wnppsau4gg5ihrlv@vireshk-i7> <4d975236-943c-ea82-547b-04f2bead9f48@arm.com>
 <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
In-Reply-To: <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Jul 2021 17:46:45 +0200
Message-ID: <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient frequencies
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 2, 2021 at 4:21 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> This is a gentle ping.
> You have probably not seen this discussion thread.

I have looked at it briefly for a few times, but not too much into detail.

> On 6/16/21 1:45 PM, Lukasz Luba wrote:
> >
> >
> > On 6/16/21 11:53 AM, Viresh Kumar wrote:
> >> On 16-06-21, 11:33, Lukasz Luba wrote:
> >>> On 6/16/21 10:31 AM, Viresh Kumar wrote:
> >>>> On 16-06-21, 10:03, Lukasz Luba wrote:
> >>>> Clean is not lesser number of lines for me, but rather having the
> >>>> right ownership of such things.
> >>>
> >>> Some developers do like patches which removes more lines then adds ;)
> >>
> >> :)
> >>
> >
> > [snip]
> >
> >>>
> >>> What could be the modified v1 [2]:
> >>> - LUT which holds two IDs: efficient, inefficient, take one
> >>>    according to the clamp f_max
> >>> - add new argument 'policy->max' to em_pd_get_efficient_freq()
> >>>
> >>> freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq,
> >>> policy->max);
> >>>
> >>> The problem was that EAS couldn't know the clamp freq_max,
> >>> which shouldn't be the blocker now.
> >>
> >> If you can do that without adding any EM specific stuff in the cpufreq
> >> core, I will mostly be fine.
> >>
> >> But honestly speaking, creating more data structures to keep related
> >> information doesn't scale well.
> >>
> >> We already have so many tables for keeping freq/voltage pairs, OPP,
> >> cpufreq, EM. You tried to add one more in EM I think V1, not sure.
> >>
> >> It is always better to consolidate and we almost reached to a point
> >> where that could have been done very easily. I understand that you
> >> didn't want to touch so many different parts, but anyway..
> >
> > Yes, I don't want to touch some many generic parts because they
> > are intended to be generic. This heuristic is only for EM platforms,
> > which are arm, arm64 battery powered (not servers or other).
> > Thus, I wanted to keep it locally. The cost of EM extra structures
> > (the LUT) will only be for platforms for which EM discovers that
> > they have inefficient performance levels.
> > The code would even not be compiled in for x86, ppc, etc, in hot path.
> >
> >>>>> this v3 and your proposal.
> >>>>
> >>>> IMHO, adding such callbacks to the EM core, like .mark_efficient(),
> >>>> will only make this easier to handle for all different frameworks, and
> >>>> not otherwise. The code will look much cleaner everywhere..
> >>>>
> >>>
> >>> What about coming back to the slightly modified v1 idea?
> >>> That was really self-contained modification for this
> >>> inefficient opps heuristic.
> >>
> >> I am not sure if I really understand what that would be, but again
> >> adding another table is going to create more problems then it should.
> >
> > IMHO your proposals are more invasive for the generic code, while
> > not always being even used. Plenty of architectures don't even set EM,
> > even arm64 for servers doesn't use it. You and Rafael would have to
> > maintain these modifications in generic code. It might be hard to remove
> > it. While I recommend to keep this heuristic feature inside the EM and
> > we will maintain it. If we decide after a few years that new arm64
> > platforms use some smarter FW for performance level, we might just
> > disable this heuristic.
> >
> >>
> >> Anyway, that's my view, which can be wrong as well.
> >>
> >> Rafael: You have any suggestions here ?
> >>
> >
> > I would also like to hear Rafael's opinion :)
>
> It would be great if you could have a look.
> I will be grateful for your time spend on it and opinion.

First of all, IMO checking whether or not a given frequency is
"efficient" doesn't belong to cpufreq governors.  The governor knows
what the min and max supported frequencies are and selects one from
that range and note that it doesn't even check whether or not the
selected frequency is present in the frequency table.  That part
belongs to the driver or the general frequency table handling in the
cpufreq core.

So the governor doesn't care and it shouldn't care IMO.

Besides, in the cpufreq_driver_fast_switch() case the driver's
->fast_switch() callback is entirely responsible for applying the
selected frequency, so I'm not sure how this "efficient" thing is
going to work then?

Anyway, since we are talking about frequency tables, that would be the
__cpufreq_driver_target() case only and specifically in the
__target_index() case only (note how far away this is from the
governor).

Now, you may think about modifying cpufreq_frequency_table_target() to
skip "inefficient" frequencies, but then the question is why those
frequencies need to be there in the frequency table in the first
place?
