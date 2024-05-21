Return-Path: <linux-pm+bounces-8021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFBC8CAC39
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 12:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14661280A60
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6A605CE;
	Tue, 21 May 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHVqd2cD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7D6CDA9
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287386; cv=none; b=l3HJJeTUSv28LqLFkm/EDeUBGlF948Yn9t8/bgOQRmM4HSI76SOSz0p5k2KdXC7l2Zkza95gKNwv384xsNUzKKSORN5UKSFiSTa4ElhChKkW8S7lqoeVk9nLx22dW1HfEVsa47In/DAHvDcpKxDaexIx3AnpDBLZBYrX5DcXZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287386; c=relaxed/simple;
	bh=hhxSfEN3YZHsURt9abVwnipYtfjc7URPzVX6S12WmaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fefqiwiZkiVdnB5D7//2axsZutvrYJLOeHvABCXXV4MP+T6PMiR1Fb0C+qsKGSnZfIdIf6/KAAfByLj4gPfO7/rUoNLkVjiid+drBcv0TFMAsdt+ocqFO1SqBLW8kQGeMKRd0jKG88sv54326oGDtKkHRFaDYjHHDz7Q8P3id6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHVqd2cD; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de6074a464aso3277377276.0
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716287383; x=1716892183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hhxSfEN3YZHsURt9abVwnipYtfjc7URPzVX6S12WmaU=;
        b=oHVqd2cDJwclSmbMZTfGyhouMD1SOYRV2gGP9p5kGs4rrImma+UFt1IbFx9oEiNsLj
         CrhMj/1lC2t/McLja0lAop/KL8QgTtPhSu082FT9e7C5Q3pRzlag7qaJug0tWEEzUrOp
         nMiEIgC9seNopTp0Cu4ciPc1KSBJU/tM7KzPpVBw2Gyt2BD9MiBtoi60eD7mdjevIRDg
         DpSNsH5KZh17oXNfMH0QY3gQs5fgHpm8MESG4+f7hTSyg59oGoCiM2eCgraYNleRdSr7
         MVOnVZnwl1FSOqFlftQBYQbUDYtxc1iuSQUofuHpCGbGma6enUdlYWtBQ+dTPM3JI9bS
         Kmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716287383; x=1716892183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhxSfEN3YZHsURt9abVwnipYtfjc7URPzVX6S12WmaU=;
        b=jC4Pi4U8+lWfnB/P7x5bG/ys7wSh49T63Pb7RpY1+aJ/iJeoAFrqHbQ2+mpoLlJAb2
         kp0NuXuBwfeWE/GsOQ2tTbq9S6GnF6CYoLAwLwfq5XOe5aoG0j4x6eyf7/i2lk50BO+N
         RIr614CyWESsw3AsdjvFlXsiPzDhoFrZmuZfyf+ecrX7UwQ1zkK/bGM222mUN/jjmLfb
         9A+5ijAS3eSIgQ4PxQBdeMIMkmOvcK15N9sMIcZJVbYGkAJbb1A5AHRzRZmabV7mz41N
         0bcwzzzClY+DICp+GcrepyeUnMOMn5nMK3Bis7jAzrE2Oyyc1K8VkSyh8P9/FAwM6VJm
         VFWw==
X-Forwarded-Encrypted: i=1; AJvYcCV9h0FqpaZljf+AWU3bImQZJIjIYkGAE98Zbi8oXkY06LuQnBMw877oHp+D+muX0nAIoVxW58tQtjdcRD+nOcggUTb2+49L200=
X-Gm-Message-State: AOJu0Ywu7+4f0F3Rtjq1aVQnuZ85XBrQeyLduyCSSrR7z57OslGU11CB
	k1a+e7S2YHk3tO+8pliD47JEPDrrVpud1iu+/sj/DoM74ebvAh2Od6i4pXzSBAR3MOv35UQ/kQn
	xPkjgJxHTqTi0Sf2MadKZPXaYoKppufpM6Kev2w==
X-Google-Smtp-Source: AGHT+IHEkPcbU/mY9ABnsDa2hRbs7hlpxgMWmqACXFmTwhxL+abQNPRnrk+hHryTOxcjSofFyV3Lr3Hzwi2viXteRkA=
X-Received: by 2002:a05:6902:4:b0:de5:705d:9373 with SMTP id
 3f1490d57ef6-dee4f1b7848mr26999598276.12.1716287383352; Tue, 21 May 2024
 03:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-ti-sci-pd-v1-0-a0e56b8ad897@ideasonboard.com>
 <20240415-ti-sci-pd-v1-2-a0e56b8ad897@ideasonboard.com> <d4cd0323-4792-49b0-a4e2-0bc92068e7f0@ideasonboard.com>
 <CAPDyKFqShuq98qV5nSPzSqwLLUZ7LxLvp1eihGRBkU4qUKdWwQ@mail.gmail.com> <d7bf10d1-9294-44b0-b9f4-193d1a4f26a0@ideasonboard.com>
