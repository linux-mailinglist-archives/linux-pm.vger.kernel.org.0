Return-Path: <linux-pm+bounces-33926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47A2B4503C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6676E584C27
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0C265637;
	Fri,  5 Sep 2025 07:50:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41601261B64;
	Fri,  5 Sep 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058604; cv=none; b=JJ3yEWhU8v42dP2sP0rtG2AcFs8ZVrprrYKKTy2a9Gi385bRCoFHbeSp/yBLAHdBN/NzO+0VpB6PDb7qqlXut05cA7grwlYkzMNmy5hAe2PQPu1j2MPx8DQ2ff8ODxC2xrgfXTLDuVlF3SRsD7riE0robt0huK8QcpMw0gsO2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058604; c=relaxed/simple;
	bh=+ptU5iuSMXJ8zcKk5D4/Y8OBmsov13j0Igo2eyHbUK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImHh4uLjblrVq1TRQwWklldwXTbYXb8fDvTVHdtg3zHuKukVo1jPm3N6KxUN3X4pFFV0PCjYtWkgtYkXR1Hk3TKTcmDhaoi79Umf5C9/xUX7ap0kDJoeB0Pom1yD/wjYVI+dVk8iyUgDlyM5wOL8QARVTVZIvHazvTrqqDpXErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-52a80b778e7so681360137.1;
        Fri, 05 Sep 2025 00:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757058601; x=1757663401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g41c13NWV9jwHMWvIm9LbxXNid7LZCSCocg1Kjw6o8M=;
        b=v/aLDQpDnYLNwXrO0d6q7sckZ6SVkzPv0mVIBLCC4n6L9ctVI3JqxVcS8qUnS9exc/
         CgVQ3H4HdJj9d+AFZPjCQ4lJW8TeTgcCq8/nkvmx/g9Xa8N7Umx7sSqiXMnFvLOeVn9k
         5/nea4TVLUmtesz8OHDhhNMg/UYZ4uM06u4m6eBwlE5tm9qfH3J68s2+0aLotoALwE8X
         t9lDJ5aLKhoQAqaEGOCdhILfJEhUOlUGPveUs4LaiIITktLjELPvMYw1KLcU/MBENUYb
         7tcn90ruGhaF6GG4Fm3BXIQaY7rqYzLAMrZGAkoSxnSkpKf80MbhMLx7rIUyegFoNGzT
         Yq6w==
X-Forwarded-Encrypted: i=1; AJvYcCVyQiwLY92bUxkoKAp6FW1cFCPZUe7C9EUVcJKu3px7YTB/+WoZwBmlJdIKihmevuOTyktipPHX2i4=@vger.kernel.org, AJvYcCWZ0qeGRXGuaXar+lG75BJuNRaLirsrf3gCZInNWAoR3h0OgNR3zHUKAZPPDYhy0yEXKDzPI95eBtlfrb0=@vger.kernel.org, AJvYcCXKEDQV1Bnhvnn5/tpa4rp0n8Gj8Y7WNOznxw2L3uByj5fDP3JQmKQshp/3hZ/RePpaG64P0uBT/Ud3lrJnG2I/mEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtBqgOUz6ZeN/MJcmwCs2jT7hhOIQv2dXjNufs/tIi+nEvgJb
	L8+TvisZ/nvsEmd2Kk7mGsQIYA4+HbdNaP02fZnifCXyUMo6Bdd/A5ZrcKSOMbMJ
X-Gm-Gg: ASbGncvKDzjDaUsJi/RsnlVZOIF8WEohFc3UaOV1zscNksocTDH0gOoYiqgvbZpn7o2
	++G0wc9pY9b84cRuYsjT1Qt+pvvR0aZMt4CJaaaTJNqzd86qZIi1TE9cBBnCbujjB8S3UV4BARl
	ty8Pw2g/UB7GcH2F5YLN7Mt4ECy7agTt/dLrmAkoyWZ9YzeV1xkfuYMPX7SQdqRiuNpcRu+3dkJ
	PsDBl3BpYLBb7slll+yd9GOLEe4fPqJlX47N51kk3D5+wYt1tlnC70YWveUUc91q5ifZjzwygqx
	4QCxP3PXOjSbOFUUOAdyQ2OdT/8XLd8v6nKtMnQ8QK2Q2vaZu3FlP9BFJMB7aLSSSblIgv6RxOH
	uLJ5PF0/1vV98GSqnQIolnIZ/W/Y/Fku/a8265SkE3Q7HqKMPsBbONoGSXVH5
