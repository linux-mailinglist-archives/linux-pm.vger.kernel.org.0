Return-Path: <linux-pm+bounces-41725-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGgnBna+e2mnIAIAu9opvQ
	(envelope-from <linux-pm+bounces-41725-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:09:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E23DB4286
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3061D30210C2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7B32E120;
	Thu, 29 Jan 2026 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufozF9ZX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB7327C06
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717350; cv=none; b=kP8+M2kJLSwbsjN5Oru9jTnjX/LI7DyWxbs6NfE/Nll6bRw+Tl+SvowI/C540sSVaU+4rf0MCm3tj2HNYp+BNUmB5dlc6r+KuPJR2iqFMDat/dqgIno6noNQasE8o7okbLumQi4NGB5mE/8dzOkkgCri8ZXrGfdNlePAkFCFX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717350; c=relaxed/simple;
	bh=5g4PJcJGtRew9woIi4OoTST/tP0m2PWttFuHI8O14so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6SJHxvYfyE9h4HNF7jiKcKWpPbNTmUEjd5u3q4pCjJYx7ROq2DeV6KZCIA25OibEgbtaMjPesQdrEMZcE7T73Bbvn87Mo9rgb/qaL8zmqNK4p9SNbjNgm3Hyse17fhdXyH51PI04j2hDURLM6TzJB0fjx2BeiPTzB94F0oybbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufozF9ZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A70C4CEF7
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 20:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769717350;
	bh=5g4PJcJGtRew9woIi4OoTST/tP0m2PWttFuHI8O14so=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ufozF9ZXtp9o1BuCwWbHJmZ8mx6gcJSGF1OKwCkTCwaWTGScpEdm0biFtS2te3MN7
	 RyBMaRWlqEX93/T6JrTDHX1JBPjtC4kKKIgg7TyP8VY0/TsezZGkNxx9aP4hcEk6ut
	 ZNMRKBp4v9RDy4FTDzFI+ahQzuAPnGs/4hpI/Iojrh4fCpLE2nfUwIAHme8G2M7cZn
	 UAyRfDaQH0JA4ngnwG07mlf0kJa9hce3q7RLvTaCALcEWLTbCnc+zgimQiXQgzAP1X
	 N2yTlR3APlLcGLXswdLxHd8qp+txJrajDJXFFwi6FW0lcgExI2OGTqQZMF8Apfqtmv
	 E7cnlZvFQjMtg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6610f407959so425032eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:09:10 -0800 (PST)
X-Gm-Message-State: AOJu0Yw/OWC4WKW3b0/ILTNsa5xOwPTHHV9Hk+iHSRj91XEbeswR3kts
	KC2FOZ9g3ld1JMqDtPVw75ePdvVVlRz1f8ULVH51pjasRkMJ0mFz91hZH26bGqONNQbIBvANWoM
	/3aUNH1bUUaGBWV+7OmQJ1dmk5WdUJXs=
X-Received: by 2002:a05:6820:4910:b0:663:74e:b642 with SMTP id
 006d021491bc7-6630f3f56d9mr289408eaf.66.1769717346287; Thu, 29 Jan 2026
 12:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12831359.O9o76ZdvQC@rafael.j.wysocki> <5079287.31r3eYUQgx@rafael.j.wysocki>
 <44c4ee5a-34ec-4b23-b06b-05bd0fda6585@arm.com> <CAJZ5v0i8q=UoZMmNpe6KLQDk_0Fsmh6pYcxxMUitv68VueA9hA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i8q=UoZMmNpe6KLQDk_0Fsmh6pYcxxMUitv68VueA9hA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Jan 2026 21:08:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jo=gbCZoPPHxUTyCV-h81G1amTonc5CgA3HJW_aeUqoA@mail.gmail.com>
X-Gm-Features: AZwV_QhYTQb9V8yi705W71drdmCAvPi7VPTdubHgkSrxwg6WoCjyB6R5RvosYEk
Message-ID: <CAJZ5v0jo=gbCZoPPHxUTyCV-h81G1amTonc5CgA3HJW_aeUqoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: governors: teo: Adjust the classification
 of wakeup events
To: Christian Loehle <christian.loehle@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-41725-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arm.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E23DB4286
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 6:18=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Jan 29, 2026 at 10:16=E2=80=AFAM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 1/26/26 19:45, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > If differences between target residency values of adjacent idle state=
s
> > > of a given CPU are relatively large, the corresponding idle state bin=
s
> > > used by the teo governors are large either and the rule by which hits
> > > are distinguished from intercepts is inaccurate.
> > >
> > > Namely, by that rule, a wakeup event is classified as a hit if the
> > > sleep length (the time till the closest timer other than the tick)
> > > and the measured idle duration, adjusted for the entered idle state
> > > exit latency, fall into the same idle state bin.  However, if that bi=
n
> > > is large enough, the actual difference between the sleep length and
> > > the measured idle duration may be significant.  It may in fact be
> > > significantly greater than the analogous difference for an event wher=
e
> > > the sleep length and the measured idle duration fall into different
> > > bins.
> > >
> > > For this reason, amend the rule in question with a check that will
> > > only allow a wakeup event to be counted as a hit if the difference
> > > between the sleep length and the measured idle duration is less than
> > > LATENCY_THRESHOLD_NS (which means that the difference between the
> > > sleep length and the raw measured idle duration is below the sum of
> > > LATENCY_THRESHOLD_NS and 1/2 of the entered idle state exit latency).
> > > Otherwise, the event will be counted as an intercept.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1.1 -> v2: No changes
> > >
> > > v1 -> v1.1
> > >    * Drop the change in teo_select() along with the corresponding
> > >      part of the changelog (after receiving testing feedback from
> > >      Christian)
> > >
> > > This is a resend of
> > >
> > > https://lore.kernel.org/linux-pm/4707705.LvFx2qVVIh@rafael.j.wysocki/
> > >
> > > It applies on top of the first three patches from
> > >
> > > https://lore.kernel.org/linux-pm/2257365.irdbgypaU6@rafael.j.wysocki/
> > >
> > > ---
> > >  drivers/cpuidle/governors/teo.c |   32 ++++++++++++++++-------------=
---
> > >  1 file changed, 16 insertions(+), 16 deletions(-)
> > >
> > > --- a/drivers/cpuidle/governors/teo.c
> > > +++ b/drivers/cpuidle/governors/teo.c
> > > @@ -48,13 +48,11 @@
> > >   * in accordance with what happened last time.
> > >   *
> > >   * The "hits" metric reflects the relative frequency of situations i=
n which the
> > > - * sleep length and the idle duration measured after CPU wakeup fall=
 into the
> > > - * same bin (that is, the CPU appears to wake up "on time" relative =
to the sleep
> > > - * length).  In turn, the "intercepts" metric reflects the relative =
frequency of
> > > - * non-timer wakeup events for which the measured idle duration fall=
s into a bin
> > > - * that corresponds to an idle state shallower than the one whose bi=
n is fallen
> > > - * into by the sleep length (these events are also referred to as "i=
ntercepts"
> > > - * below).
> > > + * sleep length and the idle duration measured after CPU wakeup are =
close enough
> > > + * (that is, the CPU appears to wake up "on time" relative to the sl=
eep length).
> > > + * In turn, the "intercepts" metric reflects the relative frequency =
of non-timer
> > > + * wakeup events for which the measured idle duration is measurably =
less than
> > > + * the sleep length (these events are also referred to as "intercept=
s" below).
> > >   *
> > >   * The governor also counts "intercepts" with the measured idle dura=
tion below
> > >   * the tick period length and uses this information when deciding wh=
ether or not
> > > @@ -253,12 +251,16 @@ static void teo_update(struct cpuidle_dr
> > >       }
> > >
> > >       /*
> > > -      * If the measured idle duration falls into the same bin as the=
 sleep
> > > -      * length, this is a "hit", so update the "hits" metric for tha=
t bin.
> > > +      * If the measured idle duration falls into the same bin as the
> > > +      * sleep length and the difference between them is less than
> > > +      * LATENCY_THRESHOLD_NS, this is a "hit", so update the "hits"
> > > +      * metric for that bin.
> > > +      *
> > >        * Otherwise, update the "intercepts" metric for the bin fallen=
 into by
> > >        * the measured idle duration.
> > >        */
> > > -     if (idx_timer =3D=3D idx_duration) {
> > > +     if (idx_timer =3D=3D idx_duration &&
> > > +         cpu_data->sleep_length_ns - measured_ns < LATENCY_THRESHOLD=
_NS) {
> >
> > So it needs to be within 7.5us here.
> > Can we always expect that to be true?
>
> It's just a margin.
>
> > Especially since measured_ns does this "infer average from worst-case e=
xit
> > latency" handling.
> > On deeper states this
> > measured_ns -=3D lat_ns / 2;
> > is an order of magnitude higher than our threshold.
>
> True.
>
> > So it should probably be something like
> > exit_latency / 2 + LATENCY_THRESHOLD_NS?
> > Or just exit_latency and allow the error to both sides?
>
> Well, the exit latency is already there in this inequality because
> measured_ns =3D=3D raw_measured_ns - exit_latency / 2 and I didn't want t=
o
> take it into account twice.
>
> And in fact I want sleep_length_ns and measured_us (already adjusted
> for the entered state exit latency) to be equal up to a margin and I
> just think that the margin can be the same for all of the state bins
> because it's basically the granularity of the comparison.

Well, scratch the above paragraph.

The point is that cpu_data->sleep_length_ns should be less than
measured_ns (which means that the wakeup appears to have occurred
after the anticipated timer event) or at least not much greater than
it (the actual wakeup latency might be shorter than 1/2 of the
declared one due to a prewake or similar).  How much sleep_length_ns
can be greater than measured_ns for the wakeup to still count as a
"hit" is, of course, a matter of choice and I thought that it would be
reasonable to use a constant limit.

However, the limit may as well be chosen to depend on the exit latency
of the entered state and it can be as large as 1/2 of that number (I
don't think that using a larger number would make a lot of sense).

