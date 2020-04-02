Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93C219BEED
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 11:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgDBJxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 05:53:23 -0400
Received: from mail-am6eur05on2050.outbound.protection.outlook.com ([40.107.22.50]:6251
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbgDBJxW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 05:53:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNrBLs/hg9VRPrRLzl9eMdihVILc4kedCbNIIDtA1gy0nIZeMu0pXg9hSDrAVej6GJU0xIJ0hY4NYjusD7RNHskkYk/m25Y3cAy5SmGczfGxQWMSvVzyPPks4Pi7HcuAPI+oWmkF45TaPnd8ktWcZphjVhALAOIjJmVTRlYJVbyJPP2DhyVGIvLZ0EfC8Dou49tU5MKWZtgJ/Eigfa9oZuwg/OAgQ3phG0S1wE1cYhAC+pKwNJX37b1C5n58G1O2ZNsrMLa7o84sCvEYHqoUuq1jwKdhTMeBU5WkGepdI4nU3YTUyF0xcVXDaBZrCnhbVWJvP05ruaIiVDJdd6qpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRkQ1+B1Y3bfz3dyBTysi5xr5TiHZMt/iYsfnimckzs=;
 b=T2gQCZ3MdfeB6oiIR759shbjW6hWtE8OoP22Kkevg9B5MeU9beTs/0lfhVLzsQHVWLCW7LvvUWuJCEsUNhHV1fX6RZl+CBIKCETlFt0zwH1jw7+b44M0tFiR0n+qYUD+gX/UCB/jF1k/2SFfkQWd2O7w/aE0SvvAo6tEPvUqiKdzWKaDTMRUQvWi0WMIZ4uQNSOIG41snGwGAjlhh1K8vmpyH2xGVeCqoZAld1xDnXd8V6NKeDn/LJAUp8KP7+xK+9Wln9p2koMBLgJOvJ7vzD8cbDR1/XYC5fZ3ZCJYLLvzwoMBLBC7mATndis39IUJk8+0jOoxqOurIXIroRmR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRkQ1+B1Y3bfz3dyBTysi5xr5TiHZMt/iYsfnimckzs=;
 b=IRnHinPiLlVSI2nIXfi2kuKuZ6uR23MmtEbIX9tFCGQQnixKlcuooKm74r1RwfRIaHCUNv2mXFcrVraOI1Ji1cT6S7hk2BJ+MeuDeUKCylRTRlrz5XRc0rvrJCfQmnxvsxCCtFbaVCSHzM2zJ6zI78FUr/vty/eVQzkPByUvC/Q=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.244.87) by
 VI1PR04MB6208.eurprd04.prod.outlook.com (20.179.24.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Thu, 2 Apr 2020 09:53:15 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 09:53:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kepplinger <martink@posteo.de>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@samsung.com>,
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
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/8] PM / devfreq: Add generic imx bus scaling driver
Thread-Topic: [PATCH 2/8] PM / devfreq: Add generic imx bus scaling driver
Thread-Index: AQHWAxSPVPtoe31rEECA7ZPaKWog5A==
Date:   Thu, 2 Apr 2020 09:53:15 +0000
Message-ID: <VI1PR04MB69417B0BC486AE67957522ADEEC60@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
 <CGME20200326021637epcas1p26d84c256cf05a97ae1c90bb16ea6fa5d@epcas1p2.samsung.com>
 <e32290a36b31fbe922cc8ed48c33e89a5eb08804.1585188174.git.leonard.crestez@nxp.com>
 <781911a0-6139-8e41-cd96-da40fad685fc@samsung.com>
 <VI1PR04MB694183137034565F350E8587EEC90@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <8b1623d9-fb71-836f-776e-2dffdbcc27b3@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bddd6ff7-54d2-416e-ad62-08d7d6eba9ef