X-Google-Smtp-Source: AGHT+IEZS6VH5wYzVwZRl6uowgP5aLIofQNGRdBcqnSqB05trWeQBOyc8xDPLOvT+kHNNW/L4gAUGg==
X-Received: by 2002:a05:6102:dcb:b0:523:fa25:9dcb with SMTP id ada2fe7eead31-52b19a52539mr7618483137.8.1757058600955;
        Fri, 05 Sep 2025 00:50:00 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8982751bf54sm4708269241.21.2025.09.05.00.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 00:50:00 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89e5b87f406so479396241.0;
        Fri, 05 Sep 2025 00:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4CBHzt8IffizkDKu4zTIQ+LDXO+apoXKjrprJEcSAp3C3duc9CViyBgEVgIjM1uLu5jC4m73yHUMdRDU=@vger.kernel.org, AJvYcCV957MiJiOaNgtDHaEag8gbV9q5+Fan+cUCpJlfsWM1XUeobfPHMv+TbxHqhtcDgUECqqIukGK3gAM=@vger.kernel.org, AJvYcCWrFhPEEZdg9CvWqPokrczehjutWsSjA5JrWZZ8z9tEUvr1iqqJIrlsdMxH/NRAN6Vv4xHoxBXYtAm54qsnnUk7P0E=@vger.kernel.org
X-Received: by 2002:a05:6102:4b84:b0:527:84e4:265 with SMTP id
 ada2fe7eead31-52b19534045mr8151301137.5.1757058600400; Fri, 05 Sep 2025
 00:50:00 -0700 (PDT)
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
 <CAMuHMdUAhsZMbkUzwb=XnCNyvA3aOvuhkKL4=1nOPQ0w0if-HA@mail.gmail.com> <CAPDyKFrWv3ObciCtrb4YE_K6to5xxx79DGcPv0=nP9LR60=xYA@mail.gmail.com>
In-Reply-To: <CAPDyKFrWv3ObciCtrb4YE_K6to5xxx79DGcPv0=nP9LR60=xYA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Sep 2025 09:49:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXoLnQR_hB-jXeGxAudwwpFRcQjrQcCb8iYCOz32yHinw@mail.gmail.com>
X-Gm-Features: Ac12FXxsmJginKpxd1Bb3DOpcRL3N2fGsIcySobleVuR7bO4K7fM-l9wOi9dDY0
Message-ID: <CAMuHMdXoLnQR_hB-jXeGxAudwwpFRcQjrQcCb8iYCOz32yHinw@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
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

Hi Ulf,

