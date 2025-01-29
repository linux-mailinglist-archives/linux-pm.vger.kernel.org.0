Return-Path: <linux-pm+bounces-21103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE4A221EE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 17:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9236E1887245
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427641DEFC6;
	Wed, 29 Jan 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJcSFj1d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60580143722
	for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168963; cv=none; b=S03PEx/zgwJdNWKrrgiLJLmaw648wG6V1uomviErxj4BcumcO9FaOOMqpOUwUHVhe5iK13EEwK/Clcq8aCkb5Vc/BP95B6Y5Mi36d7Nfp5zSaV2NrSNDkC8KKBJdA0ADlpS2K83yyGzUbZLKPCKgR78Eu/fntsa4XkDRhWNoZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168963; c=relaxed/simple;
	bh=jXoR5JrFfvY/cqgDfvi2pJHswhPkdoNT2QhSMeBBjw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTiZnj97eJmoZ0Iqsl6WZPQ4JwFTEV67Ia0YLuu3cKDhyRfKxWlgtHqfqnmjLNLQHCqspXDIGb0QpLTjDGwupaUAmK6sqaYbFFcg73k+OGj0ERCEkhM8a1OhLMmowtopobYMvKDdSy9ByV3oYI/+b+EQvLu5NwfHsKZajkAi8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YJcSFj1d; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e479e529ebcso9306426276.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2025 08:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738168960; x=1738773760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWlafRPE1Nteycazvm1h1SgHP7CX0ZQJvFWfBfYS9Wg=;
        b=YJcSFj1dsuhWyU8bKs2y6u0yyU5DP7ukI/pAxpFw+IuuXgOqfefobCsqKT6PHKS9wX
         /DWIu6ppo13aRnUBBK77n6oOo7iPE2pr3ZhLGE9oii61jmUB3IpG8I4e0KdQwIHhpinB
         RYDVYq/el+bfrNDPOA0OvPyWEcLXKNS/xUi/qOsgkrMs0EVsW8yQIYyonW365zgzPApI
         NKF82z4TWokFM9g13Svsdt0LicrTIFvxPFM0S+A8Rr86Fdgle4g5yjWGZYXGLKHrIAKJ
         1qOIWn4hufTKnWMXDqeUUavLoeoCUu5xXgYKFDxOoLNtlfc5bN/nvJYSuUd68LjDBV40
         CBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168960; x=1738773760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWlafRPE1Nteycazvm1h1SgHP7CX0ZQJvFWfBfYS9Wg=;
        b=DwLgIUaVCMuFb0gMjlaFL1n7yvSjsBbhnfvpb1JVQhaDrCm7UVi1iI7CMhJMrjO4tm
         P8XJ3+2nyWnN/IrzJb0toC6ff7MOqHCagSKwt6CrPYb/MB8tteMTy0k+q1HPvT3Wfnua
         wfB4X2anps3dYnwf+VT4chnRvmscAUJb5xD8ZRqCj/9O3zKIBu99hLV6a0sWhVbaUYNf
         EB+5ZCVIaAv298k+FpkkxE44+PN1bnJlnrt2wD4tKyxNnqMT0CT4cCDjsNIrZtxMqooM
         JXdkY0cqG4UFvtJn8CcV/4OnOVDldJUFn8eHn1AWwR/X2HKnPdNURCZ3kafduvFxm/jz
         ROKA==
X-Forwarded-Encrypted: i=1; AJvYcCX/HwHm3mzTU/o8b2LUUwf/dLJyVwtEVU1pBuIIvtsM+kOxYOIEkmk/p8FhmYSpXFD8wVEkRNL4TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEgYg5hYWQb2goEVE7EH9vqXmizQ5WRiRNPJ+ziRB3T3g6f3H
	F/0QEKX5nMaSPkdKO0rnprXrlARRqAdMjeCnbxj5hKwXxwMCWgf7KWm/gItOpmuwLvfNIcRZZSB
	O0v+nuedvIV89UCJl48YwWbPOfGKRlYjSy4iOjQ==
X-Gm-Gg: ASbGncu+ySX8nRqk5vwiVIeZVM6FlMZ9L9jmBnZHE18r7w122UZdjzG5jY6rRDZySNh
	0/YwnhV5vJ41M/fMhVr/xwK0rPRFTY5WgBImCay+EXaT+UKvccnJqspq3qD1x9L6DRUs77GPRSA
	==
X-Google-Smtp-Source: AGHT+IFZ5T7lGKFozgd8Zmg8zvVcH8aNJ2UXXnGQPWsMRZkxXaj591kgIDlz2K2MPK3LYp/x/jdYXivXLC0iPyVjXhg=
X-Received: by 2002:a05:6902:2b06:b0:e57:4db7:6d51 with SMTP id
 3f1490d57ef6-e58a4bd6abfmr2725769276.32.1738168960210; Wed, 29 Jan 2025
 08:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
 <CAJZ5v0gvQjp_P-5Ww7iN1cGiiMJ6tvLLnPpkTQNk++KhoRe=GA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvQjp_P-5Ww7iN1cGiiMJ6tvLLnPpkTQNk++KhoRe=GA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 29 Jan 2025 17:42:04 +0100
