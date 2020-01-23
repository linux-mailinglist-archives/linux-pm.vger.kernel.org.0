Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D941472E3
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 22:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAWVCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 16:02:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34556 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWVCi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 16:02:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so4186701otf.1;
        Thu, 23 Jan 2020 13:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwkzB9x1WanWBhDL7x07j92uDlqSFlw2k1NGj/hLgTI=;
        b=opwwqkVr7ujqaFEXL/m94OShnLJaHmfL96kZAQoawzKRHOMX38UT1Erln0IAMOL6Yf
         6iV3dnAIxbiBWwYMuu+JPN4QRWCaNKTBPuEkh0hUuAl1kMH4Li8gzFbtnrt6RWZ2G/Ak
         JvuGpAnl8VLTouUZ7Gi4WuampEOtAB/Naa4uqVD6FRvL5tThZuFw4KgqLTe8BhHaW535
         yU4N+8jcJcPcf2ItCUBmv1WlcgQi+kIiMxbLchuD7Kb5w3Ujy6AeCSLEYQGgsxN32BSO
         Q2BsOEZCgqFVZQfKkmDUKO1ouAPH7sCGexcv9yGJXA1WojGJcQgqfNqFb3a9KW+N+tKI
         UJfg==
X-Gm-Message-State: APjAAAXdtJwvJRMofiMSKCqhNwTP+m9z5gSTIIkaWJ5StClZBVhDOYJo
        XeeOIinORFjYI4IVWs30sO3rd5ioOzDbJ3Rp9DU=
X-Google-Smtp-Source: APXvYqyPIvypfDCs30t1gqIpepbgvzYop6gWlF2t/0E8yKfq7mJSeQh1VrOYGs6HAAT3CzMUeucf0TINV6jaGNWPijE=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr225722otr.262.1579813357759;
 Thu, 23 Jan 2020 13:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-5-douglas.raillard@arm.com> <CAJZ5v0gP5v3LzU-uGyHpoJV8z+E2heR1PEQp+c=L7RZS3FzCWg@mail.gmail.com>
 <9b5afae9-0cf5-6c3a-b94b-0796da4e6a71@arm.com>
In-Reply-To: <9b5afae9-0cf5-6c3a-b94b-0796da4e6a71@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 22:02:26 +0100
Message-ID: <CAJZ5v0h8=Kh-xutPMf110UOrRfEQtjjOTneZaWoZLaYO=Bfm1A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        qperret@google.com, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 23, 2020 at 6:21 PM Douglas Raillard
<douglas.raillard@arm.com> wrote:
>
>
>
> On 1/23/20 3:55 PM, Rafael J. Wysocki wrote:
> > On Wed, Jan 22, 2020 at 6:36 PM Douglas RAILLARD
> > <douglas.raillard@arm.com> wrote:
> >>
> >> Use the utilization signals dynamic to detect when the utilization of a
> >> set of tasks starts increasing because of a change in tasks' behavior.
> >> This allows detecting when spending extra power for faster frequency
> >> ramp up response would be beneficial to the reactivity of the system.
> >>
> >> This ramp boost is computed as the difference between util_avg and
> >> util_est_enqueued. This number somehow represents a lower bound of how
> >> much extra utilization this tasks is actually using, compared to our
> >> best current stable knowledge of it (which is util_est_enqueued).
> >>
> >> When the set of runnable tasks changes, the boost is disabled as the
> >> impact of blocked utilization on util_avg will make the delta with
> >> util_est_enqueued not very informative.
> >>
> >> Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
> >> ---
> >>  kernel/sched/cpufreq_schedutil.c | 43 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 43 insertions(+)
> >>
> >> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >> index 608963da4916..25a410a1ff6a 100644
> >> --- a/kernel/sched/cpufreq_schedutil.c
> >> +++ b/kernel/sched/cpufreq_schedutil.c
> >> @@ -61,6 +61,10 @@ struct sugov_cpu {
> >>         unsigned long           bw_dl;
> >>         unsigned long           max;
> >>
> >> +       unsigned long           ramp_boost;
> >> +       unsigned long           util_est_enqueued;
> >> +       unsigned long           util_avg;
> >> +
> >>         /* The field below is for single-CPU policies only: */
> >>  #ifdef CONFIG_NO_HZ_COMMON
> >>         unsigned long           saved_idle_calls;
> >> @@ -183,6 +187,42 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
> >>         }
> >>  }
> >>
> >> +static unsigned long sugov_cpu_ramp_boost(struct sugov_cpu *sg_cpu)
> >> +{
> >> +       return READ_ONCE(sg_cpu->ramp_boost);
> >> +}
> >
> > Where exactly is this function used?
>
> In the next commit where the boost value is actually used to do
> something. The function is introduced here to keep the
> WRITE_ONCE/READ_ONCE pair together.

But ramp_boost itself is not really used in this patch too AFAICS.
