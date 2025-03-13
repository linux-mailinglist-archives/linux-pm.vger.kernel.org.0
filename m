Return-Path: <linux-pm+bounces-23978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05498A5F1A8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 11:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C14B17C550
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D326560B;
	Thu, 13 Mar 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0DAQ8s/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41D260382;
	Thu, 13 Mar 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863505; cv=none; b=OEm6kBqmhzW1vUEjnVmRvrf+w9AmE1TPRL1BvdgeWk7zfJmNGGtZwtKvCj0KItWsaYyHv3v2PW3kYt3lLLC75QAALQKkvCvBqYbwrydiSb5BdRxdWMDaVCcoVAUVtmQ+5xXVy2cgpTxw16OStoayLuFL+QxUViXq+12DGA0WXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863505; c=relaxed/simple;
	bh=jeW+psbkp0X5CYfJk63izerCs5l1XzDNrmU1BWAE47w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmwEbDY8ygJaIjpSvNvToZj2RIckxJgg0TIXna6pYp2Jb6uZLxGzOd483HSZiE14zL8vTXW6+xjEVvJq4/l11J6BsHoxG9E+0jRFat/6AGWuUAsCr+paVW/hdXdXfF27fud/u3p3nBTU6AM6IZjBVuH5n2fnAv9diJkTcugQbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0DAQ8s/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9B0C4CEF2;
	Thu, 13 Mar 2025 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741863504;
	bh=jeW+psbkp0X5CYfJk63izerCs5l1XzDNrmU1BWAE47w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W0DAQ8s/qeQp0UHPaFpP3z278kkdcDbMqQJ4Wbrj5/mV4rf0UcGvMzdCfTbRDFq0r
	 g/ZGQLIwm8MV+BXRoGIHerRcBm7vi5C2Qe7NoX8OG5QaVCa2bgrzrsXyvhwKuDpLPN
	 ExnQiMYYgXH38t/wHLq/8WAyRysQ47roQIX/svjHEJGnXqIqCuyB6ERA9CxSEMYF7O
	 dg5wWe38Q7dFjM5c4Y2yKXu0sWuqe+V4Jtj9PGVTuHSc9nM7Uu08khfZmcpxkKZubs
	 T0xvaKL/tOVT3ZvmUp6ZURHSSXYEjieKfVBheDJ8pPyqPfeZNFFoscvnrgT8/v25D1
	 Dl0OWgAPiy6WQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2bcf9d9b60aso277451fac.3;
        Thu, 13 Mar 2025 03:58:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0Vp/GtDjPiJERBLxMNAe7pc8XNcDAttcwzaHjYJD0s2eknLSJpopZTjQW23reQ+bAL1GDVVoMZLY=@vger.kernel.org, AJvYcCWHXTI9shWsMZybbXR6E4HCiPRwowFjq+nspwfSSlyRtzL6nPXH3tBB9iPYfmErlnAs9SnbYFZerAel+1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWyXNU0Qirk/Ym1iWJModE+W4vkRwO3z0JiO7m6wxav9hqSIiQ
	9tRR10rtwv/To59+nwkCFxzduCeYMcj85Y7BD67FqZf7gYdfNzOETP5KwlwhWlp04dVokTwOuuz
	UaSTgDK4HVU+Pd3wOYENiimBgyLs=
X-Google-Smtp-Source: AGHT+IH5VgwEr030Ww2EchojMfp/Pq2TbnAhHwlAI1RwUOaNtv+tV6cUuAViSi47ZQQyjH0yHIlOxWnvWXBmD04NdrU=
X-Received: by 2002:a05:6870:498a:b0:29e:3bea:7e67 with SMTP id
 586e51a60fabf-2c2e89c8b02mr6030659fac.38.1741863503990; Thu, 13 Mar 2025
 03:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com> <CAJZ5v0grG7eSJ7_c73i9-bXaFhm5rfE2WmxtR6yLB-MGkd7sVg@mail.gmail.com>
 <CAJZ5v0i42ZczVpDWQD4_OuduuHb3LDMmn0FJ9_XoqL8Frx9MEw@mail.gmail.com> <CAGETcx83c2bDROcNWOiL9Dry4k2BWVzftncObCAzdftHY0u_NQ@mail.gmail.com>
