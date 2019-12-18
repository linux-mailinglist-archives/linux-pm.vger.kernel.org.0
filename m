Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4019A124554
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLRLGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 06:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfLRLGL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 06:06:11 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8629C2467F;
        Wed, 18 Dec 2019 11:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576667170;
        bh=T+lH8bJxMA3antgWa53mmQwA212SQMB99c3fW+LhwCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U6y+wFZlMneOyvFVXlVmT9NAoJK9qKiIRr4ZWY9SIOPnXD6ghsuufJsTcO+UvqUyc
         nuix7OhsOk/VAmBPgi25sfTsTBnlnxeGW7777zao8ROqFQfm/PP5jIM4kTViXjqEhk
         oX9RADWYfvfWW7DXoiWICPR98BXBM+fil2Ki2C6c=
Received: by mail-lj1-f175.google.com with SMTP id j26so1621299ljc.12;
        Wed, 18 Dec 2019 03:06:10 -0800 (PST)
X-Gm-Message-State: APjAAAWsEJqHj2VsIasaZn/leAslyEVkcBttF4F40MMbIT4yELmZ7Bu/
        8TguzntN6BAewetmlWEqyuvIbfp44ggJGGH6Jr8=
X-Google-Smtp-Source: APXvYqxFqmEzLfRtA5LIKkLhHUdcqgmVQa4Gh13Gq0MRklJ/wwcukLDCLMxwYsSm8EMPDm2MdkofX2tLdCyM06y4H2I=
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr1318444ljg.82.1576667168599;
 Wed, 18 Dec 2019 03:06:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573761527.git.leonard.crestez@nxp.com> <CGME20191114201049epcas5p370853a1d78584bf00d8493ce20320bf9@epcas5p3.samsung.com>
 <e0e6a1685ccdad95c9d0c922801afdda8adb9f05.1573761527.git.leonard.crestez@nxp.com>
 <4d45cd39-24df-1714-0a27-5019c1367063@samsung.com> <VI1PR04MB7023F511BAE7D1EDF971CC48EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <60fe19c6-6e73-4133-ed7e-a13a875589c0@samsung.com> <VI1PR04MB7023DAC69C8B4B7CF144F29EEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023DAC69C8B4B7CF144F29EEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Wed, 18 Dec 2019 20:05:32 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1omr9jqRv9JX+X253YardFx_B26Hm-cT8UNF2J7eC_og@mail.gmail.com>
Message-ID: <CAGTfZH1omr9jqRv9JX+X253YardFx_B26Hm-cT8UNF2J7eC_og@mail.gmail.com>
Subject: Re: [PATCH RFC v6 3/9] PM / devfreq: imx: Register interconnect device
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

2019=EB=85=84 12=EC=9B=94 18=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 7:14, =
Leonard Crestez <leonard.crestez@nxp.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On 17.12.2019 02:55, Chanwoo Choi wrote:
> > On 12/17/19 12:00 AM, Leonard Crestez wrote:
> >> On 13.12.2019 06:22, Chanwoo Choi wrote:
> >>> Hi,
> >>>
> >>> On 11/15/19 5:09 AM, Leonard Crestez wrote:
> >>>> There is no single device which can represent the imx interconnect.
> >>>> Instead of adding a virtual one just make the main &noc act as the
> >>>> global interconnect provider.
> >>>>
> >>>> The imx interconnect provider driver will scale the NOC and DDRC bas=
ed
> >>>> on bandwidth request. More scalable nodes can be added in the future=
,
> >>>> for example for audio/display/vpu/gpu NICs.
> >>>>
> >>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >>>> ---
> >>>>    drivers/devfreq/imx-devfreq.c | 37 ++++++++++++++++++++++++++++++=
+++++
> >>>>    1 file changed, 37 insertions(+)
> >>>>
> >>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-dev=
freq.c
> >>>> index 620b344e87aa..585d340c0f6e 100644
> >>>> --- a/drivers/devfreq/imx-devfreq.c
> >>>> +++ b/drivers/devfreq/imx-devfreq.c
> >>>> @@ -15,10 +15,11 @@
> >>>>    struct imx_devfreq {
> >>>>            struct devfreq_dev_profile profile;
> >>>>            struct devfreq *devfreq;
> >>>>            struct clk *clk;
> >>>>            struct devfreq_passive_data passive_data;
> >>>> +  struct platform_device *icc_pdev;
> >>>>    };
> >>>>
> >>>>    static int imx_devfreq_target(struct device *dev,
> >>>>                                  unsigned long *freq, u32 flags)
> >>>>    {
> >>>> @@ -60,11 +61,40 @@ static int imx_devfreq_get_dev_status(struct dev=
ice *dev,
> >>>>            return 0;
> >>>>    }
> >>>>
> >>>>    static void imx_devfreq_exit(struct device *dev)
> >>>>    {
> >>>> +  struct imx_devfreq *priv =3D dev_get_drvdata(dev);
> >>>> +
> >>>>            dev_pm_opp_of_remove_table(dev);
> >>>> +  platform_device_unregister(priv->icc_pdev);
> >>>> +}
> >>>> +
> >>>> +/* imx_devfreq_init_icc() - register matching icc provider if requi=
red */
> >>>> +static int imx_devfreq_init_icc(struct device *dev)
> >>>> +{
> >>>> +  struct imx_devfreq *priv =3D dev_get_drvdata(dev);
> >>>> +  const char *icc_driver_name;
> >>>> +
> >>>> +  if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX))
> >>>> +          return 0;
> >>>
> >>> It is not proper to check the enable state of CONFIG_INTERCONNECT_IMX=
 configuration
