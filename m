Return-Path: <linux-pm+bounces-34213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E89EB4A356
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 09:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2020B16E378
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 07:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DCD2566D3;
	Tue,  9 Sep 2025 07:19:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC51234984;
	Tue,  9 Sep 2025 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402399; cv=none; b=lckApLBf+zovVdbnXxCr6bNaBwdNPAtHZk/KQ1KyjrivQksrbUgVTSm2T2dl5BjPjqWpqdSI6Fbtr2WkTdFyBw9N35CkWm8tPLdO4y2BZgPgF+LS4NiQeA+TQZSbQbYvzqScDLYylgEnY23tEjalFjrVUJPWAOhuRJIMNy+1uzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402399; c=relaxed/simple;
	bh=YvY/X2ZOD1KTPAeNMoiGc0Uo/mDnAxHj167c6kN/Npk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ju3aRoLajWO69WHAN42BThk0gw0oUcAk6Kba+TBtYLZBozmc8iu2B/wB4V/Ufb/BbcQX0j1eZe9T+qNEue/ZvfoWoBbT1kzdav9g3omw/rc7o6WwDIY6a7v4iaOz2j2YQbmQ9ymNMd6LGzeN0X5L8XLBkWT5mYzv85L25QENEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8c0e2d1efd5so34561241.3;
        Tue, 09 Sep 2025 00:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757402396; x=1758007196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeojvgOoj27fx5wlpnFPiJSqcaAod3+dZ6jf/qLHH+c=;
        b=PBYHAWN/Fxd046x+Lh6c7F8wOXmcPgiYRSoDvpBk7lMTJiUypsDbTZJRdGEKUljajf
         dAsdFiNrDD6yLeieBNo8N54FJYqsrzUcDkqj8ci/S4b+G8qiry19QXRQYQQxAvgDJ5Xa
         Xj7S0KWRIGxD7tcuCBQHBxHMXDvorasokvXZJuiY5ZhyV2lDTguZfZKxSQmK08hDD6Pk
         eS/9P1SQGKovkanJcRABSAZFR6I/b0kJKidXgEcXFMBpqflDOiUdmwxxtbcRhuq9rubJ
         lc4WmSKgDbwoYAQmqTXa/Lai1gPAtwuotkYnTjdy3JhAVQDRFTi/WZsTzD/UmEfH0Knz
         1h5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3j8WdL3/YAg6+dTmATxWIIoZq2Ox+AnQjJ3PZw0GTrRgzCXd86pMxuCtmkE+TAPy3e14qhMMwRzA=@vger.kernel.org, AJvYcCWKvNaaEJmcHnsvqJUdcSzDAvBIbwkcLyzSA0ztyP97Ur3soQSpRsEwpS52W9q8rnap1ZUXTLClU9haaplAWRXOviw=@vger.kernel.org, AJvYcCWra4nqXZJOCnI/+g5T2NflzedgtX+1CbQI6fvHWDzzOAnelJsHUQGIglI5IGfb8xgCKtPqY0H23/0YykY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLlvQvUzAdyxEpH/jMKnKoGlFE9FCVRQInRMIj9inalsBpnaE
	Dc/nPdYllSlEr4ea4jVdv4PJbT85xuTMYCQpL+zUlc+Dbg9p9vMrlC0q8PFD7OuV
X-Gm-Gg: ASbGncvNb22CZLOSiy0WmQl10fcBDnAamiuOCVTvtwg/7GW53kTQGz6aOLXIUfhFTML
	ijTku6jMwpiXrnutjDVFByouMERXh2R6YsEcEpy5jMoQaMGXov2cy5daNL9sH9JL1q0FcGtGnpZ
	1DH6ubE8uLEPIyRl4on5dY3y/qRGW0fs/kAzp+8EKosaeki0pSnkPpZ3yFaFRC6PGiAoboIKZeJ
	MHfd/fTMsi04cIFQPXlK2PPBTIiMSpCVzjpbNL7ZDJdwTIMU2az6pyinGVI5RA6ywWCnlitCris
	GSOcTY0MWXhYelmjam6p9ha2aAhup2CcyBvw20+t5yWz4eW4AKiPClJrKPYt9sb8Iqb+acwt5Pe
	F+d6YKlFCd6YyVmKIwxjVErBnHYneSWJLjaZW0tKG1tQKQ+SfDZf6chwfTyU1NGYm
