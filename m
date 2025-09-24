Return-Path: <linux-pm+bounces-35290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A86B9B13F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208333B5D49
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB4314B68;
	Wed, 24 Sep 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChSbV6/L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AB313E37
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735283; cv=none; b=TdHwCpKPwXXM3AkYrFGJQ0e0pDB8hAcKtX94T72XYIqotMUWJCuPE3POsQMzodmGAxCD3AcuUHbamJnnN15H/cp6jf1B3jCLBsPHi+CzIKn3J6VikSoEhR2VEkVh4yGwSoqykvnAK9PIU4q/dVbP1zSc94q4+QZGRtFfg+nNy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735283; c=relaxed/simple;
	bh=tnoLIAqfEFthufY3Qr3rmHg7H4+5/ajzN8VYtHAy6CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTo9NwaDmKT27w3+/N/DXLwqMAaXFO6cNiss/iTUFa/D8pEZJp9PBr+0hp1z1bOHwD4nif2N9U71nLv5J7FnFsXAHgLDxQQwFORXeM6WbstKg4qIuAUpmNvKu81xI5Rv9kyI0tbdD9tMbNoTjjwxqUKybiErZXAPTkhIiNCTH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChSbV6/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447DAC4CEF4
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758735283;
	bh=tnoLIAqfEFthufY3Qr3rmHg7H4+5/ajzN8VYtHAy6CE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ChSbV6/LOPCEuWsGI2iZsSG6gr5UAHqkNRyt83KdR1jFuDR/cf1iXjwuu4RewVLb+
	 GoV+EgMbEMqfN2sVyBTOuX3b2s4Ff89CKZNyVeW5L6oytBq0OmqIqlT5XphQ8fyLwz
	 ZZvPq66DoskBgDUuk3hpoSbg3HIF9e9Ip2SsQ4zAKl6EaUaefslmQ5vOQFnmggBKmw
	 RIG818e989ds1Y+RXUGtKOqhQZeJGTPQKt/KF55adobvY6KCzcMS0JDjo/R4mhuJRM
	 o9RBOdlat2593Gyw8rPSbQjjQgqUge/PP+e4p0xQKE4SV10skoc1qhMhT2Uazwbq1P
	 qEKjqmvuiL7vQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74381df387fso33750a34.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 10:34:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXN7Y5nNh4UPmQm/EHiyg3Rv2fFRDGU1H+Ev6FzqieblDwgKxE9FwBrGH/QjqCm+wkK+yICGYfsaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDkfa8VzCPUXQQkvIHiP438CVF4azvAgHti/AWqr2o98swATm
	+DRY/95AxauELRfPzQKKER+t5xhB54v8lIkdRpDqZIf7kvsDcHLmqDRQADgqSkxu9jjLaqoZ5ax
	jmz/bE0w40FGkTLkzrtL2gfIlzi4YmS8=
X-Google-Smtp-Source: AGHT+IGa6IM8dPeQhPZq5m/tq1tKn+eE6aJrlMNwjE6EtPpONXcDmFw428+j3qQbp1yRbYiVfGFFhPbeJedxLVeebpE=
X-Received: by 2002:a05:6830:6af7:b0:73e:9b34:9a0f with SMTP id
 46e09a7af769-7a037fadb49mr367673a34.7.1758735282559; Wed, 24 Sep 2025
 10:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>
 <aMHjOJGaKi9cwbsn@google.com> <CAJZ5v0iELLPYBS6FKmX=DhoyQ2tDq9F9DAzuV0A8etv0dGeJvQ@mail.gmail.com>
 <aNMWa0SD5l4Cb6G_@google.com> <CAJZ5v0jnPsVrULF9+S-e+HvT+bik=+WA7FfXzFg5vfO8WhTy9Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jnPsVrULF9+S-e+HvT+bik=+WA7FfXzFg5vfO8WhTy9Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 19:34:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0_r_=rsPzLmST7cZtGjHCP73t9aoXdVFa81J9nJmzsQ@mail.gmail.com>
