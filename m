Return-Path: <linux-pm+bounces-23833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F6A5BE30
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 11:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A864188E424
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 10:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC3524EF6E;
	Tue, 11 Mar 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKNbnTYA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378624EA94;
	Tue, 11 Mar 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690052; cv=none; b=hcOshXAofPuQwhZaZDQvSl+wrXaDcw5X2zcpKo9xC/R/8olQffxK1yWaRcHUN2J+QlurWn2eCaBYz27oEmfpp/F4Jhi95NI0QGz+yQVt2c7Pe4iQvPuqfU2FNl4C9199nnKneMUQ5s9EQyWo2NWbOk5tjRcmUmhBK/9zCtk14IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690052; c=relaxed/simple;
	bh=6CKIUv8QIOSc6vAHNsKeJjNr5Qs9WiJcfJ8Rn4nf/6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHBNXyh1KKwQW7489O7ye+2Ny4JowvbXWnyi6IjEsVbL2DSt2hiTC3KcaL0Sv45gu1iudPFNQLAl6ICoUC2e1mKVF+Y75CBh8asrMyhflWPVp0TGXMigowp38rMomahRm3K/4Trpuimxf4GfqOOiEtuuyfBJEOCpc+SqHm05I1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKNbnTYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1ECC4CEEE;
	Tue, 11 Mar 2025 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741690051;
	bh=6CKIUv8QIOSc6vAHNsKeJjNr5Qs9WiJcfJ8Rn4nf/6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sKNbnTYAP7UGTDPTSGtSLZZ7jeBHS7jXKoUxrWao6AyGnrW+J+MTJIDi0c4YwVohz
	 DPXGSvkOoOn2ZkyTW0dJ01wkN9raWyVVpDdmOQIDYfriX1V9dPMwtawIFkACtykS82
	 Mhuvv+K3JUNK4409uj/MsdIg7mneZfnBgkaPO9OmitQt+NzcZjFhjwiqhbMZrb+1Z4
	 1drvZ3gcVRoe5WcN8vkIuZ+RDeFQdo8mOJkw4acKmcNDx4IJ3jSFyXJoIou5koNt0t
	 tPFNcRDwpMUHHjvJLReZl6NH2bN6nQEccez9s9SGLJCf73LNkgCObpMz0DKbR4CshD
	 Eyg/7xEZi5aTA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c1c4e364c8so2424137fac.1;
        Tue, 11 Mar 2025 03:47:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUFCGO1kmoon9HNEz0TT26ot6+RW9yiCFYq/b70YhO4lJ6R7nLdRTJFb2zLCYEj+Vl0USc3EqOxS/C1E0=@vger.kernel.org, AJvYcCVSyKE/5JEDEJYf+vw4hCl1luGxfvB8Z/1nKX6ICkDBYVPUXnRrs++fNAFv4Q1gQeb1Ga5A2Ex84wI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lF4ploQOGeKYF+BFSg75UcQqf4ERj6jDELyI49k2RbDNv97b
	Ak9qnT9OOWunaLyF9NO6DW+QN5e7fA2/OYV2lfsaVE8l4DfkcMTrCszqK5mfbYdgh8zKOJFRAFL
	qRvgb8fD8dWqZ1R7ac9Sm66JGjbM=
X-Google-Smtp-Source: AGHT+IEe/NcV1hIjGOles6Av0O5zCBrwOnydC51FYCajKGv7k93kyoWOSMc6Y94cbdHMahh3yYYRQGyJ+MfcG8X6A68=
X-Received: by 2002:a05:6870:80c6:b0:2b8:41ef:2ca with SMTP id
 586e51a60fabf-2c2e95dc1ccmr1677482fac.6.1741690050652; Tue, 11 Mar 2025
 03:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com> <CAJZ5v0grG7eSJ7_c73i9-bXaFhm5rfE2WmxtR6yLB-MGkd7sVg@mail.gmail.com>
In-Reply-To: <CAJZ5v0grG7eSJ7_c73i9-bXaFhm5rfE2WmxtR6yLB-MGkd7sVg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Mar 2025 11:47:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i42ZczVpDWQD4_OuduuHb3LDMmn0FJ9_XoqL8Frx9MEw@mail.gmail.com>
X-Gm-Features: AQ5f1JpRewozx2E19oew8x7uYbKDVJ3rsPpQ3GkIN7KhAJMqUMDH0SEYN8eFsIo
Message-ID: <CAJZ5v0i42ZczVpDWQD4_OuduuHb3LDMmn0FJ9_XoqL8Frx9MEw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
To: Saravana Kannan <saravanak@google.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Segall <bsegall@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:53=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Trim CC list.
>
> On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak@googl=
e.com> wrote:
> >
> > Some devices might have their is_suspended flag set to false. In these
> > cases, dpm_resume() should skip doing anything for those devices.
>
> Not really.  This is particularly untrue for devices with
> power.direct_complete set that have power.is_suspended clear.
>
> > However, runtime PM enable and a few others steps are done before
> > checking for this flag. Fix it so that we do things in the right order.
>
> I don't see the bug this is fixing, but I can see bugs introduced by it.

So AFAICS the bug is in the error path when dpm_suspend() fails in
which case some devices with direct_complete set may not have been
handled by device_suspend().  Since runtime PM has not been disabled
for those devices yet, it doesn't make sense to re-enable runtime PM
for them (and if they had runtime PM disabled to start with, this will
inadvertently enable runtime PM for them).

However, two changes are needed to fix this issue:
(1) power.is_suspended needs to be set for the devices with
direct_complete set in device_suspend().
(2) The power.is_suspended check needs to be moved after the
power.syscore one in device_resume().

The patch below only does (2) which is insufficient and it introduces
a functional issue for the direct_complete devices with runtime PM
disabled because it will cause runtime PM to remain disabled for them
permanently.

> I think that you want power.is_suspended to be checked before waiting
> for the superiors.  Fair enough, since for devices with
> power.is_suspended clear, there should be no superiors to wait for, so
> the two checks can be done in any order and checking
> power.is_suspended first would be less overhead.  And that's it
> AFAICS.
>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/power/main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 4a67e83300e1..86e51b9fefab 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_me=
ssage_t state, bool async)
> >         if (dev->power.syscore)
> >                 goto Complete;
> >
> > +       if (!dev->power.is_suspended)
> > +               goto Unlock;

And this should be "goto Complete" because jumping to Unlock
introduces a device locking imbalance.

> > +
> >         if (dev->power.direct_complete) {
> >                 /* Match the pm_runtime_disable() in __device_suspend()=
. */
> >                 pm_runtime_enable(dev);
> > @@ -931,9 +934,6 @@ static void device_resume(struct device *dev, pm_me=
ssage_t state, bool async)
> >          */
> >         dev->power.is_prepared =3D false;
> >
> > -       if (!dev->power.is_suspended)
> > -               goto Unlock;
> > -
> >         if (dev->pm_domain) {
> >                 info =3D "power domain ";
> >                 callback =3D pm_op(&dev->pm_domain->ops, state);
> > --

If you want to submit a new version of this patch, please do so by the
end of the week or I will send my fix because I want this issue to be
addressed in 6.15.

BTW, please note that this is orthogonal to the recent async
suspend-resume series

https://lore.kernel.org/linux-pm/13709135.uLZWGnKmhe@rjwysocki.net/

so there is no reason why it should be addressed in that series.

