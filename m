Return-Path: <linux-pm+bounces-43943-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OekFo2+rmlEIgIAu9opvQ
	(envelope-from <linux-pm+bounces-43943-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 13:35:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA89238EE6
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 13:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BED93060BFC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D714F3A4F36;
	Mon,  9 Mar 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck+p9y4y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BB377541
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059173; cv=none; b=EaLXipF5vnK1H+XDAF5QPxqPRqrVNWcr7eXAQPBtHZPSsOMXaREKhZkz2KBYJ1ANGBrecUYtcurRl37ISUqrjii4NnbwhvLsFgmODr+EdUwU/625bRTTJrdiH9ohdkvNBLtoNkhXC7dOmoK0gr6pTfdjKrtOch02kgP6D5lo5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059173; c=relaxed/simple;
	bh=qWUeFzwV3bdfVnpCJSk7jIORXf8o07T1YjoPJjdmYwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbzgErhj5MqnjhuQw7PyfUb+YnROqCSmVCclLBW3vzHYox5uZN1QpOlnWce7x7K6uHlG++q2nyX2P7a2FL1OTh9xnDvzsUpgVZRL3erVR8BZwhVcEhvWShc/XL9ffwjcBxZH3/gn9mLP2gJTqT3k4q/jnvV4qrOddxbHogUWRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck+p9y4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AC6C2BCAF
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773059173;
	bh=qWUeFzwV3bdfVnpCJSk7jIORXf8o07T1YjoPJjdmYwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ck+p9y4yaZerp8puZ/8gcJ9nuUZzZ7HUS4GBek4fg+bNOhDFzqFFYEvNsC0K6KW4j
	 ds/8WYaeH+ipbjN6aYzndaa/Yl2Ou6Bp33ncRvtgX4xT8GBPZin/Q00auIPRe0WvcP
	 hCVn9W6FnQI6n2/veduGXm09Gont60RTiMJbDBPEq5ea+BOr97BLNCT75meaMVK82S
	 xNQ6bGNxziVQIsqopxs0XuU4iAb4qA+ILte2x2/PPlerR29kM4KA8Q6fPoWnhDTUEW
	 hilOlSxwasSLKG4zGcImW8HW6BXiPV6VQpGcw0PahDhvcAMpRnUdeZ1//a3DD0fOhQ
	 A3XHASehI1YdA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-67baebf711cso738323eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 05:26:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL94KQREH4YmJE+TZEpkParwZOcOR/cGT1hbuQbUfrzozOKO1G2OSoTvZxeCAYCMtQQSSD7ZJfyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTmcsClX40I4C6b72VlwYDn63xZaVldCHcCMq1hExFpBIWgJb
	w0xNRd5nUm8araqeArZ5wkbmwQN3KHfg7jj1UY1UlaxOHwVB+LdkhRb42I1EChH7Cq/ljqbj1Oy
	cId92xcbs7841R2FvU6+6RwNOAF0F7e4=
X-Received: by 2002:a05:6820:2297:b0:66f:b778:5d1a with SMTP id
 006d021491bc7-67b9bca22a1mr7270434eaf.28.1773059172384; Mon, 09 Mar 2026
 05:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301191959.406218221@kernel.org> <CAJZ5v0h-bGU34d9OnhYqdzz+5UiKV1rBEB9NS-TL4=sK2jf-LQ@mail.gmail.com>
 <20260304030306.uk5c63xw4oqvjffb@airbuntu> <12857700.O9o76ZdvQC@rafael.j.wysocki>
 <eaccec02-2f4d-4746-81a0-deda2125bed3@arm.com>
In-Reply-To: <eaccec02-2f4d-4746-81a0-deda2125bed3@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Mar 2026 13:26:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iVhOurCYuGoZpjd_+GqCxre38Ms1gT9+3-LYk5isP5Dg@mail.gmail.com>
X-Gm-Features: AaiRm52TUV_DsStHOmFA7Ecppl7VJrNPj-jzRO9d2_yEFY4Ba_jy5ER5sBFOkto
Message-ID: <CAJZ5v0iVhOurCYuGoZpjd_+GqCxre38Ms1gT9+3-LYk5isP5Dg@mail.gmail.com>
Subject: Re: [PATCH v1] sched: idle: Make skipping governor callbacks more consistent
To: Christian Loehle <christian.loehle@arm.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>, Thomas Gleixner <tglx@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BFA89238EE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-43943-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 10:13=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 3/7/26 16:12, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the cpuidle governor .select() callback is skipped because there
> > is only one idle state in the cpuidle driver, the .reflect() callback
> > should be skipped as well, at least for consistency (if not for
> > correctness), so do it.
> >
> > Fixes: e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state i=
s available")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/cpuidle.c |   10 ----------
> >  kernel/sched/idle.c       |   11 ++++++++++-
> >  2 files changed, 10 insertions(+), 11 deletions(-)
> >
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -359,16 +359,6 @@ noinstr int cpuidle_enter_state(struct c
> >  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *=
dev,
> >                  bool *stop_tick)
> >  {
> > -     /*
> > -      * If there is only a single idle state (or none), there is nothi=
ng
> > -      * meaningful for the governor to choose. Skip the governor and
> > -      * always use state 0 with the tick running.
> > -      */
> > -     if (drv->state_count <=3D 1) {
> > -             *stop_tick =3D false;
> > -             return 0;
> > -     }
> > -
> >       return cpuidle_curr_governor->select(drv, dev, stop_tick);
> >  }
> >
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -221,7 +221,7 @@ static void cpuidle_idle_call(void)
> >
> >               next_state =3D cpuidle_find_deepest_state(drv, dev, max_l=
atency_ns);
> >               call_cpuidle(drv, dev, next_state);
> > -     } else {
> > +     } else if (drv->state_count > 1) {
> >               bool stop_tick =3D true;
> >
> >               /*
> > @@ -239,6 +239,15 @@ static void cpuidle_idle_call(void)
> >                * Give the governor an opportunity to reflect on the out=
come
> >                */
> >               cpuidle_reflect(dev, entered_state);
> > +     } else {
> > +             tick_nohz_idle_retain_tick();
> > +
> > +             /*
> > +              * If there is only a single idle state (or none), there =
is
> > +              * nothing meaningful for the governor to choose.  Skip t=
he
> > +              * governor and always use state 0.
> > +              */
> > +             call_cpuidle(drv, dev, 0);
> >       }
> >
> >  exit_idle:
> >
> >
> >
>
> Duh, good catch.
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

OK, so any objections or concerns from anyone?

I'm about to queue this up for the next -rc.

