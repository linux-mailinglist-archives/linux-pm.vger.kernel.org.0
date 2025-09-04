Return-Path: <linux-pm+bounces-33849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898C8B440EF
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A6DA02DA0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80B428AB0B;
	Thu,  4 Sep 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ormsN1Pv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845EB28135D
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000698; cv=none; b=CK2kjabJf3rAZ5E2T2hTroDUZifqCNei1+CXXU5AmdnvJYlawFBKvO8VmVLcpYQl9xL60HvZaWxdQ9QTeNHKSPTCEzbonCHRTnq280q4GOwFVKiXbUpT52n6H1Gfj8eKHa1OhkPGk45d9dcp2TxZvOWyOKXke44p3+FSJuoCqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000698; c=relaxed/simple;
	bh=za/FMiQ/hrpNWhQeSF++BbIPhItA+YemcLYTLk5VdTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEH4cOOSXhsMS8JKERwi74kSon7hnlJaPXJsxK2WH+exzkt1KhR8XMIJPGqhJfhptk1JJbzzkPp3vovh8CsbZF66p8SfPGmUI+TYOsgNvIBLx9vYJwKGabi0rKc7avkZdze1DvAcwZerEsYI0sHR/1hIcgJeB2yl9k1T4/GwLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ormsN1Pv; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-723ae0bb4e4so13863217b3.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757000695; x=1757605495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w2+tlcyWq8T/KHaJV31sRbGd0JRKtIIi6oR1Re9mq0U=;
        b=ormsN1PvwzscMmI1TpiLAJEyyv52eIqWMv4F+QDbCg2HKKAxK/JVriu1yJ0MlQ9Rut
         qovFTyHo2QdsrkwoGCwnrXWY/5t765o1KtgO5h5eJQgK3BLazKYsLWAZDjC2Smxq1U6B
         ZJBdzxxeGcfsync4Ew/7URwYcUt/nwllKRMNxp4GqpAtRbQzaTU0fJB0IDX0R3PlFiwv
         Hh0AZs+RehWUB++z3YNStxsM14ZAALR1TgpDvSGjUnbIEOje09mHDCmQ4r9hFXUVvul8
         6c3uKVDPEuHKFuZYXjUUvJXcFcvEIjw9PCRFIbl7ixl8UrYH/VrXEMouesMAJo3jEA+e
         WwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757000695; x=1757605495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2+tlcyWq8T/KHaJV31sRbGd0JRKtIIi6oR1Re9mq0U=;
        b=bJ5GvhdTuM/LmSq8TRCP/4flI/q6OS+Zgu0xmleL84OsNaTFaA3Hu0E0BKen43ErIH
         w1iblhQKSBxm/09j1witgroILrtbtC5oAaK8qFHuBARiHSVN9hFzepzG9yzoIP3sbblG
         zw0Z4lI1vwy/D2HbDF2VW6iDX5ZAOxRSpAp0uw9tNKBIptfXoXYRq0GyLDBrwgYHioNp
         i8NDHZKG9fkpU28POI7pkTMaP1Q81fdP9fP+jcwz3Qix4MDpcIT87MDZhj3FGxHolpa2
         /fLNp4/lQf6Fad8ujto9hoQJ+ODljxhjCAQEKkoDxXt7ILkfzICjOgtDQd4sCuBN9zs2
         2i9A==
X-Forwarded-Encrypted: i=1; AJvYcCUVh55awvNXuHB5oEx6DRspTgVsHWd6+51fHykf8EvzcvZLPAdWOcekFiRX7MQLHg3Nv8TTuFap4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpS2krq/2GaSNfYjg6z8hl47SXdYwrqCybMZ6at0RE7BWwcgon
	0prR0BLJJe0oUMeG6QNtZR9+7LIn7MPfrZZn+PYjg9bHOLnpG2hanrlEEeh843LcsSMG0x6uBCP
	+lR7p3PGwblgUSLUgwtV1fwISL2DzRr4gBV8HS5EatQ==
