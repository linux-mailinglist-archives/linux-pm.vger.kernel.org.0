Return-Path: <linux-pm+bounces-43884-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCqOF9VHq2lcbwEAu9opvQ
	(envelope-from <linux-pm+bounces-43884-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 22:32:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242BE227F52
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 22:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82798301D0C1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 21:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFC0337105;
	Fri,  6 Mar 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppRxXqcH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36F339875
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832723; cv=none; b=MfPLFaULfuOFtDAdcPKegLfDJUKTzY239ulpu+LKGybCIQvFi+wOHgfF56oGRtERx5Sd89FPbHSF0UmCemGVsWeAySt53/PEAZLi1cuDFUqJ0EJ64xCIeIBmHEYKi+QwJUk1VoyON6GTH4+hjPR//QAEPNUdR18i+RLu7xCiduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832723; c=relaxed/simple;
	bh=J9SagHd55OWqyOwpkd8p9WBIqLY8ydmezN1YM9Gjhho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2yrdl1sWT50feXHtPZsvCHnjr0X/XyTf2U8iqmBQ+bz9phJ+ggR3so5Qv/Symq0U0W/Crzqi/3Az6GEFYiEbndrrf6jEl7Q9A/ItqxgkJ7ZAst48vS1qpYBQ5F7v9y+lGPZnvk58iGp1DvEUK7sB6WgIzBwrJKHSg8rtlQjQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppRxXqcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AD6C2BC86
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 21:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832723;
	bh=J9SagHd55OWqyOwpkd8p9WBIqLY8ydmezN1YM9Gjhho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ppRxXqcHzcyxhuRXWoHbHRic3BEbN5A1yK0+FS7qTOyAABMjNzV0XFleetFsI8pg9
	 zKWkQEdYN/IqWJufLe7+fQxrk+h74B7NJLrG9IskVTkxTxCZMYEf1jTLpavdqgrTgo
	 lwBIR6aUJcIOF/eNuee39+IoFkhNpjdAgJGPhj877Iz9jaaXYRejOZTh5cf71RozA1
	 DQEBt9ix04FWkzERRDJkocNf25fSM4zqYX8PSYnNd0TPFS89TZNXdVl6keFy1hqWVW
	 gNlVn08Ln8Qib50ZCmyy6H0qCHHta21ik6Ft1AcizHP8omn6HjEPWVSjp7WlEBDwRh
	 0oEt5l6jQ6pbQ==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-463208653d6so7038582b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 13:32:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjauEMdFbM0IwBtgog1lArx3NRGBn1yP9qXDsxR4QPNFioFTfn4Av3RIw1dXdN5ABMfqdql0eZrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzVUTk3vqxHoP+Z/FnrQ3EGGzaIPBCkPodRuoW5xtTodu2lq+
	/WVCyMv1w8nkt1IW2JE5Zof6rtMx4vWYQ3C+6GJCgXrSmdx0z1iFdoaHCXGCQBhHxYPukN8VmHI
	fe2sNmG1wvOWt4/sl2anLdZd1bZbeYmM=
X-Received: by 2002:a05:6808:4f13:b0:44d:c08a:e039 with SMTP id
 5614622812f47-466dc9e040emr2031259b6e.10.1772832722042; Fri, 06 Mar 2026
 13:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301191959.406218221@kernel.org> <CAJZ5v0h-bGU34d9OnhYqdzz+5UiKV1rBEB9NS-TL4=sK2jf-LQ@mail.gmail.com>
 <20260304030306.uk5c63xw4oqvjffb@airbuntu> <6250711.lOV4Wx5bFT@rafael.j.wysocki>
In-Reply-To: <6250711.lOV4Wx5bFT@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 22:31:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jb7wJFQEfP_-JRv4mwh3qveq+VPoy8k9dmtmigoSyKhg@mail.gmail.com>
X-Gm-Features: AaiRm50GZTF3fNbPLg9_CWyQfzHY71-9lJ5x1nnCjggGPf8kgRrrdtZ14pJjEEM
Message-ID: <CAJZ5v0jb7wJFQEfP_-JRv4mwh3qveq+VPoy8k9dmtmigoSyKhg@mail.gmail.com>
Subject: Re: [patch 2/2] sched/idle: Make default_idle_call() NOHZ aware
To: Qais Yousef <qyousef@layalina.io>, Christian Loehle <christian.loehle@arm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 242BE227F52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-43884-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,arm.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 10:21=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wednesday, March 4, 2026 4:03:06 AM CET Qais Yousef wrote:
> > On 03/02/26 22:25, Rafael J. Wysocki wrote:
> > > On Mon, Mar 2, 2026 at 12:04=E2=80=AFPM Christian Loehle
> > > <christian.loehle@arm.com> wrote:
> > > >
> > > > On 3/1/26 19:30, Thomas Gleixner wrote:
> > > > > Guests fall back to default_idle_call() as there is no cpuidle dr=
iver
> > > > > available to them by default. That causes a problem in fully load=
ed
> > > > > scenarios where CPUs go briefly idle for a couple of microseconds=
:
> > > > >
> > > > > tick_nohz_idle_stop_tick() is invoked unconditionally which means=
 unless
> > > > > there is timer pending in the next tick, the tick is stopped and =
a couple
> > > > > of microseconds later when the idle condition goes away restarted=
. That
> > > > > requires to program the clockevent device twice which implies a V=
M exit for
> > > > > each reprogramming.
> > > > >
> > > > > It was suggested to remove the tick_nohz_idle_stop_tick() invocat=
ion from
> > > > > the default idle code, but would be counterproductive. It would n=
ot allow
> > > > > the host to go into deeper idle states when the guest CPU is full=
y idle as
> > > > > it has to maintain the periodic tick.
> > > > >
> > > > > Cure this by implementing a trivial moving average filter which k=
eeps track
> > > > > of the recent idle recidency time and only stop the tick when the=
 average
> > > > > is larger than a tick.
> > > > >
> > > > > Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> > > > > ---
> > > > >  kernel/sched/idle.c |   65 +++++++++++++++++++++++++++++++++++++=
++++++++-------
> > > > >  1 file changed, 57 insertions(+), 8 deletions(-)
> > > > >
> > > > > --- a/kernel/sched/idle.c
> > > > > +++ b/kernel/sched/idle.c
> > > > > @@ -105,12 +105,7 @@ static inline void cond_tick_broadcast_e
> > > > >  static inline void cond_tick_broadcast_exit(void) { }
> > > > >  #endif /* !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE */
> > > > >
> > > > > -/**
> > > > > - * default_idle_call - Default CPU idle routine.
> > > > > - *
> > > > > - * To use when the cpuidle framework cannot be used.
> > > > > - */
> > > > > -static void __cpuidle default_idle_call(void)
> > > > > +static void __cpuidle __default_idle_call(void)
> > > > >  {
> > > > >       instrumentation_begin();
> > > > >       if (!current_clr_polling_and_test()) {
> > > > > @@ -130,6 +125,61 @@ static void __cpuidle default_idle_call(
> > > > >       instrumentation_end();
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_NO_HZ_COMMON
> > > > > +
> > > > > +/* Limit to 4 entries so it fits in a cache line */
> > > > > +#define IDLE_DUR_ENTRIES     4
> > > > > +#define IDLE_DUR_MASK                (IDLE_DUR_ENTRIES - 1)
> > > > > +
> > > > > +struct idle_nohz_data {
> > > > > +     u64             duration[IDLE_DUR_ENTRIES];
> > > > > +     u64             entry_time;
> > > > > +     u64             sum;
> > > > > +     unsigned int    idx;
> > > > > +};
> > > > > +
> > > > > +static DEFINE_PER_CPU_ALIGNED(struct idle_nohz_data, nohz_data);
> > > > > +
> > > > > +/**
> > > > > + * default_idle_call - Default CPU idle routine.
> > > > > + *
> > > > > + * To use when the cpuidle framework cannot be used.
> > > > > + */
> > > > > +static void default_idle_call(void)
> > > > > +{
> > > > > +     struct idle_nohz_data *nd =3D this_cpu_ptr(&nohz_data);
> > > > > +     unsigned int idx =3D nd->idx;
> > > > > +     s64 delta;
> > > > > +
> > > > > +     /*
> > > > > +      * If the CPU spends more than a tick on average in idle, t=
ry to stop
> > > > > +      * the tick.
> > > > > +      */
> > > > > +     if (nd->sum > TICK_NSEC * IDLE_DUR_ENTRIES)
> > > > > +             tick_nohz_idle_stop_tick();
> > > > > +
> > > > > +     __default_idle_call();
> > > > > +
> > > > > +     /*
> > > > > +      * Build a moving average of the time spent in idle to prev=
ent stopping
> > > > > +      * the tick on a loaded system which only goes idle briefly=
.
> > > > > +      */
> > > > > +     delta =3D max(sched_clock() - nd->entry_time, 0);
> > > > > +     nd->sum +=3D delta - nd->duration[idx];
> > > > > +     nd->duration[idx] =3D delta;
> > > > > +     nd->idx =3D (idx + 1) & IDLE_DUR_MASK;
> > > > > +}
> > > > > +
> > > > > +static void default_idle_enter(void)
> > > > > +{
> > > > > +     this_cpu_write(nohz_data.entry_time, sched_clock());
> > > > > +}
> > > > > +
> > > > > +#else  /* CONFIG_NO_HZ_COMMON */
> > > > > +static inline void default_idle_call(void { __default_idle_call(=
); }
> > > > > +static inline void default_idle_enter(void) { }
> > > > > +#endif /* !CONFIG_NO_HZ_COMMON */
> > > > > +
> > > > >  static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
> > > > >                              struct cpuidle_device *dev,
> > > > >                              u64 max_latency_ns)
> > > > > @@ -186,8 +236,6 @@ static void cpuidle_idle_call(void)
> > > > >       }
> > > > >
> > > > >       if (cpuidle_not_available(drv, dev)) {
> > > > > -             tick_nohz_idle_stop_tick();
> > > > > -
> > > > >               default_idle_call();
> > > > >               goto exit_idle;
> > > > >       }
> > > > > @@ -276,6 +324,7 @@ static void do_idle(void)
> > > > >
> > > > >       __current_set_polling();
> > > > >       tick_nohz_idle_enter();
> > > > > +     default_idle_enter();
> > > > >
> > > > >       while (!need_resched()) {
> > > > >
> > > > >
> > > >
> > > > How does this work? We don't stop the tick until the average idle t=
ime is larger,
> > > > but if we don't stop the tick how is that possible?
> > > >
> > > > Why don't we just require one or two consecutive tick wakeups befor=
e stopping?
> > >
> > > Exactly my thought and I think one should be sufficient.
> >
> > I concur. From our experience with TEO util threshold these averages ca=
n
> > backfire. I think one tick is sufficient delay to not be obviously brok=
en.
>
> So if I'm not mistaken, it would be something like the appended prototype
> (completely untested, but it builds for me).
>
> ---
>  drivers/cpuidle/cpuidle.c |   10 ----------
>  kernel/sched/idle.c       |   32 ++++++++++++++++++++++++--------
>  2 files changed, 24 insertions(+), 18 deletions(-)
>
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -359,16 +359,6 @@ noinstr int cpuidle_enter_state(struct c
>  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *de=
v,
>                    bool *stop_tick)
>  {
> -       /*
> -        * If there is only a single idle state (or none), there is nothi=
ng
> -        * meaningful for the governor to choose. Skip the governor and
> -        * always use state 0 with the tick running.
> -        */
> -       if (drv->state_count <=3D 1) {
> -               *stop_tick =3D false;
> -               return 0;
> -       }
> -
>         return cpuidle_curr_governor->select(drv, dev, stop_tick);
>  }
>
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
>         return cpuidle_enter(drv, dev, next_state);
>  }
>
> +static void idle_call_stop_or_retain_tick(bool stop_tick)
> +{
> +       if (stop_tick || tick_nohz_tick_stopped())
> +               tick_nohz_idle_stop_tick();
> +       else
> +               tick_nohz_idle_retain_tick();
> +}
> +
>  /**
>   * cpuidle_idle_call - the main idle function
>   *
> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
>   * set, and it returns with polling set.  If it ever stops polling, it
>   * must clear the polling bit.
>   */
> -static void cpuidle_idle_call(void)
> +static void cpuidle_idle_call(bool got_tick)
>  {
>         struct cpuidle_device *dev =3D cpuidle_get_device();
>         struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
>         }
>
>         if (cpuidle_not_available(drv, dev)) {
> -               tick_nohz_idle_stop_tick();
> +               idle_call_stop_or_retain_tick(!got_tick);

Oh, I got this backwards (here and below).

The tick should be stopped if we've got the tick previously, but you
get the idea.

[Note to self: Don't send patches in the night.]

>                 default_idle_call();
>                 goto exit_idle;
> @@ -221,7 +229,7 @@ static void cpuidle_idle_call(void)
>
>                 next_state =3D cpuidle_find_deepest_state(drv, dev, max_l=
atency_ns);
>                 call_cpuidle(drv, dev, next_state);
> -       } else {
> +       } else if (drv->state_count > 1) {
>                 bool stop_tick =3D true;
>
>                 /*
> @@ -229,16 +237,22 @@ static void cpuidle_idle_call(void)
>                  */
>                 next_state =3D cpuidle_select(drv, dev, &stop_tick);
>
> -               if (stop_tick || tick_nohz_tick_stopped())
> -                       tick_nohz_idle_stop_tick();
> -               else
> -                       tick_nohz_idle_retain_tick();
> +               idle_call_stop_or_retain_tick(stop_tick);
>
>                 entered_state =3D call_cpuidle(drv, dev, next_state);
>                 /*
>                  * Give the governor an opportunity to reflect on the out=
come
>                  */
>                 cpuidle_reflect(dev, entered_state);
> +       } else {
> +               /*
> +                * If there is only a single idle state (or none), there =
is
> +                * nothing meaningful for the governor to choose.  Skip t=
he
> +                * governor and always use state 0.
> +                */
> +               idle_call_stop_or_retain_tick(!got_tick);
> +
> +               call_cpuidle(drv, dev, 0);
>         }
>
>  exit_idle:
> @@ -259,6 +273,7 @@ exit_idle:
>  static void do_idle(void)
>  {
>         int cpu =3D smp_processor_id();
> +       bool got_tick =3D false;
>
>         /*
>          * Check if we need to update blocked load
> @@ -329,8 +344,9 @@ static void do_idle(void)
>                         tick_nohz_idle_restart_tick();
>                         cpu_idle_poll();
>                 } else {
> -                       cpuidle_idle_call();
> +                       cpuidle_idle_call(got_tick);
>                 }
> +               got_tick =3D tick_nohz_idle_got_tick();
>                 arch_cpu_idle_exit();
>         }

