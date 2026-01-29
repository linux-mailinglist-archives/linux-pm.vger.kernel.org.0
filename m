Return-Path: <linux-pm+bounces-41699-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H2xN+2We2nOGAIAu9opvQ
	(envelope-from <linux-pm+bounces-41699-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:20:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60770B2C34
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F5DE300A609
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18B6343204;
	Thu, 29 Jan 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHnUiANj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9652C0F7F
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707108; cv=none; b=dSnIQfnmZ1IubVCQrn+q4ahTtv7d4pv1ttNEBgwREd5fXhWnSDsQzjYADAsCjJgJUPaRCtHFUyUR/aloj1j4WdH9kBklfjc5BpciSOTevkd9Y3Pwab4RfgqN8TTY3DznBgdI2Fa60ruoWYLH4a1ZxAlxguSHo1kvcHJt97CrfUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707108; c=relaxed/simple;
	bh=qGhHJUvXh2zle3OVTWqdWPlyBRrQQZySCtaK6hhDNp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psAiqHMd0FSPqWmI72+EB8CR1JUj8cZl4cHCCd6Lue/9Fmo6qnDM48/lBKPB/P9/K5FlmhqaCNjLp8k1o40D/xpcenihY602yEyhuefzweh5DMeDlngTscU5yAMXULdVGUiXI0jpz1Pp8y4TD42SeJT2b8rlQLtoYM2waPtu9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHnUiANj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBDFC19422
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769707108;
	bh=qGhHJUvXh2zle3OVTWqdWPlyBRrQQZySCtaK6hhDNp0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PHnUiANj8J2+kjieYnTG++IMsa+T8hTN3/r89WAVqNd2aBb0OXEQY+mdvrwueMQ1e
	 jX2OZ8cIVlI8/N4ZupB4ybaKQPny0fKcHnPIuGo1+u/ZFNXIsGVTs5btKfzaSVaC9q
	 FGb0mgjvz4wgpVeyPYJ+Ur3EQ7xh5EA7b6AmVKddSEKql9LkM03ENJ3XvbgoYfolxa
	 qCPpppC7olqa6zuCfFzid38v66irZrD1zlYEt31AN69F3+QcRTjdzSsLNIfX02Dh8F
	 gw2JBYvzOWqBM893Aq5ZvS8eI63DtOV0RhY55gaK/kDoVp1b3AAd9fR7SUyY3ydX76
	 yMzRaxxCqnocQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7cfd65ea639so766167a34.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 09:18:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEZchM7Be9BivjaFo8ZldAgjd5iKGUF0GQoIvu9vdd/fYGI+Ewauoo/aePIKYzYF5U+80S6Esm8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjwn8oT1Wm4QQIxyW3pJE3zlOpaX1XFTTgvPFM0GFqJBnX6zWR
	d0pFbtJhxFHj+HDkaBEqHSqnJMdybHIoSIRFBUUGHdRvCrXBkTa8Ekt7nkGH24XkjTcen95iN8F
	czNxvDOASF4udVJrYpgK+PYn9KRKuLUA=
X-Received: by 2002:a05:6830:43ab:b0:7cf:d1ed:f9ff with SMTP id
 46e09a7af769-7d1a539155fmr167400a34.34.1769707107439; Thu, 29 Jan 2026
 09:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12831359.O9o76ZdvQC@rafael.j.wysocki> <5079287.31r3eYUQgx@rafael.j.wysocki>
 <44c4ee5a-34ec-4b23-b06b-05bd0fda6585@arm.com>
In-Reply-To: <44c4ee5a-34ec-4b23-b06b-05bd0fda6585@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Jan 2026 18:18:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i8q=UoZMmNpe6KLQDk_0Fsmh6pYcxxMUitv68VueA9hA@mail.gmail.com>
X-Gm-Features: AZwV_Qh2dWHmto3I1IpytqHWT76HLtYeJCa5xTCGoAnlrkHxPXnonviWn5PNbyM
Message-ID: <CAJZ5v0i8q=UoZMmNpe6KLQDk_0Fsmh6pYcxxMUitv68VueA9hA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: governors: teo: Adjust the classification
 of wakeup events
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41699-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 60770B2C34
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:16=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/26/26 19:45, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If differences between target residency values of adjacent idle states
> > of a given CPU are relatively large, the corresponding idle state bins
> > used by the teo governors are large either and the rule by which hits
> > are distinguished from intercepts is inaccurate.
> >
> > Namely, by that rule, a wakeup event is classified as a hit if the
> > sleep length (the time till the closest timer other than the tick)
> > and the measured idle duration, adjusted for the entered idle state
> > exit latency, fall into the same idle state bin.  However, if that bin
> > is large enough, the actual difference between the sleep length and
> > the measured idle duration may be significant.  It may in fact be
> > significantly greater than the analogous difference for an event where
> > the sleep length and the measured idle duration fall into different
> > bins.
> >
> > For this reason, amend the rule in question with a check that will
> > only allow a wakeup event to be counted as a hit if the difference
> > between the sleep length and the measured idle duration is less than
> > LATENCY_THRESHOLD_NS (which means that the difference between the
> > sleep length and the raw measured idle duration is below the sum of
> > LATENCY_THRESHOLD_NS and 1/2 of the entered idle state exit latency).
> > Otherwise, the event will be counted as an intercept.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1.1 -> v2: No changes
> >
> > v1 -> v1.1
> >    * Drop the change in teo_select() along with the corresponding
> >      part of the changelog (after receiving testing feedback from
> >      Christian)
> >
> > This is a resend of
> >
> > https://lore.kernel.org/linux-pm/4707705.LvFx2qVVIh@rafael.j.wysocki/
> >
> > It applies on top of the first three patches from
> >
> > https://lore.kernel.org/linux-pm/2257365.irdbgypaU6@rafael.j.wysocki/
> >
> > ---
> >  drivers/cpuidle/governors/teo.c |   32 ++++++++++++++++---------------=
-
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -48,13 +48,11 @@
> >   * in accordance with what happened last time.
> >   *
> >   * The "hits" metric reflects the relative frequency of situations in =
which the
> > - * sleep length and the idle duration measured after CPU wakeup fall i=
nto the
> > - * same bin (that is, the CPU appears to wake up "on time" relative to=
 the sleep
> > - * length).  In turn, the "intercepts" metric reflects the relative fr=
equency of
> > - * non-timer wakeup events for which the measured idle duration falls =
into a bin
> > - * that corresponds to an idle state shallower than the one whose bin =
is fallen
> > - * into by the sleep length (these events are also referred to as "int=
ercepts"
> > - * below).
> > + * sleep length and the idle duration measured after CPU wakeup are cl=
ose enough
> > + * (that is, the CPU appears to wake up "on time" relative to the slee=
p length).
> > + * In turn, the "intercepts" metric reflects the relative frequency of=
 non-timer
> > + * wakeup events for which the measured idle duration is measurably le=
ss than
> > + * the sleep length (these events are also referred to as "intercepts"=
 below).
> >   *
> >   * The governor also counts "intercepts" with the measured idle durati=
on below
> >   * the tick period length and uses this information when deciding whet=
her or not
> > @@ -253,12 +251,16 @@ static void teo_update(struct cpuidle_dr
> >       }
> >
> >       /*
> > -      * If the measured idle duration falls into the same bin as the s=
leep
> > -      * length, this is a "hit", so update the "hits" metric for that =
bin.
> > +      * If the measured idle duration falls into the same bin as the
> > +      * sleep length and the difference between them is less than
> > +      * LATENCY_THRESHOLD_NS, this is a "hit", so update the "hits"
> > +      * metric for that bin.
> > +      *
> >        * Otherwise, update the "intercepts" metric for the bin fallen i=
nto by
> >        * the measured idle duration.
> >        */
> > -     if (idx_timer =3D=3D idx_duration) {
> > +     if (idx_timer =3D=3D idx_duration &&
> > +         cpu_data->sleep_length_ns - measured_ns < LATENCY_THRESHOLD_N=
S) {
>
> So it needs to be within 7.5us here.
> Can we always expect that to be true?

It's just a margin.

> Especially since measured_ns does this "infer average from worst-case exi=
t
> latency" handling.
> On deeper states this
> measured_ns -=3D lat_ns / 2;
> is an order of magnitude higher than our threshold.

True.

> So it should probably be something like
> exit_latency / 2 + LATENCY_THRESHOLD_NS?
> Or just exit_latency and allow the error to both sides?

Well, the exit latency is already there in this inequality because
measured_ns =3D=3D raw_measured_ns - exit_latency / 2 and I didn't want to
take it into account twice.

And in fact I want sleep_length_ns and measured_us (already adjusted
for the entered state exit latency) to be equal up to a margin and I
just think that the margin can be the same for all of the state bins
because it's basically the granularity of the comparison.

I didn't get it right though and the code should be something like this:

    if (idx_timer =3D=3D idx_duration) {
        s64 delta_ns =3D cpu_data->sleep_length_ns - measured_ns;

        if (delta_ns < 0)
            delta_ns =3D -delta_ns;

        if (delta_ns < LATENCY_THRESHOLD_NS) {
            cpu_data->state_bins[idx_timer].hits +=3D PULSE;
            return;
        }
    }
    /*
     * Update the "intercepts" metric for the bin fallen into by the
     * measured idle duration.
     */
    cpu_data->state_bins[idx_duration].intercepts +=3D PULSE;
    if (measured_ns <=3D TICK_NSEC)
        cpu_data->tick_intercepts +=3D PULSE;

LATENCY_THRESHOLD_NS is as good as anything else here and for bins
narrower than it (which means C1 and C1e on Intel x86 for instance)
delta_ns will always be less than it, so the behavior there won't
change after the patch.

> >               cpu_data->state_bins[idx_timer].hits +=3D PULSE;
> >       } else {
> >               cpu_data->state_bins[idx_duration].intercepts +=3D PULSE;
> >
> >

Overall, I'll respin the series.

