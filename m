Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890033BBDFD
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 16:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGEOMC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jul 2021 10:12:02 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:36728 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGEOMB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jul 2021 10:12:01 -0400
Received: by mail-oi1-f176.google.com with SMTP id 11so20897722oid.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Jul 2021 07:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWNF2z7e4wzXVNVKtV8jGxjbjzxTWKSRdbqjRsQ9Txg=;
        b=PvIMPHmcIA5aFBDG7riynyv3zdOuk2DVfr10osXjPoPzrgjMzBnD2jNd5pRO+xfDyw
         Zv5kFBoWfIZk3FcC7PxV4IwVSnBEqsBHvVIGqM7TY/udvoAI3L9rHpwOZ6GMwEZ6+vbU
         edpJUJ9KNO88zeqZUuWyLDX/ZDL8XuZB8Dytv4Li3uR/F9h8G/zopo4HYcJbRgiMSJFl
         80XN5PM4xygvJbGqxeWws7FO1YgD/HB7ku3rYodMH9ib8nlLjsNaSc9IHYewjaf95aHr
         E9oS0ILgxyBRZvPf0UWD8XFS/BPsTvuvQDM8oJYfuUsaGYn+EHZWv/Z6Lyp6UEirUjJ4
         WeNw==
X-Gm-Message-State: AOAM530laeOS7QocaLo7gE1nv4wBMhS/6k/OGY9hsMlvyrpOW+eYIaJ8
        rbpH2YNz8AKZmQbE7uFFbpaHw5u8Yc5Xyip1Tt4=
X-Google-Smtp-Source: ABdhPJzBykU99G8W9IyL+tzrPjwe64W8dUhsg9RVnkXdF+QciH1eQp74IWQ/OzT+XL1OryDxGjlaejfrXH9FQmO8lBg=
X-Received: by 2002:aca:c457:: with SMTP id u84mr1133984oif.69.1625494163657;
 Mon, 05 Jul 2021 07:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com> <20210616093127.lfpi4rje56b3dhwx@vireshk-i7>
 <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com> <20210616105327.wnppsau4gg5ihrlv@vireshk-i7>
 <4d975236-943c-ea82-547b-04f2bead9f48@arm.com> <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
 <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
 <CAJZ5v0hOXHtoN3Z+Mw9Ym_HaY0OxessNAKTEpp6GM5_pnLJauw@mail.gmail.com>
 <a660b9ec-3ee7-28b2-569c-5a8d1510d927@arm.com> <CAJZ5v0iQve59SxD0TJ19wonj=WO7qVSApM-xPf_FYUf42Z3d5Q@mail.gmail.com>
 <20210702191658.GA30379@e120877-lin.cambridge.arm.com>
In-Reply-To: <20210702191658.GA30379@e120877-lin.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jul 2021 16:09:12 +0200
Message-ID: <CAJZ5v0ijLepOyGX0Et1h3j6AbtFxV_-mq+2uNrv8syG0RPiJbg@mail.gmail.com>
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

On Fri, Jul 2, 2021 at 9:17 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> > > >
> > > > I'm guessing that the problem is that cpufreq_cooling works by using
> > > > freq_qos_update_request() to update the max frequency limit and if
> > > > that is in effect you'd rather use the inefficient frequencies,
> > > > whereas when the governor selects an inefficient frequency  below the
> > > > policy limit, you'd rather use a higher-but-efficient frequency
> > > > instead (within the policy limit).
> > > >
> > > > Am I guessing correctly?
> > > >
> > >
> > > Yes, correct. Thermal would use all (efficient + inefficient), but
> > > we in cpufreq governor would like to pick if possible the efficient
> > > one (below the thermal limit).
> >
> > To address that, you need to pass more information from schedutil to
> > __cpufreq_driver_target() that down the road can be used by
> > cpufreq_frequency_table_target() to decide whether or not to skip the
> > inefficient frequencies.
> >
> > For example, you can define CPUFREQ_RELATION_EFFICIENT and pass it
> > from schedutil to __cpufreq_driver_target() in the "relation"
> > argument, and clear it if the target frequency is above the max policy
> > limit, or if ->target() is to be called.
>
> What about a cpufreq_policy option that if sets would make
> cpufreq_frequency_table_target() skip inefficient OPPs while staying within
> the limit of max policy?

That would work too, ->

> Each governor could decide to set it or not, but
> it would hide the efficiency resolution to the governor and allow drivers
> that implements ->target() to also implements support for inefficient OPPs.

-> but alternatively there could be an additional cpufreq driver flag
to be set by the drivers implementing ->target() and wanting to deal
with CPUFREQ_RELATION_EFFICIENT themselves (an opt-in of sorts).

So the governors that want it may pass CPUFREQ_RELATION_EFFICIENT to
__cpufreq_driver_target() and then it will be passed to ->target()
depending on whether or not the new driver flag is set.

> That flag could be set according to a new cpufreq_governor flag
> CPUFREQ_GOV_SKIP_INEFFICIENCIES?
>
> That could though modify behaviors like powersave_bias from ondemand. But if
> a frequency is inefficient, there's probably no power saving anyway.

AFAICS, the userspace governor aside, using inefficient frequencies
only works with the powersave governor.  In the other cases,
RELATION_L (say) can be interpreted as "the closest efficient
frequency equal to or above the target" with the max policy limit
possibly causing inefficient frequencies to be used if they are closer
to the limit than the next efficient one.

As a rule, the governors don't assume that there are any inefficient
frequencies in the table.  In fact, they don't make any assumptions
regarding the contents of the frequency table at all.  They don't even
assume that the driver uses a frequency table in the first place.
