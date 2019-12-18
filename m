Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC26124ED0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLRRHH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 12:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbfLRRHH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 12:07:07 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133D424685;
        Wed, 18 Dec 2019 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688823;
        bh=MzHE6ufhhPkKhgLUUVDED2/ALVNXq0b79zlJSu4P+FY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xq0SsJI8bACPGxZXwnpkGKCWehh6Y0nqDCxugxyubZdAGLh7o4uJN82BGDzZ7/9P8
         IE9lRxBB+8TsfPcCkMsyvQsDbaWLs7r9gt6k5ZEPRNzcMztUyAzuvEGHe2XvaIVUoX
         DHDekuzFstlz7glyxGOT0BVkGkgpk6yfghslXh8A=
Received: by mail-lj1-f176.google.com with SMTP id u17so2972602lja.4;
        Wed, 18 Dec 2019 09:07:02 -0800 (PST)
X-Gm-Message-State: APjAAAX2VVP5bFMfHc8AqfHNK6Q91k73IaFTA8Gr1qbuV5wC88PpVf/x
        dXNGvdTiUodq7diEWwfk3byN1nCIUc6TjhUCqOU=
X-Google-Smtp-Source: APXvYqzJhmoDoMQLQ2+3FWc+IaDWTox5GeEEhmtDKr/J0cz6bFDB7PmdQciMN6D9OtoGzLdd/uMfIdI7BG9+8qRWAF8=
X-Received: by 2002:a2e:9b05:: with SMTP id u5mr2597911lji.59.1576688820891;
 Wed, 18 Dec 2019 09:07:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573761527.git.leonard.crestez@nxp.com> <CGME20191114201049epcas5p4a24607634af7b31e6a2dbdb4166dd862@epcas5p4.samsung.com>
 <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
 <8734a934-79e2-7445-c3e5-a0bb59afd4a8@samsung.com> <047990a5-263d-d447-7f0a-77a99e4b1f63@samsung.com>
 <25e3177f-e2b9-6be4-cfb8-24f87ccba45b@samsung.com> <VI1PR04MB702396D09FCED6CBA49B6AE7EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <698357b4-32e7-7f4b-3e67-59f5890f574a@samsung.com> <VI1PR04MB7023F0CCD7FAF5EEA74C7873EE500@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <f4267efa-1345-4fab-e6a7-73fca674dd72@samsung.com> <VI1PR04MB7023AE8CE3E05FE3E70D1FEEEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAGTfZH1QGe7ahQQnhR8b=NM+dpsWednPokKPTr3oq11660mm2Q@mail.gmail.com>
In-Reply-To: <CAGTfZH1QGe7ahQQnhR8b=NM+dpsWednPokKPTr3oq11660mm2Q@mail.gmail.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Thu, 19 Dec 2019 02:06:24 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3Yqb-8R81H7=KzPp6WDB4F+P_oUq1CvcULiD+VEGh96w@mail.gmail.com>
Message-ID: <CAGTfZH3Yqb-8R81H7=KzPp6WDB4F+P_oUq1CvcULiD+VEGh96w@mail.gmail.com>
Subject: Re: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling driver
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=EB=85=84 12=EC=9B=94 18=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 7:46, =
Chanwoo Choi <chanwoo@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi,
>
> 2019=EB=85=84 12=EC=9B=94 18=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 7:11=
, Leonard Crestez <leonard.crestez@nxp.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> >
> > On 18.12.2019 05:08, Chanwoo Choi wrote:
> > > On 12/18/19 6:05 AM, Leonard Crestez wrote:
> > >> On 17.12.2019 02:35, Chanwoo Choi wrote:
> > >>> On 12/16/19 11:57 PM, Leonard Crestez wrote:
> > >>>> On 16.12.2019 03:00, Chanwoo Choi wrote:
> > >>>>> Hi,
> > >>>>>
> > >>>>> Also, I think that 'devfreq' word is not proper for device driver=
 name.
