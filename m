Return-Path: <linux-pm+bounces-17647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2689CF41A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 19:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE0CB2AFA4
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B074185B48;
	Fri, 15 Nov 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9aAu6Ul"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D403183088
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695651; cv=none; b=HUclANp79U/VqaTsrzkG0eMcrzcK+B6THUCAuMTStzpQYHlBe9HARLmq7JoV3qoLBXBhP04AyRhnDnFoc2h2urdB/Mqth+XqWNzU7roHU5llZzE/tO9QOdSRJuOxDtPfpdeSBc7m2THeYK8wFP0yh8ygjVD0c64UkrqRxWQaR+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695651; c=relaxed/simple;
	bh=3h5kUMvphD9EcDhaC9fPuRm5yVEsbmXmzQxGBLAf1e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ywd2YaWrKe6ii3hGrf3NHrIfv1+l21sc4Ea2WH6zLwkIop8uFUNSNPr7THovfZuLo+RAXo7dXBbt1fSUITgXC5+o/B9MDzMjOqfKgEwevbzFbR4IVTtP9BVPQcKeWtJzNUbugElcysPl25J7LlsQqFo0uifxmYo0KVFSp5rHy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9aAu6Ul; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72410cc7be9so1920389b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 10:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731695650; x=1732300450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iRzdScLNs2sJWthnnu9cg8AR50zZitK+3FhL3wS9Gk=;
        b=U9aAu6UlGOYNdeiSe10hI6r/N4+gE4v+etBIdxYUTTxqWJsdgHaCMK9vZ8L47f6thm
         Z3/0WCy7BDibxutC8ON/UDlKb8GvLYRSc5eyCYM1w/LQtVEb/fLV01Bebn/zEnf6w7j7
         N3dBnDQpWtbcU5B5UvW5wpxmvgOE3o6t4nAyak8g+H/GUxbJDEYb1yKtg1C9I42bgZ7j
         WXUxp+IghTvuLB4jtdoJUUYv2y7AEG9e1owqhQrQYpZste45nXvd65BKIh7/r0q7rYAF
         wlZK/l5aSU1tAAo6wkmyebeJS+GrXjEsML5ssuayRcPP+UlbFaCNXT6MRewJhst/+jAG
         0eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731695650; x=1732300450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iRzdScLNs2sJWthnnu9cg8AR50zZitK+3FhL3wS9Gk=;
        b=aCrYcAqPB+r3olKwS+WCB0AS69GU92I1im0YvUnvLc2igikNYnn7KITsK3PY5JwC1Z
         VRTj7TLeBDYqMNK/Hw6pbbgcLtNWPfk6m7K+V3ubTyi5SQcDToFxWbnnn7Iu2eqCztgq
         DO5GdaZ5UbA7AxwhN4ZQSP/Uh/UoRbzZIsA+DbCYSKWZkgIKPb6OM3IUTlc3XvM7Pgg9
         f9MKwPJYZySHJisq3QiDZvCq/tLEdkqOWMdWSim21nuW1ThxxoVH2qKB5PYZryzpMAoa
         MAA9JNnd8k7PbvQLyLodFTFuGeVk32CvYzRwx6euOQE3vPnE0M0HGq4XSLLdXcdXiyQc
         yJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUu5qmqEL/gK5F7T92J3CvTU3V1MYJyYl9MIUgJtyOG5f7lRsWWs8VUJTPH9BwHystiZkaNt7BF4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GJq34pXLLWjUQ/+cXK0VI0/tl5co8e/Mw4ITMNv7g4FF3fuI
	LD6jSfa5LkyXLDLDkA/fGmkHKq3aIYfA/F5GSKfNmF3fUQSP8+UUafO2es2cSjisvkLALdW2Wlg
	Gojg9mrMxkitAyL/MNGazQ3LXu0MoWBAobPAd
X-Google-Smtp-Source: AGHT+IEH27SSGgcQkgj+0KAZtxEVpGt31YF9/pVru611lrbV81qCn04TUZu4o+aVejRR6yFwkAl6JtXd7N6MQGf4nNA=
X-Received: by 2002:a05:6a00:3e12:b0:71e:7cb2:57e7 with SMTP id
 d2e1a72fcca58-72476b96c11mr5186093b3a.10.1731695649277; Fri, 15 Nov 2024
 10:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-6-saravanak@google.com> <CAKfTPtDYdFQoFjF8zXxXEEcx3frXoSSKxnPonQ6R8eEAJWkVWQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDYdFQoFjF8zXxXEEcx3frXoSSKxnPonQ6R8eEAJWkVWQ@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 15 Nov 2024 10:33:32 -0800
Message-ID: <CAGETcx9d0DuxHyuvH4e3znHUdmxMCjih8NWSabjqDqJ+TXmduQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during
 dpm_resume*() phases
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 8:13=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 14 Nov 2024 at 23:09, Saravana Kannan <saravanak@google.com> wrot=
e:
> >
> > As of today, the scheduler doesn't spread out all the kworker threads
> > across all the available CPUs during suspend/resume. This causes
> > significant resume latency during the dpm_resume*() phases.
> >
> > System resume latency is a very user-visible event. Reducing the
> > latency is more important than trying to be energy aware during that
> > period.
> >
> > Since there are no userspace processes running during this time and
> > this is a very short time window, we can simply disable EAS during
> > resume so that the parallel resume of the devices is spread across all
> > the CPUs.
> >
> > On a Pixel 6, averaging over 100 suspend/resume cycles, the new logic
> > plus disabling EAS for resume yields significant improvements:
> > +---------------------------+-----------+------------+-----------------=
-+
> > | Phase                     | Old full sync | New full async | % change=
 |
