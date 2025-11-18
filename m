Return-Path: <linux-pm+bounces-38166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CABC695DF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A9350B8F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D0354AF5;
	Tue, 18 Nov 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7AuCQBQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55C3546F9
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468783; cv=none; b=If6i3KnIvUD3rNOrnJtP0s1SYFmw4Zv9JhSnBgEGNmb3I5SnWTOlox8iKrh4/cOBvxTlYMy+m8QzV1SuBycsFpD572lt/F/3P9nrB18wFnrda+lGTG7NFNac4XQSiqDoL5Pdz5SgXw+1PenHbtboelRqvFTFepEPdLUgon4cJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468783; c=relaxed/simple;
	bh=OQW9B/dyCzcM/bIWdIMNnuLsQU3gBUjkA6PMYVbTh7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAfKJbXvl//myo02ycmGrqVbMYGjSURfLxh8HUJvGBX7Kcvv/27AI7JiUwon0VOnCswolPVOgH6Jkzp+U99LL07b6rWa/ibqhYaVY3bqokKiVyvPFnpVDOlkf5Jr3B7IdDmuaT3O7DiDMUBGMU4CdaPv+iI33evRFI2oC8NvNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7AuCQBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3036BC4AF12
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763468782;
	bh=OQW9B/dyCzcM/bIWdIMNnuLsQU3gBUjkA6PMYVbTh7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T7AuCQBQzJ3MpT1vVfpibJcfTYM68Sz/tTRa0qCK7WIBGjGNlNsJ9klGL247/4VBB
	 sY4i7ZZmOUBDyKdnzrOy/XlEiqZzW5ZutJE0P7jp1ziwc2BXcnjwIi/2sOB7n5ElKp
	 nMlgnabqRh34Ie9jQ3Fl3GMFUATyLt9MMddd1RiySATC9Ngo6U3H5na91XIBzNc4Ki
	 /y9l28rqV2/fMe0rWr/Z1XwrzqY6NXYOw1/mdx3bXc+n+6vkvhdknIxuKhsMHyqs0+
	 hxFToA2HafwJ8NGr6rqiRXwnmyg3gD9QD3hZHf1ArZ8fJ/SDBvQjfMKasb6C+V2r/j
	 hr0/2xHde2oGg==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c76f65feb5so1041857a34.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 04:26:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9kRTG3VYk5bx4QnWjahj/huExiDtGuprHPwJ28M56ZfA4LG4m1oHSum4hCq8OHoAW3pAOx37Usg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpW9LQDs6/6HIzTizIya4ElUtJlJlu6isdxYN4t/vfp5VQ0L3J
	SSzcWXBSjmwXuoaQEZiUGxjWvqCXJb5Owx+IpV1o0bsMlHzVozPXO2kVGl2z/f74KDW82Fd09NR
	2DlCTMPHH2ahcgIemXjuQf7zRIleWIPs=
X-Google-Smtp-Source: AGHT+IELTs+baIL1OrUJ6lfYKQJrx3au7tikjQ/WjvAvnLWN8GeNFk7gmzuFm25SBqt1p1LkQmGpQPESh5sh/Go6alg=
X-Received: by 2002:a05:6808:67c3:b0:43f:ee6f:3bf2 with SMTP id
 5614622812f47-450974289b6mr7187219b6e.17.1763468779141; Tue, 18 Nov 2025
 04:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <5940388.DvuYhMxLoT@rafael.j.wysocki> <119e2410ca32a0d55fa6febf93c7a3164b391db0.camel@mediatek.com>
 <12782716.O9o76ZdvQC@rafael.j.wysocki> <CAPDyKFqzt70rkHaRP62zErkMi2kFC1iY-NHPWjK0FWZSjZ00jA@mail.gmail.com>
In-Reply-To: <CAPDyKFqzt70rkHaRP62zErkMi2kFC1iY-NHPWjK0FWZSjZ00jA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Nov 2025 13:26:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com>
X-Gm-Features: AWmQ_bnH3KX730tRoTnlZ4-5nfP9SwaRCiL1Njlm18RCobVNepyDg9y7Z_8Zzf8
Message-ID: <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Rose Wu <ya-jou.wu@mediatek.com>, rafael.j.wysocki@intel.com, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	wsd_upstream <wsd_upstream@mediatek.com>, linux-mediatek@lists.infradead.org, 
	"artis. chiu" <artis.chiu@mediatek.com>, "Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:18=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Tue, 18 Nov 2025 at 12:48, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Tuesday, November 18, 2025 9:31:08 AM CET Rose Wu wrote:
> > > Hi,
> > >
> > > On Mon, 2025-11-17 at 19:57 +0100, Rafael J. Wysocki wrote:
> > > >
> > > > Make two changes to address this problem.
> > > >
> > > > First, reorder device_suspend_late() to only disable runtime PM for=
 a
> > > > device if the power.is_late_suspended flag is going to be set for i=
t.
> > > > In all of the other cases, disabling runtime PM for the device is n=
ot
> > > > in fact necessary.
> > > >
> > > > Second, make device_resume_early() only enable runtime PM for the
> > > > devices with the power.is_late_suspended flag set.
> > > >
> > >
> > > My concern is with the error path in device_suspend_late().
> > > If a device fails its dpm_run_callback(), it appears that its
> > > power.is_late_suspended flag is not set, potentially leaving its runt=
ime
> > > PM disabled during the resume sequence.
> >
> > Right, pm_runtime_enable() is missing in the error path after calling
> > dpm_run_callback().
> >
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Runtime PM should only be enabled in device_resume_early() if it has
> > been disabled for the given device by device_suspend_late().  Otherwise=
,
> > it may cause runtime PM callbacks to run prematurely in some cases
> > which leads to further functional issues.
> >
> > Make two changes to address this problem.
> >
> > First, reorder device_suspend_late() to only disable runtime PM for a
> > device when it is going to look for the device's callback.  In all of
> > the other cases, disabling runtime PM for the device is not in fact
> > necessary.  However, if the device's callback returns an error and the
> > power.is_late_suspended flag is not going to be set, enable runtime
> > PM so it only remains disabled when power.is_late_suspended is set.
> >
> > Second, make device_resume_early() only enable runtime PM for the
> > devices with the power.is_late_suspended flag set.
> >
> > Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchron=
ous")
> > Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
> > Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a7dee=
7edaaffc33.camel@mediatek.com/
> > Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Add pm_runtime_enable() to device_suspend_late() error path (=
Rose).
> >
> > ---
> >  drivers/base/power/main.c |   15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -941,11 +941,11 @@ Run:
> >
> >  Skip:
> >         dev->power.is_late_suspended =3D false;
> > +       pm_runtime_enable(dev);
> >
> >  Out:
> >         TRACE_RESUME(error);
> >
> > -       pm_runtime_enable(dev);
> >         complete_all(&dev->power.completion);
> >
> >         if (error) {
> > @@ -1630,12 +1630,6 @@ static void device_suspend_late(struct d
> >         TRACE_DEVICE(dev);
> >         TRACE_SUSPEND(0);
> >
> > -       /*
> > -        * Disable runtime PM for the device without checking if there =
is a
> > -        * pending resume request for it.
> > -        */
> > -       __pm_runtime_disable(dev, false);
> > -
> >         dpm_wait_for_subordinate(dev, async);
> >
> >         if (READ_ONCE(async_error))
> > @@ -1649,6 +1643,12 @@ static void device_suspend_late(struct d
> >         if (dev->power.syscore || dev->power.direct_complete)
> >                 goto Complete;
> >
> > +       /*
> > +        * Disable runtime PM for the device without checking if there =
is a
> > +        * pending resume request for it.
> > +        */
> > +       __pm_runtime_disable(dev, false);
> > +
>
> Moving this here means we are going to keep runtime pm enabled for
> syscore devices during system wide suspend/resume. That's quite a
> change in behaviour for a fix for a regression, I think. Not saying
> that it can't work though.

syscore devices can be a special case, but I thought it wouldn't be
necessary to special-case them.

Do you actually know about any of them needing special casing?

> Although, perhaps better to call __pm_runtime_disable() a few lines
> earlier and use a separate flag to track that we need to call
> pm_runtime_enable() in device_resume_early()?

I don't think it is necessary or even useful to introduce new flags for thi=
s.

