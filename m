Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28668D0DBE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfJILeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 07:34:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46809 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfJILeU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 07:34:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so1353386lfc.13
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2019 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EG9v3kTZ0STByqKzP1n2q6Lh+2OqkwymViAjwK7ZPds=;
        b=kH+IeUMBfwMkv+Uo4/4m6ZmUuhDopta5OobVSgramulhVEyCCZxL5T5iTJOdzm2ikl
         viyWRm8qzrngXIFOEtvhZyR3IqmVVW2GF9QmXLIJgbTUyymNdFCnG0qJ4WhHUlH09bZv
         h2xcgZVPD2u3UzlBpuO2zP5Hl7+jNW5mCu13+X0Y/hE3OATs5Mwrjqk40NwJUBP+2n6i
         m76Al2ZrYxWeyVpS28DnybxabAHASJg4GFrrYQ8x7oTSsGiAyqCltQZz7Kne5lV28xfp
         RFj3OwzWPIxsZcRAmtCpYaWSMdzpoXO2EJAz9dCO1akwjDH/mC+W/blXsAhj0wn+HrN3
         TKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EG9v3kTZ0STByqKzP1n2q6Lh+2OqkwymViAjwK7ZPds=;
        b=jMzD1Nwg82qRbxrNxpycTaYuXvTcbMBasvPVFjtLVIEltwUIp+OrC2wd340MGUCtlA
         s0tZd3XnlRHkN4ArvLIgGTOXxHkotJnIb8kzHRZTmW/lzfy7qwxp0du+n2r+7XLslR8o
         r8NWDJKJxSc7Pbs55yVc5esl3Dy1wfIzfTlrMFcd9bvd6fawqE0jvuaiUfBDpyS4cWzl
         8jSOIR47KIdxtwHvRMMStiYD41CCJpLihYzmzAHvwSv2LYDxnc12lvc9JVUbfNem9uqm
         esxSPdPyDvwRrAM9ZrFSBGRPDJoPpAWjJlGLcvjET0gMrQlYhyy5LUVPQdUOALKsg19K
         hsjQ==
X-Gm-Message-State: APjAAAXEo3SQ21656Y0h0YTB8OEYt/8gRYBuVaC9i4H+vKDFjPWqckvY
        zxJ3j8DQp/tHuRo19RBdN+7KRFu4cvMNmLmxXHnJmw==
X-Google-Smtp-Source: APXvYqyE36EyOAEHFvFyThIKdgVAP3t6Zlig8jOB79kkG650s6dVZXW5xCuGRLueBvJWlgkFNY0EbbJ3Zw9MdV2E4aI=
X-Received: by 2002:a19:4f06:: with SMTP id d6mr1847743lfb.15.1570620858079;
 Wed, 09 Oct 2019 04:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191007083051.4820-1-parth@linux.ibm.com> <20191008132842.6612-1-hdanton@sina.com>
 <d4c936d9-c99f-e50d-95c9-0732ae45d1b9@linux.ibm.com>
In-Reply-To: <d4c936d9-c99f-e50d-95c9-0732ae45d1b9@linux.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 9 Oct 2019 13:34:06 +0200
Message-ID: <CAKfTPtDghQrjK=4Pd0RbvwbQTU1SP88nVp6NLkNitk+07UfadA@mail.gmail.com>
Subject: Re: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small
 background tasks on fewer cores
To:     Parth Shah <parth@linux.ibm.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Quentin Perret <qperret@qperret.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 9 Oct 2019 at 11:23, Parth Shah <parth@linux.ibm.com> wrote:
>
>
>
> On 10/8/19 6:58 PM, Hillf Danton wrote:
> >
> > On Mon,  7 Oct 2019 14:00:49 +0530 Parth Shah wrote:
> >> +/*
> >> + * Try to find a non idle core in the system  based on few heuristics:
> >> + * - Keep track of overutilized (>80% util) and busy (>12.5% util) CPUs
> >> + * - If none CPUs are busy then do not select the core for task packing
> >> + * - If atleast one CPU is busy then do task packing unless overutilized CPUs
> >> + *   count is < busy/2 CPU count
> >> + * - Always select idle CPU for task packing
> >> + */
> >> +static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
> >> +{
> >> +    struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
> >> +    int iter_cpu, sibling;
> >> +
> >> +    cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
> >> +
> >> +    for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
> >> +            int idle_cpu_count = 0, non_idle_cpu_count = 0;
> >> +            int overutil_cpu_count = 0;
> >> +            int busy_cpu_count = 0;
> >> +            int best_cpu = iter_cpu;
> >> +
> >> +            for_each_cpu(sibling, cpu_smt_mask(iter_cpu)) {
> >> +                    __cpumask_clear_cpu(sibling, cpus);
> >> +                    if (idle_cpu(iter_cpu)) {
> >
> > Would you please elaborate the reasons that the iter cpu is checked idle
> > more than once for finding a busy core?
> >
>
> Thanks for looking at the patches.
> Could you please point me out where iter_cpu is checked more than once?

I think that point is that you have a sibling that there is
for_each_cpu(sibling, cpu_smt_mask(iter_cpu) but you never use sibling
in the loop except for clearing it on the cpumask cpus
All the tests are done with iter_cpu so you will test several time
iter_cpus but never the other sibling
Should you use sibling instead ?


>
> >> +                            idle_cpu_count++;
> >> +                            best_cpu = iter_cpu;
> >> +                    } else {
> >> +                            non_idle_cpu_count++;
> >> +                            if (cpu_overutilized(iter_cpu))
> >> +                                    overutil_cpu_count++;
> >> +                            if (is_cpu_busy(cpu_util(iter_cpu)))
> >> +                                    busy_cpu_count++;
> >> +                    }
> >> +            }
> >> +
> >
>
