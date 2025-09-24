Return-Path: <linux-pm+bounces-35289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF4B9B127
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 19:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B907B6827
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D233168E3;
	Wed, 24 Sep 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD0747gy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F83148C4
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735169; cv=none; b=hR9Siw8qhODNbFinwPw3mKQfQiTsmrZMnOC0iESzedtgT6GRfNOl7oHgF7Eh9raFRlS7eOD4eRtCoAtTTSW2DmD+YVrV839iVGnLFHkAUMpG7Ud6eYA2fsfitXPvQ2Ie36r0JMbsSWqtG0YRAcVj7JBlg8OHm+B71M3qSZv0gPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735169; c=relaxed/simple;
	bh=N57ylfp0cpGyGC49q2K6R3Kxlwmiy1WFW/d/WeBrIHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipoJj+/7Q6fY8o6sE84vyvLYwVZk5hgeve7G4UKdGUeLKgt5wWvyIQyRE7hc6GW0QviS/ouxOouKwtkVaL7ecWSqyYCIsOl+gLa/apk6PjietOAagq7xHmEPeiLZgnr1TSI8xDaBmGg1TLrt48lTsz2Av+O/wPG4/edYm4fOtas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD0747gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD9AC4CEF4
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758735169;
	bh=N57ylfp0cpGyGC49q2K6R3Kxlwmiy1WFW/d/WeBrIHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pD0747gyk4r+iXPyMkwQUmhGKhmVnnN8amRjx8NmUngSwVdPtxYTq4UR1oE1xejJB
	 9fDeQTVNjMj0qWZE+IosynfP0zN/o4vELw1RRsFMlU0706IsYwXccPH9Zla/0w+naY
	 rZHT6o7O7gtr6YpEeW1JT+mwBM2rFmJLQg3iu2x+sd3W23rjl2+4JoLTka1N9OQmqz
	 HJoQRWydhr++xjuFIXuCSfj7fy/RlVNEEyRfygFOEQZ5QIaw8VGw8SQ8war++3CI5O
	 7E4R1FE6YMX6Xlv9VrUw1JsyaTEp2PuW4P8aX1PzciK0H+O4QLk2UrjkEUf/sQaA1a
	 tAIC1nEE6iWYQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-793ef18e8a3so27609a34.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 10:32:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDu9MrJ8ASWkKJoytBD8KeWSmtND9BInw0wbmLbe/NJVeq0W5dcWBaz9qXynBHuG3ylrZVOE3i3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYs/CeV5Sr4jvcKSCvJNuE2hE0fdk8z0Hse8RtXWhcWjUkmYv
	wFWCVhiRBeuxpu+DNDbh8nSYPSjjmTijp63hOAAcpvG3FgSeR0BiwhBlNeCiRq1Q3WVWkOV+b9/
	TQBUpAouaZcgEaarCjGIFx6b3JaVqAeY=
X-Google-Smtp-Source: AGHT+IE17tQHof0YwlFF6INr0qw1UwcmFFp6Nfi25etvxnlaAvXosYHhSYdyymFTj7vcL9okMKZfw4eLABQxoAQjUzY=
X-Received: by 2002:a05:6830:2c0e:b0:753:7a09:78d5 with SMTP id
 46e09a7af769-7a074c216a9mr271125a34.8.1758735168429; Wed, 24 Sep 2025
 10:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>
 <aMHjOJGaKi9cwbsn@google.com> <CAJZ5v0iELLPYBS6FKmX=DhoyQ2tDq9F9DAzuV0A8etv0dGeJvQ@mail.gmail.com>
 <aNMWa0SD5l4Cb6G_@google.com>
In-Reply-To: <aNMWa0SD5l4Cb6G_@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 19:32:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jnPsVrULF9+S-e+HvT+bik=+WA7FfXzFg5vfO8WhTy9Q@mail.gmail.com>
X-Gm-Features: AS18NWAizqE9xg3DJDB8kO1MsPcsbi2ZudRba1wG5FHzgNJxsPJfsrvHWUpou40
Message-ID: <CAJZ5v0jnPsVrULF9+S-e+HvT+bik=+WA7FfXzFg5vfO8WhTy9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, kunit-dev@googlegroups.com, 
	Len Brown <lenb@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Tue, Sep 23, 2025 at 11:51=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> Hi Rafael,
