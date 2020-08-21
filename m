Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4022C24E34D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 00:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHUW1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 18:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgHUW06 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 18:26:58 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50CEC061573;
        Fri, 21 Aug 2020 15:26:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so2843764edv.11;
        Fri, 21 Aug 2020 15:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xVtjZRNRS3E8MVTp7lHDkvpy13Q1fp6Wa/UA+c8+FM=;
        b=Bxa+FV2CpjigcBwmlJ0mAZ6CFy5eNN8qLauJWLCHmjyOrmPjCKQX+oKc18WbH/dX96
         lQtBKJRd9iNGtLhKGRWVePgG+4jOgBBsRYArMhBWZTvPRueWGD9ko+My68SQN5wGQ6wN
         VLKk6MMJ8BfmYZDprO6rX9nxtc2GlFJ1nGKYgOgBm7og9JbzxZMrPuTPN+aQY0j1Mij2
         fXDi4vBb3kClkMtAtzx9z6UfZE95+mrx4bApQtyDd+5GUJ7isAJpriROBxvYzmXfAhvh
         xa6LxLtqBDrGn6/lGLt4IzpFLqpvfrKGjVDaN3pTa8dOvkP7mGkcUGRgplgLJ9cX6XEE
         pSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xVtjZRNRS3E8MVTp7lHDkvpy13Q1fp6Wa/UA+c8+FM=;
        b=OA2DJFdejpEQmcNzP15Y87NQzFjYEWHXQsEd9cqK9O5fbWrsPc5Al7MAoecWOAA36c
         gFTqxj/8IgyZW/BkNeqsW+uCK5zYcAh1m2zU2nVSXZNUf4YI7qiGjxivvgLnIfnSxsf7
         XLJIhr6PRMvg8wMYZhb+pzbjdfd/LKt3Lfyn273iZzXS71qArL1IEu9v/vfTggX42FjV
         czqOfhH654OhZUpWJD9kIlmGjun/hxrA4lWSNkhxoXphqUvh1dttQm6rlkWsOX0L7TL2
         3jERgnAFDWxGLc/s1IxopWj5Kw5DtuDzrzQONG96e1oWpI3AO9RVi1vPp1FXTXQ8g8vB
         WPVA==
X-Gm-Message-State: AOAM531axZ7Iod8BX+DaJdtXY4gR1l5cOpVSDA4xD7sEYlhyJjDdVzpw
        LeH79yrESPF63QmgCZ8tCvw=
X-Google-Smtp-Source: ABdhPJxLrBiXYSrNYXMVCMuh+sIT//JDR2ezQOjASjRkpp2BLAQVyiAzZ32tZvDhOURB2PDhXBmssQ==
X-Received: by 2002:a05:6402:6da:: with SMTP id n26mr5103065edy.262.1598048816550;
        Fri, 21 Aug 2020 15:26:56 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id bx22sm2057801ejc.18.2020.08.21.15.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:26:56 -0700 (PDT)
Date:   Sat, 22 Aug 2020 01:26:53 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add initial support for ATC260x PMICs
Message-ID: <20200821222653.GA2255465@BV030612LT>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I have just realized I had omitted the changelog - sorry:

Changes in v2:
- Reworked MFD core & I2C driver
  * Integrated Lee's feedback
  * Added support for using the regmap within atomic contexts
  * Added support for ATC2603C chip variant
  * Reorganized KConfig entries
- Improved regulator driver
  * Added support for ATC2603C variant
  * Used helper macros for more compact specification of regulator_desc items
  * Added more regulator capabilities
- Added power controller driver
  * Provides system poweroff/reboot functionalities
  * Requires support for I2C Atomic transfers in the Owl driver (already submitted)
- Added onkey driver: exposes the power button as an input device
- Added yaml binding doc
- Rebased patchset on kernel v5.9-rc1

Kind regards,
Cristi

On Sat, Aug 22, 2020 at 01:19:46AM +0300, Cristian Ciocaltea wrote:
> This is re-spin of the patch series submitted some time ago by Mani,
> who added initial support (MFD core and regulators) for the Actions
> Semi ATC260x PMICs:
> https://lore.kernel.org/lkml/20190617155011.15376-1-manivannan.sadhasivam@linaro.org/
> 
> The ATC260x family of PMICs integrates Audio Codec, Power management,
> Clock generation and GPIO controller blocks. There are currently 3
> variants: ATC2603A, ATC2603C and ATC2609A.
> 
> In addition to the ATC2609A regulator functionality provided that time,
> this patchset adds support for the ATC2603C variant, together with some
> new functionalities for both chips: power controller and onkey input.
> The ATC2603A variant remains unsupported for the moment.
> 
> This has been tested on RoseapplePi, a SBC based on the Action Semi S500
> SoC, which integrates ATC2603C PMIC. An initial support for this board
> has been already submitted:
> https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/
> 
> Please note that enabling the ATC260x PMICs on the compatible Actions
> Semi Owl SoC based boards depends on the following:
> 
> * Actions Semi SIRQ driver (for PMIC DTS setup):
>   https://lore.kernel.org/lkml/cover.1597852360.git.cristian.ciocaltea@gmail.com/
> 
> * I2C Atomic transfers in Actions Semi Owl driver (for proper operation
>   of the power controller driver):
>   https://lore.kernel.org/lkml/b086ef6d355d9730c839359e15eb06175283e323.1596485741.git.cristian.ciocaltea@gmail.com/
>   
> Thanks,
> Cristi
> 
> Cristian Ciocaltea (6):
>   dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
>   mfd: Add MFD driver for ATC260x PMICs
>   regulator: Add regulator driver for ATC260x PMICs
>   power: reset: Add poweroff driver for ATC260x PMICs
>   input: atc260x: Add onkey driver for ATC260x PMICs
>   MAINTAINERS: Add entry for ATC260x PMIC
> 
>  .../bindings/mfd/actions,atc260x.yaml         | 221 ++++++++
>  MAINTAINERS                                   |  12 +
>  drivers/input/misc/Kconfig                    |  11 +
>  drivers/input/misc/Makefile                   |   2 +-
>  drivers/input/misc/atc260x-onkey.c            | 304 +++++++++++
>  drivers/mfd/Kconfig                           |  18 +
>  drivers/mfd/Makefile                          |   3 +
>  drivers/mfd/atc260x-core.c                    | 290 ++++++++++
>  drivers/mfd/atc260x-i2c.c                     |  73 +++
>  drivers/power/reset/Kconfig                   |   8 +-
>  drivers/power/reset/Makefile                  |   1 +
>  drivers/power/reset/atc260x-poweroff.c        | 274 ++++++++++
>  drivers/regulator/Kconfig                     |   8 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/atc260x-regulator.c         | 511 ++++++++++++++++++
>  include/linux/mfd/atc260x/atc2603c.h          | 281 ++++++++++
>  include/linux/mfd/atc260x/atc2609a.h          | 308 +++++++++++
>  include/linux/mfd/atc260x/core.h              |  86 +++
>  18 files changed, 2410 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
>  create mode 100644 drivers/input/misc/atc260x-onkey.c
>  create mode 100644 drivers/mfd/atc260x-core.c
>  create mode 100644 drivers/mfd/atc260x-i2c.c
>  create mode 100644 drivers/power/reset/atc260x-poweroff.c
>  create mode 100644 drivers/regulator/atc260x-regulator.c
>  create mode 100644 include/linux/mfd/atc260x/atc2603c.h
>  create mode 100644 include/linux/mfd/atc260x/atc2609a.h
>  create mode 100644 include/linux/mfd/atc260x/core.h
> 
> -- 
> 2.28.0
> 
