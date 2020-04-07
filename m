Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1091A14A9
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgDGSja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 14:39:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36707 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgDGSj3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 14:39:29 -0400
Received: by mail-io1-f68.google.com with SMTP id n10so4491343iom.3;
        Tue, 07 Apr 2020 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m/dkOYJLIlXBlQ2q0cF+y0fSOD9w7drnxFN+ZiKGczc=;
        b=HhVc+VPQjdnTtHJrbSqVAIpA37XENUVVPMKJoCvMOLILhmYAt9Cg6MCTkuxbLg/S5L
         zge2X3hZMuuonoY+RSpjILUJHxY839RCYOmgj++OV+mHW57ei7rmxVvFuOng8/o1ZxiH
         dT/FJsUEcpn6bQnq8+U8F3fWSibqWlkbyWAlF3/7iZQrElRKnpCueDJY40YuPf3y96Oz
         ju3q8H2IpouARmIulQM/2D5wNoa6/8gttCaUfPdlf44J/YUPJXtnGDaaH2zGHegjV6C0
         pLKYEO/NkHyYW4zXjAEWieU56zPYQVNjR+CwfHdoZLREjYT0qki0wGDHGsQTSlNxQ+RU
         f6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m/dkOYJLIlXBlQ2q0cF+y0fSOD9w7drnxFN+ZiKGczc=;
        b=n00gcgI66r/MswzOvjPb9SoYJQmqdZtzO7WtL/zF6r1LVhi42iSqV90uG5LIZsxJ2L
         q16A2L+p2Ym32ecoIyxq7euBHxcOLA591PdKRFHy84Bn8kBfE77+ZuBwtgilswXfm6L9
         ez4Z26a+go85IchqWnHkio6LUkTgweMtBiW3lASDb0cPve8MybmZLYyTIt9bsLqwh3ZP
         QXrGg+YU9rR0sW6t/GVc8gfKzlI3wMXnYBLt4W62Ty6MCx38rgzTxPsiGLIH17WyrvLd
         OQ0/2b4wHF5nuAoS7+cJyzR3yy7r5Obfcahurzw+ykhZBjKAHNHVX2iqND7TNHUN/uZy
         ynAA==
X-Gm-Message-State: AGi0PuY35G8iOt3jQplF/oOlBGvGCPBtbVehAI2abw1/1TucznxoHt+D
        yNeKQt9ETZIwEgEZ9IcpA+3fIZAeiMRlC+5MfnI=
X-Google-Smtp-Source: APiQypK8CelIKlG8WGkSg9wDsshxnRW9s7TBg+Pmy9wtl3BctesOgPVGqiV912kKL0NWCXULiA4yy8kOE5DKMqeSIhA=
X-Received: by 2002:a02:9988:: with SMTP id a8mr3254752jal.3.1586284767120;
 Tue, 07 Apr 2020 11:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585751281.git.leonard.crestez@nxp.com> <c167baa48d6830cf32b9ac51968eeadd684ebf2d.1585751281.git.leonard.crestez@nxp.com>
 <CAHCN7xKpwex8MQbTFAYKjGPQbQ1uOe7EywASmcakg8F_2w-iuA@mail.gmail.com> <VI1PR04MB69417FFDFF452FC46889B686EEC30@VI1PR04MB6941.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB69417FFDFF452FC46889B686EEC30@VI1PR04MB6941.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 7 Apr 2020 13:39:09 -0500
