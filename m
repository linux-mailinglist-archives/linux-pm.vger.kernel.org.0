Return-Path: <linux-pm+bounces-41793-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIFCMV7xfGndPQIAu9opvQ
	(envelope-from <linux-pm+bounces-41793-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 18:58:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66228BD8D9
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 18:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 078F8300B981
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FD436920F;
	Fri, 30 Jan 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8OKHTmh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E30366544
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795926; cv=none; b=p6OqP+3occtFSXmoHxrOIQNCwW9TLoNzhrVNKfWEb/n6xcRsW34MaA0qTHPTdvIr4CaDsYFYDyHoo7yktq3U/NktZ06IYmKWqtjUkhOlyeFUqR+FdicdHVYN18cAnzWCjOZxRRScucal4bry3bVLDmTvbFaeQytMUm93KeQEwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795926; c=relaxed/simple;
	bh=+KSVTUnYEOh8TA6ZyISuddwNrjkZYIxVcOeuULbRfr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/N+dgJUcfcZZ7LtH84LFEc/TjwShdB6oEhgd/JA1yh6HCD37QXbBkW0bVuvn5T9/1+pZ/TI2aS2Er5JWEMXTrs9tNbijCW3R3maVF5ndKuV+Pho0g/PDO7E7C5oiEVBOVHp22Ul4o0UNkB1syy+jao0UUVghJKIzXPBtgNXg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8OKHTmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B51C116C6
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769795925;
	bh=+KSVTUnYEOh8TA6ZyISuddwNrjkZYIxVcOeuULbRfr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H8OKHTmhf72KKRMTnaromBU2woQaQgCNQ9dI7Pti2+YWjs77OrYFeBU6d0xYPA1MN
	 VsOpy57I8JoZSg6wE69xWEpibsJU4IuOmFVlI+8Rgclwnp+boOMi1P+Le7pcrE/9jR
	 WBVMl4FPZdGAm52kvM/7QbY1roietRFEIrOPUd8ovTbAWfTT4ImQZf5e4fCn9UEnKG
	 p1OLB/ou6XWSWKEaW1fbG5uJv65kCpptWfoA6jqOGtTS7vDdoOvXF0NSEiF0Ev5ARH
	 ACDQ0ujq/Eoa435cz7pMhNfEyk0er3qphTCvtndRJuAd6LzAJgmzg6hEkrnKRmwWF2
	 ddqvsJXdFKteA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4043eea60a3so1483626fac.2
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 09:58:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0xNOFdCLP5yfnWbloOnQEUhemU9Or04XupP3zHMWnlxZllF3pEQRdzE1wXeug91+Vl3J+/VCHEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSXwwhsfLtMHFNXKVMYrj5FewFagxyy5/taIJG88teo4KGL0Fd
	b69WudIr11rs5LObDBYbLVfqV3jGkPo1w25fUr/uF3A78Nj4j7SUpeU39aXVDV5Oy14Gc3/9aCZ
	aKGylncjgsUUVOaBow8gGSJcbOAxC7DU=
X-Received: by 2002:a05:6820:184a:b0:663:3aa:56d9 with SMTP id
 006d021491bc7-6630f0330ebmr1714466eaf.19.1769795924868; Fri, 30 Jan 2026
 09:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12846604.O9o76ZdvQC@rafael.j.wysocki> <2417298.ElGaqSPkdT@rafael.j.wysocki>
 <0be1c2a6-21ed-4b4b-bd0a-2d57cb55cde9@arm.com>
In-Reply-To: <0be1c2a6-21ed-4b4b-bd0a-2d57cb55cde9@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Jan 2026 18:58:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hGj1txYQM2kTJeTyVP0gqmELLwmwWVAWDD2as6bDG4uQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgvj1UDtZGUgiteOdL6bFdnVsC07ljdQPmv_nXw5_umwCLjaHr0vJGzwcU
Message-ID: <CAJZ5v0hGj1txYQM2kTJeTyVP0gqmELLwmwWVAWDD2as6bDG4uQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpuidle: governors: teo: Refine intercepts-based
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41793-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66228BD8D9
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:04=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/29/26 20:51, Rafael J. Wysocki wrote:
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
>
> FWIW the algorithm would be self-correcting long-term here because
> selecting state1 would then no longer accumulate intercepts for >state1
> and soon enough it will select state0.
> Anyway I think this is an optimisation nonetheless.
>
> >
> > To address this, refine the candidate idle state lookup based on
> > intercepts to start at the state with the maximum intercepts metric,
> > below the deepest enabled one, to avoid the cases in which the search
> > may stop before reaching that state.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3: No changes
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
> > @@ -74,12 +74,17 @@
> >   *      than the candidate one (it represents the cases in which the C=
PU was
> >   *      likely woken up by a non-timer wakeup source).
> >   *
> > + *    Also find the idle state with the maximum intercepts metric (if =
there are
> > + *    multiple states with the maximum intercetps metric, choose the o=
ne with
>
> s/intercetps/intercepts
>
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
> > @@ -308,8 +313,10 @@ static int teo_select(struct cpuidle_dri
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
> > @@ -340,17 +347,32 @@ static int teo_select(struct cpuidle_dri
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
> > +              * the state with the maximum intercetps metric.
>
> s/intercetps/intercepts
>
> > +              */
> > +             if (prev_intercepts >=3D intercept_max) {
> > +                     intercept_max =3D prev_intercepts;
> > +                     intercept_max_idx =3D i - 1;
> > +             }
> >
> >               if (dev->states_usage[i].disable)
> >                       continue;
> > @@ -414,9 +436,22 @@ static int teo_select(struct cpuidle_dri
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
> > +              * the one with the maximum intercetps metric, whose targ=
et
>
> s/intercetps/intercepts

Yeah, I've noticed this and the above, but thanks for pointing them out!

I'll fix them when applying the patch.

> > +              * residency had not been greater than the idle duration =
in over
> > +              * a half of the relevant cases in the past.
> >                *
> >                * Take the possible duration limitation present if the t=
ick
> >                * has been stopped already into account.
> > @@ -428,7 +463,8 @@ static int teo_select(struct cpuidle_dri
> >                               continue;
> >
> >                       idx =3D i;
> > -                     if (2 * intercept_sum > idx_intercept_sum)
> > +                     if (2 * intercept_sum > idx_intercept_sum &&
> > +                         i <=3D intercept_max_idx)
>
>
> Ah right, we don't wanna miss the intercept 'peak' here (and we're iterat=
ing idle
> states in descending order).
> All good then!
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks!

> >                               break;
> >               }
> >       }

