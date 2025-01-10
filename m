Return-Path: <linux-pm+bounces-20225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF892A09225
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD6D188298F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E920B80D;
	Fri, 10 Jan 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onJH6tIZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2B78C91;
	Fri, 10 Jan 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516093; cv=none; b=mDaC1G3Sv1Dy0SARYdEmpmEp5EOhA7gv6BZpCq81eNLdLvppv8wyekzrs/Ks2oeEOsc/OhGdtCfgjbMwHBpJ51Px0+wPgNzeEnEs2q0L9X18d8zB5FTYWYPPk7L6BkRTnS07dWDcooGDMRhsvKdZMH4CvuDvbzJQRN957sAqByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516093; c=relaxed/simple;
	bh=UVYtGWlHf2XPJdl7LbzGBo+7rdm/RbujJMBqXcO5uuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhkUb5j26j4K6zewXKqbxY6D99VT0u+os+8rfeC8PngQK1UPp2wWYsBY+dQPg3qQu1iDGVxEdc880lmOXwe+IgRpc46i87r5XohbRYlfCdxXyBr3hWixfrPABDewIK7H9FsE3YuZ8wDvJZe7aB0+JVHTHYaoFZmXW2Ldh/7T5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onJH6tIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BD8C4CEE2;
	Fri, 10 Jan 2025 13:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736516093;
	bh=UVYtGWlHf2XPJdl7LbzGBo+7rdm/RbujJMBqXcO5uuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=onJH6tIZ0xgNn/542cvEqBP4iw+aZB0JI1hEJkc+Hwo8jLPFZisdsT5aAGr+0nDkB
	 5EYdDIkiNEcQNOfKfga5vGFSqEKWcUljQgMypFDeCFiIVWbDILD1QRCIkaSH8rC3aM
	 9OKYe1QKJmR93ohdbTsAPTXxKH3CyyQOeaJXpiDHvYqqkIgUxOUCBRrKGVEcGqstSo
	 0aR8pt5HUYEvLqgavVVsxVxJItnKqUGxLysLx/Jm1g0dGfffBG/1hunaJi6fG2Ccfm
	 7lv164kuNTw6ebIgqIcPg6E6Zbdvu+IN7WdfVdfOae12buSM5hybKMc4FwGjsy8gKq
	 9YxHnCX++hhRw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29e5aedbebdso982139fac.0;
        Fri, 10 Jan 2025 05:34:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwoIetVvNy2NOJ9W6tRSqEyrjWTClLLJmsX4yDdoM42nejLVSo/8OTcjxZJT/NKWjJP70S7UCMWsc=@vger.kernel.org, AJvYcCXCjZhM5zlaG6XKu/MEjB/uT/B8dFLcxL8v3TXlLQTL00bhD+yEMfy9uJK8QUwZncOw3Hj7WvcFqblOU9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfjdG3IbxkuYYKte7RBTaIKalVBXu3ZcU4IDbZhYbhP+VM//J
	2PiohwNLIMdmsJUaOMOHpDzytviU8VNFBh8YZjqvIMlf8KJaU4Gq8orWcmQtY5CkZBdriWcxyvx
	EAaoXHtQp0HAWZv3UbpX69bhTE3c=
X-Google-Smtp-Source: AGHT+IEI9IczEXSwTUFK/n8L7ouDRXi2e2SPA47I/92Ohk0226VABcXkdADRlyPxzizGlwXoPYX310waazhd6b2CY7c=
X-Received: by 2002:a05:6871:800a:b0:29e:3bea:7e60 with SMTP id
 586e51a60fabf-2aa0698375emr5339496fac.38.1736516092550; Fri, 10 Jan 2025
 05:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4953183.GXAFRqVoOG@rjwysocki.net> <13679187.uLZWGnKmhe@rjwysocki.net>
 <842b1500-9f4f-47e5-9777-ee89351f956e@arm.com>
In-Reply-To: <842b1500-9f4f-47e5-9777-ee89351f956e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Jan 2025 14:34:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKZP7b8G+FJrb2kTSo90YK75XUsukExPMGVqhoZsSU7A@mail.gmail.com>
X-Gm-Features: AbW1kvZXg5zq4NzD1-GKtJII0BbF4s2IKA6AwzAV-wNyz8-Lz_fHYVRxnhV6GzE
Message-ID: <CAJZ5v0hKZP7b8G+FJrb2kTSo90YK75XUsukExPMGVqhoZsSU7A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] cpuidle: teo: Add polling flag check to early
 return path
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 2:16=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/10/25 12:53, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After commit 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_leng=
th()
> > call in some cases") the teo governor behaves a bit differently on
> > systems where idle state 0 is a "polling" state (that is, it is not
> > really an idle state, but a loop continuously executed by the CPU).
> > Namely, on such systems it skips the tick_nohz_get_sleep_length() call
> > if the target residency of the current candidate idle state is small
> > enough.
> >
> > However, if state 0 itself was to be returned, it would be returned
> > right away without calling tick_nohz_get_sleep_length() even on systems
> > where it was not a "polling" state until commit 4b20b07ce72f ("cpuidle:
> > teo: Don't count non-existent intercepts") that attempted to fix this
> > problem.
> >
> > Unfortunately, commit 4b20b07ce72f has made the governor always call
> > tick_nohz_get_sleep_length() when about to return state 0 early, even
> > if that state is a "polling" one, which is inconsistent and defeats
> > the purpose of commit 6da8f9ba5a87 in that case.
> >
> > Address this by adding a CPUIDLE_FLAG_POLLING check to the path where
> > state 0 is returned early to prevent tick_nohz_get_sleep_length() from
> > being called if it is a "polling" state.
> >
> > Fixes: 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts=
")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -422,7 +422,8 @@
> >                       first_suitable_idx =3D i;
> >               }
> >       }
> > -     if (!idx && prev_intercept_idx) {
> > +     if (!idx && prev_intercept_idx &&
> > +         !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
> >               /*
> >                * We have to query the sleep length here otherwise we do=
n't
> >                * know after wakeup if our guess was correct.
> >
> >
> >
>
> But then you do run into the issue of intercepts not being detected if
> state0 is the right choice, don't you?

That's true, but then on systems with a "polling" state 0 you still
have this problem if the state returned early is not state 0.  Say C1
on x86.

The point here is that the behavior needs to be consistent, one way or anot=
her.

The exact point of commit 6da8f9ba5a87 was to avoid calling
tick_nohz_get_sleep_length() in some cases when the state to be
returned is shallow enough and obviously that includes a "polling"
state 0, possibly at the cost of being somewhat inaccurate in
prediction.

Then you're seeing this intercept accumulation for state 0 when there
are only 2 states in the table (or all of the other states are much
higher target residency than state 0).

Commit 4b20b07ce72f effectively caused tick_nohz_get_sleep_length() to
be called every time on systems without a "polling" state 0, which was
fair enough, but it also affected the other systems, which wasn't.

> This would then enable intercept-detection only for <50% of the time,
> another option is to not allow intercepts selecting a polling state, but
> there were recent complaints about this exact behavior from Aboorva (+TO)=
.
> They don't have a low-latency non-polling state.
>
> https://lore.kernel.org/lkml/20240809073120.250974-1-aboorvad@linux.ibm.c=
om/

If they don't have a "polling" state 0, they won't be affected by this
patch and after commit 4b20b07ce72f, they'll always call
tick_nohz_get_sleep_length(), so the current governor behavior is
generally unsuitable for them.

I have an idea how to change it to be more accurate in prediction, but
we'll see how it goes.  Stay tuned.

