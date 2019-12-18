Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB84124E16
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 17:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLRQnM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 11:43:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35249 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfLRQnM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 11:43:12 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so2668000iol.2;
        Wed, 18 Dec 2019 08:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IOyVwrmaEwwM5WAlAYfaci9lrn0wT5jQ4QrM8/YtKaU=;
        b=bwf02nR+A9NSy+e1SfYm+xuwG6kMjMnyGBYXuf1R+EUJyFZhfvwR9A/KA2f6gUWSee
         eWhUdbmIw8VUO9pMfZs/jSqO8lsuYZQkb7fNZuUJ7X2nXGMEFJ/xoZM06AFoSDmZMZ/a
         l15UIse4XfYbUkuASsnRs56RRI3BtjNdkszjZQT1ZpKg/fxq5US1GvtYaeRQtbW76p8I
         Ggk3tylfxdkU8V77QlxCDxX+jy7QukyJ0rV2QAWv25fBxfl/6zGsrwCzR38T1sbliLr0
         //Y2QvqL009Hwz3ufH4CksNgiUpk7lUBcQp31Vu/7kNCccXAjLS2Du+ReaeAef+09tRb
         Wg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IOyVwrmaEwwM5WAlAYfaci9lrn0wT5jQ4QrM8/YtKaU=;
        b=UvuZ8x8sKppDg7rEhvZGvDXytoDk2E0DhP2Ht6+BvYCdd0jWvlvZztuLIKKF/ZMLub
         TTnfKYfzf7aYzacIMWRuHfkS3UiUg+1f7YjnfIdO8bCfPwSWFV9Ol7l/+wbChZf4Izuv
         kh6uJkZ/IgLhHrg1LAAdEJZX46J9ZUZqRC8Bbzd/HxzZ3quOiHB49FgwXi9eA6x0N2CV
         QVYPM49H1wT4Nda3tRBctf56H9su454kF61TT3KOw+ZzaefJxXvd5mu/llmYlOpSCeIv
         09/5PoKEZdGdm4/XznFDiORCrF3fqM93S12CZbS3kttv8DMYCmNrK+RfenojjTMe4H4J
         L6mw==
X-Gm-Message-State: APjAAAUVSWE7DuOAFa5akn8O8BZLTwyWnMcEbKxzNPDJ2hLYX0NuYbVq
        qX9yeH7mCviY3sLgCMh8ixZzQqmn4NqvnnTL59c=
X-Google-Smtp-Source: APXvYqyEmFhVFyiB1+P9msk5Bt3WIDE5rv7yI/fQAraMgD2uQ0T2i8x0fTzU1ktQjq/OKHYy4j9cwkX5ps7mSvnZEsQ=
X-Received: by 2002:a02:a38a:: with SMTP id y10mr3150468jak.55.1576687390752;
 Wed, 18 Dec 2019 08:43:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574458460.git.leonard.crestez@nxp.com> <CAHCN7xKNwit8ueUO0OkebfYh=4hsL7_+DRWEbn2dEt0H322W4w@mail.gmail.com>
 <VI1PR04MB70231CA0E3C4574211518359EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xJNy0z2hvWbM3UhLni5ruS+sCLeBH8BKiYexe3Sp=6Q0w@mail.gmail.com>
 <VI1PR04MB70235951BC137515BDD2FDC7EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xKHJAb8k1A+WC3EUOmgLTx-Kbjw_5EsmwyhDkkOKCsmGQ@mail.gmail.com> <VI1PR04MB702379645745FB697033FE6BEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB702379645745FB697033FE6BEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 18 Dec 2019 10:42:59 -0600