On Thu, 4 Sept 2025 at 17:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 4 Sept 2025 at 14:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 14 Aug 2025 at 17:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Wed, 13 Aug 2025 at 13:58, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, 12 Aug 2025 at 12:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > On Thu, 7 Aug 2025 at 11:38, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Wed, 30 Jul 2025 at 12:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > > On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > > > Changes in v3:
> > > > > > > > > >         - Added a couple of patches to adress problems on some Renesas
> > > > > > > > > >         platforms. Thanks Geert and Tomi for helping out!
> > > > > > > > > >         - Adressed a few comments from Saravanna and Konrad.
> > > > > > > > > >         - Added some tested-by tags.
> > > > > > > > >
> > > > > > > > > I decided it was time to give this a try, so I have queued this up for
> > > > > > > > > v6.17 via the next branch at my pmdomain tree.
> > > > > > > > >
> > > > > > > > > If you encounter any issues, please let me know so I can help to fix them.
> > > > > > > >
> > > > > > > > Thanks for your series!  Due to holidays, I only managed to test
> > > > > > > > this very recently.
> > > > > > > >
> > > > > > > > Unfortunately I have an issue with unused PM Domains no longer being
> > > > > > > > disabled on R-Car:
> > > > > > > >   - On R-Car Gen1/2/3, using rcar-sysc.c, unused PM Domains are never
> > > > > > > >     disabled.
> > > > > > > >   - On R-Car Gen4, using rcar-gen4-sysc.c, unused PM Domains are
> > > > > > > >     sometimes not disabled.
> > > > > > > >     At first, I noticed the IOMMU driver was not enabled in my config,
> > > > > > > >     and enabling it did fix the issue.  However, after that I still
> > > > > > > >     encountered the issue in a different config that does have the
> > > > > > > >     IOMMU driver enabled...
> > > > > > > >
> > > > > > > > FTR, unused PM Domains are still disabled correctly on R/SH-Mobile
> > > > > > > > (using rmobile-sysc.c) and on BeagleBone Black. Note that these use
> > > > > > > > of_genpd_add_provider_simple(), while all R-Car drivers use
> > > > > > > > of_genpd_add_provider_onecell().  Perhaps there is an issue with
> > > > > > > > the latter?  If you don't have a clue, I plan to do some more
> > > > > > > > investigation later...
> > > > > >
> > > > > > of_genpd_add_provider_onecell() has:
> > > > > >
> > > > > >     if (!dev)
> > > > > >             sync_state = true;
> > > > > >     else
> > > > > >             dev_set_drv_sync_state(dev, genpd_sync_state);
> > > > > >
> > > > > >     for (i = 0; i < data->num_domains; i++) {
> > > > > >             ...
> > > > > >             if (sync_state && !genpd_is_no_sync_state(genpd)) {
> > > > > >                     genpd->sync_state = GENPD_SYNC_STATE_ONECELL;
> > > > > >                     device_set_node(&genpd->dev, fwnode);
> > > > > >                     sync_state = false;
> > > > > >                     ^^^^^^^^^^^^^^^^^^^
> > > > > >             }
> > > > > >             ...
> > > > > >     }
> > > > > >
> > > > > > As the R-Car SYSC drivers are not platform drivers, dev is NULL, and
> > > > > > genpd->sync_state is set to GENPD_SYNC_STATE_ONECELL for the first PM
> > > > > > Domain only.  All other domains have the default value of sync_state
> > > > > > (0 = GENPD_SYNC_STATE_OFF).  Hence when genpd_provider_sync_state()
> > > > > > is called later, it ignores all but the first domain.
> > > > > > Apparently this is intentional, as of_genpd_sync_state() tries to
> > > > > > power off all domains handled by the same controller anyway (see below)?
> > > > >
> > > > > Right, this is intentional and mainly because of how fw_devlink works.
> > > > >
> > > > > fw_devlink is limited to use only the first device - if multiple
> > > > > devices share the same fwnode. In principle, we could have picked any
> > > > > of the devices in the array of genpds here - and reached the same
> > > > > result.
> > > >
> > > > OK, just like I already assumed...
> > > >
> > > > > > > > BTW, the "pending due to"-messages look weird to me.
> > > > > > > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > > > > > > >
> > > > > > > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
> > > > > > > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> > > > > > > > due to e6020000.watchdog
> > > > > > > >
> > > > > > > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > > > > > > the watchdog resides in the always-on Clock Domain, and uses the
> > > > > > > > clock-controller for PM_CLK handling.
> > > > > >
> > > > > > Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
> > > > > > these bogus pending states, and no PM Domain is powered off.
> > > > >
> > > > > I see, thanks for the details. I am looking closer at this.
> > > > >
> > > > > In any case, this is the main issue, as it prevents the ->sync_state()
> > > > > callback to be called. Hence the "genpd->stay_on" will also *not* be
> > > > > cleared for any of the genpd's for the genpd-provider.
> > > >
> > > > I was under the impression there is a time-out, after which the
> > > > .sync_state() callback would be called anyway, just like for probe
> > > > deferral due to missing optional providers like DMACs and IOMMUs.
> > > > Apparently that is not the case?
> > >
> > > The behaviour is configurable, so it depends. The current default
> > > behaviour does *not* enforce the ->sync_state() callbacks to be
> > > called, even after a time-out.
> > >
> > > You may set CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT to achieve the above
> > > behavior or use the fw_devlink command line parameters to change it.
> > > Like setting "fw_devlink.sync_state=timeout".
> > >
> > > I guess it can be debated what the default behaviour should be.
> > > Perhaps we should even allow the default behaviour to be dynamically
> > > tweaked on a per provider device/driver basis?
> >
> > The domains are indeed powered off like before when passing
> > "fw_devlink.sync_state=timeout", so that fixes the regression.
> > But it was not needed before...
>
> Right, the default behavior in genpd has changed. The approach was
> taken as we believed that original behavior was not correct.
>
> Although, the current situation isn't good as it causes lot of churns for us.

