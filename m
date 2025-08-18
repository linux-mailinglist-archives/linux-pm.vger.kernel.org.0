Return-Path: <linux-pm+bounces-32574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 973ACB2AF0D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 19:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1CB1BA1FD5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289BB32C30B;
	Mon, 18 Aug 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHe7kpOS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E532C301;
	Mon, 18 Aug 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536905; cv=none; b=rOwNwALxnBT/EBah+JTInwUV+Qsa0+c3CZLQHFxFNn+pwbrCVTA2ZwRY4FA5Iler6Vn7L+G3BuzOekVIvjsfoInP42ITC/YdHNM2CWrmUH0A9ISZqulRypY/0Fw/xh3fF3bBDabQq79TOgZcDS4Co7JkwLWS2b1ChNBZDf5NXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536905; c=relaxed/simple;
	bh=zQxTuAvYIfNO8cz+oNsAkBS/V5FhHPFGI5pi8bMfH7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRPSN/2X4ujX7hjWLoNeRxSoEi4DIG8SGXVMwsySARP0WrD6/DShBDT4n52Stv9Le4qCYocrdFBnZ0tYNoxHBhrYP1gT46NjPR5Y64WqrpUE72+fgfuIJW5MLg5pfn+tHaAL0Fgdwt6tlE4BxuUMAF+7bLU//3xC13OtHqnGaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHe7kpOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AB8C113D0;
	Mon, 18 Aug 2025 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755536904;
	bh=zQxTuAvYIfNO8cz+oNsAkBS/V5FhHPFGI5pi8bMfH7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AHe7kpOSYCeVenSQSDlBdWJbhWw9+6xpG5Z9Xd/rWt/Agzc4uHcefnXu6fpfW8DB/
	 ZVNFWSxVjLiv2pgvhCmEqI0XwGvNqVa2rGa5/Y3owm+eLbOXwCMxjfIRvKUz4gQ+lM
	 dnXjVYm2pxJo1WWliQowWLkD5OlRHXaOArLyZn41N+2MHMVhs9cqhvVXyTnG6QQWfl
	 r6tw0ry5G0JgQz+PRxXnwRmLUispbqIj/bh0pSbbcZm16Jg3COU7SHTQvbGbcbCpCM
	 s53Q0gJbYa8PaI/Awjs/3Xt0dx3B9scGBpOYYeDMbA28Yl2P/6CmByij5UN2145NNK
	 RnTCC+U8Im4cg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61bf9ef4f1fso1505389eaf.3;
        Mon, 18 Aug 2025 10:08:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK6n4Dm+l5eqZGKZRU38IxnM2L5je0Dl+CMldDrkfbr3irL7X6Lf8ecz/A3YMMk+l7wnh7US9HCsM=@vger.kernel.org, AJvYcCVW4R1Ho6xGtmTdWhD31HPIKAcbMLmyUXQUFyuyq2tHK1iLlkQQpBc7JJTN4sC0fjtwrWhcUNL3nD3xExA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2YT110P44eTE8Ll21esMu/ho/Pd2uGyJnJtsbUrrMp4WUTykS
	LQisw5acLXQldsW5OespOFQ3WCHx1YJYafluupqvnXQAcLJu2+NOn65+gPHA3x1t9ABkPtEvZja
	rGmO9R6XjRAer842Ic9sPBX4A0Tj2liw=
X-Google-Smtp-Source: AGHT+IEuxEPvxBQjnopblcKv41S8Q91oq3BerfWHUDFh6phFeM73xEMNjROm8iMJIjhJt1jijjn/DfnJ5NYDB5XKM6g=
X-Received: by 2002:a05:6820:1690:b0:61c:4fa:7465 with SMTP id
 006d021491bc7-61c04fa7528mr4551613eaf.0.1755536904134; Mon, 18 Aug 2025
 10:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <5043159.31r3eYUQgx@rafael.j.wysocki>
 <0da8086f-2b6c-46e3-92ca-e156b9374a2a@arm.com>
In-Reply-To: <0da8086f-2b6c-46e3-92ca-e156b9374a2a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Aug 2025 19:08:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpfZt-BB579mBkSkNX6em4sHKwiLYCgm4dzzkUFeexmQ@mail.gmail.com>
X-Gm-Features: Ac12FXwD6X_DNc5siHpU3QcBm0fI4CvCLa2kVu59QXSF-3Y9_CyL9_6PGkZ1AeM
Message-ID: <CAJZ5v0jpfZt-BB579mBkSkNX6em4sHKwiLYCgm4dzzkUFeexmQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] cpuidle: governors: menu: Avoid selecting states
 with too much latency
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 9:13=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/13/25 11:25, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Occasionally, the exit latency of the idle state selected by the menu
> > governor may exceed the PM QoS CPU wakeup latency limit.  Namely, if th=
e
> > scheduler tick has been stopped already and predicted_ns is greater tha=
n
> > the tick period length, the governor may return an idle state whose exi=
t
> > latency exceeds latency_req because that decision is made before
> > checking the current idle state's exit latency.
> >
> > For instance, say that there are 3 idle states, 0, 1, and 2.  For idle
> > states 0 and 1, the exit latency is equal to the target residency and
> > the values are 0 and 5 us, respectively.  State 2 is deeper and has the
> > exit latency and target residency of 200 us and 2 ms (which is greater
> > than the tick period length), respectively.
> >
> > Say that predicted_ns is equal to TICK_NSEC and the PM QoS latency
> > limit is 20 us.  After the first two iterations of the main loop in
> > menu_select(), idx becomes 1 and in the third iteration of it the targe=
t
> Can drop "of it" here?

