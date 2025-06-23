Return-Path: <linux-pm+bounces-29345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD358AE46BD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8865916B816
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA65255E23;
	Mon, 23 Jun 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3yVhW51"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C524C669
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688480; cv=none; b=MK8H9dWxzxKnTHkYwelq6I05gomjngps199qRkIJWOmgH0K+wcHC18x9ZsNsP8PlIWbfEd+0k21AjYxB8Gd51JAUxkgn3NWG2kb/DOtD8JjuFtYv/FXguIakUDVsnChjtpROSfw0EcDUghgv/KQ3+FCITXsSG9eF6oJeibeoa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688480; c=relaxed/simple;
	bh=cBaSltK+iBNsKR5acnBC7CYnfFMGQp9L6266nNzeioI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0LKilqnzTXynKOIK4Q5em7/FVeV0DNKr/VmY2EbPYbX+LGCa9W625dIvALmk0k513laubpjWzlMIIw5BCpGa0JW2zJKWm8gqMyjnsPh++HlZ0eCsU5dyaKtTsVbTlOhym7qgugIKhV7DePP7IkfAHacANRYytGqmy4D74ydIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l3yVhW51; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so771680276.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750688477; x=1751293277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U7Pf4Tw/xl4ZzOJcSTeUWy9hR8fh3hnPuV5B7YmZsKc=;
        b=l3yVhW51beyrEbOhlBHr8IptdHfupsG23Xefg7RgbHgVymyIxWAtKEK1XoXSjI75e0
         zXvD3ZQHVZ0PDQEUIx9gm0qQIjMF1Rr4Z29RaV2EDVJvEqj6nhxVN/bXBfMOyHniCph5
         oOVEABh1hp6Zmq48f51ZucZz/LHBtAKRf173vUShq+P2olN+U7cRXTm+nArJWJ+N5z5X
         sD7ML+gT4CFFl+1M1CtB76n8CjL4gCZwx+QwktIR++CbGYDlUbwNcZPZncyqb0kxuutT
         UVCQOITubNGtztWX11qoq9Z/QORz2Mh45mdugr+cCI5hf3iKENJjXsNCxR6CSuoL+XX6
         5tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688477; x=1751293277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7Pf4Tw/xl4ZzOJcSTeUWy9hR8fh3hnPuV5B7YmZsKc=;
        b=PpFYFj4ZPwbw31rhrHOPm+mRe1Z2bkKaL3ay57j1HB0i8u1MXCgizdFE+/3zr28bs6
         ybH1Y74JV84/I0SRr0V4+QEibrFpNfXVNivrNs8ZZEy8mVmc0uZ+tJOr9vyOlWZjBW18
         z8gzotuXV/3spOosd9/LX9m0r2OOYCfJOwAuqrNnyUeRmnhpE7iQ45BYYzQz+UXXv7pO
         Bghjy2PNM1WqqJTrl8H3JlTqWVmyr9t7cCA3citMDUXasxqLohWo3sn/CtZO58UUQwLX
         aCK1xcVOn2/wG1aVeM17a09a30Ku50/Cb6YBjRjA7UQRfwxgLwDXkxbgRKtxbirxh4Ps
         zvFw==
X-Forwarded-Encrypted: i=1; AJvYcCXsz0DCeyCWEKDs/IilFYktpLPJ5I8XZITsiEfkdalUgG0Fh57fuBG7OhwVK3xN2VruYC/hxdPApA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdS3qDJb7/4qPZxNBAmvNKx+XTN1vxchXDE1Rl0fH8g2C/Fes
	kAV6/aFYXgKJCkPxR9ymCgWvD6DsVYOdZM7ySo6G0/D66hbp74LOjDlSIrVVgT5adrq0Vpbig9S
	fyHirWvsR7TMpue8pyJvVzzzZCrJ8i24zN3IDcljPtA==
X-Gm-Gg: ASbGncvynnVJdj4q8HHbocXV2QZbGBhLAHLJ7JSB0XfdQYgn54HLftKxRecW7sMilRV
	vDBay0ZYwwUzNa1hLO0kYPpAJjhH7wIIsFhVPyMlS9tkrMOWheh/wyy3WejFhHd909pqL+ZwLNe
	Q1nHGaN7pAoFJecmjBmbJO6NSyu56C6n1IDPehlLTisPIb
