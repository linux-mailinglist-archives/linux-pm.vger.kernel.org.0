Return-Path: <linux-pm+bounces-36993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C76AC16DE1
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 22:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872031B27F64
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 21:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153162D7D42;
	Tue, 28 Oct 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVxr2Lo9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F61221721
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685608; cv=none; b=XnIpHROwqM29zB5okwHC/bq9Rny7WY+2eGevkzLvmHudU5ps5q+fpXjA0IrFQryAuDz/hPP5ff43FMeBhlSXilNN08qJaaxb9cN5KQjTXDw0TI7g1x01X+nsw7IYhJYzwG5QC/qw9iA82uy7JP0+Ajr4US14h/Y6k1ctl4rB0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685608; c=relaxed/simple;
	bh=7ac7NSSDc2JHZkTul8LlHNXHMeFeOILZgLCx2uL8PNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVuUooF0kfzqyxhGwGUVA0K3mnWGQ79+HX6aX3B46DxpQIszG7iUC01A8piODRTB0mt03bZN7jKnTuEFhRYJWUN5RsAexzntutoiSKqqWyV9qcQglsbDzwdGNUzc51tuyxrBGQLa9H/UDO1uGiPzD7RZxCTaiUiBKw+iXQvWD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVxr2Lo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62364C4CEFF
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 21:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761685607;
	bh=7ac7NSSDc2JHZkTul8LlHNXHMeFeOILZgLCx2uL8PNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QVxr2Lo9sszi9p201ElKJUhvbXvE3+6G4kjupd4J8LPBbQjdBcW5gXGK/FoTtkDmk
	 Wb6seCoYJLOrrMVXZA1/3rifhlQrd+Aj33eXJs0R52zYzIe9d8pK3Pzw52qTMHrhah
	 YfIH5l1phtyQOdWyFwQxdG0Rx1lZyP336h/B+s3fRfMCEnrRPL1Vb4AzPR2UMrKcWK
	 Qo+iqRyOuKIWiMfjOM5WvqQxTxrJZaKEYByFfonsUzHP+0Ol9kxUnC3gF7yxfvefMi
	 q5t5N1P5L2SfkBRTN4TvlcFflyo1LrFks37vXYDgpTjCs4NQxYzskTMoNnN65wH9Ir
	 M8uMe/Zbmd0HQ==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-44daa894741so897206b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 14:06:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQf9y2P0AINiwuXEgYTILVVcA2l7STtV0j9RVAb8jekdk1jWBz6dqWLq1H1K2i1HJRqVmWW4s1mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvwikMjhHbzNr3GnyU1PQCtsJ9014xB6Miwu+vTSBNBjc3Gcv
	pdiRcZvcR1Ur0dKGNtmIv0I4k2YwDugd4TFKmUx8LYhhM5mTHTF/udeQAEsuVx0i9PuSov6XgqF
	El170nwJyHz1VspKUjBRctQBv2r9f+Ic=
X-Google-Smtp-Source: AGHT+IF0wAxeWz+XdHgo3iSZLf+IZKvJm22SyuFfu0RnisM2jZ2OeS1uVEL/+n9dJu5pBEIAxZXHk7cWPVDXQpQvJdo=
X-Received: by 2002:a05:6808:1b0a:b0:43f:1e42:9e89 with SMTP id
 5614622812f47-44f7a5526dcmr483041b6e.45.1761685606728; Tue, 28 Oct 2025
 14:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026033115.436448-1-superm1@kernel.org> <20251028111730.2261404-1-safinaskar@gmail.com>
 <CAJZ5v0iziWj0dWWFMz-otXAt2c1PBp6RwQKVjt_hwbrU4B_fVg@mail.gmail.com>
 <CAPnZJGCOR_zCOvLPdyYARQrZdafvBGwkXaDO-MGA6axw4etEsA@mail.gmail.com> <CAJZ5v0jT222NbgqUp4VNfTA3sUNuG1dEoBBCCtFg78ZQQwm0dA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jT222NbgqUp4VNfTA3sUNuG1dEoBBCCtFg78ZQQwm0dA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Oct 2025 22:06:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gwXXpMukMxyXKHwbUkN9S90uskUi7-4Ogu2GagiqJckg@mail.gmail.com>
