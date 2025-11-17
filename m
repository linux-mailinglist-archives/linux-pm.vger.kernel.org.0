Return-Path: <linux-pm+bounces-38133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F30C65179
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 17:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1372C29D2D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C42D592F;
	Mon, 17 Nov 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyi40qh+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACF2D5924
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396170; cv=none; b=rjnf/C7HpHjxWanhXMEB06nfPoULtcC3csekTyN1eTveGblc/3Z0pfCMo7r9edFCP+TeADpJWW4vQL8oAH/uq1PX2p/RyKG13fyknGILAzrWtgszZ84P/K/oUrqZnmKcqCM9706pVmtVlcc6xrtRN0/KtLVh7XMFtsjaRrxIU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396170; c=relaxed/simple;
	bh=UieG9CwZdmYwQ9SDslSKRMC0Pk05rZFyhQjrdQmBiWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEJXwKh8x5s4N/2SelOMDjaQX2iFn/06XY1ezwguwQp6WIHUSxAysN6NTCYLEUmoi21+qTa/iwRbfbqekOcgHtFjIACFMbFSR7DuNXkJcyf2F3DUOSkbTevnYwJaUgVVYhxUbZ1xZdJzz7UgCcubHxhFvt1JeOoqlS9zgTdZfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyi40qh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550AAC2BC86
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396170;
	bh=UieG9CwZdmYwQ9SDslSKRMC0Pk05rZFyhQjrdQmBiWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tyi40qh+9V/f4KXyAsENfA0C+DzplXCuwHH8d3gnO8HUDq6NJ85dPIqO06WNFeRPk
	 860eM2P4ZvCkne9jYsitPtlcOSLpDbHrKKG6S/S5Qpy3QKqU9fXpJoGAvmTxvcho1s
	 Oagv6l8rnJ376N4NIdOgOfyzMjFGuhHl4XzWI2O0SZ3OmgMJhepOp2sQR+CMe9Z3bB
	 3HEXIpBv+0YB2Fuwwcv91f9XGp+1fW/gDHOS8YsPFIO9cU4oGmt+I4PG3mWl8GpT6S
	 A3xSw14k66ycbYTip4SRvwmqiD5hN6cf0yhoZUw2jXh6vea18usJxpdpHAR1agIUfz
	 2ISLcCR3a0Opw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-65366485678so1948193eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 08:16:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXZa7ZcngybvehZ4HqGreJfpjoVX8cXdGtTw6i67rJbnRX7WasEVh6fTMENxEapUDEzpvIk7GBug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9HekbYG9qg20QHwKtfMQzBjXzDr3sQGkNMg3KEs+hsZfT/QGJ
	JqyR5yFq+qDsvFFCtdm4DyslMeQ7LWJOpwu/HddiDXBoGhlYXoTzyOWg3CFbr6lXWwVSQ7yZlUn
	qDekXhkjGxhJWbY45a7fMxTnv0kh8zB0=
X-Google-Smtp-Source: AGHT+IGlzDPrzR+Sg1+ecp8Jx0LtBQx0PGsxKj2qzNctCNl1RuWuRCJFjsVW8QuimFHSTAUUR67qNWSNrpJXgyWux98=
X-Received: by 2002:a05:6808:6714:b0:44f:e801:d6d6 with SMTP id
 5614622812f47-450973fb19cmr6750148b6e.6.1763396169541; Mon, 17 Nov 2025
 08:16:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12810244.O9o76ZdvQC@rafael.j.wysocki> <5085160.31r3eYUQgx@rafael.j.wysocki>
 <8a9482f3-d8f4-4dcf-b7eb-51a2e1bd4d3b@arm.com>
In-Reply-To: <8a9482f3-d8f4-4dcf-b7eb-51a2e1bd4d3b@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Nov 2025 17:15:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iyqW2hC1PJT+XqaSc9i2pvKOTjb+1w+jkCLpJSmA=9Lg@mail.gmail.com>
X-Gm-Features: AWmQ_bkU60AMCmC86ORU69-JZFJ2GIlcN6uFjCVIb86Uy1lBKhRPIIgTjIxlpqo
Message-ID: <CAJZ5v0iyqW2hC1PJT+XqaSc9i2pvKOTjb+1w+jkCLpJSmA=9Lg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] cpuidle: governors: teo: Fix tick_intercepts
 handling in teo_update()
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:06=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/16/25 12:34, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The condition deciding whether or not to increase cpu_data->tick_interc=
epts
> > in teo_update() is reverse, so fix it.
> >
> > Fixes: d619b5cc6780 ("cpuidle: teo: Simplify counting events used for t=
ick management")
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > I'm planning to apply this for 6.19 on top of
> >
> > https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wysocki/
> >
> > because that patch (indirectly) depends on commit d619b5cc6780.
> >
> > ---
> >  drivers/cpuidle/governors/teo.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -251,7 +251,7 @@ static void teo_update(struct cpuidle_dr
> >               cpu_data->state_bins[idx_timer].hits +=3D PULSE;
> >       } else {
> >               cpu_data->state_bins[idx_duration].intercepts +=3D PULSE;
> > -             if (TICK_NSEC <=3D measured_ns)
> > +             if (measured_ns <=3D TICK_NSEC)
>
> nit: Why <=3D instead of <?

Because it was <=3D before.

> I guess it really doesn't matter with measured_ns only being a rough appr=
oximation
> with an error in the order of wakeup-latency.

Right and moreover, TICK_NSEC is an upper bound for tick wakeups, they
occur earlier as a rule.

> Reviewed-by:
> Christian Loehle <christian.loehle@arm.com>
>
> Let me go write some tests for all these edge cases :/
>
> IIRC Aboorva's power systems have no idle state deeper than TICK_NSEC, so
> this might make a big difference here, hence CCed.

Like x86 systems with HZ < 1000 which are the majority nowadays AFAICS.

Thanks!