X-Google-Smtp-Source: AGHT+IFmXrgANVx0IYhMdQYOfB0Skdc7N6fQOgs5QLdnYV7J3UOUQDkeow54vNbcDoHVG0Qbc693wA==
X-Received: by 2002:a05:6102:5803:b0:521:b9f2:a5ca with SMTP id ada2fe7eead31-53d0dbe8686mr2955646137.13.1757402395610;
        Tue, 09 Sep 2025 00:19:55 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943bba6b6asm10462871241.19.2025.09.09.00.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 00:19:54 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5449432a9d7so2936734e0c.3;
        Tue, 09 Sep 2025 00:19:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2BJfl8HALiIamC3VEENe0zBNHEwBn3VsdsE87KcKPK179uyEFN1UYVx/eMsP7VcQvCRb0rRfHraKdNHs=@vger.kernel.org, AJvYcCWfLuR5oAXp4JT8DeeIQ00xuah5NSxnQUgpW0tmBU0jdNmZN1FxFjaJkl18CIBF8tcOVjfu3moR0rg=@vger.kernel.org, AJvYcCWud+0n8lpfS2fQkTbTFBtgukwWcmS/A3BAMRRp385rcNaFnJ+1EcbK/e4VcI28KmY/b6QVPLx0MOiwuVeEuI6eIGI=@vger.kernel.org
X-Received: by 2002:a05:6122:2a0e:b0:539:1dbf:3148 with SMTP id
 71dfb90a1353d-5473a6b5e5dmr2681615e0c.2.1757402393942; Tue, 09 Sep 2025
 00:19:53 -0700 (PDT)
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
 <CAPDyKFrWv3ObciCtrb4YE_K6to5xxx79DGcPv0=nP9LR60=xYA@mail.gmail.com>
 <CAMuHMdXoLnQR_hB-jXeGxAudwwpFRcQjrQcCb8iYCOz32yHinw@mail.gmail.com> <CAPDyKFqvjeuXhk7H4nH80RY63QfKwGO_61UW=MJaU8Qiahbt3g@mail.gmail.com>
In-Reply-To: <CAPDyKFqvjeuXhk7H4nH80RY63QfKwGO_61UW=MJaU8Qiahbt3g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Sep 2025 09:19:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU6HpuAR+CgChWXrH_59R2VtQh6aYzFr7TxbwYqhTvBFw@mail.gmail.com>
X-Gm-Features: AS18NWDmHT-3R8QmqJ6KdmkENOe2qYT7JumC9ZBMppvAjXadPk6DLp2HtLSHeEQ
Message-ID: <CAMuHMdU6HpuAR+CgChWXrH_59R2VtQh6aYzFr7TxbwYqhTvBFw@mail.gmail.com>
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

On Fri, 5 Sept 2025 at 13:09, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > > > BTW, the "pending due to"-messages look weird to me.
> > > > > > > > > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > > > > > > > > >
> > > > > > > > > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
> > > > > > > > > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> > > > > > > > > > due to e6020000.watchdog
> > > > > > > > > >
> > > > > > > > > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > > > > > > > > the watchdog resides in the always-on Clock Domain, and uses the
> > > > > > > > > > clock-controller for PM_CLK handling.
> > > > > > > >
> > > > > > > > Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
> > > > > > > > these bogus pending states, and no PM Domain is powered off.
> > > > > > >
> > > > > > > I see, thanks for the details. I am looking closer at this.
> > > > > > >
> > > > > > > In any case, this is the main issue, as it prevents the ->sync_state()
> > > > > > > callback to be called. Hence the "genpd->stay_on" will also *not* be
> > > > > > > cleared for any of the genpd's for the genpd-provider.
> > > > > >
> > > > > > I was under the impression there is a time-out, after which the
> > > > > > .sync_state() callback would be called anyway, just like for probe
> > > > > > deferral due to missing optional providers like DMACs and IOMMUs.
> > > > > > Apparently that is not the case?
> > > > >
> > > > > The behaviour is configurable, so it depends. The current default
> > > > > behaviour does *not* enforce the ->sync_state() callbacks to be
> > > > > called, even after a time-out.
> > > > >
> > > > > You may set CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT to achieve the above
> > > > > behavior or use the fw_devlink command line parameters to change it.
> > > > > Like setting "fw_devlink.sync_state=timeout".
> > > > >
> > > > > I guess it can be debated what the default behaviour should be.
> > > > > Perhaps we should even allow the default behaviour to be dynamically
> > > > > tweaked on a per provider device/driver basis?
> > > >
> > > > The domains are indeed powered off like before when passing
> > > > "fw_devlink.sync_state=timeout", so that fixes the regression.
> > > > But it was not needed before...
> > >
> > > Right, the default behavior in genpd has changed. The approach was
> > > taken as we believed that original behavior was not correct.
> > >
> > > Although, the current situation isn't good as it causes lot of churns for us.
> >
> > I did some more testing, and there seems to be a similar issue with
> > DMA controllers, which I hadn't really noticed before, as I have
> > DMAC drivers built-in in all my kernel configs.  If the (optional)
> > DMAC driver is not available, you need "fw_devlink=permissive" to make
> > drivers probe devices that have (optional) DMA support.
>
> Well, after the deferred probe timeout, the missing supplier depency
> should be ignored even if you don't have "permissive".
>
> Typically we get a print in the log that could say:
> "pm-test-drv pm_test24: deferred probe timeout, ignoring dependency"
>
> ... and then the driver-core tries probing the device anyway. It's
> then up to the consumer driver to allow probing to succeed, even if
> the DMA setup procedure fails.

