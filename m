Return-Path: <linux-pm+bounces-13217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0D965ECE
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF8A1F28D28
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC5F17DFE1;
	Fri, 30 Aug 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6cvODdy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782B17C7A5
	for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012912; cv=none; b=l21dRtx/2E81dT27XFQR+Jo5P/93kBgrEMFnhVlo/lXvu8bdMC7FbOsd6w7aiI/9h3E7UH6BNlxQMdGa+5fPMiVj9MAxIQNkb7xGBWH3xdhFrnqqs9nQTRkiagw+clDfUWcS+BoJUuDYyLdRrZt+QYiQkubUWZd0/H9EW4kpB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012912; c=relaxed/simple;
	bh=WKHyjE3GWAJVo9iMvBZPS4A1pN7WDzTJ8ZSgL8cSjms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqE7oNQAw/oF6iUHFhz0NMtforslBCIEioMZV9Fpx7LO14ThD4AVoFtC2eWTlmJWVgWIcpMwvBs2jyG4jdcNL5IgdvEQgz+9/rnvncmMvhHAGFtWf+ZAzemALv1ihl0NgdWSXAlNkxu0sbgiltK3fxQIaVc+ns0TXxalfWJQeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v6cvODdy; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso1740541276.1
        for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2024 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725012909; x=1725617709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UwkZJIL6lWhl6ByZiDGKwgiO886aZ7Ma/SrA3D4RrxQ=;
        b=v6cvODdys7plPt3vu8Eqr0XhICPBTt88oMP6Ko8Al5fdivava+zdXj1xvS/gyXExTI
         ZVm/1iwRG0TWtHZhTDrEddWmvm3CXqDcGx9dnWEuPytTmEYALrPDvzXHhu+ra2ogzu6N
         XDiz7pG5A/ZmSjw5PB3NkqvNhGrQVjPy5FD5VUJjBZ0oDydmI6FRsm52b1ewYrq9fsft
         mluuIsoVQXvU9mC5P+CT2K2BLEfYs/7RzNn2PHxzji5A4jmIrX4HdJWoVRUjddgCC8/v
         mXji55ZTMyM5A/JqXlfsI8zxve7NxUW+2KkyTuA/qg5DejTMOti/W3PBzHidY04pKb7L
         ZnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012909; x=1725617709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwkZJIL6lWhl6ByZiDGKwgiO886aZ7Ma/SrA3D4RrxQ=;
        b=ugoTwq+/2YHb+17XMpzPAEc+/lzLQNjXZQ0lZ/W1FKm6rh2qDf/T/wUbS36oGCeFLt
         ic0WnLL95tXBtofIm27tiK3qhd01TH8xCSkaGPqTiR5mRRa0LnEglSvTPTXxgvr5IwYg
         KKU1VHNwRMGsUnvoqs9qMG4KjqnRMbCCHvXD52gSBvHn1jRLmOuKc7nfLsvC1yvZ89Uh
         fYFsom8aZKU21hN9bcTL3o9bBooWUgxqazW9EV7xTEynsB/8EZWId+pqSeA7f7gyc9Z2
         MObMI09h/9EKPtQ3YGfzs3VFbTTC8Wn4hjQWWrkNNNXrLUeQhTkTMzJOPR8QJFr9tMPE
         PMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMgaTSOr5oHmESIFA6eJEG40CLIxyWcaK97LOJkuIKTmC9vp58I7nCBxFwKtoAvmfAVcf6VfIj6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9nL0Kk9P5buTr8ZsJQVwhbZHrxhoQ8H/b/0xk21jEZ5xaRvS5
	tHz4lGucTEWyYoJc8uqbaoHr4tlG17YPtkU0EzU1VSJMgTpmdTEUCcjFKFBk306BxrWmCZjOutG
	AChEB3qCmtoccg7TfaJNfN6rDTQJo+XrUKt3HZg==
X-Google-Smtp-Source: AGHT+IENC1Eou3o76ET+fArBcJHz5tLkQ1M6jag1cqYy++ImNouJ6bItdx2SVPKjxSeyzrzWnSwjb3NJLNY42U4Z7/o=
X-Received: by 2002:a05:6902:1384:b0:e0e:cb25:c413 with SMTP id
 3f1490d57ef6-e1a7a1d369emr1888445276.52.1725012909519; Fri, 30 Aug 2024
 03:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com> <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
