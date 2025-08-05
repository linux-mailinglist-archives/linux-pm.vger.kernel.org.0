Return-Path: <linux-pm+bounces-31966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93329B1B4D6
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 15:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3612A1883A7C
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA26C273805;
	Tue,  5 Aug 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKGrDtIn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8D1E1E16;
	Tue,  5 Aug 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400248; cv=none; b=nxZ7P2W6Kfj64Q5z5zQbwER6DHMyOQtzlAsYu5ucZClXbTVYgzRASxOuuHtx8KmUEk9aI1L2GN1V/5CGCQpcq6Cs0RXOocjvCTKCiftjny4gV3it3HGGa4iDSjMGlORto3QCkCXnO49xm6yMddfKS4ouzgJjXkf767BrHe0fzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400248; c=relaxed/simple;
	bh=xZDXyAZOLBlA4/A5JnrnmHPWTOBdRw9MM15cnN+eOVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5Si7w6+NEEZaSrh5kqfg5UMyV2Tydr2rhsDAeyTQ+9Dc0WZzsbcjQsfaQWlq2Ptn2ANpnSB19qPZbCjHA7IvZHhxSa9MIh1iLvc0J80algcYamnjlCJ4u+Ref4d3IeyHv564gSCWRQr/g1jHNuQVYqt0yhOaR3bD4iEhh7I1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKGrDtIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E784C4CEF4;
	Tue,  5 Aug 2025 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754400248;
	bh=xZDXyAZOLBlA4/A5JnrnmHPWTOBdRw9MM15cnN+eOVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QKGrDtInUNQP/8LL2A1lZQ1xRi88S8pZEFk9a4fQWs3++pBDHYMCHXTxWSyTeHRCN
	 ATXk8pxh6YkiuYfWneJVkxzWLVPAoFHACxP/auOa8Gx9NtMUZzg4gHDYVMKG9QJyNn
	 vj3FBv+vmmIWHcP1A/O/4L0j9xzcf7jO+KccOhjD/zR/wAgNEUVxtvcuhDXPpbPyo5
	 1r0Zq1gDfCGKBBpVzkVyW/z3jwmxqkvwqeyewX9ClEfUjJBuwX1F35uz2cu936dODu
	 9T9UNY9txsfIKobqb+frYObgU4bOI/GWVf+Fyaw9OEVjU9pZ6dNK1RTaC/r6p608KE
	 O//yfeqQKk2DA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-619a0f2a8c9so977318eaf.0;
        Tue, 05 Aug 2025 06:24:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUuO0V1zgWlfdxYd2bQfehex1pQtG7wkXYNfUVM+EPJ7b96jfyobikxh9nSQg0KS64Xht/1rgokwSb4sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDwV95X/SGLiHVpbvb5JsJ4Sbmo0o9JYQeCHiSJzIBmC3YwKS
	2cVeFl2ckOgyoIxwSxrIV1BK6x6SfOdQY7qV6c1GCT7eQvMpmhLiXqcL3OShKr/SRUPCfMEfnzi
	Y75OQB1uwrcX2TiCstyLF7BWcDvBPVto=
X-Google-Smtp-Source: AGHT+IF9qo1tbISogqdePZ9CIgk29+uKOQqeYONL8rODcdZ7q8tKCLX9bPjK4rD2p7p3ImOzHHA086FDEYAih5Jjb8I=
X-Received: by 2002:a05:6820:201c:b0:61b:4073:871a with SMTP id
 006d021491bc7-61b40738792mr3433748eaf.7.1754400247507; Tue, 05 Aug 2025
 06:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1916668.tdWV9SEqCh@rjwysocki.net> <7770672.EvYhyI6sBW@rjwysocki.net>
 <86o6sv6n94.wl-maz@kernel.org>
