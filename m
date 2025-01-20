Return-Path: <linux-pm+bounces-20698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C3EA17015
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 17:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F990188068D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AEA1E98E6;
	Mon, 20 Jan 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1IPhPI0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ADD19BA6;
	Mon, 20 Jan 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390261; cv=none; b=nXfpY4MYbX2lyU+pcPH3pbK27sc+2A3sOYarMhtqoJCJ0wH7yVvo2QZvhm5giLrwnihbdpyx2H6ug8LQ2rX18lzNDzEO0j7zuHLNNO/qR8IEP+FfiMyt4yS+Vz7K8BtZka9xR8E0FJEOFEufqvOIr2Wj65wLvXa/sTBQ/A1y7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390261; c=relaxed/simple;
	bh=7V6OfoanT6uJzAPieF+bgx+SST0nWWXVoglA03c7WQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bufF9Mdu6baQ1JFjVwVxLu7HCNYZtYqP+ZdaU+m4GasVKoix630eKv2DT5LhUYcW4AQx28utUYpojdIwf/vfekK0PfpNEm2H1+ApF+U3dMQRpGZAOIsH1KLTfzLjyIyLCvoKaQq3mxaZWxmPBZBwHCissgeYgprJekRs+rsRmoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1IPhPI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAF9C4CEE5;
	Mon, 20 Jan 2025 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737390260;
	bh=7V6OfoanT6uJzAPieF+bgx+SST0nWWXVoglA03c7WQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T1IPhPI0PqXK4caId4EH2W7don+r0WP2AvM+UTuj/wMet0i84HlneYBvE/eu3ipOr
	 D6Tb+42pPbK72l+ZBQF0fE8yEp1dKzr5SzBNked+D9HFb/4udIIunGuOt6ygn2HUWt
	 Yrkpg1FFPaaktZXKv2sOSsHuFtTRpRJCdq28JXj6JxAb4n1i9QWb2dorsYMnjMPyLy
	 xLM7OJF5LTqOV0tVHKdmIiCwh28LvRyOvP28k4id2LTC8m3L/JYbhKunReRd3G3PdF
	 a0X3OaVF71UfKmz146vj53DheMX2PiFkUGzfpYFjuyH8iKnTzkiU5lN6pYKeQl6iT1
	 EykHsNbyLWYng==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e19fee3b3so2893048a34.0;
        Mon, 20 Jan 2025 08:24:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSqCLuxN/nAVf+uW7VhM28ggpLzsyStzQgA99hRqZ7/x1fhkJVpRPx9r9XqfTaG3vc7SsN90XMqI0=@vger.kernel.org, AJvYcCXo4TDLkgSgqxdiCu9Zjp5SRxhhnXpjXeoMhxpUlXWeHOG4vrZXOlT8mVsodzE0hCCX+vL20u78aZkzhag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYoVZ+E4FKrvw3nnuAH7grraP0zdohZ7or1Mpcm/nsyL3Pz9/
	52oOygjj0NAZ0iYCRLsSTtSUcqtvByVzi2zY/i2ZTJHv2IjGKfJ6r6Y4umfOAL7vsneXnaQQenl
	2URcsL1M7M7d+VWKfq93KUJ3+9aM=
X-Google-Smtp-Source: AGHT+IFBH9G17TcoktkCeQYrYmVF2niWLYGVBD8jLqYcLK9frHq6uGFCsaOLmIlmBQ106j2KNyHxkCxjnAWl16Ak2c8=
X-Received: by 2002:a9d:7313:0:b0:71d:e5e2:c648 with SMTP id
 46e09a7af769-724858ecd2dmr12859046a34.1.1737390259770; Mon, 20 Jan 2025
 08:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6116275.lOV4Wx5bFT@rjwysocki.net> <3851791.kQq0lBPeGt@rjwysocki.net>
 <f1f6fe0e-6d6f-442b-87d2-dd15d2e022bc@arm.com>
In-Reply-To: <f1f6fe0e-6d6f-442b-87d2-dd15d2e022bc@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Jan 2025 17:24:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iZ9z_rfD4raSD9n-HQGYKy85A=u3MdC7DJUAmyh8dmkw@mail.gmail.com>
X-Gm-Features: AbW1kvaqhC5NKap-CwzNWKpmi6pkpSfMEy2sHHWHWzmEIsYFxyARNMkW5w3wLeM
Message-ID: <CAJZ5v0iZ9z_rfD4raSD9n-HQGYKy85A=u3MdC7DJUAmyh8dmkw@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] cpuidle: teo: Skip getting the sleep length is
 wakeups are very frequent
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:08=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/13/25 18:48, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
>
> Title has a typo: s/is/if

