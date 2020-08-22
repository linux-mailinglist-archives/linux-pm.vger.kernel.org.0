Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3CA24E796
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgHVNN6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Aug 2020 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgHVNN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Aug 2020 09:13:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBE7C061574
        for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2020 06:13:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so2433910pfp.7
        for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2020 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQFZ3Sv5y18I7wZ9EvV1kNK7LL9SLdrdcRtoUoCFnvA=;
        b=C4Y072XUAIYZyfmRrshf5l95PKNCWRwbELitDleGUvIdERcUpFcVgCGYWWXxXo3+vG
         8BPaFHw/m1aeMNF8psDMprEv/tZXx39vj8amuMaLWdebvAPjysgxNmt9sgLSGkgHWp3B
         jAxXX1Y8EbBER6csHNYJU8QIxOfMbOMxBINcNC+g+re1je9Nf3dv3BOl7mseXgz0Hjnu
         uSyzMi3CyCgojgN13U2OTkpESZnzjTZHY+oZpPCO3Vjw2KnMMb7QaRtY2DmA2zTyxVFy
         y3bYbFtml8cHTQYaSw+yThBfrEO0DpO9OZMCcddOhggEtsLenCi93krz/vdgD6d5nbsP
         3+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQFZ3Sv5y18I7wZ9EvV1kNK7LL9SLdrdcRtoUoCFnvA=;
        b=QhObs2KfvhmG9ZDJJzXZJ8VIikmdm59LElnmOlXzT7tx+LOEDj3g4BJ+3irmq/RaEs
         xjVI0xNp5+3ZTl5oVTymZuad8Gtvy/0WVQ1sJtqzg7zF8nYYSZcbAKIKM0PlYqyTVfpu
         69CxIKqomh1rAuSJD1r0oDyguNZD96pM9owdlicvFhIueCLyXRCEFmRHAElZmg/vunia
         c0y1SNyMR2hAhy018pb39nsE/AEzM+d5GtR5qOW7vTHHSDy1x/vItG8pWIZEr6fhy+AP
         ZujdJnMkCI39RZf0/WSMUV2UqO+ZxEI6n7EFxdUFrRNzkjMLobrUj1aH0kUITzA8XUND
         YFRA==
X-Gm-Message-State: AOAM530xuv3OvdTwmLHKYDH2dOLVRtU3YwNvyf/sXzCk/IjAVPVfb3AN
        eizBaByoVSN1Hgh0YUtP7aGC
X-Google-Smtp-Source: ABdhPJyRlCojM5NMEXP9w3XIS/sCcanKf8LrNsIJpeQOfBQ0femryhqcgTQIORPf0+wab+FZ1K3W0A==
X-Received: by 2002:aa7:8a0d:: with SMTP id m13mr6118466pfa.13.1598102035821;
        Sat, 22 Aug 2020 06:13:55 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d94:5e90:8021:8773:d646:5b0b])
        by smtp.gmail.com with ESMTPSA id ha17sm580529pjb.6.2020.08.22.06.13.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 06:13:54 -0700 (PDT)
Date:   Sat, 22 Aug 2020 18:43:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add initial support for ATC260x PMICs
Message-ID: <20200822131343.GA5954@Mani-XPS-13-9360>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <20200821222653.GA2255465@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821222653.GA2255465@BV030612LT>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Cristi,

Thanks for the series! I'll take a look soon but there is a quick comment
below.

