Return-Path: <linux-pm+bounces-29012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60151ADF703
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 21:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A3F4A16C1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28E217737;
	Wed, 18 Jun 2025 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf7ZidFZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD2215F56
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275817; cv=none; b=J70y//akAcgdxFrMjGgcmeW/q9F/uIC4ynmrnRgfsTWez6eVOkD6FkvunXBB5Ohw7yWZ6ZvOmud+Q88jHyNegyDsjqR9nimyeZJOPV0UzaTO9G2nzGZlvFsfrtxPJlQ1Lbw1uLq9rBTkZIwkwdQCwcgCjmciNRZxKf6kGmvMH8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275817; c=relaxed/simple;
	bh=HA/J4AEIYU6yEPIbWzA/FU53Hgds7LwQ9aG0CLt4y8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXPOlpr9lHzVYnnRovQEmPqh3cl5D4jYGXBg9OmoBf0nnxNO3W+WurCeLpUsE3+mXpzw6P/hYsrM5luEWom7gnTQoDvwq8gdmpzj5b7C0y8yhLIkgg6L8v1Hb5CyzrMO0UMHcWPHVTsR8BPaz3dQ7g3L1GTGxF6qE7SXDPM/5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf7ZidFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8D7C4CEED
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 19:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750275817;
	bh=HA/J4AEIYU6yEPIbWzA/FU53Hgds7LwQ9aG0CLt4y8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gf7ZidFZmry0QKSzf+sOQ8wT2YK/IuTSiuknqI8ujnQJVRYoanjJ/V6FfUHRX5Jl1
	 pbamC5NzOtsqOMBAZbAuTb8z6bXuDdikAhg7zeBY6UPPxrqzQb8Yb2GJtm+coM2UoE
	 weQl9gVekG2EKArLISyQ2bA5e4FeqUq/I8/GCHdTsSwFSQegpYTv1UFSP14YPof0Jo
	 i3geNSrNQqFox8bCVsfeA07+i8rj1ftTj5kz9SNC5iBlBnUcExb/GwzV8XgVBBqTng
	 B2rn5CnDD77SytPj4FoydnTWWQBFDHDylAbb4LlQ5vQti36FRWSsNDOiYUnFTD+kb+
	 UYFosYJNKCdAw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4066a0d0256so4723551b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 12:43:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8xQhgKpbkHQnCqgal+/4sK+xfauEtZQPplgGfu7Eb/OjcYmbbv2U8qlIUo6AyYi+94/X1keYGFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmH8JFSELz+mSvKaRoNvpTyX+k3OTrFNeutohZWMKio8UZBmo
	G6uGl8sEKnGVNA+XCdX74t9wLaB+DmYRQ5X0kIWhW+Y6FfKQbpCeFaMM6aWeRoWjz44MRUZMlLI
	TjxYJ9OD1CjU9KdqeRb5zu8mcLH489RI=
X-Google-Smtp-Source: AGHT+IFOpWdI1HftnDVa2Em/TM/MOdM/JUab5621AQivtXRMVcCB2aanA4RpjYJNjT5U4kajrXyQrgnkatbYJ11bcUc=
X-Received: by 2002:a05:6871:8611:b0:2d4:7cfa:6f3 with SMTP id
 586e51a60fabf-2eaf0b0a4damr9669738fac.20.1750275816694; Wed, 18 Jun 2025
 12:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0hEJ+XVdXGghLiF+KSvHCA=HorZXVR0vXkDaB_zxaM1WA@mail.gmail.com> <aFBudUgU2TWyDgn8@kekkonen.localdomain>
In-Reply-To: <aFBudUgU2TWyDgn8@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Jun 2025 21:43:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iPBT6_zMRUW+=RGfp-baA5nXnj+2z+zWSdRj5SC5C4iA@mail.gmail.com>
X-Gm-Features: AX0GCFuzWMOwcKOMM4TXNahNifs3Wro0R4rU3sxtQgqRi3Rl-7SKxbzypRQLIA4
Message-ID: <CAJZ5v0iPBT6_zMRUW+=RGfp-baA5nXnj+2z+zWSdRj5SC5C4iA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Update last busy timestamp in Runtime PM
 autosuspend callbacks
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:20=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Jun 16, 2025 at 01:21:02PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 16, 2025 at 8:12=E2=80=AFAM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Folks,
> > >
> > > The original plan for adding pm_runtime_mark_last_busy() calls to
> > > functions dealing with Runtime PM autosuspend originally included a f=
ew
> > > intermediate steps of driver conversion, including the use of recentl=
y
> > > added __pm_runtime_put_autosuspend(). The review of the set convertin=
g the
> > > users first to __pm_runtime_put_autosuspend() concluded this wasn't
> > > necessary. See
> > > <URL:https://lore.kernel.org/all/20241004094101.113349-1-sakari.ailus=
@linux.intel.com/>.
> > >
> > > This set extends the inclusion of the pm_runtime_mark_last_busy() cal=
l to
> > > the _autosuspend() variants of the Runtime PM functions dealing with
> > > suspending devices, i.e. pm_runtime_put_autosuspend(),
> > > pm_runtime_put_sync_autosuspend(), pm_runtime_autosuspend() and
> > > pm_request_autosuspend(). This will introduce, for a brief amount of =
time,
> > > unnecessary calls to pm_runtime_mark_last_busy() but this wasn't seen=
 as
> > > an issue. Also, all users of these functions, including those that di=
d not
> > > call pm_runtime_mark_last_busy(), will now include that call. Presuma=
bly
> > > in the vast majority of the cases a missing call would have been a bu=
g.
> > >
> > > Once this set is merged, I'll post further patches to remove the extr=
a
> > > pm_runtime_mark_last_busy() calls. The current set of these patches i=
s
> > > here
> > > <URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-nex=
t.git/log/?h=3Dpm-direct-on-next>.
> > >
> > > It'd be best to have all merged within the same cycle.
> > >
> > > Rafael: any thoughts on the merging?
> >
> > I'm going to queue this up for 6.17.
>
> Thank you! :-)

Now applied.

> >
> > > Would an immutable branch on top of rc1 be an option?
> >
> > I think so, but does anyone need it?
>
> I guess it's not mandatory but we'll have now a lot of redundant calls to
> the pm_runtime_mark_last_busy(). It just doesn't look very elegant. In th=
e
> end it's all up to what the maintainers prefer.

I'll let you know when the branch is ready to pull from.

Thanks!

