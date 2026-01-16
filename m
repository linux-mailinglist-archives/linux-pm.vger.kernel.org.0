Return-Path: <linux-pm+bounces-40997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB56FD311C1
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA09303ADDD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1291DE4EF;
	Fri, 16 Jan 2026 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrKODXr/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297111D95A3
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566577; cv=none; b=QfFm2E1yt9UZn8N0w2O6PrHhpQgCdeLvUsX2zNHL6TmYYhykVMOGInaFBN1FhAg5g9ULzxu7EGIZR6CjVQO3J3mnHoxCO2xeJcdzWnRCk3/ttvGY3H+1q+8+xygEPLrKX6bRfxjlUzWjc6sZzH6En5KEwUMQVKBt7jvvKs0MUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566577; c=relaxed/simple;
	bh=Iq7ytyp+dAm1XighsG//f6DoaYGEMR2mEjShU87+Uns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6+FeQq4aSdMPhmqj4sWBJUKsX+FmlR2i7T1rhlbRPTlQbuoOnX3d1EHWK8V9gNWHmFESerCCKDMss70DBc9EPjVOLFGmAiFSokBpZziGJlbkdmgpiQD9xTpyZj/vURQ6pDtEPKC84AiWUIxF2DMGg5Kh0expu7YOhIa7+a7aZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrKODXr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD52AC19423
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768566576;
	bh=Iq7ytyp+dAm1XighsG//f6DoaYGEMR2mEjShU87+Uns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LrKODXr/LVOII/L27gkAMFLr2RhDkd1+3jQ0ULnTbKGfxDElPOchJHsunSmuTc2RR
	 azkqpFr82MkRS6iCG3XJ/pn+/ruerLhra20bWLHqEuMT7YmwI8r0XB4b5vDP4rUJ2x
	 qlizoFROSL0jEMIIDPy7/SMfb7fHqobYuG0pKSsHggj/OAcM2rwSJOxLxbFsprKOeJ
	 flHVM4KCEOizFuEXuZnP3RJqpVv5n4PSNUcTjlNOPS1RlE/ogBJBdQU2z5IW1ZVf6m
	 99L37a4pTqNzfF9YMxYPGkKXSBWy9I1ccNpWn5vYVogzomAK1tcNLBPbEHa3DE6Lf8
	 hLxh+T/PvAqsw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45c7400259bso787846b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 04:29:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzAQLPD+Fv8KwqyzzUXEnT8wmVty82h4WTH35XrdxdZdav3Egf+rZgJqqWUfzfqmNi1UwE86spOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylsiMfoq+sKXpHYS6H+enmX23I4TA31dCMcgFes/KX2udy9Axl
	Aoc4oi2GFBpmZBAWem2J8DEX7pxBudUfnhhgtLcHqeiqRl8pQyxvvze11odRiRG67RRCLiWjNZ5
	se8dDrZ26oGU9zyMXL43fTokvxjwACY4=
X-Received: by 2002:a05:6820:1ca2:b0:659:9a49:8dcc with SMTP id
 006d021491bc7-661188d53bbmr1084065eaf.14.1768566576000; Fri, 16 Jan 2026
 04:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2257365.irdbgypaU6@rafael.j.wysocki> <0532f98b-1f33-418b-ae94-d9bb57fb259a@arm.com>
In-Reply-To: <0532f98b-1f33-418b-ae94-d9bb57fb259a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Jan 2026 13:29:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iGKZH_Zg1M_pXSizoPMHt5fuZOPbDeWhmXHatimjZBCQ@mail.gmail.com>
X-Gm-Features: AZwV_QjGVgiz07s9XAOcwVIbU4KySrytJ85rG_3ua8wfertFEA6noh9kgH3WiYs
Message-ID: <CAJZ5v0iGKZH_Zg1M_pXSizoPMHt5fuZOPbDeWhmXHatimjZBCQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] cpuidle: governors: teo: Wakeup events
 classification change and some refinements
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 12:52=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/14/26 19:42, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This material has been in my local queue for almost a full development =
cycle,
> > so time to post it.
> >
> > The motivation for the changes in this series is mostly theoretical, bu=
t I do
> > see some idle power improvements from patch [4/5], for example, but not=
hing
> > specifically worth reporting.
> >
> > The first patch simply prevents idle states with zero-size bins from be=
ing
> > selected sometimes when teo_select() runs with stopped tick.
> >
> > Patch [2/5] avoids counting tick wakeups as intercepts unless there are
> > sufficiently many intercepts within the tick period range to assume tha=
t
> > the tick wakeup may have clobbered a genuine intercept.
> >
> > Patch [3/5] simply updates a coefficient in one of the inequalities to =
be
> > somewhat easier to interpret (this should be a cosmetic change).
> >
> > Patch [4/5] changes the criteria used for classifying wakeup events as =
hits
> > or intercepts to (hopefully) make the classification work better for la=
rge
> > state bins.
> >
> > Patch [5/5] refines the idle state lookup based on intercepts to first
> > consider the state with the maximum intercepts metric, so that state is
> > always taken into consideration.
> >
> > Please see the individual patch changelogs for details.
> >
> > Thanks!
> >
> >

Hi Christian,

> Hi Rafael,
> I'll do the in-depth review, but have run some tests already.
> They are attached, platform is the usual rk3399.
> "teo" is mainline, "teo-$i" is with patches 1..$i applied.

Thanks for testing!

> There's a regression on teo-4 visible on the intercept heavy IO workloads=
,
> for idle misses that isn't strong enough to reflect in score changes exce=
pt
> for the very slow mtdblock device.
> interestingly though there also seems to be a regression in
> mapper/dm-slow (dm device with 51ms delay on each IO), which is not
> intercept heavy.
> Looking at the state residencies it overuses the deepest state2 in
> where state1 was preferred for the other teo variants.
> I've attached that too for reference.
> I'm assuming that is because of the new intercept-logic-exclusion clause.

So can you please restore that clause to its previous form, while
keeping the other changes in patch 4, and see if the regression is
still there?

> teo-5 seems to be slightly better than teo-4 here, but still a regression
> from the others.

I see.

