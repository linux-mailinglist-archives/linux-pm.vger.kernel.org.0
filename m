Return-Path: <linux-pm+bounces-33976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6184EB455C4
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 13:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3884918946EF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B931341AC8;
	Fri,  5 Sep 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EY3P8DkF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5B34166A
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070599; cv=none; b=G9Mu1hlooMEGcsGZbQ/bAMUeknY+HSFh7PG4wc5p9lrKQQ6npLXsvxDiNUyI7RHaUn5ivij3NSt8l0ZwIQM4OObdo70ZrBFTK9hGF872eACgnDYPgbGe0iGFdBTRp2yd6um2JAd8x/U56tvBg9j3I8w2BoePJh56RdeLep+Q3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070599; c=relaxed/simple;
	bh=7ALH7IJrp4A6nmOz1p/n3wXjhY7VUyQresBwcjSPj14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvOTsP7/celcHT0RGCye4IvnRJqiuxnZsqHgiyj7NCjLpReurKQSBeoxfJ+b7EDDFLp7a9Mlyv7XbJk9pjmkYrch/ZdrdHiqVOxO1FHbM9v27HfQop485N+5tHNPXRaKUlZxndnQikd3zrnwB9W0jEW/3J6i4qKUYX3AXXcZ8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EY3P8DkF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e98b64d7000so1844007276.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757070596; x=1757675396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2JdXw4Qv1njBlO6xmYzVUcXa+L4DKBA78RJzciCH6Gs=;
        b=EY3P8DkFtoh53lUFqYoX/8zs9jbHFtCA3qmiqlBBjda3XXRs5ND5afjFfKsKkNZAtX
         vJ3dcIoyVeqC06YtOd3wKZlrlkcoZlZ89xcNX/h0hS+kK4z0OrVeJlSp6SH3RsMF4xkF
         mUetwiWRGzIMhIT6AhD3Yb5FRnS1jzqoRFt7vy5EMCHiAfR0ydtPTTc9yv0fSHlfMDC+
         A3yfDxSvv1FzkFxahy3XHWaO8HnUqWGqdLVgWvBwZyuar8FEcsXgeiChwYATj84W42tE
         7o64XKJUkB/aoASrrKcHvWSFWNRHxzkY5866P9XZ8XICqzjkFhQG4rBgJgMax1usFPyG
         IPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757070596; x=1757675396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JdXw4Qv1njBlO6xmYzVUcXa+L4DKBA78RJzciCH6Gs=;
        b=R6xQbOXF/R5jW6aTATQ69nw7W0+/zF6zRRliRWIxfoSeVrezRD8OvXBMV1TjwDXQM7
         fE1BDeinBKkFYrqx4kVcfaJbj6cxD0NXVkCkC2ZEJcuH0ebCRPxmOcW0iSp0WncolUWi
         2V8j+8Ma4xBoStvQ2tDwuS6EtSC6V+q/6JHnipzDaPkrNdH+DxQvvP9mVRW99Y2/nJRH
         InXEzljxzpZ9H6sP5dj42jtz5pKb9U2Qv7E9rO3LfsA+50GhgJITkEubhuwRVeqqaLQV
         R6bT0zpt2qxY22tP1DI7g8dz0hU3/zfP2BX1MoZzmylKdHVpqUzdK1Fs8lnhilbBdfl2
         TETA==
X-Forwarded-Encrypted: i=1; AJvYcCUEL/aGkTAnl4Gbo9X87Qyg8ZafpF8yiKpgTdgYAkxC+QjqJYZKyjWRgedthixhM1ej0RrBM4riAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCueuXPrwZfIKRBXCil0sLU2sh7bsWayG0zVosOXfqX48eUTI
	NwDmeaYSXsO1JMEwSHsfFKa5FP+XoGSoe+RxatAXPKDolbUYNoYwczvx0krL4rxNC2V6VbwIPcE
	DDavTQWxYVr7isEF+jjhscNU5K1BvuB00ZKGhvO89OQ==
X-Gm-Gg: ASbGncuiDEbE/atTmzI41k4MgHBlbXAcr2Asr+DL/4EEP9XvwFI0mJMCI0Fbbgstba+
	pkGNliDqBcGsGICXnVFatAjARGlkqylt/W3SXsOXwGc/AF/E1ngnNOotKOHVBs2SLmfyGbZ0Bq9
	JL5FKBSYmNulGblNCNIB3cfovXb7bx68NNgbq4TkfaHsi2s3e5tHTwdbYwJjrfnRLR0jiOoKuw8
	vV3FJm3aqewHQc8smE=
