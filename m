Return-Path: <linux-pm+bounces-35259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6CBB97A25
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 23:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B30D19C3257
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F58E30CDAA;
	Tue, 23 Sep 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SSO/EhRY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEDF2F1FDD
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664303; cv=none; b=p+pSdTCcuGD39UScAUC4/WAdFhpxpIulPCm+lcGQypmGah+W0tXyIvxuT6tFF0VEfeM5c+KBolxHwfV7jBrW93HyB5MjQ3uuVSUOH/dEyJWoYDAjLJubieqkL/vvxE1eZLl/cFNdQ5CEvI9c2Ncit7Jvf8yZHx+xpK/ije1Brhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664303; c=relaxed/simple;
	bh=TZ/4RZqmJx8nT5UAqseK8KWLNlnTGv2swniVLnuOw1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVhj0DFkIxkMaYQPr4Jgq2zHo6M8kngDrYSJFlxWzfK6hr4yRv6ei8prazIcEx4KSQC/g6eksH7Ysk8eRwI6KFHI9u44+gijZd2Tf+47kSsxQsLnJIjOCgMAe/rg/8gSe+C/N00VWM/D4LnqJNuXfPD7UfpJYOB6egPo2dLjWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SSO/EhRY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26c209802c0so44970695ad.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758664301; x=1759269101; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l3xBl6BdAh/kCCxZLUhoPYjdbnlgJBcOgSnus1I/AnU=;
        b=SSO/EhRYrj2EsfMOYdqj26cf08FbHnrQWCorioGPBzDDfhFTLU2MPFUUWpag8LiFOb
         lhdyX0B5GoQj/qjqXrdaKW/aSCD7JjfENYt42iazZPhByEMvKaIh7Phj/cUNt1idTLGt
         +XFzfEADNXHd56SWR2WnxYQfDNia2uhl3mmMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758664301; x=1759269101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3xBl6BdAh/kCCxZLUhoPYjdbnlgJBcOgSnus1I/AnU=;
        b=iOV2GnkzYFA+p/GFKgZPZ8jfd62a29xFzvjHokg3Kl3za7dmOQvx68W6MFMFXu3rLg
         gCDENKltBhM2UA7pakDxHx2SGfjrxZYs5fMA2ji+9jfw5OMO41+W/IcXH44yWVQfMrwy
         3dsGsWU5N1zwM/BB5IBUU9c0f1t8q2DNOiYAmNGIDGpVroPcw2/YUt2IeODE7pLRBB2g
         fitbhKWeQrqEfMLEOjQxQQPZTU3XyOmn5ls5jZs7QDrqeL1enzwHU0w/ssTaynUGtZ8U
         2SEoB8I1j3QyD2Vml8qkMyTENDzk7xKapS02Bo0RS4N9+iAhAmKZFEte+OdACvM/hbvJ
         E6sg==
X-Forwarded-Encrypted: i=1; AJvYcCU8zmnENV79glplFwtq5vS4eKApVEzA6OvBqcNFikYpuGahUl5+Ax7ltodM3bjg/7TvBxkiFVp57w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvCF7Z41lbp7v8778Po/owRMWccTWz6cmlj1sPm4LOUVvaN837
	5l37ecPtMd8mr9iTeXwEz3YN9UYhsbtvfTdsLJy6RrZVYH5pX/Np8I/pQWd8G+UyDQ==
X-Gm-Gg: ASbGnct0UAct32IwRx3/53XItaoto/Jz+/FU/BksirAw7AMdRZnL6DdjCW8GSKv/RHP
	O2xAC0GuuZJ0xZeco3kiiOAL3UDD3B/J33tz0htxOkKPRSTYHPmC4G1G9olm0P3ItcRIrWB8RjP
	f/U1ulPDnnLlBxqFgKtpFA3zkfrj5LamDunJfEtyG1An4wAjwXRVmxiqlvB7NEpGiPBnv+2ESqg
	FE5mUAir2XJ57yWlHgwc26gJdIjIsy5trqWCYRZKOoCHDvQ8wIszLMB1Pd3sdQKuFxH2xczjChF
	Smii6PR2JEKsTVG6qOx9WeuN098JWM6QFSGZ3kOAHRPh7B0aMEBgoSO3L0RBH4lkvNNo7HwO/OJ
	m4GFg9ZfltMjwxRwhqkM1oZxWXZp49dCSCXVPaIVX00ckVuzQ/JRIwO3FhS4IOI2iyo5B/Ko=
