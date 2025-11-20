Return-Path: <linux-pm+bounces-38298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE35C73A14
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 12:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96564E8F68
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BA32FA01;
	Thu, 20 Nov 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6lnjudB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537632F74F
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636853; cv=none; b=sbfl96AIjl51/RXbT9P5OVRJWbDiGdNWMmdg8Yi9YQAU7+SgloQxcs2BUAwvg7u+pX6ivT5psg/gPi1E/0W9emrLd7ybdJ3vqHNF4jFsaCfb2/L9kTSsmxfVgfQOV3Pm0sMVPOYweQQzBW/oaFW2yK9U9fQJ6laf+v3xJZ5zSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636853; c=relaxed/simple;
	bh=v11BK620Bz6rGU0RaW0JbPVejPcmqpoaHqxSWTXotwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkEGX6M0tODTf2ayQSun9Hwt9X7JmXGflHa4sREGzyOMoyVbKykpd+2R54dAoeZDOL4fs/BDurO5MRqtyWkAkKJ/i1qlFdTH9PzC2SX+7aHxwCQWMt184iYPygrCxmeALIbdcP33amazNKFciFlYO2dDM6ZhdNKVsNNLtb42s6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6lnjudB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C059C4CEF1
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 11:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763636851;
	bh=v11BK620Bz6rGU0RaW0JbPVejPcmqpoaHqxSWTXotwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O6lnjudBYty6A+gYKAqQ1HBIjCJ9V6mf8+BJAep7A27nr6PWsOxAFBylxiCjeTXr3
	 kEAQxCl3dy5Ng++E/ekn6udO8a1/ezSXL/lbsyPjv4Qp0/QF02UIwXArGRI6YXDPrJ
	 ArNB8iBl76lXJDwnLJSnv6f4kdfbWoU7L3AeJm5hFrfutoHl6lhVJcSpBcIAuN4o7T
	 TRrC8MwEcfBtZJSznl4ufImC5ihyZmLmYQ8pinzY3erAlNkqurFCq6pJfRNQGcP5fP
	 vH4a6u4E8E8offB+66T8l5y+Dl8ArJqj5qoLHuoke7LSJEzfKY27DP6sCijOCNHVY3
	 bETtJR5k0rnXQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e8819eda8bso174305fac.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 03:07:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWogmeNp4KiJorwZgNSMQWs2rojJ4ioYf0SRB/gozt/cqt4997jteNfFbqzQyTJZzerMchOgfPFuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1T42xV7XztENJLkhxRZjYd7c0pDDTopFKKWVM5/nF7KbQ52r
	WYJC8DoK+3ivk0PVg3rrfDb2RpbmtLZo1vmy2oy4DrTHv7xmqRtJJ0EVH11OLDAdnVOOl7Oda66
	vfemDzSV8dPpnU0tVvR78K/W9U2Zy4To=
X-Google-Smtp-Source: AGHT+IGBAfOdbOuNpNkFMOkFcswoemOuxkRgEc7mRe/RJ6w1WQ0FkY1P+TCWVN1UbtqSy3zV4x8eBA3XkAsmG91LKa0=
X-Received: by 2002:a05:6808:2519:b0:450:c456:10e3 with SMTP id
 5614622812f47-450ff276d3fmr1075751b6e.25.1763636850909; Thu, 20 Nov 2025
 03:07:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12810244.O9o76ZdvQC@rafael.j.wysocki> <2418792.ElGaqSPkdT@rafael.j.wysocki>
 <1fcc8368-7a21-418e-8c42-aae96272beee@arm.com>
In-Reply-To: <1fcc8368-7a21-418e-8c42-aae96272beee@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 12:07:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jYxcsBv2OJdkJcvJK_HZDxuUEUq75Dg7LdvWcU0fV5tA@mail.gmail.com>
X-Gm-Features: AWmQ_bkMtuQfH_E24XUZUfLMjXVUdUyEHe-lsOhuAT9qQPCiXZxrGI3pkgCtut8
Message-ID: <CAJZ5v0jYxcsBv2OJdkJcvJK_HZDxuUEUq75Dg7LdvWcU0fV5tA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cpuidle: governors: teo: Simplify intercepts-based
 state lookup
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 9:45=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/16/25 12:35, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Simplify the loop looking up a candidate idle state in the case when an
> > intercept is likely to occur by adding a search for the state index lim=
it
> > if the tick is stopped before it.
> >
> > First, call tick_nohz_tick_stopped() just once and if it returns true,
> > look for the shallowest state index below the current candidate one wit=
h
> > target residency at least equal to the tick period length.
> >
> > Next, simply look for a state that is not shallower than the one found
> > in the previous step and, ideally, satisfies the intercepts majority
> > condition.
>
> NIT: The ideally is a bit handwavy, maybe:
> Next, look for the deepest state that satisfies the intercepts majority
> condition but select no shallower state than the one from the previous st=
ep.
>
> Sounds a bit verbose I guess.

