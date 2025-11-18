Return-Path: <linux-pm+bounces-38173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE794C6983B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 11B7E28D46
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143F92E7F3F;
	Tue, 18 Nov 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcs5v27C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014F2DE6F1
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470918; cv=none; b=N17RWF3vjiPQmBOn3PqT+IVC/+iVSM6GQVJHhu5D6BFBDi7L4VlD0rFEoEId43hU+ZgF4U6Os0aD+AjjMAZSSzeiXp+GZC99AxzYr/+RPSY7SC4PLTLHpa2SPgd2wtgbbbDDlbkkwGJVHTcLO/BhKJlZCAcu00tfQwWzEsKHCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470918; c=relaxed/simple;
	bh=YjtLQBMeP0xt7VJYYWG7rgttKkl7y8Fqq8/Sa5rW9P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ti6LoQw6/j4Fn4La520r2tzwuxQUNmw23BlMlMY20t50c3028aoCC3bkOC7lq7NLdDoG4//Be4riYewU6ZXQGRu0ejzIh6yxHEE0ZMChfqfbyLuVsNvWay91M0k1HsjiXnj6paq/t9GHqDDhi633kfxUxqiVWED5sCsHmK5nujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcs5v27C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F889C4AF0B
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763470917;
	bh=YjtLQBMeP0xt7VJYYWG7rgttKkl7y8Fqq8/Sa5rW9P4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lcs5v27CClV1Go2UPLHo88yPz7NGv3PSgEl2eFxDIWKwQcHN8XJt8lrwxNUF7UDT1
	 /u57fJtKDCyMuBVc+bm5BT0is56bZcm04mv+4FUYYJI/Gvdr0jsifp4sSvF/jqB7dO
	 3LTqHteacvXrOkhmSkRYv3cuuEC33Kk7TKJpLpwdoTHHUcKLa1AgP1dIdb4TBcKveR
	 q8okvFYnK5yuhE9rifUPhRfoeEmsMRqxgkA1sGGLzs2PqnTi+tk0EZ34jGbtLuPGXl
	 ENf0hto/cak6qDcyivKJ6X/WBlpXi6nblEP3l2nZXVSqi5sYoJOffztDhXErO+OIMQ
	 iXbqWX9HhYuqg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c7533dbd87so2013799a34.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 05:01:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1PJMhHCiyNaWM8DKLb2RqLWrIQtAewPTar5ydjOGeq/N5zrbED1SHBts2yo5if3/qrDCC/p74xw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm5gXO6ZSt/yKJrF46t6pLuIvsMuzh60IotYpNBf0GG/dfeqXT
	2XfBGrKeVeokRHix3ARqU/yd9QYZcUXDAjL4+9fG92t2pVNGwBB2WB8jo3VfgHa0exxjs2ruuwd
	wLjjNenb+pzPC4HkSFCoEJ3y9ws0OwGQ=
X-Google-Smtp-Source: AGHT+IHXS37uQTmeIx0p25jXSTTQG/CVFr3Vmtg9OyQqsn0MkmXDXyyv1d6qJBfWbiQozCzHQk/UEuxEZE8AqR27gL4=
X-Received: by 2002:a05:6830:4389:b0:7c7:5d72:567b with SMTP id
 46e09a7af769-7c75d7272b4mr5643963a34.23.1763470914397; Tue, 18 Nov 2025
 05:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <CAPDyKFqzt70rkHaRP62zErkMi2kFC1iY-NHPWjK0FWZSjZ00jA@mail.gmail.com>
 <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com>
 <5941318.DvuYhMxLoT@rafael.j.wysocki> <CAPDyKFq9boy3xTZ0Zy55QMgNu9MFH50FQeJp8buu4q7WowgFLg@mail.gmail.com>
In-Reply-To: <CAPDyKFq9boy3xTZ0Zy55QMgNu9MFH50FQeJp8buu4q7WowgFLg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Nov 2025 14:01:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gMEjBfsLse4FmG_XeXE3Yd4wktq57OwqcytQN4h1+t5w@mail.gmail.com>
X-Gm-Features: AWmQ_bnsDSjSopji_sFnDz22MaQHn5-fmwPMCMp2aNM-hUEOI8CJfT9twykNx5g
Message-ID: <CAJZ5v0gMEjBfsLse4FmG_XeXE3Yd4wktq57OwqcytQN4h1+t5w@mail.gmail.com>
Subject: Re: [PATCH v3] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rose Wu <ya-jou.wu@mediatek.com>, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, wsd_upstream <wsd_upstream@mediatek.com>, 
	linux-mediatek@lists.infradead.org, "artis. chiu" <artis.chiu@mediatek.com>, 
	"Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:58=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Tue, 18 Nov 2025 at 13:45, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Tuesday, November 18, 2025 1:26:06 PM CET Rafael J. Wysocki wrote:
> > > On Tue, Nov 18, 2025 at 1:18=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Tue, 18 Nov 2025 at 12:48, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Tuesday, November 18, 2025 9:31:08 AM CET Rose Wu wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Mon, 2025-11-17 at 19:57 +0100, Rafael J. Wysocki wrote:
> > > > > > >
> > > > > > > Make two changes to address this problem.
> > > > > > >
> > > > > > > First, reorder device_suspend_late() to only disable runtime =
PM for a
> > > > > > > device if the power.is_late_suspended flag is going to be set=
 for it.
> > > > > > > In all of the other cases, disabling runtime PM for the devic=
e is not
> > > > > > > in fact necessary.
> > > > > > >
> > > > > > > Second, make device_resume_early() only enable runtime PM for=
 the
