Return-Path: <linux-pm+bounces-42933-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB7FLZdBmGneDwMAu9opvQ
	(envelope-from <linux-pm+bounces-42933-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 12:12:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279981672C1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 12:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E72F230041D3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39EF341AB6;
	Fri, 20 Feb 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXsPrSCS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3E34166B
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585939; cv=none; b=m5XSr7EC752WA6GyWp2TAcgWmIcNKsGEh8Fqrb9llVR8E0mHPsEQyCnLdRap6ESqJ/qrv0VUdkfpRFqT1nyupXlg8kFuTEzusjW7nrMFXP3UgL+GopXP4NkyWujuskac4vknxu2eJurNNX5LDapNHoERFiu2zP/N6xVUYs6VqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585939; c=relaxed/simple;
	bh=UvwZLtEoPKg5BTYgid4rQNZNKSe7V9Bt5U1rD4Eofh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oi9kgF2msKw6bdtIAYXOAqSNkfL8iD/iEEc8/XXjw42OOkYSk3GkS+rSMlk50xz5qmimE6LP/FeXkut3S0Dr1sT8hFuBCqOgIlt4UDpXXSUbHXbYohgf9+jgXhSXKMabwGFvc1rDa33LHoXC0Q5IU+alxPFZXhgNya6v1x4KWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXsPrSCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421B5C2BC87
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585939;
	bh=UvwZLtEoPKg5BTYgid4rQNZNKSe7V9Bt5U1rD4Eofh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cXsPrSCSXxJWvFjkKtEPS3Fw3oj2L/qXe/ZS+Tnb1DhdsNLB+hig2Pxl1kuvuDYVc
	 jlF9q0WqMceMCmNIL6PiuviBAsRUyNve4bH6+SIv2Ucq+u2z5FicPjRz3qKeZbltqE
	 pNUaPyitlEq02vr5xy2eHMkEP5IxMB+wz9H5LNxTjyd/Oh0VNtCfn5i+Xj0iErh9vK
	 9mW8wRB0jio+0H9Ek/pxljWiT56FlfTdXvv3+JV55ZgJy/t0ji0sx3p+61yNiBfs6E
	 db/18KCtVOMV7TT/Aedrk5lErDd5w9rAE9TZCkikkw+A5l7t6v1+dXPUcqGV2F/0U8
	 QSQ4dPvLNBPUA==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d196a2334fso1563700a34.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 03:12:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqihbBbtDmV/uyx0RYiA+0miXWpXl6XOX/Eyz3IoHyBII0RRkEIIEdCQFjExFLgxnrlrpMqiwX/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoY4kf8O/e6nlhmfdnya9UoyFv1f2Qgtuek8PjfpkPyw3J2RNV
	iLBCL2QaAG1TT+uD35QLFmqLSoiNNo66dZLCQk0o56lDwRsmskGxHeM/qB03d704UYfnBGhTIue
	nLttMwTdJ48kOBvbZ04ep37Eh97pxnTI=
X-Received: by 2002:a05:6830:81c6:b0:7cf:cc66:6df7 with SMTP id
 46e09a7af769-7d516a484c5mr3008272a34.9.1771585938234; Fri, 20 Feb 2026
 03:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1953482.tdWV9SEqCh@rafael.j.wysocki> <3409058.44csPzL39Z@rafael.j.wysocki>
 <f9d8789f-40ac-462c-9745-8aafbffc11d4@arm.com>
In-Reply-To: <f9d8789f-40ac-462c-9745-8aafbffc11d4@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Feb 2026 12:12:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hjDAe37qRrVDZ__NGr=XZp5RUot=B9XXE6SXGhvpyODw@mail.gmail.com>
X-Gm-Features: AaiRm52_6tab5oGkZT1mDTfX_wVeKBnXrG9AVMev3n-QU9wsCbYWZ846S0ZRZdk
Message-ID: <CAJZ5v0hjDAe37qRrVDZ__NGr=XZp5RUot=B9XXE6SXGhvpyODw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cpuidle: governors: teo: Rearrange stopped tick handling
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, 
	"Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,telus.net,linux.ibm.com,gmail.com];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42933-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 279981672C1
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 11:16=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 2/18/26 18:37, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > This change is based on the observation that it is not in fact necessar=
y
> > to select a deep idle state every time the scheduler tick has been
> > stopped before the idle state selection takes place.  Namely, if the
> > time till the closest timer (that is not the tick) is short enough,
> > a shallow idle state can be selected because the timer will kick the
> > CPU out of that state, so the damage from a possible overly optimistic
> > selection will be limited.
> >
> > Update the teo governor in accordance with the above in analogy with
> > the previous analogous menu governor update.
> >
> > Among other things, this will cause the teo governor to call
> > tick_nohz_get_sleep_length() every time when the tick has been
> > stopped already and only change the original idle state selection
> > if the time till the closest timer is beyond SAFE_TIMER_RANGE_NS
> > which is way more straightforward than the current code flow.
> >
> > Of course, this effectively throws away some of the recent teo governor
> > changes, but the resulting simplification is worth it in my view.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |   80 ++++++++++++++++---------------=
---------
> >  1 file changed, 33 insertions(+), 47 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -413,50 +413,13 @@ static int teo_select(struct cpuidle_dri
> >        * better choice.
> >        */
> >       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> > -             int min_idx =3D idx0;
> > -
> > -             if (tick_nohz_tick_stopped()) {
> > -                     /*
> > -                      * Look for the shallowest idle state below the c=
urrent
> > -                      * candidate one whose target residency is at lea=
st
> > -                      * equal to the tick period length.
> > -                      */
> > -                     while (min_idx < idx &&
> > -                            drv->states[min_idx].target_residency_ns <=
 TICK_NSEC)
> > -                             min_idx++;
> > -
> > -                     /*
> > -                      * Avoid selecting a state with a lower index, bu=
t with
> > -                      * the same target residency as the current candi=
date
> > -                      * one.
> > -                      */
> > -                     if (drv->states[min_idx].target_residency_ns =3D=
=3D
> > -                                     drv->states[idx].target_residency=
_ns)
> > -                             goto constraint;
> > -             }
> > -
> > -             /*
> > -              * If the minimum state index is greater than or equal to=
 the
> > -              * index of the state with the maximum intercepts metric =
and
> > -              * the corresponding state is enabled, there is no need t=
o look
> > -              * at the deeper states.
> > -              */
> > -             if (min_idx >=3D intercept_max_idx &&
> > -                 !dev->states_usage[min_idx].disable) {
> > -                     idx =3D min_idx;
> > -                     goto constraint;
> > -             }
> > -
> >               /*
> >                * Look for the deepest enabled idle state, at most as de=
ep as
> >                * the one with the maximum intercepts metric, whose targ=
et
> >                * residency had not been greater than the idle duration =
in over
> >                * a half of the relevant cases in the past.
> > -              *
> > -              * Take the possible duration limitation present if the t=
ick
> > -              * has been stopped already into account.
> >                */
> > -             for (i =3D idx - 1, intercept_sum =3D 0; i >=3D min_idx; =
i--) {
> > +             for (i =3D idx - 1, intercept_sum =3D 0; i >=3D idx0; i--=
) {
> >                       intercept_sum +=3D cpu_data->state_bins[i].interc=
epts;
> >
> >                       if (dev->states_usage[i].disable)
> > @@ -469,7 +432,6 @@ static int teo_select(struct cpuidle_dri
> >               }
> >       }
> >
> > -constraint:
> >       /*
> >        * If there is a latency constraint, it may be necessary to selec=
t an
> >        * idle state shallower than the current candidate one.
> > @@ -478,13 +440,13 @@ constraint:
> >               idx =3D constraint_idx;
> >
> >       /*
> > -      * If either the candidate state is state 0 or its target residen=
cy is
> > -      * low enough, there is basically nothing more to do, but if the =
sleep
> > -      * length is not updated, the subsequent wakeup will be counted a=
s an
> > -      * "intercept" which may be problematic in the cases when timer w=
akeups
> > -      * are dominant.  Namely, it may effectively prevent deeper idle =
states
> > -      * from being selected at one point even if no imminent timers ar=
e
> > -      * scheduled.
> > +      * If the tick has not been stopped and either the candidate stat=
e is
> > +      * state 0 or its target residency is low enough, there is basica=
lly
> > +      * nothing more to do, but if the sleep length is not updated, th=
e
> > +      * subsequent wakeup will be counted as an "intercept".  That may=
 be
> > +      * problematic in the cases when timer wakeups are dominant becau=
se it
> > +      * may effectively prevent deeper idle states from being selected=
 at one
> > +      * point even if no imminent timers are scheduled.
> >        *
> >        * However, frequent timers in the RESIDENCY_THRESHOLD_NS range o=
n one
> >        * CPU are unlikely (user space has a default 50 us slack value f=
or
> > @@ -500,7 +462,8 @@ constraint:
> >        * shallow idle states regardless of the wakeup type, so the slee=
p
> >        * length need not be known in that case.
> >        */
> > -     if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THR=
ESHOLD_NS) &&
> > +     if (!tick_nohz_tick_stopped() && (!idx ||
> > +          drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_N=
S) &&
> >           (2 * cpu_data->short_idles >=3D cpu_data->total ||
> >            latency_req < LATENCY_THRESHOLD_NS))
> >               goto out_tick;
> > @@ -508,6 +471,29 @@ constraint:
> >       duration_ns =3D tick_nohz_get_sleep_length(&delta_tick);
> >       cpu_data->sleep_length_ns =3D duration_ns;
> >
> > +     /*
> > +      * If the tick has been stopped and the closest timer is too far =
away,
> > +      * update the selection to prevent the CPU from getting stuck in =
a
> > +      * shallow idle state for too long.
> > +      */
> > +     if (tick_nohz_tick_stopped() && duration_ns > SAFE_TIMER_RANGE_NS=
 &&
> > +         drv->states[idx].target_residency_ns < TICK_NSEC) {
> > +             /*
> > +              * Look for the deepest enabled idle state with target
> > +              * residency within duration_ns.
> > +              */
> > +             for (i =3D drv->state_count - 1; i > idx; i--) {
>
> s/drv->state_count - 1/constraint_idx/
> to respect the latency_req here?

Good point, yes.

> > +                     if (dev->states_usage[i].disable)
> > +                             continue;
> > +
> > +                     if (drv->states[i].target_residency_ns <=3D durat=
ion_ns) {
> > +                             idx =3D i;
> > +                             break;
> > +                     }
> > +             }
> > +             return idx;
> > +     }
> > +
> >       if (!idx)
> >               goto out_tick;