I'll figure out something suitable.

> >
> > Since teo_state_ok() has no callers any more after the above changes,
> > drop it.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |   62 ++++++++++---------------------=
---------
> >  1 file changed, 16 insertions(+), 46 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -256,12 +256,6 @@ static void teo_update(struct cpuidle_dr
> >       }
> >  }
> >
> > -static bool teo_state_ok(int i, struct cpuidle_driver *drv)
> > -{
> > -     return !tick_nohz_tick_stopped() ||
> > -             drv->states[i].target_residency_ns >=3D TICK_NSEC;
> > -}
> > -
> >  /**
> >   * teo_find_shallower_state - Find shallower idle state matching given=
 duration.
> >   * @drv: cpuidle driver containing state data.
> > @@ -383,7 +377,18 @@ static int teo_select(struct cpuidle_dri
> >        * better choice.
> >        */
> >       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> > -             int first_suitable_idx =3D idx;
> > +             int min_idx =3D idx0;
> > +
> > +             if (tick_nohz_tick_stopped()) {
> > +                     /*
> > +                      * Look for the shallowest idle state below the c=
urrent
> > +                      * candidate one whose target residency is not be=
low the
> > +                      * tick period length.
> > +                      */
>
> NIT: s/not below/above
> or just use >=3D in the comment?

Well, I can just say "equal to or greater than" or "at least equal to"
(slightly preferred).

> > +                     while (min_idx < idx &&
> > +                            drv->states[min_idx].target_residency_ns <=
 TICK_NSEC)
> > +                             min_idx++;
> > +             }
> >
> >               /*
> >                * Look for the deepest idle state whose target residency=
 had
> > @@ -393,49 +398,14 @@ static int teo_select(struct cpuidle_dri
> >                * Take the possible duration limitation present if the t=
ick
> >                * has been stopped already into account.
> >                */
> > -             intercept_sum =3D 0;
> > -
> > -             for (i =3D idx - 1; i >=3D 0; i--) {
> > -                     struct teo_bin *bin =3D &cpu_data->state_bins[i];
> > -
> > -                     intercept_sum +=3D bin->intercepts;
> > -
> > -                     if (2 * intercept_sum > idx_intercept_sum) {
> > -                             /*
> > -                              * Use the current state unless it is too
> > -                              * shallow or disabled, in which case tak=
e the
> > -                              * first enabled state that is deep enoug=
h.
> > -                              */
> > -                             if (teo_state_ok(i, drv) &&
> > -                                 !dev->states_usage[i].disable) {
> > -                                     idx =3D i;
> > -                                     break;
> > -                             }
> > -                             idx =3D first_suitable_idx;
> > -                             break;
> > -                     }
> > +             for (i =3D idx - 1, intercept_sum =3D 0; i >=3D min_idx; =
i--) {
> > +                     intercept_sum +=3D cpu_data->state_bins[i].interc=
epts;
> >
> >                       if (dev->states_usage[i].disable)
> >                               continue;
> >
> > -                     if (teo_state_ok(i, drv)) {
> > -                             /*
> > -                              * The current state is deep enough, but =
still
> > -                              * there may be a better one.
> > -                              */
> > -                             first_suitable_idx =3D i;
> > -                             continue;
> > -                     }
> > -
> > -                     /*
> > -                      * The current state is too shallow, so if no sui=
table
> > -                      * states other than the initial candidate have b=
een
> > -                      * found, give up (the remaining states to check =
are
> > -                      * shallower still), but otherwise the first suit=
able
> > -                      * state other than the initial candidate may tur=
n out
> > -                      * to be preferable.
> > -                      */
> > -                     if (first_suitable_idx =3D=3D idx)
> > +                     idx =3D i;
> > +                     if (2 * intercept_sum > idx_intercept_sum)
> >                               break;
> >               }
> >       }
>
> Thanks, that is indeed a nice simplification. I'll get test results out o=
n Monday,
> sorry!

No worries.

> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks!