X-Google-Smtp-Source: AGHT+IGJvbbIlAC6F/9Nh1B+6nqGQfT+amUgoRJzoU9Ah54iDfe6pod7IY2Mz9W1QhgN1npg8B3ZwJzDinFuk2aB9V8=
X-Received: by 2002:a05:690e:15c7:b0:5f5:5d5:b1f5 with SMTP id
 956f58d0204a3-601774c10f2mr4510800d50.20.1757070596115; Fri, 05 Sep 2025
 04:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
 <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
 <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com>
 <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com>
 <CAPDyKFq7z9e9hEC9QWiYcaU=t+Gs_GgRurmK-+cNYp4xkhr5Ow@mail.gmail.com>
 <CAMuHMdU7W+f3nZ_ckHOFsmmK6V9HzK0-fNtcu8kgjTSeU89AqQ@mail.gmail.com>
 <CAPDyKFr-mVbGo62Wp+othcs+cWR6Wn9bz==ZB5hSpyKgkGtqHg@mail.gmail.com>
 <CAMuHMdUAhsZMbkUzwb=XnCNyvA3aOvuhkKL4=1nOPQ0w0if-HA@mail.gmail.com>
 <CAPDyKFrWv3ObciCtrb4YE_K6to5xxx79DGcPv0=nP9LR60=xYA@mail.gmail.com> <CAMuHMdXoLnQR_hB-jXeGxAudwwpFRcQjrQcCb8iYCOz32yHinw@mail.gmail.com>
In-Reply-To: <CAMuHMdXoLnQR_hB-jXeGxAudwwpFRcQjrQcCb8iYCOz32yHinw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 5 Sep 2025 13:09:20 +0200
X-Gm-Features: Ac12FXxAyk0DgxeOLPurHUdA5X-JyzT3WI7knde2ma8Q4W4KgpMj8w1PmU3YQLs
Message-ID: <CAPDyKFqvjeuXhk7H4nH80RY63QfKwGO_61UW=MJaU8Qiahbt3g@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[...]

> > > > > > > > > BTW, the "pending due to"-messages look weird to me.
> > > > > > > > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > > > > > > > >
> > > > > > > > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
> > > > > > > > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> > > > > > > > > due to e6020000.watchdog
> > > > > > > > >
> > > > > > > > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > > > > > > > the watchdog resides in the always-on Clock Domain, and uses the
> > > > > > > > > clock-controller for PM_CLK handling.
> > > > > > >
> > > > > > > Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
> > > > > > > these bogus pending states, and no PM Domain is powered off.
> > > > > >
> > > > > > I see, thanks for the details. I am looking closer at this.
> > > > > >
> > > > > > In any case, this is the main issue, as it prevents the ->sync_state()
> > > > > > callback to be called. Hence the "genpd->stay_on" will also *not* be
> > > > > > cleared for any of the genpd's for the genpd-provider.
> > > > >
> > > > > I was under the impression there is a time-out, after which the
> > > > > .sync_state() callback would be called anyway, just like for probe
> > > > > deferral due to missing optional providers like DMACs and IOMMUs.
> > > > > Apparently that is not the case?
> > > >
> > > > The behaviour is configurable, so it depends. The current default
> > > > behaviour does *not* enforce the ->sync_state() callbacks to be
> > > > called, even after a time-out.
> > > >
> > > > You may set CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT to achieve the above
> > > > behavior or use the fw_devlink command line parameters to change it.
> > > > Like setting "fw_devlink.sync_state=timeout".
> > > >
> > > > I guess it can be debated what the default behaviour should be.
> > > > Perhaps we should even allow the default behaviour to be dynamically
> > > > tweaked on a per provider device/driver basis?
> > >
> > > The domains are indeed powered off like before when passing
> > > "fw_devlink.sync_state=timeout", so that fixes the regression.
> > > But it was not needed before...
> >
> > Right, the default behavior in genpd has changed. The approach was
> > taken as we believed that original behavior was not correct.
> >
> > Although, the current situation isn't good as it causes lot of churns for us.
>
> I did some more testing, and there seems to be a similar issue with
> DMA controllers, which I hadn't really noticed before, as I have
> DMAC drivers built-in in all my kernel configs.  If the (optional)
> DMAC driver is not available, you need "fw_devlink=permissive" to make
> drivers probe devices that have (optional) DMA support.

