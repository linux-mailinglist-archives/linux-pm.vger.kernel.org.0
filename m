Return-Path: <linux-pm+bounces-34964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F3B853B1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 16:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201051C87E8F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B891030C34F;
	Thu, 18 Sep 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FY1PXBLQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39A30FF27
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205151; cv=none; b=E9zxhz494wsDuzGb80p2KBzgjefoBvVX0WvfTPHuMwnQ7OcUYJ4se87W7Gc/roiY98q0S5lgRqJ+fPvLKz5NMr0xETCJTwhbO1qayAmV9c2JBdqdkOpkyAaD207BXM4UM9RtGbyL4TjJQzF6lDrrJCBnCVVEjwMrGYJxFT9s5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205151; c=relaxed/simple;
	bh=efV7ND5peOzZ6wFre05dZsI2sW9Mwg+FnrXTj0ULe04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeA1p1e1KMSucytk0+XAHMyjXqZ/JPKLFBpWBcPPWgL5eRyOg9o+Fjgh/lI1Wn3uVrxda/mxmcV8f7kCZ5UjTsMeRKL2Og54mYV3R+8JyPau2uSYID0AMwuUgCrsaoWuFke/Hpeyz7SRzrOFMZ6omezv1bvorQ0OP1KwxO7pgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FY1PXBLQ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60501806so8390757b3.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758205149; x=1758809949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwnJ7MfncjQZZqEO7RPiB5wvlA6TdyUbKRJ/WpUXEpc=;
        b=FY1PXBLQW7nyZrUWVKrDHMIsBsJSdJjNWVsRJRCKwHuSlAwV9XIxG7Pr40MjxY4/wm
         7rwDY/TNygK4sLnCKqN4moCCuhjbEwdc5/fkDJk5h1KD8CDb1auRcHmeqy00tXn9gj5w
         R/3zF40CbHsvkzpJZQ+g71AgvBg8IuFwX/hjKzde9N4ptRmc4RM6igGaVd8CCp6MeycS
         KzjnMgQ7QZaqIjlcUtmKpkJjIuWYRJyqptse0It3YUADaAeO6tbtMiH0xDRdgIzj1kGU
         tNO1D4tx19AZ7v39laPYSMERNAgR4UHqXbMAvog/OqJWE/grfwxqddymT99aOBS/YK7Z
         Qk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205149; x=1758809949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwnJ7MfncjQZZqEO7RPiB5wvlA6TdyUbKRJ/WpUXEpc=;
        b=FxBmIThNiAuBDCYT+g5Vj/HcwVtXxM3VjB89X9K6VE3CQ77j9Q7bH5/36+UKT6LC2f
         p7JvjYkP0HpFxSpu1NuKgUVtbgMRvW3TDtTwg5kmkUJlAF//Vehyo8pNhRQEWcMBS4F1
         fPXK0yhCXwQdZZOTRxJJtSFrEQY/+KFBD0IGtqBXQhIZqmZkMn2PAH1HR9LUavS7qlgo
         hM9vowrhGfMbhGxL/xIv6DZTUPcmh1p7UaWAc7m29JfXyROh6lfdcN4u9jdVBFs+HPsv
         rmtBddlNy9Pp6YS/kX8znRc31QC9CofCt3T8tvDAtyGIXR7TTJU1M2RO7xVv5U51wY4t
         McUA==
X-Forwarded-Encrypted: i=1; AJvYcCUOFukZGtMhvC20ftgfi5+q39faLL3FxLLnFqT0ODF2Qn7yfoaG0Vh7w6toL8fLDH5AQLodkQfHLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWAmPN+9i3r8Wu4Eo9at/snXLBEk4MQxPCFlJ/fTpqShJOF8R
	e93ka2zUR8SZj3bDYo7I7JillEGVJF6SXQ3Fg6kHaPCQV4V2vMHhql0LDUOfc5mLn6TGnnWWFGG
	ntsgehWIpv/rK76+BvYkeeRkT/67UavEWw6nnVE7Ymg==
X-Gm-Gg: ASbGncsB6DWCttHHQLDTKrbiJLR/QNTEVgGt+R4RYOy81huOJRmfnK6vVCECkciZneI
	d1uZ6d4PLd9caVk7Fzal955ZeD7qvcBlIuy/VbeVPCxnlxaDWqGS3pp4IdfKEhQxM0gvA7PIiSH
	F5sP+qPMVfqtS65Lsz/nc0Syq5FLtkxQGu0T/3X48+L/I4dJ+WpsJ1FZCrfFe7AXMi0z9X5wSwH
	Xl+gCIPI61BIpBolX5eWgO85X4=
