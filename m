Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90B1185D7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 12:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLJLIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 06:08:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38693 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJLIL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 06:08:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id b8so9410731oiy.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 03:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcPPmAhprIChcpRlQSOWJI+yE90HvISBIojdfa1OL1g=;
        b=BbVMdAxpI/eehTHNW5kjfH1rvtpanjv7SVveHGlQeTnmOYUTGsB632+L20RHe2x79T
         E8GTFEOIygwcO1KeSlG4qTvYCTca3NQ+jUHrRonYUB8O+uTuduU+Wu7fw+E+BYVVYeZs
         Xl/4HVpg+e9cNtQh3gBcgyH5zXs0soM4qq+12JBNYflUGubE2Ln+dKyuwiGGKsKH2ihY
         +tDA4zeq2Fk74O/A3XWXu+vLV7dOjDaQVGe2EvP68A9vZhAROSGFGtLXFXWnxcPpPeyC
         T3N9QvT2XO8NivX9JcR3c2Sz/GlYl9IzOWYnvgq+qFnVYoxHV6VRnIZpCTuGVnha3i3C
         pRQA==
X-Gm-Message-State: APjAAAX2E+QnCO3Y4c5lTvMmoEkf0BpBQIfmG8venByGRWHmMfqUFk1D
        9QegAPpx0irmltqVsG/AM3+YZRZ+7R8aTippDkc=
X-Google-Smtp-Source: APXvYqxdd41nvl5s085pMGotMSEy4DciMtxt8mmrGj7IPeP/wt/g+y2wjTSwXQLRHHl8coXNmvUVq7yWUQHp5Wm+8gA=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr3344017oig.68.1575976089770;
 Tue, 10 Dec 2019 03:08:09 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <40413247.HltoIgKm8r@kreacher> <DB3PR0402MB3916C7E77C885343B2B961CFF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <5310126.hg2rr5Fjtk@kreacher> <20191210105450.avv2gvygl7kj5auu@vireshk-i7>
In-Reply-To: <20191210105450.avv2gvygl7kj5auu@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Dec 2019 12:07:58 +0100
Message-ID: <CAJZ5v0ih4U+=U27jgLgqfMRaz5Wi2OAMTKmE=rd=RYOj+OCXVg@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 10, 2019 at 11:54 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 10-12-19, 11:39, Rafael J. Wysocki wrote:
> > Index: linux-pm/kernel/sched/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/cpufreq.c
> > +++ linux-pm/kernel/sched/cpufreq.c
> > @@ -5,6 +5,8 @@
> >   * Copyright (C) 2016, Intel Corporation
> >   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >   */
> > +#include <linux/cpufreq.h>
> > +
> >  #include "sched.h"
> >
> >  DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
> > @@ -57,3 +59,19 @@ void cpufreq_remove_update_util_hook(int
> >       rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
> > +
> > +/**
> > + * cpufreq_this_cpu_can_update - Check if cpufreq policy can be updated.
> > + * @policy: cpufreq policy to check.
> > + *
> > + * Return 'true' if:
> > + * - the local and remote CPUs share @policy,
> > + * - dvfs_possible_from_any_cpu is set in @policy and the local CPU is not going
> > + *   offline (in which it is not expected to run cpufreq updates any more).
> > + */
> > +bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
> > +{
> > +     return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
> > +             (policy->dvfs_possible_from_any_cpu &&
>
> > +              rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data)));
>
> I somehow feel that doing this particular check in cpufreq_update_util() maybe
> better. Or maybe we can call cpufreq_this_cpu_can_update() itself right from
> cpufreq_update_util() instead and remove it from multiple places in the
> governors.

First, there are two places actually.

Second, the point is that the presence of the hook only needs to be
checked if dvfs_possible_from_any_cpu is set and checking that in
cpufreq_update_util() would be kind of obnoxious IMO.
