Return-Path: <linux-pm+bounces-10882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8882692BE33
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 17:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F379BB22322
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F619D07C;
	Tue,  9 Jul 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4Q4VgRG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0E19CD0C
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538486; cv=none; b=dtnrj4VFcMZjox0bzhgzxCGTwBo8WsoWWXPfJ31CBZD3wML7JO8LWJzrsdbLNHDv20NiMsLj1TV3ggCwWetE0392MFu6Gdcg6xWK0UfTQYUTu5TmccJ3JI0Ruo59t2NC3InhKPdToOISlvB6mpFEyBFdo4aOwTgHBgn5IQi2+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538486; c=relaxed/simple;
	bh=JnqGX+NqSmCpgSLShW9xRhy64Jd1gG2A9mOPxMqFDNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MI8nB8Ss2UTLVIXsAWH0NI8/ZI+2AYzk+Snkwnt4ttJRZb56cXTa//WWhFdMF1vUgBqV0FweLZA4RXUovfDIDw2FiAJhp4mb+hxMAxSxAOeObI9oJQp0zfi+MDdq3b/ZASBaFXY8W0YxMGk8i4FR3Uy2g7RRLlOpNliqkObyv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4Q4VgRG; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso5503074276.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720538483; x=1721143283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ICl7/zRhEDU7+lYP8K9yTw1Jz5+/brpOoKv+lstlOO4=;
        b=v4Q4VgRGZhA79kUTppY3diTJHXMv8V2mi5R0cSUkcgpMMp7PBVzO+RmmJO1LMHvMsJ
         hYoGP0SXqM7deZ4Tv5nPFpqKTbLAT5/rBN+HV7Nc0lOdvkS40hMCqBs0lQYITm1feV98
         ywmqKfioQq84k41pLvIZKWtGv7qAvDJjzqEg8Sqm3/bpCRWL3OmpJTAOBpul34+BIqyM
         GcvJ6C9lk1QDtp2J3VePsCfRIp9vFeDw4KeFI53reCduEdY6mYH/HGBBJqP+WeDlycgh
         24QZMu5a4NwUV2J2+9tNHGdiZUm/MF4cyV2Ot4M+QnnZvxMJkrsPxAnkm1wpR7RxgRh8
         tcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538483; x=1721143283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICl7/zRhEDU7+lYP8K9yTw1Jz5+/brpOoKv+lstlOO4=;
        b=uP+qDv8qhwACScLlix8ma2CIqd2MYg8zLBm8AXYxMKs3bJfwPcozPcVGUhR9lKVCFR
         oivvxY5DAE9Km2CHQZ1LqGtvLHcv1TvtC2jaNIucAiJOWbDv+4W/gUWXmHoflndyZToi
         dW0wKR3kvlknl30FLjSQUAwfQ8Li0IxlLW7fxbPAvphn/cgACvZ8Y/nPgjMYCNzL26Ip
         z7iBLpdeH/tPhQlzTT2t7qRPuQrbS0OMLAJSMbJHYA448E1uny134im2D+sJ8AbdeJJu
         P9nvEksJ7hPLmZjDN460PCqYj8IHwmjxeVLvlmYC2jzH/G8j0wPXdxmIzhEin7bGzIe4
         SviQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFRX7G7/CdQX8ux1VaxU2QZq+Dje6M31Ti1p1NohIUEt4Lq+7VEddzo0rIfwffg/0qQpp37AjHF64mS0i6Ru2Yj9TmZZxTKlM=
X-Gm-Message-State: AOJu0Yw52BKqEkM5hqVxOdP60W+4kI3kkTh1O5YO/s/uSaZ/btEFdM3c
	pmR41g8ap97bWsTkKU4a/44T90D5jXvxeauONTltJ1sHzHFripKKrLA4GW0ZGQvfalrte2Rfpp8
	ugWWvB37tjEZft6kGAZgrt4dDY/BT6/rk7suIwA==
