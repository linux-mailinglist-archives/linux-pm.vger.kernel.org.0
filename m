Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3D6154FD7
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 01:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBGAt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 19:49:29 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42263 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBGAt3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 19:49:29 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so205931qvb.9;
        Thu, 06 Feb 2020 16:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6oOvkFZ9CSC5ckdz/CdZgJ1/qpX15ssCumnuFtMEW8=;
        b=sU8FpCBau1A8Sy5WiXmDeb7GJAtyl1hXaM0E4yNnUqb2GFL/UJDceg4Qu02bpkKxnu
         c4HNOxX8Xy2FMaH1AmGERnW7cXO3DLKOjD+6Vo08BL1il37Gqr4w5RrKATCgzeo/lpnz
         Dbmw+EsIjDlb3F48fWOOUUF6q/7aaSwKUfIee6faLLOvRJJPPdGvHTe1w8Q1ZoLSf0F5
         WhQVPfuvlm15hZVmjEKLEJAfz5bgtGSi/G1TuZbhXHzoN4N072nkC9e5MFL1S/7SBkfB
         wGDHVmcfktx1DECmrtb+V0uFxKj8LZlDgyRpWIvEINIqt6UzwPCI1QoqSWBTxUDZ1O32
         3KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6oOvkFZ9CSC5ckdz/CdZgJ1/qpX15ssCumnuFtMEW8=;
        b=JZI87+jKKW8yO4wo03YwYpRj9Ic6hNsJsdYSjjSODquNjuAny+yTh69tt+5K7Smw9s
         z4zeKeV7ulv/62J80zoFCDbXdTNmZkJ57NvMNn44MLO0ciJ2ksfMh9WTIY0CV4ED5a5R
         7wliOQ0dvP2RQWofwCFCmDEHsl+0Ex4JZXw3vb778+24puBLikG6rKR0wnYTQgizTXo6
         MlVLr9WViPjRkzZAAx9MxsF0AfPBb9kld0IfQFTfNetmoImfY3q613KY3vXGb643uY0y
         Su1IupMIUGfkPuuk4ThWw3XFXwDAaWfcDMWv7EAt/4HqqcnkzeIdYSmozHy0pWzcTfNC
         bBgg==
X-Gm-Message-State: APjAAAUDFyR3y98RCflu+D7vSIaQ8Bamw0iVCkhCgMtVCYxb+VkPeHiH
        +TjkCKoVi2HzciQ8wYqVWcuXGwxPJqZE8xlIaDk=
X-Google-Smtp-Source: APXvYqxFDtQytKEWKhZPcxgNl3MkZD9ZoQpITSB46YTjUU2thEd25m9XiMt60ChqrBM9fJtNdT3BY4EUL7SDZEWKwSY=
X-Received: by 2002:ad4:55ec:: with SMTP id bu12mr4857664qvb.107.1581036567753;
 Thu, 06 Feb 2020 16:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20191219172823.1652600-1-anarsoul@gmail.com> <CAHLCerPWEDqEE8LRUiO5GpeP+BfnestocndBQq6oXAxVN=+3ow@mail.gmail.com>
In-Reply-To: <CAHLCerPWEDqEE8LRUiO5GpeP+BfnestocndBQq6oXAxVN=+3ow@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 6 Feb 2020 16:49:01 -0800
Message-ID: <CA+E=qVf1wVLgJ3_4K3nbZtgkRUVfmfgArwssPXu2Qb0NHAB+GA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
To:     Amit Kucheria <amit.kucheria@verdurent.com>
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

On Thu, Feb 6, 2020 at 6:14 AM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> Hi Vasily,
>
> For this entire series, the DTS files don't contain any trip points.
> Did I miss some other series?

See https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?h=sunxi/dt-for-5.6&id=e1c3804a177418fe14d95f0c4ccba5ae66f73d82
for A64

> At a minimum, you should add some "hot" or "critical" trip points
> since then don't require a cooling-map with throttling actions. If you
> have "passive" trip points, then you need to provide cooling-maps.
>
> Since this series has been merged, could you please follow up with a
> fixup series to add the trip points?

A64 has already made it into linux-next, I believe there's other
series in flight at least for H6 from Yangtao Li and for H5 from
Chen-Yu Tsai

> Regards,
> Amit
> p.s. We should catch all this automatically, I'll send out yaml
> bindings for the thermal framework soon that should catch this stuff.
>
> On Thu, Dec 19, 2019 at 10:58 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> > H6 and R40 SoCs.
> >
> > v8:
> >         - [vasily] Address more Maxime's comments for dt-schema
> >         - [vasily] Add myself to MAINTAINERS for the driver and schema
> >         - [vasily] Round calibration data size to word boundary for H6 and A64
> >         - [vasily] Change offset for A64 since it reports too low temp otherwise.
> >                    Likely conversion formula in user manual is not correct.
> >
> > v7:
> >         - [vasily] Address Maxime's comments for dt-schema
> >         - [vasily] Move common part of H3 and H5 dts into sunxi-h3-h5.dtsi
> >         - [vasily] Add Maxime's a-b to the driver patch
> >
> > v6:
> >         - [ondrej, vasily] Squash all driver related changes into a
> >                            single patch
> >         - [ondrej] Rename calib -> calibration
> >         - [ondrej] Fix thermal zone registration check
> >         - [ondrej] Lower rate of sensor data interrupts to 4/sec/sensor
> >         - [ondrej] Rework scale/offset values, H6 calibration
> >         - [ondrej] Explicitly set mod clock to 24 MHz
> >         - [ondrej] Set undocumented bits in CTRL0 for H6
> >         - [ondrej] Add support for A83T
> >         - [ondrej] Add dts changes for A83T, H3, H5, H6
> >         - [vasily] Add dts changes for A64
> >         - [vasily] Address Maxime's comments for YAML scheme
> >         - [vasily] Make .calc_temp callback mandatory
> >         - [vasily] Set .max_register in regmap config, so regs can be
> >                    inspected using debugfs
> >
> > Ondrej Jirman (4):
> >   ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
> >   ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
> >   arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
> >   arm64: dts: allwinner: h6: Add thermal sensor and thermal zones
> >
> > Vasily Khoruzhick (1):
> >   arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
> >
> > Yangtao Li (2):
> >   thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
> >   dt-bindings: thermal: add YAML schema for sun8i-thermal driver
> >     bindings
> >
> >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 160 +++++
> >  MAINTAINERS                                   |   8 +
> >  arch/arm/boot/dts/sun8i-a83t.dtsi             |  36 +
> >  arch/arm/boot/dts/sun8i-h3.dtsi               |  20 +
> >  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |   6 +
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  42 ++
> >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  26 +
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +
> >  drivers/thermal/Kconfig                       |  14 +
> >  drivers/thermal/Makefile                      |   1 +
> >  drivers/thermal/sun8i_thermal.c               | 639 ++++++++++++++++++
> >  11 files changed, 985 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> >  create mode 100644 drivers/thermal/sun8i_thermal.c
> >
> > --
> > 2.24.1
> >
