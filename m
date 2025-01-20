Return-Path: <linux-pm+bounces-20692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1998A16C7C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE3E1621E9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9661E0DB0;
	Mon, 20 Jan 2025 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRTHBRwk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249061E0B67;
	Mon, 20 Jan 2025 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376995; cv=none; b=t3jX+8Eu00yvBDEykPLqLF/qF+KCUfLNjc3PHLNvNLXK4LDK5DUZghDh+Yc3RlsePrGQdAHy2u+m9q+famUllGNaL4QUXpW8OcraS8zDuq11OUL8BaeyuCTdJRHbtrKbpZEjsp4WREate0iC54O9KHNJ9Ya8wQ51ni0EigGaB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376995; c=relaxed/simple;
	bh=SNk8XAVx9UErM6WkzLFXp9IRTzf3M6V0f7hZmLoqmOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/v1RkEHD3ujLag9CthDUe8XrQ2gYUmZhjBuFM5601S7r/I+ekxo5uTEpP/HPIVtNS/AlsgqYnkASy+YqW33gGP0oaG038OCvkKb6HdIzyHsQQ012j4psKvlaD8kj/JfE3/ubJeBrfI0Q6NQWQjeEh3rh9bdOe1zOrZ4n4F+sF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRTHBRwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847E7C4CEE3;
	Mon, 20 Jan 2025 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737376994;
	bh=SNk8XAVx9UErM6WkzLFXp9IRTzf3M6V0f7hZmLoqmOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lRTHBRwkdSHMToqsc2UjFwDMjDVaD7oP6BIwUD+n2zh/MNYQvjvYxWW/MK1qUR5cE
	 JvQ02quAcoBfyYlD/N5VTEXzjYLev/fhtgqpijfrf89bDpYdaH9WrOXM/XRGAj+Ums
	 zcYhcV2PmnHRO7qLl3GEwWMAGxmu4iy6LrRIroAdRTzg0nzF1UxShudZwOgSLo9i0Z
	 q7ikJtpt4GDoILFHueIZedupYNIUpxxpsBpkbukGYg84dLn/I/ELBZtZ3kNIZIZsh9
	 gmy6TIPf+x+JP7ycAQ/bsozrJD+1S4t98g1rzcmEWmABRzGvoR+mVbbbcimoKR8J/v
	 Vw50WHIwD01kg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eba559611aso1282427b6e.0;
        Mon, 20 Jan 2025 04:43:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWiX52MdP6ERVytNLpruUUUj9u7NU3fwmkC7mBV4x5uO7IpNX58jwZeJy13Dsopkcq80GpX7EjPxY=@vger.kernel.org, AJvYcCWmNxj5HyOmBIRjgxNav9V05uHyzew/rOu5EAZdinmV2QknYTwk5MswT9lLKurLyWHETMj98kitOgBWq64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKL1v0J/VSdw3L/gZD0L2UGgcGuAs/svLJKuNrIbuQ+ibDhzy
	ZXQj5uQZOO32ooa5jVomMvpNNuMc+CYjK2r35GWrv1qheq/FSAGMmG6BsIKzKaTcvHndcLUTaAQ
	0lVJ7J7n4aqbJ+fPU6lM4zDGpCyU=
X-Google-Smtp-Source: AGHT+IFCzIv56nIpr/7HYZWeYLVrOUp8S9GF7bxxesthPbCZEvIMoX5QCQIW42/pgMe4IQ/kAB3tsMlT2neSdkY8f0Q=
X-Received: by 2002:a05:6808:8003:b0:3ea:aa8a:c121 with SMTP id
 5614622812f47-3f19fcbfc1cmr5986249b6e.22.1737376993783; Mon, 20 Jan 2025
 04:43:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6116275.lOV4Wx5bFT@rjwysocki.net> <6010475.MhkbZ0Pkbq@rjwysocki.net>
 <c55e5fa8-a747-4a77-8889-93b4f42bd5c3@arm.com>