> >>> on device driver. Why don't you add the 'select CONFIG_INTERCONNECT_I=
MX' on Kconfig?
> >>
> >> Because it's optional.
> >>
> >> You can disable interconnect support and just tweak frequencies using
> >> the devfreq sysfs API. But indeed would only really be useful for debu=
gging.
> >
> > Even if it's optional, I don't prefer to use 'IS_ENABLED' macro.
> >
> > Generally, add or delete the property or value at DT file
> > to either enable or disable the some feature provided by device driver
> > instead of checking the configuration.
> >
> > If user adds the property/value related to interconnect
> > and imx-bus.c configuration is enabled, the behavior
> > related to interconnect on imx-bus.c doesn't work. It make some confusi=
on.
>
> Maybe I could print a warning if #interconnect-cells is present but
> CONFIG_INTERCONNECT_IMX is off?

Actually, user might think that if imx-bus.c is enabled
, CONFIG_INTERCONNECT_MIX is enabled.
Because, the dt binding document of imx-bus.c will
contain the property for interconnect.

If device driver support the various feature,
the device driver have to enable all configuration
in order to support the features for user.

>
> An explicit select in Kconfig seems like a pointless limitation but in
> practice it would almost never be useful to build one without the other.

This patch is for the some CONFIG_INTERCONNECT_IMX driver.
I don't understand why is not meaningful to select CONFIG_INTERCONNECT_IMX
in Kconfig?

>
> > The imx-bus.c have to add the 'select CONFIG_INTERCONNECT_IMX'
> > and hand over the right which use the interconnect feature or not, to u=
ser.
> >
> > If there are any requirement to add the additional property
> > to check whether interconnect feature will be used or not,
> > you can add the extra property. But, I think that it is enough
> > to check the '#interconnect-cells'.
> >
> > In result, I think that it is right to decide the usage of feature
> > of device driver by user on Devicetree.
> >
> >>
> >>>> +  if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
> >>>> +          return 0;
> >>>> +
> >>>> +  icc_driver_name =3D of_device_get_match_data(dev);
> >>>> +  if (!icc_driver_name)
> >>>> +          return 0;
> >>>> +
> >>>> +  priv->icc_pdev =3D platform_device_register_data(
> >>>> +                  dev, icc_driver_name, 0, NULL, 0);
> >>>> +  if (IS_ERR(priv->icc_pdev)) {
> >>>> +          dev_err(dev, "failed to register icc provider %s: %ld\n",
> >>>> +                          icc_driver_name, PTR_ERR(priv->devfreq));
> >>>> +          return PTR_ERR(priv->devfreq);
> >>>> +  }
> >>>> +
> >>>> +  return 0;
> >>>>    }
> >>>>
> >>>>    static int imx_devfreq_probe(struct platform_device *pdev)
> >>>>    {
> >>>>            struct device *dev =3D &pdev->dev;
> >>>> @@ -120,18 +150,25 @@ static int imx_devfreq_probe(struct platform_d=
evice *pdev)
> >>>>                    ret =3D PTR_ERR(priv->devfreq);
> >>>>                    dev_err(dev, "failed to add devfreq device: %d\n"=
, ret);
> >>>>                    goto err;
> >>>>            }
> >>>>
> >>>> +  ret =3D imx_devfreq_init_icc(dev);
> >>>> +  if (ret)
> >>>> +          goto err;
> >>>> +
> >>>>            return 0;
> >>>>
> >>>>    err:
> >>>>            dev_pm_opp_of_remove_table(dev);
> >>>>            return ret;
> >>>>    }
> >>>>
> >>>>    static const struct of_device_id imx_devfreq_of_match[] =3D {
> >>>> +  { .compatible =3D "fsl,imx8mq-noc", .data =3D "imx8mq-interconnec=
t", },
> >>>> +  { .compatible =3D "fsl,imx8mm-noc", .data =3D "imx8mm-interconnec=
t", },
> >>>> +  { .compatible =3D "fsl,imx8mn-noc", .data =3D "imx8mn-interconnec=
t", },
> >>>>            { .compatible =3D "fsl,imx8m-noc", },
> >>>>            { .compatible =3D "fsl,imx8m-nic", },
> >>>>            { /* sentinel */ },
> >>>>    };
> >>>>    MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
> >>
> >>
> >
> >
>


--=20
Best Regards,
Chanwoo Choi