X-Google-Smtp-Source: AGHT+IEEAUwdlCn2/Ki0VmNsTPtfj2S/xTZsi8vYK2ZmZboTHZVvEXX6s9CJFnBiMKE9+CtvZNiEJj0wkmn4ulsV4X8=
X-Received: by 2002:a05:690c:30f:b0:643:ed61:11bb with SMTP id
 00721157ae682-658ee791041mr37664557b3.7.1720538483530; Tue, 09 Jul 2024
 08:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716811405.git.geert+renesas@glider.be> <CAPDyKFpa4LZF3eN7x-NT+b9=dKB3Oe6RY8RAyetdRBSR1-LQoQ@mail.gmail.com>
 <0a025885-ed95-45d3-bf76-d2a043baaed7@ideasonboard.com> <CAPDyKFrxUDhnUUfz5wHpGVQfNYssxoWO5Eb2wtmZMTcMYhEjxQ@mail.gmail.com>
 <1bda8e8f-10df-4a10-a217-26cf50ef3577@ideasonboard.com> <CAGETcx-T54w=x=gv524dUJtnRGmOiXFA2CRYHE5Pawbux8_Tig@mail.gmail.com>
 <CAMuHMdUTGLSDv-zAun7tV2VnN0q08PibBT9B-MhxqdwmRTA_UQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUTGLSDv-zAun7tV2VnN0q08PibBT9B-MhxqdwmRTA_UQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Jul 2024 17:20:46 +0200
Message-ID: <CAPDyKFpYvinCB3t7aNp02_-=QNwQr+B4wWvtzAAzYi8rTwKkKQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] pmdomain: renesas: rmobile-sysc: Remove serial
 console handling
To: Geert Uytterhoeven <geert@linux-m68k.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> > > >>>>
> > > >>>> However, if the serial port's clock or PM Domain is shared with another
> > > >>>> device, and that other device is runtime-suspended before the full
> > > >>>> serial driver has probed, the serial port's clock and/or PM Domain will
> > > >>>> be disabled inadvertently.  Any subsequent serial console output will
> > > >>>> cause a crash or system lock-up.  E.g. on R/SH-Mobile SoCs, the serial
> > > >>>> ports share their PM Domain with several other I/O devices.  After the
> > > >>>> use of pwm (Armadillo-800-EVA) or i2c (KZM-A9-GT) during early boot,
> > > >>>> before the full serial driver takes over, the PM Domain containing the
> > > >>>> early serial port is powered down, causing a lock-up when booted with
> > > >>>> "earlycon".
>
> Let's call this "Case B".
>
> > > >>>
> > > >>> Thanks for the detailed description of the problem! As pointed out in
> > > >>> regards to another similar recent patch [1], this is indeed a generic
> > > >>> problem, not limited to the serial console handling.
> > > >>>
> > > >>> At Linaro Connect a few weeks ago I followed up with Saravana from the
> > > >>> earlier discussions at LPC last fall. We now have a generic solution
> > > >>> for genpd drafted on plain paper, based on fw_devlink and the
> > > >>> ->sync_state() callback. I am currently working on the genpd series,
> > > >>> while Saravana will re-spin the series (can't find the link to the
> > > >>> last version) for the clock framework. Ideally, we want these things
> > > >>> to work in a very similar way.
> > > >>>
> > > >>> That said, allow me to post the series for genpd in a week or two to
> > > >>> see if it can solve your problem too, for the serial console.

I managed to hit the vacation period before I was able to post the
series. I will pick it up this week and hopefully should be able to
post something next week.

