Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB03BD68F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 14:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhGFMhh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 08:37:37 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:35646 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbhGFMOR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 08:14:17 -0400
Received: by mail-ot1-f53.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so21356035oti.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Jul 2021 05:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqS1EE5ZCqXXrj+zliiH/OuJG8X+J4V/WoEfh/3zb70=;
        b=P/fa2uk9dVhMd7C+TONNMXT6RtX7NcekvqOdUibb3OujwRlPiHx9f1OoHl3xkarQ46
         dvFILFySirSSsnoyr8arIDmUHWdBRXQGvjaJknKKR+woKy7dAi+yA8GDrIFo0XvD15xA
         ksorfqE1VNy7HNzIH1y3mUVb2Q8YTKrhq5vVkJCoB+MBeayVedCA1pQgxVAI70iedWwO
         Yq9JPtEm5RA3cUc4rbPsanLS9KXSiUeF+8ZoGHWbqQa3I+yZE/9FyxAEOx29OVXUFzvn
         Wsq0JME7AfqdkBfBaSJkAhJxkngT9eZM7wpiqeMTcwF29us0C4LP/7Z339QXGeMHsj/0
         o/cQ==
X-Gm-Message-State: AOAM530KkSeH2liT27RwZDX3qpQhPUHv6feV5oFWofBFWzBZL6Vaom8Q
        2LjdOh/oFGwCyiv6WHg7CCOBu5OcnTftaCmVXVu8Vn11F6A=
X-Google-Smtp-Source: ABdhPJzXatIluzbOjqv2w9KcZpQ0FfZw9wFN0BdqyjEpjtzppq8XwHGpoXMjA76WkCvcVDzfmF0MJu/Qs+2CKtp/DXM=
X-Received: by 2002:a9d:22a5:: with SMTP id y34mr4250930ota.321.1625573496019;
 Tue, 06 Jul 2021 05:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com> <20210616105327.wnppsau4gg5ihrlv@vireshk-i7>
 <4d975236-943c-ea82-547b-04f2bead9f48@arm.com> <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
 <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
 <CAJZ5v0hOXHtoN3Z+Mw9Ym_HaY0OxessNAKTEpp6GM5_pnLJauw@mail.gmail.com>
 <a660b9ec-3ee7-28b2-569c-5a8d1510d927@arm.com> <CAJZ5v0iQve59SxD0TJ19wonj=WO7qVSApM-xPf_FYUf42Z3d5Q@mail.gmail.com>
 <20210702191658.GA30379@e120877-lin.cambridge.arm.com> <CAJZ5v0ijLepOyGX0Et1h3j6AbtFxV_-mq+2uNrv8syG0RPiJbg@mail.gmail.com>
 <20210706081256.GA216826@e120877-lin.cambridge.arm.com>
In-Reply-To: <20210706081256.GA216826@e120877-lin.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Jul 2021 14:11:24 +0200
Message-ID: <CAJZ5v0h+zZZOn70eGD9XZy0rcy0ic-C1=UC7YGLhUahVgC4pzg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient frequencies
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Tue, Jul 6, 2021 at 10:13 AM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> > >
> > > What about a cpufreq_policy option that if sets would make
> > > cpufreq_frequency_table_target() skip inefficient OPPs while staying within
> > > the limit of max policy?
> >
> > That would work too, ->
> >
> > > Each governor could decide to set it or not, but
> > > it would hide the efficiency resolution to the governor and allow drivers
> > > that implements ->target() to also implements support for inefficient OPPs.
> >
> > -> but alternatively there could be an additional cpufreq driver flag
> > to be set by the drivers implementing ->target() and wanting to deal
> > with CPUFREQ_RELATION_EFFICIENT themselves (an opt-in of sorts).
> >
> > So the governors that want it may pass CPUFREQ_RELATION_EFFICIENT to
> > __cpufreq_driver_target() and then it will be passed to ->target()
> > depending on whether or not the new driver flag is set.
>
> Of course, I can implement this instead of a cpufreq_policy flag in v4.
> I suppose then right fallback for CPUFREQ_RELATION_EFFICIENT in case the
> driver doesn't opt-in is CPUFREQ_RELATION_L.
>
> >
> > > That flag could be set according to a new cpufreq_governor flag
> > > CPUFREQ_GOV_SKIP_INEFFICIENCIES?
> > >
> > > That could though modify behaviors like powersave_bias from ondemand. But if
> > > a frequency is inefficient, there's probably no power saving anyway.
> >
> > AFAICS, the userspace governor aside, using inefficient frequencies
> > only works with the powersave governor.  In the other cases,
> > RELATION_L (say) can be interpreted as "the closest efficient
> > frequency equal to or above the target" with the max policy limit
> > possibly causing inefficient frequencies to be used if they are closer
> > to the limit than the next efficient one.
> >
> > As a rule, the governors don't assume that there are any inefficient
> > frequencies in the table.  In fact, they don't make any assumptions
> > regarding the contents of the frequency table at all.  They don't even
> > assume that the driver uses a frequency table in the first place.
>
> So all the governors, beside powersave and userspace would replace their
> RELATION_L with RELATION_EFFICIENT. I'll add the changes in v4.
>
> So if I sum-up: new RELATION_EFFICIENT that resolves RELATION_L to an higher
> efficient frequency (if necessary) within the limits of policy->max.

Yes.

It can be called RELATION_E for brevity.

> CPUfreq drivers can opt-in by setting an appropriate flag. If they do not,
> RELATION_EFFICIENT will be rewritten in RELATION_L.

Yes, and cpufreq_frequency_table_target() will take RELATION_E into
account if set.

> All governors but userspace and powersave would use RELATION_EFFICIENT instead of RELATION_L.

Yes.

> If that works for you, I'll implement this in a v4, as well as some
> improvements for the CPUfreq/EM registration following the discussion with
> Viresh.

Sounds good, thanks!