I did some more testing, and there seems to be a similar issue with
DMA controllers, which I hadn't really noticed before, as I have
DMAC drivers built-in in all my kernel configs.  If the (optional)
DMAC driver is not available, you need "fw_devlink=permissive" to make
drivers probe devices that have (optional) DMA support.
Interestingly, that is not the case with (optional) IOMMU support:
drivers do probe devices that have (optional) DMA support when the
latter is not available.

> > I could add "select FW_DEVLINK_SYNC_STATE_TIMEOUT" to the SYSC_RCAR
> > and SYSC_RCAR_GEN4 Kconfig options, but that would play badly with
> > multi-platform kernels.  As the fw_devlink_sync_state flag is static,
> > the R-Car SYSC drivers can't just auto-enable the flag at runtime.
> >
> > Any other options? Perhaps a device-specific flag to be set by the PM
> > Domain driver, and to be checked by fw_devlink_dev_sync_state()?
>
> Something along those lines seems reasonable to me too.
>
> However, the remaining question though, is what should be the default
> behavior in genpd for this. Due to all the churns, we may want
> something that is closer to what we had *before*, which means to
> always use the timeout option, unless the genpd provider driver
> explicitly requests to not to (an opt-out genpd config flag).
>
> Saravana, it would be nice to get some thoughts from you are around
> this? Does it make sense?
>
> >
> > > > > > If I remove the "sync_state = false" above, genpd_provider_sync_state()
> > > > > > considers all domains, and does power down all unused domains (even
> > > > > > multiple times, as expected).
> > > > >
> > > > > I think those are getting called because with the change above, there
> > > > > is no device_link being tracked. As stated above, fw_devlink is
> > > > > limited to use only one device - if multiple devices share the same
> > > > > fwnode.
> > > >
> > > > Indeed.
> > > >
> > > > > In other words, the ->sync_state() callbacks are called even if the
> > > > > corresponding consumer devices have not been probed yet.
> > > >
> > > > Hence shouldn't there be a timeout, as the kernel may not even have
> > > > a driver for one or more consumer devices?
> > >
> > > See above.
> > >
> > > > > > Upon closer look, all "pending due to" messages I see claim that the
> > > > > > first (index 0) PM Domain is pending on some devices, while all of
> > > > > > these devices are part of a different domain (usually the always-on
> > > > > > domain, which is always the last (32 or 64) on R-Car).
> > > > > >
> > > > > > So I think there are two issues:
> > > > > >   1. Devices are not attributed to the correct PM Domain using
> > > > > >      fw_devlink sync_state,
> > > > > >   2. One PM Domain of a multi-domain controller being blocked should
> > > > > >      not block all other domains handled by the same controller.
> > > > >
> > > > > Right, that's a current limitation with fw_devlink. To cope with this,
> > > > > it's possible to enforce the ->sync_state() callback to be invoked
> > > > > from user-space (timeout or explicitly) for a device.
> >
> > That needs explicit handling, which was not needed before.
> >
> > Perhaps the fw_devlink creation should be removed again from
> > of_genpd_add_provider_onecell(), as it is not correct, except for
> > the first domain?
>
> There is nothing wrong with it, the behavior is correct, unless I
> failed to understand your problem. To me the problem is that it is

