Return-Path: <linux-pm+bounces-32273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95057B248F6
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E847218FC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3827AC3D;
	Wed, 13 Aug 2025 11:58:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E42BD5AB;
	Wed, 13 Aug 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086336; cv=none; b=PunhmgEK8vztSJA8VEuIKW3kil/mVKeDNeDbGJu0V8PJ+FYCpT1EOlIK65hnkd5bbT5HEV8YTBJ5aA7ixxsPX9ifka2c1ys6PrAxPMsEhd0b01isJGMuPYMRf1+hJQ24qj6d/ZwMPZpJeUBBC4FTHmMxOY0GWR8lRkQyXnOOGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086336; c=relaxed/simple;
	bh=mx/Vyi5Fx1iuPdxl9ty0h3Ekc+IxjOPe2cCOFI7AK1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rk3Es75HMAiyUPvpGQ8K2qU4XbkUHJpwhyiMxVBwI3JQkqzHCglYisIHrGvhj1O1p9ZxrBtP2nz3ioT9+TnLHLefVHn8NyoYZL/RzS6ExkD+9oG48TauoZVD9UwUIcEaaoPEqDko3qIr+Jpluzru0rQEwYlGm8lLooJV4aD20zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-88dbc90853cso2029083241.2;
        Wed, 13 Aug 2025 04:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086333; x=1755691133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXaVARntTj5rstYFk0DVZoF1grl45M/iHSv+inIZnl0=;
        b=RH2vRRv1f2FP1tJL3aHi6CGprbvPGQ+tivfGSfWHp2d6P5MWEVvRDFLCzdl/fSbtrd
         dlVy/efRlp76iCakqM2eY8He03gm9dhnXU0IZGcFCP51cJKEP86XaUyOyI4BuCqbiYXM
         IXGi0fsKgE8Vf7uWUGNjUhhpneaxCU1/3D2i4tEyH2miijEjk6sztlxlJuKV0zdvmTyw
         aUNoK5bh+ELyFNCjGENVBxRS0pBQ8qRiVIrL2UQ4GeDzo0aK1LadOt6zPvSG98i6dVlZ
         jqk4Ba5X9FQ8MMH5hhwNzcD1ueaamCxKAoJjcZASMlo8JBfBe2V2ieyqFcraOEgXC873
         jTHg==
X-Forwarded-Encrypted: i=1; AJvYcCVFaFXwmTyiPmCsVRFaXG/1tzriKK5o2lQWvylL2q8nGvIUUZkfhvywT2E56UU0RvmpY/xCGJHA0BENMibyW6ujoKY=@vger.kernel.org, AJvYcCWCXIg2/bky4J1HLugUqAn2GmenMpiAuyD+tgV/EuFmvkLjG+23Cbk8CcL4vAGxiSruV+UgNM7587Y=@vger.kernel.org, AJvYcCWf8BkHSK4Ywcangqbj5tmiCbQHLnEArUHgXvCdBxDbasSJfbEG6B39iDFZlk+YP8SPcwTXgL9JaLgNhAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvV6oG6u7uYUfwoOMv3ShToJGUgtNfPNvBMq48VOC3NwVnRFn
	XhzR7cVGesZTU9GY43UzyJ0/CtTygV76Yu4UvgJIZjo4QRNM1idZt/SJrzLHCfFM
X-Gm-Gg: ASbGncs0oqiDX7n+N6tF8C0Hb0Lcl3ZGg5w1KSGV5OoQuALYRl5NX1zQrpPyU2enOcH
	AYhAcBONb+xjRxi6yUR7qTLUKFTkPnSWNnZ941H5e9B3F2lEON7UftAm7tR0/aRbV9CsIhpF2XG
	53BTmdWPfjbTqIjouh3F0tGhp2mw9b+S08jon7E4eUYy/WxUokUeXH81AIcC89yH+b/KEgZXcP8
	Hbb6S3v28DhEMLuLoB5igxA59OrLzp29+Pm1TzRsF+rgvBSHq7G0vM7oorgUHZGJC9dvAwyKnVF
	dRc4Uo1Cqp7AeVYQn3l90rh5/IZZjXW1nHhfYxP579nGEtfxLwMwTZeyFaIYOWwvY/bfRlAaK4e
	plcMDbAQ5f3gaBDIHFtLU6W5CbYSZ2CNOFkQ5CaFSTtslJLlIJn4nY2KjW5bxYR1UpeLQyvw=