Message-ID: <CAHCN7xLOgh+E5Gw+2v4RUuZANHa+CkW=ACHL5NALMcSRfRY8eQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] PM / devfreq: Add dynamic scaling for imx8m ddr controller
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Jacky Bai <ping.bai@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        Alexandre Bailon <abailon@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 18, 2019 at 10:22 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> On 18.12.2019 17:37, Adam Ford wrote:
> > On Wed, Dec 18, 2019 at 9:16 AM Leonard Crestez <leonard.crestez@nxp.co=
m> wrote:
> >>
> >> On 18.12.2019 17:05, Adam Ford wrote:
> >>> On Wed, Dec 18, 2019 at 8:44 AM Leonard Crestez <leonard.crestez@nxp.=
com> wrote:
> >>>>
> >>>> On 18.12.2019 15:35, Adam Ford wrote:
> >>>>> On Fri, Nov 22, 2019 at 3:45 PM Leonard Crestez <leonard.crestez@nx=
p.com> wrote:
> >>>>>>
> >>>>>> This adds support for dynamic scaling of the DDR Controller (ddrc)
> >>>>>> present on i.MX8M series chips. Actual frequency switching is
> >>>>>> implemented inside TF-A, this driver wraps the SMC calls and
> >>>>>> synchronizes the clk tree.
> >>>>>>
> >>>>>> DRAM frequency switching requires clock manipulation but during th=
is operation
> >>>>>> DRAM itself is briefly inaccessible so this operation is performed=
 a SMC call
> >>>>>> to by TF-A which runs from a SRAM area. Upon returning to linux th=
e clock tree
> >>>>>> is updated to correspond to hardware configuration.
> >>>>>>
> >>>>>> This is handled via CLK_GET_RATE_NO_CACHE for dividers but muxes a=
re handled
> >>>>>> manually: the driver will prepare/enable the new parents ahead of =
switching (so
> >>>>>> that the expected roots are enabled) and afterwards it will call c=
lk_set_parent
> >>>>>> to ensure the parents in clock framework are up-to-date.
> >>>>>>
> >>>>>> This series is useful standalone and roughly similar to devfreq dr=
ivers for
> >>>>>> tegra and rockchip.
> >>>>>>
> >>>>>> Running at lower dram rates saves power but can affect the functio=
nality of
> >>>>>> other blocks in the chip (display, vpu etc). Support for in-kernel=
 constraints
> >>>>>> will some separately.
> >>>>>>
> >>>>>> This series has no dependencies outside linux-next. The driver dep=
ends
> >>>>>> on features from the NXP branch of TF-A and will cleanly fail to p=
robe
> >>>>>> on mainline. There are also plans to upstream dram dvfs in TF-A.
> >>>>>>
> >>>>>> Leonard Crestez (5):
> >>>>>>      clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks
> >>>>>>      clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCA=
CHE
> >>>>>>      dt-bindings: memory: Add bindings for imx8m ddr controller
> >>>>>>      PM / devfreq: Add dynamic scaling for imx8m ddr controller
> >>>>>>      arm64: dts: imx8m: Add ddr controller nodes
> >>>>>>
> >>>>>>     .../memory-controllers/fsl/imx8m-ddrc.yaml    |  72 +++
> >>>>>>     arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +
> >>>>>>     arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +
> >>>>>>     .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +
> >>>>>>     arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  10 +
> >>>>>>     arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +
> >>>>>>     arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  10 +
> >>>>>>     drivers/clk/imx/clk-imx8mm.c                  |  11 +-
> >>>>>>     drivers/clk/imx/clk-imx8mn.c                  |  12 +-
> >>>>>>     drivers/clk/imx/clk-imx8mq.c                  |  12 +-
> >>>>>>     drivers/clk/imx/clk-pll14xx.c                 |   7 +
> >>>>>>     drivers/clk/imx/clk.h                         |   1 +
> >>>>>>     drivers/devfreq/Kconfig                       |   9 +
> >>>>>
> >>>>> Since there is a Kconfig change, should there me a defconfig change=
?
> >>>>
> >>>> Yes, you need to enable CONFIG_ARM_IMX8M_DDRC_DEVFREQ in order to te=
st
> >>>> this. Enabling as "m" should work.
> >>>
> >>> I enabled it as 'm' but I was more curious to know if we should push
> >>> this upstream with the rest of the series.
> >>
> >> I skipped enabling because it's very experimental; maybe after imx
> >> interconnect is also enabled?
> >>
> >>>>>>     drivers/devfreq/Makefile                      |   1 +
> >>>>>>     drivers/devfreq/imx8m-ddrc.c                  | 465 ++++++++++=
++++++++
> >>>>>>     15 files changed, 670 insertions(+), 10 deletions(-)
> >>>>>>     create mode 100644 Documentation/devicetree/bindings/memory-co=
ntrollers/fsl/imx8m-ddrc.yaml
> >>>>>>     create mode 100644 drivers/devfreq/imx8m-ddrc.c
> >>>>>
> >>>>> I applied the whole series against 5.5-rc1 and I am trying to test =
it.
> >>>>> I know the 4.14 kernel NXP posted on Code Aurora is capable to
> >>>>> lowering the DDRC controller to 25MHz on the 8MM when the video is
> >>>>> off.  Since there is no video support yet for the 8MM, I was expect=
ing
> >>>>> to see the DDRC clock to be at or around 25MHz.
> >>>>>
> >>>>> Using debug FS, I can see the dram core clock is still running at
> >>>>> 750MHz, and measuring power, it shows something consistent with wha=
t I
> >>>>> see on the Code Aurora kernel with video turned on and the clock at
> >>>>> 750MHz.
> >>>>>
> >>>>> Is there some way to get the dram_core_clk to drop to 25MHz to see
> >>>>> some power reduction?  The same commands used in the Yocto build do=
n't
> >>>>> apply here since we don't have video.
> >>>>
> >>>> Current upstream driver just keeps current frequency by default. Try=
 the
