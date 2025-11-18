Return-Path: <linux-pm+bounces-38169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD2C69789
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D9ABD2ABF3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484E23C39A;
	Tue, 18 Nov 2025 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oyviti7s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2CB22D793
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470196; cv=none; b=NKNVdJEjZsClgW4oXKWHsgF402IoEn/f4zNSXhKjhNTT9IfmS8Ms9/NkmbSQ/J5mskyW7ZdwffWpgsoMg4tDOAiZ4WahsBkzqN9gNFkGUCV/Kh+PtNXj/GGkm14CVNjy5vJNcIa1e3grUuu94dR2z3sFReTj0SMge98fzgMskYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470196; c=relaxed/simple;
	bh=vYivSjB8GRTSYqaeVJnuHNwH12FJQr86bo8AOy2gR/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9GxGm8/wNFNuU+imxOcP6bG5gb5KF6D/DNaYbJA7vpfjyGPq5MeNWqAsW4znnb7fYTrdI69BWscXEI6tszzcPKiho2H2n8uXyQmCib/hFS9oWmA0WA+R7T6VvaZaQ951Do9XY4hajfwZMdKALfwyv4KhKkhU01lz9jCF8HOXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oyviti7s; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787ff3f462bso62755357b3.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763470193; x=1764074993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub6oQvlEtYLoJrlCD9mhTR7z/VHGGNL0VyAOPZ1FyWo=;
        b=Oyviti7skHfmubFv9eA9SRVpL42kfeZ5YqMjOLTM9fgO4+e9bPOaWXFEvM9UjAqCBO
         LMyhOkN4CF0n6Q4uDZiTkfsGsNl71y3R8zaaKmnY0uaksjAOXMRWUsSahmRktIa1kEAr
         MAuattq/g2QbFd/vWJNVR1TqWAzAE2F6ftDMCyaY7LPhcXxl2r3SpjPkDotoVoecd2+6
         2PtVt6WwikHf+efzPuS+ispCBqechmKTqoDiMKzdUqhXNGDSoZh1knjLRV4TbibbtMwR
         30Kr6vzFFt6oAmcOZmRYlTxbPB6JQxlOtYjrRz8lsd65z/EpO4O/l6lbo1BDVn54s2xC
         vX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763470193; x=1764074993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ub6oQvlEtYLoJrlCD9mhTR7z/VHGGNL0VyAOPZ1FyWo=;
        b=gjmAieNHAYqiTi0Erc6KAv1kQqmlNGvp5JanRXK8kMXRnSgyuRBPBfzJQ+vBHpYgiD
         HhxPeR8vw5d3fvOfpkyfak6L3ceO962i/QC1hRgkica+1C6RxTgMJ9oYyPySa24RFjfF
         /AP1uR8qdLN0uH+Pq+zuYl48ZmBIY6Dgu10yqsvX1errKdIujiaSQMwl0Q1iWHxwf0Ps
         igcBczIPhBOf9Lz8HNGcx3TYGzkji1aZE7/MSxNyjS0RyoezJ9ufWCUOiG47SyAxz2PT
         8f3uewYf0WaOpXTObMGXU8NPQZlKcSM3409VybUJWb1+c3xtozr4fHIn5pGC8TRNulo2
         dBsg==
X-Gm-Message-State: AOJu0YxsamPkhEllCt0/fcaoU639cYBqiHBE5oOIBYb0r8gsM1QBBB3/
	kwQm7yT3SkGSm4wk9jArfu97yRVFRfxmFsN3WiieuBnh+pDxryiNfnya7lew6rPVQdzSr8HA0AT
	7BFlmQitxN4dicrY2cINokZ7QufAxgGKiSVI9oX4llQ==
X-Gm-Gg: ASbGncuK7U4s4R+4rwXPO33uEMDsRdNxzyffu8OfF1d2kmPenBM6gFc5V/8naFqMtOu
	N/2WfCzjMtt4FR/+MO3OuVmkBGnfgMvZryee9SWkyf1Snss4SvLzj3iObnsEICjLRv7fbFsvCf5
	4gKjUOugoOvOHpv2gh+WmlxurncAkwoUCAjeTne3n6PNtc6aMgPVTsMuvLBqbFqllGwdk/RwH93
	dnuSR31XfEwHBdldRZy6Hti1BywvwgmL4k4jMerrjXFxiOe57jl48CEZqPLSvcs1VBIDZy9
X-Google-Smtp-Source: AGHT+IEUrIciaZ+/GqyeOIzYQaExU4Ajz+xsT/QRuNFCliHkKGZNgLtsOhcPlVhGFuTxkS2ukXW1MwbANuONCy2vZkQ=
X-Received: by 2002:a05:690e:118e:b0:63f:a876:ae58 with SMTP id
 956f58d0204a3-6421341777cmr2485852d50.9.1763470193290; Tue, 18 Nov 2025
 04:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <5940388.DvuYhMxLoT@rafael.j.wysocki> <119e2410ca32a0d55fa6febf93c7a3164b391db0.camel@mediatek.com>
 <12782716.O9o76ZdvQC@rafael.j.wysocki> <CAPDyKFqzt70rkHaRP62zErkMi2kFC1iY-NHPWjK0FWZSjZ00jA@mail.gmail.com>
 <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Nov 2025 13:49:16 +0100