X-Gm-Gg: ASbGnctyd6UwRWWIh0Ittk6fB5kS9PwIPFBweA7i1rFVMs9eD+GUEEMs5ztwnHmFTjw
	xPkdjoNJknQzCxYwGICRHeF/3WqF+uHEUqTAfvBUK7o+Cj9y/FlBYe3MdvtThVMdTdMFfnXTi9d
	AVIhhvYgBrMTfMbGbc1h+7k+JKrA3HLYHo3u1a7dvrdnxB7af1TS3gHMeS4tAGWJ/a36ofRQsSL
	xGLlWCm
X-Google-Smtp-Source: AGHT+IF5yg3THOmLr52f+Mb5IMiiVxDSJvgG/pjXHtGs/D1ZpA/dULwb5bjzrsVPTTLbrDXBjm00C3Fn/D3DeSqJZI8=
X-Received: by 2002:a05:690c:4512:b0:71a:42a3:7b47 with SMTP id
 00721157ae682-722761340fdmr208616477b3.0.1757000695183; Thu, 04 Sep 2025
 08:44:55 -0700 (PDT)
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
 <CAPDyKFr-mVbGo62Wp+othcs+cWR6Wn9bz==ZB5hSpyKgkGtqHg@mail.gmail.com> <CAMuHMdUAhsZMbkUzwb=XnCNyvA3aOvuhkKL4=1nOPQ0w0if-HA@mail.gmail.com>
In-Reply-To: <CAMuHMdUAhsZMbkUzwb=XnCNyvA3aOvuhkKL4=1nOPQ0w0if-HA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 17:44:19 +0200
X-Gm-Features: Ac12FXwVls7vb6lB0gSoy-5SLukvLoftJ9gYC6D8h2w17T4ACoTGb-y-2NvXtd4
Message-ID: <CAPDyKFrWv3ObciCtrb4YE_K6to5xxx79DGcPv0=nP9LR60=xYA@mail.gmail.com>
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

