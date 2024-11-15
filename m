Return-Path: <linux-pm+bounces-17635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719089CF115
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A703AB2DEE7
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3871D54E3;
	Fri, 15 Nov 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llCfQuEo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C381D5173
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684615; cv=none; b=LduTsP88y/TIvOVjDsnlqhLTobPdwBr8Ud+zHRk/Bqy+wfTcWc11h+Ot11ir7cSY/DzLMksdkOV0HEtbCir+rzb9/kHsyQv7pqQLKCpOf7XU4Q7DB0IWT+eE86x1SdUlg8x+MlIGUAUL/Sgq5pXlBLibVJLTs71SlM/LmCjR2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684615; c=relaxed/simple;
	bh=BTJWNGbpl5KvD6H+VDgOWo2Yq5EF8KYra7F4VvHtP7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FC2+O1iHPo08eJQyW3ddHxVz+FFS30CGWObK0hDiPV9r2pYQglt2uMcPSzuTzks6bdKMX9r4zPI3xrCv07I3LKwUUVSMf5cmCKUGfivh94wxPeFaTjqNVLYUJ65X3RJzFbuV/7Kh5h5AASWEkLM0z4H562cvpOycANprqviTcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=llCfQuEo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea08667b23so1566042a91.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 07:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731684613; x=1732289413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmJxOZsK/WTy1TwXxhvCivxQcUc93pFDymw3BaVCfLw=;
        b=llCfQuEoChGIMnRdPKBRn4pxI/jgngEe9olxAAFvIQZA92bWVh4FoMMKYOT96qVAkm
         CYsGYfqMdy2mRb72p4rM3uDj4ZNNTtBNrZzY8LD7wVzrrrENq8+0ywUP5U7Hlqg5sXo6
         PkrLnkYwDw8I04yq3/m7KLTBmLijwM2fwzrFwtk0GM5ynlWi6otmUTzZvC5R5U5nQ+/z
         VE1kETpE3VWjf8A2GUDQDAH8lSRxCq7Ww6PjRpF9OYBjfVM532wIbq32x7T3bsBlFOBI
         dfJc8jMYXfVv5DxoWHp9EznIt4gD66ZWAWV5IJdYiFmKSA5WOuWLHQMoYunPhxFj6RDl
         swuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684613; x=1732289413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmJxOZsK/WTy1TwXxhvCivxQcUc93pFDymw3BaVCfLw=;
        b=Jj2r9EmVYi45/eWuMTuhmW2G8ilQhEDi9gG0lIm97Z9ZMZp0K6IYTynNBhZZkgY17x
         0GKgYm3XokacJ5dtbPd/rn9czN71/xTE/gG92+BJyVnwvwYJVeC3hW8VBTdPMBI5n6OJ
         MdkPYv9hhFgvv2QJohKtl0vZHVNX2y8Toi+ptw+zvJpHv8qHDAVmM7Zv5LbBx2aVdKoT
         JsajgR0cAhnBQpW83n4Z1bQiCMGntgHtiKkQ+cfus/76Kd8pM88ixT28O4UGxPH34nWT
         +SGFDrAVx3RP0gcsksKQnyyrZlZI3FzfzoEgEEK3y9RB0bFjn5pnJV1pfY47etQtWTUX
         mVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1AebyzP0VG2NcYWX55NrIoS3ucrrIF+kCoG6bwWfDtb6iIXPcSkgANGFaqqdw/pvaqc1EW/naZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWakuJM+uaim9Vm1oWbPJFoyG9E7/cEG9SxcZcFgrxOgVZEom1
	EjtEoNPZqQsuSjLhJlFXN1lQzSrujqDork5eMw4GsHsmQSdk/dSsFe9qPrFdyHhoWokW3/io2wU
	pq7C3uyaretITg0Qh6tF/iv64OmZn0N27KiYq4w==
X-Google-Smtp-Source: AGHT+IG+PpsGMG3D9PHGUTyU+b4ehE7tPO3iApsCyt2WZs25ja3VpgyyqO4OP9BJpQwEMK+Fcj307W6uEdNaV+/TXgM=
X-Received: by 2002:a17:90b:4c52:b0:2e2:cef9:4d98 with SMTP id
 98e67ed59e1d1-2ea155a23bcmr3340237a91.25.1731684612942; Fri, 15 Nov 2024
 07:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-6-saravanak@google.com> <CAGETcx8xni1vyoNts=C=dgEaMcfhsfo0B5Ef02jD3in0QqCB1w@mail.gmail.com>
In-Reply-To: <CAGETcx8xni1vyoNts=C=dgEaMcfhsfo0B5Ef02jD3in0QqCB1w@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 15 Nov 2024 16:30:01 +0100
Message-ID: <CAKfTPtBZVKXoJPz0w2-WxOddfq5k+mNCB3H_Kay6Y9OgB9Y-GQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during
 dpm_resume*() phases
To: Saravana Kannan <saravanak@google.com>
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

On Fri, 15 Nov 2024 at 06:25, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Nov 14, 2024 at 2:09=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
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

extern void sched_set_energy_aware(unsigned int enable);

clear the warning

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
>   CC      kernel/sched/build_utility.o
> In file included from kernel/sched/build_utility.c:88:
> kernel/sched/topology.c:287:6: warning: no previous prototype for
> =E2=80=98sched_set_energy_aware=E2=80=99 [-Wmissing-prototypes]
>   287 | void sched_set_energy_aware(unsigned int enable)
>       |      ^~~~~~~~~~~~~~~~~~~~~~
>
> Peter/Vincent,
>
> I noticed that I'm getting a warning for this line. But I'm not sure
> what to do about it. I intentionally didn't put this in a header file
> because I'm guessing we don't want to make this available to
> drivers/frameworks in general.
>
> Let me know how you want me to handle this.
>
> -Saravana
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