X-Gm-Features: AWEUYZmasrpUN1sfDUDJbaFI09M9NVpAp9-XCWt7FC6NnV6gxuqP6a5vX2P6gd0
Message-ID: <CAPDyKFrBO+r8qYRrhoFZN21__8RuR61ofbsGQZbA=pyQbti5CA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jan 2025 at 16:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 29, 2025 at 12:53=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Tue, 28 Jan 2025 at 20:24, Rafael J. Wysocki <rjw@rjwysocki.net> wro=
te:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
> > > resume phase") overlooked the case in which the parent of a device wi=
th
> > > DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runtime=
-
> > > suspended before a transition into a system-wide sleep state.  In tha=
t
> > > case, if the child is resumed during the subsequent transition from
> > > that state into the working state, its runtime PM status will be set =
to
> > > RPM_ACTIVE, but the runtime PM status of the parent will not be updat=
ed
> > > accordingly, even though the parent will be resumed too, because of t=
he
> > > dev_pm_skip_suspend() check in device_resume_noirq().
> > >
> > > Address this problem by tracking the need to set the runtime PM statu=
s
> > > to RPM_ACTIVE during system-wide resume transitions for devices with
> > > DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by them=
.
> > >
> > > Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the r=
esume phase")
> > > Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldconsu=
lting.com/
> > > Reported-by: Johan Hovold <johan@kernel.org>
> > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/main.c |   29 ++++++++++++++++++++---------
> > >  include/linux/pm.h        |    1 +
> > >  2 files changed, 21 insertions(+), 9 deletions(-)
> > >
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -656,13 +656,15 @@
> > >          * so change its status accordingly.
> > >          *
> > >          * Otherwise, the device is going to be resumed, so set its P=
M-runtime
> > > -        * status to "active", but do that only if DPM_FLAG_SMART_SUS=
PEND is set
> > > -        * to avoid confusing drivers that don't use it.
> > > +        * status to "active" unless its power.set_active flag is cle=
ar, in
> > > +        * which case it is not necessary to update its PM-runtime st=
atus.
> > >          */
> > > -       if (skip_resume)
> > > +       if (skip_resume) {
> > >                 pm_runtime_set_suspended(dev);
> > > -       else if (dev_pm_skip_suspend(dev))
> > > +       } else if (dev->power.set_active) {
> > >                 pm_runtime_set_active(dev);
> > > +               dev->power.set_active =3D false;
> > > +       }
> > >
> > >         if (dev->pm_domain) {
> > >                 info =3D "noirq power domain ";
> > > @@ -1189,18 +1191,24 @@
> > >         return PMSG_ON;
> > >  }
> > >
> > > -static void dpm_superior_set_must_resume(struct device *dev)
> > > +static void dpm_superior_set_must_resume(struct device *dev, bool se=
t_active)
> > >  {
> > >         struct device_link *link;
> > >         int idx;
> > >
> > > -       if (dev->parent)
> > > +       if (dev->parent) {
> > >                 dev->parent->power.must_resume =3D true;
> > > +               if (set_active)
> > > +                       dev->parent->power.set_active =3D true;
> > > +       }
> > >
> > >         idx =3D device_links_read_lock();
> > >
> > > -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c=
_node)
> > > +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c=
_node) {
> > >                 link->supplier->power.must_resume =3D true;
> > > +               if (set_active)
> > > +                       link->supplier->power.set_active =3D true;
> >
> > If I understand correctly, the suppliers are already handled when the
> > pm_runtime_set_active() is called for consumers, so the above should
> > not be needed.
>
> It is needed because pm_runtime_set_active() doesn't cause the setting
> to propagate to the parent's/suppliers of the suppliers AFAICS.

Hmm, even if that sounds reasonable, I don't think it's a good idea as
it may introduce interesting propagation problems between drivers.

For example, consider that Saravana is trying to enable runtime PM for
fw_devlinks. It would mean synchronization issues for the runtime PM
status, all over the place.

That said, is even consumer/suppliers part of the problem we are
trying to solve?

>
> > That said, maybe we instead allow parent/child to work in the similar
> > way as for consumer/suppliers, when pm_runtime_set_active() is called
> > for the child. In other words, when pm_runtime_set_active() is called
> > for a child and the parent is runtime PM enabled, let's runtime resume
> > it too, as we do for suppliers. Would that work, you think?
>
> The parent is not runtime-PM enabled when this happens.

That sounds really weird to me.

Does that mean that the parent has not been system resumed either? If
so, isn't that really the root cause for this problem, or what am I
missing?

Kind regards
Uffe

