Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F87320BC5
	for <lists+linux-pm@lfdr.de>; Sun, 21 Feb 2021 17:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhBUQgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 11:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBUQgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2021 11:36:50 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F3C061574;
        Sun, 21 Feb 2021 08:36:09 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id u20so24655059ejb.7;
        Sun, 21 Feb 2021 08:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vz0D2hb8azzFA/YJrEwh/eM9FqM4vxUQYz4qe31Suc4=;
        b=HT+MyzO4wdYIJXrvhLU2zCsTdoCIv0J+fvIhJKN7OfHJVu7qPGD57EHEjWRsQLpFVE
         SNoFMBK8ZmdV3cyoZEFnytfXblaUil1F4JXddiiqS/y4Y1Ri5EHcMrkuWPawemFvqG9v
         uf6eGhHVLHB9SefTiJfiPwlbSJN8SU4BhR7gMPcW7eunZQUW66ittno3G7XraoFmg40C
         40RnPog9F2vQMcbqB0Z2D6STP/HsaJmYNmDMF7+pxlOkpRsveDIVJdecpRdGnf5Ze+47
         ap2OMRY6Tenm2jx+jLUL6E56WnoM75M0c+91OyXAIfG+zGF3yohzvK0jP3GqkeFK1YzK
         AZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vz0D2hb8azzFA/YJrEwh/eM9FqM4vxUQYz4qe31Suc4=;
        b=lUYWVrvYaC4x5/IwOVrgFf2dWqpARkx9hbvi+MMw4R7QKtvNPAcZ/cAd8uKxVoKQE0
         qCu0DWv4soY0ZRp6J7CVIq+tTK5p+z38DK+IgehVj7dhfK5Mu1IxlU8y1t4DUPK/8kle
         5Dphk3TfCwGUWMV0RCDoYYTUfZOdgMHlRTZg3lqlLb08mYMFmnbMYBpJ4yZ2GRjfGMk+
         xIChEyikiHvFyRK5USNWIgIjAocS/Qc0rgDxDr8N44NICfbBn4N+KzDbGx45dXsGx3Z1
         8+CPmEeKGB/sFMMsFHI31U+4EpxJBFylllZM4ysXuD6ice8TRvKhVF9FngHLTcU+s7Ck
         Qeyw==
X-Gm-Message-State: AOAM5302AwfACEyMO+zHyu1tfgTwrMZrOe7ZiuPPIFSQf2NEWczRYChX
        1OGUfskOw/WI8tW4ROrMxjs=
X-Google-Smtp-Source: ABdhPJwoCiaTcah2Byf/IKaVAcO0yCymSQZWTCh7JF3iWtSHBloeCIoqZnEUJ5JGMPNrNqpwiqAqQg==
X-Received: by 2002:a17:906:6942:: with SMTP id c2mr2538412ejs.425.1613925366269;
        Sun, 21 Feb 2021 08:36:06 -0800 (PST)
Received: from BV030612LT ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id t19sm8406046ejc.62.2021.02.21.08.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 08:36:05 -0800 (PST)
Date:   Sun, 21 Feb 2021 18:36:02 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add initial support for ATC260x PMICs
Message-ID: <20210221163602.GA297639@BV030612LT>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lee,

I have just noticed your mfd-next tag for 5.12 doesn't include the
support for the ATC260x PMICs.

I assumed the patchset is ready for merging.. Did I miss something?

Thanks,
Cristi

