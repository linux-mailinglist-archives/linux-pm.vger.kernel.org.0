Return-Path: <linux-pm+bounces-30486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B5AFEA2F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC173AF29D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089292E54C4;
	Wed,  9 Jul 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0f0VZPw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C532E5432
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067528; cv=none; b=QsSxqyFVHIzi+4iaE8apbmKHPZAE3N6612EcI7M6amgaB3nMNPGBdhNOaD4RClP+TCs8SXbVTfYFin4TEGcSSB4U0Q0mTCLQFr+T9SnNiy5yOE+I017QOxuKFQgOyUSRrwmhO6AHc5+bV5k8eatN9/pRb7ha8mpFDwdqXs/6Lug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067528; c=relaxed/simple;
	bh=0Kt7fyGJ9S5hVGnqLvyQoR9maETa92oP1ICT/52AnNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u10QPkjYPYCq89aHdcOYzJYpnAn/ux6GQ1NO2zYa0wzgj62+zM1rQeJw/LahpkhvFxi2Z8gBNJgO6UA9Iqi8O7xrWGLoyCJHWazGdicvUEUTUKAUzLi0tjRgVDSnebvI43k1JiB6gbaRPzgH09QXj23hjnPAIAaY6tkjrUdH4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0f0VZPw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-708d90aa8f9so50945627b3.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752067526; x=1752672326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa3/IrQyBvmTYTtNd/N8HxLuoVeEFku8rfsBSVlEkKw=;
        b=f0f0VZPw7Xnel890WbvozB62aRFc70t+As4Ax+TzgKKzvK0qY0BnjGxMdxSCq+CbxN
         NN8fWW7JZnnmX/ZA8tlz5nmAsMA3HCOBZ66CZS6sYtLm1DT5NRLEaxpLO9TdEa4jZbh/
         zAofpTNUMIHwDXhRfpWVEotlxp+AkI2WeH7GkvKSBHgvfRcWIkf9yTTWgGYYMVbbzMA1
         Luw7mIDQjKcpxMagYjfmzKwOcyZMikP5lR/0KRXEnZ5EYilzBK1w3xp/7mUH72H3RCvg
         nxkpNDonuVtdx6DJjLjodMjkt7pcDMVvZIPnV5SKnImaODdaE4B2mz2jpC+9IlKpG11i
         N8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067526; x=1752672326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa3/IrQyBvmTYTtNd/N8HxLuoVeEFku8rfsBSVlEkKw=;
        b=MT5A2j14vUaVIYvugpKBsPfUpwagjU4cNaeN5SRxd1jpYIrj/Y2hKU7PfVjDtRqUSS
         B3Bj+CE7RrYXpkU2hXzk9itdNYRQCcA3xcPM2DnYn8GVPtDmsCaj4dZpTeX8WpxNxPhV
         OMb12MzgfPrSuhW2suhVdBHel4j+DVp2grGTPISmMIBl9YWxeTXP+5WtiGHXyudYjhWz
         8IWcz1jyICBaYJCnTrWnNTJulswlcGBqZlurfr1qS0RvLMUcAZcCqFqJwNTjlOpYnz03
         jYjSo4kBYNDw6Pz5Ycg09VdbttwekClTgf0ojqGkRLcpIjR2vxplHpbtM5fdOuzCSnrU
         48JA==
X-Forwarded-Encrypted: i=1; AJvYcCVI2lf/fLnLrlMTQiSMCrcA0scEIZfvLKZYizZZ66ffbQPAeyd3UCmIYCGWbG8i6gU3+BQoNZkmtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5Lglk/zXnBpT9BdpmmVukLbb2j3HLAI0iGT5rlEr6bglkKvF
	NNm4nF3ne6jh7xrh+xTficmTkiTzBBAD8otmjrG9O9jEp0+cbcdPlx91LfZ7GRbxQz6+1OtmBcm
	rbZsopHTg+ngzJSpIGrXMv1wNNIWtZhIdV1UI0iU+FA==
X-Gm-Gg: ASbGnctu4fFpiKZ/LTJd3KJSoI5iubJZIgfbllzk33SLuSXODjC5djJHQWD+byBqqlZ
	nKiJcysxuyefHgQT2yfDEujN7Wv4V22Sxb8NyyUr5pcEjT28qdmD+svVNJcn2Z8feqL9A7QZOHc
	QJrwpUbz021yu5uP11dyUz8R2rgjyo6a3hji9JoqyvEoZb
