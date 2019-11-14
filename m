Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711C1FCB68
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 18:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKNRGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 12:06:36 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33194 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfKNRGg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 12:06:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id d6so5682958lfc.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 09:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUshx25ptyYHMcSI3qBArBPZRmtiuT1b7sUSIZ582Mk=;
        b=ZdVr8Kefhung4i+R4Al9a1AzRSpC7dEEu/I59uddd99N3XirlBFUi9OSV3ELUSWDxw
         UoWQwG3YcudsiX15JyNbSjYh/EG3of68leKVPHFykLWcYOgho7myxA017IkFhVFC53cg
         R21Jk6/a5sltnjpbjdNKMJvijPKDhGFBx3/WROBc2hHu+breKXDdjer+JszSaP5edtux
         nYpofgB3tOI59ar9Y3O0iE2lhFaxR+QoPmQp/+xH9G6liobJ04rxUs1XhlHmEN3KFD/g
         C5lfSagG/vzzUxlaHE6oTk5RLo60qZh1p5QHs2BOm2L9y8VAaY3lPLvZjoIFGkd0oRDF
         OAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUshx25ptyYHMcSI3qBArBPZRmtiuT1b7sUSIZ582Mk=;
        b=G2SmwHkOLGDQQRNO26RVdXhumtD5PAjK/ohN6NDDTKEyt5uCLgvJa8VsXEFwtNviMs
         Xe2cWanamixG6jnaz+CxIkmZwX82Ijy0zhbx4fkI4/t3ecBRTretAZ9S8ComounQCF04
         DmCmlyRmrJDizIfq814R8UcMGpLt7EbKkxBvBJ9yIduDUNeACBihTBZo9VUiLnlKyqG8
         qCQx3wCmj7XaH7KAo4dBOFUppQSd1b3KMTABYvn45s3GOXv9Gr1m1y7WjZzixFqBgCsy
         d7BdKQ7pjyg0Nb9vGUPP5liL9QY3IPGVrdnNVJt47zDa2GBvbMrtm98vdQslJjUon9sg
         sWbw==
X-Gm-Message-State: APjAAAUs/62eBKHXDifr55QUeBNj+NcjFcejPUPMZIaaVcm6ZN7P0dDn
        iB9CKpCkLqnvg0z7mmH3dOXtld2922v+gMaq4Zj6EQ==
X-Google-Smtp-Source: APXvYqyfyZhD8eJoEGu/UwZt7xr5QhuiQJHFQjPAqTi7V65rDkU7hj41uZK2ShCgxorX5yNo7CPl3tyra5v20g5ErFk=
X-Received: by 2002:a19:c215:: with SMTP id l21mr6878085lfc.125.1573751192728;
 Thu, 14 Nov 2019 09:06:32 -0800 (PST)
MIME-Version: 1.0
References: <1573676461-7990-1-git-send-email-vincent.guittot@linaro.org> <5a56358b-83f5-09db-17f0-dbdeecba2ff3@arm.com>
In-Reply-To: <5a56358b-83f5-09db-17f0-dbdeecba2ff3@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Nov 2019 18:06:20 +0100
Message-ID: <CAKfTPtDmr8BY3uy6twPM2e8mcEs+-oaKnMtRt6DEyX4Z8F_Vbw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/freq: move call to cpufreq_update_util
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Nov 2019 at 17:23, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 13.11.19 21:21, Vincent Guittot wrote:
> > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > which might be inefficient when cpufreq driver has rate limitation.
> >
> > When a task is attached on a CPU, we have call path:
> >
> > update_load_avg()
> >   update_cfs_rq_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >   attach_entity_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >
> > The 1st frequency update will not take into account the utilization of the
> > newly attached task and the 2nd one might be discard because of rate
> > limitation of the cpufreq driver.
> >
> > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > and update_load_avg() so we can move the call to
> > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > interesting to notice that update_load_avg() already calls directly
> > cfs_rq_util_change() for !SMP case.
> >
> > This changes will also ensure that cpufreq_update_util() is called even
> > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > irq, rt or dl pelt signals.
> >
> > Reported-by: Doug Smythies <dsmythies@telus.net>
> > Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> > ---
> >
> > changes for v3:
> > - fix typo
> > - test the decay of root cfs_rq even for !CONFIG_FAIR_GROUP_SCHED case
>
> nit: s/!CONFIG_FAIR_GROUP_SCHED/CONFIG_FAIR_GROUP_SCHED
>
> [...]
>
> > @@ -7543,6 +7544,7 @@ static void update_blocked_averages(int cpu)
> >       const struct sched_class *curr_class;
> >       struct rq_flags rf;
> >       bool done = true;
> > +     int decayed;
> >
> >       rq_lock_irqsave(rq, &rf);
> >       update_rq_clock(rq);
> > @@ -7552,9 +7554,9 @@ static void update_blocked_averages(int cpu)
> >        * that RT, DL and IRQ signals have been updated before updating CFS.
> >        */
>
> tip/sched/urgent's b90f7c9d2198 ("sched/pelt: Fix update of blocked PELT
> ordering") adds this comment to both update_blocked_averages()
> implementations. It mentions explicitly that update_cfs_rq_load_avg()
> can call cpufreq_update_util(). Something this patch changes. Might be
> good to update the comments with this patch as well.

yes.

>
> [...]