X-Gm-Features: AWmQ_bkPv80vLiP8Ho8RcGqH0zNC_axJ4RjcJ2X8UAbi3PlPL_ozFcNziv15WCg
Message-ID: <CAPDyKFqBB7gDXSDV-GbMqWDBbT8RMVdc-9+iDOvEdpVV5TACyw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Rose Wu <ya-jou.wu@mediatek.com>, 
	rafael.j.wysocki@intel.com, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, wsd_upstream <wsd_upstream@mediatek.com>, 
	linux-mediatek@lists.infradead.org, "artis. chiu" <artis.chiu@mediatek.com>, 
	"Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2025 at 13:26, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 18, 2025 at 1:18=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Tue, 18 Nov 2025 at 12:48, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Tuesday, November 18, 2025 9:31:08 AM CET Rose Wu wrote:
> > > > Hi,
> > > >
> > > > On Mon, 2025-11-17 at 19:57 +0100, Rafael J. Wysocki wrote:
> > > > >
> > > > > Make two changes to address this problem.
> > > > >
> > > > > First, reorder device_suspend_late() to only disable runtime PM f=
or a
> > > > > device if the power.is_late_suspended flag is going to be set for=
 it.
> > > > > In all of the other cases, disabling runtime PM for the device is=
 not
> > > > > in fact necessary.
> > > > >
> > > > > Second, make device_resume_early() only enable runtime PM for the
> > > > > devices with the power.is_late_suspended flag set.
> > > > >
> > > >
> > > > My concern is with the error path in device_suspend_late().
> > > > If a device fails its dpm_run_callback(), it appears that its
> > > > power.is_late_suspended flag is not set, potentially leaving its ru=
ntime
> > > > PM disabled during the resume sequence.
> > >
> > > Right, pm_runtime_enable() is missing in the error path after calling
> > > dpm_run_callback().
> > >
> > > ---
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Runtime PM should only be enabled in device_resume_early() if it has
> > > been disabled for the given device by device_suspend_late().  Otherwi=
se,
> > > it may cause runtime PM callbacks to run prematurely in some cases
> > > which leads to further functional issues.
> > >
> > > Make two changes to address this problem.
> > >
> > > First, reorder device_suspend_late() to only disable runtime PM for a
> > > device when it is going to look for the device's callback.  In all of
> > > the other cases, disabling runtime PM for the device is not in fact
> > > necessary.  However, if the device's callback returns an error and th=
e
> > > power.is_late_suspended flag is not going to be set, enable runtime
> > > PM so it only remains disabled when power.is_late_suspended is set.
> > >
> > > Second, make device_resume_early() only enable runtime PM for the
> > > devices with the power.is_late_suspended flag set.
> > >
> > > Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchr=
onous")
> > > Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
> > > Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a7d=
ee7edaaffc33.camel@mediatek.com/
> > > Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1 -> v2: Add pm_runtime_enable() to device_suspend_late() error path=
 (Rose).
> > >
> > > ---
> > >  drivers/base/power/main.c |   15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > >
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -941,11 +941,11 @@ Run:
> > >
> > >  Skip:
> > >         dev->power.is_late_suspended =3D false;
> > > +       pm_runtime_enable(dev);
> > >
> > >  Out:
> > >         TRACE_RESUME(error);
> > >
> > > -       pm_runtime_enable(dev);
> > >         complete_all(&dev->power.completion);
> > >
> > >         if (error) {
> > > @@ -1630,12 +1630,6 @@ static void device_suspend_late(struct d
> > >         TRACE_DEVICE(dev);
> > >         TRACE_SUSPEND(0);
> > >
> > > -       /*
> > > -        * Disable runtime PM for the device without checking if ther=
e is a
> > > -        * pending resume request for it.
> > > -        */
> > > -       __pm_runtime_disable(dev, false);
> > > -
> > >         dpm_wait_for_subordinate(dev, async);
> > >
> > >         if (READ_ONCE(async_error))
> > > @@ -1649,6 +1643,12 @@ static void device_suspend_late(struct d
> > >         if (dev->power.syscore || dev->power.direct_complete)
> > >                 goto Complete;
> > >
> > > +       /*
> > > +        * Disable runtime PM for the device without checking if ther=
e is a
> > > +        * pending resume request for it.
> > > +        */
> > > +       __pm_runtime_disable(dev, false);
> > > +
> >
> > Moving this here means we are going to keep runtime pm enabled for
> > syscore devices during system wide suspend/resume. That's quite a
> > change in behaviour for a fix for a regression, I think. Not saying
> > that it can't work though.
>
> syscore devices can be a special case, but I thought it wouldn't be
> necessary to special-case them.
>
> Do you actually know about any of them needing special casing?

There are a couple of clocksource drivers, cpuidle-psci,
cpuidle-riscv-sbi and a usb driver that marks their devices as syscore
devices.

It *probably* works to keep runtime pm enabled for all of them, but I
am not sure.

>
> > Although, perhaps better to call __pm_runtime_disable() a few lines
> > earlier and use a separate flag to track that we need to call
> > pm_runtime_enable() in device_resume_early()?
>
> I don't think it is necessary or even useful to introduce new flags for t=
his.

Kind regards
Uffe