X-Google-Smtp-Source: AGHT+IFUQ6txa1Y8SDWT8eyNJEl2lGsRx5T0N8Gh9XBD/67jrCyb9nnoly91e6q8APx5gOkc74rwLzNts7Vy+2o7WLA=
X-Received: by 2002:a05:690c:3349:b0:70c:c013:f2f with SMTP id
 00721157ae682-717b1a2758amr39801867b3.35.1752067525556; Wed, 09 Jul 2025
 06:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12700973.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpGH=ZUyQ0wbkEKVLxknm59hDX6DNm9hXpuqzHCpoe-KQ@mail.gmail.com>
 <CAJZ5v0how7VXTjuxtd533zNeqKwCqnJDVVKK=Vpww_HbQkwxKw@mail.gmail.com> <CAJZ5v0isuV-HDyGCrLeFp0WFcCQoQpi9dMEbJnWrsOdvk4Bf1A@mail.gmail.com>
In-Reply-To: <CAJZ5v0isuV-HDyGCrLeFp0WFcCQoQpi9dMEbJnWrsOdvk4Bf1A@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 15:24:49 +0200
X-Gm-Features: Ac12FXwgWJz7GdJwpPBaSqY2rwe7dkrPOkMHFV_ripKLsw4BjkwqjZLt2vHONYE
Message-ID: <CAPDyKFooD2z9J0vYC0GzcoyQBsEv1PEM4tG9RiQktDGt94sAPA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Take active children into account in pm_runtime_get_if_in_use()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Alex Elder <elder@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Jul 2025 at 14:48, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jul 9, 2025 at 2:06=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Wed, Jul 9, 2025 at 1:47=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> > >
> > > On Wed, 9 Jul 2025 at 12:41, Rafael J. Wysocki <rjw@rjwysocki.net> wr=
ote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > For all practical purposes, there is no difference between the situ=
ation
> > > > in which a given device is not ignoring children and its active chi=
ld
> > > > count is nonzero and the situation in which its runtime PM usage co=
unter
> > > > is nonzero.  However, pm_runtime_get_if_in_use() will only incremen=
t the
> > > > device's usage counter and return 1 in the latter case.
> > > >
> > > > For consistency, make it do so in the former case either by adjusti=
ng
> > > > pm_runtime_get_conditional() and update the related kerneldoc comme=
nts
> > > > accordingly.
> > > >
> > > > Fixes: c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_activ=
e() usage")
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/base/power/runtime.c |   27 ++++++++++++++++++---------
> > > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > > >
> > > > --- a/drivers/base/power/runtime.c
> > > > +++ b/drivers/base/power/runtime.c
> > > > @@ -1203,10 +1203,12 @@
> > > >   *
> > > >   * Return -EINVAL if runtime PM is disabled for @dev.
> > > >   *
> > > > - * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and =
either
> > > > - * @ign_usage_count is %true or the runtime PM usage counter of @d=
ev is not
> > > > - * zero, increment the usage counter of @dev and return 1. Otherwi=
se, return 0
> > > > - * without changing the usage counter.
> > > > + * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign=
_usage_count
> > > > + * is set, or (2) @dev is not ignoring children and its active chi=
ld count is
> > > > + * nonero, or (3) the runtime PM usage counter of @dev is not zero=
, increment
> > > > + * the usage counter of @dev and return 1.
> > > > + *
> > > > + * Otherwise, return 0 without changing the usage counter.
> > > >   *
> > > >   * If @ign_usage_count is %true, this function can be used to prev=
ent suspending
> > > >   * the device when its runtime PM status is %RPM_ACTIVE.
> > > > @@ -1228,7 +1230,8 @@
> > > >                 retval =3D -EINVAL;
> > > >         } else if (dev->power.runtime_status !=3D RPM_ACTIVE) {
> > > >                 retval =3D 0;
> > > > -       } else if (ign_usage_count) {
> > > > +       } else if (ign_usage_count || (!dev->power.ignore_children =
&&
> > > > +                  atomic_read(&dev->power.child_count) > 0)) {
> > >
> > > I am not sure I understand why this is needed, sorry.
> > >
> > > If someone and somehow we have "dev->power.runtime_status =3D=3D
> > > RPM_ACTIVE", then the dev's parents/childrens and suppliers/consumers
> > > should have been reference counted correctly already.
> >
> > Sure.
> >
> > > Otherwise it should not have been possible to set the runtime_status =
to RPM_ACTIVE
> > > in the first place, right?
> >
> > Right.
> >
> > runtime_status must be RPM_ACTIVE, but pm_runtime_get_if_in_use() only
> > wants to bump it up if the device is in use in addition to that.
>
> I mean pm_runtime_get_if_in_use() only wants to bump up the device's
> usage counter if it is in use already.
>
> > So far it's been checking the usage counter only though.
>
> And the above is correct.

Aha, I understand your point now.

Comparing how a runtime resume of consumer-device-link works (it bumps
the provider's usage count), your change makes perfect sense as it
aligns the behaviour for child devices.

[...]

That said, please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