On Sat, Aug 22, 2020 at 01:26:53AM +0300, Cristian Ciocaltea wrote:
> I have just realized I had omitted the changelog - sorry:
> 
> Changes in v2:
> - Reworked MFD core & I2C driver
>   * Integrated Lee's feedback
>   * Added support for using the regmap within atomic contexts
>   * Added support for ATC2603C chip variant
>   * Reorganized KConfig entries
> - Improved regulator driver
>   * Added support for ATC2603C variant
>   * Used helper macros for more compact specification of regulator_desc items
>   * Added more regulator capabilities
> - Added power controller driver
>   * Provides system poweroff/reboot functionalities
>   * Requires support for I2C Atomic transfers in the Owl driver (already submitted)
> - Added onkey driver: exposes the power button as an input device
> - Added yaml binding doc
> - Rebased patchset on kernel v5.9-rc1
> 
> Kind regards,
> Cristi
> 
> On Sat, Aug 22, 2020 at 01:19:46AM +0300, Cristian Ciocaltea wrote:
> > This is re-spin of the patch series submitted some time ago by Mani,
> > who added initial support (MFD core and regulators) for the Actions
> > Semi ATC260x PMICs:
> > https://lore.kernel.org/lkml/20190617155011.15376-1-manivannan.sadhasivam@linaro.org/
> > 
> > The ATC260x family of PMICs integrates Audio Codec, Power management,
> > Clock generation and GPIO controller blocks. There are currently 3
> > variants: ATC2603A, ATC2603C and ATC2609A.
> > 
> > In addition to the ATC2609A regulator functionality provided that time,
> > this patchset adds support for the ATC2603C variant, together with some
> > new functionalities for both chips: power controller and onkey input.
> > The ATC2603A variant remains unsupported for the moment.
> > 
> > This has been tested on RoseapplePi, a SBC based on the Action Semi S500
> > SoC, which integrates ATC2603C PMIC. An initial support for this board
> > has been already submitted:
> > https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/
> > 
> > Please note that enabling the ATC260x PMICs on the compatible Actions
> > Semi Owl SoC based boards depends on the following:
> > 
> > * Actions Semi SIRQ driver (for PMIC DTS setup):
> >   https://lore.kernel.org/lkml/cover.1597852360.git.cristian.ciocaltea@gmail.com/
> > 
> > * I2C Atomic transfers in Actions Semi Owl driver (for proper operation
> >   of the power controller driver):
> >   https://lore.kernel.org/lkml/b086ef6d355d9730c839359e15eb06175283e323.1596485741.git.cristian.ciocaltea@gmail.com/
> >   
> > Thanks,
> > Cristi
> > 
> > Cristian Ciocaltea (6):
> >   dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
> >   mfd: Add MFD driver for ATC260x PMICs
> >   regulator: Add regulator driver for ATC260x PMICs

You need to preserve my authorship for above two patches. Adding the signed-off-by
is not enough.

> >   power: reset: Add poweroff driver for ATC260x PMICs
> >   input: atc260x: Add onkey driver for ATC260x PMICs
> >   MAINTAINERS: Add entry for ATC260x PMIC

I think this one too.

Thanks,
Mani

> > 
> >  .../bindings/mfd/actions,atc260x.yaml         | 221 ++++++++
> >  MAINTAINERS                                   |  12 +
> >  drivers/input/misc/Kconfig                    |  11 +
> >  drivers/input/misc/Makefile                   |   2 +-
> >  drivers/input/misc/atc260x-onkey.c            | 304 +++++++++++
> >  drivers/mfd/Kconfig                           |  18 +
> >  drivers/mfd/Makefile                          |   3 +
> >  drivers/mfd/atc260x-core.c                    | 290 ++++++++++
> >  drivers/mfd/atc260x-i2c.c                     |  73 +++
> >  drivers/power/reset/Kconfig                   |   8 +-
> >  drivers/power/reset/Makefile                  |   1 +
> >  drivers/power/reset/atc260x-poweroff.c        | 274 ++++++++++
> >  drivers/regulator/Kconfig                     |   8 +
> >  drivers/regulator/Makefile                    |   1 +
> >  drivers/regulator/atc260x-regulator.c         | 511 ++++++++++++++++++
> >  include/linux/mfd/atc260x/atc2603c.h          | 281 ++++++++++
> >  include/linux/mfd/atc260x/atc2609a.h          | 308 +++++++++++
> >  include/linux/mfd/atc260x/core.h              |  86 +++
> >  18 files changed, 2410 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> >  create mode 100644 drivers/input/misc/atc260x-onkey.c
> >  create mode 100644 drivers/mfd/atc260x-core.c
> >  create mode 100644 drivers/mfd/atc260x-i2c.c
> >  create mode 100644 drivers/power/reset/atc260x-poweroff.c
> >  create mode 100644 drivers/regulator/atc260x-regulator.c
> >  create mode 100644 include/linux/mfd/atc260x/atc2603c.h
> >  create mode 100644 include/linux/mfd/atc260x/atc2609a.h
> >  create mode 100644 include/linux/mfd/atc260x/core.h
> > 
> > -- 
> > 2.28.0
> > 
