Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23D7154C18
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 20:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBFTXs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 14:23:48 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45484 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFTXs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 14:23:48 -0500
Received: by mail-vk1-f194.google.com with SMTP id g7so1930232vkl.12
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2020 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2t7kk/1bpGDazBh7M5TloR9sVuVnHpzkthWO4hHktzU=;
        b=MGESQ+IxWEt/9Y1lL3WS7J6QtOa7pHsGxDEv6zoGQxpXoKioee+39Ysl5vZ4c45W1o
         nk7zSxpiBM0gCPx3YLVZZovnkssHejQnY2vxOIUXgvQ+nUE97QCC4VRLm0TIOepv+h/k
         5/A9XbflEPqcZTjuHR+DICIfzCf4Jds09wIVxkjjyF8FigS1XE7K8/P9TIZq13UW00Ar
         q3XCbs3/A65vyh9vpOwiOQW9a/l0SFcUA9ubz7oMGPGKWP5ANbZip8azUKHi15C1z32e
         nAu5Sn3eiqQoxTV0aOHDiSvO75+j/PiSHjyYVqJAEAhLrYNiFNzWoWHou+mMTWLo4867
         SKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2t7kk/1bpGDazBh7M5TloR9sVuVnHpzkthWO4hHktzU=;
        b=YxqU13D0sncB3LbFr7GrXlax+tSMM1RVjD+l9/PE/9+69KrxyetAShjysjvJG407oc
         w7eZ7MQGVk61TOAImOx6nqPqyjPTW1zyREKyxIxI6OKMr7VbRsXrRcXUmfVHnGftTkJ4
         3V0Jf8xf+cL9XIEU5qI0ibe6Va0nKgzug5YOLF0H6srqGjkK3crYiTl6dGWS3Y+/ZMf1
         scZBQNA48fUE9Wgrokdg2SK94zQchJbl0cjk+qS+iNOFFDj0FfliXfwEpqi+VK7HgVRZ
         Y/cEiQ9Ddf4lV1zhpqXKkIstVJ2hvXj0z5y3HcJNEtNlpefYiVeqHkvFFDWx/GMo2qTi
         Rw0w==
X-Gm-Message-State: APjAAAXxlHZs4KpxfaitBvCEk/PfQAm2KKWouYG5YQN0dIRPOSuwYv1y
        3tJGIqeNVER9EukmeOAZnlbnLws5fCpDTJdn/FsJrg==
X-Google-Smtp-Source: APXvYqw0uOUcEtkACNs/U0sJtZSRFEeaRY33nIGAsIIaR8s4C4Kp0W76YvfhYf/D8oYAtyZFNHsWstF/geBfUtugtow=
X-Received: by 2002:ac5:c7a9:: with SMTP id d9mr2720800vkn.79.1581017027140;
 Thu, 06 Feb 2020 11:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20191219172823.1652600-1-anarsoul@gmail.com> <CAHLCerPWEDqEE8LRUiO5GpeP+BfnestocndBQq6oXAxVN=+3ow@mail.gmail.com>
 <af5383b5-2dd4-92ab-ded2-f1cde48bb21a@linaro.org>
In-Reply-To: <af5383b5-2dd4-92ab-ded2-f1cde48bb21a@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 7 Feb 2020 00:53:36 +0530
Message-ID: <CAHLCerPir-7DEpweGZ9qoowm+u3BtDdLyB-B18KibMo9y+Q_DQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 6, 2020 at 10:16 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Amit,
>
> On 06/02/2020 15:13, Amit Kucheria wrote:
> > Hi Vasily,
> >
> > For this entire series, the DTS files don't contain any trip points.
> > Did I miss some other series?
> >
> > At a minimum, you should add some "hot" or "critical" trip points
> > since then don't require a cooling-map with throttling actions. If you
> > have "passive" trip points, then you need to provide cooling-maps.
>
> Except I'm misunderstanding the bindings, a thermal zone must define
> these required properties:
>
> - polling-delay
> - polling-delay-passive
> - thermal-sensors
> - trips
> - cooling-maps

