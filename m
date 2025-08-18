Return-Path: <linux-pm+bounces-32576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6BB2AFA2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F98418A5E32
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92025283FC3;
	Mon, 18 Aug 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5uWIZmX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B302773D9;
	Mon, 18 Aug 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538907; cv=none; b=bH6DX0x04e4KwYyIL8df1bKvVzpque6b/anT7UjGLIScv+WqWtRpJCf2KFjLG3m99ehj8tyvDPBPoXWgqSvpSlBggr+/arZG6F0QjiY9WTuZuDRvSNO9war3eOVgDVvYGZlkj8Sb+u5jzxzhfYjEligwC25dvDGtdPuPt8dI4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538907; c=relaxed/simple;
	bh=cYWtsiJGtihXFgyhyhpeKFwvCJd0vJ94ICN5unw9gAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1Sj8N/bG2IHE15UQOniYIRq0VJOBGGWdMZsAdAH3BY44xvhmiIChVVPksO1P0D891nwjurRg+M/9f0cVBt2ewN51EPzN0X+JflHW5e4Q/sKdL6POUW64AAcmiGwPLgvOr+JVkXBCHGDR1AgEK0cvZi2vzUrdxTGm2V6kA1bcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5uWIZmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D82C4CEF1;
	Mon, 18 Aug 2025 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538906;
	bh=cYWtsiJGtihXFgyhyhpeKFwvCJd0vJ94ICN5unw9gAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I5uWIZmX3s/Ryqjdw/12lYlS84SAU+Lra3p5bXaGnbt22rlNpftzXnaU2dhYDa6oO
	 2xjACxx2dliMWGHY1+N0eiEStIYjdLyQqctX8vVyAfH1syA7o2/zz5/OBIx0Q8PC+E
	 +kJ/W8AtG3i83k6lTlQpDfZjllL/S8C4Yzyf57thZ926UiAhsX07CRb2XcYz6XEoN3
	 DXb15or/SqnEJ88ePAGf7+jav0S2pRq5H5GIvdM8rLEbZ1V3XaRyBg1q1PjI282FdK
	 iUJsrf6/EalYA+fTTuc7aXeE21hmiMvIny0vYzPGb6QCVG9YQpqkLEvL/kcidtNwRH
	 93flri4dfNaoA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30cce5b711bso3625562fac.0;
        Mon, 18 Aug 2025 10:41:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2SWtveCSayD2QWpnaNzp8buxmtvizGQZD+krJ1vT91PP0qiWM08GnrxMgFsiflD2daMp0CiUoyPs=@vger.kernel.org, AJvYcCX2tT9K9ICDtJeJce3CtgYCKb/QhTY2p7HWUT4v7rPjDC/qbmE2/T8p8NROBQPYrZG0R5UxMa3I1p8WAN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRFCboHFc7It0jHb6Z9R3JY1Dh6WpV7mDbZovBd1o6SU+amsw
	ziGgZ/dGkdV0Vosjx8LjTdYvRc7a3qCSza7lkcVzeeFQwQyaQJn6kEhnpv5tBWKB201Uugt28Jk
	j57wxbr9n1VisJL6rj0qtXHHnz/QWnXA=
X-Google-Smtp-Source: AGHT+IGVyYYrtN3lr7XolYOLAIMRk7cq51ADEukhSg0JGP9CK2DtcdjKMns4Pgg07cNyDWafw+qCbxhLytEYstAHABM=
X-Received: by 2002:a05:6870:d912:b0:2ff:9c45:4f51 with SMTP id
 586e51a60fabf-310aad4cf5bmr8104752fac.15.1755538906242; Mon, 18 Aug 2025
 10:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <2244365.irdbgypaU6@rafael.j.wysocki>
 <9104c434-9025-4365-8127-28014ddddc8d@arm.com>
In-Reply-To: <9104c434-9025-4365-8127-28014ddddc8d@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Aug 2025 19:41:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iTaa62WGXCLcgiRyzcj2GBXmYcvLa8AtQZD5bQcxTw5g@mail.gmail.com>
X-Gm-Features: Ac12FXwmbMoRlFRjAGl4x3sK6EGRxQQDe0VPxAvxfcO95h8NI0JoD5iLwee-mUk
Message-ID: <CAJZ5v0iTaa62WGXCLcgiRyzcj2GBXmYcvLa8AtQZD5bQcxTw5g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full CPUs
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:09=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/13/25 11:29, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When the menu governor runs on a nohz_full CPU and there are no user
> > space timers in the workload on that CPU, it ends up selecting idle
> > states with target residency values above TICK_NSEC all the time due to
> > a tick_nohz_tick_stopped() check designed for a different use case.
> > Namely, on nohz_full CPUs the fact that the tick has been stopped does
> > not actually mean anything in particular, whereas in the other case it
> > indicates that previously the CPU was expected to be idle sufficiently
> > long for the tick to be stopped, so it is not unreasonable to expect
> > it to be idle beyond the tick period length again.
> >
> > In some cases, this behavior causes latency in the workload to grow
> > undesirably.  It may also cause the workload to consume more energy
> > than necessary if the CPU does not spend enough time in the selected
> > deep idle states.
> >
> > Address this by amending the tick_nohz_tick_stopped() check in question
> > with a tick_nohz_full_cpu() one to avoid using the time till the next
> > timer event as the predicted_ns value all the time on nohz_full CPUs.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |   12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -293,8 +293,18 @@
> >        * in a shallow idle state for a long time as a result of it.  In=
 that
> >        * case, say we might mispredict and use the known time till the =
closest
> >        * timer event for the idle state selection.
> > +      *
> > +      * However, on nohz_full CPUs the tick does not run as a rule and=
 the
> > +      * time till the closest timer event may always be effectively in=
finite,
> > +      * so using it as a replacement for the predicted idle duration w=
ould
> > +      * effectively always cause the prediction results to be discarde=
d and
> > +      * deep idle states to be selected all the time.  That might intr=
oduce
> > +      * unwanted latency into the workload and cause more energy than
> > +      * necessary to be consumed if the discarded prediction results a=
re
> > +      * actually accurate, so skip nohz_full CPUs here.
> >        */
> > -     if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> > +     if (tick_nohz_tick_stopped() && !tick_nohz_full_cpu(dev->cpu) &&
> > +         predicted_ns < TICK_NSEC)
> >               predicted_ns =3D data->next_timer_ns;
> >
> >       /*
> >
> >
> >
>
> OTOH the behaviour with $SUBJECT possibly means that we use predicted_ns =
from
> get_typical_interval() (which may suggest picking a shallow state based o=
n
> previous wakeup patterns) only then to never wake up again?

Yes, there is this risk, but the current behavior is more damaging IMV
because it (potentially) hurts both energy efficiency and performance.

It is also arguably easier for the user to remedy getting stuck in a
shallow idle state than to change governor's behavior (PM QoS is a bit
too blunt for this).

Moreover, configuring CPUs as nohz_full and leaving them in long idle
may not be the most efficient use of them.