X-Gm-Features: AS18NWA0YgYU5kzVavVQAVrORFvwLpqoQvrOwslP6-MHI2Cz87LSTHyAvww8uPQ
Message-ID: <CAJZ5v0i0_r_=rsPzLmST7cZtGjHCP73t9aoXdVFa81J9nJmzsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
To: Brian Norris <briannorris@chromium.org>
Cc: Pavel Machek <pavel@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:32=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi Brian,
>
> On Tue, Sep 23, 2025 at 11:51=E2=80=AFPM Brian Norris <briannorris@chromi=
um.org> wrote:
> >
> > Hi Rafael,
> >
> > On Fri, Sep 19, 2025 at 06:58:50PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Sep 10, 2025 at 10:44=E2=80=AFPM Brian Norris <briannorris@ch=
romium.org> wrote:
> > > > On Fri, Sep 05, 2025 at 07:37:38PM +0200, Rafael J. Wysocki wrote:
> > > > > On Fri, Aug 29, 2025 at 2:33=E2=80=AFAM Brian Norris <briannorris=
@chromium.org> wrote:
> > > > > > +       /* Flush, in case the above (non-sync) triggered any wo=
rk. */
> > > > > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* n=
o wakeup needed */
> > > > >
> > > > > Why do you run pm_runtime_barrier(dev) here?  It is guaranteed th=
at no
> > > > > requests are pending at this point.
> > > >
> > ...
> > > > So IMO, it's a reasonable thing to run in this test, although I pro=
bably
> > > > should drop the "Flush" comment.
> > >
> > > Yeah, changing the comment would help.
> >
> > Will do.
> >
> > > > > > +
> > > > > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > > > >
> > > > > This has already been tested above.
> > ...
> > > > Anyway, like I said, it's probably some matter of opinion/style. I =
can
> > > > drop some of these checks if you still think they have no place her=
e.
> > >
> > > I would do just two of them, one at the beginning and one at the end.
> > > It should be an invariant for everything in between.
> >
> > Ack.
> >
> > > > > > +       /*
> > > > > > +        * We never actually left RPM_SUSPENDED, but rpm_idle()=
 still treats
> > > > > > +        * this as -EAGAIN / "runtime PM status change ongoing"=
.
> > > > >
> > > > > No, this means "Conditions are not suitable, but may change".
> > > >
> > > > I'm just quoting the API docs for put():
> > > >
> > > > """
> > > > * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status c=
hange ongoing.
> > > > """
> > > >
> > > > If that's the wrong language, then we should update the API doc. At=
 any
> > > > rate, I'm not sure what's "unsuitable" about a suspended device whe=
n we
> > > > call put(). It's not unsuitable -- it's already in the target state=
!
> > > >
> > > > Notably, I'm also changing this behavior in patch 2, since I think =
it's
> > > > an API bug. And the comment then goes away.
> > >
> > > Yeah, so I'd prefer to change this particular thing entirely,
> > > especially in the face of
> > >
> > > https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/
> > >
> > > which quite obviously doesn't take the return value of
> > > pm_runtime_put() and pm_runtime_put_sutosuspend() into account.
> > >
> > > I would like these two functions to be void.
> >
> > Sure, I think inspecting put() return codes is generally a bad idea.
> > 'void' would be cool with me, although maybe a bit impractical now,
> > considering how many users look at the current return code.
>
> For pm_runtime_put() it's not that bad.  I have ~20 patches changing
> all of the code looking at its return value to stop doing that.
>
> Interestingly enough, there's only one piece of that code (USB core)
> doing anything remotely useful with that return value.  Everything
> else is just garbage IMV.
>
> > So at a minimum, I'd separate "make 'em void" from my "document and tes=
t the
> > API" work.
>
> But you can just skip them.
>
> > Really, I'm mostly looking at this area because I have to support drive=
r
> > developers trying to learn how to use the runtime PM API, and they
> > wonder about the return codes. So if they exist, I'd at least like them
> > to make sense.
>
> Sure.
>
> That said, as far as pm_runtime_put() and pm_runtime_put_autosuspend()
> are concerned, you may as well just say "discard their return values,
> you don't want to have to deal with them, and never ever pass them
> verbatim to the callers of your code".
>
> > Anyway, for the particulars of this test: I can try to adapt the commen=
t
> > language a bit. But are you suggesting I shouldn't even try patch 2,
> > which fixes the pm_runtime_put() return codes?
>
> Not really.
>
> > > Of course, there are existing users that check their return values,
> > > but I'm not sure how much of a real advantage from doing that is.
>
> Well, see above. :-)
>
> >  At least some of those users appear to not exactly know what they are
> > doing.
>
> Almost none of them do nonsense.

s/none/all/ (sorry)

