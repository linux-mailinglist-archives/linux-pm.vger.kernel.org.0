Return-Path: <linux-pm+bounces-43208-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGDwKCrxnmnoXwQAu9opvQ
	(envelope-from <linux-pm+bounces-43208-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 13:55:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F1197AC9
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 13:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C50230659D6
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CAD3ACF17;
	Wed, 25 Feb 2026 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOxk0iC3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08233BBAD
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024066; cv=none; b=K0z/trZsiOitHDqE5FAyKepBY8Xy4ZWXAQmvV95v3ftJ2bl3SsAu+9Ph1zCtHZmGl82jgmsnc63JdjAJQCJnFF6s2ToFcuRSRO62qvOiQPl8IN4AyavCbJP4C65PCqWBtMvFg5OUtdv5mjPeqgqdPcQrpobOdROeYymSP0T44lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024066; c=relaxed/simple;
	bh=QWUYnTvDepF7eI54eKa//ObIlxRrPfkxGgGTdx9olrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjqFbKJyMFhT+X/Sy7r36sEukncEdLIKk/r+Kjk/x6rgEy223sv73t4l9I4O2zPPYbg2xsmr+RUdQyTLnP8KyrKoXrL58Fa4C8w92rg47LDWIaIXN2sM+o2+NvWiVh/Ak0g3pb50D+A5OpEwmHRgYQeoUYIWhIYlW5M55KItyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOxk0iC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237D1C19423
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 12:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772024066;
	bh=QWUYnTvDepF7eI54eKa//ObIlxRrPfkxGgGTdx9olrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XOxk0iC3a9YTLoI/AYGfpGgFlkLfNqJHGXgCKw20DKoLuA2VFgAwgSNluRXUKplNt
	 JyufH+naffsaw2WRT201vNXBtXTgafhKE2gWHNgnljKn4xFx64VUmsSBc3+SIIO9Mg
	 HejvVSBBuK7wRtBmUDawphZ5HAkU7o2r8p8QiMODG4lcjlX2V4ZaBiOoZhPEG8p8DY
	 v/SwoQxm8xPnckzoO5H2tQV9hInQ+sCBB19ts4eqXaZD5EoGTGLvIG473O9zLtu/oG
	 JkTiESJqHxFNt1FooKjhfxKcZn5QB9SKqKzd3rGJ0vrrk/Zu+kXrkVrUXEHwS5yHpq
	 cTqz85Av9Hm1A==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662f9aeb782so4284108eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 04:54:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxNhu7vvP1Qx5ewZ1mECJR+eRjqALyQrzMAcfBbuod6yRtd29aS+Qx3ZrQR9uN0mXfNUl3MRkcew==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1AUhArqdj7D9e20oikeeFi2liC115Glogz730bbQcUzArEGO
	gV/rQsSLl83MWJ11nN9Ov15IHsZqnuLQet50Yqe9iWkMgTtFY4Z7LmxHnHtIURhsvWChw+oIZQ/
	6e2ZPWFK86FFM3Ukk46cJq5cVoUGigNQ=
X-Received: by 2002:a05:6820:4a11:b0:679:a57c:c84e with SMTP id
 006d021491bc7-679c4646645mr6762206eaf.5.1772024065218; Wed, 25 Feb 2026
 04:54:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875x7mv8wd.ffs@tglx> <ca2b5ede-1922-4540-bc44-a7ff6bec406f@arm.com>
 <87zf4yt90t.ffs@tglx> <5987061.DvuYhMxLoT@rafael.j.wysocki> <87jyw1u7ps.ffs@tglx>
In-Reply-To: <87jyw1u7ps.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Feb 2026 13:54:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g-PuFsSit4_xg+B=pDqJauOo=VX55bH+Kj+s=-tpXWTQ@mail.gmail.com>
X-Gm-Features: AaiRm51kCxTmNSb5y3yvd_0PAmLtEOfv1tiwm3KLaEk8ZC0A1SvpSuhZkIfsJtQ
Message-ID: <CAJZ5v0g-PuFsSit4_xg+B=pDqJauOo=VX55bH+Kj+s=-tpXWTQ@mail.gmail.com>
Subject: Re: [PATCH RFC] tick/sched: Prevent pointless NOHZ transitions
To: Thomas Gleixner <tglx@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-43208-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 004F1197AC9
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:56=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> On Tue, Feb 24 2026 at 22:31, Rafael J. Wysocki wrote:
> > On Tuesday, February 24, 2026 5:13:06 PM CET Thomas Gleixner wrote:
> >> So either the governor/driver muck provides some sensible default
> >> implementation or this has to go into into default_idle_call().
> >>
> >> Oh well...
> >
> > It looks like the issue is cause by the tick_nohz_idle_stop_tick() call=
ed right
> > before invoking default_idle_call().
> >
> > After the recent changes mentioned above, cpuidle_select() will never s=
top the
> > tick when there's only one idle state in the cpuidle driver, so it woul=
d be
> > consistent to make the default case behave analogously.  The default id=
le state
> > is never a deep one AFAICS.
> >
> > So maybe something like the below?
> >
> > ---
> >  kernel/sched/idle.c |    2 --
> >  1 file changed, 2 deletions(-)
> >
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -186,8 +186,6 @@ static void cpuidle_idle_call(void)
> >       }
> >
> >       if (cpuidle_not_available(drv, dev)) {
> > -             tick_nohz_idle_stop_tick();
> > -
> >               default_idle_call();
> >               goto exit_idle;
> >       }
>
> Which prevents VMs or other systems which do not have an idle driver to
> stop the tick at all. That's just obviously wrong, no?

The benefit from stopping the tick in cpuidle is that it doesn't kick
CPUs from idle states unnecessarily, so more energy can be saved (or
even some energy can be saved at all if the idle state target
residency is large enough), but if the idle state in question is
shallow, that's rather not super-useful.  And I'd rather not expect
default idle to be a deep idle state because that would obviously hurt
low-latency use cases.

I must be missing something, so what is it?

