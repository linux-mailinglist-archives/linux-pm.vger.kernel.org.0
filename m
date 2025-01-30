Return-Path: <linux-pm+bounces-21126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD0A22C52
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 12:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4455F169ABB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20C1E130F;
	Thu, 30 Jan 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnZsL+56"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835F1DFE01
	for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738235503; cv=none; b=J+LnGc1dj8y7XDg5tNE8Mqq17eWbDQxzNYbZkyS7BiajMVd/I2Vf2vuyfHAz6PNcW5/tUvbMcA/Kq0i/hukfWaOV+wusRuJiEN/3YgDqmA/I66joUL5TN6yF6DCBOv4X1+uY/8bY1Ur81wRAIHWzlGFa8afv87dTBYdqAmXIntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738235503; c=relaxed/simple;
	bh=7qUKjfeFd8uRS6iUUPrNvt6wUuj1wjimYl//jxDhZic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phh5AhbhBt3HG2gjNb73bX+PLmqH9DHSMUixN07mQBqXp28YIbLw3d2QltsTsnlZsQ2Ws1gbjbXp2a0GQ28aIJBnYTBgrzt06kDtRA40wHsbWttOVEV1/KS7FYMO4B5VrBxg4zaaXEmtYZpTN+rikT9FpGzHCf2niUlS0M6tu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QnZsL+56; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e54bd61e793so1033304276.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 03:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738235498; x=1738840298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDik+uRtYN6dq+boI1IijggzPXqfrovRb/cQ821uQok=;
        b=QnZsL+56/SOjQpSrCSDD+hTr6mmjhlU2T6+I2KYPiGWcxdhOhJpugtXao4MXG5h+9+
         UNJqC1MdvsQQKb1IQZXf9J2RqI1cJxafLia0I0yMPtcmUCspwVKI8sNnM59ZU5wbQSmv
         YzmjjhkpUVqSouY7l1RHMSm8Dc/eTnUTeDErddyFBCZN77neaW6fB2dfRoIAIoWCVnIS
         tmZykuqQVeLoq8ywH8j85Db54Uzu6TZHq8l0fRCxzypGq9IKRLRJ6YD6nhw7NnehhWTG
         Fgsoluoc8JKr0yK1+oWa+Wd+Su9LqCgD2bCOGDG+3Mj56tWJMLBECTmmDShaicBuJRJ6
         UqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738235498; x=1738840298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDik+uRtYN6dq+boI1IijggzPXqfrovRb/cQ821uQok=;
        b=wnCaQ/hqKb3p2/u/T+EgYVjMPAOpmtxuQrS3fP+WAByUh2MJyHmrGo9kdf2IT+hdU4
         rsAs+e+LHJ3Lq2Po04VzfWgq2NI2gecJv21aoXbvxgQg3k6C3M1Bt85ja7dSezBJvKzV
         0N2CUsNt0ZuernqoP81z4CzbLqy4HzkGOl3n1kKlLQfMLAa8waTgrcmNvpdNNmVRdmbL
         CzMI0eAfUA1ck0KGdgxjBuc+4jNU1kNMNCkcXFuHu8qsgOGkh+hoImKypCnQWg6Is9qo
         w1pguJ41RH8Me9deliJ9Qvva5LYG+AQgg6aZSW+t+CRStKqywRc88KLe0HjBb/jCUpzt
         17oA==
X-Forwarded-Encrypted: i=1; AJvYcCVmgLQ51qsQlLMApp18Z7imrzp6i7r6/7aJ2xKFwopXYS/tohAcjXZ4hbdLivhbCEQb0vN0hmy2FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTd+sZbQ6StvXYW10K4lgEvQ7nngj8hCOlfH69Dhmq31lDSOuJ
	qMJdGhI/Z/0u1GoXrJN5pEVjta9H/9gQfPx4hwPvXtnAjxHsxZ5rQvJRVXSdqk7A43OfPPw4TEj
	W6Y5Cun9hNkUVvLgi04H5dBOul1jSWZbLqA9wioOk9foPfXf5K88=
X-Gm-Gg: ASbGncsGL8F64VKNQf7IhVxbcD7TPcxxA1jEVBI/Qs5BoY6yZ+0mEMyXFUWCwQDSy3x
	W1foLXxW6L/R6y6To8yym0QA9uz7UAdy19xLc/aAr1wb61ukM+uwjI1rKdsLXyzMyWN6cOVBBLw
	==