> >>>> following:
> >>>>
> >>>> cd /sys/class/devfreq/devices/devfreq0
> >>>
> >>> can't cd to /sys/class/devfreq/devices/devfreq0: No such file or dire=
ctory
> >>>
> >>> I did some checking and I found:
> >>>       imx8m-ddrc-devfreq 3d400000.memory-controller: failed to init
> >>> firmware freq info: -19
> >>>
> >>> Was there some prerequisite patches I needed to apply before your ser=
ies?
> >>
> >> You need a recent version of TF-A from nxp ( upstream). Try this:
> >>
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fso=
urce.codeaurora.org%2Fexternal%2Fimx%2Fimx-atf%2Flog%2F%3Fh%3Dimx_4.19.35_1=
.1.0&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7Cc07fadd829994fe6293c0=
8d783d02fa9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637122802480130351=
&amp;sdata=3DdVovGr1ttwrnSz39MPNNVg%2FB8HV5AjrHXGbksO3XvVo%3D&amp;reserved=
=3D0
> >>
> >> Or this:
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
thub.com%2Fcdleonard%2Farm-trusted-firmware%2Fcommits%2Fimx_2.0.y_busfreq&a=
mp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7Cc07fadd829994fe6293c08d783d=
02fa9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637122802480140347&amp;s=
data=3DQ9KPq60FOxJ7GflwupNaXvbqHIR40Ej5GxeY%2BhHI658%3D&amp;reserved=3D0
> >>
> >> Support on upstream ATF is not yet available
> >
> > I cloned your github branch and built it per the instructions in the
> > u-boot readme file.
> > did a make clean on u-boot, copied the bl31.bin to u-boot and rebuild
> > per U-Boot's instructions.
> >
> > U-Boot booted and Linux booted, but I still get:
> >
> >     imx8m-ddrc-devfreq 3d400000.memory-controller: failed to init
> > firmware freq info: -19
>
> Which version of u-boot is that, upstream? I'm subscribed to uboot
> mailing list and I see that imx8m support has its own separate issues
> but my familiarity is limited :(

U-Boot 2020.01-rc4-00244-gf39abbbc53-dirty (Dec 18 2019 - 09:27:40 -0600)

>
> I've only ever tested with NXP uboot and the NXP version of mkimage:
>
> https://source.codeaurora.org/external/imx/uboot-imx/log/?h=3Dimx_v2019.0=
4_4.19.35_1.1.0
> https://source.codeaurora.org/external/imx/imx-mkimage/

I will try your versions and see what happens.

> My bootloader prints the following BuildInfo:
>    - ATF 70fa7bc
>
>    - U-Boot 2019.04-00019-g4d377539a119
>

Thanks for your help.

adam
> --
> Regards,
> Leonard
