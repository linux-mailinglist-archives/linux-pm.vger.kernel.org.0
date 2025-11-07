Return-Path: <linux-pm+bounces-37645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B40C415E0
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 20:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920FA189EAFB
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE4733C515;
	Fri,  7 Nov 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb1sayqI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC933B97A
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541937; cv=none; b=d5D1XFtztSNon4Z5TzaWLlZI/3UbQRBFIri/+3mVx40Z31IfqI10m/UOi0uB5dJIuhr18itEyFf6lVU1zrUcf/gwiZ1ffa+bIb1pH092iYiSRSbGIjAsBqT8agFOgaoyW/11Hwo5ueczTeX4KfaAjt6683IxRm1jiQFteKVzK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541937; c=relaxed/simple;
	bh=JY3ffK3b9GTcr8PiL6cpOTkjcyjA8THe0BXledAm0cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQmRZuEy/EAdHZiAluVvSBbA/426jzXKYNKUW2y4Fwrqt6juw//gbUTsEK3Kr5IfQ3O36wzIxk0pkBdJTdnJN3fpJEgyW76y8IcRi/z5d4tAxUnYP4w6F+fvr6H4uT+C24S6A4Z9INjqUf01bwOSxMCob1mLe5Ii9hbZZg/9teU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb1sayqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7719BC19422
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 18:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762541936;
	bh=JY3ffK3b9GTcr8PiL6cpOTkjcyjA8THe0BXledAm0cA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fb1sayqIpSmHJhNUvMdB7sENEBhJLQmNT3BnAoxwXizoFu9HXvmMa1x+8mD5JBEgC
	 H6qDECqPHiMcsCmSYk4EvfxWSAdKzQmjolSL6/zqLUJuuXkHQ9l7m0yAmN16W39a/W
	 DvVl1PDGtfbMbdoYwVGVRw/YbN0L9aEkBd/3XuoyyZKAIMPjM9qhPHx9L+043b/s/+
	 tyAiygZHy5ToaumEAPgQqpsy8zLz/q+CQODmz6aoarw5GYLJ7EW7zTnGyRMK2n9syS
	 EFrHc7S7h4URj2EZv1cpGGY9AVZFFsAqSFsxp8C/3Mw5lwJw+nqKYXNdVj+Jk0q8Tm
	 MwLL7qUm8SKXg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-656ce836420so392441eaf.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 10:58:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlbtGYjiOSfw5HK0kEkJVJBcd7VSQnVK6M7LCAj+XIXED4A6dlknvdj+a6cBByuQ+fjZG1X/Iggw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvuIy6L3uARjKSmJ8TE5wzj+LEqb1nUwKqNk7eKB9sS7dO6Hpf
	L7lvjD6e5XPNHqGbLfWcTw/Dz8l03fAdEmXWi8cMn+nVjg65six323Za3LUgK+ANj1oZxud2PFh
	I6hI7qGTaBb334m4BVrSr9eACDj/g39Q=
X-Google-Smtp-Source: AGHT+IHxdorsHFt+kPRK92oTkZiIgZZZSZc5IXKfRWQPTnaBbxj43YOS77ijVBe6ftZfCHNn4jYNDaEDCRuWKu7LM2A=
X-Received: by 2002:a05:6820:c09c:10b0:656:77b8:9e3d with SMTP id
 006d021491bc7-656d873b0f7mr284668eaf.1.1762541935644; Fri, 07 Nov 2025
 10:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5939579.DvuYhMxLoT@rafael.j.wysocki> <a8d3fe252f5ed9d513c026331eeabfe5971196b1.camel@linux.intel.com>
In-Reply-To: <a8d3fe252f5ed9d513c026331eeabfe5971196b1.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 19:58:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hVPbU__=LZA1una8+1JSmGFytpBjBEXq2EuL_VOSYw2A@mail.gmail.com>
X-Gm-Features: AWmQ_bkcuYZN_3aiXuOj1GS8pTncdqvYhI5mHsCPvwQJeJ57BnL8AOo3PDnxS1E
Message-ID: <CAJZ5v0hVPbU__=LZA1una8+1JSmGFytpBjBEXq2EuL_VOSYw2A@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: Add sanity check for exit latency and target residency
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:47=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> On Fri, 2025-11-07 at 19:19 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make __cpuidle_driver_init() sanitize CPU idle states so that the exit
> > latency of a given state is not greater than its target residency which
> > would break cpuidle assumptions.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/driver.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > --- a/drivers/cpuidle/driver.c
> > +++ b/drivers/cpuidle/driver.c
> > @@ -193,6 +193,16 @@ static void __cpuidle_driver_init(struct
> >                       s->exit_latency_ns =3D  0;
> >               else
> >                       s->exit_latency =3D div_u64(s->exit_latency_ns, N=
SEC_PER_USEC);
> > +
> > +             /*
> > +              * Ensure that the exit latency of a CPU idle state does =
not
> > +              * exceed its target residency which is assumed in cpuidl=
e in
> > +              * multiple places.
> > +              */
> > +             if (s->exit_latency_ns > s->target_residency_ns) {
> > +                     s->target_residency_ns =3D s->exit_latency_ns;
> > +                     s->target_residency =3D s->exit_latency;
> > +             }
>
> I suggest to error out instead of capping it. Because as soon as you
> cap it, you may end up with the target residency of the next C-state.

Good point.

> Just erroring out is very explicit, no surprises, and the table
> provider will have to just fix the table.

Alternatively, the state may just be dropped, but let's try with
failing to begin with.