In-Reply-To: <86o6sv6n94.wl-maz@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Aug 2025 15:23:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g=eSeAp96mHCOm+C9jis3uNRXgPhNgtT0SgP9kZ1emvw@mail.gmail.com>
X-Gm-Features: Ac12FXx3dJRVbknhF-e_nma1gjEHxi6UwdAkbI1TjS8gTLy1hATm3AFNcQMt1m4
Message-ID: <CAJZ5v0g=eSeAp96mHCOm+C9jis3uNRXgPhNgtT0SgP9kZ1emvw@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 5/5] cpuidle: menu: Avoid discarding useful information
To: Marc Zyngier <maz@kernel.org>, Christian Loehle <christian.loehle@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 6:54=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> [+ Thomas, Mark]
>
> On Thu, 06 Feb 2025 14:29:05 +0000,
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When giving up on making a high-confidence prediction,
> > get_typical_interval() always returns UINT_MAX which means that the
> > next idle interval prediction will be based entirely on the time till
> > the next timer.  However, the information represented by the most
> > recent intervals may not be completely useless in those cases.
> >
> > Namely, the largest recent idle interval is an upper bound on the
> > recently observed idle duration, so it is reasonable to assume that
> > the next idle duration is unlikely to exceed it.  Moreover, this is
> > still true after eliminating the suspected outliers if the sample
> > set still under consideration is at least as large as 50% of the
> > maximum sample set size.
> >
> > Accordingly, make get_typical_interval() return the current maximum
> > recent interval value in that case instead of UINT_MAX.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -190,8 +190,19 @@
> >        * This can deal with workloads that have long pauses intersperse=
d
> >        * with sporadic activity with a bunch of short pauses.
> >        */
> > -     if ((divisor * 4) <=3D INTERVALS * 3)
> > +     if (divisor * 4 <=3D INTERVALS * 3) {
> > +             /*
> > +              * If there are sufficiently many data points still under
> > +              * consideration after the outliers have been eliminated,
> > +              * returning without a prediction would be a mistake beca=
use it
> > +              * is likely that the next interval will not exceed the c=
urrent
> > +              * maximum, so return the latter in that case.
> > +              */
> > +             if (divisor >=3D INTERVALS / 2)
> > +                     return max;
> > +
> >               return UINT_MAX;
> > +     }
> >
> >       /* Update the thresholds for the next round. */
> >       if (avg - min > max - avg)
>
> It appears that this patch, which made it in 6.15, results in *a lot*
> of extra interrupts on one of my arm64 test machines.
>
> * Without this patch:
>
> maz@big-leg-emma:~$ vmstat -y 1
> procs -----------memory---------- ---swap-- -----io---- -system-- ------c=
pu-----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy i=
d wa st
>  1  0      0 65370828  29244 106088    0    0     0     0   66   26  0  0=
 100  0  0
>  1  0      0 65370828  29244 106088    0    0     0     0  103   66  0  0=
 100  0  0
>  1  0      0 65370828  29244 106088    0    0     0     0   34   12  0  0=
 100  0  0
>  1  0      0 65370828  29244 106088    0    0     0     0   25   12  0  0=
 100  0  0
>  1  0      0 65370828  29244 106088    0    0     0     0   28   14  0  0=
 100  0  0
>
> we're idling at only a few interrupts per second, which isn't bad for
> a 24 CPU toy.
>
> * With this patch:
>
> maz@big-leg-emma:~$ vmstat -y 1
> procs -----------memory---------- ---swap-- -----io---- -system-- ------c=
pu-----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy i=
d wa st
>  1  0      0 65361024  28420 105388    0    0     0     0 3710   27  0  0=
 100  0  0
>  1  0      0 65361024  28420 105388    0    0     0     0 3399   20  0  0=
 100  0  0
>  1  0      0 65361024  28420 105388    0    0     0     0 4439   78  0  0=
 100  0  0
>  1  0      0 65361024  28420 105388    0    0     0     0 5634   14  0  0=
 100  0  0
>  1  0      0 65361024  28420 105388    0    0     0     0 5575   14  0  0=
 100  0  0
>
> we're idling at anywhere between 3k and 6k interrupts per second. Not
> exactly what you want. This appears to be caused by the broadcast
> timer IPI.
>
> Reverting this patch on top of 6.16 restores sanity on this machine.

I don't know what is going on here, but it looks highly suspicious to me.

The only effect of the change in question should be selecting a
shallower idle state occasionally and why would this alone cause the
number of wakeup interrupts to increase?

Arguably, it might interfere with the tick stopping logic if
predicted_ns happened to be less than TICK_NSEC sufficiently often,
but that is not expected to happen on an idle system because in that
case the average interval between genuine wakeups is relatively large.
The tick itself is not counted as a wakeup event, so returning a
shallower state at one point shouldn't affect future predictions, but
the data above suggests that it actually does affect them.

It looks like selecting a shallower idle state by the governor at one
point causes more wakeup interrupts to occur in the future which is
really note expected to happen.

Christian, what do you think?

> I suspect that we're entering some deep idle state in a much more
> aggressive way,

The change actually goes the other way around.  It causes shallower
idle states to be more likely to be selected overall.

> leading to a global timer firing as a wake-up mechanism,

What timer and why would it fire?

> and the broadcast IPI being used to kick everybody else
> back. This is further confirmed by seeing the broadcast IPI almost
> disappearing completely if I load the system a bit.
>
> Daniel, you should be able to reproduce this on a Synquacer box (this
> what I used here).
>
> I'm happy to test things that could help restore some sanity.

Before anything can be tested, I need to understand what exactly is going o=
n.

What cpuidle driver is used on this platform?

Any chance to try the teo governor on it to see if this problem can
also be observed?

Please send the output of

$ grep -r '.*' /sys/devices/system/cpu/cpu*/cpuidle

collected after a period of idleness from the kernel in which the
change in question is present and from a kernel without it?

