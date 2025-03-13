Return-Path: <linux-pm+bounces-23951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE950A5E991
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 02:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5589E189CFF7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 01:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951A7603F;
	Thu, 13 Mar 2025 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlM9vd7E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED912AD31
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830617; cv=none; b=M2r3eWWPXxsOmi7oeJxPmot+vx/XyMR8tAi4nzCBGg/6kr/6Ok5Nf51XbSDfB08j5o9BYpabnI+eJs928ayyCL0RlyxTFenSH+7iZ1nMahJ28oY9SeMIxmGkrmwlKd9mmGpwRvh0JpXaG9uxhfD9HTAHKZGICy6T0xIgckKGaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830617; c=relaxed/simple;
	bh=41AczRiNyc4mn1z+SuV//JXGz0lYt/dC7rUHxIupShE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLVw4+SVShEcvlnJa6Vn2vN5ioSMZPDngS5MFb6sd+SPJ2W/4MrggqgVNYXr2KI2sAgS91Ah0H55mZri5f0nWirnS528bg0lK/Cx9Mkhr3Y7LNyTl8PiLJSuQKL/wwBIyhMRraXgtgkFmjKkZHnF9yvofog83to7DYxOAYd6S5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlM9vd7E; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so497208e87.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 18:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741830613; x=1742435413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rhnTdC4msVOGkRqdQCpgRtVWxEKnxMJbPpV2vd+gws=;
        b=BlM9vd7EzYygTFRBb/onUbcWoMxHW3hyCj3S/tLzRUsXsXRACw6r4ooHWRgiLjgXqi
         zyKoU3xggmD0FB2/gEF+mMFO+Eu3a6yDQQB1XKvLCWWJBzzIpeFaEO+VWBUfSuA0oxJZ
         306FhdE6Xzxdcv27Ciu3yZHU+XJHcHbWGeWy8RDcvGi2K/8TsBqBmLbaZFWCY+a1sGWY
         KFxdco0URfjmeG+kYWCQSCmbfKUN/6ph6kJ2rwWSDXSaCgAR2YsRluB1LZw6b4CPTYVM
         OBm+MjnncyHnibOweTvo6px1KaaeXK2+a2iA9jzMHKrHp8tkx6Oy3RauOLj+Ikp4Sj3M
         czlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741830613; x=1742435413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rhnTdC4msVOGkRqdQCpgRtVWxEKnxMJbPpV2vd+gws=;
        b=rLusxXBLBvY9Re5CUQHggPYUzZZ+EpNI8VzytxRpj+t7zcfnQMwVhC8kuc/Y6bqsXZ
         U61MFjxpzB0rJHkr/V4wZybERaDF75qONsSJGfXx5aKW/92occbbPQuApTcK2k/YgAtF
         0QfoqngQVH4GjLG9iKvzmkKrFKojjDTuix7rPoMnDSfxsbCiR3sQ4qqFVAtqeBKGOs9k
         nRbOAPOxjDRsacXdFP1cdTURoU05iewTyTg1mdThmeyd0r+xF0i/uWez5lMefzn2oguj
         SGAYGIX6YUm0WJ3pa4xV07a17b1DgYgBd8pgGOH8/RGiEeg9jRJ15Wm2knfL1BPKB4Lt
         7neg==
X-Forwarded-Encrypted: i=1; AJvYcCWfv0zxJ10cmVUtkxOT9O03pR4JVqkZD/jkrNTx7/vzp2KyjVr6x8vQpXjb0aRmAydbm9mqLssGkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYzSMVOfhVGP1EYnJrV+Md8WW710mtEn8mdq/gqRydQ+BmndVE
	1WRMiNCMnwSBBjhFqC857ZpdBTZ/65kIz9OJ+OyIPMapw1Wu2dg2pAhKKIU1UlGTuiaJXMVIhVt
	cuhkBaPjzuMsdRdEgAsfb29MI7bF8ClbLiPAK2rI0Eog+ZzjYjA==
X-Gm-Gg: ASbGncsMdBXjO2xNJf9MA+3E0a28/0xP+ssTt7kEuO/qYwLwI4+Ztiv9DV8dGmQ2m+V
	a8dsHwp5KR30JoVezYLVcgQQk2lZX91HVoKIV61ENERH2DAXvfElRNb2rKOkSn6acu7NILVMoQP
	/x91FXtehFlyDVHbvOsowE7LuCGJ74UrCzhcOCgOZY2m98pLXTn1Zk
