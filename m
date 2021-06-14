Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC483A6AE9
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 17:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhFNPwO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 11:52:14 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34574 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhFNPwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 11:52:14 -0400
Received: by mail-lj1-f173.google.com with SMTP id bn21so20845503ljb.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvxA21VumxeBH80QU+YFcZjpYmFJP2YEnOU9brfcC/Q=;
        b=ov3+e6XcGW7aaTgitcXgtvPoIULYqS4OqrYI5NXLHClAO16OfPyuCdmO7oUzbB28/H
         gnbpQAf6lHGUsrfpiqjqCgd9aNJD9pwFRPL0alRWw9U2qb7IEe1DbA5apv1b85+0YQRI
         fPGBmONGKxwlX/8gkRyO/vXXjiNE+mJzYbMPtt3KlNBDE547jiPlu+4o1lT/czrP+VdA
         zYWXsFZU7WgMWs0TY+3JRQPoF+VPj5NmeRDIFB7Ilmtz5XaFBxsUkgF51mXrbRvsmSFJ
         KdLw88W3xU2OhiBJdEyQ+0c4qfxTGwO1puVM0UB9ZE4qGoS+QDgB/MMQG4hH3N7wMF/D
         UOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvxA21VumxeBH80QU+YFcZjpYmFJP2YEnOU9brfcC/Q=;
        b=XDfLJD7VUtlVRM4BYSEIqd/lqIw64WjyqJGMNrtVhmDqYp2Gy8iLIR3lkYGyfWhgC/
         qyTerHilsFPtXP+khyOcXX4FTz1xEBrZEgLsxQ+7vPAHb95wEHxFIp+3LU0o9KViSjEX
         WLlQO+unxxu2wtz0WALNiX6YrqS9x4oWiyj7L7pdVvEg3PKm9CBgcsyuzWIqm2AcBJMq
         dUpuAL9xd1lyTzvi7c1Ql9WYNWRdYqPr22sXT5+tKRpnXjlCsm8qytouNNmZW7k73Ofz
         l2QB0zeYB2B4FIa4W0R3EI8GSdx8JB770+q+wS/DuWF9WjccMTFCFBuJUiADfOT5Q2OF
         wLng==
X-Gm-Message-State: AOAM530dMARlcOZm5sToOpH0Nd+bHs2nrfAXzNf5W7CRVDpZWQfFIFX1
        6WquQwIg2ztrvHpV9Pcl4Oda9SNWW5RxykSkLKVikA==
X-Google-Smtp-Source: ABdhPJxznhPx2RrVYUHfLp6eoaT4EB22Qs8+vOyCmJDNT5wKOpSDC4gZ0LhLmFc7sPRynmyvbZJGPqcDnBVdMWCtsmY=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr6984068ljg.401.1623685750313;
 Mon, 14 Jun 2021 08:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210610150324.22919-1-lukasz.luba@arm.com> <20210610150324.22919-3-lukasz.luba@arm.com>
 <81d7bd73-a61a-5501-f8ec-77e195355013@arm.com>
In-Reply-To: <81d7bd73-a61a-5501-f8ec-77e195355013@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Jun 2021 17:48:58 +0200
Message-ID: <CAKfTPtDcOt6ELdUXk9yoTc4QtAcT-5iad9UAB4COPyrN8z5umg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>, amitk@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 14 Jun 2021 at 17:29, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> Gentle ping. Could you have a look at this implementation, please?

Ah yes, this has been lost in my inbox. Let me have a look at it

>
>
> On 6/10/21 4:03 PM, Lukasz Luba wrote:
>
> [snip]
>
> > @@ -6527,8 +6527,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> >       struct cpumask *pd_mask = perf_domain_span(pd);
> >       unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
> >       unsigned long max_util = 0, sum_util = 0;
> > +     unsigned long _cpu_cap, thermal_pressure;
> >       int cpu;
> >
> > +     thermal_pressure = arch_scale_thermal_pressure(cpumask_first(pd_mask));
> > +     _cpu_cap = cpu_cap - thermal_pressure;
>
> I've done the implementation according to your suggestion. That should
> provide the consistent usage.
>
> Regards,
> Lukasz
