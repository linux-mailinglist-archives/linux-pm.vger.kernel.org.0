Return-Path: <linux-pm+bounces-38043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8553C5DE77
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489A74203DA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464E328B6E;
	Fri, 14 Nov 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4JKp1a+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A02192FA
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133184; cv=none; b=NKMzI3NvyPHPBABMQ8GbUVcAUVLFQ6O7rbMQOac1nvHs9v8fhM2IBEHEGt3PoIMVOTIVJL/cUec5lzMOldciU6vKzv/lbzyJ8a2RMF5gY1bN6vygpM1i7RqffX7ukCGz4kT7g4ZZxWqzmeB3Ebq7ryxltEEHQZ8uWRhFjJNwXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133184; c=relaxed/simple;
	bh=xfEpH2bNQqu4obmEefBFvB+YeKoOfImo1hdHAMXm2a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQf24mrf/N6oMhf8B01kWmCZGRPPnwljkmi8YWxYooshCP/YK1LgS0ecUB108R6q7uUcC/nPK32XSCTCvrbRAc70swBMXlaIkiSE/S7gGTs/k1vp63l40fgoe7+Yfo7jRFhr/2u1Pxm2F6d2SUMEhuD+ndCisp5wiabfUXtQ9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4JKp1a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F334C19422
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763133184;
	bh=xfEpH2bNQqu4obmEefBFvB+YeKoOfImo1hdHAMXm2a4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f4JKp1a+iblsMghneLrzMdf4zYjaNOi5U4qqC5IrhH8h3awq/wFmZPKdF4b0LOBji
	 0pbw+rqzyRpDInV8yxsquN0ieFK71LVkoHRzhLBxJfuuNEqPylfD4zVWccA5lT8eQ/
	 3KWRY9vkn0ugUiX1J2BUdR/dZNEkR008Yv+d0LKNq6EUQK9mUpi4bf6NxJuLyDrQz8
	 JsFQEUiEUFEZ1yEEyE3i72kiZPXbR2IdXsdsAc95cN8zJsqBB1kG3oVY1QwHKi86dT
	 tbL00Ry7pQunyhCNnUAZ0edCo/kNye7hW4V6nlXGfcRs9zGhZ2tuH8hmQ4HCNzN1bC
	 wbWMEOe7VQltw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45085a4ab72so968715b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 07:13:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTvVYKG4Y2JAaarkM1Hxr9BZrg/V6CoARmi/esy4ZeDZPdc2Qg7Hi1MAdDe6slfTb4YQaeJ+lu/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpfj8MSh6HgHCYTSV/jUwhBX9SWIqy5Iedt/mI6lDih6hqASr
	qGC45nrqw4h+jzf4g6/uhmaubTvlK+GVwXAsitK3UMf4xo1do9U/ptzdkkxXDZO/LesG7+czRWB
	UNTRap8BtY75iEAUr5ZQvphn+Co2vPlQ=
X-Google-Smtp-Source: AGHT+IENZODB/feyKtDYRKzYjbkeyMi5puaWd7zAVhgl9kdHRSGncVBLa4pjeSBG79EaTbr6JJmODc8OmPhRrBks/4c=
X-Received: by 2002:a05:6808:4f4a:b0:44f:7562:1a73 with SMTP id
 5614622812f47-45097589432mr1803890b6e.35.1763133183368; Fri, 14 Nov 2025
 07:13:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com> <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
 <6228387.lOV4Wx5bFT@rafael.j.wysocki> <fcf1584a-7e15-4aec-b302-b94cfa168e11@arm.com>