X-Gm-Features: AWmQ_bl0bnXn24OJXlMR39GZ0Xk2Mm83WO8bw1bJv-cs52m0laGA6Hg4wBb_QOY
Message-ID: <CAJZ5v0gwXXpMukMxyXKHwbUkN9S90uskUi7-4Ogu2GagiqJckg@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Restore GFP mask in power_down() for HIBERNATION_PLATFORM
To: Askar Safin <safinaskar@gmail.com>
Cc: superm1@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org, 
	mario.limonciello@amd.com, pavel@kernel.org, rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:12=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Oct 28, 2025 at 1:56=E2=80=AFPM Askar Safin <safinaskar@gmail.com=
> wrote:
> >
> > On Tue, Oct 28, 2025 at 2:49=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > > What kind of damage are you talking about, specifically?
> >
> > Again: "pm_restore_gfp_mask" will restore "gfp_allowed_mask" to its
> > normal value,
> > which will contain __GFP_IO and __GFP_FS. Thus "pm_suspended_storage" w=
ill
> > start to return false.
> >
> > But "pm_suspended_storage" is called here:
> > https://elixir.bootlin.com/linux/v6.18-rc3/source/mm/swapfile.c#L1895
> >
> > (Also, please, read that big comment at this link.
> > Well, I have to admit I don't understand it in full.)
> >
> > This check is needed to prevent swapping out pages during hibernation.
>
> It is actually more complicated, but fair enough.
>
> Basically, the concern is that a swap page can be freed and then
> re-used for storing another page of memory after the image has been
> created, so the swap metadata in the image would not match the reality
> any more.
>
> > Call chain is so:
> > swap_writeout -> folio_free_swap -> folio_swapcache_freeable ->
> > pm_suspended_storage
> >
> > So by calling "pm_restore_gfp_mask" we allow pages to be swapped out.
> >
> > But we already wrote hibernation image by that point!
> >
> > So swapping pages will make our swap partition inconsistent.
> >
> > Moreover, as well as I understand, whole reason why we deal with GFP ma=
sk
> > in hibernation code is to prevent swapping out pages.
>
> No, it is not the whole reason.  It is also done to avoid accessing
> swap devices while they may not be (fully) operational.
>
> > We restrict GFP before creating hibernation image here:
> > https://elixir.bootlin.com/linux/v6.18-rc3/source/kernel/power/hibernat=
e.c#L463
> > .
> >
> > We do this (as well as I understand) to prevent pages from swapping out=
.
> >
> > And, starting from that moment, as well as I understand, we should
> > not restore GFP mask until either:
> > - we resume
> > - hibernation will abort for some reason (for example, "wake up event
> > detected during hibernation")
>
> Again, this is slightly more complicated because the GFP mask is going
> to be restricted again shortly after being restored temporarily by the
> $subject patch and if no memory allocations happen in the meantime,
> nothing bad will happen.  Also, if those memory allocations don't
> trigger swapping, nothing bad will happen either.  Now, it is quite
> unlikely that anyone will attempt to allocate a lot of memory during
> the "prepare" phase of a suspend or power-off transition, so all of
> this is not super-worrisome, but I agree that avoiding all of this GFP
> mask restrict/restore dance would be better overall.
>
> I'm going to remove the  pm_restrict_gfp_mask() and
> pm_restore_gfp_mask() calls from dpm_suspend_start() and
> dpm_suspend_end(), respectively, but that's not a change for 6.18.

And I've decided to do something else:

https://lore.kernel.org/linux-pm/5935682.DvuYhMxLoT@rafael.j.wysocki/

because having those calls in dpm_suspend_start() and
dpm_suspend_end(), respectively, makes sense in general as the GFP
mask needs to be restricted after the "prepare" phase of suspend.