Fixed when applying the patch.

> > Commit 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length()
> > call in some cases") attempted to reduce the governor overhead in some
> > cases by making it avoid obtaining the sleep length (the time till the
> > next timer event) which may be costly.
> >
> > Among other things, after the above commit, tick_nohz_get_sleep_length(=
)
> > was not called any more when idle state 0 was to be returned, which
> > turned out to be problematic and the previous behavior in that respect
> > was restored by commit 4b20b07ce72f ("cpuidle: teo: Don't count non-
> > existent intercepts").
> >
> > However, commit 6da8f9ba5a87 also caused the governor to avoid calling
> > tick_nohz_get_sleep_length() on systems where idle state 0 is a "pollin=
g"
> > one (that is, it is not really an idle state, but a loop continuously
> > executed by the CPU) when the target residency of the idle state to be
> > returned was low enough, so there was no practical need to refine the
> > idle state selection in any way.  This change was not removed by the
> > other commit, so now on systems where idle state 0 is a "polling" one,
> > tick_nohz_get_sleep_length() is called when idle state 0 is to be
> > returned, but it is not called when a deeper idle state with
> > sufficiently low target residency is to be returned.  That is arguably
> > confusing and inconsistent.
> >
> > Moreover, there is no specific reason why the behavior in question
> > should depend on whether or not idle state 0 is a "polling" one.
> >
> > One way to address this would be to make the governor always call
> > tick_nohz_get_sleep_length() to obtain the sleep length, but that would
> > effectively mean reverting commit 6da8f9ba5a87 and restoring the latenc=
y
> > issue that was the reason for doing it.  This approach is thus not
> > particularly attractive.
> >
> > To address it differently, notice that if a CPU is woken up very often,
> > this is not likely to be caused by timers in the first place (user spac=
e
> > has a default timer slack of 50 us and there are relatively few timers
> > with a deadline shorter than several microseconds in the kernel) and
> > even if it were the case, the potential benefit from using a deep idle
> > state would then be questionable for latency reasons.  Therefore, if th=
e
> > majority of CPU wakeups occur within several microseconds, it can be
> > assumed that all wakeups in that range are non-timer and the sleep
> > length need not be determined.
> >
> > Accordingly, introduce a new metric for counting wakeups with the
> > measured idle duration below RESIDENCY_THRESHOLD_NS and modify the idle
> > state selection to skip the tick_nohz_get_sleep_length() invocation if
> > idle state 0 has been selected or the target residency of the candidate
> > idle state is below RESIDENCY_THRESHOLD_NS and the value of the new
> > metric is at least 1/2 of the total event count.
> >
> > Since the above requires the measured idle duration to be determined
> > every time, except for the cases when one of the safety nets has
> > triggered in which the wakeup is counted as a hit in the deepest
> > idle state idle residency range, update the handling of those cases
> > to avoid skipping the idle duration computation when the CPU wakeup
> > is "genuine".
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |   58 ++++++++++++++++++++++++-------=
---------
> >  1 file changed, 36 insertions(+), 22 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -129,6 +129,7 @@
> >   * @state_bins: Idle state data bins for this CPU.
> >   * @total: Grand total of the "intercepts" and "hits" metrics for all =
bins.
> >   * @tick_intercepts: "Intercepts" before TICK_NSEC.
> > + * @short_idle: Wakeups after short idle periods.
> >   */
> >  struct teo_cpu {
> >       s64 time_span_ns;
> > @@ -136,6 +137,7 @@
> >       struct teo_bin state_bins[CPUIDLE_STATE_MAX];
> >       unsigned int total;
> >       unsigned int tick_intercepts;
> > +     unsigned int short_idle;
>
> Maybe call these short_idles?

I renamed it accordingly when applying the patch.

> >  };
> >
> >  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> > @@ -152,12 +154,12 @@
> >       s64 target_residency_ns;
> >       u64 measured_ns;
> >
> > -     if (cpu_data->time_span_ns >=3D cpu_data->sleep_length_ns) {
> > +     cpu_data->short_idle -=3D cpu_data->short_idle >> DECAY_SHIFT;
> > +
> > +     if (cpu_data->time_span_ns < 0) {
> >               /*
> > -              * This causes the wakeup to be counted as a hit regardle=
ss of
> > -              * regardless of the real idle duration which doesn't nee=
d to be
> > -              * computed because the wakeup has been close enough to a=
n
> > -              * anticipated timer.
> > +              * If one of the safety nets has triggered, assume that t=
his
> > +              * might have been a long sleep.
> >                */
> >               measured_ns =3D U64_MAX;
> >       } else {
> > @@ -177,10 +179,14 @@
> >                * time, so take 1/2 of the exit latency as a very rough
> >                * approximation of the average of it.
> >                */
> > -             if (measured_ns >=3D lat_ns)
> > +             if (measured_ns >=3D lat_ns) {
> >                       measured_ns -=3D lat_ns / 2;
> > -             else
> > +                     if (measured_ns < RESIDENCY_THRESHOLD_NS)
> > +                             cpu_data->short_idle +=3D PULSE;
> > +             } else {
> >                       measured_ns /=3D 2;
> > +                     cpu_data->short_idle +=3D PULSE;
> > +             }
> >       }
> >
> >       cpu_data->total =3D 0;
> > @@ -419,27 +425,35 @@
> >       if (idx > constraint_idx)
> >               idx =3D constraint_idx;
> >
> > -     if (!idx) {
> > -             /*
> > -              * Query the sleep length to be able to count the wakeup =
as a
> > -              * hit if it is caused by a timer.
> > -              */
> > -             cpu_data->sleep_length_ns =3D tick_nohz_get_sleep_length(=
&delta_tick);
> > -             goto out_tick;
> > -     }
> > -
> >       /*
> > -      * If state 0 is a polling one, check if the target residency of
> > -      * the current candidate state is low enough and skip the timers
> > -      * check in that case too.
> > +      * If either the candidate state is state 0 or its target residen=
cy is
> > +      * low enough, there is basically nothing more to do, but if the =
sleep
> > +      * length is not updated, the subsequent wakeup will be counted a=
s an
> > +      * "intercept" which may be problematic in the cases when timer w=
akeups
> > +      * are dominant.  Namely, it may effectively prevent deeper idle =
states
> > +      * from being selected at one point even if no imminent timers ar=
e
> > +      * scheduled.
> > +      *
> > +      * However, frequent timers in the RESIDENCY_THRESHOLD_NS range o=
n one
> > +      * CPU are unlikely (user space has a default 50 us slack value f=
or
> > +      * hrtimers and there are relatively few timers with a lower dead=
line
> > +      * value in the kernel), and even if they did happene, the potent=
ial
>
> s/happene/happen

Fixed when applying the patch.

> > +      * benefit from using a deep idle state in that case would be
> > +      * questionable anyway for latency reasons.  Thus if the measured=
 idle
> > +      * duration falls into that range in the majority of cases, assum=
e
> > +      * non-timer wakeups to be dominant and skip updating the sleep l=
ength
> > +      * to reduce latency.
> >        */
> > -     if ((drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
> > -         drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS=
)
> > +     if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THR=
ESHOLD_NS) &&
> > +         2 * cpu_data->short_idle >=3D cpu_data->total)
> >               goto out_tick;
> >
> >       duration_ns =3D tick_nohz_get_sleep_length(&delta_tick);
> >       cpu_data->sleep_length_ns =3D duration_ns;
> >
> > +     if (!idx)
> > +             goto out_tick;
> > +
> >       /*
> >        * If the closest expected timer is before the target residency o=
f the
> >        * candidate state, a shallower one needs to be found.
> > @@ -501,7 +515,7 @@
> >       if (dev->poll_time_limit ||
> >           (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TIC=
K_NSEC)) {
> >               dev->poll_time_limit =3D false;
> > -             cpu_data->time_span_ns =3D cpu_data->sleep_length_ns;
> > +             cpu_data->time_span_ns =3D KTIME_MIN;
> >       } else {
> >               cpu_data->time_span_ns =3D local_clock() - cpu_data->time=
_span_ns;
> >       }
> >
>
> Thanks, I like this approach.
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thank you!