In-Reply-To: <fcf1584a-7e15-4aec-b302-b94cfa168e11@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 16:12:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g2PL3rj=sZoCHAqQg0dSnxMk_u-GHn1vybFuPUjh0iKA@mail.gmail.com>
X-Gm-Features: AWmQ_bnm1_WDqCryrKp5Pa1bR-vhWqnwQiAaESaGuBUFRcV6DL7z4LhQXzmJtSY
Message-ID: <CAJZ5v0g2PL3rj=sZoCHAqQg0dSnxMk_u-GHn1vybFuPUjh0iKA@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wakeups
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Reka Norman <rekanorman@chromium.org>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 3:47=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/13/25 16:56, Rafael J. Wysocki wrote:
> > On Thursday, November 13, 2025 4:43:18 PM CET Christian Loehle wrote:
> >> On 11/12/25 18:33, Christian Loehle wrote:
> >>> On 11/12/25 14:16, Rafael J. Wysocki wrote:
> >>>> On Wed, Nov 12, 2025 at 3:03=E2=80=AFPM Christian Loehle
> >>>> <christian.loehle@arm.com> wrote:
> >>>>>
> >>>>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
> >>>>>> On Tue, Nov 11, 2025 at 6:20=E2=80=AFPM Christian Loehle
> >>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>
> >>>>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
> >>>>>>>> On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> >>>>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>>>>>> I see two issues:
> >>>>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess t=
his wouldn't really be an issue without 2))
> >>>>>>>>
> >>>>>>>> This shouldn't be a problem.
> >>>>>>>
> >>>>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't the =
case $subject would've likely
> >>>>>>> never been an issue.
> >>>>>>
> >>>>>> Well, I think that the leftovers can be cleared when they become l=
ess than 8.
> >>>>>>
> >>>>>>>>
> >>>>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) =
isn't an appropriate check, it will
> >>>>>>>>>> exclude the state if it its idx_hit_sum make up the vast major=
ity of cpu_data->total (i.e. it would
> >>>>>>>>>> have been a really good candidate actually).
> >>>>>>>>
> >>>>>>>> Well, it would exclude the state if the sum of hits for the stat=
es
> >>>>>>>> below it is large enough.  This is questionable (because why wou=
ld
> >>>>>>>> hits matter here), but I attempted to make the change below and
> >>>>>>>> somebody reported a regression IIRC.
> >>>>>>>>
> >>>>>>>> This check is related to the problem at hand though (see below).
> >>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I lightly tested the below, it seems to be at least comparable=
 to mainline teo.
> >>>>>>>>>> (the documentation/comments would need adapting too, of course=
)
> >>>>>>>>>>
> >>>>>>>>>> -----8<-----
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle=
/governors/teo.c
> >>>>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
> >>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_drive=
r *drv, struct cpuidle_device *dev,
> >>>>>>>>>>          * all of the deeper states, a shallower idle state is=
 likely to be a
