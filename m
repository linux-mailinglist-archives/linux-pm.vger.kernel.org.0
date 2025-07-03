Return-Path: <linux-pm+bounces-30042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F139AF760A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90DE4A5337
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA628B516;
	Thu,  3 Jul 2025 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3Lvqclk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4517332C;
	Thu,  3 Jul 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550376; cv=none; b=E0e6NhWKikD+5HWiriPlWoMBgIoAj98aB1IxgxPPlMoDd4MsbJPyb2A19otG1eIN5nGlzbnSmxWR6iinx3i34lLpJz69sl0DC0uQUwo+8khwskgroKAsuRv9CEUFRV53Z0Yt6taUA0jS03gh/DWuLmcKmd67MKWaofaY9k6axSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550376; c=relaxed/simple;
	bh=KfUSNGQ37UCIpa1WbY7nTzUA43ohR2bW2z8Jpfr5BKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNTtNxEv4FMm1IGuwUTSb6gh+zdVnljW61Z5vjTZ8ffeTtYHirAc4TEKGN/f6kCkZNXmJ5SH7absGm0ax4IuzSq9ZhHOYrHFC3k1SaRga+CQMZsQ8ihPcXV4u+HKo/uSVxSCdCjb7tKy2j4kowG5rR1CmXKbh8rlkivEpcR+9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3Lvqclk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB75C4CEED;
	Thu,  3 Jul 2025 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751550375;
	bh=KfUSNGQ37UCIpa1WbY7nTzUA43ohR2bW2z8Jpfr5BKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q3LvqclkARsqKciZGJOJT7P26FiQtVqc05WYWQZiBpUjn5a82y8E3aL0vg2u300l5
	 yt50ByR9EoUThOSkXQGpnbTHtPnoG4fuCpm1hup/KH/mEsqTn4K0/zsJdzn8UMd+J8
	 jk0wLOtHtulIXi4tZAwURuLchdpZPDCV+0wSHE9etKSWPwTfcerzTluGT+89/up91i
	 EID7d4jDubkd4OupVaEkp3ZG3DcFwppAINTX3dlLggrates+h3j52k6WbEfe/Q48E3
	 uS6xJeszHNBqYUW+yP8xcp/AENv1Ly8gQeh8vJedw7zQbDVgwwZCnXGjvfl7vPf8t7
	 GG3iPeG9yKOhA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-610d86b3da9so1968549eaf.0;
        Thu, 03 Jul 2025 06:46:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU58oS5/dqqyBHvVbjhpEIPfekVhVEiZISe7Yj7ggBHFZbRwG2MyDD3Uq2FJm7MSMRGelZDHEqTBT/ybo0=@vger.kernel.org, AJvYcCVJZmngv6R33AQHbonWZ8n8Cakit/wKANxGmzYmOsoHa84qrhE/EvcNBKG+8RE0VGNHYUHdE1UgPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30WZuwjINL+BYfILwLxQDTTz6MLIoGwG3joiDbpI4a+mzSoRH
	FKXbaQPYQdhE2drDfV58lvyyLG2A9xsGD6x/53AHqQGL2dT+IdDrNVTh1ihsofMciMA+NPSUPJ1
	iKyXxJZApSHqxC0OkaDu78hP71q7dnq4=
X-Google-Smtp-Source: AGHT+IFRGzpNAwgOZYcA9ML7MvvQBl1ZOes81gaH7XnaiyMopbp7+DoCLDWZ2ljxNjM14Z1CdAkyQT97LqNFXudCjGU=
X-Received: by 2002:a05:6820:2483:b0:613:87ee:10e with SMTP id
 006d021491bc7-61387ee02d3mr627853eaf.5.1751550375080; Thu, 03 Jul 2025
 06:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <rlzpjdsg6cbgxc553j6m25ysb6tyldy4lnxsjjn4hdzv7rszpp@y6rfcrbjfook>
 <fbfc6bf9-d7c6-4df5-85d0-b1d357159d88@suse.com> <CAJZ5v0hPh19h9uVRVHSXiLaHxm3PR9A3W5+j=2=-B-YCyBr=uw@mail.gmail.com>
 <hjkm55hus3ctueydf7ebfb25hbdw6w3spdzx7maauzlzmnakas@noqexx2pxxtj> <e635l6gfpg7amck2hnu4l47tnc54lr6e26v7y3ohaywil6pjwr@4trxzfdigo62>