X-Google-Smtp-Source: AGHT+IGQEIj1UsQ55vIFvWQifdDJoJ+K0Nx7MGvC38cD88eyY8S5QS7be30pF9GpgYGqg3E2hM+cYw==
X-Received: by 2002:a05:6102:441b:b0:4e6:ddd0:96ff with SMTP id ada2fe7eead31-50e507a5fcamr798538137.16.1755086333469;
        Wed, 13 Aug 2025 04:58:53 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-506290ef39asm2683838137.4.2025.08.13.04.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:58:53 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4fd6c638f20so3031893137.1;
        Wed, 13 Aug 2025 04:58:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyOXSry0zNhlT8wQ9TizrBcQz3GkZz8X5PasF70ffnZuNEfV3s5rPG1H7GnszfJzkkno8gvGz8Hl7lDuk=@vger.kernel.org, AJvYcCW3F2PGj8UIAXMsOD9SNXZ6LpztGhV4PVknp9jiSjAHODNoTuxUtCnDv6KsNUd1247hjsJ1bhS/8/ilTMKiZh2Kpo0=@vger.kernel.org, AJvYcCXKzhZklCzpd0ZsTLbnKn7os2tn6lLik7m11GPedqg8RQDVS9+fvHUoZ9hyJnFSRUvMvBv/OQDa/ZA=@vger.kernel.org
X-Received: by 2002:a05:6102:1487:b0:4e5:9cf0:4eb6 with SMTP id
 ada2fe7eead31-50e4e5d7c88mr994820137.5.1755086332601; Wed, 13 Aug 2025
 04:58:52 -0700 (PDT)
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
 <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com> <CAPDyKFq7z9e9hEC9QWiYcaU=t+Gs_GgRurmK-+cNYp4xkhr5Ow@mail.gmail.com>
In-Reply-To: <CAPDyKFq7z9e9hEC9QWiYcaU=t+Gs_GgRurmK-+cNYp4xkhr5Ow@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Aug 2025 13:58:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7W+f3nZ_ckHOFsmmK6V9HzK0-fNtcu8kgjTSeU89AqQ@mail.gmail.com>
X-Gm-Features: Ac12FXy_QPIbJQtFhWwoeC5qDQfggpsR7MDF7zj_crLn7Nv8scpATkvcHMh0lNM
Message-ID: <CAMuHMdU7W+f3nZ_ckHOFsmmK6V9HzK0-fNtcu8kgjTSeU89AqQ@mail.gmail.com>
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