In-Reply-To: <d7bf10d1-9294-44b0-b9f4-193d1a4f26a0@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 May 2024 12:29:07 +0200
Message-ID: <CAPDyKFppS1CFZ7iDATfvT1=C+oqOR6sOGoV5Fc2PgXTn4NkUOQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] pmdomain: ti-sci: Support retaining PD boot time state
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, J Keerthy <j-keerthy@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Devarsh Thakkar <devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 12:19, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 03/05/2024 16:45, Ulf Hansson wrote:
> > + Abel, Saravanna, Stephen
> >
> > On Mon, 15 Apr 2024 at 19:17, Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> >>
> >> On 15/04/2024 19:00, Tomi Valkeinen wrote:
> >>> Add a new flag, TI_SCI_PD_KEEP_BOOT_STATE, which can be set in the dts
> >>> when referring to power domains. When this flag is set, the ti-sci
> >>> driver will check if the PD is currently enabled in the HW, and if so,
> >>> set the GENPD_FLAG_ALWAYS_ON flag so that the PD will stay enabled.
> >>>
> >>> The main issue I'm trying to solve here is this:
> >>>
> >>> If the Display Subsystem (DSS) has been enabled by the bootloader, the
> >>> related PD has also been enabled in the HW. When the tidss driver
> >>> probes, the driver framework will automatically enable the PD. While
> >>> executing the probe function it is very common for the probe to return
> >>> EPROBE_DEFER, and, in rarer cases, an actual error. When this happens
> >>> (probe() returns an error), the driver framework will automatically
> >>> disable the related PD.
> >>>
> >>> Powering off the PD while the DSS is enabled and displaying a picture
> >>> will cause the DSS HW to enter a bad state, from which (afaik) it can't
> >>> be woken up except with full power-cycle. Trying to access the DSS in
> >>> this state (e.g. when retrying the probe) will usually cause the board
> >>> to hang sooner or later.
> >>>
> >>> Even if we wouldn't have this board-hangs issue, it's nice to be able to
> >>> keep the DSS PD enabled: we want to keep the DSS enabled when the
> >>> bootloader has enabled the screen. If, instead, we disable the PD at the
> >>> first EPROBE_DEFER, the screen will (probably) go black.
> >>
> >> A few things occurred to me. The driver is supposed to clear the
> >> GENPD_FLAG_ALWAYS_ON when the driver has probed successfully. There are
> >> two possible issues with that:
> >>
> >> - Afaics, there's no API to do that, and currently I just clear the bit
> >> in genpd->flags. There's a clear race there, so some locking would be
> >> required.
> >>
> >> - This uses the GENPD_FLAG_ALWAYS_ON flag to say "PD is always on, until
> >> the driver has started". If the PD would have GENPD_FLAG_ALWAYS_ON set
> >> for other reasons, the driver would still go and clear the flag, which
> >> might break things.
> >>
> >> Also, unrelated to the above and not a problem in practice at the very
> >> moment, but I think clocks should also be dealt with somehow. Something,
> >> at early-ish boot stage, should mark the relevant clocks as in use, so
> >> that there's no chance they would be turned off when the main kernel has
> >> started (the main display driver is often a module).
> >>
> >> It would be nice to deal with all the above in a single place. I wonder
> >> if the tidss driver itself could somehow be split into two parts, an
> >> early part that would probe with minimal dependencies, mainly to reserve
> >> the core resources without doing any kind of DRM init. And a main part
> >> which would (somehow) finish the initialization at a later point, when
> >> we have the filesystem (for firmware) and the other bridge/panel drivers
> >> have probed.
> >>
> >> That can be somewhat achieved with simplefb or simpledrm, though, but we
> >> can't do any TI DSS specific things there, and it also creates a
> >> requirement to have either of those drivers built-in, and the related DT
> >> nodes to be added.
> >
> > Without going into too much detail, this and similar problems have
> > been discussed in the past. With the fw_devlink and the ->sync_state()
> > callback we are getting closer to a solution, but for genpd a solution
> > is still pending.
> >
> > If you want to read up on earlier discussions and join us moving
> > forward, that would be great. The last attempt for genpd to move this
> > forward was posted by Abel Vesa:
> > https://lore.kernel.org/linux-pm/20230621144019.3219858-1-abel.vesa@linaro.org/
> >
> > Beyond that, we have also discussed various solutions at the last LPC
> > in Richmond. I think the consensus at that point was that Saravana
> > targeted to post something for clocks - and when that was done, we
> > should do the similar thing for genpd. Anyway, I have looped them into
> > this thread, so they can share any updates on their side of the
> > matter.
>
> If I understand the series correctly, it has an issue at least for this
> case/platform.
>
> The devlinks are between the consumer devices and the PD provider
> device. TI SCI PD provider has quite a lot of PDs, and all the consumers
> would have to be probed before any of the PDs could be disabled. So, to
> get the display PD disabled, I would have to load, e.g., the GPU driver
> (which I don't even have).
>
> I believe this is the case for the clocks also.
>
> Perhaps that can be considered a feature, but I fear that in practice it
> would mean that most of the time for most users all the boot-time
> enabled powerdomains would be always on.
>
> Nevertheless, I believe the series would fix the issue mentioned in this
> patch, so I'll see if I can get the series working on the TI platform to
> get a bit more experience on this whole issue.

[...]

Just to share a brief update on this matter. I have had an offlist
chat with Saravana and some Qcom guys about this topic. In particular
we looked closer at some implementation details.

Allow me a few weeks, then I will post a series for genpd to implement
the above. I will keep you posted and would appreciate reviews and
tests, of course.

Kind regards
Uffe

