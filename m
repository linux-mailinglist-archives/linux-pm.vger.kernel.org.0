Return-Path: <linux-pm+bounces-17604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA59CDB81
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CEB1F22408
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90718CC1C;
	Fri, 15 Nov 2024 09:25:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D45186295;
	Fri, 15 Nov 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662720; cv=none; b=XxawebfF4HW1LCQBJRHr46pY3uZbtx6NZ0Ir4zoX/rpjG5N30Rb0utUmFfPrXmuaIFxKgvGjoWPyNPOjWuDh7eCpAhJITjqHVNAx62FCwl9SEKVqPHrjQKfIECjoGse5fsdTOlrYeRHlLR3qGKtfvuEGxNtec0GbYYeDo/LfxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662720; c=relaxed/simple;
	bh=ERa5WYGTtwx3L0zJjASxr5QfIVoE8Q4QH+boOQoZ0hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFUNRI1rzV2m5D/+eLrYVkuB9xNEg6BFGOOVZMGtJ3vJac4sOcJyjN0CbHri7I4y9zPIaHt5ISToKaCQfobcL52VOK1kgAxtgXyEcWKBYqDUg0inHSV8Uu6cO9smx7IwXAfVogKR3POYJZRZAPYpqLaj3h2IVsNi1ytnG6rd4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea7c9226bbso17434167b3.3;
        Fri, 15 Nov 2024 01:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662716; x=1732267516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NIljxAt/VoeNXqks0tIuucyMvh7o2GfuF/8F2vXkhM=;
        b=rPK99qUUQMTZvW6vKbNMa4X+tjpCRA/cd403W87xeLn3ULm0JVG4xjDV/kOQKzOQj5
         TBzJ00t8HokgjWs9OiKPYv2auLLu0xD1VDXyuNB8/AZdaTr1SsDTI+66+a29n6ZQ7vZ4
         pfWdX5s4fYMUzxYlpjOot7QLc2YDp8u8od866Lu+QiqbkWbHOW1SpSTbjaIducXm10cN
         9v6htHpAIGpK0NMwLYFyJ1c2rOxXX9E8KJEJQe2F/3HtYj07WpRftl8JSeKi8uYHt48v
         921LyN/9eNd8D7cKob0Hnq1SjW0uw7KsTPlVUNWRDLTxm9airRgFayNd/KAjVqNhUwEo
         bmAg==
X-Forwarded-Encrypted: i=1; AJvYcCUVqErmqmoS+ALHWbm9MndpmprdtVt9UoCq+9miPx8HhzvlFtWj7HAjYeedmJp072wHMRF2rAx891U=@vger.kernel.org, AJvYcCV7PiL+wUub3AKVdu0yuR9Rz6sgr6906VqzJfN+1gWn6wRhYg6i9cgwtDMJPafAS0/O+bwat9/cGkxp4v0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NbaOMyZMMAgmLKrdh8k13qgbSzeQVTCES/Qa2SyDyk0bmQfR
	MnIRq3XqdpxUuqNWkR/N0Wr0S2cnDD86nDzioC7yw9NpMVgD9HLUU5weUZTw
X-Google-Smtp-Source: AGHT+IFus39Wv/bZT0T7FhydQJCjm9QXoxPiVWbf+EatqsLkjRI8B77U+jMPnvCZNPvAmbn8WgMgFA==
X-Received: by 2002:a05:690c:4444:b0:6e2:7dd:af66 with SMTP id 00721157ae682-6ee55c1dce0mr20812357b3.19.1731662716109;
        Fri, 15 Nov 2024 01:25:16 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4404661esm6533557b3.31.2024.11.15.01.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:25:15 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea07d119b7so13706367b3.0;
        Fri, 15 Nov 2024 01:25:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUws5XNFmqeXyPji4ra3H1KIlIbDolOkjnPfQR4VcD5do1QRtCTZZDt0yjntARpw8KeWefGmHZwrk8cSOI=@vger.kernel.org, AJvYcCWiwDcdyZYma4FePfEYRMkmJD8k3wqt1Y6dP8rX9P5Fa1w0cw/yc9dtEJXoX8vXa9BWPl0Qx+eaiyc=@vger.kernel.org
X-Received: by 2002:a05:690c:6806:b0:6ea:86b6:f703 with SMTP id
 00721157ae682-6ee55b95922mr25021017b3.1.1731662713877; Fri, 15 Nov 2024
 01:25:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-6-saravanak@google.com> <CAGETcx8xni1vyoNts=C=dgEaMcfhsfo0B5Ef02jD3in0QqCB1w@mail.gmail.com>
In-Reply-To: <CAGETcx8xni1vyoNts=C=dgEaMcfhsfo0B5Ef02jD3in0QqCB1w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Nov 2024 10:25:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUVj8m8JkKgH0fYQ=55F8GCcW=GA6ftbqsOJn34NLS_YQ@mail.gmail.com>
Message-ID: <CAMuHMdUVj8m8JkKgH0fYQ=55F8GCcW=GA6ftbqsOJn34NLS_YQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during
 dpm_resume*() phases
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Marek Vasut <marex@denx.de>, Bird@google.com, 
	Tim <Tim.Bird@sony.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Fri, Nov 15, 2024 at 6:25=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
> On Thu, Nov 14, 2024 at 2:09=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
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

Put the prototype in kernel/sched/sched.h, and include
../sched/sched.h from kernel/power/suspend.c?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

