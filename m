Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD433ED8D5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhHPOUm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 10:20:42 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38673 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhHPOUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 10:20:39 -0400
Received: by mail-ot1-f48.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so21115325otu.5
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 07:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8fRqi6W0q43XhD24FVMcvxlBJPIyhTDKtNsJvPuZ/8=;
        b=rBAW+BjcpAKmC1GUYNKxcufJ4P0rQFDoTCZuQJDxLJcUK2RNZR2yxPL0oTkiQH5K5b
         RJV8vlbNDEfDhqr06nUHTUIcZlenXBi6Z2oDm2aU+cADvtGVQnrGjU6kX3e86g/7oKaD
         VPiGCVeTeuVcO4tRfpW9O+PVpIihxgNqHo449Nepc1GkpKELRi6d6A3qTpeELWhXq6LK
         U8g4sUfr5q7OELEkTlgYmhBQOSVX9eoKmjjohpchJ+24Y+vYZZjxZ07bODZ6RAmGE+e+
         RH3zmZI3LKEkCselW2WwTjrYJT+lF27zipBJ0RJYgKdwwhHm2bPWAuQAkonKocC+D7r8
         H02Q==
X-Gm-Message-State: AOAM533oZyxPqf3Fm4H1BAZ1IdzOzqI1OFbF7Q1x1az4Nn4a7uzt82iD
        6slkYYuxAHWtVOc9omiA7ZCoC167P7vAVF9xim8=
X-Google-Smtp-Source: ABdhPJy4c64EksW5u3esMFqNcw2ra08sGv1XhUDF22IsMX0wdCwVPMlcsJ0kQYMrRSWeZ98kGvE8egUbLRNZmatAPco=
X-Received: by 2002:a9d:a75:: with SMTP id 108mr12687701otg.260.1629123607656;
 Mon, 16 Aug 2021 07:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com> <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
In-Reply-To: <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 16:19:41 +0200
Message-ID: <CAJZ5v0hta1mEVatT=6ZMLhZCs3btcSbTT10YEihfdvB-WxDuzQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Tue, Aug 10, 2021 at 8:13 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 04-08-21, 18:21, Rafael J. Wysocki wrote:
> > The cpufreq changes are mostly fine by me now, but I would like to
> > hear from Viresh regarding this.
>
> I have few doubts/concerns here.
>
> Just to iterate it again, the idea here is to choose a higher
> frequency, which will work in an efficient manner based on energy
> consumption. So this _only_ works for the case where the caller asked
> for CPUFREQ_RELATION_L.
>
> - The new flag being added here, CPUFREQ_RELATION_E, doesn't feel
>   complete in this sense to me. It should rather be called as
>   CPUFREQ_RELATION_LE instead as it is _always_ used with relation L.

Well, this mostly is a matter of what the flag means.  If "E" implies
"L", I don't see a problem.

> - IMO this has made the caller site a bit confusing now, i.e.  why we
>   send CPUFREQ_RELATION_E sometimes and CPUFREQ_RELATION_H at other
>   times. Why shouldn't the _H freq be efficient as well ?

This is a good point, though.

>  I understand  that this was done to not do the efficient stuff in case of
>   userspace/powersave/performance governors.
>
>   What about reusing following for finding all such cases ?
>
>         policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING
>
>   The driver can set a flag to tell if it wants efficient frequencies
>   or not, and at runtime we apply efficient algorithm only if the
>   current governor does DVFS, which will leave out
>   userspace/performance/powersave.

As long as this can be done without actually accessing
policy->governor->flags on every transition, it sounds like a good
idea.

> Now the other thing I didn't like since the beginning, I still don't
> like it :)
>
> A cpufreq table is provided by the driver, which can have some
> inefficient frequencies. The inefficient frequencies can be caught by
> many parts of the kernel, the current way (in this series) is via EM.
> But this can totally be anything else as well, like a devfreq driver.
>
> The way we have tied this whole thing with EM, via
> cpufreq_read_inefficiencies_from_em(), is what I don't like. We have
> closely bound the whole thing with one of the ways this can be done
> and we shouldn't be polluting the cpufreq core with this IMHO. In a
> sane world, the cpufreq core should just provide an API, like
> cpufreq_set_freq_invariant() and it can be called by any part of
> the kernel.

Right.

> I understand that the current problem is where do we make that call
> from and I suggested dev_pm_opp_of_register_em() for the same earlier.
> But that doesn't work as the policy isn't properly initialized by that
> point.
>
> Now that I see the current implementation, I think we can make it work
> in a different way.
>
> - Copy what's done for thermal-cooling in cpufreq core, i.e.
>   CPUFREQ_IS_COOLING_DEV flag, for the EM core as well. So the cpufreq
>   drivers can set a flag, CPUFREQ_REGISTER_EM, and the cpufreq core
>   can call dev_pm_opp_of_register_em() on their behalf. This call will
>   be made from cpufreq_online(), just before/after
>   cpufreq_thermal_control_enabled() stuff. By this point the policy is
>   properly initialized and is also updated in
>   per_cpu(cpufreq_cpu_data).
>
> - Now the cpufreq core can provide an API like
>   cpufreq_set_freq_invariant(int cpu, unsigned long freq), which can
>   be called from EM core's implementation of
>   em_dev_register_perf_domain().

Sounds reasonable to me.