X-Google-Smtp-Source: AGHT+IG4u/QuqlN/apS55dCHTg/t8PleUpagHcT2EFk3tBM+YjVckiLLA2ZR7kBpuv+Ft6oZKPTO5b35l1NizpuSEy8=
X-Received: by 2002:a05:6902:2483:b0:e58:514:cc9a with SMTP id
 3f1490d57ef6-e58a4b12709mr5147408276.29.1738235498568; Thu, 30 Jan 2025
 03:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
 <CAJZ5v0gvQjp_P-5Ww7iN1cGiiMJ6tvLLnPpkTQNk++KhoRe=GA@mail.gmail.com>
 <CAPDyKFrBO+r8qYRrhoFZN21__8RuR61ofbsGQZbA=pyQbti5CA@mail.gmail.com> <CAJZ5v0jTutgKeXtg3YLR1Onw9gOmvHudHamVVgMxEsieNDXViw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jTutgKeXtg3YLR1Onw9gOmvHudHamVVgMxEsieNDXViw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Jan 2025 12:11:02 +0100
X-Gm-Features: AWEUYZlrH6ze7xs6-nI2ghaTzurC1qj8MdXzoQItOKZMS_3rvaL1L_OdE15S0yQ
Message-ID: <CAPDyKFpmNPhyV3YoBFu7KnW04550DQgqzGHAbGLLqp7=TggVtw@mail.gmail.com>
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

On Wed, 29 Jan 2025 at 17:58, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 29, 2025 at 5:42=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Wed, 29 Jan 2025 at 16:55, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Wed, Jan 29, 2025 at 12:53=E2=80=AFPM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > >
> > > > On Tue, 28 Jan 2025 at 20:24, Rafael J. Wysocki <rjw@rjwysocki.net>=
 wrote:
> > > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in t=
he
> > > > > resume phase") overlooked the case in which the parent of a devic=
e with
> > > > > DPM_FLAG_SMART_SUSPEND set did not use that flag and could be run=
time-
> > > > > suspended before a transition into a system-wide sleep state.  In=
 that
> > > > > case, if the child is resumed during the subsequent transition fr=
om
> > > > > that state into the working state, its runtime PM status will be =
set to
> > > > > RPM_ACTIVE, but the runtime PM status of the parent will not be u=
pdated
> > > > > accordingly, even though the parent will be resumed too, because =
of the
> > > > > dev_pm_skip_suspend() check in device_resume_noirq().
> > > > >
> > > > > Address this problem by tracking the need to set the runtime PM s=
tatus
> > > > > to RPM_ACTIVE during system-wide resume transitions for devices w=
ith
> > > > > DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by =
them.
> > > > >
> > > > > Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in t=
he resume phase")
> > > > > Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldc=
onsulting.com/
> > > > > Reported-by: Johan Hovold <johan@kernel.org>
> > > > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.or=
g>
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  drivers/base/power/main.c |   29 ++++++++++++++++++++---------
> > > > >  include/linux/pm.h        |    1 +
> > > > >  2 files changed, 21 insertions(+), 9 deletions(-)
> > > > >
> > > > > --- a/drivers/base/power/main.c
> > > > > +++ b/drivers/base/power/main.c
> > > > > @@ -656,13 +656,15 @@
> > > > >          * so change its status accordingly.
> > > > >          *
> > > > >          * Otherwise, the device is going to be resumed, so set i=
ts PM-runtime
> > > > > -        * status to "active", but do that only if DPM_FLAG_SMART=
_SUSPEND is set
> > > > > -        * to avoid confusing drivers that don't use it.
> > > > > +        * status to "active" unless its power.set_active flag is=
 clear, in