x-ms-traffictypediagnostic: VI1PR04MB6208:|VI1PR04MB6208:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6208E9A4C27CC6BD91B05D19EEC60@VI1PR04MB6208.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(316002)(55016002)(6506007)(9686003)(478600001)(8936002)(53546011)(2906002)(81166006)(76116006)(186003)(110136005)(7416002)(86362001)(5660300002)(54906003)(45080400002)(7696005)(966005)(8676002)(81156014)(26005)(66476007)(66946007)(4326008)(64756008)(33656002)(66556008)(44832011)(52536014)(66574012)(71200400001)(66446008)(41533002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Qci88OW3j7HGXo37Z+decoHQBFXpUIP3V2ZSBhCqJHlOuWMcNjz9nVV8+8xF2l64lJLjNYNt8NKI1ehEwVRAeBLHSKOHeaaDKmaL8FaLVNjS9TV0f9tSBqKN1BJg9l7EADceHNGvnBXKiTAGQete0hO12tqSKff1EXblhUFFiMkxQTKSfnZ22IpMUaDKSie+vBnTkVaKfoP2RnLILYNeOFg5HgYfAANPwU2AVhliedECLLzNkowOLApg04+8jIDyYGeZdZavL8CpROUTYml0oOpEPm6BKiDLvtJ1uIqRucKngSy6RmIMcT5gkp+6sDpt7xhAjErgsHuO9VAotdwjNjkeo2EOglPwYqAMP6rbLwV3LRbjXVJpxtUk9dIqK15BbtRBTcE27f+Vd3ZXysPkQzeKlWTMaFoSsAP8Fi5d+KlUp/Fzop8Ke3dkuUuTkQ2+i8RIjatqfx81VBnZPPsbQubGGG1tCugklS8UZXr2m7n6IQdq0GtmeVFd9vDJAKsC5A05jMNEldSsQBG5sbDGqvjM7TSGao+671KYj6BzH1eYRF8pHvJP2mxFlmRh6Po
x-ms-exchange-antispam-messagedata: p7ykiJ8i2ym7tTYtwDQQ/8G46J3Bj8gZcgNNh2zPRgQYtVmp4oftQtxPTtlcHyUfIujKqR32fxbTCmbNBSloJ2zYJKWwEfSDBnTh7DueKlQE5NrLlr4+eXvXlrhb7OGGUfo4XkTro3BMIuTalRRd2Q==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddd6ff7-54d2-416e-ad62-08d7d6eba9ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 09:53:15.1914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTdMr+tiIx4i5kZuIp+1vPIC1DORZtrO8/ontk3UfnQS2HzgqAhCgZotegZA+jIeO+Dh41AHVDlGrL6D8EBe5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6208
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-02 1:48 AM, Chanwoo Choi wrote:=0A=
> On 4/1/20 11:20 PM, Leonard Crestez wrote:=0A=
>> On 2020-04-01 1:55 AM, Chanwoo Choi wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> Looks good to me. I added the comments.=0A=
>>> But, it need to add the dt binding documentation for this device.=0A=
>>=0A=
>> DT bindings were included:=0A=
>>=0A=
>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc=
hwork.kernel.org%2Fpatch%2F11458981%2F&amp;data=3D02%7C01%7Cleonard.crestez=
%40nxp.com%7C7381d117a4d1468cd2c608d7d68ecfac%7C686ea1d3bc2b4c6fa92cd99c5c3=
01635%7C0%7C0%7C637213781167514099&amp;sdata=3DQu8x14cXnuxlwOT2SlUOf%2FLgCV=
WbnJRKA4TBjMIWQeA%3D&amp;reserved=3D0=0A=
> =0A=
> The dt-binding document for this driver is required under=0A=
> Documentation/devicetree/binding/devfreq.=0A=
=0A=
Bindings for imx8m-ddrc were at one point posted for =0A=
devicetree/bindings/devfreq but Rob Herring suggested to move them under =
=0A=
"memory-controller" instead and I expect same logic makes sense here. =0A=
Link to previous discussion:=0A=
=0A=
https://patchwork.kernel.org/patch/11221919/=0A=
=0A=
DT bindings should try to describe "hardware" rather than "drivers" and =0A=
an "interconnect" is a class of hardware while "devfreq" isn't.=0A=
=0A=
Not only that but the main noc has properties parsed by interconnect driver=
.=0A=
=0A=
> It is difficult to catch where is the dt-binding document=0A=
> for this driver for who don't know the detailed history=0A=
> of this driver. I don't said that add the duplicate documentation=0A=
> But, at least the some document have to point out the reference.=0A=
=0A=
What I usually do to find information about a device is grep for the =0A=
compat string in the entire tree.=0A=
=0A=
>>> The old email of Artur =A6wigo=F1 is not used. On next time,=0A=
>>> use following the new email address Because when I reply the mail,=0A=
>>> always show the fail message from thunderbird due to the Artur's old em=
ail.=0A=
>>> <a.swigon@partnet.samsung.com> -> <a.swigon@samsung.com>=0A=
>>=0A=
>> Yeah, I received multiple bounces because of this.=0A=
>>=0A=
>>> On 3/26/20 11:16 AM, Leonard Crestez wrote:=0A=
>>>> Add initial support for dynamic frequency switching on pieces of the i=
mx=0A=
>>>> interconnect fabric.=0A=
>>>>=0A=
>>>> All this driver does is set a clk rate based on an opp table, it does=
=0A=
>>>> not map register areas.=0A=
>>>>=0A=
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>> ---=0A=
>>>>    drivers/devfreq/Kconfig   |   9 +++=0A=
>>>>    drivers/devfreq/Makefile  |   1 +=0A=
>>>>    drivers/devfreq/imx-bus.c | 142 +++++++++++++++++++++++++++++++++++=
+++=0A=
>>>>    3 files changed, 152 insertions(+)=0A=
>>>>    create mode 100644 drivers/devfreq/imx-bus.c=0A=
>>>>=0A=
>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig=0A=
>>>> index 0b1df12e0f21..44d26192ddc4 100644=0A=
>>>> --- a/drivers/devfreq/Kconfig=0A=
>>>> +++ b/drivers/devfreq/Kconfig=0A=
>>>> @@ -99,10 +99,19 @@ config ARM_IMX8M_DDRC_DEVFREQ=0A=
>>>>    	select DEVFREQ_GOV_USERSPACE=0A=
>>>>    	help=0A=
>>>>    	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It a=
llows=0A=
>>>>    	  adjusting DRAM frequency.=0A=
>>>>    =0A=
>>>> +config ARM_IMX_BUS_DEVFREQ=0A=
>>>> +	tristate "i.MX Generic Bus DEVFREQ Driver"=0A=
>>>> +	depends on ARCH_MXC || COMPILE_TEST=0A=
>>>> +	select DEVFREQ_GOV_PASSIVE=0A=
>>>> +	select DEVFREQ_GOV_USERSPACE=0A=
>>>=0A=
>>> Maybe, you would update it by using passive governor?=0A=
>>> But, in this version, it doesn't handle the any passive governor.=0A=
>>=0A=
>> dropped=0A=
>>=0A=
>>>> +	help=0A=
>>>> +	  This adds the generic DEVFREQ driver for i.MX interconnects. It=0A=
>>>> +	  allows adjusting NIC/NOC frequency.=0A=
>>>> +=0A=
>>>>    config ARM_TEGRA_DEVFREQ=0A=
>>>>    	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"=0A=
>>>>    	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \=0A=
>>>>    		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \=0A=
>>>>    		ARCH_TEGRA_210_SOC || \=0A=
>>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile=0A=
>>>> index 3eb4d5e6635c..3ca1ad0ecb97 100644=0A=
>>>> --- a/drivers/devfreq/Makefile=0A=
>>>> +++ b/drivers/devfreq/Makefile=0A=
>>>> @@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+=3D governor_po=
wersave.o=0A=
>>>>    obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor_userspace.o=0A=
>>>>    obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=3D governor_passive.o=0A=
>>>>    =0A=
>>>>    # DEVFREQ Drivers=0A=
>>>>    obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o=0A=
>>>> +obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+=3D imx-bus.o=0A=
>>>=0A=
>>> The ARM_IMX_BUS_DEVFREQ config is under ARM_IMX8M_DDRC_DEVFREQ=0A=
>>> and imx-bus.o is over imx8m-ddrc.o. Need to edit the sequence.=0A=
>>=0A=
>> Reordered kconfig to match. 8M_DDRC sorts before _BUS alphabetically but=
=0A=
>> it's pettier this way, and matches tegra.=0A=
>>=0A=
>>>>    obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+=3D imx8m-ddrc.o=0A=
>>>>    obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+=3D rk3399_dmc.o=0A=
>>>>    obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra30-devfreq.o=0A=
>>>>    obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+=3D tegra20-devfreq.o=0A=
>>>>    =0A=
>>>> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c=0A=
>>>> new file mode 100644=0A=
>>>> index 000000000000..285e0f1ae6b1=0A=
>>>> --- /dev/null=0A=
>>>> +++ b/drivers/devfreq/imx-bus.c=0A=
>>>> @@ -0,0 +1,142 @@=0A=
>>>> +// SPDX-License-Identifier: GPL-2.0=0A=
>>>> +/*=0A=
>>>> + * Copyright 2019 NXP=0A=
>>>> + */=0A=
>>>> +=0A=
>>>> +#include <linux/clk.h>=0A=
>>>> +#include <linux/devfreq.h>=0A=
>>>> +#include <linux/device.h>=0A=
>>>> +#include <linux/module.h>=0A=
>>>> +#include <linux/of_device.h>=0A=
>>>> +#include <linux/pm_opp.h>=0A=
>>>> +#include <linux/platform_device.h>=0A=
>>>> +#include <linux/slab.h>=0A=
>>>> +=0A=
>>>> +struct imx_bus {=0A=
>>>> +	struct devfreq_dev_profile profile;=0A=
>>>> +	struct devfreq *devfreq;=0A=
>>>> +	struct clk *clk;=0A=
>>>> +	struct devfreq_passive_data passive_data;=0A=
>>>=0A=
>>> This patch doesn't touch the passive_data.=0A=
>>=0A=
>> dropped=0A=
>>=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +static int imx_bus_target(struct device *dev,=0A=
>>>> +		unsigned long *freq, u32 flags)=0A=
>>>> +{=0A=
>>>> +	struct imx_bus *priv =3D dev_get_drvdata(dev);=0A=
>>>> +	struct dev_pm_opp *new_opp;=0A=
>>>> +	unsigned long new_freq;=0A=
>>>> +	int ret;=0A=
>>>> +=0A=
>>>> +	new_opp =3D devfreq_recommended_opp(dev, freq, flags);=0A=
>>>> +	if (IS_ERR(new_opp)) {=0A=
>>>> +		ret =3D PTR_ERR(new_opp);=0A=
>>>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);=0A=
>>>> +		return ret;=0A=
>>>> +	}=0A=
>>>> +	new_freq =3D dev_pm_opp_get_freq(new_opp);=0A=
>>>=0A=
>>> It doesn't need. Because the new frequency is stored to 'freq'=0A=
>>> by calling devfreq_recommended_opp().=0A=
>>=0A=
>> fixed=0A=
>>=0A=
>>>> +	dev_pm_opp_put(new_opp);=0A=
>>>> +=0A=
>>>> +	return clk_set_rate(priv->clk, new_freq);=0A=
>>>=0A=
>>> nitpick. you can use dev_pm_opp_set_rate(). But, I'm not forcing to use=
 it.=0A=
>>=0A=
>> Switched to dev_pm_opp_set_rate.=0A=
>>=0A=
>> It might be interesting to add regulators control later, on some chips=
=0A=
>> the main NOC can run at different voltages.=0A=
>>=0A=
>>>=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx_bus_get_cur_freq(struct device *dev, unsigned long *fr=
eq)=0A=
>>>> +{=0A=
>>>> +	struct imx_bus *priv =3D dev_get_drvdata(dev);=0A=
>>>> +=0A=
>>>> +	*freq =3D clk_get_rate(priv->clk);=0A=
>>>> +=0A=
>>>> +	return 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx_bus_get_dev_status(struct device *dev,=0A=
>>>> +		struct devfreq_dev_status *stat)=0A=
>>>> +{=0A=
>>>> +	struct imx_bus *priv =3D dev_get_drvdata(dev);=0A=
>>>> +=0A=
>>>> +	stat->busy_time =3D 0;=0A=
>>>> +	stat->total_time =3D 0;=0A=
>>>> +	stat->current_frequency =3D clk_get_rate(priv->clk);=0A=
>>>> +=0A=
>>>> +	return 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static void imx_bus_exit(struct device *dev)=0A=
>>>> +{=0A=
>>>> +	dev_pm_opp_of_remove_table(dev);=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx_bus_probe(struct platform_device *pdev)=0A=
>>>> +{=0A=
>>>> +	struct device *dev =3D &pdev->dev;=0A=
>>>> +	struct imx_bus *priv;=0A=
>>>> +	const char *gov =3D DEVFREQ_GOV_USERSPACE;=0A=
>>>> +	int ret;=0A=
>>>> +=0A=
>>>> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);=0A=
>>>> +	if (!priv)=0A=
>>>> +		return -ENOMEM;=0A=
>>>> +=0A=
>>>> +	/*=0A=
>>>> +	 * Fetch the clock to adjust but don't explictly enable.=0A=
>>>=0A=
>>> Need to fix typo.=0A=
>>> s/explictly/explicitly=0A=
>>=0A=
>> fixed=0A=
>>=0A=
>>>> +	 *=0A=
>>>> +	 * For imx bus clock clk_set_rate is safe no matter if the clock is =
on=0A=
>>>> +	 * or off and some peripheral side-buses might be off unless enabled=
 by=0A=
>>>> +	 * drivers for devices on those specific buses.=0A=
>>>> +	 *=0A=
>>>> +	 * Rate adjustment on a disabled bus clock just takes effect later.=
=0A=
>>>> +	 */=0A=
>>>> +	priv->clk =3D devm_clk_get(dev, NULL);=0A=
>>>> +	if (IS_ERR(priv->clk)) {=0A=
>>>> +		ret =3D PTR_ERR(priv->clk);=0A=
>>>> +		dev_err(dev, "failed to fetch clk: %d\n", ret);=0A=
>>>> +		return ret;=0A=
>>>> +	}=0A=
>>>> +	platform_set_drvdata(pdev, priv);=0A=
>>>> +=0A=
>>>> +	ret =3D dev_pm_opp_of_add_table(dev);=0A=
>>>> +	if (ret < 0) {=0A=
>>>> +		dev_err(dev, "failed to get OPP table\n");=0A=
>>>> +		return ret;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	priv->profile.polling_ms =3D 1000;=0A=
>>>> +	priv->profile.target =3D imx_bus_target;=0A=
>>>> +	priv->profile.get_dev_status =3D imx_bus_get_dev_status;=0A=
>>>> +	priv->profile.exit =3D imx_bus_exit;=0A=
>>>> +	priv->profile.get_cur_freq =3D imx_bus_get_cur_freq;=0A=
>>>> +	priv->profile.initial_freq =3D clk_get_rate(priv->clk);=0A=
>>>> +=0A=
>>>> +	priv->devfreq =3D devm_devfreq_add_device(dev, &priv->profile,=0A=
>>>> +						gov, NULL);=0A=
>>>> +	if (IS_ERR(priv->devfreq)) {=0A=
>>>> +		ret =3D PTR_ERR(priv->devfreq);=0A=
>>>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);=0A=
>>>> +		goto err;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	return 0;=0A=
>>>> +=0A=
>>>> +err:=0A=
>>>> +	dev_pm_opp_of_remove_table(dev);=0A=
>>>> +	return ret;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static const struct of_device_id imx_bus_of_match[] =3D {=0A=
>>>> +	{ .compatible =3D "fsl,imx8m-noc", },=0A=
>>>> +	{ .compatible =3D "fsl,imx8m-nic", },=0A=
>>>> +	{ /* sentinel */ },=0A=
>>>> +};=0A=
>>>> +MODULE_DEVICE_TABLE(of, imx_bus_of_match);=0A=
>>>> +=0A=
>>>> +static struct platform_driver imx_bus_platdrv =3D {=0A=
>>>> +	.probe		=3D imx_bus_probe,=0A=
>>>> +	.driver =3D {=0A=
>>>> +		.name	=3D "imx-bus-devfreq",=0A=
>>>> +		.of_match_table =3D of_match_ptr(imx_bus_of_match),=0A=
>>>> +	},=0A=
>>>> +};=0A=
>>>> +module_platform_driver(imx_bus_platdrv);=0A=
>>>> +=0A=
>>>> +MODULE_DESCRIPTION("Generic i.MX bus frequency scaling driver");=0A=
>>>> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");=0A=
>>>> +MODULE_LICENSE("GPL v2");=0A=
>>>>=0A=
>>>=0A=
>>>=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