But it also doesn't really hurt I think.

> > residency of the current state (state 2) is greater than predicted_ns.
> > State 2 is not a polling one and predicted_ns is not less than TICK_NSE=
C,
> > so the check on whether or not the tick has been stopped is done.  Say
> > that the tick has been stopped already and there are no imminent timers
> > (that is, delta_tick is greater than the target residency of state 2).
> > In that case, idx becomes 2 and it is returned immediately, but the exi=
t
> > latency of state 2 exceeds the latency limit.
> >
> > Address this issue by modifying the code to compare the exit latency of
> > the current idle state (idle state i) with the latency limit before
> > comparing its target residecy with predicted_ns, which allows one
> residency

Fixed while applying.

> > more exit_latency_ns check that becomes redundant to be dropped.
> >
> > However, after the above change, latency_req cannot take the predicted_=
ns
> > value any more, which takes place after commit 38f83090f515 ("cpuidle:
> > menu: Remove iowait influence"), because it may cause a polling state
> > to be returned prematurely.
> >
> > In the context of the previous example say that predicted_ns is 3000 an=
d
> > the PM QoS latency limit is still 20 us.  Additionally, say that idle
> > state 0 is a polling one.  Moving the exit_latency_ns check before the
> > target_residency_ns one causes the loop to terminate in the second
> > iteration, before the target_residency_ns check, so idle state 0 will b=
e
> > returned even though previously state 1 would be returned if there were
> > no imminent timers.
> >
> > For this reason, remove the assignment of the predicted_ns value to
> > latency_req from the code.
> >
> > Fixes: 5ef499cd571c ("cpuidle: menu: Handle stopped tick more aggressiv=
ely")
> > Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |   29 ++++++++++++-----------------
> >  1 file changed, 12 insertions(+), 17 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -287,20 +287,15 @@
> >               return 0;
> >       }
> >
> > -     if (tick_nohz_tick_stopped()) {
> > -             /*
> > -              * If the tick is already stopped, the cost of possible s=
hort
> > -              * idle duration misprediction is much higher, because th=
e CPU
> > -              * may be stuck in a shallow idle state for a long time a=
s a
> > -              * result of it.  In that case say we might mispredict an=
d use
> > -              * the known time till the closest timer event for the id=
le
> > -              * state selection.
> > -              */
> > -             if (predicted_ns < TICK_NSEC)
> > -                     predicted_ns =3D data->next_timer_ns;
> > -     } else if (latency_req > predicted_ns) {
> > -             latency_req =3D predicted_ns;
> > -     }
> > +     /*
> > +      * If the tick is already stopped, the cost of possible short idl=
e
> > +      * duration misprediction is much higher, because the CPU may be =
stuck
> > +      * in a shallow idle state for a long time as a result of it.  In=
 that
> > +      * case, say we might mispredict and use the known time till the =
closest
> > +      * timer event for the idle state selection.
> > +      */
> > +     if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> > +             predicted_ns =3D data->next_timer_ns;
> >
> >       /*
> >        * Find the idle state with the lowest power while satisfying
> > @@ -316,13 +311,15 @@
> >               if (idx =3D=3D -1)
> >                       idx =3D i; /* first enabled state */
> >
> > +             if (s->exit_latency_ns > latency_req)
> > +                     break;
> > +
> >               if (s->target_residency_ns > predicted_ns) {
> >                       /*
> >                        * Use a physical idle state, not busy polling, u=
nless
> >                        * a timer is going to trigger soon enough.
> >                        */
> >                       if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLIN=
G) &&
> > -                         s->exit_latency_ns <=3D latency_req &&
> >                           s->target_residency_ns <=3D data->next_timer_=
ns) {
> >                               predicted_ns =3D s->target_residency_ns;
> >                               idx =3D i;
> > @@ -354,8 +351,6 @@
> >
> >                       return idx;
> >               }
> > -             if (s->exit_latency_ns > latency_req)
> > -                     break;
> >
> >               idx =3D i;
> >       }
> >
> >
> >
>
> Good catch!
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thank you!