Message-ID: <CAHCN7xJSpTCJM5gAP=BuUdKXE3+ig0skoTLnsgqTs1LGcTmD1w@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] arm64: dts: imx8m: Add NOC nodes
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 7, 2020 at 4:10 AM Leonard Crestez <leonard.crestez@nxp.com> wr=
ote:
>
> On 2020-04-04 4:25 PM, Adam Ford wrote:
> > On Wed, Apr 1, 2020 at 9:35 AM Leonard Crestez <leonard.crestez@nxp.com=
> wrote:
> >>
> >> Add nodes for the main interconnect of the imx8m series chips.
> >>
> >> These nodes are bound to by devfreq and interconnect drivers.
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >> ---
> >>   arch/arm64/boot/dts/freescale/imx8mm.dtsi | 24 +++++++++++++++++++++=
++
> >>   arch/arm64/boot/dts/freescale/imx8mn.dtsi | 24 +++++++++++++++++++++=
++
> >>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 +++++++++++++++++++++=
++
> >>   3 files changed, 72 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/bo=
ot/dts/freescale/imx8mm.dtsi
> >> index 175c28ae10cf..41047b6709b6 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> >> @@ -6,10 +6,11 @@
> >>   #include <dt-bindings/clock/imx8mm-clock.h>
> >>   #include <dt-bindings/gpio/gpio.h>
> >>   #include <dt-bindings/input/input.h>
> >>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>   #include <dt-bindings/thermal/thermal.h>
> >> +#include <dt-bindings/interconnect/imx8mm.h>
> >>
> >>   #include "imx8mm-pinfunc.h"
> >>
> >>   / {
> >>          interrupt-parent =3D <&gic>;
> >> @@ -860,10 +861,33 @@
> >>                                  status =3D "disabled";
> >>                          };
> >>
> >>                  };
> >>
> >> +               noc: interconnect@32700000 {
> >> +                       compatible =3D "fsl,imx8mm-noc", "fsl,imx8m-no=
c";
> >> +                       reg =3D <0x32700000 0x100000>;
> >> +                       clocks =3D <&clk IMX8MM_CLK_NOC>;
> >> +                       fsl,ddrc =3D <&ddrc>;
> >> +                       #interconnect-cells =3D <1>;
> >> +                       operating-points-v2 =3D <&noc_opp_table>;
> >> +
> >> +                       noc_opp_table: opp-table {
> >> +                               compatible =3D "operating-points-v2";
> >> +
> >> +                               opp-150M {
> >> +                                       opp-hz =3D /bits/ 64 <15000000=
0>;
> >> +                               };
> >> +                               opp-375M {
> >> +                                       opp-hz =3D /bits/ 64 <37500000=
0>;
> >> +                               };
> >> +                               opp-750M {
> >> +                                       opp-hz =3D /bits/ 64 <75000000=
0>;
> >
> > Out of curiosity, the 8M Mini runs up to 750M, and  the 8M Nano and
> > 8MQ run up to 800.  The 8MQ had a patch to increase the assigned clock
> > speed for the NOC to 800MHz
> >
> > See: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git=
%2Fpatch%2Farch%2Farm64%2Fboot%2Fdts%2Ffreescale%3Fid%3D912b9dacf3f0ffad55e=
1a1b3c5af0e433ebdb5dd&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C32c3=
655718e4459028e008d7d89baa31%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6=
37216035403876452&amp;sdata=3Dz%2B5afsPGbCk4HkRp4nR6QepOrm70Fi5B5dohyvaquxo=
%3D&amp;reserved=3D0)
> >
> > The 8M Mini and 8M Nano appear to be setting the default speed to 0.
>
> I'm not sure what you mean about this, the noc clock is required for
> mostly everything.

As an example, the i.MX8MM looks like this:

assigned-clocks =3D <&clk IMX8MM_CLK_NOC>,
                              <&clk IMX8MM_CLK_AUDIO_AHB>,
                              <&clk IMX8MM_CLK_IPG_AUDIO_ROOT>,
                              <&clk IMX8MM_SYS_PLL3>,
                              <&clk IMX8MM_VIDEO_PLL1>,
                              <&clk IMX8MM_AUDIO_PLL1>,
                              <&clk IMX8MM_AUDIO_PLL2>;
assigned-clock-parents =3D <&clk IMX8MM_SYS_PLL3_OUT>,
                                         <&clk IMX8MM_SYS_PLL1_800M>;
assigned-clock-rates =3D <0>,
                                    <400000000>,
                                    <400000000>,
                                    <750000000>,
                                    <594000000>,
                                    <393216000>,
                                    <361267200>;

If I am reading this correctly, it appears to me that IMX8MM_CLK_NOC
is set to 0.

The i.MX8MN is similar, but the patch above shows IMX8MQ_CLK_NOC used
to be 0, but was updated for better performance.

>
> > Should the 8M Mini or 8M Nano do something similar to what the 8MQ
> > did, or does this series negate the need for such a patch?
>
> Instead of doing assigned-clocks noc frequency needs to be tweaked by
> adjusting OPPs in this list. The devfreq device for noc will overwrite
> other frequencies set for the noc.

My question was whether or not we should consider a patch to made the
default assigned-clock-rate for IMX8MM_CLK_NOC to be 750000000.  Based
on your response, it sounds like the answer might be that it's not
necessary.

thanks

adam
>
> --
> Regards,
> Leonard
