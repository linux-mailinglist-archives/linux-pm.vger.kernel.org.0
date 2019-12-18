Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3D124BD5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfLRPh1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 10:37:27 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36321 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfLRPh0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 10:37:26 -0500
Received: by mail-il1-f195.google.com with SMTP id b15so2051381iln.3;
        Wed, 18 Dec 2019 07:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/0Cx566venUU7dDXePf4MglaNmiGe8WWE6mIv6eA2E=;
        b=vYKP2MAYqg+oajDl0uayzHdWlss0ZrDkraWsIP54vlUDqpcUxX6oBKbS5uBuhD6cus
         DoZjwv8EEMKbpVXxUAzYbZyiw+gK1PcYkjrW9OvHduUGwi5Zjh+sDg9qbGIR6WIPeVm5
         Y51iZWoIQxtjTnldJtdLeZ6IzfRNP+GqzE3TedmVY3O3e/wFp9py5HRCQEG8iIG4aWCe
         8Yr5bYix+ZYp2H9nVWywx9u0c6KRlCSUBokXBOuf2qzK1MRdCiZTe43hkmp9h9x3ItVm
         wsNk/wn7AZidxIoICZ5ToBq+u/Y6DghM2CYxKA5aHTXLHf+Cuxxm7E5ZTvG/Uz3kN1PH
         tgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/0Cx566venUU7dDXePf4MglaNmiGe8WWE6mIv6eA2E=;
        b=g6CbM0mJAQkXgOj5Z0DdgIJUvjzA6EIfubbcPqxiQW+zpWGCerAZXKapBzn3Qpxp4s
         zXOo4f+iWtSriwN2TXKnsO1XUONFeaBAeZ88kF++wjtV1T102Dyl0v+ShIBCC6YMdH/i
         lHrCjQVrtZ2mAl5GEarpL1xOGCGoc2uU5U1pDui1HslBXglPPPw4ba3xoBfdISJSf20O
         b3u2cgYGSHC2EGJZRbWW74w3weyKs2md5SyjEpoD3EQneQ9es9px/P/b37Q5+XZ9EoXA
         7RXJDGL/ZE57ExC+wR2KlK0KqkccYlmsZpLbHXzfBHmz4xVTGn3o79ROtjqYkKmNw6fB
         a27Q==
X-Gm-Message-State: APjAAAXgFONSI186EUW5YiId/krJ1nUf6ESt1dQ03y/Xqmc9KQZKcecH
        zUL/sKcDXsnLvJ2IGV6oII0ImPWHQsEAKVzr8qQ=
X-Google-Smtp-Source: APXvYqzZwSwTUOlYM6TsQQNm3QDAI/MmJsqk//isBpzlQCB5QCN/YvtmUYVY/LMiY4AbBPfcqD05jwXVAxK7n1Qryjg=
X-Received: by 2002:a92:dc91:: with SMTP id c17mr2593518iln.78.1576683445143;
 Wed, 18 Dec 2019 07:37:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574458460.git.leonard.crestez@nxp.com> <CAHCN7xKNwit8ueUO0OkebfYh=4hsL7_+DRWEbn2dEt0H322W4w@mail.gmail.com>
 <VI1PR04MB70231CA0E3C4574211518359EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xJNy0z2hvWbM3UhLni5ruS+sCLeBH8BKiYexe3Sp=6Q0w@mail.gmail.com> <VI1PR04MB70235951BC137515BDD2FDC7EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70235951BC137515BDD2FDC7EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 18 Dec 2019 09:37:14 -0600
