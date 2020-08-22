Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F149124EA70
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 01:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgHVXYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Aug 2020 19:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgHVXYL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Aug 2020 19:24:11 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F6AC061573;
        Sat, 22 Aug 2020 16:24:09 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id di22so4980170edb.12;
        Sat, 22 Aug 2020 16:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Y7f9Xm7v0nGDpdXPmRW8vOuI1YSbNsKgcTvjCP8tEM=;
        b=mh5dbrQUG/l3CZ6OUbTiw9PTjkn0qWtJDHWBegMmFjIY4jZNgDxAi8yQA3rPug4OiB
         zy2MCNHhdjBTCQIxN8Qfk6yybwXNnjKICphLXpv/V/yMcdUaCCYTvY9i/8rBQ1k6ofcG
         MkIyJi3e1GIOHaKhZhYyEak5VEzvK1A3jAsjPPc+K6HgjfjUFG5bh5t9sqXHyM27i4Vy
         jPufr2UnVxxNuXa20KQV8/EAZjrty6zLvyeeEFbxvhh5TtRe8WSAZxti6pbqA9atHqmM
         EQFybR6TH/XH++l6dTTHL9UfJV11eAsfiQCXoYqEV1Tdf/V2JxPczJg7MxcEVpu7UbpL
         +/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Y7f9Xm7v0nGDpdXPmRW8vOuI1YSbNsKgcTvjCP8tEM=;
        b=Jwqmafgbn/xHO866A2KKPGvDr4b4KPd8jrf1lXPPPZLFX2Dl6PfSvol5BnxfTSExuE
         PGmPsBP8j0idHUWtkhm2rpw2oMxen+PhzzOSPqfvzo8eq3Ac3ME627qE16AzJZLrAv0c
         P92geOX0AKHDu830de429THA6qzjfpSFwaUeSQvtwrwgXoff2vK45V80UE8T72G/lmxD
         kudqFh/iv15/qA7q5sPIkKBrqbkeAvicDJnhe8Zi1fEJQ6vt16TqMeehYxTXRsLQvWbq
         OygZgXcIPtSDxFXUSQjlcvy/ilivbx1WQqtq0zv9PgurTnceTaWTwRFp+H91Xps1GPjT
         bBdw==
X-Gm-Message-State: AOAM532WialMHilLfs/QZtS4C/RpH5GaPDOuIP+CULbeQdz9G1WJQsoL
        9qXzcf8RLGK5FMiraDFzBSI=
X-Google-Smtp-Source: ABdhPJx8dvKf7ZC5W+KduDx+/c1sFm5WWOWbntchk1xRMi5Sr8P6+Tu2VlVxDyE4m1YjQ/xfzFRxaw==
X-Received: by 2002:a05:6402:3193:: with SMTP id di19mr9110918edb.224.1598138648402;
        Sat, 22 Aug 2020 16:24:08 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id dr21sm4518213ejc.112.2020.08.22.16.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 16:24:07 -0700 (PDT)
Date:   Sun, 23 Aug 2020 02:24:05 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20200822232405.GA2261833@BV030612LT>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <20200821222653.GA2255465@BV030612LT>
 <20200822131343.GA5954@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822131343.GA5954@Mani-XPS-13-9360>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mani,