> > |                           |               | + EAS disabled |         =
 |
> > +---------------------------+-----------+------------+-----------------=
-+
> > | Total dpm_suspend*() time |        107 ms |          62 ms |     -42%=
 |
> > +---------------------------+-----------+------------+-----------------=
-+
> > | Total dpm_resume*() time  |         75 ms |          61 ms |     -19%=
 |
> > +---------------------------+-----------+------------+-----------------=
-+
> > | Sum                       |        182 ms |         123 ms |     -32%=
 |
> > +---------------------------+-----------+------------+-----------------=
-+
>
> in cover letter you have figures for
>  - Old full sync
>  - New full async
>  - New full async  + EAS disabled
>
> you should better use the figures for  New full async vs New full
> async  + EAS disabled to show EAS disabled impact

I do give those numbers in the commit text of each patch making the changes=
.

Patch 4 commit text shows how it's improving things compared to the
older logic full sync (this is the baseline) - resume is 1% faster.
Patch 5 commit text shows you how disabling EAS is improving numbers
compared to baseline - resume 19% faster.

So, yeah, all the numbers are there in one of these emails. Patch 5
(which is the only one touching EAS) is the one that has the
comparison you are asking for.

> I would be interested to get figures about the impact of disabling it
> during full suspend sequence as I'm not convince that it's worth the
> complexity especially with fix OPP during suspend

1. Device suspend actually got worse by 5ms or so. I already provided that.

2. As I said in the Patch 5, suspend is more about reducing the energy
going into suspend. It's a balance of how quick you can be to how much
power you use to be quick. So, disabling EAS across all of
suspend/resume will have a huge impact on power because userspace is
still running, there are a ton of threads and userspace could get
preempted between disabling suspend and kicking off suspend. Lots of
obvious power concerns overall.

Thanks,
Saravana

>
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  kernel/power/suspend.c  | 16 ++++++++++++++++
> >  kernel/sched/topology.c | 13 +++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 09f8397bae15..7304dc39958f 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -393,6 +393,12 @@ void __weak arch_suspend_enable_irqs(void)
> >         local_irq_enable();
> >  }
> >
> > +/*
> > + * Intentionally not part of a header file to avoid risk of abuse by o=
ther
> > + * drivers.
> > + */
> > +void sched_set_energy_aware(unsigned int enable);
> > +
> >  /**
> >   * suspend_enter - Make the system enter the given sleep state.
> >   * @state: System sleep state to enter.
> > @@ -468,6 +474,15 @@ static int suspend_enter(suspend_state_t state, bo=
ol *wakeup)
> >
> >   Platform_wake:
> >         platform_resume_noirq(state);
> > +       /*
> > +        * We do this only for resume instead of suspend and resume for=
 these
> > +        * reasons:
> > +        * - Performance is more important than power for resume.
> > +        * - Power spent entering suspend is more important for suspend=
. Also,
> > +        *   stangely, disabling EAS was making suspent a few milliseco=
nds
> > +        *   slower in my testing.
> > +        */
> > +       sched_set_energy_aware(0);
> >         dpm_resume_noirq(PMSG_RESUME);
> >
> >   Platform_early_resume:
> > @@ -520,6 +535,7 @@ int suspend_devices_and_enter(suspend_state_t state=
)
> >   Resume_devices:
> >         suspend_test_start();
> >         dpm_resume_end(PMSG_RESUME);
> > +       sched_set_energy_aware(1);
>
> If we end up having a special scheduling mode during suspend, we
> should make the function more generic and not only EAS/ smartphone
> specific
>
> Like a sched_suspend and sched_resume
>
> >         suspend_test_finish("resume devices");
> >         trace_suspend_resume(TPS("resume_console"), state, true);
> >         resume_console();
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9748a4c8d668..c069c0b17cbf 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -284,6 +284,19 @@ void rebuild_sched_domains_energy(void)
> >         mutex_unlock(&sched_energy_mutex);
> >  }
> >
> > +void sched_set_energy_aware(unsigned int enable)
>
> This is a copy/paste of sched_energy_aware_handler() below, we should
> have 1 helper for both
>
> > +{
> > +       int state;
> > +
> > +       if (!sched_is_eas_possible(cpu_active_mask))
> > +               return;
> > +
> > +       sysctl_sched_energy_aware =3D enable;
> > +       state =3D static_branch_unlikely(&sched_energy_present);
> > +       if (state !=3D sysctl_sched_energy_aware)
> > +               rebuild_sched_domains_energy();
> > +}
> > +
> >  #ifdef CONFIG_PROC_SYSCTL
> >  static int sched_energy_aware_handler(const struct ctl_table *table, i=
nt write,
> >                 void *buffer, size_t *lenp, loff_t *ppos)
> > --
> > 2.47.0.338.g60cca15819-goog
> >