In-Reply-To: <CAGETcx83c2bDROcNWOiL9Dry4k2BWVzftncObCAzdftHY0u_NQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 11:58:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hhiO24_pSqshzfycP=kwJPOC4mjFstrPreO6uMCR9ACQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrfgqAeo2LHBR9yLWu0b4lESl4svGygXKADzhyOu3Ey2E_L_awDQTV92dg
Message-ID: <CAJZ5v0hhiO24_pSqshzfycP=kwJPOC4mjFstrPreO6uMCR9ACQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Segall <bsegall@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:50=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Tue, Mar 11, 2025 at 3:47=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Wed, Dec 4, 2024 at 1:53=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > Trim CC list.
> > >
> > > On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak@g=
oogle.com> wrote:
> > > >
> > > > Some devices might have their is_suspended flag set to false. In th=
ese
> > > > cases, dpm_resume() should skip doing anything for those devices.
> > >
> > > Not really.  This is particularly untrue for devices with
> > > power.direct_complete set that have power.is_suspended clear.
> > >
> > > > However, runtime PM enable and a few others steps are done before
> > > > checking for this flag. Fix it so that we do things in the right or=
der.
> > >
> > > I don't see the bug this is fixing, but I can see bugs introduced by =
it.
> >
> > So AFAICS the bug is in the error path when dpm_suspend() fails in
> > which case some devices with direct_complete set may not have been
> > handled by device_suspend().  Since runtime PM has not been disabled
> > for those devices yet, it doesn't make sense to re-enable runtime PM
> > for them (and if they had runtime PM disabled to start with, this will
> > inadvertently enable runtime PM for them).
> >
> > However, two changes are needed to fix this issue:
> > (1) power.is_suspended needs to be set for the devices with
> > direct_complete set in device_suspend().
> > (2) The power.is_suspended check needs to be moved after the
> > power.syscore one in device_resume().
> >
> > The patch below only does (2) which is insufficient and it introduces
> > a functional issue for the direct_complete devices with runtime PM
> > disabled because it will cause runtime PM to remain disabled for them
> > permanently.
> >
> > > I think that you want power.is_suspended to be checked before waiting
> > > for the superiors.  Fair enough, since for devices with
> > > power.is_suspended clear, there should be no superiors to wait for, s=
o
> > > the two checks can be done in any order and checking
> > > power.is_suspended first would be less overhead.  And that's it
> > > AFAICS.
> > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/base/power/main.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > index 4a67e83300e1..86e51b9fefab 100644
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -913,6 +913,9 @@ static void device_resume(struct device *dev, p=
m_message_t state, bool async)
> > > >         if (dev->power.syscore)
> > > >                 goto Complete;
> > > >
> > > > +       if (!dev->power.is_suspended)
> > > > +               goto Unlock;
> >
> > And this should be "goto Complete" because jumping to Unlock
> > introduces a device locking imbalance.
> >
> > > > +
> > > >         if (dev->power.direct_complete) {
> > > >                 /* Match the pm_runtime_disable() in __device_suspe=
nd(). */
> > > >                 pm_runtime_enable(dev);
> > > > @@ -931,9 +934,6 @@ static void device_resume(struct device *dev, p=
m_message_t state, bool async)
> > > >          */
> > > >         dev->power.is_prepared =3D false;
> > > >
> > > > -       if (!dev->power.is_suspended)
> > > > -               goto Unlock;
> > > > -
> > > >         if (dev->pm_domain) {
> > > >                 info =3D "power domain ";
> > > >                 callback =3D pm_op(&dev->pm_domain->ops, state);
> > > > --
> >
> > If you want to submit a new version of this patch, please do so by the
> > end of the week or I will send my fix because I want this issue to be
> > addressed in 6.15.
>
> Please do ahead with the fix for this. I'm not too comfortable with
> the direct_complete logic yet.

OK, I will, thank you!

