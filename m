Return-Path: <linux-pm+bounces-20511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEEEA12D6A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 22:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B22165B89
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 21:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F431DAC97;
	Wed, 15 Jan 2025 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR7lN8KT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D61D63E8;
	Wed, 15 Jan 2025 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975423; cv=none; b=QDtR5t5EX1w1fr8ZxVPxFx+9Cs2WZgzc+FwGtx/ZOwXvEkN75c8ozagmkNcwoDkG6gRT48xtXBiLEt5cSk3Xq+Y09jsJhWHAgKBAelYXBJ4WTVmgYOFguV9znLnIGD1EjDQRYV45gfhLiJiY89Ba3cWvbkBsKjIzeXmFAT9GcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975423; c=relaxed/simple;
	bh=zP8ZYkjMOLm0Pwvv+BfFGRWiYBtSUPW/EsvdFBprqgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xrm91fpThV1BGwbeKpRfLrSnPOXG9JePtVfpU+/ReBfOFqG1k/CV+LsEzgxTp92W21Z8Xki6Z7WZTzNjmUh13GVRYLlw+Vuvq0Yxd9S6tM8l2N5/Oue7jsYY6sLTpyvHyf8sw/nEHpspnAnnq58wUbRp8ObRzqQdcegwe8UMZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR7lN8KT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3FCC4CEE3;
	Wed, 15 Jan 2025 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736975423;
	bh=zP8ZYkjMOLm0Pwvv+BfFGRWiYBtSUPW/EsvdFBprqgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PR7lN8KTp5uu3l0VctcX88rwTN9CgTi5/BSP0dXBle3xYHmMAj91T10FjZWcFeN5H
	 eYIHBzNsKz6/KW+DoCREGz/s3aB1cJNchiEWrH2EYJsrc9xAELjeXZ+sy5PtLJXHM+
	 efM3MaWtrXJzryLYW0i4sLEpl5/Ig4mF6JDGPalx+lby1xpaGTWvBWlKa0MneS5ZBt
	 HF6cOZeG/gdGrUMWy+RllBQPPfqJ3I2lYLcdqsPeqsViT8R7I4HEHBgRHeJu1PP5uZ
	 /wn/aR6D5ndsQB8CPezwIir13ejNK7YR9s2vMEAVdv25ivGJZ+clBEhcBUWuRjjjtd
	 ud4gTEUG1yWBw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29fb532b668so97706fac.0;
        Wed, 15 Jan 2025 13:10:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmgqHKUtdMqgcgWiyevQGZua0Ebjqrb4ObtK4n6xGtDRn7C+3JoCRe14Y5+lhUCmWjoBg0t70z0/f7F54=@vger.kernel.org, AJvYcCXpb0kTsgWUsiLpGtJ6CkDGJc+2UWm/Z4iLYDwM49X9MDUxYsKlhPrC4gENmvR8enJPDAeYF2a5SkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxey7R4UHf90LPalG0G83y85fUBc+LxPrPLHpF798TaTmsChnZE
	YRi6idv/Qm3yIm6DfDLpNINnk1x5KwaZiv256XV+XzOyw6RTLjaNmd5KPDey4QZ6dUk2LwtWUex
	UvSXaXrbvSdfEcn7BS1rljQK7GSU=
X-Google-Smtp-Source: AGHT+IHsgpyuC09pA3K+hw6CRAmmmI8I3xMjjerA/+uNeMkinmC8Qd7B5n5FCsApeDn8XfhSun+7ITECLqwQjTI7Hk4=
X-Received: by 2002:a05:6871:aa12:b0:288:563b:e48d with SMTP id
 586e51a60fabf-2aa066b475amr17013060fac.10.1736975422502; Wed, 15 Jan 2025
 13:10:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6116275.lOV4Wx5bFT@rjwysocki.net> <1907276.tdWV9SEqCh@rjwysocki.net>
 <8959e72a-600d-427a-9ab2-54f14b056766@arm.com> <CAJZ5v0iVOg5CnYo8OQ5E8VGLdn4cvVdFFQqpOgpWvij4a4cdxQ@mail.gmail.com>
 <a44d8a62-8753-4efb-8c3a-f9c3cdc1dabc@arm.com> <CAJZ5v0g2CxmFB3Js09jKk=ym26oEGVUsr5tM2p2vpPU_bczjmA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g2CxmFB3Js09jKk=ym26oEGVUsr5tM2p2vpPU_bczjmA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jan 2025 22:10:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gr5CTM+p4dvAywuNyxLfE6MW7WWFu7wajCazMPodEvvg@mail.gmail.com>
