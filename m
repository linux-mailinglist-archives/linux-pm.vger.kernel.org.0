Return-Path: <linux-pm+bounces-41693-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ9iCChfe2kdEQIAu9opvQ
	(envelope-from <linux-pm+bounces-41693-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 14:22:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312EB0582
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 14:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAB23011C48
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB920E023;
	Thu, 29 Jan 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwnRyGc2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E71F09A8
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692913; cv=none; b=KSsqnCvcK+SHiI7DTUlrZXSXWsRM9aLE9D+EPMN0i83PBGH/O1L3qp2bxyb2aD1Q0Nmm7WpfXkI7wZHnP1XjG/0+llCExMjSfJH9PEqbh+/1tc6QOHZOZtQV6pR7C/iRe+t76uUxx1syW38cCSVGJJb90H6DGvwphH31uXDhfG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692913; c=relaxed/simple;
	bh=cM0yGEQCeQZTosrh3kAkD07fbfLpEZ0F7FA8/6PnHoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8C7jYhXZxP8tRQz/QAKGt17yTXaLcSOPiNNgmW/hvoygNH2gfZshG3wi2X6gDeSBgNWcppcDmyeR+E8DfI7OOt6SbSuzl199/lmLkFXGWR+VQTuy6kZbfAPq5DEywsgrr/CcNC0wnI8BMv+GAAZVx1hIu8hI305ydGyl4kVmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwnRyGc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D1BC4CEF7
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 13:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769692913;
	bh=cM0yGEQCeQZTosrh3kAkD07fbfLpEZ0F7FA8/6PnHoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EwnRyGc2UFDxui+xd4xS+ROTYAhzEFsu+yh/mkJmpmJkjZv9DzdInrtvyhQnOG/fu
	 +PTDvUx81FxNmx2UnA9FXG5maztb7vT8nimpvAxlockd7JTMCuN6UubI4kL8KiqGYc
	 P2OxkNKAaOs5BLvjlxlFzT8qzDeqHzwyVYIUYQC7dTRL7W56ihJkt61d4pRoPxqirA
	 x0WhqeEtRLA/Wr8kskb3yKJI8+rLeikWCPkb81Xr9BiYJpcRUsbCMjHEpNID2deIlS
	 Yi2IZJFKIvL2g/RGooDy01tS/iCCmV+cHw8op77mq2m+dJT8MIpm9M1oHrBBy58fBF
	 fPQZ1vmBzpdoQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-409521ba360so556981fac.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 05:21:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVj+m3pXzuOIwSpTFJfcpFBYO/yMcN0apqiMG6z4JfqvCoYcdR3V8c8IxJEjhPu2GZ5oUWtFVvupw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIxfvSu+dN1etCWeCk0uuNxLkXwqyh3dPykPigO/x15HXqvnQ
	9Atz+NdXqm+1LtlYPdczmYA279nPTuLg8Lih6P6IMS5+pAAnXs4aTDMo7p0/TVWVJOVCqOavYZ3
	1rU7ejNpmEOo9oJsz0PNMk3kpP1yZJfc=
X-Received: by 2002:a05:6820:80c7:b0:65b:26c8:d9e7 with SMTP id
 006d021491bc7-662f204543cmr4751428eaf.31.1769692912223; Thu, 29 Jan 2026
 05:21:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12831359.O9o76ZdvQC@rafael.j.wysocki> <1951534.tdWV9SEqCh@rafael.j.wysocki>
 <a44aa54e-cfcf-4f3f-a832-da09cd9be70e@arm.com>
In-Reply-To: <a44aa54e-cfcf-4f3f-a832-da09cd9be70e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Jan 2026 14:21:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iBiqfa=JV5w=2hAFVkz=ZCgQk9uOMBfqfY80dN7+DSNg@mail.gmail.com>
X-Gm-Features: AZwV_Qgozf4IFZyX_NA3NlGyS4vPn6m6WSo9XDAzzQaOYhUZOCksCEq0kDweGgo
Message-ID: <CAJZ5v0iBiqfa=JV5w=2hAFVkz=ZCgQk9uOMBfqfY80dN7+DSNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpuidle: governors: teo: Refine intercepts-based
 idle state lookup
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41693-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 7312EB0582
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:19=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/26/26 19:51, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are cases in which decisions made by the teo governor are
> > arguably overly conservative.
> >
> > For instance, suppose that there are 4 idle states and the values of
> > the intercepts metric for the first 3 of them are 400, 250, and 251,
> > respectively.  If the total sum computed in teo_update() is 1000, the
> > governor will select idle state 1 (provided that all idle states are
> > enabled and the scheduler tick has not been stopped) although arguably
> > idle state 0 would be a better choice because the likelihood of getting
> > an idle duration below the target residency of idle state 1 is greater
> > than the likelihood of getting an idle duration between the target
> > residency of idle state 1 and the target residency of idle state 2.
> >
> > To address this, refine the candidate idle state lookup based on
> > intercepts to start at the state with the maximum intercepts metric,
> > below the deepest enabled one, to avoid the cases in which the search
> > may stop before reaching that state.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    * Multiple fixes related to the handling of cases in which some stat=
es
> >      are disabled.
> >    * Fixes in new comments (there was some confusion in those comments
> >      regarding the direction of idle states table traversal).
> >    * Fixed typos in new comments.
> >
> > ---
> >  drivers/cpuidle/governors/teo.c |   50 +++++++++++++++++++++++++++++++=
+++------
> >  1 file changed, 43 insertions(+), 7 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -73,12 +73,17 @@
> >   *      than the candidate one (it represents the cases in which the C=
PU was
> >   *      likely woken up by a non-timer wakeup source).
> >   *
> > + *    Also find the idle state with the maximum intercepts metric (if =
there are
> > + *    multiple states with the maximum intercepts metric, choose the o=
ne with
> > + *    the highest index).
> > + *
> >   * 2. If the second sum computed in step 1 is greater than a half of t=
he sum of
> >   *    both metrics for the candidate state bin and all subsequent bins=
 (if any),
> >   *    a shallower idle state is likely to be more suitable, so look fo=
r it.
> >   *
> >   *    - Traverse the enabled idle states shallower than the candidate =
one in the
> > - *      descending order.
> > + *      descending order, starting at the state with the maximum inter=
cepts
> > + *      metric found in step 1.
> >   *
> >   *    - For each of them compute the sum of the "intercepts" metrics o=
ver all
> >   *      of the idle states between it and the candidate one (including=
 the
> > @@ -307,8 +312,10 @@ static int teo_select(struct cpuidle_dri
> >       ktime_t delta_tick =3D TICK_NSEC / 2;
> >       unsigned int idx_intercept_sum =3D 0;
> >       unsigned int intercept_sum =3D 0;
> > +     unsigned int intercept_max =3D 0;
> >       unsigned int idx_hit_sum =3D 0;
> >       unsigned int hit_sum =3D 0;
> > +     int intercept_max_idx =3D -1;
> >       int constraint_idx =3D 0;
> >       int idx0 =3D 0, idx =3D -1;
> >       s64 duration_ns;
> > @@ -339,17 +346,32 @@ static int teo_select(struct cpuidle_dri
> >       if (!dev->states_usage[0].disable)
> >               idx =3D 0;
> >
> > -     /* Compute the sums of metrics for early wakeup pattern detection=
. */
> > +     /*
> > +      * Compute the sums of metrics for early wakeup pattern detection=
 and
> > +      * look for the state bin with the maximum intercepts metric belo=
w the
> > +      * deepest enabled one (if there are multiple states with the max=
imum
> > +      * intercepts metric, choose the one with the highest index).
> > +      */
> >       for (i =3D 1; i < drv->state_count; i++) {
> >               struct teo_bin *prev_bin =3D &cpu_data->state_bins[i-1];
> > +             unsigned int prev_intercepts =3D prev_bin->intercepts;
> >               struct cpuidle_state *s =3D &drv->states[i];
> >
> >               /*
> >                * Update the sums of idle state metrics for all of the s=
tates
> >                * shallower than the current one.
> >                */
> > -             intercept_sum +=3D prev_bin->intercepts;
> >               hit_sum +=3D prev_bin->hits;
> > +             intercept_sum +=3D prev_intercepts;
> > +             /*
> > +              * Check if this is the bin with the maximum number of
> > +              * intercepts so far and in that case update the index of
> > +              * the state with the maximum intercepts metric.
> > +              */
> > +             if (prev_intercepts >=3D intercept_max) {
> > +                     intercept_max =3D prev_intercepts;
> > +                     intercept_max_idx =3D i - 1;
> > +             }
> >
> >               if (dev->states_usage[i].disable)
> >                       continue;
> > @@ -413,9 +435,22 @@ static int teo_select(struct cpuidle_dri
> >               }
> >
> >               /*
> > -              * Look for the deepest idle state whose target residency=
 had
> > -              * not exceeded the idle duration in over a half of the r=
elevant
> > -              * cases in the past.
> > +              * If the minimum state index is greater than or equal to=
 the
> > +              * index of the state with the maximum intercepts metric =
and
> > +              * the corresponding state is enabled, there is no need t=
o look
> > +              * at the deeper states.
> > +              */
> > +             if (min_idx >=3D intercept_max_idx &&
> > +                 !dev->states_usage[min_idx].disable) {
> > +                     idx =3D min_idx;
> > +                     goto constraint;
> > +             }
> > +
> > +             /*
> > +              * Look for the deepest enabled idle state, at most as de=
ep as
> > +              * the one with the maximum intercepts metric, whose targ=
et
> > +              * residency had not been greater than the idle duration =
in over
> > +              * a half of the relevant cases in the past.
> >                *
> >                * Take the possible duration limitation present if the t=
ick
> >                * has been stopped already into account.
> > @@ -427,7 +462,8 @@ static int teo_select(struct cpuidle_dri
> >                               continue;
> >
> >                       idx =3D i;
> > -                     if (2 * intercept_sum > idx_intercept_sum)
> > +                     if (2 * intercept_sum > idx_intercept_sum &&
> > +                         i <=3D intercept_max_idx)
>
> Should this be i >=3D intercept_max_idx?

No, the point is to get to intercept_max_idx, or below it if it is
disabled (note that i is decremented in each step of the loop, so i
cannot be greater than intercept_max_idx if its initial value isn't).

> >                               break;
> >               }
> >       }
> >
> >
> >
>
>

