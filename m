Return-Path: <linux-pm+bounces-32031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2989B1D4FA
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D4B16750E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F6E246BB7;
	Thu,  7 Aug 2025 09:38:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DDB2264A7;
	Thu,  7 Aug 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559510; cv=none; b=D38a605gKl73+90ia/Ifctxp71U0FzCx6Wv49tPmmR13DRokYpB3Jfp1tC/NaATuOnSRnbrE2FuGZxjSeq8Ur/v/BlKyEiCl3ItD5ncKcevTyOC51fI2oR2F+Z3LMiYiVsX5zw35i2X4hJ+cXDJttRhV9ncQZXXMSzxibDsj4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559510; c=relaxed/simple;
	bh=HY6zT8/BDEjGGXWZNg+FplBqUklqVaKsTKOVXero19I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPbvbp/cO07EJC5c7cTxa01shdxxS98+oGE0nsZbIUEGLSORRNQtfP36vMYzritQtHPIfYKhdEiJXKKWNcSVi4h1nhsQ8W9DL/YGgfq+QB6I4e4keH4N9k1FCABRsTsaYL679r7AjGJ80P5Ffg0cQ6RQIcSgEI8KskLvCmuhLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-539512e3c3aso207831e0c.3;
        Thu, 07 Aug 2025 02:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559507; x=1755164307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kg4yVMonzvoboWXkN1zzSwUBk/T53kVazB7EUBcPsmw=;
        b=qiiPIJK7O0jD63wY1eGLKCQStfI/FPTynZ/ua893P07m2IA6V2AqZuFFo4dWxUSwnw
         ICserb5oqNhsHrh+rw332I/w7JBjptLPUp+VuFuxIilA+I8YD1Iz5BaFseAWi3b3i2uE
         QXGNNNWsvG/mUnFPfLg++1kXypIZcOBySHyHMGnz23fYyDaAM4p/z0Ioq4hlzNzei0Mz
         g862Nyz5rSuu9lWDHm3y0rXo7FIfIM70y9o5M+/VbWzOZhsJ8l8gWf2SPbhMsmGigHN1
         w+VXyrHdzDZhP6Q7xU+S00ALKC9RcCJoBVY3QmcQKCd4CbEzhzwQhNde0XZcVQ5cJkQx
         ozIg==
X-Forwarded-Encrypted: i=1; AJvYcCUhFBdkC1Nf5Sf7889INK2mnSKgEzyWaaniZUg4LTH9y3pmXS6shR2qk5WC4RFWM55RnUsr37BLcVwrsLs=@vger.kernel.org, AJvYcCVKWh0oKtMdCNBZ1eBah34T9/0oqd2MEBatdcOzmUf58/G5q03I+rAUJY5io1v9khw1jmugLQq688E=@vger.kernel.org, AJvYcCXEhWDrpLrnU/3EVNW6phEn9XdKoiZQ77U09nawYeA7f+WJXly4qlJ1c9QUMV9UIkrd5GtcHsTCfQ1yDquwBrJGI9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WsYRcZq0tiCMTcey84AWX3FaFUbpAY0MZ6xl6eh+opuM3Tok
	X02r0IzKlXpMjtcyw3KN94EoHyL/NeiQyN0iH7tPbTOF3/CRNnTRz9m+kty1GMZ7QqU=
X-Gm-Gg: ASbGncs/KaKavyhaywKp7rNNDKMlFuO8QDCe7nWsPhD3cPgpIDj3gJ4t+Gl6OVldw9H
	n34UHCr7ExOV6gM+FO0K3pwuTn+tuLhehZ0mdtYv/PG0sPOcELAxBjp+pSZ32ABAuPyfVnr8pqz
	vJCyX/stql/MWEEGr+w95MbvR5VrblD830C8g3+SBH517Z1+iBQ1OeXA1ToBleNdT+XWZpHmFto
	Q3uhuqDRdzZXZXHMXdl04hQU3e625qiJM4eEpAVjGAoFgMCqdFdmGP9/Jye39HoIyBnOZwhzUPO
	1BWhL/alkW/6PA+8Uh84fgyL6H4pDmINGzBY80uJ44dDVovxqa8MkmGQazQC4TDCVT03si6Tr9J
	GG6dE+9YTlaWf4L0C6q6B6rLVb/bPa+9DoBTGP1EDn12AAX0DGH1llqO4vsRFiErD