Message-ID: <CAHCN7xKHJAb8k1A+WC3EUOmgLTx-Kbjw_5EsmwyhDkkOKCsmGQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] PM / devfreq: Add dynamic scaling for imx8m ddr controller
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Jacky Bai <ping.bai@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 18, 2019 at 9:16 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 18.12.2019 17:05, Adam Ford wrote:
> > On Wed, Dec 18, 2019 at 8:44 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >>
> >> On 18.12.2019 15:35, Adam Ford wrote:
> >>> On Fri, Nov 22, 2019 at 3:45 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >>>>
> >>>> This adds support for dynamic scaling of the DDR Controller (ddrc)
> >>>> present on i.MX8M series chips. Actual frequency switching is
> >>>> implemented inside TF-A, this driver wraps the SMC calls and
> >>>> synchronizes the clk tree.
> >>>>
> >>>> DRAM frequency switching requires clock manipulation but during this operation
> >>>> DRAM itself is briefly inaccessible so this operation is performed a SMC call
> >>>> to by TF-A which runs from a SRAM area. Upon returning to linux the clock tree
> >>>> is updated to correspond to hardware configuration.
> >>>>
> >>>> This is handled via CLK_GET_RATE_NO_CACHE for dividers but muxes are handled
> >>>> manually: the driver will prepare/enable the new parents ahead of switching (so
> >>>> that the expected roots are enabled) and afterwards it will call clk_set_parent
> >>>> to ensure the parents in clock framework are up-to-date.
> >>>>
> >>>> This series is useful standalone and roughly similar to devfreq drivers for
> >>>> tegra and rockchip.
> >>>>
> >>>> Running at lower dram rates saves power but can affect the functionality of
> >>>> other blocks in the chip (display, vpu etc). Support for in-kernel constraints
> >>>> will some separately.
> >>>>
> >>>> This series has no dependencies outside linux-next. The driver depends
> >>>> on features from the NXP branch of TF-A and will cleanly fail to probe
> >>>> on mainline. There are also plans to upstream dram dvfs in TF-A.
> >>>>
> >>>> Leonard Crestez (5):
> >>>>     clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks
> >>>>     clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACHE
> >>>>     dt-bindings: memory: Add bindings for imx8m ddr controller
> >>>>     PM / devfreq: Add dynamic scaling for imx8m ddr controller
> >>>>     arm64: dts: imx8m: Add ddr controller nodes
> >>>>
> >>>>    .../memory-controllers/fsl/imx8m-ddrc.yaml    |  72 +++
> >>>>    arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +
> >>>>    arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +
> >>>>    .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +
> >>>>    arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  10 +
> >>>>    arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +
> >>>>    arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  10 +
> >>>>    drivers/clk/imx/clk-imx8mm.c                  |  11 +-
> >>>>    drivers/clk/imx/clk-imx8mn.c                  |  12 +-
> >>>>    drivers/clk/imx/clk-imx8mq.c                  |  12 +-
> >>>>    drivers/clk/imx/clk-pll14xx.c                 |   7 +
> >>>>    drivers/clk/imx/clk.h                         |   1 +
> >>>>    drivers/devfreq/Kconfig                       |   9 +
> >>>
> >>> Since there is a Kconfig change, should there me a defconfig change?
> >>
> >> Yes, you need to enable CONFIG_ARM_IMX8M_DDRC_DEVFREQ in order to test
> >> this. Enabling as "m" should work.
> >
> > I enabled it as 'm' but I was more curious to know if we should push
> > this upstream with the rest of the series.
>
> I skipped enabling because it's very experimental; maybe after imx
> interconnect is also enabled?
>
> >>>>    drivers/devfreq/Makefile                      |   1 +
> >>>>    drivers/devfreq/imx8m-ddrc.c                  | 465 ++++++++++++++++++
> >>>>    15 files changed, 670 insertions(+), 10 deletions(-)
> >>>>    create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
> >>>>    create mode 100644 drivers/devfreq/imx8m-ddrc.c
> >>>
> >>> I applied the whole series against 5.5-rc1 and I am trying to test it.
> >>> I know the 4.14 kernel NXP posted on Code Aurora is capable to
> >>> lowering the DDRC controller to 25MHz on the 8MM when the video is
> >>> off.  Since there is no video support yet for the 8MM, I was expecting
> >>> to see the DDRC clock to be at or around 25MHz.
> >>>
> >>> Using debug FS, I can see the dram core clock is still running at
> >>> 750MHz, and measuring power, it shows something consistent with what I
> >>> see on the Code Aurora kernel with video turned on and the clock at
> >>> 750MHz.
> >>>
> >>> Is there some way to get the dram_core_clk to drop to 25MHz to see
> >>> some power reduction?  The same commands used in the Yocto build don't
> >>> apply here since we don't have video.
> >>
> >> Current upstream driver just keeps current frequency by default. Try the
> >> following:
> >>
> >> cd /sys/class/devfreq/devices/devfreq0
> >
> > can't cd to /sys/class/devfreq/devices/devfreq0: No such file or directory
> >
> > I did some checking and I found:
> >      imx8m-ddrc-devfreq 3d400000.memory-controller: failed to init
> > firmware freq info: -19
> >
> > Was there some prerequisite patches I needed to apply before your series?
>
> You need a recent version of TF-A from nxp ( upstream). Try this:
>
> https://source.codeaurora.org/external/imx/imx-atf/log/?h=imx_4.19.35_1.1.0
>
> Or this:
> https://github.com/cdleonard/arm-trusted-firmware/commits/imx_2.0.y_busfreq
>
> Support on upstream ATF is not yet available

I cloned your github branch and built it per the instructions in the
u-boot readme file.
did a make clean on u-boot, copied the bl31.bin to u-boot and rebuild
per U-Boot's instructions.

U-Boot booted and Linux booted, but I still get:

   imx8m-ddrc-devfreq 3d400000.memory-controller: failed to init
firmware freq info: -19

I am still learning the imx8mm platform, so please forgive my ignorance.

adam
>
> --
> Regards,
> Leonard