> > > > > > > devices with the power.is_late_suspended flag set.
> > > > > > >
> > > > > >
> > > > > > My concern is with the error path in device_suspend_late().
> > > > > > If a device fails its dpm_run_callback(), it appears that its
> > > > > > power.is_late_suspended flag is not set, potentially leaving it=
s runtime
> > > > > > PM disabled during the resume sequence.
> > > > >
> > > > > Right, pm_runtime_enable() is missing in the error path after cal=
ling
> > > > > dpm_run_callback().
> > > > >
> > > > > ---
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Runtime PM should only be enabled in device_resume_early() if it =
has
> > > > > been disabled for the given device by device_suspend_late().  Oth=
erwise,
> > > > > it may cause runtime PM callbacks to run prematurely in some case=
s
> > > > > which leads to further functional issues.
> > > > >
> > > > > Make two changes to address this problem.
> > > > >
> > > > > First, reorder device_suspend_late() to only disable runtime PM f=
or a
> > > > > device when it is going to look for the device's callback.  In al=
l of
> > > > > the other cases, disabling runtime PM for the device is not in fa=
ct
> > > > > necessary.  However, if the device's callback returns an error an=
d the
> > > > > power.is_late_suspended flag is not going to be set, enable runti=
me
> > > > > PM so it only remains disabled when power.is_late_suspended is se=
t.
> > > > >
> > > > > Second, make device_resume_early() only enable runtime PM for the
> > > > > devices with the power.is_late_suspended flag set.
> > > > >
> > > > > Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asy=
nchronous")
> > > > > Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
> > > > > Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f=
4a7dee7edaaffc33.camel@mediatek.com/
> > > > > Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >
> > > > > v1 -> v2: Add pm_runtime_enable() to device_suspend_late() error =
path (Rose).
> > > > >
> > > > > ---
> > > > >  drivers/base/power/main.c |   15 ++++++++-------
> > > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > > >
> > > > > --- a/drivers/base/power/main.c
> > > > > +++ b/drivers/base/power/main.c
> > > > > @@ -941,11 +941,11 @@ Run:
> > > > >
> > > > >  Skip:
> > > > >         dev->power.is_late_suspended =3D false;
> > > > > +       pm_runtime_enable(dev);
> > > > >
> > > > >  Out:
> > > > >         TRACE_RESUME(error);
> > > > >
> > > > > -       pm_runtime_enable(dev);
> > > > >         complete_all(&dev->power.completion);
> > > > >
> > > > >         if (error) {
> > > > > @@ -1630,12 +1630,6 @@ static void device_suspend_late(struct d
> > > > >         TRACE_DEVICE(dev);
> > > > >         TRACE_SUSPEND(0);
> > > > >
> > > > > -       /*
> > > > > -        * Disable runtime PM for the device without checking if =
there is a
> > > > > -        * pending resume request for it.
> > > > > -        */
> > > > > -       __pm_runtime_disable(dev, false);
> > > > > -
> > > > >         dpm_wait_for_subordinate(dev, async);
> > > > >
> > > > >         if (READ_ONCE(async_error))
> > > > > @@ -1649,6 +1643,12 @@ static void device_suspend_late(struct d
> > > > >         if (dev->power.syscore || dev->power.direct_complete)
> > > > >                 goto Complete;
> > > > >
> > > > > +       /*
> > > > > +        * Disable runtime PM for the device without checking if =
there is a
> > > > > +        * pending resume request for it.
> > > > > +        */
> > > > > +       __pm_runtime_disable(dev, false);
> > > > > +
> > > >
> > > > Moving this here means we are going to keep runtime pm enabled for
> > > > syscore devices during system wide suspend/resume. That's quite a
> > > > change in behaviour for a fix for a regression, I think. Not saying
> > > > that it can't work though.
> > >
> > > syscore devices can be a special case, but I thought it wouldn't be
> > > necessary to special-case them.
> > >
> > > Do you actually know about any of them needing special casing?
> >
> > In any case, below is a v3 that special-cases syscore devices.  Fortuna=
tely,
> > it is not much more complicated than the v2.
> >
> > Thanks!
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
> > device when it is going to look for the device's callback or if the
> > device is a "syscore" one.  In all of the other cases, disabling runtim=
e
> > PM for the device is not in fact necessary.  However, if the device's
> > callback returns an error and the power.is_late_suspended flag is not
> > going to be set, enable runtime PM so it only remains disabled when
> > power.is_late_suspended is set.
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
> > v2 -> v1:
> >    * Also set is_late_suspended for syscore devices to avoid skipping r=
untime PM
> >      disabling for them (Ulf).
> >    * Update the changelog to reflect the above.
> >
> > v1 -> v2:
> >    * Add pm_runtime_enable() to device_suspend_late() error path (Rose)=
.
> >    * Update the changelog to reflect the above.
> >
> > ---
> >  drivers/base/power/main.c |   25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -903,7 +903,10 @@ static void device_resume_early(struct d
> >         TRACE_DEVICE(dev);
> >         TRACE_RESUME(0);
> >
> > -       if (dev->power.syscore || dev->power.direct_complete)
> > +       if (dev->power.syscore)
> > +               goto Skip;
>
> This will enable runtime PM for a syscore device, even if it wasn't
> disabled when device_suspend_late() wasn't called for it.

Yeah, I need to reorder this after the power.is_late_suspended check.

I'll send a v4 later today.

Thanks!