Well, after the deferred probe timeout, the missing supplier depency
should be ignored even if you don't have "permissive".

Typically we get a print in the log that could say:
"pm-test-drv pm_test24: deferred probe timeout, ignoring dependency"

... and then the driver-core tries probing the device anyway. It's
then up to the consumer driver to allow probing to succeed, even if
the DMA setup procedure fails.

> Interestingly, that is not the case with (optional) IOMMU support:
> drivers do probe devices that have (optional) DMA support when the
> latter is not available.

Okay, so some special treatments are already in place for IOMMUs, to
allow them to probe sooner, I guess. I don't know in detail how this
works, maybe Saravana can help to fill in?

Although my guess is that, by allowing IOMMUs to probe like this,
means that these drivers need to manage the DMA setup quite
differently.

The DMA driver (supplier) may probe and become available *after* the
IOMMU driver has probed. In other words, the IOMMU drivers then need
to manage the DMA setup even beyond probing.

>
> > > I could add "select FW_DEVLINK_SYNC_STATE_TIMEOUT" to the SYSC_RCAR
> > > and SYSC_RCAR_GEN4 Kconfig options, but that would play badly with
> > > multi-platform kernels.  As the fw_devlink_sync_state flag is static,
> > > the R-Car SYSC drivers can't just auto-enable the flag at runtime.
> > >
> > > Any other options? Perhaps a device-specific flag to be set by the PM
> > > Domain driver, and to be checked by fw_devlink_dev_sync_state()?
> >
> > Something along those lines seems reasonable to me too.
> >
> > However, the remaining question though, is what should be the default
> > behavior in genpd for this. Due to all the churns, we may want
> > something that is closer to what we had *before*, which means to
> > always use the timeout option, unless the genpd provider driver
> > explicitly requests to not to (an opt-out genpd config flag).
> >
> > Saravana, it would be nice to get some thoughts from you are around
> > this? Does it make sense?
> >
> > >
> > > > > > > If I remove the "sync_state = false" above, genpd_provider_sync_state()
> > > > > > > considers all domains, and does power down all unused domains (even
> > > > > > > multiple times, as expected).
> > > > > >
> > > > > > I think those are getting called because with the change above, there
> > > > > > is no device_link being tracked. As stated above, fw_devlink is
> > > > > > limited to use only one device - if multiple devices share the same
> > > > > > fwnode.
> > > > >
> > > > > Indeed.
> > > > >
> > > > > > In other words, the ->sync_state() callbacks are called even if the
> > > > > > corresponding consumer devices have not been probed yet.
> > > > >
> > > > > Hence shouldn't there be a timeout, as the kernel may not even have
> > > > > a driver for one or more consumer devices?
> > > >
> > > > See above.
> > > >
> > > > > > > Upon closer look, all "pending due to" messages I see claim that the
> > > > > > > first (index 0) PM Domain is pending on some devices, while all of
> > > > > > > these devices are part of a different domain (usually the always-on
> > > > > > > domain, which is always the last (32 or 64) on R-Car).
> > > > > > >
> > > > > > > So I think there are two issues:
> > > > > > >   1. Devices are not attributed to the correct PM Domain using
> > > > > > >      fw_devlink sync_state,
> > > > > > >   2. One PM Domain of a multi-domain controller being blocked should
> > > > > > >      not block all other domains handled by the same controller.
> > > > > >
> > > > > > Right, that's a current limitation with fw_devlink. To cope with this,
> > > > > > it's possible to enforce the ->sync_state() callback to be invoked
> > > > > > from user-space (timeout or explicitly) for a device.
> > >
> > > That needs explicit handling, which was not needed before.
> > >
> > > Perhaps the fw_devlink creation should be removed again from
> > > of_genpd_add_provider_onecell(), as it is not correct, except for
> > > the first domain?
> >
> > There is nothing wrong with it, the behavior is correct, unless I
> > failed to understand your problem. To me the problem is that it is
>
> It does print wrong and confusing warnings indicating the problem:
>
>     genpd_provider ca57-cpu0: sync_state() pending due to fe000000.pcie
>
> (no, the PCIe controller is not part of the CPU PM Domain)

That's a good point. We should fix this to avoid confusion.