It does print wrong and confusing warnings indicating the problem:

    genpd_provider ca57-cpu0: sync_state() pending due to fe000000.pcie

(no, the PCIe controller is not part of the CPU PM Domain)

> just less fine grained, compared to using
> of_genpd_add_provider_simple(). All PM domains that is provided by a
> single power-domain controller that uses #power-domain-cells = <1>,
> requires all consumers of them to be probed, to allow the sync_state
> callback to be invoked.

if it would be just coarse-grained, the link should be created to a
device representing the controller, not to the device representing
the first PM domain.

> If we could teach fw_devlink to take into account the
> power-domain-*id* that is specified by the consumer node, when the
> provider is using #power-domain-cells = <1>, this could potentially
> become as fine-grained as of_genpd_add_provider_simple().
>
> Saravana, do think we can extend fw_devlink to take this into account somehow?

Doesn't the pmdomain core create a device for each PM domain, so the
index could be used to link to the correct domain?

> > > > > Another option would be to allow an opt-out behavior for some genpd's
> > > > > that are powered-on at initialization. Something along the lines of
> > > > > the below.
> > > > >
> > > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Date: Tue, 29 Jul 2025 14:27:22 +0200
> > > > > Subject: [PATCH] pmdomain: core: Allow powered-on PM domains to be powered-off
> > > > >  during boot
> > > >
> > > > [...]
> > > >
> > > > I gave this a try (i.e. "| GENPD_FLAG_NO_STAY_ON" in rcar-sysc.c), but
> > > > this doesn't make any difference.  I assume this would only work when
> > > > actively calling genpd_power_off() (i.e. not from of_genpd_sync_state()
> > > > or genpd_provider_sync_state())?
> > >
> > > Right. Thanks for testing!
> > >
> > > So, we may need to restore some part of the genpd_power_off_unused()
> > > when CONFIG_PM_GENERIC_DOMAINS_OF is set. Without clearing
> > > "genpd->stay_on".
> > >
> > > I can extend the patch, if you think it would make sense for you?
> >
> > I would applaud anything that would fix these regressions.
> > Thanks!
>
> While being mostly silent from my side for a while, I have been
> continuing to evolve my test suite for sync_state tests. Wanted to
> make sure I cover additional new corner cases that you have pointed
> out for Renesas platforms.
>
> That said, I have not observed any issues on my side, so it looks like
> we are simply facing new behaviors that you have pointed out to be a
> problem. In this regards, I think it's important to note that we are
> currently only seeing problems for those genpds that are powered-on
> when the provider driver calls pm_genpd_init(). Another simple option
> is to power-off those PM domains that we know is not really needed to
> be powered-on. Also not perfect, but an option.
>
> Another option is something along the lines of what I posted, but
> perhaps extending it to let the late_initcall_sync to try to power-off
> the unused PM domains.

Yep, like before.

> I will work on updating the patch so we can try it out - or perhaps
> what you suggested above with a device-specific flag taken into
> account by fw_devlink_dev_sync_state() would be better/sufficient you
> think?

I also had a closer look at the few pending sync_state() pending
warnings I do see on SH/R-Mobile SoCs.  Their PM Domain driver uses
of_genpd_add_provider_simple() instead of of_genpd_add_provider_onecell().
E.g. on R-Mobile A1:

    genpd_provider a3sm: sync_state() pending due to f0100000.cache-controller
    genpd_provider a4s: sync_state() pending due to fe400000.memory-controller
    genpd_provider d4: sync_state() pending due to ptm

All three domains were already handled specially in the PM Domain
driver, as they must not be turned off, so these platforms didn't
regress due to this series.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