On Sat, Aug 22, 2020 at 06:43:43PM +0530, Manivannan Sadhasivam wrote:
> Hi Cristi,
> 
> Thanks for the series! I'll take a look soon but there is a quick comment
> below.
> 
> On Sat, Aug 22, 2020 at 01:26:53AM +0300, Cristian Ciocaltea wrote:
> > I have just realized I had omitted the changelog - sorry:
> > 
> > Changes in v2:
> > - Reworked MFD core & I2C driver
> >   * Integrated Lee's feedback
> >   * Added support for using the regmap within atomic contexts
> >   * Added support for ATC2603C chip variant
> >   * Reorganized KConfig entries
> > - Improved regulator driver
> >   * Added support for ATC2603C variant
> >   * Used helper macros for more compact specification of regulator_desc items
> >   * Added more regulator capabilities
> > - Added power controller driver
> >   * Provides system poweroff/reboot functionalities
> >   * Requires support for I2C Atomic transfers in the Owl driver (already submitted)
> > - Added onkey driver: exposes the power button as an input device
> > - Added yaml binding doc
> > - Rebased patchset on kernel v5.9-rc1
> > 
> > Kind regards,
> > Cristi
> > 
> > On Sat, Aug 22, 2020 at 01:19:46AM +0300, Cristian Ciocaltea wrote:
> > > This is re-spin of the patch series submitted some time ago by Mani,
> > > who added initial support (MFD core and regulators) for the Actions
> > > Semi ATC260x PMICs:
> > > https://lore.kernel.org/lkml/20190617155011.15376-1-manivannan.sadhasivam@linaro.org/
> > > 
> > > The ATC260x family of PMICs integrates Audio Codec, Power management,
> > > Clock generation and GPIO controller blocks. There are currently 3
> > > variants: ATC2603A, ATC2603C and ATC2609A.
> > > 
> > > In addition to the ATC2609A regulator functionality provided that time,
> > > this patchset adds support for the ATC2603C variant, together with some
> > > new functionalities for both chips: power controller and onkey input.
> > > The ATC2603A variant remains unsupported for the moment.
> > > 
> > > This has been tested on RoseapplePi, a SBC based on the Action Semi S500
> > > SoC, which integrates ATC2603C PMIC. An initial support for this board
> > > has been already submitted:
> > > https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/
> > > 
> > > Please note that enabling the ATC260x PMICs on the compatible Actions
> > > Semi Owl SoC based boards depends on the following:
> > > 
> > > * Actions Semi SIRQ driver (for PMIC DTS setup):
> > >   https://lore.kernel.org/lkml/cover.1597852360.git.cristian.ciocaltea@gmail.com/
> > > 
> > > * I2C Atomic transfers in Actions Semi Owl driver (for proper operation
> > >   of the power controller driver):
> > >   https://lore.kernel.org/lkml/b086ef6d355d9730c839359e15eb06175283e323.1596485741.git.cristian.ciocaltea@gmail.com/
> > >   
> > > Thanks,
> > > Cristi
> > > 
> > > Cristian Ciocaltea (6):
> > >   dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
> > >   mfd: Add MFD driver for ATC260x PMICs
> > >   regulator: Add regulator driver for ATC260x PMICs
> 
> You need to preserve my authorship for above two patches. Adding the signed-off-by
> is not enough.

I'm very sorry for the mistake, I was not aware of the correct reposting
procedure. Should I resend the series now or could we handle a first round
of review before?

Thanks,
Cristi

> > >   power: reset: Add poweroff driver for ATC260x PMICs
> > >   input: atc260x: Add onkey driver for ATC260x PMICs
> > >   MAINTAINERS: Add entry for ATC260x PMIC
> 
> I think this one too.
> 
> Thanks,
> Mani
> 
> > > 
> > >  .../bindings/mfd/actions,atc260x.yaml         | 221 ++++++++
> > >  MAINTAINERS                                   |  12 +
> > >  drivers/input/misc/Kconfig                    |  11 +
> > >  drivers/input/misc/Makefile                   |   2 +-
> > >  drivers/input/misc/atc260x-onkey.c            | 304 +++++++++++
> > >  drivers/mfd/Kconfig                           |  18 +
> > >  drivers/mfd/Makefile                          |   3 +
> > >  drivers/mfd/atc260x-core.c                    | 290 ++++++++++
> > >  drivers/mfd/atc260x-i2c.c                     |  73 +++
> > >  drivers/power/reset/Kconfig                   |   8 +-
> > >  drivers/power/reset/Makefile                  |   1 +
> > >  drivers/power/reset/atc260x-poweroff.c        | 274 ++++++++++
> > >  drivers/regulator/Kconfig                     |   8 +
> > >  drivers/regulator/Makefile                    |   1 +
> > >  drivers/regulator/atc260x-regulator.c         | 511 ++++++++++++++++++
> > >  include/linux/mfd/atc260x/atc2603c.h          | 281 ++++++++++
> > >  include/linux/mfd/atc260x/atc2609a.h          | 308 +++++++++++
> > >  include/linux/mfd/atc260x/core.h              |  86 +++
> > >  18 files changed, 2410 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > >  create mode 100644 drivers/input/misc/atc260x-onkey.c
> > >  create mode 100644 drivers/mfd/atc260x-core.c
> > >  create mode 100644 drivers/mfd/atc260x-i2c.c
> > >  create mode 100644 drivers/power/reset/atc260x-poweroff.c
> > >  create mode 100644 drivers/regulator/atc260x-regulator.c
> > >  create mode 100644 include/linux/mfd/atc260x/atc2603c.h
> > >  create mode 100644 include/linux/mfd/atc260x/atc2609a.h
> > >  create mode 100644 include/linux/mfd/atc260x/core.h
> > > 
> > > -- 
> > > 2.28.0
> > > 