On Tue, Jan 26, 2021 at 11:55:56AM +0200, Cristian Ciocaltea wrote:
> The ATC260x family of PMICs integrates Audio Codec, Power management,
> Clock generation and GPIO controller blocks. There are currently 3
> variants: ATC2603A, ATC2603C and ATC2609A.
> 
> This is re-spin of the v1 patch series submitted some time ago by
> Mani, who provided the MFD and regulator drivers for ATC2609A:
> https://lore.kernel.org/lkml/20190617155011.15376-1-manivannan.sadhasivam@linaro.org/
> 
> Since v2, I added support for ATC2603C, together with some new
> functionalities for both chips: power controller and onkey input.
> The ATC2603A chip type remains unsupported for the moment.
> 
> This has been tested on RoseapplePi, a SBC based on the Actions Semi S500
> SoC, which integrates the ATC2603C variant of the PMIC.
> 
> Note that enabling the ATC260x PMICs on compatible Actions Semi Owl SoC
> based boards depends on:
> 
> * the Actions Semi SIRQ driver (for PMIC DTS setup), merged in v5.10:
>   https://lore.kernel.org/lkml/cover.1600114378.git.cristian.ciocaltea@gmail.com/
> 
> * the atomic transfers in Owl I2C driver (for power controller), merged in v5.11:
>   https://lore.kernel.org/lkml/cover.1602190168.git.cristian.ciocaltea@gmail.com/
> 
> Additionally, please note that I have taken the authorship for the MFD
> and regulator drivers patches, considering the original code has been
> modified to a large extent.
> 
> Thanks,
> Cristi
> 
> Changes in v7:
> - Dropped the patches already queued for merging:
>   * regulator: Add regulator driver for ATC260x PMICs
>   * power: reset: Add poweroff driver for ATC260x PMICs
> - Rebased patchset on v5.11-rc5
> 
> Changes in v6 - MFD driver updates as indicated by Lee:
> - Defined a magic number for max chip revision
> - Adjusted code formatting around i2c_driver struct initialization
> - Dropped the device initialization callback in struct atc260x and instead 
>   provided a generic function making use of a new member structure to hold
>   the hardware specific register information
> 
> Changes in v5:
> - Removed an unnecessary '#include' line in the power-off driver,
>   as noticed by Sebastian
> - Rebased patchset on v5.11-rc3
> 
> Changes in v4:
> - Updated MFD driver according to Lee's review
> - Handled ATC2603C's LDO12 fixed regulator per Mark's suggestion
> - Rebased patchset on v5.11-rc1
> 
> Changes in v3:
> - Integrated feedback from Mani, Rob, Mark, Sebastian, Dmitry
> - Fixed issues reported by Lee's kernel test robot
> - Added new patch for 'reset-time-sec' DT binding property
> - Rebased patchset on v5.10-rc6
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
>   * Depends on atomic transfers in the Owl I2C driver
> - Added onkey driver: exposes the power button as an input device
> - Added yaml binding doc
> - Rebased patchset on kernel v5.9-rc1
> 
> Cristian Ciocaltea (4):
>   dt-bindings: input: Add reset-time-sec common property
>   dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
>   mfd: Add MFD driver for ATC260x PMICs
>   input: atc260x: Add onkey driver for ATC260x PMICs
> 
> Manivannan Sadhasivam (1):
>   MAINTAINERS: Add entry for ATC260x PMIC
> 
>  .../devicetree/bindings/input/input.yaml      |   7 +
>  .../bindings/mfd/actions,atc260x.yaml         | 183 +++++++++++
>  MAINTAINERS                                   |  12 +
>  drivers/input/misc/Kconfig                    |  11 +
>  drivers/input/misc/Makefile                   |   2 +-
>  drivers/input/misc/atc260x-onkey.c            | 305 +++++++++++++++++
>  drivers/mfd/Kconfig                           |  18 +
>  drivers/mfd/Makefile                          |   3 +
>  drivers/mfd/atc260x-core.c                    | 310 ++++++++++++++++++
>  drivers/mfd/atc260x-i2c.c                     |  64 ++++
>  include/linux/mfd/atc260x/atc2603c.h          | 281 ++++++++++++++++
>  include/linux/mfd/atc260x/atc2609a.h          | 308 +++++++++++++++++
>  include/linux/mfd/atc260x/core.h              |  58 ++++
>  13 files changed, 1561 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
>  create mode 100644 drivers/input/misc/atc260x-onkey.c
>  create mode 100644 drivers/mfd/atc260x-core.c
>  create mode 100644 drivers/mfd/atc260x-i2c.c
>  create mode 100644 include/linux/mfd/atc260x/atc2603c.h
>  create mode 100644 include/linux/mfd/atc260x/atc2609a.h
>  create mode 100644 include/linux/mfd/atc260x/core.h
> 
> -- 
> 2.30.0
> 