> > > >>
> > > >> Both the genpd and the clock solutions will make suppliers depend on all
> > > >> their consumers to be probed, right?
> > > >>
> > > >> I think it is a solution, and should be worked on, but it has the
> > > >> drawback that suppliers that have consumers that will possibly never be
> > > >> probed, will also never be able to turn off unused resources.
> > > >>
> > > >> This was specifically the case with the TI ti-sci pmdomain case I was
> > > >> looking at: the genpd driver (ti_sci_pm_domains.c) provides a lot of
> > > >> genpds for totally unrelated devices, and so if, e.g., you don't have or
> > > >> don't want to load a driver for the GPU, all PDs are affected.
> > > >>
> > > >> Even here the solutions you mention will help: instead of things getting
> > > >> broken because genpds get turned off while they are actually in use, the
> > > >> genpds will be kept enabled, thus fixing the breakage. Unfortunately,
> > > >> they'll be kept enabled forever.
> > > >>
> > > >> I've been ill for quite a while so I haven't had the chance to look at
> > > >> this more, but before that I was hacking around a bit with something I
> > > >> named .partial_sync_state(). .sync_state() gets called when all the
> > > >> consumers have probed, but .partial_sync_state() gets called when _a_
> > > >> consumer has been probed.
> > > >>
> > > >> For the .sync_state() things are easy for the driver, as it knows
> > > >> everything related has been probed, but for .partial_sync_state() the
> > > >> driver needs to track resources internally. .partial_sync_state() will
> > > >> tell the driver that a consumer device has probed, the driver can then
> > > >> find out which specific resources (genpds in my case) that consumer
> > > >> refers to, and then... Well, that's how far I got with my hacks =).
> > > >>
> > > >> So, I don't know if this .partial_sync_state() can even work, but I
> > > >> think we do need something more on top of the .sync_state().
> > > >
> > > > Thanks for the update!
> > > >
> > > > You certainly have a point, but rather than implementing some platform
> > > > specific method, I think we should be able enforce the call to
> > > > ->sync_state(), based upon some condition/timeout - and even if all
> > > > consumers haven't been probed.
> > >
> > > Hmm, I think that was already implemented in some of the serieses out
> > > there (or even in mainline already?), as I remember doing some
> > > experiments with it. I don't like it much, though.
> > >
> > > With a simple timeout, it'll always be just a bit too early for some
> > > user (nfs mount took a bit more time than expected -> board frozen).
> > >
> > > The only condition I can see that would somewhat work is a manual
> > > trigger from the userspace. The boot scripts could then signal the
> > > kernel when all the modules have been loaded and probably a suitable,
> > > platform/use case specific amount of time has passed to allow the
> > > drivers to probe.
> >
> > This is also already supported in mainline.
> >
> > Devices with sync_state() implementations (once Ulf adds it) will have
> > a state_synced file in sysfs. It shows where it has been called yet or
> > not. But you can also echo 1 into it to force the sync_state()
> > callback (only if it hasn't been called already). So, yeah, all
> > methods of handling this are available if you implement the
> > sync_state() callback.
> >
> > By default it's all strict (wait till all consumers probe
> > successfully). But you can set it to timeout (fw_devlink.sync_state).
> > And you also have the option I mentioned above that you can use with
> > both cases.
>
> So the idea is to disable unused genpds and clocks from the genpd
> resp. clock's driver .sync_state() callback, instead of from a late
> initcall?  That would indeed solve issues related to "Case A".
>
> However, how to solve "Case B"? Ignore disabling genpds or clocks
> before .sync_state() callback() has been called?
> That would cause issues for cases where the clock must be disabled,
> cfr.
>     "[PATCH RFC 0/3] Add clk_disable_unprepare_sync()"
>     https://lore.kernel.org/all/20240131160947.96171-1-biju.das.jz@bp.renesas.com/
>     "[PATCH v3 0/3] Add clk_poll_disable_unprepare()"
>     https://lore.kernel.org/linux-renesas-soc/20240318110842.41956-1-biju.das.jz@bp.renesas.com/
>

For genpd, the plan is to check the initial state of the PM domain. It
can be powered-on or powered-off and if it's powered-on, we should not
allow it to be powered-off until after ->sync_state() have been
called.

The similar approach is what Saravanna is trying to implement for
clocks, I think.

In the end, we simply need to try out these approaches to see if they
really work. Although, based on previous discussions (LKML +
F2F-conferences), I think there should be a good chance for us.

[...]

Kind regards
Uffe