> >>>>>>>>>>          * better choice.
> >>>>>>>>>>          */
> >>>>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_=
sum) {
> >>>>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> >>>>>>>>>>                 int first_suitable_idx =3D idx;
> >>>>>>>>>>
> >>>>>>>>>>                 /*
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0.=
..idx-1.
> >>>>>>>>> Maybe something like this, again lightly tested:
> >>>>>>>>>
> >>>>>>>>> -----8<-----
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/=
governors/teo.c
> >>>>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
> >>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driv=
er *drv, struct cpuidle_device *dev,
> >>>>>>>>>                  * has been stopped already into account.
> >>>>>>>>>                  */
> >>>>>>>>>                 intercept_sum =3D 0;
> >>>>>>>>> +               hit_sum =3D 0;
> >>>>>>>>>
> >>>>>>>>>                 for (i =3D idx - 1; i >=3D 0; i--) {
> >>>>>>>>>                         struct teo_bin *bin =3D &cpu_data->stat=
e_bins[i];
> >>>>>>>>>
> >>>>>>>>>                         intercept_sum +=3D bin->intercepts;
> >>>>>>>>> +                       hit_sum +=3D bin->hits;
> >>>>>>>>>
> >>>>>>>>> -                       if (2 * intercept_sum > idx_intercept_s=
um) {
> >>>>>>>>> +                       if (2 * intercept_sum > cpu_data->total=
 || 2 * hit_sum > cpu_data->total) {
> >>>>>>>>>                                 /*
> >>>>>>>>>                                  * Use the current state unless=
 it is too
> >>>>>>>>>                                  * shallow or disabled, in whic=
h case take the
> >>>>>>>>
> >>>>>>>> This will only matter after the deepest state has been rejected
> >>>>>>>> already and on the system in question this means selecting state=
 0 no
> >>>>>>>> matter what.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Ah, right!
> >>>>>>>
> >>>>>>>
> >>>>>>>> The pre-6.12 behavior can be explained if tick wakeups are taken=
 into account.
> >>>>>>>>
> >>>>>>>> Namely, when state 0 is chosen (because of the check mentioned a=
bove),
> >>>>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  If t=
he
> >>>>>>>> subsequent wakeup is a tick one, it will be counted as a hit on =
the
> >>>>>>>> deepest state (and it will contribute to the total sum in the ch=
eck
> >>>>>>>> mentioned above).  Then, at one point, cpu_data->total will be l=
arge
> >>>>>>>> enough and the deepest state will become the candidate one.  If
> >>>>>>>> tick_nohz_get_sleep_length() returns a large value at that point=
, the
> >>>>>>>> tick will be stopped and the deepest state will be entered.  Nir=
vana
> >>>>>>>> ensues.
> >>>>>>>
> >>>>>>> So fundamentally we will have to count tick-wakeups as a) nothing=
, which
> >>>>>>> doesn't allow us to ever break out of the intercept logic that ca=
used us
> >>>>>>> to leave the tick on b) intercepts, which is bonkers and doesn't =
allow us
> >>>>>>> to ever break out and c) hits =3D=3D sleep_length would've been a=
ccurate.
> >>>>>>> Of course counting a tick wakeup as a hit for sleep_length negate=
s the
> >>>>>>> intercept logic.
> >>>>>>
> >>>>>> Not quite.  The intercept logic is there for wakeups other than ti=
ck
> >>>>>> wakeups and timer wakeups.
> >>>>>>
> >>>>>> I actually think that tick wakeups can be counted as hits on the
> >>>>>> deepest available state - maybe only when tick wakeups dominate th=
e
> >>>>>> wakeup pattern - but generally this is not unreasonable: When the
> >>>>>> wakeup pattern is dominated by tick wakeups, this by itself is a g=
ood
> >>>>>> enough reason to stop the tick.
> >>>>>
> >>>>> (assuming HZ=3D1000 below but it doesn't matter)
> >>>>> That will exclude any 'intercept' logic from having much effect if =
the
> >>>>> avg idle duration is >TICK_NSEC/2, which is potentially still quite=
 a bit
> >>>>> off from state1 residency, like in Reka's case here.
> >>>>> That's why I thought it would cause unreasonable regressions here.
> >>>>> I'll give it a go as well though!
> >>>>
> >>>> Thanks!
> >>>>
> >>>> Note that I'd prefer to add a check if tick wakeups dominate the
> >>>> wakeup pattern before setting sleep_length_ns to KTIME_MAX though.
> >>>> I'd first like to know how the Reka's system reacts to the more
> >>>> drastic variant of this change.
> >>>
> >>> Below are my usual tests, it's definitely visible but the impact is l=
imited
> >>> on this platform anyway. I think if we gate the KTIME_MAX setting beh=
ind
> >>> the "tick wakeup dominate" it should be acceptable!
> >>> Let's see what Reka reports.
> >>>
> >> Forgot to post the full results, anyway as expected with mtdblock (a v=
ery slow
> >> / low frequent wakeup scenario) the impact becomes clearly visible.
> >> Still hopeful that the more conservative approach will be acceptable!
> >
> > Speaking of which, the patch to test is appended below, but it doesn't =
apply
> > directly on top of the mainline.  It is based on some other patches tha=
t have
> > been posted recently, so here's a git branch with all of the requisite
> > material:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpuid=
le-teo-testing
> >
> > Reka, please try this one and let us know how it goes.
> >
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH v1] cpuidle: governors: teo: Rework the handling of tic=
k wakeups
> >
> > If the wakeup pattern is clearly dominated by tick wakeups, count those
> > wakeups as hits on the deepest available idle state to increase the
> > likelihood of stopping the tick, especially on systems where there are
> > only 2 usable idle states and the tick can only be stopped when the
> > deeper state is selected.
>
> Maybe a sentence on the consequence that without this we may be ever-stuc=
k in
> the intercept logic.

Good point, I'll add one.

> >
> > This change is expected to reduce power on some systems where state 0 i=
s
> > selected relatively often even though they are almost idle.
> >
>
> Should be a fixes tag, but I think it's a lot earlier than just
> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")

I'll add the Fixes: tag pointing to this because it has exposed the
issue, but I agree that it was there earlier.

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |   39 ++++++++++++++++++++++++-------=
--------
> >  1 file changed, 24 insertions(+), 15 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -133,17 +133,19 @@ struct teo_bin {
> >   * @sleep_length_ns: Time till the closest timer event (at the selecti=
on time).
> >   * @state_bins: Idle state data bins for this CPU.
> >   * @total: Grand total of the "intercepts" and "hits" metrics for all =
bins.
> > + * @total_tick: Wakeups by the scheduler tick.
> >   * @tick_intercepts: "Intercepts" before TICK_NSEC.
> >   * @short_idles: Wakeups after short idle periods.
> > - * @artificial_wakeup: Set if the wakeup has been triggered by a safet=
y net.
> > + * @tick_wakeup: Set if the last wakeup was by the scheduler tick.
> >   */
> >  struct teo_cpu {
> >       s64 sleep_length_ns;
> >       struct teo_bin state_bins[CPUIDLE_STATE_MAX];
> >       unsigned int total;
> > +     unsigned int total_tick;
> >       unsigned int tick_intercepts;
> >       unsigned int short_idles;
> > -     bool artificial_wakeup;
> > +     bool tick_wakeup;
> >  };
> >
> >  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> > @@ -172,9 +174,10 @@ static void teo_update(struct cpuidle_dr
> >
> >       teo_decay(&cpu_data->short_idles);
> >
> > -     if (cpu_data->artificial_wakeup) {
> > +     if (dev->poll_time_limit) {
> > +             dev->poll_time_limit =3D false;
> >               /*
> > -              * If one of the safety nets has triggered, assume that t=
his
> > +              * Polling state timeout has triggered, so assume that th=
is
> >                * might have been a long sleep.
> >                */
> >               measured_ns =3D S64_MAX;
> > @@ -223,6 +226,21 @@ static void teo_update(struct cpuidle_dr
> >       cpu_data->total =3D total + PULSE;
> >
> >       teo_decay(&cpu_data->tick_intercepts);
> > +
> > +     teo_decay(&cpu_data->total_tick);
> > +     if (cpu_data->tick_wakeup) {
> > +             cpu_data->total_tick +=3D PULSE;
> > +             /*
> > +              * If tick wakeups dominate the wakeup pattern, count thi=
s one
> > +              * as a hit on the deepest available idle state to increa=
se the
> > +              * likelihood of stopping the tick.
> > +              */
> > +             if (3 * cpu_data->total_tick > 2 * cpu_data->total) {
> > +                     cpu_data->state_bins[drv->state_count-1].hits +=
=3D PULSE;
> > +                     return;
> > +             }
> > +     }
> > +
>
> What if this state happens to be disabled?
> If we're walking through the states anyway to find the deepest non-disabl=
ed one,
> I think the first non-disabled above TICK_NSEC might be an even better ch=
oice?

It actually doesn't matter AFAICS because those hits only come to play in t=
he

    if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {

check in teo_select() and they are included in cpu_data->total in either ca=
se.

> >       /*
> >        * If the measured idle duration falls into the same bin as the s=
leep
> >        * length, this is a "hit", so update the "hits" metric for that =
bin.
> > @@ -512,18 +530,9 @@ static void teo_reflect(struct cpuidle_d
> >  {
> >       struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
> >
> > +     cpu_data->tick_wakeup =3D tick_nohz_idle_got_tick();
> > +
> >       dev->last_state_idx =3D state;
> > -     if (dev->poll_time_limit ||
> > -         (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TIC=
K_NSEC)) {
> > -             /*
> > -              * The wakeup was not "genuine", but triggered by one of =
the
> > -              * safety nets.
> > -              */
> > -             dev->poll_time_limit =3D false;
> > -             cpu_data->artificial_wakeup =3D true;
> > -     } else {
> > -             cpu_data->artificial_wakeup =3D false;
> > -     }
> >  }
>
> The result is definitely still visible, especially looking at the belows,=
 but I'd say
> this is in a reasonable range.
> Tested-by: Christian Loehle <christian.loehle@arm.com>

Thanks!