In-Reply-To: <e635l6gfpg7amck2hnu4l47tnc54lr6e26v7y3ohaywil6pjwr@4trxzfdigo62>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 15:46:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsLCpGnA5fNSSVLOoPL6Qinw=o_fBGG-0iFKeWyQtFZQ@mail.gmail.com>
X-Gm-Features: Ac12FXyvXICzxs9Gum-bU5T0wa6naIqz0g09M3W8Ukt8GohaVls9utaM8cGw-Ws
Message-ID: <CAJZ5v0gsLCpGnA5fNSSVLOoPL6Qinw=o_fBGG-0iFKeWyQtFZQ@mail.gmail.com>
Subject: Re: Forcing devices into idle
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:32=E2=80=AFPM Thierry Reding <thierry.reding@gmail=
.com> wrote:
>
> On Thu, Jul 03, 2025 at 02:06:00PM +0200, Thierry Reding wrote:
> > On Thu, Jul 03, 2025 at 01:12:15PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Jul 3, 2025 at 12:33=E2=80=AFPM Oliver Neukum <oneukum@suse.c=
om> wrote:
> > > >
> > > > On 03.07.25 12:08, Thierry Reding wrote:
> > > >
> > > > > Any thoughts on how to solve this? Is the pm_runtime_{put,get}_sy=
nc()
> > > > > method acceptable? If not, are there other alternatives to achiev=
e the
> > > > > same thing that I'm not aware of? Would it be useful to add a new=
 set of
> > > > > APIs to force devices into an idle state (which could be semantic=
ally
> > > > > different from runtime suspend)? Or is this all too specific for =
any
> > > > > kind of generic API?
> > > >
> > > > Basically what you need is what happens when the system prepares to
> > > > do a snapshot for S4. However, if you just perform FREEZE and then =
THAW,
> > > > devices will assume that user space has been frozen. You need a way
> > > > to substitute for that assumption.
> > >
> > > Well, you just need to freeze user space beforehand.
> >
> > Freezing userspace seems a bit heavy-handed. There's only a very few
> > devices that need to be put into reset (such as the GPU), so most of
> > userspace should be fine to continue to run. For the GPU the idea is
> > to block all incoming requests while the device is forced into idle,
> > and then to resume processing these requests after the VPR resize.
> >
> > But maybe freezing userspace isn't the heavy operation that I think it
> > is. Ideally we do not want to suspend things for too long to avoid
> > stuttering on the userspace side.
> >
> > Also, I think we'd want the freezing to be triggered by the VPR driver
> > because userspace ideally doesn't know when the resizing happens. The
> > DMA BUF heap API that I'm trying to use is too simple for that, and
> > only the VPR driver knows when a resize needs to happen.
> >
> > Is it possible to trigger the freeze from a kernel driver? Or localize
> > the freezing of userspace to only the processes that are accessing a
> > given device?
> >
> > Other than that, freeze() and thaw() seem like the right callbacks for
> > this.
>
> I've prototyped this using the sledgehammer freeze_processes() and
> thaw_processes() functions and the entire process seems to be pretty
> quick. I can get through most of it in ~30 ms. This is on a mostly
> idle test system, so I expect this to go up significantly if there
> is a high load.
>
> On the other hand, this will drastically simplify the GPU driver
> implementation, because by the time ->freeze() is called, all userspace
> will be frozen, so there's no need to do any blocking on the kernel
> side.
>
> What I have now is roughly this:
>
>         freeze_processes();
>
>         for each VPR device dev:
>                 pm_generic_freeze(dev);
>
>         resize_vpr();
>
>         for each VPR device dev:
>                 pm_generic_thaw(dev);
>
>         thaw_processes()
>
> I still can't shake the feeling that this is sketchy, but it seems to
> work. Is there anything blatantly wrong about this?

There are a few things to take into consideration.

First, there are 4 tiers of "freeze" callbacks (->prepare, ->freeze,
->freeze_late, ->freeze_noirq), and analogously for "thaw" callbacks,
but you only use one of them.  This may be fine in a particular case,
but you need to ensure that the other tiers are not needed and, in
particular, the _noirq ones need not be involved.  Also ensure that
they don't assume that PM notifiers have run (or that they will run on
the resume side).

Second, if there are dependencies between the devices being frozen and
other devices, they will have to be taken into account.

Also note that kernel threads are generally not affected by
freeze_processes(), but I guess this is not a problem in your use
case.

Thanks!

