Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF74004B7
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350383AbhICSPN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 14:15:13 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36475 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349959AbhICSPM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 14:15:12 -0400
Received: by mail-ot1-f45.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso88321otv.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 11:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zflj9RhYoPFAVDQmfE2MY9vIGsDUoUFAZ4lrNKfsqiA=;
        b=NshqfF/EhfRwyIbolDoxvIJvrsUum1hFxkZKrdsIb6E7cMt60I2znmlAj+VjgOEubf
         Tht4ESLdiaI3BWLTECyaKckCeUfyPLICWTF5CBm2IsJKeAe3ua7ZL0Dwx53Jjq5/xRzG
         IbMRCL3XaCM9pZJxZcnyRfYwQjfxVV5P8VQVIaCRBcOO7w42QYeb7TR0AipAYibmlYQb
         6n/XUTxJS9Eu3nPES0CJgrJALbeUdp9Wqdss3FH7GvxdVShM7bOTMoO96roMYmXVLYbq
         DxUrVbq6BQ8qXtEBmPnWkh1sjZcVC5bPVPARKbltygZs2T+CG9VL+3/1qeWmxayrqYYS
         v8Dw==
X-Gm-Message-State: AOAM530xURfvLlcKQjiZFEXJMBtsR8lv/u1J4ciNQElXRt0BPgUZfliX
        S5j+/BulP6cHASOZR/TaUTnVCLBUA4qiWrgb5/8=
X-Google-Smtp-Source: ABdhPJysMYroe/TjQ8gkAV2jWl6DCLUwKFZ3Na9oFcPMgPNhjg6/6CONMuiVE6gXv8YV8FJYsGavMmHNqPIojGRf7ps=
X-Received: by 2002:a9d:6945:: with SMTP id p5mr272675oto.301.1630692852063;
 Fri, 03 Sep 2021 11:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
 <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0i5KRkUKvqGbqoxhaNh626bmg3C2F-rZmcqaaqReQF7SQ@mail.gmail.com>
 <20210902105037.GA136543@e120877-lin.cambridge.arm.com> <CAJZ5v0iRJuyup2M16snP+BdJSKToSQ4QiFnrCoZn1j2KYhLEGA@mail.gmail.com>
 <20210902134927.GA147718@e120877-lin.cambridge.arm.com>
In-Reply-To: <20210902134927.GA147718@e120877-lin.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Sep 2021 20:14:00 +0200
Message-ID: <CAJZ5v0hi=YDiO79YWPDHcHEVypwv7++Qjmz7JAjOs9O6ooGy+g@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] cpufreq: Skip inefficient frequencies
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 2, 2021 at 3:49 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> > > > >
> > > > > +static inline unsigned int
> > > > > +cpufreq_frequency_find_efficient(struct cpufreq_policy *policy,
> > > > > +                                unsigned int idx)
> > > > > +{
> > > > > +       struct cpufreq_frequency_table *table = policy->freq_table;
> > > > > +       unsigned int efficient_idx = table[idx].efficient;
> > > > > +
> > > > > +       return table[efficient_idx].frequency <= policy->max ? efficient_idx :
> > > > > +               idx;
> > > >
> > > > I'm not sure about this.
> > > >
> > > > In the _RELATION_L case table[idx].frequency can be above the policy
> > > > max, so you may end up running at an inefficient frequency above the
> > > > policy max, but you won't use an efficient one above it.  Isn't this
> > > > slightly confusing?
> > >
> > > This can indeed happen when policy->max isn't equal to an available frequency.
> > > But nontheless, we can't let the efficient resolution violate the policy->max,
> > > which is used for thermal capping. The fact that we can overshoot a max
> > > limit is confusing as well.
> > >
> > > So I could add a policy->max sanity, to make sure this value is an actual
> > > frequency and that RELATION_L will never overshoot that value. Or we can have a
> > > flag somewhere to indicate thermal capping is happening and we shouldn't skip
> > > inefficient frequencies.
> >
> > I would prefer the first option, because user space may be applying
> > the limit for power capping or thermal reasons too and the kernel
> > can't really tell why it is doing that.
> >
> > This needs to be added to cpufreq_set_policy(), I think after calling
> > the driver's ->verify().
> >
> > And if this is done to the policy max, IMO it needs to be done to the
> > policy min too, for consistency.  So if a frequency table is used, the
> > policy max and the policy min could be only the frequencies present in
> > the table.
>
> Ack. I'll consolidate policy->max and ->min set behavior in v7 so we won't have
> any problem having to know who set policy->max and if yes or no we can break it.
>
> What relation do we want for min/max setting? I guess RELATION_H for policy->max
> and RELATION_L for policy->min (i.e. The highest frequency existing right below
> the maximum and the lowest frequency existing just above the minimum)

Yes.

> >
> > Moreover, if only efficient frequencies are to be used, RELATION_L
> > needs to return min(policy->max, the closest efficient frequency equal
> > to or above the target).
>
> You mean, never returning an inefficient frequency, unless there are no
> efficient ones in the range policy->min policy->max ?

No, that's not what I mean.

First note that the target here is clamped between the policy min and
max.  Also bear in mind that each of them is a frequency from the
table, either efficient or inefficient.

In the first step, search through the efficient frequencies only.
That will return you something at or above the target.  If it is at
the target, you're done.  If it is above the target, it may be either
within or above the policy max.  If it is within the policy max,
you're done.  If it is above the policy max, you need to search
through the inefficient frequencies between the target and the policy
max (and you know that there is at least one - the policy max itself).

So what I said previously wasn't particularly precise, sorry about that.