X-Google-Smtp-Source: AGHT+IFMUtlnzYcbytb8yU8Bu3i7ST+jbM6zWRM1rfI1C2MhEYrUzZr7z46qnooeSHU0twUyuT1E1JDN0et4biqdQUY=
X-Received: by 2002:a05:6512:1245:b0:545:5d:a5cd with SMTP id
 2adb3069b0e04-54990e2c073mr7803758e87.6.1741830612786; Wed, 12 Mar 2025
 18:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com> <CAJZ5v0grG7eSJ7_c73i9-bXaFhm5rfE2WmxtR6yLB-MGkd7sVg@mail.gmail.com>
 <CAJZ5v0i42ZczVpDWQD4_OuduuHb3LDMmn0FJ9_XoqL8Frx9MEw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i42ZczVpDWQD4_OuduuHb3LDMmn0FJ9_XoqL8Frx9MEw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 12 Mar 2025 18:49:36 -0700
X-Gm-Features: AQ5f1JpeqZsD8iihTHZ2xPjQCBSbgVweLRKkornpnC9Uki24vODyoMydcmMSRpM
Message-ID: <CAGETcx83c2bDROcNWOiL9Dry4k2BWVzftncObCAzdftHY0u_NQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Segall <bsegall@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:47=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Dec 4, 2024 at 1:53=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > Trim CC list.
> >
> > On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak@goo=
gle.com> wrote:
> > >
> > > Some devices might have their is_suspended flag set to false. In thes=
e
> > > cases, dpm_resume() should skip doing anything for those devices.
> >
> > Not really.  This is particularly untrue for devices with
> > power.direct_complete set that have power.is_suspended clear.
> >
> > > However, runtime PM enable and a few others steps are done before
> > > checking for this flag. Fix it so that we do things in the right orde=
r.
> >
> > I don't see the bug this is fixing, but I can see bugs introduced by it=
.
>
> So AFAICS the bug is in the error path when dpm_suspend() fails in
> which case some devices with direct_complete set may not have been
> handled by device_suspend().  Since runtime PM has not been disabled
> for those devices yet, it doesn't make sense to re-enable runtime PM
> for them (and if they had runtime PM disabled to start with, this will
> inadvertently enable runtime PM for them).
>
> However, two changes are needed to fix this issue:
> (1) power.is_suspended needs to be set for the devices with
> direct_complete set in device_suspend().
> (2) The power.is_suspended check needs to be moved after the
> power.syscore one in device_resume().
>
> The patch below only does (2) which is insufficient and it introduces
> a functional issue for the direct_complete devices with runtime PM
> disabled because it will cause runtime PM to remain disabled for them
> permanently.
>
> > I think that you want power.is_suspended to be checked before waiting
> > for the superiors.  Fair enough, since for devices with
> > power.is_suspended clear, there should be no superiors to wait for, so
> > the two checks can be done in any order and checking
> > power.is_suspended first would be less overhead.  And that's it
> > AFAICS.
> >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/base/power/main.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 4a67e83300e1..86e51b9fefab 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_=
message_t state, bool async)
> > >         if (dev->power.syscore)
> > >                 goto Complete;
> > >
> > > +       if (!dev->power.is_suspended)
> > > +               goto Unlock;
>
> And this should be "goto Complete" because jumping to Unlock
> introduces a device locking imbalance.
>
> > > +
> > >         if (dev->power.direct_complete) {
> > >                 /* Match the pm_runtime_disable() in __device_suspend=
(). */
> > >                 pm_runtime_enable(dev);
> > > @@ -931,9 +934,6 @@ static void device_resume(struct device *dev, pm_=
message_t state, bool async)
> > >          */
> > >         dev->power.is_prepared =3D false;
> > >
> > > -       if (!dev->power.is_suspended)
> > > -               goto Unlock;
> > > -
> > >         if (dev->pm_domain) {
> > >                 info =3D "power domain ";
> > >                 callback =3D pm_op(&dev->pm_domain->ops, state);
> > > --
>
> If you want to submit a new version of this patch, please do so by the
> end of the week or I will send my fix because I want this issue to be
> addressed in 6.15.

Please do ahead with the fix for this. I'm not too comfortable with
the direct_complete logic yet.

-Saravana

>
> BTW, please note that this is orthogonal to the recent async
> suspend-resume series
>
> https://lore.kernel.org/linux-pm/13709135.uLZWGnKmhe@rjwysocki.net/
>
> so there is no reason why it should be addressed in that series.

