Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 829911545DB
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 15:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgBFOOO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 09:14:14 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38065 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgBFOOO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 09:14:14 -0500
Received: by mail-vs1-f67.google.com with SMTP id r18so3830941vso.5
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2020 06:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zq26qbESibgRQo9Jt8lbKYJuguzXROj1d9xvP1lsLj0=;
        b=OTMh3ak8WHbmFIhfKhaZWiZins4prgaMm65Qnrse7HErepdEtI+xZHcTAvKk7tfg7D
         REYznSAyc53K8kO2ydadMMaEqwqh9dpEN2Nvv2aGDuGKHQSrS+PCkvgDkjxCPxJ4/I78
         ZMtLb8n3yFdJB52xNRI0NG3sYhtqcy1ygP0UsVTA0jpjuipHUNg5ZYDTa+SernIq6/2v
         A9R1M8XXJzFuE4q6pbo/GSnjb49a/oh6z7m6pqaoqsUbAuNJ3/nNsWGlT+XaBk/jllzs
         vD68vLYPo+HZRLZwME/z63FNLHCf1FlIJ1cJvzPHh2Xr+kEWw9wTHTpU44GBJb4ekNPs
         HBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zq26qbESibgRQo9Jt8lbKYJuguzXROj1d9xvP1lsLj0=;
        b=dsjO1agwAQLhJp1u71x3FQaxJ3ctOOpR9+hJ+E4W8j2I4kMRS6kwMJ5BiMNkEoFh0I
         N7q6qEHjlhmh0KEinof/rZHrbRUgNu/s74UrWwmn/UmJEcksm0hkPGE2WBi9huLvydg9
         OOR0jlOe9Kc6xJghOOQs97XF0fMHVVo1oTc6PUK1qPXW46bZwffimDGKr1QSQjgz9Z0O
         NrJ+4qozUy0HalO3j9BafEYf8o4EsMYcQ0xpkOl6LBDuAWc4FWU0NZWLS5I8Ss+Gokg5
         q0eHI+tdVskbfCgiZxET8LhV1xTElu7vxEBT5rV/u7arU1z8UrkyJGZW45BmUl/NeCKt
         jjiQ==
X-Gm-Message-State: APjAAAV9CHWNfUs0Lo6M4uWm8CPHmqZOf66TnvHp45et0VtAkbJMJQdz
        u/aJ4aeMxLtm0D2l5dX7wsSV2zzum2vBhu58O0M+zg==
X-Google-Smtp-Source: APXvYqzebCTr2QcQz9u5oLrDGawETmoHyGUrr+V12r7zXovoI3ed0UYSk2EhVLGHr9yZ7IKix4nLC4jFkJMS3Wfbtsk=
X-Received: by 2002:a67:d011:: with SMTP id r17mr1672458vsi.159.1580998451210;
 Thu, 06 Feb 2020 06:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20191219172823.1652600-1-anarsoul@gmail.com>
In-Reply-To: <20191219172823.1652600-1-anarsoul@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 6 Feb 2020 19:43:59 +0530
Message-ID: <CAHLCerPWEDqEE8LRUiO5GpeP+BfnestocndBQq6oXAxVN=+3ow@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vasily,

For this entire series, the DTS files don't contain any trip points.
Did I miss some other series?

At a minimum, you should add some "hot" or "critical" trip points
since then don't require a cooling-map with throttling actions. If you
have "passive" trip points, then you need to provide cooling-maps.

Since this series has been merged, could you please follow up with a
fixup series to add the trip points?

Regards,
Amit
p.s. We should catch all this automatically, I'll send out yaml
bindings for the thermal framework soon that should catch this stuff.

On Thu, Dec 19, 2019 at 10:58 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> H6 and R40 SoCs.
>
> v8:
>         - [vasily] Address more Maxime's comments for dt-schema
>         - [vasily] Add myself to MAINTAINERS for the driver and schema
>         - [vasily] Round calibration data size to word boundary for H6 and A64
>         - [vasily] Change offset for A64 since it reports too low temp otherwise.
>                    Likely conversion formula in user manual is not correct.
>
> v7:
>         - [vasily] Address Maxime's comments for dt-schema
>         - [vasily] Move common part of H3 and H5 dts into sunxi-h3-h5.dtsi
>         - [vasily] Add Maxime's a-b to the driver patch
>
> v6:
>         - [ondrej, vasily] Squash all driver related changes into a
>                            single patch
>         - [ondrej] Rename calib -> calibration
>         - [ondrej] Fix thermal zone registration check
>         - [ondrej] Lower rate of sensor data interrupts to 4/sec/sensor
>         - [ondrej] Rework scale/offset values, H6 calibration
>         - [ondrej] Explicitly set mod clock to 24 MHz
>         - [ondrej] Set undocumented bits in CTRL0 for H6
>         - [ondrej] Add support for A83T
>         - [ondrej] Add dts changes for A83T, H3, H5, H6
>         - [vasily] Add dts changes for A64
>         - [vasily] Address Maxime's comments for YAML scheme
>         - [vasily] Make .calc_temp callback mandatory
>         - [vasily] Set .max_register in regmap config, so regs can be
>                    inspected using debugfs
>
> Ondrej Jirman (4):
>   ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
>   ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
>   arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
>   arm64: dts: allwinner: h6: Add thermal sensor and thermal zones
>
> Vasily Khoruzhick (1):
>   arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
>
> Yangtao Li (2):
>   thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
>   dt-bindings: thermal: add YAML schema for sun8i-thermal driver
>     bindings
>
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 160 +++++
>  MAINTAINERS                                   |   8 +
>  arch/arm/boot/dts/sun8i-a83t.dtsi             |  36 +
>  arch/arm/boot/dts/sun8i-h3.dtsi               |  20 +
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |   6 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  42 ++
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  26 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +
>  drivers/thermal/Kconfig                       |  14 +
>  drivers/thermal/Makefile                      |   1 +
>  drivers/thermal/sun8i_thermal.c               | 639 ++++++++++++++++++
>  11 files changed, 985 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
>  create mode 100644 drivers/thermal/sun8i_thermal.c
>
> --
> 2.24.1
>
