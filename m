Return-Path: <linux-pm+bounces-20496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102EA127EC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 16:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24703166085
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694915383A;
	Wed, 15 Jan 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiYt2/pH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE924A7C3;
	Wed, 15 Jan 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956505; cv=none; b=lz8mh8/ZqvWXI6l8mN9uNgB6mtBTgsoxZcaFRtRhMPI2bztcjxHTbevEDbUcUkhlqPZWWv3Sv+Rg5mc/C9fiH6s2uSwZ6evU5l8Lf2zQH9ZbUvaKgmr44IPTAyl3tsvohmVg4+xWUxvpTKEWYv4625eXWXc4v/WUo8qZGlKf1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956505; c=relaxed/simple;
	bh=+QPiUTiSAK22ayBo/E8hcV3AUVObrjc8o5z9lxWA71s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8dYMZ7AR7vvEJ2Z9BiKlh1pWBSdrW52dqvSp3fP3YUTZ3HFjnxClr1S3IQ8V61INQ3dtC/yNv4lwrXKAufMfemoM2xM803vYrW3+9auxz5AHNlh+PuClElU6fHG52gYScMJ5R0uosjKozEWn/xrb1HWB09/dMq8WqPRSyBL4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiYt2/pH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23CAC4CEDF;
	Wed, 15 Jan 2025 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736956504;
	bh=+QPiUTiSAK22ayBo/E8hcV3AUVObrjc8o5z9lxWA71s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EiYt2/pHsTuW0AsmNH6wvfOc86c7IDCzBzbgwZeqRmOl7LLajF8o7swErKxRlQDbR
	 b6xN1Mb9O4/STBdh9nZ6SWqURj8jAGNYahxv0I8KcRg4gYQXOV6/hdSyqWjtuIukr0
	 w2hkpuAHkSmzPtLL0pVCYpyno+OiMAB81Y8SGJ7ECeWdVjpn430QN4czQBgBsRncVT
	 ZLeCKksgeS32KzEnCPXFKPCpQ2M86UFBDh7RHL3VPSSY2ebtYARHthoWnRrWliA/88
	 84libB6dqZaz+r7LU2Z2t7G2ZXDpyVDHcpmwTdl4FezTViqfeKidxLvkMGcGipekPZ
	 sDkguvZ3jbvQg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2a3939a758dso2339578fac.1;
        Wed, 15 Jan 2025 07:55:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVD4SvFeiHuGp0bnY+RJ/S/M64mCJkBM5VZj4RQt39dU99BiQsA84ck4/sZ5PMnK1xB31pV0/Q0Ku0=@vger.kernel.org, AJvYcCVeZBRFxbWoVr/gy/l/nz2oZVUO9XCgn9/5nCOtajm93zS0nv2QCbt/wrMiA4dAd13/U4jcfp8/hpT9aso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMBeDDtIm3jVvlNjTiWNtbljOdvvgv071dvvkriz5TaHG22IR
	fBo+P1b/oleWTKZ68nS6MZ27ulfqwAIrujxJTA9mnsXBgJwRhWHfzaTnRd9yDEjNVoPHV5ZsmHr
	7YoEodyrpLzeHONGax/DejS+1oCU=
X-Google-Smtp-Source: AGHT+IEvEE1AQjnGEBb9oOAF6OO9hzl851xb1B7iB3glRUngOnIZK5tFlSysC2vVROe7kf2PIpVFRP+oM4MOm9r2HeY=
X-Received: by 2002:a05:6871:80c5:b0:29d:c832:840d with SMTP id
 586e51a60fabf-2aa0699a7dbmr19065306fac.35.1736956504202; Wed, 15 Jan 2025
 07:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6116275.lOV4Wx5bFT@rjwysocki.net> <1907276.tdWV9SEqCh@rjwysocki.net>
 <8959e72a-600d-427a-9ab2-54f14b056766@arm.com>
In-Reply-To: <8959e72a-600d-427a-9ab2-54f14b056766@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jan 2025 16:54:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iVOg5CnYo8OQ5E8VGLdn4cvVdFFQqpOgpWvij4a4cdxQ@mail.gmail.com>
X-Gm-Features: AbW1kvYml30kwv_BE_IxV34fnXWUxoZyiG2hMtyEQrLXK3Qdi33cB3NsiTwvTFE
Message-ID: <CAJZ5v0iVOg5CnYo8OQ5E8VGLdn4cvVdFFQqpOgpWvij4a4cdxQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] cpuidle: teo: Reorder candidate state index checks
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 3:46=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/13/25 18:36, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since constraint_idx may be 0, the candidate state index may change to =
0
> > after assigning constraint_idx to it, so first check if it is greater
> > than constraint_idx (and update it if so) and then check it against 0.
>
> So the reason I've left this where it was is because the prev_intercept_i=
dx
> was supposed to query the sleep length if we're in an majority-intercept
> period and then it makes sense to query the sleep length (to detect such
> a period being over).
> A constraint_idx =3D=3D 0 scenario doesn't need the intercept-machinery t=
o
> work at all, why are we querying the sleep length then?

In case the constraint is different next time and it's better to know
the sleep length to properly classify the wakeup.

> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is a rebased variant of
> >
> > https://lore.kernel.org/linux-pm/8476650.T7Z3S40VBb@rjwysocki.net/
> >
> > ---
> >  drivers/cpuidle/governors/teo.c |   15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -428,6 +428,14 @@
> >                               break;
> >               }
> >       }
> > +
> > +     /*
> > +      * If there is a latency constraint, it may be necessary to selec=
t an
> > +      * idle state shallower than the current candidate one.
> > +      */
> > +     if (idx > constraint_idx)
> > +             idx =3D constraint_idx;
> > +
> >       if (!idx && prev_intercept_idx) {
> >               /*
> >                * We have to query the sleep length here otherwise we do=
n't
> > @@ -439,13 +447,6 @@
> >       }
> >
> >       /*
> > -      * If there is a latency constraint, it may be necessary to selec=
t an
> > -      * idle state shallower than the current candidate one.
> > -      */
> > -     if (idx > constraint_idx)
> > -             idx =3D constraint_idx;
> > -
> > -     /*
>
> We could leave this here and just do goto end;?

Why would this be better?