On Thu, 4 Sept 2025 at 14:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Thu, 14 Aug 2025 at 17:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 13 Aug 2025 at 13:58, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, 12 Aug 2025 at 12:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > On Thu, 7 Aug 2025 at 11:38, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Wed, 30 Jul 2025 at 12:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > > Changes in v3:
> > > > > > > > >         - Added a couple of patches to adress problems on some Renesas
> > > > > > > > >         platforms. Thanks Geert and Tomi for helping out!
> > > > > > > > >         - Adressed a few comments from Saravanna and Konrad.
> > > > > > > > >         - Added some tested-by tags.
> > > > > > > >
> > > > > > > > I decided it was time to give this a try, so I have queued this up for
> > > > > > > > v6.17 via the next branch at my pmdomain tree.
> > > > > > > >
> > > > > > > > If you encounter any issues, please let me know so I can help to fix them.
> > > > > > >
> > > > > > > Thanks for your series!  Due to holidays, I only managed to test
> > > > > > > this very recently.
> > > > > > >
> > > > > > > Unfortunately I have an issue with unused PM Domains no longer being
> > > > > > > disabled on R-Car:
> > > > > > >   - On R-Car Gen1/2/3, using rcar-sysc.c, unused PM Domains are never
> > > > > > >     disabled.
> > > > > > >   - On R-Car Gen4, using rcar-gen4-sysc.c, unused PM Domains are
> > > > > > >     sometimes not disabled.
> > > > > > >     At first, I noticed the IOMMU driver was not enabled in my config,
> > > > > > >     and enabling it did fix the issue.  However, after that I still
> > > > > > >     encountered the issue in a different config that does have the
> > > > > > >     IOMMU driver enabled...
> > > > > > >
> > > > > > > FTR, unused PM Domains are still disabled correctly on R/SH-Mobile
> > > > > > > (using rmobile-sysc.c) and on BeagleBone Black. Note that these use
> > > > > > > of_genpd_add_provider_simple(), while all R-Car drivers use
> > > > > > > of_genpd_add_provider_onecell().  Perhaps there is an issue with
> > > > > > > the latter?  If you don't have a clue, I plan to do some more
> > > > > > > investigation later...
> > > > >
> > > > > of_genpd_add_provider_onecell() has:
> > > > >
> > > > >     if (!dev)
> > > > >             sync_state = true;
> > > > >     else
> > > > >             dev_set_drv_sync_state(dev, genpd_sync_state);
> > > > >
> > > > >     for (i = 0; i < data->num_domains; i++) {
> > > > >             ...
> > > > >             if (sync_state && !genpd_is_no_sync_state(genpd)) {
> > > > >                     genpd->sync_state = GENPD_SYNC_STATE_ONECELL;
> > > > >                     device_set_node(&genpd->dev, fwnode);
> > > > >                     sync_state = false;
> > > > >                     ^^^^^^^^^^^^^^^^^^^
> > > > >             }
> > > > >             ...
> > > > >     }
> > > > >
> > > > > As the R-Car SYSC drivers are not platform drivers, dev is NULL, and
> > > > > genpd->sync_state is set to GENPD_SYNC_STATE_ONECELL for the first PM
> > > > > Domain only.  All other domains have the default value of sync_state
> > > > > (0 = GENPD_SYNC_STATE_OFF).  Hence when genpd_provider_sync_state()
> > > > > is called later, it ignores all but the first domain.
> > > > > Apparently this is intentional, as of_genpd_sync_state() tries to
> > > > > power off all domains handled by the same controller anyway (see below)?
> > > >
> > > > Right, this is intentional and mainly because of how fw_devlink works.
> > > >
> > > > fw_devlink is limited to use only the first device - if multiple
> > > > devices share the same fwnode. In principle, we could have picked any
> > > > of the devices in the array of genpds here - and reached the same
> > > > result.
> > >
> > > OK, just like I already assumed...
> > >
> > > > > > > BTW, the "pending due to"-messages look weird to me.
> > > > > > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > > > > > >
> > > > > > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
> > > > > > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> > > > > > > due to e6020000.watchdog
> > > > > > >
> > > > > > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > > > > > the watchdog resides in the always-on Clock Domain, and uses the
> > > > > > > clock-controller for PM_CLK handling.
> > > > >
> > > > > Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
> > > > > these bogus pending states, and no PM Domain is powered off.
> > > >
> > > > I see, thanks for the details. I am looking closer at this.
> > > >
> > > > In any case, this is the main issue, as it prevents the ->sync_state()
> > > > callback to be called. Hence the "genpd->stay_on" will also *not* be
> > > > cleared for any of the genpd's for the genpd-provider.
> > >
> > > I was under the impression there is a time-out, after which the
> > > .sync_state() callback would be called anyway, just like for probe
> > > deferral due to missing optional providers like DMACs and IOMMUs.
> > > Apparently that is not the case?
> >
> > The behaviour is configurable, so it depends. The current default
> > behaviour does *not* enforce the ->sync_state() callbacks to be
> > called, even after a time-out.
> >
> > You may set CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT to achieve the above
> > behavior or use the fw_devlink command line parameters to change it.
> > Like setting "fw_devlink.sync_state=timeout".
> >
> > I guess it can be debated what the default behaviour should be.
> > Perhaps we should even allow the default behaviour to be dynamically
> > tweaked on a per provider device/driver basis?
>
> The domains are indeed powered off like before when passing
> "fw_devlink.sync_state=timeout", so that fixes the regression.
> But it was not needed before...

Right, the default behavior in genpd has changed. The approach was
taken as we believed that original behavior was not correct.

Although, the current situation isn't good as it causes lot of churns for us.

>
> I could add "select FW_DEVLINK_SYNC_STATE_TIMEOUT" to the SYSC_RCAR
> and SYSC_RCAR_GEN4 Kconfig options, but that would play badly with
> multi-platform kernels.  As the fw_devlink_sync_state flag is static,
> the R-Car SYSC drivers can't just auto-enable the flag at runtime.
>
> Any other options? Perhaps a device-specific flag to be set by the PM
> Domain driver, and to be checked by fw_devlink_dev_sync_state()?

Something along those lines seems reasonable to me too.

However, the remaining question though, is what should be the default
behavior in genpd for this. Due to all the churns, we may want
something that is closer to what we had *before*, which means to
always use the timeout option, unless the genpd provider driver
explicitly requests to not to (an opt-out genpd config flag).

Saravana, it would be nice to get some thoughts from you are around
this? Does it make sense?