>
> On Fri, Sep 19, 2025 at 06:58:50PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 10, 2025 at 10:44=E2=80=AFPM Brian Norris <briannorris@chro=
mium.org> wrote:
> > > On Fri, Sep 05, 2025 at 07:37:38PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, Aug 29, 2025 at 2:33=E2=80=AFAM Brian Norris <briannorris@c=
hromium.org> wrote:
> > > > > +       /* Flush, in case the above (non-sync) triggered any work=
. */
> > > > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no =
wakeup needed */
> > > >
> > > > Why do you run pm_runtime_barrier(dev) here?  It is guaranteed that=
 no
> > > > requests are pending at this point.
> > >
> ...
> > > So IMO, it's a reasonable thing to run in this test, although I proba=
bly
> > > should drop the "Flush" comment.
> >
> > Yeah, changing the comment would help.
>
> Will do.
>
> > > > > +
> > > > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > >
> > > > This has already been tested above.
> ...
> > > Anyway, like I said, it's probably some matter of opinion/style. I ca=
n
> > > drop some of these checks if you still think they have no place here.
> >
> > I would do just two of them, one at the beginning and one at the end.
> > It should be an invariant for everything in between.
>
> Ack.
>
> > > > > +       /*
> > > > > +        * We never actually left RPM_SUSPENDED, but rpm_idle() s=
till treats
> > > > > +        * this as -EAGAIN / "runtime PM status change ongoing".
> > > >
> > > > No, this means "Conditions are not suitable, but may change".
> > >
> > > I'm just quoting the API docs for put():
> > >
> > > """
> > > * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status cha=
nge ongoing.
> > > """
> > >
> > > If that's the wrong language, then we should update the API doc. At a=
ny
> > > rate, I'm not sure what's "unsuitable" about a suspended device when =
we
> > > call put(). It's not unsuitable -- it's already in the target state!
> > >
> > > Notably, I'm also changing this behavior in patch 2, since I think it=
's
> > > an API bug. And the comment then goes away.
> >
> > Yeah, so I'd prefer to change this particular thing entirely,
> > especially in the face of
> >
> > https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/
> >
> > which quite obviously doesn't take the return value of
> > pm_runtime_put() and pm_runtime_put_sutosuspend() into account.
> >
> > I would like these two functions to be void.
>
> Sure, I think inspecting put() return codes is generally a bad idea.
> 'void' would be cool with me, although maybe a bit impractical now,
> considering how many users look at the current return code.

For pm_runtime_put() it's not that bad.  I have ~20 patches changing
all of the code looking at its return value to stop doing that.

Interestingly enough, there's only one piece of that code (USB core)
doing anything remotely useful with that return value.  Everything
else is just garbage IMV.

> So at a minimum, I'd separate "make 'em void" from my "document and test =
the
> API" work.

But you can just skip them.

> Really, I'm mostly looking at this area because I have to support driver
> developers trying to learn how to use the runtime PM API, and they
> wonder about the return codes. So if they exist, I'd at least like them
> to make sense.

Sure.

That said, as far as pm_runtime_put() and pm_runtime_put_autosuspend()
are concerned, you may as well just say "discard their return values,
you don't want to have to deal with them, and never ever pass them
verbatim to the callers of your code".

> Anyway, for the particulars of this test: I can try to adapt the comment
> language a bit. But are you suggesting I shouldn't even try patch 2,
> which fixes the pm_runtime_put() return codes?

Not really.

> > Of course, there are existing users that check their return values,
> > but I'm not sure how much of a real advantage from doing that is.

Well, see above. :-)

>  At least some of those users appear to not exactly know what they are
> doing.

Almost none of them do nonsense.