On Tue, 12 Aug 2025 at 12:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 7 Aug 2025 at 11:38, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, 30 Jul 2025 at 12:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > Changes in v3:
> > > > > >         - Added a couple of patches to adress problems on some Renesas
> > > > > >         platforms. Thanks Geert and Tomi for helping out!
> > > > > >         - Adressed a few comments from Saravanna and Konrad.
> > > > > >         - Added some tested-by tags.
> > > > >
> > > > > I decided it was time to give this a try, so I have queued this up for
> > > > > v6.17 via the next branch at my pmdomain tree.
> > > > >
> > > > > If you encounter any issues, please let me know so I can help to fix them.
> > > >
> > > > Thanks for your series!  Due to holidays, I only managed to test
> > > > this very recently.
> > > >
> > > > Unfortunately I have an issue with unused PM Domains no longer being
> > > > disabled on R-Car:
> > > >   - On R-Car Gen1/2/3, using rcar-sysc.c, unused PM Domains are never
> > > >     disabled.
> > > >   - On R-Car Gen4, using rcar-gen4-sysc.c, unused PM Domains are
> > > >     sometimes not disabled.
> > > >     At first, I noticed the IOMMU driver was not enabled in my config,
> > > >     and enabling it did fix the issue.  However, after that I still
> > > >     encountered the issue in a different config that does have the
> > > >     IOMMU driver enabled...
> > > >
> > > > FTR, unused PM Domains are still disabled correctly on R/SH-Mobile
> > > > (using rmobile-sysc.c) and on BeagleBone Black. Note that these use
> > > > of_genpd_add_provider_simple(), while all R-Car drivers use
> > > > of_genpd_add_provider_onecell().  Perhaps there is an issue with
> > > > the latter?  If you don't have a clue, I plan to do some more
> > > > investigation later...
> >
> > of_genpd_add_provider_onecell() has:
> >
> >     if (!dev)
> >             sync_state = true;
> >     else
> >             dev_set_drv_sync_state(dev, genpd_sync_state);
> >
> >     for (i = 0; i < data->num_domains; i++) {
> >             ...
> >             if (sync_state && !genpd_is_no_sync_state(genpd)) {
> >                     genpd->sync_state = GENPD_SYNC_STATE_ONECELL;
> >                     device_set_node(&genpd->dev, fwnode);
> >                     sync_state = false;
> >                     ^^^^^^^^^^^^^^^^^^^
> >             }
> >             ...
> >     }
> >
> > As the R-Car SYSC drivers are not platform drivers, dev is NULL, and
> > genpd->sync_state is set to GENPD_SYNC_STATE_ONECELL for the first PM
> > Domain only.  All other domains have the default value of sync_state
> > (0 = GENPD_SYNC_STATE_OFF).  Hence when genpd_provider_sync_state()
> > is called later, it ignores all but the first domain.
> > Apparently this is intentional, as of_genpd_sync_state() tries to
> > power off all domains handled by the same controller anyway (see below)?
>
> Right, this is intentional and mainly because of how fw_devlink works.
>
> fw_devlink is limited to use only the first device - if multiple
> devices share the same fwnode. In principle, we could have picked any
> of the devices in the array of genpds here - and reached the same
> result.

OK, just like I already assumed...

> > > > BTW, the "pending due to"-messages look weird to me.
> > > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > > >
> > > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
> > > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> > > > due to e6020000.watchdog
> > > >
> > > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > > the watchdog resides in the always-on Clock Domain, and uses the
> > > > clock-controller for PM_CLK handling.
> >
> > Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
> > these bogus pending states, and no PM Domain is powered off.
>
> I see, thanks for the details. I am looking closer at this.
>
> In any case, this is the main issue, as it prevents the ->sync_state()
> callback to be called. Hence the "genpd->stay_on" will also *not* be
> cleared for any of the genpd's for the genpd-provider.

I was under the impression there is a time-out, after which the
.sync_state() callback would be called anyway, just like for probe
deferral due to missing optional providers like DMACs and IOMMUs.
Apparently that is not the case?

> > If I remove the "sync_state = false" above, genpd_provider_sync_state()
> > considers all domains, and does power down all unused domains (even
> > multiple times, as expected).
>
> I think those are getting called because with the change above, there
> is no device_link being tracked. As stated above, fw_devlink is
> limited to use only one device - if multiple devices share the same
> fwnode.

Indeed.

> In other words, the ->sync_state() callbacks are called even if the
> corresponding consumer devices have not been probed yet.

Hence shouldn't there be a timeout, as the kernel may not even have
a driver for one or more consumer devices?

> > Upon closer look, all "pending due to" messages I see claim that the
> > first (index 0) PM Domain is pending on some devices, while all of
> > these devices are part of a different domain (usually the always-on
> > domain, which is always the last (32 or 64) on R-Car).
> >
> > So I think there are two issues:
> >   1. Devices are not attributed to the correct PM Domain using
> >      fw_devlink sync_state,
> >   2. One PM Domain of a multi-domain controller being blocked should
> >      not block all other domains handled by the same controller.
>
> Right, that's a current limitation with fw_devlink. To cope with this,
> it's possible to enforce the ->sync_state() callback to be invoked
> from user-space (timeout or explicitly) for a device.
>
> Another option would be to allow an opt-out behavior for some genpd's
> that are powered-on at initialization. Something along the lines of
> the below.
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Tue, 29 Jul 2025 14:27:22 +0200
> Subject: [PATCH] pmdomain: core: Allow powered-on PM domains to be powered-off
>  during boot

[...]

I gave this a try (i.e. "| GENPD_FLAG_NO_STAY_ON" in rcar-sysc.c), but
this doesn't make any difference.  I assume this would only work when
actively calling genpd_power_off() (i.e. not from of_genpd_sync_state()
or genpd_provider_sync_state())?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