>
> > just less fine grained, compared to using
> > of_genpd_add_provider_simple(). All PM domains that is provided by a
> > single power-domain controller that uses #power-domain-cells = <1>,
> > requires all consumers of them to be probed, to allow the sync_state
> > callback to be invoked.
>
> if it would be just coarse-grained, the link should be created to a
> device representing the controller, not to the device representing
> the first PM domain.
>
> > If we could teach fw_devlink to take into account the
> > power-domain-*id* that is specified by the consumer node, when the
> > provider is using #power-domain-cells = <1>, this could potentially
> > become as fine-grained as of_genpd_add_provider_simple().
> >
> > Saravana, do think we can extend fw_devlink to take this into account somehow?
>
> Doesn't the pmdomain core create a device for each PM domain, so the
> index could be used to link to the correct domain?

Correct, we have a device associated for each PM domain - and when
of_genpd_add_provider_onecell() is called, we get the index associated
for each of them.

If I understand your proposal, you are suggesting that genpd itself
creates the device_link between its corresponding device (supplier)
and the upcoming consumer device(s), at the point when
of_genpd_add_provider_onecell() is called, right?

It's an interesting idea, but I am not sure it will work. To create
the device_link at this point, assumes that all the consumer OF-nodes
have been populated (to have devices available for them). Maybe there
is an intermediate step we can take to instruct fw_devlink to treat
these "links" differently?

Saravana, any thoughts around this?

>
> > > > > > Another option would be to allow an opt-out behavior for some genpd's
> > > > > > that are powered-on at initialization. Something along the lines of
> > > > > > the below.
> > > > > >
> > > > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > Date: Tue, 29 Jul 2025 14:27:22 +0200
> > > > > > Subject: [PATCH] pmdomain: core: Allow powered-on PM domains to be powered-off
> > > > > >  during boot
> > > > >
> > > > > [...]
> > > > >
> > > > > I gave this a try (i.e. "| GENPD_FLAG_NO_STAY_ON" in rcar-sysc.c), but
> > > > > this doesn't make any difference.  I assume this would only work when
> > > > > actively calling genpd_power_off() (i.e. not from of_genpd_sync_state()
> > > > > or genpd_provider_sync_state())?
> > > >
> > > > Right. Thanks for testing!
> > > >
> > > > So, we may need to restore some part of the genpd_power_off_unused()
> > > > when CONFIG_PM_GENERIC_DOMAINS_OF is set. Without clearing
> > > > "genpd->stay_on".
> > > >
> > > > I can extend the patch, if you think it would make sense for you?
> > >
> > > I would applaud anything that would fix these regressions.
> > > Thanks!
> >
> > While being mostly silent from my side for a while, I have been
> > continuing to evolve my test suite for sync_state tests. Wanted to
> > make sure I cover additional new corner cases that you have pointed
> > out for Renesas platforms.
> >
> > That said, I have not observed any issues on my side, so it looks like
> > we are simply facing new behaviors that you have pointed out to be a
> > problem. In this regards, I think it's important to note that we are
> > currently only seeing problems for those genpds that are powered-on
> > when the provider driver calls pm_genpd_init(). Another simple option
> > is to power-off those PM domains that we know is not really needed to
> > be powered-on. Also not perfect, but an option.
> >
> > Another option is something along the lines of what I posted, but
> > perhaps extending it to let the late_initcall_sync to try to power-off
> > the unused PM domains.
>
> Yep, like before.

Okay!

>
> > I will work on updating the patch so we can try it out - or perhaps
> > what you suggested above with a device-specific flag taken into
> > account by fw_devlink_dev_sync_state() would be better/sufficient you
> > think?
>
> I also had a closer look at the few pending sync_state() pending
> warnings I do see on SH/R-Mobile SoCs.  Their PM Domain driver uses
> of_genpd_add_provider_simple() instead of of_genpd_add_provider_onecell().
> E.g. on R-Mobile A1:
>
>     genpd_provider a3sm: sync_state() pending due to f0100000.cache-controller
>     genpd_provider a4s: sync_state() pending due to fe400000.memory-controller
>     genpd_provider d4: sync_state() pending due to ptm
>
> All three domains were already handled specially in the PM Domain
> driver, as they must not be turned off, so these platforms didn't
> regress due to this series.

Okay!

Again the prints are confusing and annoying, but in principle we are
fine. Thanks for clarifying!

This also makes me wonder if we should skip enabling the fw_devlink
support for those genpds with "simple" providers that are special
(GENPD_FLAG_ALWAYS_ON and GENPD_FLAG_RPM_ALWAYS_ON). It doesn't make
sense to track consumers for them, I think.

[...]

Kind regards
Uffe

