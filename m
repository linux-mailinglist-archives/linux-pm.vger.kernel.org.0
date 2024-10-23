Return-Path: <linux-pm+bounces-16284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735059AC6EF
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24471C24221
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C4E19CC27;
	Wed, 23 Oct 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T78yyWDE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E4152517;
	Wed, 23 Oct 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677024; cv=none; b=TB8qNqb0WIEb0wvQGgjM0WDipD/stHIdOqwhJar8UGxna+YhnQTzAt9ZfS3MukmJD0uW1G5ubDy/Va4qTCLYSps17Y8Cr7lRBqQkMb1VEugwh8qr+l+s7h1ikYXixFhPsz9COhZ3XEiFXUHQKudFihHckuRCGqYby9HtG8DYWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677024; c=relaxed/simple;
	bh=86bNL0kwdLkucNoLyKL04fg25Q3kvxNWwqSppf0aCfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Es/k/bDG0lbk+B/Rvuzg7UhRWI0pBtK3hh7a+43LUlRRaocClFK4XiARjteX1Rtdrkdh1sUxw5ESjNkjU99ZZk1LrEMCbC7C07wbongehKjf2qx2843DO+ZF71soxdnQavw4HAUU/bfzWH7wzGy4mCumyhAGQrgOcmromkfpbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T78yyWDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A41C4CEEB;
	Wed, 23 Oct 2024 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729677023;
	bh=86bNL0kwdLkucNoLyKL04fg25Q3kvxNWwqSppf0aCfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T78yyWDEK7flazfqDgSrCPz8eACxMhdcG1oU7cJ/Aba7u1g09DBGJ2uM8qXhty1PE
	 VQ+tZkF+X/+wbm8Ak/hGue5icorn+dZJMrG4uhHE/2ZZR1+sJxpVCfTZ20UZXX2IOs
	 4V4K42RXNpCl99JhXQ5TQbMLbVPPd/H6N8UJhyZyJtzdLUCmTnYlLB5i1bXcaJX/r5
	 XO0kWURFZNbq1mq4F1lhm9CeRusWZkV+l/g8lUQw8w7qYvO2kFq81J6db/mp7crBfV
	 v6UxYsOWIiY13h6r0vQrUJwNVFt8gFTyxRhYZ4t+aVjvknsiMbpxtChCk9eUzPIms0
	 ACGeTc9+TdK+A==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2887326be3dso3074085fac.1;
        Wed, 23 Oct 2024 02:50:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrj9CCctzP71U8rDifLdWzt/RMZEybxhsfE9aWbAsgQDiNUp5axJrZz0wPM0FU5fDhrXs6uf88A6A=@vger.kernel.org, AJvYcCVta0CgZY1ZSID8vRDIt6QVhao/fRdHfT68poLaieXAt118F9YzsrK+x8WWx5DF/f6289JF7EOKHlisZOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK1pr8Lor4R9wcQWpoi5n5yfR+q9EPaO8Zvj4GR5+I+d8aBnzL
	d2N29qvZxQIcUFxdH/TCgDe+t77mQSvf7VDjP9/UzCV99kG6NeLiSZxTnWsyVkpea/R/8tIbSlU
	OTI1WxEhvc6AHmwg76Pv4cJ/CI3Y=
X-Google-Smtp-Source: AGHT+IHO6k4/ZN5wpABz3fUlREC3wQznWjXLd/VxSX3+3J1qO7cnwpFrOPCG6CNyeJwEUM1dkaG7ZyjO2U63AhHWTOo=
X-Received: by 2002:a05:6870:a106:b0:277:f5de:210f with SMTP id
 586e51a60fabf-28ccb486ee1mr2191917fac.19.1729677023233; Wed, 23 Oct 2024
 02:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4985597.31r3eYUQgx@rjwysocki.net> <1930069.tdWV9SEqCh@rjwysocki.net>
 <2fc850b3-93af-4d8e-8a64-1c95942e911b@arm.com>
In-Reply-To: <2fc850b3-93af-4d8e-8a64-1c95942e911b@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Oct 2024 11:50:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g7zKWT_DpQ5uO+AeDXEKmJrwVBqcN-4PAJNYBORX+rAQ@mail.gmail.com>
Message-ID: <CAJZ5v0g7zKWT_DpQ5uO+AeDXEKmJrwVBqcN-4PAJNYBORX+rAQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] thermal: core: Add and use thermal zone guard
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Oct 22, 2024 at 11:01=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Rafael,
>
> On 10/10/24 23:05, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add and use a guard for thermal zone locking.
> >
> > This allows quite a few error code paths to be simplified among
> > other things and brings in a noticeable code size reduction for
> > a good measure.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is a new iteration of
> >
> > https://lore.kernel.org/linux-pm/3241904.5fSG56mABF@rjwysocki.net/
> >
> > that has been combined with
> >
> > https://lore.kernel.org/linux-pm/4613601.LvFx2qVVIh@rjwysocki.net/
> >
> > and rebased on top of
> >
> > https://lore.kernel.org/linux-pm/12549318.O9o76ZdvQC@rjwysocki.net/
> >
> > and
> >
> > https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
> >
> > ---
> >   drivers/thermal/thermal_core.c    |   61 +++++++---------------------
> >   drivers/thermal/thermal_core.h    |    4 +
> >   drivers/thermal/thermal_debugfs.c |   25 +++++++----
> >   drivers/thermal/thermal_helpers.c |   17 ++-----
> >   drivers/thermal/thermal_hwmon.c   |    5 --
> >   drivers/thermal/thermal_netlink.c |   21 ++-------
> >   drivers/thermal/thermal_sysfs.c   |   81 ++++++++++++++++------------=
----------
> >   drivers/thermal/thermal_trip.c    |    8 ---
> >   8 files changed, 86 insertions(+), 136 deletions(-)
> >
>
>
> [snip]
>
> Surprise, how the code can look smaller using that
> style with 'guard'.

Yes, it gets more concise.

Not only that, though.  It is also less error-prone, because you won't
forget to unlock the lock in an error path and you won't use "lock"
instead of "unlock" by mistake etc.

Moreover, it kind of promotes dividing the code into smaller
self-contained pieces, which is a plus too IMV.

> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you!