> > > > > +        * which case it is not necessary to update its PM-runtim=
e status.
> > > > >          */
> > > > > -       if (skip_resume)
> > > > > +       if (skip_resume) {
> > > > >                 pm_runtime_set_suspended(dev);
> > > > > -       else if (dev_pm_skip_suspend(dev))
> > > > > +       } else if (dev->power.set_active) {
> > > > >                 pm_runtime_set_active(dev);
> > > > > +               dev->power.set_active =3D false;
> > > > > +       }
> > > > >
> > > > >         if (dev->pm_domain) {
> > > > >                 info =3D "noirq power domain ";
> > > > > @@ -1189,18 +1191,24 @@
> > > > >         return PMSG_ON;
> > > > >  }
> > > > >
> > > > > -static void dpm_superior_set_must_resume(struct device *dev)
> > > > > +static void dpm_superior_set_must_resume(struct device *dev, boo=
l set_active)
> > > > >  {
> > > > >         struct device_link *link;
> > > > >         int idx;
> > > > >
> > > > > -       if (dev->parent)
> > > > > +       if (dev->parent) {
> > > > >                 dev->parent->power.must_resume =3D true;
> > > > > +               if (set_active)
> > > > > +                       dev->parent->power.set_active =3D true;
> > > > > +       }
> > > > >
> > > > >         idx =3D device_links_read_lock();
> > > > >
> > > > > -       list_for_each_entry_rcu_locked(link, &dev->links.supplier=
s, c_node)
> > > > > +       list_for_each_entry_rcu_locked(link, &dev->links.supplier=
s, c_node) {
> > > > >                 link->supplier->power.must_resume =3D true;
> > > > > +               if (set_active)
> > > > > +                       link->supplier->power.set_active =3D true=
;
> > > >
> > > > If I understand correctly, the suppliers are already handled when t=
he
> > > > pm_runtime_set_active() is called for consumers, so the above shoul=
d
> > > > not be needed.
> > >
> > > It is needed because pm_runtime_set_active() doesn't cause the settin=
g
> > > to propagate to the parent's/suppliers of the suppliers AFAICS.
> >
> > Hmm, even if that sounds reasonable, I don't think it's a good idea as
> > it may introduce interesting propagation problems between drivers.
> >
> > For example, consider that Saravana is trying to enable runtime PM for
> > fw_devlinks. It would mean synchronization issues for the runtime PM
> > status, all over the place.
>
> What synchronization issues?

Changing the runtime PM status for a parent/supplier that doesn't have
DPM_FLAG_SMART_SUSPEND, is likely to confuse their drivers.

You also removed that part of the comment a few lines above, in
device_resume_noirq(). I am not sure I understand why?

>
> > That said, is even consumer/suppliers part of the problem we are
> > trying to solve?
>
> They are in general.
>
> It's just that stuff that was runtime-suspended prior to a system-wide
> suspend may need to be resumed and marked as RPM_ACTIVE during
> system-wide resume because one of the devices wants/needs to be
> resumed then.
>
> If this turns out to be problematic, the problem will need to be
> addressed, but for now I'm not seeing why there would be a problem.
>
> > >
> > > > That said, maybe we instead allow parent/child to work in the simil=
ar
> > > > way as for consumer/suppliers, when pm_runtime_set_active() is call=
ed
> > > > for the child. In other words, when pm_runtime_set_active() is call=
ed
> > > > for a child and the parent is runtime PM enabled, let's runtime res=
ume
> > > > it too, as we do for suppliers. Would that work, you think?
> > >
> > > The parent is not runtime-PM enabled when this happens.
> >
> > That sounds really weird to me.
> >
> > Does that mean that the parent has not been system resumed either?
>
> Yes.
>
> It hasn't been resumed yet, but it is known that it will be resumed.
>
> > If so, isn't that really the root cause for this problem,
>
> No, it is not.
>
> > or what am I missing?
>
> Essentially, what I said above.
>
> If a device that was suspended prior to a system-wide suspend
> wants/needs to be resumed during the subsequent system-wide resume,
> and it was runtime-PM-enabled before the suspend transition, it needs
> to (a) be runtime-PM-enabled during the subsequent system-wide resume
> transition and (b) it also needs to be marked as RPM_ACTIVE because in
> fact it is not suspended any more.  The existing code before the patch
> takes care of this for the device itself, but not for the devices it
> depends on which also need to be resumed (which happens) and marked as
> RPM_ACTIVE (which doesn't happen) and the patch just makes sure that
> the latter will happen.

Thanks for clarifying!

>
> Actually, what happens now is that the actual state of the parent
> during the system-wide resume, right before re-enabling runtime PM for
> it, does not match its runtime PM status which is still RPM_SUSPENDED.
> That's what is fixed here and it applies to the parent as well as to
> all of the other devices depended on by the child and the parent.

Well, unfortunately I don't think it will work to call
pm_runtime_set_active() for parents/suppliers like this.

I think we need the drivers for the parents/suppliers to be in
agreement with the behaviour of DPM_FLAG_SMART_SUSPEND to allow the
propagation. Not sure how to best achieve this though.

Kind regards
Uffe