In-Reply-To: <c55e5fa8-a747-4a77-8889-93b4f42bd5c3@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Jan 2025 13:42:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gMkjKwFMxdVsKF-t5z=Ue8Wkr9ACK-wgfY+DyEYb=g1g@mail.gmail.com>
X-Gm-Features: AbW1kvZalIWB0nqPbCNFo7hFZRGpjfbiMW03aJip7xyhpfDnJpZy5cLsHGlu_5g
Message-ID: <CAJZ5v0gMkjKwFMxdVsKF-t5z=Ue8Wkr9ACK-wgfY+DyEYb=g1g@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] cpuidle: teo: Replace time_span_ns with a flag
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:16=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/13/25 18:51, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After recent updates, the time_span_ns field in struct teo_cpu has
> > become an indicator on whether or not the most recent wakeup has been
> > "genuine" which may as well be indicated by a bool field without
> > calling local_clock(), so update the code accordingly.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |   27 +++++++++------------------
> >  1 file changed, 9 insertions(+), 18 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -124,20 +124,20 @@
> >
> >  /**
> >   * struct teo_cpu - CPU data used by the TEO cpuidle governor.
> > - * @time_span_ns: Time between idle state selection and post-wakeup up=
date.
> >   * @sleep_length_ns: Time till the closest timer event (at the selecti=
on time).
> >   * @state_bins: Idle state data bins for this CPU.
> >   * @total: Grand total of the "intercepts" and "hits" metrics for all =
bins.
> >   * @tick_intercepts: "Intercepts" before TICK_NSEC.
> >   * @short_idle: Wakeups after short idle periods.
> > + * @artificial_wakeup: Set if the wakeup has been triggered by a safet=
y net.
> >   */
> >  struct teo_cpu {
> > -     s64 time_span_ns;
> >       s64 sleep_length_ns;
> >       struct teo_bin state_bins[CPUIDLE_STATE_MAX];
> >       unsigned int total;
> >       unsigned int tick_intercepts;
> >       unsigned int short_idle;
> > +     bool artificial_wakeup;
> >  };
> >
> >  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> > @@ -156,7 +156,7 @@
> >
> >       cpu_data->short_idle -=3D cpu_data->short_idle >> DECAY_SHIFT;
> >
> > -     if (cpu_data->time_span_ns < 0) {
> > +     if (cpu_data->artificial_wakeup) {
> >               /*
> >                * If one of the safety nets has triggered, assume that t=
his
> >                * might have been a long sleep.
> > @@ -165,13 +165,6 @@
> >       } else {
> >               u64 lat_ns =3D drv->states[dev->last_state_idx].exit_late=
ncy_ns;
> >
> > -             /*
> > -              * The computations below are to determine whether or not=
 the
> > -              * (saved) time till the next timer event and the measure=
d idle
> > -              * duration fall into the same "bin", so use last_residen=
cy_ns
> > -              * for that instead of time_span_ns which includes the cp=
uidle
> > -              * overhead.
> > -              */
> >               measured_ns =3D dev->last_residency_ns;
> >               /*
> >                * The delay between the wakeup and the first instruction
> > @@ -286,7 +279,6 @@
> >               dev->last_state_idx =3D -1;
> >       }
> >
> > -     cpu_data->time_span_ns =3D local_clock();
> >       /*
> >        * Set the sleep length to infitity in case the invocation of
>
> You're not touching this here, but might as well fix the infitity
> typo with the series.

I'll fix this when applying the patches.

> >        * tick_nohz_get_sleep_length() below is skipped, in which case i=
t won't
> > @@ -504,17 +496,16 @@
> >       struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
> >
> >       dev->last_state_idx =3D state;
> > -     /*
> > -      * If the wakeup was not "natural", but triggered by one of the s=
afety
> > -      * nets, assume that the CPU might have been idle for the entire =
sleep
> > -      * length time.
> > -      */
> >       if (dev->poll_time_limit ||
> >           (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TIC=
K_NSEC)) {
> > +             /*
> > +              * The wakeup was not "geniune", but triggered by one of =
the
>
> s/geniune/genuine

Ditto.

> > +              * safety nets.
> > +              */
> >               dev->poll_time_limit =3D false;
> > -             cpu_data->time_span_ns =3D KTIME_MIN;
> > +             cpu_data->artificial_wakeup =3D true;
> >       } else {
> > -             cpu_data->time_span_ns =3D local_clock() - cpu_data->time=
_span_ns;
> > +             cpu_data->artificial_wakeup =3D false;
> >       }
>
> You could rewrite this without the else by just setting it to false befor=
e the if.

True, but the "alse" is there already and I didn't want to make more
changes than necessary in this patch.

> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks for all of the reviews!