X-Google-Smtp-Source: AGHT+IHOeZZKYswcD2+7mNFNITMikJvufzmGWdphs9OZVOVEegSi+TQx3Mqq1zDy67QaE2m9d/2OADaGrEZ0W8PZuM8=
X-Received: by 2002:a05:6902:70b:b0:e7f:263e:6c40 with SMTP id
 3f1490d57ef6-e842bc884dcmr16607791276.16.1750688477207; Mon, 23 Jun 2025
 07:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
 <fd4cfe7a-e29b-4237-b82f-48354deead3b@ideasonboard.com> <CAPDyKFpprO=HGuiHX3MQ_+m1YRnaWG=XwCx8-fSdXak8VBDUbQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpprO=HGuiHX3MQ_+m1YRnaWG=XwCx8-fSdXak8VBDUbQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Jun 2025 16:20:41 +0200
X-Gm-Features: AX0GCFtl7MtxcE4vyAd4TW4aP7KiFQbKSRPzfdkRqmmetdjmZM6hCv3ubI_yHWQ
Message-ID: <CAPDyKFpXcpwkacnYqWz2vxaTd7pW5bSRa2F063BryFxVNEAmPA@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] pmdomain: Add generic ->sync_state() support to genpd
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Jun 2025 at 13:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 13 Jun 2025 at 12:33, Tomi Valkeinen
> <tomi.valkeinen@ideasonboard.com> wrote:
> >
> > Hi Ulf,
> >
> > On 23/05/2025 16:39, Ulf Hansson wrote:
> > > Changes in v2:
> > >       - Well, quite a lot as I discovered various problems when doing
> > >       additional testing of corner-case. I suggest re-review from scratch,
> > >       even if I decided to keep some reviewed-by tags.
> > >       - Added patches to allow some drivers that needs to align or opt-out
> > >       from the new common behaviour in genpd.
> > >
> > > If a PM domain (genpd) is powered-on during boot, there is probably a good
> > > reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> > > powered-off before all of its consumer devices have been probed. This series
> > > intends to fix this problem.
> > >
> > > We have been discussing these issues at LKML and at various Linux-conferences
> > > in the past. I have therefore tried to include the people I can recall being
> > > involved, but I may have forgotten some (my apologies), feel free to loop them
> > > in.
> > >
> > > I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
> > > Let me know if you want me to share this code too.
> > >
> > > Please help review and test!
> >
> > I tested this Renesas white-hawk board, and it hangs at boot. With
> > earlycon, I captured with/without boot logs, attached.
> >
> > The hang case doesn't look very healthy with all these: "kobject:
> > '(null)' ((____ptrval____)): is not initialized, yet kobject_get() is
> > being called."
>
> Tomi, thanks a lot for helping out with testing!
>
> rcar_gen4_sysc_pd_init() calls pm_genpd_init() and
> of_genpd_add_provider_onecell().
>
> rcar_gen4_sysc_pd_init() is an early_initcall, which I guess is the
> reason for these problems, as the genpd_provider_bus has not been
> registered that early (it's done at core_initcall)
>
> Do you think it would be possible to move rcar_gen4_sysc_pd_init() to
> a postcore/arch_initcall?

I did some investigation around this and found that both
drivers/pmdomain/renesas/rcar-gen4-sysc.c and
drivers/pmdomain/renesas/rcar-sysc.c are registering their genpd
providers at the early_initcall() level.

I was trying to find (by browsing renesas DTSes and looking into
drivers) if there is any consumers that actually relies on this, but
so far the earliest consumer I have found is the
drivers/irqchip/irq-renesas-irqc.c, but that's at postcore_initcall().
Of course, it's difficult to say if my analysis is complete as there
are a lot of platform variants and I didn't check them all.

Maybe we should just give it a try and move both two drivers above to
postcore_initcall and see if it works (assuming the irq-renesas-irqc
supports -EPROBE_DEFER correctly too).

If this doesn't work, I think we need to find a way to allow deferring
the call to device_add() in of_genpd_provider_add*() for genpd
provider's devices.

Kind regards
Uffe