X-Google-Smtp-Source: AGHT+IHWViQLu1PbJGPzKYrSBRQBX86hUFB9kfkvbHhNkjyoiP0lWB6Ubwl2tc0o+ip+ejDbq5Ft1A==
X-Received: by 2002:a17:902:f685:b0:246:7a43:3f84 with SMTP id d9443c01a7336-27cc128c12amr52545175ad.5.1758664301584;
        Tue, 23 Sep 2025 14:51:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:26d9:5758:328a:50f8])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27d6cba0a18sm21282405ad.145.2025.09.23.14.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 14:51:40 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:51:39 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
Message-ID: <aNMWa0SD5l4Cb6G_@google.com>
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>
 <aMHjOJGaKi9cwbsn@google.com>
 <CAJZ5v0iELLPYBS6FKmX=DhoyQ2tDq9F9DAzuV0A8etv0dGeJvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iELLPYBS6FKmX=DhoyQ2tDq9F9DAzuV0A8etv0dGeJvQ@mail.gmail.com>

Hi Rafael,

On Fri, Sep 19, 2025 at 06:58:50PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 10, 2025 at 10:44 PM Brian Norris <briannorris@chromium.org> wrote:
> > On Fri, Sep 05, 2025 at 07:37:38PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Aug 29, 2025 at 2:33 AM Brian Norris <briannorris@chromium.org> wrote:
> > > > +       /* Flush, in case the above (non-sync) triggered any work. */
> > > > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
> > >
> > > Why do you run pm_runtime_barrier(dev) here?  It is guaranteed that no
> > > requests are pending at this point.
> >
...
> > So IMO, it's a reasonable thing to run in this test, although I probably
> > should drop the "Flush" comment.
> 
> Yeah, changing the comment would help.

Will do.

> > > > +
> > > > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > >
> > > This has already been tested above.
...
> > Anyway, like I said, it's probably some matter of opinion/style. I can
> > drop some of these checks if you still think they have no place here.
> 
> I would do just two of them, one at the beginning and one at the end.
> It should be an invariant for everything in between.

Ack.

> > > > +       /*
> > > > +        * We never actually left RPM_SUSPENDED, but rpm_idle() still treats
> > > > +        * this as -EAGAIN / "runtime PM status change ongoing".
> > >
> > > No, this means "Conditions are not suitable, but may change".
> >
> > I'm just quoting the API docs for put():
> >
> > """
> > * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> > """
> >
> > If that's the wrong language, then we should update the API doc. At any
> > rate, I'm not sure what's "unsuitable" about a suspended device when we
> > call put(). It's not unsuitable -- it's already in the target state!
> >
> > Notably, I'm also changing this behavior in patch 2, since I think it's
> > an API bug. And the comment then goes away.
> 
> Yeah, so I'd prefer to change this particular thing entirely,
> especially in the face of
> 
> https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/
> 
> which quite obviously doesn't take the return value of
> pm_runtime_put() and pm_runtime_put_sutosuspend() into account.
> 
> I would like these two functions to be void.

Sure, I think inspecting put() return codes is generally a bad idea.
'void' would be cool with me, although maybe a bit impractical now,
considering how many users look at the current return code. So at a
minimum, I'd separate "make 'em void" from my "document and test the
API" work.

Really, I'm mostly looking at this area because I have to support driver
developers trying to learn how to use the runtime PM API, and they
wonder about the return codes. So if they exist, I'd at least like them
to make sense.

Anyway, for the particulars of this test: I can try to adapt the comment
language a bit. But are you suggesting I shouldn't even try patch 2,
which fixes the pm_runtime_put() return codes?

> Of course, there are existing users that check their return values,
> but I'm not sure how much of a real advantage from doing that is.  At
> least some of those users appear to not exactly know what they are
> doing.
> 

...

> > > > +static void pm_runtime_error_test(struct kunit *test)
> > > > +{
...

> > > > +       /* Still suspended */
> > >
> > > Error is still pending.
> >
> > Your statement is true, but I'm not quite sure what you're suggesting.
> > Are you suggesting I should
> >
> >         KUNIT_EXPECT_EQ(test, -EIO, dev->power.runtime_error);
> >
> > ?
> >
> > Or are you suggesting I change the comment?
> 
> Change the comment.
> 
> > I'm thinking I'll do both.
> 
> That will work too.

Ack.

Brian

