Return-Path: <linux-pm+bounces-37866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DFC53CBB
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 409C1342ABF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926AC34846A;
	Wed, 12 Nov 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6Ey7N2D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BD347FCC
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969927; cv=none; b=gEw1BUDvrAIzmgqt4rvM0R4f3p4FhjaoOKP1lH0E7nFW+ZqnM3UT+c6lUG/Ih4/nbsiQzF5oHTP2lSatXgtrdPIfNj6uDxWvyvqvSsJmkw9kCuDxYHR7f4n05/Tp3niAU2hjorFw+zIdWmc6H3C6BmqFOZmPQ0TcJqZTZo4Bt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969927; c=relaxed/simple;
	bh=IEvwMKkKXtZ0S5o2YnRCpT0QBAI9Zo4ZHkRNv970Q+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3yiePO1D968MAub2n5mFun59jmK85rlQAdwiktKhFTQeMTgN7gZo02YjZ05Yez6ADSBJkLTbrTdIK6oCvIBadBFcobjThUM/zRD8BSen7gTskyOvqIuwWkPXvNGvuqibD/UX6zEVT+SotHzyfDRKLPI6GxyoW48APuj2wqSMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6Ey7N2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA39C113D0
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762969924;
	bh=IEvwMKkKXtZ0S5o2YnRCpT0QBAI9Zo4ZHkRNv970Q+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h6Ey7N2Dz0N09gbUnbQtTRYZm0ZpQ6CNs+eduayJEcpDjOLSRtE+Ofw4n+kJDU6Ns
	 LftgSsgwGQXB+IatSMMRM02wGfNuiOxbzZuGv4YpLk0Q4g9M+s1lzzbeu7iLJvC3hP
	 VYjVkTRPaRFhPAY6Fy9jKvIEUcuzdIgfc2o/BxQ2gagt48cATBpAVSulqfRypCky4p
	 CBLb43iTFJ0w1E0bJggHRnbwI+Q9slzbMzKjzul7bp2KFH+eOeN313kj6ZXW/t+KVo
	 KIkNejazCZUql0Ln9zQ7/fEuoWx7+XUfMRPXOGy99+pyWx3HPXTksOVEeRH2JvGntC
	 bqzZSzqdZ6VbA==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c28ff7a42eso289328a34.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 09:52:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxwLSWglIaMGEQbiJnj5v2/Drho8UGr4PkRT+kLNufNQ5fBawRluFJsef4oA4D9W01iC7aYSIbrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zzuZooihXMlALn9eySpTioCYLnjX1tNAQp8UYSCEkuBIICiR
	xIZGxxzyYLp9Oh+STmGkA1aqbsuq4meXPgpHEzJL+SqU/BmHhaRv9J22kjeGV5Bcovmqq+HndEB
	B1LkYIOcQDZ+wm4FwQfVGHLKb5AFSKhY=
X-Google-Smtp-Source: AGHT+IFR3hyHgNt26OFh3wUxHI3FcE3zfaO/9A+tZKXN7bAZKVmFPcjRr/ln/hl75qJgJjehtDvvoMd+IZEGWc3HOrw=
X-Received: by 2002:a05:6808:2207:b0:44f:eb07:5042 with SMTP id
 5614622812f47-450745a8dd0mr1455737b6e.44.1762969924233; Wed, 12 Nov 2025
 09:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <3396811.44csPzL39Z@rafael.j.wysocki>
 <a5de1eca-494e-4624-a86b-bf917e562a08@arm.com>
In-Reply-To: <a5de1eca-494e-4624-a86b-bf917e562a08@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 18:51:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jcGsFh1ATM-Aw1oxZy-zazm+GaMUC4gwEaCskn9V-amg@mail.gmail.com>
X-Gm-Features: AWmQ_bmgEEYg_K8uXr1lAtgFDVf8su_16ZHt58HqVct8RHZz6xjsFZ1f5ysnV7Q
Message-ID: <CAJZ5v0jcGsFh1ATM-Aw1oxZy-zazm+GaMUC4gwEaCskn9V-amg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] cpuidle: governors: teo: Decay metrics below
 DECAY_SHIFT threshold
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 6:29=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/12/25 16:25, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If a given governor metric falls below a certain value (8 for
> > DECAY_SHIFT equal to 3), it will not decay any more due to the
> > simplistic decay implementation.  This may in some cases lead to
> > subtle inconsistencies in the governor behavior, so change the
> > decay implementation to take it into account and set the metric
> > at hand to 0 in that case.
> >
> > Suggested-by: Christian Loehle <christian.loehle@arm.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |   20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -148,6 +148,16 @@ struct teo_cpu {
> >
> >  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> >
> > +static void teo_decay(unsigned int *metric)
> > +{
> > +     unsigned int delta =3D *metric >> DECAY_SHIFT;
> > +
> > +     if (delta)
> > +             *metric -=3D delta;
> > +     else
> > +             *metric =3D 0;
> > +}
> > +
> >  /**
> >   * teo_update - Update CPU metrics after wakeup.
> >   * @drv: cpuidle driver containing state data.
> > @@ -159,7 +169,7 @@ static void teo_update(struct cpuidle_dr
> >       int i, idx_timer =3D 0, idx_duration =3D 0;
> >       s64 target_residency_ns, measured_ns;
> >
> > -     cpu_data->short_idles -=3D cpu_data->short_idles >> DECAY_SHIFT;
> > +     teo_decay(&cpu_data->short_idles);
> >
> >       if (cpu_data->artificial_wakeup) {
> >               /*
> > @@ -195,8 +205,8 @@ static void teo_update(struct cpuidle_dr
> >       for (i =3D 0; i < drv->state_count; i++) {
> >               struct teo_bin *bin =3D &cpu_data->state_bins[i];
> >
> > -             bin->hits -=3D bin->hits >> DECAY_SHIFT;
> > -             bin->intercepts -=3D bin->intercepts >> DECAY_SHIFT;
> > +             teo_decay(&bin->hits);
> > +             teo_decay(&bin->intercepts);
> >
> >               target_residency_ns =3D drv->states[i].target_residency_n=
s;
> >
> > @@ -207,7 +217,7 @@ static void teo_update(struct cpuidle_dr
> >               }
> >       }
> >
> > -     cpu_data->tick_intercepts -=3D cpu_data->tick_intercepts >> DECAY=
_SHIFT;
> > +     teo_decay(&cpu_data->tick_intercepts);
> >       /*
> >        * If the measured idle duration falls into the same bin as the s=
leep
> >        * length, this is a "hit", so update the "hits" metric for that =
bin.
> > @@ -222,7 +232,7 @@ static void teo_update(struct cpuidle_dr
> >                       cpu_data->tick_intercepts +=3D PULSE;
> >       }
> >
> > -     cpu_data->total -=3D cpu_data->total >> DECAY_SHIFT;
> > +     teo_decay(&cpu_data->total);
> >       cpu_data->total +=3D PULSE;
>
> This will result in total no longer being a strict sum of the bins.

Ah, good point.

> Any reason not to do something like:

Well, it would be more straightforward to just compute "total" from
scratch instead of using total_decay (it would be the same amount of
computation minus the teo_decay() changes AFAICS).

I'll send an update of this patch.