Right, except for the cooling-maps. Those are exempted if there is the
trip type is not passive. That is my understanding of the existing
bindings.

Trip type critical triggers a shutdown and trip type hot only triggers
a notification - see thermal_core.c:handle_critical_trips(). So we
only need cooling maps for passive trip types.

> > Since this series has been merged, could you please follow up with a
> > fixup series to add the trip points?
> >
> > Regards,
> > Amit
> > p.s. We should catch all this automatically, I'll send out yaml
> > bindings for the thermal framework soon that should catch this stuff.
>
> +1
>
> There was a small discussion about converting the binding to a schema:
>
> https://www.spinics.net/lists/devicetree/msg332424.html


Aah, I missed that. I started working on something last week that
looks similar to your discussion. Pushed a WIP branch here[1], it
looks like I had a similar idea on how to split the bindings. Hope to
finish this up tomorrow for an RFC.

Regards,
Amit

[1] https://github.com/idlethread/linux/commits/up/thermal/yaml-conversion-=
v1

> > On Thu, Dec 19, 2019 at 10:58 PM Vasily Khoruzhick <anarsoul@gmail.com>=
 wrote:
> >>
> >> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> >> H6 and R40 SoCs.
> >>
> >> v8:
> >>         - [vasily] Address more Maxime's comments for dt-schema
> >>         - [vasily] Add myself to MAINTAINERS for the driver and schema
> >>         - [vasily] Round calibration data size to word boundary for H6=
 and A64
> >>         - [vasily] Change offset for A64 since it reports too low temp=
 otherwise.
> >>                    Likely conversion formula in user manual is not cor=
rect.
> >>
> >> v7:
> >>         - [vasily] Address Maxime's comments for dt-schema
> >>         - [vasily] Move common part of H3 and H5 dts into sunxi-h3-h5.=
dtsi
> >>         - [vasily] Add Maxime's a-b to the driver patch
> >>
> >> v6:
> >>         - [ondrej, vasily] Squash all driver related changes into a
> >>                            single patch
> >>         - [ondrej] Rename calib -> calibration
> >>         - [ondrej] Fix thermal zone registration check
> >>         - [ondrej] Lower rate of sensor data interrupts to 4/sec/senso=
r
> >>         - [ondrej] Rework scale/offset values, H6 calibration
> >>         - [ondrej] Explicitly set mod clock to 24 MHz
> >>         - [ondrej] Set undocumented bits in CTRL0 for H6
> >>         - [ondrej] Add support for A83T
> >>         - [ondrej] Add dts changes for A83T, H3, H5, H6
> >>         - [vasily] Add dts changes for A64
> >>         - [vasily] Address Maxime's comments for YAML scheme
> >>         - [vasily] Make .calc_temp callback mandatory
> >>         - [vasily] Set .max_register in regmap config, so regs can be
> >>                    inspected using debugfs
> >>
> >> Ondrej Jirman (4):
> >>   ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
> >>   ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
> >>   arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
> >>   arm64: dts: allwinner: h6: Add thermal sensor and thermal zones
> >>
> >> Vasily Khoruzhick (1):
> >>   arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
> >>
> >> Yangtao Li (2):
> >>   thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
> >>   dt-bindings: thermal: add YAML schema for sun8i-thermal driver
> >>     bindings
> >>
> >>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 160 +++++
> >>  MAINTAINERS                                   |   8 +
> >>  arch/arm/boot/dts/sun8i-a83t.dtsi             |  36 +
> >>  arch/arm/boot/dts/sun8i-h3.dtsi               |  20 +
> >>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |   6 +
> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  42 ++
> >>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  26 +
> >>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +
> >>  drivers/thermal/Kconfig                       |  14 +
> >>  drivers/thermal/Makefile                      |   1 +
> >>  drivers/thermal/sun8i_thermal.c               | 639 +++++++++++++++++=
+
> >>  11 files changed, 985 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/thermal/allwinne=
r,sun8i-a83t-ths.yaml
> >>  create mode 100644 drivers/thermal/sun8i_thermal.c
> >>
> >> --
> >> 2.24.1
> >>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
