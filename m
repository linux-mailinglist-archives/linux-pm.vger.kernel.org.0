Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC85C3D908F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 16:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhG1O1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbhG1O07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 10:26:59 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96844C0613D3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 07:26:54 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id k65so4173541yba.13
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F8V+1MSveHL3w2OodER+J7c5R1ZGU/wPZK7SWk+KjFE=;
        b=MgMqatXgVQCwLNtXTOHzlGapZbvxnu+g2A5BSTVwUwpYU+gvpvwDPMulmKYSbBOcvB
         OJYalM2Pg/iEjD/PtqfxjJF7Ivtyc9dhRgohFp9KhU9lxW42M2Caz6AvA8L4gWWw4K/G
         7mZ6+TCoMnMxM7Jl8/fUw4hRv/tfd1nu9MaNICjBgZeN+0ZD22ooZcBO1g2ffuUS+bdu
         s4kFA/8CN95Id1M15z8wdwbI2CmFjOHJXMDJD/Q+HKI2cQ46xUKcazjbqSjvZYkyriJ8
         SLlZ2DmD9tTV0vhlqFnS36lNW2mgXSzwSi/sjMp8YsqvTOloBPnib5kRmQMP/Gh+i87G
         9PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F8V+1MSveHL3w2OodER+J7c5R1ZGU/wPZK7SWk+KjFE=;
        b=Wl9PiX8GWVNT6uzukVXmkEwwsasZgy8hclvUtzbFCOGzdi55t1Zv6SUoy3DCZOATg8
         XPpuIvyN0AL2oUHOTIGuUKH6L0P6crPlFsmdALj88pyx+06NN8tSdTgZfSKR6Dni4EyN
         NPMfbJ1KmFwg4eTgDyRaTCEblhLugb4JnMiyw7CGFUnTe/khaTCcErTfpnOexciuggp3
         qBZPeqhrSUSjRU4UkARA91BAGkU3IeBRSTveZeQ1/TRthxmAdWvryJvzESNUK/Il8um+
         OhYtNsGA+dgSx37HzT15AW2KEtVTwpEoPm7ULDhPEgliP4ULbzRBNcPCBktd+nhE3fDB
         7AIg==
X-Gm-Message-State: AOAM531vv1I7HADFJm3K6eFDpHTBXrpQ6RwjUKteEjlNcKj/STm3Z4oT
        mQRvbgq9QhmONNQwupFA3mJmL6v69V+VTnLeQR8=
X-Google-Smtp-Source: ABdhPJz4V+3o3miazbquCn2waofoW8dhZpLXCTrBlSD2yny/lcrjU1OY7NsWl/r/O9N2fOs508ecOv/oQqFzuNFETzs=
X-Received: by 2002:a5b:303:: with SMTP id j3mr36721843ybp.433.1627482413807;
 Wed, 28 Jul 2021 07:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210726190130.1973-1-macroalpha82@gmail.com> <CAMdYzYqjrReKOWBMsaGpjj-hSvQYap=hMeyvpeggKuz+mVkULw@mail.gmail.com>
 <SN6PR06MB5342D49BE4F5EBB271FDBB59A5EA9@SN6PR06MB5342.namprd06.prod.outlook.com>
