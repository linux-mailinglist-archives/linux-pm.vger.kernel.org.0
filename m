Return-Path: <linux-pm+bounces-43209-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBPuEMf0nmmcYAQAu9opvQ
	(envelope-from <linux-pm+bounces-43209-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 14:10:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A3197CCF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 14:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 585C5301BEC2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511333A0EA2;
	Wed, 25 Feb 2026 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iItkXt5g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA23B8BDC
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025026; cv=none; b=tW6h2uvrs6gBEf4+bVsOTWOGgPQKVmvTuXCY0JN981SxKHsQz6nzJaVugiHKw6jYaCfvFeFu5ngkkLYPJlvxEpz3qnv7o2O91PwbVHxHM/ttxedzxNA06P8JxbvFpub7iWfXARXkKQaRpzP6Ld6wN9PiXM63NIcuhELqS4aPG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025026; c=relaxed/simple;
	bh=g1s5uJ3lS8k5tCub6MW3Zsoszte1dOffkbqhGAN6tOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTgSsnFugFDJfO/pOx0B9OL0sYe+JIZu/LAbPexr8LMM2Isp8otOi47bbifcCoCFMiiZXU+PrFsnDiqVWxsl98r6eHHrs349cZogqf/vkh2IohUHw0RrMWt44NVYwvxIwTWR4eaXiOCU4090qLhmDuNBKXZBhE+2RHo0B3mPg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iItkXt5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D7FC19423
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025025;
	bh=g1s5uJ3lS8k5tCub6MW3Zsoszte1dOffkbqhGAN6tOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iItkXt5g/6rluEK1Vocje7EjQOQR6dJvzzWietv08CVm7JaWCN05Dsxdtt7wAxkD1
	 5b8JRa69Pigb/4Bp4wAEKOwilEjQ04D7vicmvdxb/FasmQ32H/AtP75E3NiaSpiyG0
	 q/Tq4wlX0SIigqKsqEHh/Qn/jTuBZmm+3vk8K0necD1MRSbSiTGx2EeZz3PmsfZzll
	 evQFb0Ib2Yf0oGYEjvkdJZAyYWpeEm0X25LCYF/YGq9YJIE8lAUs/fQRg4sV5a06ed
	 2wUjXtPbHgKOxIdINt99VSw/N0FeOluETyXy+nzxYsHynu/+HjVoY1ymgfx0DNfDj1
	 wmthIxlxEnYoA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4c68f0e47so4103091a34.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 05:10:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6anLkc32BlSVZOJJjaf5UGiRrjxSeVw9uGVqImyVymIkVMgfyAB2mGLok8nPmi6keFi92vsGxTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPoWmAH6RCCDsygwjt/YYqXAhgsJr8RseoypYC5/O41h7Nw8tm
	1Vv+ySE7l009BVV1X4AUDFqFBaGC4JNidw6A9gUCsqZwsmcCGsoMNDJGphYFKpgzcsL7aSV1Jqb
	AwDypPzd/CDobzttp8SOR77xw8gG2uwg=
X-Received: by 2002:a05:6830:4998:b0:7cf:e57f:df1b with SMTP id
 46e09a7af769-7d582a6781fmr134988a34.26.1772025024970; Wed, 25 Feb 2026
 05:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875x7mv8wd.ffs@tglx> <ca2b5ede-1922-4540-bc44-a7ff6bec406f@arm.com>
 <87zf4yt90t.ffs@tglx> <5987061.DvuYhMxLoT@rafael.j.wysocki>
 <87jyw1u7ps.ffs@tglx> <CAJZ5v0g-PuFsSit4_xg+B=pDqJauOo=VX55bH+Kj+s=-tpXWTQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g-PuFsSit4_xg+B=pDqJauOo=VX55bH+Kj+s=-tpXWTQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Feb 2026 14:10:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gZBTqnk36P+hTjE-CgSOsy+MP=SXSwHHY+zxr1HbCZQA@mail.gmail.com>
X-Gm-Features: AaiRm52Qx7XMbhMdDn_oONiVTB1-Wfw76Tq4QYDpaedKe1lffpJxRsCxheg7M7w
Message-ID: <CAJZ5v0gZBTqnk36P+hTjE-CgSOsy+MP=SXSwHHY+zxr1HbCZQA@mail.gmail.com>
Subject: Re: [PATCH RFC] tick/sched: Prevent pointless NOHZ transitions
To: Thomas Gleixner <tglx@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43209-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D39A3197CCF
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 1:54=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Feb 24, 2026 at 10:56=E2=80=AFPM Thomas Gleixner <tglx@kernel.org=
> wrote:
> >
> > On Tue, Feb 24 2026 at 22:31, Rafael J. Wysocki wrote:
> > > On Tuesday, February 24, 2026 5:13:06 PM CET Thomas Gleixner wrote:
> > >> So either the governor/driver muck provides some sensible default
> > >> implementation or this has to go into into default_idle_call().
> > >>
> > >> Oh well...
> > >
> > > It looks like the issue is cause by the tick_nohz_idle_stop_tick() ca=
lled right
> > > before invoking default_idle_call().
> > >
> > > After the recent changes mentioned above, cpuidle_select() will never=
 stop the
> > > tick when there's only one idle state in the cpuidle driver, so it wo=
uld be
> > > consistent to make the default case behave analogously.  The default =
idle state
> > > is never a deep one AFAICS.
> > >
> > > So maybe something like the below?
> > >
> > > ---
> > >  kernel/sched/idle.c |    2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > --- a/kernel/sched/idle.c
> > > +++ b/kernel/sched/idle.c
> > > @@ -186,8 +186,6 @@ static void cpuidle_idle_call(void)
> > >       }
> > >
> > >       if (cpuidle_not_available(drv, dev)) {
> > > -             tick_nohz_idle_stop_tick();
> > > -
> > >               default_idle_call();
> > >               goto exit_idle;
> > >       }
> >
> > Which prevents VMs or other systems which do not have an idle driver to
> > stop the tick at all. That's just obviously wrong, no?
>
> The benefit from stopping the tick in cpuidle is that it doesn't kick
> CPUs from idle states unnecessarily, so more energy can be saved (or
> even some energy can be saved at all if the idle state target
> residency is large enough), but if the idle state in question is
> shallow, that's rather not super-useful.  And I'd rather not expect
> default idle to be a deep idle state because that would obviously hurt
> low-latency use cases.
>
> I must be missing something, so what is it?

OK, if I'm not mistaken, the tick in a VM will effectively become a
periodic hrtimer in the host and it would prevent the host cpuidle
from stopping the tick.  Fair enough.