Well, that didn't seem to work. Perhaps we still have some drivers that
do not handle -EPROBE_DEFER correctly. Will check...

> > > > > > > > Upon closer look, all "pending due to" messages I see claim that the
> > > > > > > > first (index 0) PM Domain is pending on some devices, while all of
> > > > > > > > these devices are part of a different domain (usually the always-on
> > > > > > > > domain, which is always the last (32 or 64) on R-Car).
> > > > > > > >
> > > > > > > > So I think there are two issues:
> > > > > > > >   1. Devices are not attributed to the correct PM Domain using
> > > > > > > >      fw_devlink sync_state,
> > > > > > > >   2. One PM Domain of a multi-domain controller being blocked should
> > > > > > > >      not block all other domains handled by the same controller.
> > > > > > >
> > > > > > > Right, that's a current limitation with fw_devlink. To cope with this,
> > > > > > > it's possible to enforce the ->sync_state() callback to be invoked
> > > > > > > from user-space (timeout or explicitly) for a device.
> > > >
> > > > That needs explicit handling, which was not needed before.
> > > >
> > > > Perhaps the fw_devlink creation should be removed again from
> > > > of_genpd_add_provider_onecell(), as it is not correct, except for
> > > > the first domain?
> > >
> > > There is nothing wrong with it, the behavior is correct, unless I
> > > failed to understand your problem. To me the problem is that it is
> >
> > It does print wrong and confusing warnings indicating the problem:
> >
> >     genpd_provider ca57-cpu0: sync_state() pending due to fe000000.pcie
> >
> > (no, the PCIe controller is not part of the CPU PM Domain)
>
> That's a good point. We should fix this to avoid confusion.
>
> > > just less fine grained, compared to using
> > > of_genpd_add_provider_simple(). All PM domains that is provided by a
> > > single power-domain controller that uses #power-domain-cells = <1>,
> > > requires all consumers of them to be probed, to allow the sync_state
> > > callback to be invoked.
> >
> > if it would be just coarse-grained, the link should be created to a
> > device representing the controller, not to the device representing
> > the first PM domain.
> >
> > > If we could teach fw_devlink to take into account the
> > > power-domain-*id* that is specified by the consumer node, when the
> > > provider is using #power-domain-cells = <1>, this could potentially
> > > become as fine-grained as of_genpd_add_provider_simple().
> > >
> > > Saravana, do think we can extend fw_devlink to take this into account somehow?
> >
> > Doesn't the pmdomain core create a device for each PM domain, so the
> > index could be used to link to the correct domain?
>
> Correct, we have a device associated for each PM domain - and when
> of_genpd_add_provider_onecell() is called, we get the index associated
> for each of them.
>
> If I understand your proposal, you are suggesting that genpd itself
> creates the device_link between its corresponding device (supplier)
> and the upcoming consumer device(s), at the point when
> of_genpd_add_provider_onecell() is called, right?
>
> It's an interesting idea, but I am not sure it will work. To create
> the device_link at this point, assumes that all the consumer OF-nodes
> have been populated (to have devices available for them). Maybe there
> is an intermediate step we can take to instruct fw_devlink to treat
> these "links" differently?

I am not sure where these links are created. In the example above
"ca57-cpu0" is the device name of the supplier, but that is not the name
of a platform device.  Doesn't the core create devlinks between platform
devices? If yes, who creates this link to a non-platform device,
and can that code be updated easily to take into account the index cell?

> > I also had a closer look at the few pending sync_state() pending
> > warnings I do see on SH/R-Mobile SoCs.  Their PM Domain driver uses
> > of_genpd_add_provider_simple() instead of of_genpd_add_provider_onecell().
> > E.g. on R-Mobile A1:
> >
> >     genpd_provider a3sm: sync_state() pending due to f0100000.cache-controller
> >     genpd_provider a4s: sync_state() pending due to fe400000.memory-controller
> >     genpd_provider d4: sync_state() pending due to ptm
> >
> > All three domains were already handled specially in the PM Domain
> > driver, as they must not be turned off, so these platforms didn't
> > regress due to this series.
>
> Okay!
>
> Again the prints are confusing and annoying, but in principle we are
> fine. Thanks for clarifying!
>
> This also makes me wonder if we should skip enabling the fw_devlink
> support for those genpds with "simple" providers that are special
> (GENPD_FLAG_ALWAYS_ON and GENPD_FLAG_RPM_ALWAYS_ON). It doesn't make
> sense to track consumers for them, I think.

Makes sense.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

