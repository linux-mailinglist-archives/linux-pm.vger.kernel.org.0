Return-Path: <linux-pm+bounces-42938-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DXXF49bmGkNGwMAu9opvQ
	(envelope-from <linux-pm+bounces-42938-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 14:03:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677D167A7C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 14:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F7B73002F59
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF34344DA4;
	Fri, 20 Feb 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb+DpROl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58261330311
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771592585; cv=none; b=LxWUG6nMD3qmMSWlbQhTBa6yEAztIIx4SgWmXfQVBsENpCyXs3tH9kE+uHMf+HMxiPymftJ1EfSO0DmZOe8/7hMVcY7sKeudbqgFLR4D7O8U5mQofReKwLhaBxOaWdcJqxJsoiQLYYAOCGqBCdldRacdIs+s4EzmMI/2H0McBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771592585; c=relaxed/simple;
	bh=HjuLriyl95R3RDRBJMEQKF6Xmlqo8rbRe+5cEh2v1y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+0SlcIhfcS3m1Z5IcB2Pf5rDcRj0hwOzgJZD28VZB3VVG51TA9Fj+e8nAJbU6wjIVuFcuPmCyRAX3Fg1Hheg5OHuGGaK9heGua3WhjXcyDy/+cAOxYQ19lSy79u0BIt4uBiYXmkDoy/oTGQiZHRXTRVi8rZDRyv1y+t0OuZb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb+DpROl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13AAC116C6
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771592584;
	bh=HjuLriyl95R3RDRBJMEQKF6Xmlqo8rbRe+5cEh2v1y4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gb+DpROlT8pPAMPxXkI5ZlvN5HK2ntRndd+J0Fj73eOBT0EPJPrKW+/g+vfG3xJf8
	 bbsK8/OOpV4Yn71FXqwFePexkQhLQNH4zwJwhqpltX8qTfzIwmRfq4I1n3FkahZcnL
	 W2CHlsiz8vUUaocKOJHPWTP9lQNhmGe42Oon/h8m/BS+JuGYmC3sF4ferHLrMQLLLi
	 wbhGn3p4BpCDKa/ysGTWl16aO+XkpKKSCeibqOCTcGwDbP65z2A0Mq3+J/FDh0m7GX
	 y/6AWePT3IYIxioB9g0LK1xtDOR8XcFPCHL3Nc5d+N8ZIdfGJ3ycJ/5NC9bZMoRfA1
	 bmstkVSiQQ6rw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so1208117fac.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 05:03:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUz0l2MyJ0mDuoDvOerhxasYENh+EP85nT1ixvkGw2H9WaUJ6Rjuo1gIqEWcm2R5/n50ZYT5HPAHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGeZVvecjKFHUGiveeZvi2jfvIA4V7/TsKdeZHyzuEOK0kCcq
	+NeAfmH85FjVhDW3zMLdLwCPkhwLodFYWRrN2rFNxSCO+ezXjQyhfGWD6tPDRT0K4fspYTu1Ki9
	xoYOU4aqE50ExwdBrKEyIUaWqBEHNYsI=
X-Received: by 2002:a05:6870:fbaa:b0:40c:10d6:7768 with SMTP id
 586e51a60fabf-415291d9302mr4993844fac.54.1771592583798; Fri, 20 Feb 2026
 05:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <2244365.irdbgypaU6@rafael.j.wysocki>
 <20260208155902.437740-1-ionut.nechita@windriver.com>
In-Reply-To: <20260208155902.437740-1-ionut.nechita@windriver.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Feb 2026 14:02:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hVwtDw9h=XGxvDZpWi9_EaTmTaqnpSkFrwjGrVhUe24Q@mail.gmail.com>
X-Gm-Features: AaiRm502SxSdFzglRFCQOgK2Xb7kFp5XByqHjUi8sFWDylj4NnWHaP4Jvv0N1To
Message-ID: <CAJZ5v0hVwtDw9h=XGxvDZpWi9_EaTmTaqnpSkFrwjGrVhUe24Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full CPUs
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Ionut Nechita <ionut_n2001@yahoo.com>, 
	Ionut Nechita <sunlightlinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,infradead.org,arm.com,linaro.org,yahoo.com,gmail.com];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42938-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0677D167A7C
X-Rspamd-Action: no action

Hi,

On Sun, Feb 8, 2026 at 5:00=E2=80=AFPM Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> wrote:
>
> Hi Rafael,
>
> I have a question regarding this patch: is it planned for upstream
> integration, or is there a newer/improved version in the works?

Not really.

It is too risky to be made at this point because of some systems'
dependency on the current behavior.

> I'm asking because I've been working on a related optimization in the
> same code path. My patch [1] takes a different approach to the same
> problem area -- instead of skipping the override entirely for nohz_full
> CPUs, it changes:
>
>     predicted_ns =3D data->next_timer_ns;
>
> to:
>
>     predicted_ns =3D min(predicted_ns, data->next_timer_ns);

This is risky if the next timer is distant because it may cause the
CPU to get stuck in a shallow idle state effectively till the next
timer.  That in turn may prevent the processor as a whole from
entering a package idle state etc.

> The idea is to prevent selecting excessively deep C-states when the
> prediction is short but the next timer is distant, which on platforms
> like Sapphire Rapids with high exit latencies (150us+) can cause
> significant latency spikes.

Well, this essentially is a tradeoff between latency and power.

> I notice that our patches touch the same block but address slightly
> different aspects:
>
> - Your patch: prevents the override from firing on nohz_full CPUs
>   where tick_stopped is always true, avoiding systematically
>   discarding the prediction.
> - My patch: when the override does fire, uses min() instead of
>   unconditional replacement to preserve information from the
>   prediction.
>
> These two fixes could potentially be complementary. However, my patch
> is still under investigation due to limited hardware availability for
> collecting more data across different platforms.
>
> I'd appreciate your thoughts on whether these approaches could be
> combined, or if your patch already addresses the use cases I'm seeing.

Actually, I don't think that any of them are suitable.

Please see this series:

https://lore.kernel.org/linux-pm/1953482.tdWV9SEqCh@rafael.j.wysocki/

which takes a somewhat different direction.

