Return-Path: <linux-pm+bounces-40050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 861DACEA25E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 17:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 706B33021E75
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402C31815D;
	Tue, 30 Dec 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSRIXQP8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB92DFA46
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111479; cv=none; b=ieOO7wKtYknwuoq7hSbKE8HARHQedyznrS831SCJhMuSR7Vnve0dLgjV6VocGlbAMptOn0KuMPC5FsBrCUgx4TGJbpUS9qkS2yPa0YVBmm8UmYimWYHXwPirtwXU2ZsWOPRBR2a7Hpm15bQQQL9P4OYiDNisrLo72WVqT37CVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111479; c=relaxed/simple;
	bh=VEY4Cb5jc6lnJsaQHLgbiRjhF3KHmAUR5XwBio5g9jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjIFiE3hak+JOwAXBOb17cVJXR5/v32gVd4R8zvdCrM0FSS+/AX7EOFqv0wrl9QvIObrK3e/sYRQpJqrxjmDNehBiSpsc+s7Hu1+DPtSasZYAsBGEflcW/CccTElehCeKh5aspYMCtJB0QSGhDqiocueXopPbl5rdL0xEId1Ok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSRIXQP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B558C4CEFB
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111479;
	bh=VEY4Cb5jc6lnJsaQHLgbiRjhF3KHmAUR5XwBio5g9jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TSRIXQP88/SwcyieF2OFf3akY7ze9/s843ItQyYPFVueX/KlH3Q+Qsp/H1b/ZI1b7
	 DnAZd/jDIPFdoSjMp/5YQ/C/9Zhh7zCakHU3yyS9gF3gqh6YIOUugPYSHzeCaNMtua
	 BYLjhHoRr+o1+KYdyGs9hAz0OcfpktcA8AyIZNSagQ88h9rvnsWfTwjOUc1k9yEg6r
	 z2l5Pj0mAWF36HuYGzC/2C2Re6byFSKsIePAyLTo7BPtJqArF0ryYCb7a3DZlJ1GDA
	 u1aUr8PpJ5ZTFJHZNDqDCUpxeQ7EpbpATb29Ewb3W01GjxRjpJd5M1OsB+9kugsFwC
	 QHx8uSJ56teXw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65cf597a717so3701985eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 08:17:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeAnIb1kygx9+v8WcObS85O61nYtrHx6fuk85dX0h+orF1qZ93UcUiB2SdbjaPHiCuoPn1e3do3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4pfXcKBJSwwD6lTf6Q02epdBpi7f4Jx+BLR4VeACvWQrS/D8
	GrcziDIW6+Jbs1k7rzzSLBQeeiZRTmOdVt7/caoABI/wmmzPYgVJfyb72g3K/l+jZDowULgtcBn
	FpbGHfx/XVyxg5IkM+owtUDSMRwiwFbg=
X-Google-Smtp-Source: AGHT+IGqDWcQ17YvGmngpzLFMCVN7IFD3mBl45UeHMfJhujCrVsAMj1aofBPXJY0M8PXWnf/GD3wVU2PvQyIXeDk1WI=
X-Received: by 2002:a05:6820:611:b0:659:9a49:8fd6 with SMTP id
 006d021491bc7-65d0ec2650cmr15565301eaf.79.1767111478359; Tue, 30 Dec 2025
 08:17:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <2556645.jE0xQCEvom@rafael.j.wysocki>
 <CAMuHMdVMFQebA43FJ53PBnd67C8fxWAC21cr4jWTGDwg-HV53w@mail.gmail.com> <CAMuHMdWshJOjzD5DGzyRUG66jvPC6PPVBgaT=UdWy+XOk_T5Pw@mail.gmail.com>
In-Reply-To: <CAMuHMdWshJOjzD5DGzyRUG66jvPC6PPVBgaT=UdWy+XOk_T5Pw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Dec 2025 17:17:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jtck8SYvXE2Env36MkK8zvK==U_7CANNrQWxFuQf2rWg@mail.gmail.com>
X-Gm-Features: AQt7F2ocK3gV_BF4thHLc9hfJbDk4QtxfyJrWP4X7jV60IIvVc6wuKzFseGDX3E
Message-ID: <CAJZ5v0jtck8SYvXE2Env36MkK8zvK==U_7CANNrQWxFuQf2rWg@mail.gmail.com>
Subject: Re: [PATCH v1 15/23] phy: core: Discard pm_runtime_put() return values
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Brian Norris <briannorris@chromium.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-phy@lists.infradead.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 11:54=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Tue, 30 Dec 2025 at 11:34, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> > On Mon, 22 Dec 2025 at 21:40, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The PHY core defines phy_pm_runtime_put() to return an int, but that
> > > return value is never used.  It also passes the return value of
> > > pm_runtime_put() to the caller which is not very useful.
> > >
> > > Returning an error code from pm_runtime_put() merely means that it ha=
s
> > > not queued up a work item to check whether or not the device can be
> > > suspended and there are many perfectly valid situations in which that
> > > can happen, like after writing "on" to the devices' runtime PM "contr=
ol"
> > > attribute in sysfs for one example.
> > >
> > > Modify phy_pm_runtime_put() to discard the pm_runtime_put() return
> > > value and change its return type to void.  Also drop the redundant
> > > pm_runtime_enabled() call from there.
> > >
> > > No intentional functional impact.
> > >
> > > This will facilitate a planned change of the pm_runtime_put() return
> > > type to void in the future.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Thanks for your patch, which is now commit caad07ae07e3fb17 ("phy:
> > core: Discard pm_runtime_put() return values") in phy/next.
> >
> > This is causing several messages like
> >
> >     phy phy-e6590100.usb-phy-controller.2: Runtime PM usage count under=
flow!
> >
> > during boot, and s2ram on Koelsch (R-Car M2-W).
>
> On R-Car Gen3, there are no such messages, as e.g.
> drivers/phy/renesas/phy-rcar-gen3-usb2.c does support Runtime PM.
> R-Car Gen2 uses drivers/phy/renesas/phy-rcar-gen2.c, which does not
> use Runtime PM yet, but still relies on explicit clock management.
>
> > > --- a/drivers/phy/phy-core.c
> > > +++ b/drivers/phy/phy-core.c
> > > @@ -190,15 +190,12 @@ int phy_pm_runtime_get_sync(struct phy *
> > >  }
> > >  EXPORT_SYMBOL_GPL(phy_pm_runtime_get_sync);
> > >
> > > -int phy_pm_runtime_put(struct phy *phy)
> > > +void phy_pm_runtime_put(struct phy *phy)
> > >  {
> > >         if (!phy)
> > > -               return 0;
> > > +               return;
> > >
> > > -       if (!pm_runtime_enabled(&phy->dev))
> > > -               return -ENOTSUPP;
> >
> > Adding some instrumentation shows that this branch was taken before,
> > thus skipping the call to pm_runtime_put().
> >
> > Can I just put the check back, or is there an underlying problem that
> > should be fixed instead?

Sorry for breaking this!

> I assume the PHY core should support both drivers that do and do not
> support Runtime PM.

Yes, it should be sufficient to restore the pm_runtime_enabled() check.

