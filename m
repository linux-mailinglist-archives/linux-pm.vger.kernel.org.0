Return-Path: <linux-pm+bounces-38168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B99C6973B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79C9D354276
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A111FE44A;
	Tue, 18 Nov 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljAmFrc2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648D1A23AC;
	Tue, 18 Nov 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469920; cv=none; b=a3/XHyV7fQwo4vFcSep6qjjyVVfLnOjBFk1bftH80r1XjPGEwAPMYbEtO3dHyZ0jLZG18gWnynHR2oF+AZ0SqKa3rgvfNGOwtwc701SmgBbvSN07wjX3CBGcI8ZYfFXLVYh72dQy9RC73zN/Mvx2uZGKekw74M/IXnCtmMORe2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469920; c=relaxed/simple;
	bh=mX9HOl6foucJpp+7RcOmJ/Ti2/OikZKRkA5O5NI7Pes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbQGKojeDYaSGj+F8DkbX469PZAXRvVT5qqiAA340oto5NzubJ9gQaEGOFjrYs48O/+z8zHSGrgnTCF6rpWde6IIofXpFyBMBz2hIM2p7nMBRiiXwjup6tH6TOTGeWA9zUx0jcfFrwsDy1hmJPggmVxgpCGsPJopc3/isODSikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljAmFrc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CE5C4AF0C;
	Tue, 18 Nov 2025 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763469919;
	bh=mX9HOl6foucJpp+7RcOmJ/Ti2/OikZKRkA5O5NI7Pes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljAmFrc2YSDLjB7qJtOn5vuHG21eZkd6V2JNMSRIMA+JqGVA0ga/MZx4Nm9ERjvPB
	 6K7DOEkaIN/zwBJI1PZeVDSk/RUwgrOvUhP1y0jcTy9OjvE4fAY+XKmlA30i5pSJ4L
	 vP6w43jtzyuOoOZdlfyFDx/lncUWhiGEW9L5QQk9q5qPLAaPGxZK2vWrM6nzkjOzdc
	 yP1f2LRdyEesi/Qu5NiGLV5diGM2kXkCDJ/ywoEs8o4WjEva85O6fWUu4sgMiTXMhJ
	 SaK9B+kWI17DkL1PQeW1RVEvVDCM0Z11p2e+hDSgDYY5IeA8H81bwy7M+iyQJqHv0O
	 cOcupeU8JG1zQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rose Wu <ya-jou.wu@mediatek.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 wsd_upstream <wsd_upstream@mediatek.com>, linux-mediatek@lists.infradead.org,
 "artis. chiu" <artis.chiu@mediatek.com>,
 "Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>
Subject:
 [PATCH v3] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
Date: Tue, 18 Nov 2025 13:45:13 +0100
Message-ID: <5941318.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com>
References:
 <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <CAPDyKFqzt70rkHaRP62zErkMi2kFC1iY-NHPWjK0FWZSjZ00jA@mail.gmail.com>
 <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, November 18, 2025 1:26:06 PM CET Rafael J. Wysocki wrote:
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
> > > necessary.  However, if the device's callback returns an error and the
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
>=20
> syscore devices can be a special case, but I thought it wouldn't be
> necessary to special-case them.
>=20
> Do you actually know about any of them needing special casing?

In any case, below is a v3 that special-cases syscore devices.  Fortunately,
it is not much more complicated than the v2.

Thanks!

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Runtime PM should only be enabled in device_resume_early() if it has
been disabled for the given device by device_suspend_late().  Otherwise,
it may cause runtime PM callbacks to run prematurely in some cases
which leads to further functional issues.

Make two changes to address this problem.

=46irst, reorder device_suspend_late() to only disable runtime PM for a
device when it is going to look for the device's callback or if the
device is a "syscore" one.  In all of the other cases, disabling runtime
PM for the device is not in fact necessary.  However, if the device's
callback returns an error and the power.is_late_suspended flag is not
going to be set, enable runtime PM so it only remains disabled when
power.is_late_suspended is set.

Second, make device_resume_early() only enable runtime PM for the
devices with the power.is_late_suspended flag set.

=46ixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronou=
s")
Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a7dee7eda=
affc33.camel@mediatek.com/
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--

v2 -> v1:
   * Also set is_late_suspended for syscore devices to avoid skipping runti=
me PM
     disabling for them (Ulf).
   * Update the changelog to reflect the above.

v1 -> v2:
   * Add pm_runtime_enable() to device_suspend_late() error path (Rose).
   * Update the changelog to reflect the above.

=2D--
 drivers/base/power/main.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

=2D-- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -903,7 +903,10 @@ static void device_resume_early(struct d
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
=20
=2D	if (dev->power.syscore || dev->power.direct_complete)
+	if (dev->power.syscore)
+		goto Skip;
+
+	if (dev->power.direct_complete)
 		goto Out;
=20
 	if (!dev->power.is_late_suspended)
@@ -941,11 +944,11 @@ Run:
=20
 Skip:
 	dev->power.is_late_suspended =3D false;
+	pm_runtime_enable(dev);
=20
 Out:
 	TRACE_RESUME(error);
=20
=2D	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
=20
 	if (error) {
@@ -1630,12 +1633,6 @@ static void device_suspend_late(struct d
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
=20
=2D	/*
=2D	 * Disable runtime PM for the device without checking if there is a
=2D	 * pending resume request for it.
=2D	 */
=2D	__pm_runtime_disable(dev, false);
=2D
 	dpm_wait_for_subordinate(dev, async);
=20
 	if (READ_ONCE(async_error))
@@ -1646,9 +1643,18 @@ static void device_suspend_late(struct d
 		goto Complete;
 	}
=20
=2D	if (dev->power.syscore || dev->power.direct_complete)
+	if (dev->power.direct_complete)
 		goto Complete;
=20
+	/*
+	 * Disable runtime PM for the device without checking if there is a
+	 * pending resume request for it.
+	 */
+	__pm_runtime_disable(dev, false);
+
+	if (dev->power.syscore)
+		goto Skip;
+
 	if (dev->pm_domain) {
 		info =3D "late power domain ";
 		callback =3D pm_late_early_op(&dev->pm_domain->ops, state);
@@ -1679,6 +1685,7 @@ Run:
 		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async late" : " late", error);
+		pm_runtime_enable(dev);
 		goto Complete;
 	}
 	dpm_propagate_wakeup_to_parent(dev);