X-Google-Smtp-Source: AGHT+IEkFixhE5X6a9Va2nyQEtUPAJHqEEr1qga+5QljWiD4G2ghe+CHrGVrvTYZVR/5UD6VKWXD3Q==
X-Received: by 2002:a05:6122:d9c:b0:535:aea0:7a2f with SMTP id 71dfb90a1353d-539ade239ccmr877249e0c.4.1754559506748;
        Thu, 07 Aug 2025 02:38:26 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e0268d423sm234046241.2.2025.08.07.02.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 02:38:26 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-539613258e8so257064e0c.1;
        Thu, 07 Aug 2025 02:38:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoKyGBoFigQpsoFfDTgeJG0LfbMfm4rXuNtBOL6Q+Iim+1XVOPaKZZmobaf1k5gaKhfZIcafoX7mQ=@vger.kernel.org, AJvYcCWFlHN2zwK3xru2PgArgL5u0rI8UKxWQVgwVS/SztKzMCyJQA6uJZyQsjMr5CwoVCwLeD3400N7Zl9XBHU=@vger.kernel.org, AJvYcCWFrDalQXSpdxtcmLCkSg2LE2zvalx11BrDUG4ReO5sb4xHjg6JNLs2S2qrcRMBiuKxqTwgBpICnJP1ZH+rXEC2dKY=@vger.kernel.org
X-Received: by 2002:a67:e715:0:b0:4fc:d0e5:23fe with SMTP id
 ada2fe7eead31-504b889fb24mr993877137.15.1754559506070; Thu, 07 Aug 2025
 02:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
 <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com> <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com>
In-Reply-To: <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Aug 2025 11:38:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com>
X-Gm-Features: Ac12FXz_Wf7VThW0eyyjvLdjQbW2gc7dwXYQXV43OPnnHHrM4sUfbNQtDD8n2Ug
Message-ID: <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com>
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

On Wed, 30 Jul 2025 at 12:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > Changes in v3:
> > > >         - Added a couple of patches to adress problems on some Renesas
> > > >         platforms. Thanks Geert and Tomi for helping out!
> > > >         - Adressed a few comments from Saravanna and Konrad.
> > > >         - Added some tested-by tags.
> > >
> > > I decided it was time to give this a try, so I have queued this up for
> > > v6.17 via the next branch at my pmdomain tree.
> > >
> > > If you encounter any issues, please let me know so I can help to fix them.
> >
> > Thanks for your series!  Due to holidays, I only managed to test
> > this very recently.
> >
> > Unfortunately I have an issue with unused PM Domains no longer being
> > disabled on R-Car:
> >   - On R-Car Gen1/2/3, using rcar-sysc.c, unused PM Domains are never
> >     disabled.
> >   - On R-Car Gen4, using rcar-gen4-sysc.c, unused PM Domains are
> >     sometimes not disabled.
> >     At first, I noticed the IOMMU driver was not enabled in my config,
> >     and enabling it did fix the issue.  However, after that I still
> >     encountered the issue in a different config that does have the
> >     IOMMU driver enabled...
> >
> > FTR, unused PM Domains are still disabled correctly on R/SH-Mobile
> > (using rmobile-sysc.c) and on BeagleBone Black. Note that these use
> > of_genpd_add_provider_simple(), while all R-Car drivers use
> > of_genpd_add_provider_onecell().  Perhaps there is an issue with
> > the latter?  If you don't have a clue, I plan to do some more
> > investigation later...

of_genpd_add_provider_onecell() has:

    if (!dev)
            sync_state = true;
    else
            dev_set_drv_sync_state(dev, genpd_sync_state);

    for (i = 0; i < data->num_domains; i++) {
            ...
            if (sync_state && !genpd_is_no_sync_state(genpd)) {
                    genpd->sync_state = GENPD_SYNC_STATE_ONECELL;
                    device_set_node(&genpd->dev, fwnode);
                    sync_state = false;
                    ^^^^^^^^^^^^^^^^^^^
            }
            ...
    }

As the R-Car SYSC drivers are not platform drivers, dev is NULL, and
genpd->sync_state is set to GENPD_SYNC_STATE_ONECELL for the first PM
Domain only.  All other domains have the default value of sync_state
(0 = GENPD_SYNC_STATE_OFF).  Hence when genpd_provider_sync_state()
is called later, it ignores all but the first domain.
Apparently this is intentional, as of_genpd_sync_state() tries to
power off all domains handled by the same controller anyway (see below)?

> > BTW, the "pending due to"-messages look weird to me.
> > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> >
> >     genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
> >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
> > due to e6020000.watchdog
> >
> > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > the watchdog resides in the always-on Clock Domain, and uses the
> > clock-controller for PM_CLK handling.

Unfortunately the first PM Domain is "ca15-cpu0", which is blocked on
these bogus pending states, and no PM Domain is powered off.

If I remove the "sync_state = false" above, genpd_provider_sync_state()
considers all domains, and does power down all unused domains (even
multiple times, as expected).

Upon closer look, all "pending due to" messages I see claim that the
first (index 0) PM Domain is pending on some devices, while all of
these devices are part of a different domain (usually the always-on
domain, which is always the last (32 or 64) on R-Car).

So I think there are two issues:
  1. Devices are not attributed to the correct PM Domain using
     fw_devlink sync_state,
  2. One PM Domain of a multi-domain controller being blocked should
     not block all other domains handled by the same controller.

Does that make sense?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