In-Reply-To: <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 Aug 2024 12:14:33 +0200
Message-ID: <CAPDyKFrVS2vpsJqTvjKCJ7ADqXc4D4k2eeCBsaK4T+=pXDnKUA@mail.gmail.com>
Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be, 
	magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, 
	sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com, 
	biju.das.jz@bp.renesas.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 10:22, claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>
> Hi, Ulf,
>
> On 29.08.2024 18:26, Ulf Hansson wrote:
> > On Thu, 22 Aug 2024 at 17:28, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >>
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Hi,
> >>
> >> Series adds initial USB support for the Renesas RZ/G3S SoC.
> >>
> >> Series is split as follows:
> >>
> >> - patch 01/16           - add clock reset and power domain support for USB
> >> - patch 02-04/16        - add reset control support for a USB signal
> >>                           that need to be controlled before/after
> >>                           the power to USB area is turned on/off.
> >>
> >>                           Philipp, Ulf, Geert, all,
> >>
> >>                           I detailed my approach for this in patch
> >>                           04/16, please have a look and let me know
> >>                           your input.
> >
> > I have looked briefly. Your suggested approach may work, but I have a
> > few thoughts, see below.
> >
> > If I understand correctly, it is the consumer driver for the device
> > that is attached to the USB power domain that becomes responsible for
> > asserting/de-asserting this new signal. Right?
>
> Right!
>
> >
> > In this regard, please note that the consumer driver doesn't really
> > know when the power domain really gets powered-on/off. Calling
> > pm_runtime_get|put*() is dealing with the reference counting. For
> > example, a call to pm_runtime_get*() just makes sure that the PM
> > domain gets-or-remains powered-on. Could this be a problem from the
> > reset-signal point of view?
>
> It should be safe. From the HW manual I understand the hardware block is
> something like the following:
>
>
>                   USB area
>          +-------------------------+
>          |                         |
>          | PHY --->USB controller  |
> SYSC --> |  ^                      |
>          |  |                      |
>          | PHY reset               |
>          +-------------------------+
>
> Where:
> - SYSC is the system controller that controls the new signal for which
>   I'm requesting opinions in this series
> - PHY reset: is the block controlling the PHYs
> - PHY: is the block controlling the USB PHYs
> - USB controller: is the USB controller
>
> Currently, I passed the SYSC signal handling to the PHY reset driver; w/o
> PHY reset the rest of the USB logic cannot work (neither PHY block nor USB
> controller).
>
> Currently, the PHY reset driver call pm_runtime_resume_and_get() in probe
> and pm_runtime_put() in remove. The struct reset_control_ops::{assert,
> deassert} only set specific bits in registers (no pm_runtime* calls).

Thanks for clarifying!

For my understanding, in what register range do these bits belong? Is
it the USB logic or in the PM domain logic, or something else.

>
> The PHY driver is taking its PHY reset in probe and release it in remove().
> With this approach the newly introduced SYSC signal will be
> de-asserted/asserted only in the PHY reset probe/remove (either if it is
> handled though PM domain or reset control signal).
>
> If the SYSC signal would be passed to all the blocks in the USB area (and
> it would be handled though PM domains) it should be no problem either,
> AFAICT, because of reference counting the pm_runtime_get|put*() is taking
> care of. As the PHY reset is the root node the in the devices node tree for
> USB the reference counting should work, too (I may miss something though,
> please correct me if I'm wrong).
>
> If the SYSC signal would be handled though a reset control driver (as
> proposed in this series) and we want to pass this reference to all the
> blocks in the USB area then we can request the reset signal as shared and,
> AFAIK, this is also reference counted. The devices node tree should help
> with the order, too, if I'm not wrong.

Reference counting a reset signal sounds a bit weird to me, but I
guess it can work. :-)

To sum up from my side;

As long as it's fine that we may end up asserting/de-asserting the
reset-signal, without actually knowing if the PM domain is getting
turn-on/off, then using a reset-control like what you propose seems
okay to me.

If not, there are two other options that can be considered I think.
*) Using the genpd on/off notifiers, to really allow the consumer
driver of the reset-control to know when the PM domain gets turned
on/off.
**) Move the entire reset handling into the PM domain provider, as it
obviously knows when the domain is getting turned on/off.

Thanks again for your explanations!

Kind regards
Uffe

