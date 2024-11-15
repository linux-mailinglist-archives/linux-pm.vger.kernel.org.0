Return-Path: <linux-pm+bounces-17620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5367F9CDE96
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 13:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071251F23C29
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 12:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0A41BBBEE;
	Fri, 15 Nov 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH8UeCmb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344321B85FD;
	Fri, 15 Nov 2024 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674803; cv=none; b=MKKUXNBV9MOsA6YgFdKXfsTt91pUd/163ut28flgNKeqwnba7TUiiM6hSBEJ5STAy7d9f6DKPGE2ihx3LcjIVUzJn1oaSnlffe1WQnYUZ2oBlI9jylm8StAMm9+xRKvNccSBjJeoc4qhJ3rTsOHBH2XKH2fjyHrf63rt347pWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674803; c=relaxed/simple;
	bh=8aDRtTQm3vB76/p/BDdHVnHjf8UlRzNOOlJGWkDMkRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgszdoGrcqpwNAy/RFj7Momyf+lB7InbeyfTmstg2zylux8GGQ7roI4ha3N1kC2n/DTyNTYNzsV9DF2DT0M+HY8fMoON2bX8rI8ll031Jzjw5re9xsGK/2Ae1QYoRcxLWYPtE3W0xtGNYCgXQEaiBo9TfDWaF7mdRZqTIDoKSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH8UeCmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95A7C4CED5;
	Fri, 15 Nov 2024 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731674802;
	bh=8aDRtTQm3vB76/p/BDdHVnHjf8UlRzNOOlJGWkDMkRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gH8UeCmbEnBgkFt9EajTvMhTWWhUx+7RaKLkVJa5hTw0pyIfRiJTXOfczbg/vbKF4
	 D4UrWHYOwaDO1nJ29FeX0mP4b/PY0jL3KcekHLvw6J5flh/3IGvvK6c1KC5gtHMvgE
	 husjAlZVV2PoKZxdI5rK7Q3ENkRGMQ5RLRGokQDxWZT2z/UVLgG78Qiael2WxSmSXb
	 OSg/79Qtso1kic+TglwhYsksklfydEtEbhq6ecyxU28QvC3H4AwqkBfHABlr7Chr1q
	 U/hQ+op++QPJFK/amQby9T84aAjXN7mCcykKCN0ZgA7lDSOg1poeHWeqZPyNoO6dIz
	 3V/JuTxClKPkQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e5fa17a79dso1057123b6e.1;
        Fri, 15 Nov 2024 04:46:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJ42Ci6lgrvnsuFPfI24AHAiFwpOVwD+0wzy2kI03PRj5Igw6PW/F+qIGM0oRD1kShu+I6z201kIw=@vger.kernel.org, AJvYcCUl4NrFbyhrQDnkbwuSJO+towDcJV3s2G7XDWrY5fLZRgen8LcZjM9XOUJJZgXTPUF3E2J77jDxEnzdJGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/l//AEKtQUpXnw0fYhT94IT3L1acLX6GPyLXZwG6FifYZAq3E
	9EBHKpXz7SRUhUZSgOkufUH4ZbbJ5ZS5kKZz0x006ynDwAuq12puWsnj4OYtAgQIHmLu2oC+Nxm
	4KsJcV6dtj7BmMKjy6P/2Hf7NBm0=
X-Google-Smtp-Source: AGHT+IFhk0veV14hjjnkJK5v7zS2WQq7ReURviNmpS+z23aG2SzFAJWG51skgBmqfjjDcI3b2XJ+dYlYNGazfWdVz6I=
X-Received: by 2002:a05:6808:1449:b0:3e6:5a7f:e102 with SMTP id
 5614622812f47-3e7bc79e3d0mr2153557b6e.9.1731674801996; Fri, 15 Nov 2024
 04:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4992010.31r3eYUQgx@rjwysocki.net> <20241115101427.GA22801@noisy.programming.kicks-ass.net>
In-Reply-To: <20241115101427.GA22801@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Nov 2024 13:46:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gfSpzjD1PDhMOmqV_wcnCtr=m12noAqVpQkDsjetu+Ug@mail.gmail.com>
Message-ID: <CAJZ5v0gfSpzjD1PDhMOmqV_wcnCtr=m12noAqVpQkDsjetu+Ug@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: Do not return from cpuidle_play_dead() on
 callback failures
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>, 
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 11:14=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Thu, Nov 14, 2024 at 06:46:20PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the :enter_dead() idle state callback fails for a certain state,
> > there may be still a shallower state for which it will work.
> >
> > Because the only caller of cpuidle_play_dead(), native_play_dead(),
> > falls back to hlt_play_dead() if it returns an error, it should
> > better try all of the idle states for which :enter_dead() is present
> > before failing, so change it accordingly.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/cpuidle.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > @@ -70,9 +70,10 @@ int cpuidle_play_dead(void)
> >               return -ENODEV;
> >
> >       /* Find lowest-power state that supports long-term idle */
> > -     for (i =3D drv->state_count - 1; i >=3D 0; i--)
> > -             if (drv->states[i].enter_dead)
> > -                     return drv->states[i].enter_dead(dev, i);
> > +     for (i =3D drv->state_count - 1; i >=3D 0; i--) {
> > +             if (drv->states[i].enter_dead && !drv->states[i].enter_de=
ad(dev, i))
> > +                     return 0;
> > +     }
>
> Hmm, strictly speaking there is no 'success' return from play_dead(). On
> success, the CPU is dead :-)

Well, would you prefer something like

for (i =3D drv->state_count - 1; i >=3D 0; i--) {
        if (drv->states[i].enter_dead)
                drv->states[i].enter_dead(dev, i);
}

and adding a comment before the final return statement that
:enter_dead() only returns on failure?