> > >>>>> imx-bus.c or imx-noc.c or others to inform the role of this drive=
r of developer.
> > >>>>
> > >>>> I'll rename to "imx-bus". Calling it "imx-noc" is not appropriate
> > >>>> because I also want to use it for PL301 NICs.
> > >>>
> > >>> OK.
> > >>>
> > >>>>
> > >>>>> And, I have a question.
> > >>>>> This driver adds the devfreq device with either passive governor
> > >>>>> or userspace governor.
> > >>>>>
> > >>>>> As I understood, the devfreq device with passive governor
> > >>>>> will be operated with imx8m-ddrc.c driver.
> > >>>>> But, when is operating with userspace governor?
> > >>>>
> > >>>> There are multiple scalable buses inside the SOC, for example ther=
e's a
> > >>>> NIC for display controllers and one for (pci+usb). They can use
> > >>>> userspace governor for explicit frequency control.
> > >>>>
> > >>>>> I think that you better to add the explanation to description
> > >>>>> for two scenarios how to operate with interconnect provider
> > >>>>> on either passive governor or userspace governor usage case.
> > >>>>
> > >>>> I'll elaborate the example in bindings.
> > >>>
> > >>> OK.
> > >>>
> > >>>>
> > >>>>> On 12/13/19 10:51 AM, Chanwoo Choi wrote:
> > >>>>>> On 12/13/19 10:30 AM, Chanwoo Choi wrote:
> > >>>>>>> Hi,
> > >>>>>>>
> > >>>>>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:
> > >>>>>>>> Add initial support for dynamic frequency switching on pieces =
of the imx
> > >>>>>>>> interconnect fabric.
> > >>>>>>>>
> > >>>>>>>> All this driver does is set a clk rate based on an opp table, =
it does
> > >>>>>>>> not map register areas.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > >>>>>>>> ---
> > >>>>>>>>     drivers/devfreq/Kconfig       |   9 ++
> > >>>>>>>>     drivers/devfreq/Makefile      |   1 +
> > >>>>>>>>     drivers/devfreq/imx-devfreq.c | 150 ++++++++++++++++++++++=
++++++++++++
> > >>>>>>>>     3 files changed, 160 insertions(+)
> > >>>>>>>>     create mode 100644 drivers/devfreq/imx-devfreq.c
> > >>>>>>>>
> > >>>>>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > >>>>>>>> index 923a6132e741..fef5ce831e90 100644
> > >>>>>>>> --- a/drivers/devfreq/Kconfig
> > >>>>>>>> +++ b/drivers/devfreq/Kconfig
> > >>>>>>>> @@ -98,10 +98,19 @@ config ARM_IMX8M_DDRC_DEVFREQ
> > >>>>>>>>        select DEVFREQ_GOV_USERSPACE
> > >>>>>>>>        help
> > >>>>>>>>          This adds the DEVFREQ driver for the i.MX8M DDR Contr=
oller. It allows
> > >>>>>>>>          adjusting DRAM frequency.
> > >>>>>>>>
> > >>>>>>>> +config ARM_IMX_DEVFREQ
> > >>>>>>>> +      tristate "i.MX Generic DEVFREQ Driver"
> > >>>>>>>> +      depends on ARCH_MXC || COMPILE_TEST
> > >>>>>>>> +      select DEVFREQ_GOV_PASSIVE
> > >>>>>>>> +      select DEVFREQ_GOV_USERSPACE
> > >>>>>>>> +      help
> > >>>>>>>> +        This adds the generic DEVFREQ driver for i.MX interco=
nnects. It
> > >>>>>>>> +        allows adjusting NIC/NOC frequency.
> > >>>>>>>> +
> > >>>>>>>>     config ARM_TEGRA_DEVFREQ
> > >>>>>>>>        tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> > >>>>>>>>        depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
> > >>>>>>>>                ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
> > >>>>>>>>                ARCH_TEGRA_210_SOC || \
> > >>>>>>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefi=
le
> > >>>>>>>> index 3eb4d5e6635c..61d0edee16f7 100644
> > >>>>>>>> --- a/drivers/devfreq/Makefile
> > >>>>>>>> +++ b/drivers/devfreq/Makefile
> > >>>>>>>> @@ -8,10 +8,11 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)  +=3D go=
vernor_userspace.o
> > >>>>>>>>     obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)  +=3D governor_passive.o
> > >>>>>>>>
> > >>>>>>>>     # DEVFREQ Drivers
> > >>>>>>>>     obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)       +=3D exynos-bus=
.o
> > >>>>>>>>     obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)       +=3D imx8m-ddrc=
.o
> > >>>>>>>> +obj-$(CONFIG_ARM_IMX_DEVFREQ)         +=3D imx-devfreq.o
> > >>>>>>>>     obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)       +=3D rk3399_dmc=
.o
> > >>>>>>>>     obj-$(CONFIG_ARM_TEGRA_DEVFREQ)            +=3D tegra30-de=
vfreq.o
> > >>>>>>>>     obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)  +=3D tegra20-devfreq.o
> > >>>>>>>>
> > >>>>>>>>     # DEVFREQ Event Drivers
> > >>>>>>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/i=
mx-devfreq.c
> > >>>>>>>> new file mode 100644
> > >>>>>>>> index 000000000000..620b344e87aa
> > >>>>>>>> --- /dev/null
> > >>>>>>>> +++ b/drivers/devfreq/imx-devfreq.c
> > >>>>>>>> @@ -0,0 +1,150 @@
> > >>>>>>>> +// SPDX-License-Identifier: GPL-2.0
> > >>>>>>>> +/*
> > >>>>>>>> + * Copyright 2019 NXP
> > >>>>>>>> + */
> > >>>>>>>> +
> > >>>>>>>> +#include <linux/clk.h>
> > >>>>>>>> +#include <linux/devfreq.h>
> > >>>>>>>> +#include <linux/device.h>
> > >>>>>>>> +#include <linux/module.h>
> > >>>>>>>> +#include <linux/of_device.h>
> > >>>>>>>> +#include <linux/pm_opp.h>
> > >>>>>>>> +#include <linux/platform_device.h>
> > >>>>>>>> +#include <linux/slab.h>
> > >>>>>>>> +
> > >>>>>>>> +struct imx_devfreq {
> > >>>>>>>> +      struct devfreq_dev_profile profile;
> > >>>>>>>> +      struct devfreq *devfreq;
> > >>>>>>>> +      struct clk *clk;
> > >>>>>>>> +      struct devfreq_passive_data passive_data;
> > >>>>>>>> +};
> > >>>>>>>> +
> > >>>>>>>> +static int imx_devfreq_target(struct device *dev,
> > >>>>>>>> +                            unsigned long *freq, u32 flags)
> > >>>>>>>
> > >>>>>>> Don't use space for the indentation. Please use only tab.
> > >>>>
> > >>>> OK
> > >>
> > >> The spaces are required in order to align arguments to open paranthe=
sis.
> > >> Should I drop that?
> > >>
> > >> It seems that check_patch.pl and process/coding-style.rst doesn't ha=
ve a
> > >> strong opinion on this; my personal preference is for long argument
> > >> lists to just use double indentation.
> > >
> > > Generally, almost patches use the tab for the indentation.
> > > I don't use space for the indentation. If use the tab
> > > for the indentation, it is not harmful for the readability.
> > >
> > > If use the space for the pretty to make the alignment between paramet=
er,
> > > I think it it not good.
> >
> > OK, I'll just use two tabs. This also matches my personal preference.
> >
> > >>>>>>>> +{
> > >>>>>>>> +      struct imx_devfreq *priv =3D dev_get_drvdata(dev);
> > >>>>>>>> +      struct dev_pm_opp *new_opp;
> > >>>>>>>> +      unsigned long new_freq;
> > >>>>>>>> +      int ret;
> > >>>>>>>> +
> > >>>>>>>> +      new_opp =3D devfreq_recommended_opp(dev, freq, flags);
> > >>>>>>>> +      if (IS_ERR(new_opp)) {
> > >>>>>>>> +              ret =3D PTR_ERR(new_opp);
> > >>>>>>>> +              dev_err(dev, "failed to get recommended opp: %d=
\n", ret);
> > >>>>>>>> +              return ret;
> > >>>>>>>> +      }
> > >>>>>>>> +      new_freq =3D dev_pm_opp_get_freq(new_opp);
> > >>>>>>>> +      dev_pm_opp_put(new_opp);
> > >>>>>>>> +
> > >>>>>>>> +      return clk_set_rate(priv->clk, new_freq);
> > >>>>>>>> +}
> > >>>>>>>> +
> > >>>>>>>> +static int imx_devfreq_get_cur_freq(struct device *dev, unsig=
ned long *freq)
> > >>>>>>>> +{
> > >>>>>>>> +      struct imx_devfreq *priv =3D dev_get_drvdata(dev);
> > >>>>>>>> +
> > >>>>>>>> +      *freq =3D clk_get_rate(priv->clk);
> > >>>>>>>> +
> > >>>>>>>> +      return 0;
> > >>>>>>>> +}
> > >>>>>>>> +
> > >>>>>>>> +static int imx_devfreq_get_dev_status(struct device *dev,
> > >>>>>>>> +                                    struct devfreq_dev_status=
 *stat)
> > >>>>>>>
> > >>>>>>> ditto. Please use tab for the indentation.
> > >>>>>>>
> > >>>>>>>> +{
> > >>>>>>>> +      struct imx_devfreq *priv =3D dev_get_drvdata(dev);
> > >>>>>>>> +
> > >>>>>>>> +      stat->busy_time =3D 0;
> > >>>>>>>> +      stat->total_time =3D 0;
> > >>>>>>>> +      stat->current_frequency =3D clk_get_rate(priv->clk);
> > >>>>>>>> +
> > >>>>>>>> +      return 0;
> > >>>>>>>> +}
> > >>>>>>>> +
> > >>>>>>>> +static void imx_devfreq_exit(struct device *dev)
> > >>>>>>>> +{
> > >>>>>>>> +      dev_pm_opp_of_remove_table(dev);
> > >>>>>>>> +}
> > >>>>>>>> +
> > >>>>>>>> +static int imx_devfreq_probe(struct platform_device *pdev)
> > >>>>>>>> +{
> > >>>>>>>> +      struct device *dev =3D &pdev->dev;
> > >>>>>>>> +      struct imx_devfreq *priv;
> > >>>>>>>
> > >>>>>>> How about changing the variable name 'priv' to 'imx' or 'imx_da=
ta'?
> > >>>>>>> because it is not easy to catch the role of 'priv' from variabl=
e name.
> > >>>>
> > >>>> The name "priv" refers to private data of current device: it is sh=
ort
> > >>>> and not ambiguous in this context. I don't think that mentioning "=
imx"
> > >>>> adds any additional useful information.
> > >>>>
> > >>>> It doesn't seem like there's much of a convention for "local varia=
ble
> > >>>> containing private data", for example exynos-bus.c uses "struct
> > >>>> exynos_bus* bus" internally.
> > >>>
> > >>> OK. it is nitpick. Keep your style.
> > >>>
> > >>>>
> > >>>>>>>
> > >>>>>>>> +      const char *gov =3D DEVFREQ_GOV_USERSPACE;
> > >>>>>>>> +      void *govdata =3D NULL;
> > >>>>>>>
> > >>>>>>> How about changing the variable name 'govdata' to 'gov_data'?
> > >>>>>>> - govdata -> gov_data
> > >>>>
> > >>>> OK
> > >>>>
> > >>>>>>>> +      int ret;
> > >>>>>>>> +
> > >>>>>>>> +      priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > >>>>>>>> +      if (!priv)
> > >>>>>>>> +              return -ENOMEM;
> > >>>>>>>> +
> > >>>>>>>> +      priv->clk =3D devm_clk_get(dev, NULL);
> > >>>>>>>
> > >>>>>>> nitpick: because the clock-name is not mandatory.
> > >>>>>>> Don't need to specify the clock name to inform the role of cloc=
k
> > >>>>>>> of other developer/user?
> > >>>>>>>
> > >>>>>>> For example, "ddr", "bus" and so on.
> > >>>>
> > >>>> I'll call this bus, but I'm not sure it's useful when a single clo=
ck is
> > >>>> involved.
> > >>>>
> > >>>>>> And, this driver doesn't include the 'clk_prepare_enable'.
> > >>>>>> how to enable the clock?
> > >>>>
> > >>>> Clocks are either always on or perhaps controlled by some other
> > >>>> peripheral. This driver only provides scaling.
> > >>>
> > >>> It is not proper use-case of clock. If device driver
> > >>> want to control the clock, it have to be enabled on device driver.
> > >>
> > >>> Even it clock is always, the user don't know the state of clock.
> > >>> Also, user can't know what kind of device driver control the clock.
> > >>>
> > >>> It have to be controlled on this device driver
> > >>> before changing the clock frequency.
> > >>
> > >>   From clock framework perspective prepare/enable and rate bits can =
be
> > >> controlled separately.
> > >>
> > >> Many peripherals are grouped with their own bus (for example a PL301
> > >> NIC) which is normally off and only gets enabled when explicitly
> > >> requested by drivers. If this devfreq driver always enabled bus cloc=
ks
> > >> then it would waste power for no reason.
> > >
> > > You can save the power with following sequence.
> > > You are keeping the following sequence without any problem.
> > >       clk_prepare_enable()
> > >       clk_set_rate()
> > >       clk_disable_unprepare()
> > >
> > > clk API support the reference count for the clock user.
> > > It doesn't affect the any behavior of other device sharing the bus cl=
ock
> > > and waste any power-consumption because it will always restore
> > > the reference count after changing the clock rate.
> >
> > But this doesn't serve any purpose?

Again thinking, it show the at least sequence to control the clock.
To do this sequence, it doesn't affect the behavior of any device driver
which share the clock. And it show the clock is well-controlled by
this device driver.

> >
> > In some cases (depending on clock flags like CLK_SET_RATE_GATE or
> > CLK_SET_RATE_UNGATE flags) the clk_set_rate function can require than
> > clocks are either on or off and otherwise return an error.
> >
> > For imx bus clocks there is no such requirement.

Usually, the clock is enabled before using it. It doesn't depend on
the any arch or SoC.
CCF define the this rule for the clock control.

>
> If you guarantee that it is not required on all board related to imx,
> please add this comment when calling clk_set_rate().
> Because the user who don't know the history and character,
> don't understand why don't enable or disable for clock.
>
> I'll agree if you add the comment why don't need to
> enable/disable control on this driver.
>
>
> >
> > >> For example a display controller will first enable clocks to allow
> > >> access to device registers, then configure a resolution and make a
> > >> bandwith request which gets translated a min_freq request. Then when=
 the
> > >> display is blanked the entire display bus should be powered off, eve=
n if
> > >> this makes control registers inaccessible.
> > >>
> > >> This series only enables scaling for the main NOC which can't be tur=
ned
> > >> off anyway.
> > >>
> > >>>>>>>> +      if (IS_ERR(priv->clk)) {
> > >>>>>>>> +              ret =3D PTR_ERR(priv->clk);
> > >>>>>>>> +              dev_err(dev, "failed to fetch clk: %d\n", ret);
> > >>>>>>>> +              return ret;
> > >>>>>>>> +      }
> > >>>>>>>> +      platform_set_drvdata(pdev, priv);
> > >>>>>>>> +
> > >>>>>>>> +      ret =3D dev_pm_opp_of_add_table(dev);
> > >>>>>>>> +      if (ret < 0) {
> > >>>>>>>> +              dev_err(dev, "failed to get OPP table\n");
> > >>>>>>>> +              return ret;
> > >>>>>>>> +      }
> > >>>>>>>> +
> > >>>>>>>> +      priv->profile.polling_ms =3D 1000;
> > >>>>>>>> +      priv->profile.target =3D imx_devfreq_target;
> > >>>>>>>> +      priv->profile.get_dev_status =3D imx_devfreq_get_dev_st=
atus;
> > >>>>>>>> +      priv->profile.exit =3D imx_devfreq_exit;
> > >>>>>>>> +      priv->profile.get_cur_freq =3D imx_devfreq_get_cur_freq=
;
> > >>>>>>>> +      priv->profile.initial_freq =3D clk_get_rate(priv->clk);
> > >>>>>>>> +
> > >>>>>>>> +      /* Handle passive devfreq parent link */
> > >>>>>>>> +      priv->passive_data.parent =3D devfreq_get_devfreq_by_ph=
andle(dev, 0);
> > >>>>>>>> +      if (!IS_ERR(priv->passive_data.parent)) {
> > >>>>>>>> +              dev_info(dev, "setup passive link to %s\n",
> > >>>>>>>> +                       dev_name(priv->passive_data.parent->de=
v.parent));
> > >>>>>>>> +              gov =3D DEVFREQ_GOV_PASSIVE;
> > >>>>>>>> +              govdata =3D &priv->passive_data;
> > >>>>>>>> +      } else if (priv->passive_data.parent !=3D ERR_PTR(-ENOD=
EV)) {
> > >>>>>>>> +              // -ENODEV means no parent: not an error.
> > >>>>>>>> +              ret =3D PTR_ERR(priv->passive_data.parent);
> > >>>>>>>> +              if (ret !=3D -EPROBE_DEFER)
> > >>>>>>>> +                      dev_warn(dev, "failed to get initialize=
 passive parent: %d\n",
> > >>>>>>>> +                               ret);
> > >>>>>>>> +              goto err;
> > >>>>>>>> +      }
> > >>>>>>>
> > >>>>>>> You better to change the exception handling as following: It is=
 more simple.
> > >>>>>>>
> > >>>>>>>         } else if (PTR_ERR(priv->passive_data.parent) =3D=3D -E=
PROBE_DEFER)
> > >>>>>>>                         || PTR_ERR(priv->passive_data.parent) =
=3D=3D -ENODEV) {
> > >>>>>>>                 goto err;
> > >>>>>>>         } else {
> > >>>>>>>                 ret =3D PTR_ERR(priv->passive_data.parent);
> > >>>>>>>                 dev_err(dev, "failed to get initialize passive =
parent: %d\n", ret);
> > >>>>>>>                 goto err;
> > >>>>>>>         }
> > >>>>
> > >>>> But -ENODEV is not an error, it means no passive parent was found.
> > >>>
> > >>> OK. just I want to make 'if statement' more simple. This style
> > >>> is complicated.
> > >>
> > >> I can avoid handling EPROBE_DEFER in a nested if.
> > >
> > > Anyway, if you make the exception more simple, I'm ok.
> > >
> > >>
> > >>>>>>>> +      priv->devfreq =3D devm_devfreq_add_device(dev, &priv->p=
rofile,
> > >>>>>>>> +                                              gov, govdata);
> > >>>>>>>> +      if (IS_ERR(priv->devfreq)) {
> > >>>>>>>> +              ret =3D PTR_ERR(priv->devfreq);
> > >>>>>>>> +              dev_err(dev, "failed to add devfreq device: %d\=
n", ret);
> > >>>>>>>> +              goto err;
> > >>>>>>>> +      }
> > >>>>>>>> +
> > >>>>>>>> +      return 0;
> > >>>>>>>> +
> > >>>>>>>> +err:
> > >>>>>>>> +      dev_pm_opp_of_remove_table(dev);
> > >>>>>>>> +      return ret;
> > >>>>>>>> +}
> > >>>>>>>> +
> > >>>>>>>> +static const struct of_device_id imx_devfreq_of_match[] =3D {
> > >>>>>>>> +      { .compatible =3D "fsl,imx8m-noc", },
> > >>>>>>>> +      { .compatible =3D "fsl,imx8m-nic", },
> > >>>>>>>> +      { /* sentinel */ },
> > >>>>>>>> +};
> > >>>>>>>> +MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
> > >>>>>>>> +
> > >>>>>>>> +static struct platform_driver imx_devfreq_platdrv =3D {
> > >>>>>>>> +      .probe          =3D imx_devfreq_probe,
> > >>>>>>>> +      .driver =3D {
> > >>>>>>>> +              .name   =3D "imx-devfreq",
> > >>>>>>>> +              .of_match_table =3D of_match_ptr(imx_devfreq_of=
_match),
> > >>>>>>>> +      },
> > >>>>>>>> +};
> > >>>>>>>> +module_platform_driver(imx_devfreq_platdrv);
> > >>>>>>>> +
> > >>>>>>>> +MODULE_DESCRIPTION("Generic i.MX bus frequency driver");
> > >>>>>>>
> > >>>>>>> If this driver is for bus frequency, you better to use 'bus' fo=
r the clock-name
> > >>>>>>> for the readability.
> > >>
> > >>
> > >>
> > >>
> > >
> > >
> >
>
>
> --
> Best Regards,
> Chanwoo Choi



--=20
Best Regards,
Chanwoo Choi
