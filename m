Return-Path: <linux-pm+bounces-30861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22201B05A7E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 14:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603DF1AA5903
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCBD381C4;
	Tue, 15 Jul 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT9hige+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211ADF59;
	Tue, 15 Jul 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583594; cv=none; b=XaUfypMb02C/4Q9cxroKikshbIuDiK/+6s6BiL0R+DzhHPxUKEVLFiGlQlwKAplrgKOG4/P2oP7Zunhz8MjE+LXdxxvuZAmbGtFsrXam/AFfPQJpiPQylH4n3ZBtTtqGoF6pxQ/5yxSWAi4hMjVQ1ykpTxJNfbjxHNJuDMAigeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583594; c=relaxed/simple;
	bh=7+EiGA5DqyRfAT8n2kRDa1y3dt2X7YvUBYZXT6JOCq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLG3z18t4mYJgAmj3ARGOOiwpGDitk3mbX6TLO5nm9BEpiOmS4IOdppc43HQzklLuCIXkyDr1Q7XG/d5anOSCfTPaiKKrYOhvfLqg10PmwXpKs0/tN5XuGIiz7DKbR512Qd9aqHru49D61efWoQE26VG0s7/+pJKsbb/gv/rynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT9hige+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75047C4CEF1;
	Tue, 15 Jul 2025 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583593;
	bh=7+EiGA5DqyRfAT8n2kRDa1y3dt2X7YvUBYZXT6JOCq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oT9hige+EO6kjraS6G6MxR2H7jUnt+7mUDfV9HhWX29lItbEJvSC7I3iwduRotnZ4
	 9n8qsSFA/yjos2ZLHEkkzze0aGLdN3eU/qHtik46RQQn6efvv+Dn8/o/7XtZF/g4vv
	 XvQykouEWV/GwXIiDXYHTDSF4cL4V3B4xzpYuAtX/0nxD2tmV0QHHvcPimNuYn0pzo
	 pNtrqojEyRaqnV1lAQep802FJsr85zAJdbAThoHjtGc4vd7++2W5jrjYPGhRSvIv1p
	 gaUM/7GwQR+W1jFY0pwK2iWUytudKUsXI8iI8N+TfRuPeJUa5b0nQ8s/uryIzAOYW/
	 ukuPAYTvubPEw==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-41b309ce7d5so449401b6e.0;
        Tue, 15 Jul 2025 05:46:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUGTJyMINVmHye3dYaaH+1UveYkkY2p7V7LCXSmbM0mVjNtQgx5pCxhxetJHJg5YorM58kUFfGKlU=@vger.kernel.org, AJvYcCW9pquVUguf7JelkucqZKOF/Cebrf+Y5DjB7Fppe49xolV6aoSW/KG/vilPB77iebgz2dpG61oHh0SOBVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3P+JJVc3y1d+EIAA57/2SptdnlNiW2YW5mXyrKLIl6qx5YsYr
	7yK6fdwqbL5nD0MW4xIyBsKslRqLwQH3Oppgyabi9laVJvF4NqcQMFKDU3fi8ympbglpyTw37YG
	3UHQFmCm9BI6t/P/gynSF8Y4OtSibipw=
X-Google-Smtp-Source: AGHT+IFu/Q9xSrZ9iC1xiCEb7hs4kQ2UwtV4aD99pKB7qP9MAFC1OGVN2pUi4hZ9VdLis2qJe60K5sTkT2iz4Dhtxdo=
X-Received: by 2002:a05:6808:17a1:b0:40b:4208:8602 with SMTP id
 5614622812f47-4150d646f10mr12295394b6e.4.1752583592621; Tue, 15 Jul 2025
 05:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12700973.O9o76ZdvQC@rjwysocki.net> <aHYCRvz0ohgi2xUk@kekkonen.localdomain>