>
> > > > > If I remove the "sync_state = false" above, genpd_provider_sync_state()
> > > > > considers all domains, and does power down all unused domains (even
> > > > > multiple times, as expected).
> > > >
> > > > I think those are getting called because with the change above, there
> > > > is no device_link being tracked. As stated above, fw_devlink is
> > > > limited to use only one device - if multiple devices share the same
> > > > fwnode.
> > >
> > > Indeed.
> > >
> > > > In other words, the ->sync_state() callbacks are called even if the
> > > > corresponding consumer devices have not been probed yet.
> > >
> > > Hence shouldn't there be a timeout, as the kernel may not even have
> > > a driver for one or more consumer devices?
> >
> > See above.
> >
> > > > > Upon closer look, all "pending due to" messages I see claim that the
> > > > > first (index 0) PM Domain is pending on some devices, while all of
> > > > > these devices are part of a different domain (usually the always-on
> > > > > domain, which is always the last (32 or 64) on R-Car).
> > > > >
> > > > > So I think there are two issues:
> > > > >   1. Devices are not attributed to the correct PM Domain using
> > > > >      fw_devlink sync_state,
> > > > >   2. One PM Domain of a multi-domain controller being blocked should
> > > > >      not block all other domains handled by the same controller.
> > > >
> > > > Right, that's a current limitation with fw_devlink. To cope with this,
> > > > it's possible to enforce the ->sync_state() callback to be invoked
> > > > from user-space (timeout or explicitly) for a device.
>
> That needs explicit handling, which was not needed before.
>
> Perhaps the fw_devlink creation should be removed again from
> of_genpd_add_provider_onecell(), as it is not correct, except for
> the first domain?

There is nothing wrong with it, the behavior is correct, unless I
failed to understand your problem. To me the problem is that it is
just less fine grained, compared to using
of_genpd_add_provider_simple(). All PM domains that is provided by a
single power-domain controller that uses #power-domain-cells = <1>,
requires all consumers of them to be probed, to allow the sync_state
callback to be invoked.

If we could teach fw_devlink to take into account the
power-domain-*id* that is specified by the consumer node, when the
provider is using #power-domain-cells = <1>, this could potentially
become as fine-grained as of_genpd_add_provider_simple().

Saravana, do think we can extend fw_devlink to take this into account somehow?

>
> > > > Another option would be to allow an opt-out behavior for some genpd's
> > > > that are powered-on at initialization. Something along the lines of
> > > > the below.
> > > >
> > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Date: Tue, 29 Jul 2025 14:27:22 +0200
> > > > Subject: [PATCH] pmdomain: core: Allow powered-on PM domains to be powered-off
> > > >  during boot
> > >
> > > [...]
> > >
> > > I gave this a try (i.e. "| GENPD_FLAG_NO_STAY_ON" in rcar-sysc.c), but
> > > this doesn't make any difference.  I assume this would only work when
> > > actively calling genpd_power_off() (i.e. not from of_genpd_sync_state()
> > > or genpd_provider_sync_state())?
> >
> > Right. Thanks for testing!
> >
> > So, we may need to restore some part of the genpd_power_off_unused()
> > when CONFIG_PM_GENERIC_DOMAINS_OF is set. Without clearing
> > "genpd->stay_on".
> >
> > I can extend the patch, if you think it would make sense for you?
>
> I would applaud anything that would fix these regressions.
> Thanks!

While being mostly silent from my side for a while, I have been
continuing to evolve my test suite for sync_state tests. Wanted to
make sure I cover additional new corner cases that you have pointed
out for Renesas platforms.

That said, I have not observed any issues on my side, so it looks like
we are simply facing new behaviors that you have pointed out to be a
problem. In this regards, I think it's important to note that we are
currently only seeing problems for those genpds that are powered-on
when the provider driver calls pm_genpd_init(). Another simple option
is to power-off those PM domains that we know is not really needed to
be powered-on. Also not perfect, but an option.

Another option is something along the lines of what I posted, but
perhaps extending it to let the late_initcall_sync to try to power-off
the unused PM domains.

I will work on updating the patch so we can try it out - or perhaps
what you suggested above with a device-specific flag taken into
account by fw_devlink_dev_sync_state() would be better/sufficient you
think?

Kind regards
Uffe