X-Gm-Features: AbW1kvbmGzI-FpdE_OUGcPN_dQPpvncF6uKjAtj9WrtARqPG9rZvY2Nb3EVdy_U
Message-ID: <CAJZ5v0gr5CTM+p4dvAywuNyxLfE6MW7WWFu7wajCazMPodEvvg@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] cpuidle: teo: Reorder candidate state index checks
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:48=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Jan 15, 2025 at 8:20=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 1/15/25 15:54, Rafael J. Wysocki wrote:
> > > On Wed, Jan 15, 2025 at 3:46=E2=80=AFPM Christian Loehle
> > > <christian.loehle@arm.com> wrote:
> > >>
> > >> On 1/13/25 18:36, Rafael J. Wysocki wrote:
> > >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>>
> > >>> Since constraint_idx may be 0, the candidate state index may change=
 to 0
> > >>> after assigning constraint_idx to it, so first check if it is great=
er
> > >>> than constraint_idx (and update it if so) and then check it against=
 0.
> > >>
> > >> So the reason I've left this where it was is because the prev_interc=
ept_idx
> > >> was supposed to query the sleep length if we're in an majority-inter=
cept
> > >> period and then it makes sense to query the sleep length (to detect =
such
> > >> a period being over).
> > >> A constraint_idx =3D=3D 0 scenario doesn't need the intercept-machin=
ery to
> > >> work at all, why are we querying the sleep length then?
> > >
> > > In case the constraint is different next time and it's better to know
> > > the sleep length to properly classify the wakeup.
> >
> > I would hope constraints change nowhere near as frequently as
> > idle entry / exit happen, is your experience different?
>
> They don't, but they may change at any time and it is kind of good to
> have history in case this happens.
>
> > >
> > >>>
> > >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>> ---
> > >>>
> > >>> This is a rebased variant of
> > >>>
> > >>> https://lore.kernel.org/linux-pm/8476650.T7Z3S40VBb@rjwysocki.net/
> > >>>
> > >>> ---
> > >>>  drivers/cpuidle/governors/teo.c |   15 ++++++++-------
> > >>>  1 file changed, 8 insertions(+), 7 deletions(-)
> > >>>
> > >>> --- a/drivers/cpuidle/governors/teo.c
> > >>> +++ b/drivers/cpuidle/governors/teo.c
> > >>> @@ -428,6 +428,14 @@
> > >>>                               break;
> > >>>               }
> > >>>       }
> > >>> +
> > >>> +     /*
> > >>> +      * If there is a latency constraint, it may be necessary to s=
elect an
> > >>> +      * idle state shallower than the current candidate one.
> > >>> +      */
> > >>> +     if (idx > constraint_idx)
> > >>> +             idx =3D constraint_idx;
> > >>> +
> > >>>       if (!idx && prev_intercept_idx) {
> > >>>               /*
> > >>>                * We have to query the sleep length here otherwise w=
e don't
> > >>> @@ -439,13 +447,6 @@
> > >>>       }
> > >>>
> > >>>       /*
> > >>> -      * If there is a latency constraint, it may be necessary to s=
elect an
> > >>> -      * idle state shallower than the current candidate one.
> > >>> -      */
> > >>> -     if (idx > constraint_idx)
> > >>> -             idx =3D constraint_idx;
> > >>> -
> > >>> -     /*
> > >>
> > >> We could leave this here and just do goto end;?
> > >
> > > Why would this be better?
> >
> > Saves querying the sleep length in case of constraint_idx =3D=3D 0, i.e=
.
> > qos request to be very latency-sensitive and us actually adding latency
> > here.
>
> Fair enough, but before patch [7/9] leaving it where it is doesn't
> really cause it to skip the sleep length check unless state 0 is
> "polling".
>
> After patch [7/9] it is possible to add a constraint_idx check against
> 0 to the "goto out_tick" condition before the
> tick_nohz_get_sleep_length() call, that is
>
> if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_N=
S) &&
>     (2 * cpu_data->short_idle >=3D cpu_data->total || !constraint_idx))
>         goto out_tick;

Or even

if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS)=
 &&
    (2 * cpu_data->short_idle >=3D cpu_data->total || latency_req <
A_SMALL_VALUE))
        goto out_tick;

for that matter.

> but that would be a separate patch if you will.