In-Reply-To: <aHYCRvz0ohgi2xUk@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Jul 2025 14:46:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jEELFB6vb1dtkPgu_3_eew7Y1Jebevfmhye+ZPLk0Jtg@mail.gmail.com>
X-Gm-Features: Ac12FXyRglH3SKE9RdnWM8j7VCLS4iKVOw1yueYUi33KBroSMCWLlFW7h4oKd-o
Message-ID: <CAJZ5v0jEELFB6vb1dtkPgu_3_eew7Y1Jebevfmhye+ZPLk0Jtg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Take active children into account in pm_runtime_get_if_in_use()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alex Elder <elder@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Tue, Jul 15, 2025 at 9:28=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> Thanks for the patch.
>
> On Wed, Jul 09, 2025 at 12:41:45PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > For all practical purposes, there is no difference between the situatio=
n
> > in which a given device is not ignoring children and its active child
> > count is nonzero and the situation in which its runtime PM usage counte=
r
> > is nonzero.  However, pm_runtime_get_if_in_use() will only increment th=
e
> > device's usage counter and return 1 in the latter case.
> >
> > For consistency, make it do so in the former case either by adjusting
> > pm_runtime_get_conditional() and update the related kerneldoc comments
> > accordingly.
> >
> > Fixes: c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() =
usage")
>
> I guess this should be:
>
> Fixes: c111566bea7c ("PM: runtime: Add pm_runtime_get_if_active()")

Technically yes, but that would require specific backport changes for
older "stable" series.

> Should this also be cc'd to stable?

Possibly.

> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thank you!

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |   27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> >
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1203,10 +1203,12 @@
> >   *
> >   * Return -EINVAL if runtime PM is disabled for @dev.
> >   *
> > - * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and eith=
er
> > - * @ign_usage_count is %true or the runtime PM usage counter of @dev i=
s not
> > - * zero, increment the usage counter of @dev and return 1. Otherwise, =
return 0
> > - * without changing the usage counter.
> > + * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usa=
ge_count
> > + * is set, or (2) @dev is not ignoring children and its active child c=
ount is
> > + * nonero, or (3) the runtime PM usage counter of @dev is not zero, in=
crement
> > + * the usage counter of @dev and return 1.
> > + *
> > + * Otherwise, return 0 without changing the usage counter.
> >   *
> >   * If @ign_usage_count is %true, this function can be used to prevent =
suspending
> >   * the device when its runtime PM status is %RPM_ACTIVE.
> > @@ -1228,7 +1230,8 @@
> >               retval =3D -EINVAL;
> >       } else if (dev->power.runtime_status !=3D RPM_ACTIVE) {
> >               retval =3D 0;
> > -     } else if (ign_usage_count) {
> > +     } else if (ign_usage_count || (!dev->power.ignore_children &&
> > +                atomic_read(&dev->power.child_count) > 0)) {
> >               retval =3D 1;
> >               atomic_inc(&dev->power.usage_count);
> >       } else {
> > @@ -1261,10 +1264,16 @@
> >   * @dev: Target device.
> >   *
> >   * Increment the runtime PM usage counter of @dev if its runtime PM st=
atus is
> > - * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in =
which case
> > - * it returns 1. If the device is in a different state or its usage_co=
unt is 0,
> > - * 0 is returned. -EINVAL is returned if runtime PM is disabled for th=
e device,
> > - * in which case also the usage_count will remain unmodified.
> > + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or i=
t is not
> > + * ignoring children and its active child count is nonzero.  1 is retu=
rned in
> > + * this case.
> > + *
> > + * If @dev is in a different state or it is not in use (that is, its u=
sage
> > + * counter is 0, or it is ignoring children, or its active child count=
 is 0),
> > + * 0 is returned.
> > + *
> > + * -EINVAL is returned if runtime PM is disabled for the device, in wh=
ich case
> > + * also the usage counter of @dev is not updated.
> >   */
> >  int pm_runtime_get_if_in_use(struct device *dev)
> >  {
> >
> >
>
> --
> Kind regards,
>
> Sakari Ailus
>