In-Reply-To: <SN6PR06MB5342D49BE4F5EBB271FDBB59A5EA9@SN6PR06MB5342.namprd06.prod.outlook.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 28 Jul 2021 10:26:41 -0400
Message-ID: <CAMdYzYqaTCYFeGDAceRPoje6buirxfa2BPGssVOAb-jaKjcn8w@mail.gmail.com>
Subject: Re: [RFC v2 0/4] power: supply: Add Support for RK817 Charger
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        maccraft123mc@gmail.com, sre@kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 28, 2021 at 10:15 AM Chris Morgan <macromorgan@hotmail.com> wro=
te:
>
> On Wed, Jul 28, 2021 at 08:57:52AM -0400, Peter Geis wrote:
> > On Mon, Jul 26, 2021 at 3:02 PM Chris Morgan <macroalpha82@gmail.com> w=
rote:
> > >
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >
> > > As this is my first charger driver, I'm submitting it as an RFC so I
> > > can get input from the community on what else is needed to make the
> > > driver consistent with the quality upstream expects.
> > >
> > > This series is to add support for the Rockchip rk817 battery charger
> > > which is present in all Rockchip RK817 PMICs. The driver was written
> > > as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
> > > myself Chris Morgan <macromorgan@hotmail.com>.
> > >
> > > The driver requires some basic parameters be described about the
> > > battery in the devicetree such as the maximum capacity, the minimum
> > > and maximum voltage for the battery, the maximum charge current, the
> > > maximum charge voltage, and the value of sample resistors and sleep
> > > currents.
> > >
> > > The hardware itself contains an ADC capable of measuring the voltage,
> > > current, and temperature of the battery (though my implementation of =
an
> > > Odroid Go Advance lacks a thermistor for temperature). It also contai=
ns
> > > a columb counter, registers for tracking the measured voltage and
> > > current at boot, and a few bytes of nvram for storing data.
> >
> > Feel free to add my Tested-by: Peter Geis <pgwipeout@gmail.com>
>
> Thank you. Have you checked out the audio driver yet? Would be nice to
> see how it works on a device other than the Odroid Go Advance.

I would love to, but we still need to port the i2s-tdm driver over for
that functionality in the rk356x.
Once we have that, I'll be happy to test it.

>
> >
> > Tested on the Pine64 Quartz64 Model A.
> > We can't go as low on the battery voltage, otherwise the SOC becomes
> > unstable before it can shut down.
> > <3625000 0> seems sufficient for us though (adding this for the
> > benefit of anyone else testing).
> >
> > Voltages are accurate as measured at the battery.
> > Are there plans to expose the thermal sensor (if that's possible)?
>
> Unfortunately it might be more than we are capable of. The output of
> the thermal sensor from the ADC is stored in register 0x7c and 0x7d,
> however the datasheet doesn't tell me the scale/how to translate it
> to degrees. For the other ADC values there were coefficients in the
> BSP kernel, but there is nothing for the temperature unfortunately.
> Additionally, my hardware doesn't have a thermistor, so even if I
> wanted to reverse engineer it some way I don't have the means. For
> me those registers just read 0xff 0xff, which I assume is what it
> reads when the values are not present.

Okay, we have the thermistor connected so I can look into this.

>
> >
> > >
> > > Changes from V1:
> > >
> > >  - Fixed a CLANG warning regarding an uninitalized variable.
> > >  - Fixed a CLANG warning regarding a pointer as a bool value always
> > >    returning as true.
> > >  - Added Maya Matuszczyk to the Signed-off-by.
> > >
> > > Chris Morgan (4):
> > >   [RFC v2 1/4] dt-bindings: Add Rockchip rk817 battery charger suppor=
t
> > >   [RFC v2 2/4] mfd: Add Rockchip rk817 battery charger support
> > >   [RFC v2 3/4] power: supply: Add charger driver for Rockchip RK817
> > >   [RFC 4/4] arm64: dts: rockchip: add rk817 charger to Odroid Go Adva=
nce
> > >
> > >  .../devicetree/bindings/mfd/rk808.txt         |  35 +-
> > >  .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  25 +
> > >  drivers/mfd/rk808.c                           |  16 +-
> > >  drivers/power/supply/Kconfig                  |   6 +
> > >  drivers/power/supply/Makefile                 |   1 +
> > >  drivers/power/supply/rk817_charger.c          | 932 ++++++++++++++++=
++
> > >  include/linux/mfd/rk808.h                     |  87 ++
> > >  7 files changed, 1099 insertions(+), 3 deletions(-)
> > >  create mode 100644 drivers/power/supply/rk817_charger.c
> > >
> > > --
> > > 2.25.1
> > >
> > >
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flis=
ts.infradead.org%2Fmailman%2Flistinfo%2Flinux-rockchip&amp;data=3D04%7C01%7=
C%7Ca5cf5e4a240e4f76b67508d951c75713%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1=
%7C0%7C637630738863903897%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI=
joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DdriHUKoWSfpQ5y=
V7E3Jo7pyQDwoxZ7wl56A8OB0XwyA%3D&amp;reserved=3D0