X-Google-Smtp-Source: AGHT+IFja2SGfrTtCyPdRJCCefTmrgo0mQhH1O6x561N6cabqmvG2QM8w3ohhfxToBTf2XJdX84zA191m+AeXdLVuso=
X-Received: by 2002:a05:690c:3582:b0:735:8634:be68 with SMTP id
 00721157ae682-73890cb0553mr52912587b3.23.1758205148353; Thu, 18 Sep 2025
 07:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com> <20250902-pm-v3-1-ffadbb454cdc@nxp.com>
 <20250918095950.h7wmz2qj5e6khtwr@lcpd911> <20250918131230.GD9196@nxa18884-linux.ap.freescale.net>
 <20250918134039.zkpeqsbf6m2ymxvt@lcpd911>
In-Reply-To: <20250918134039.zkpeqsbf6m2ymxvt@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Sep 2025 16:18:32 +0200
X-Gm-Features: AS18NWB-C7Q2eLiy5k262B4Ual4xN_o15_I0cJZ8lRcTd3E2RvJskp1XeHp2s5E
Message-ID: <CAPDyKFrweJTBHfOOU5r8Lcfs-dsTj94A=JK8+jKDqwJ0jNfiQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] pmdomain: core: Introduce device_set/get_out_band_wakeup()
To: Peng Fan <peng.fan@oss.nxp.com>, Dhruva Gole <d-gole@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, imx@lists.linux.dev, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 15:40, Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Peng,
>
> On Sep 18, 2025 at 21:12:30 +0800, Peng Fan wrote:
> > Hi Dhruva,
> >
> > On Thu, Sep 18, 2025 at 03:29:50PM +0530, Dhruva Gole wrote:
> > >On Sep 02, 2025 at 11:33:00 +0800, Peng Fan wrote:
> > >> For some cases, a device could still wakeup the system even if its power
> > >> domain is in off state, because the device's wakeup hardware logic is
> > >> in an always-on domain.
> > >>
> > >> To support this case, introduce device_set/get_out_band_wakeup() to
> > >> allow device drivers to control the behaviour in genpd for a device
> > >> that is attached to it.
> > >>
> > >
> > >Thinking more into it, to me it seems like if the intent here is to only
> > >allow the device drivers to figure out whether they should be or not be
> > >executing the suspend/resume_noirqs then that can still be checked by
> > >wisely using the device set_wakeup APIs in the driver itself.
> > >
> > >Not sure why this patch should be necessary for a
> > >driver to execute the suspend_noirq or not. That decision can very well
> > >be taken inside the driver's suspend resume_noirq hooks based on wakeup
> > >capability and wake_enabled statuses.
> >
> > I should join today's SCMI meeting, but something else caught me (:
>
> It's alright, maybe see you in the next one ;)
>
> >
> > Thanks for looking into this.
> >
> > In genpd_suspend_finish, genpd_sync_power_off will be called if
> > "(device_awake_path(dev) && genpd_is_active_wakeup(genpd))" is false.
> > So if the device is enabled wakeup, the genpd will not be turned off because
> > the check return true.
>
> Umm I think this device_awake_path stuff is only going to be true when
> someone calls device_set_wakeup_path, I don't think it is going to
> return true for a wakeup_capable device. I know all these "wakeup"
> terminology and APIs have become all too confusing :( , so maybe Ulf can
> correct me.

The PM core checks device_may_wakeup() in device_suspend() and then
sets dev->power.wakeup_path = true;

The device_set_awake_path() and device_awake_path(), is to allow
drivers/subsystems to enforce its device to stay powered-on during
system-wide suspend. This may be needed even if the device isn't
configured to deliver system-wakeups.

> I maybe misremembering, but I have seen in some cases where a driver may
> have marked itself wakeup_capable but the suspend hooks still do get
> called... So your concern about genpd_sync_power_off not being called
> due to wakeup capable device driver may not be valid... Again please
> feel to correct me if I am wrong.

The system PM callbacks should get called no matter what.

The problem Peng pointing out, is when genpd_suspend_noirq() (which
calls genpd_finish_suspend()) is called for a device that is attached
to a genpd, we may end up bailing out, preventing the power-off for
its PM domain, while it may be perfectly fine to allow the PM domain
to be powered-off.

The particular code we are looking at, is in genpd_finish_suspend():

        if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
                return 0;

>
> Did you also look at the wake IRQ stuff I mentioned?
> In the path you're talking about it just checks
> device_awake_path(dev) && genpd_is_active_wakeup(genpd)
> However if the device irq is just marked as a wake IRQ, I don't think
> that is checked anywhere in this path. So definitely if the IRQ of your
> device is set as a wake IRQ, it will still get suspended and resumed as
> usual and that's what you want right?

The missing piece for the wake_irq, is to know whether the interrupt
can be delivered via an out-band-powered-on-logic, thus without
requiring the device to stay powered-on during system suspend.

[...]

Kind regards
Uffe

