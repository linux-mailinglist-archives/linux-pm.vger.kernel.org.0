Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC2120911
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 15:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfLPO57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 09:57:59 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:14478
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728008AbfLPO55 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 09:57:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTvXxcfcC2tnouMQm5TUf+qLYrSEaAQhQc264h0mBgDtPWODOvCJHJtlxwGIrQKQXHa+xe9fjqV4ZiYw5/9RUgpUDFxZvuXl357GdVPdxOUzytEDWFJtUtosz7XBdiJhYg6OWrBRo7/PV5BF01s3Ti/nB1ZktTMK3KTRov+r+j2fIvIRURbnhMvLzJ/VYgGBR/SaTkIjQagFD+2muO9Pl/UnGaitS1wwnHrFRywf90plm9F0iThRNdykjgB/lxJxJSdGTIsSoNl4VXjU5p92nOX/v8vTZRwE736GrTtAyaQHoasAsjImBRIaQ7zYMmJQStAWrc+VN1uH51xpjqAqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha3Pa/aNcEju1IT2rVX631S01ZhJSthG7H1STyZHxwE=;
 b=Kou90EeFD/Vfd/XBjKF08MfhrVN+Aji3G0yMVfCfzHR25KYKQUb4xwDi3ICxX2T9pb+RAp2sbvRLg+U/VCnNetOB4uvPHKeGPQbbcr/dSxTtWQ4VzcowhPRaJotvVtWgrLtJph+lFMgFvXxAMhMSvZr6pYwT6Px5bT+XF6iWdsychOSfkr9rnYFmbxfH3mfFUy62j5qdZQsmhzwDzK4AI1b33Ht7Xv1rGbmtX9/6WdAni+PsujAA1WpkaEJAhtlDopng23CsDuEkoxmTYocf5A0HWFVghwDKw2uwCCW7gfshXQdQB7mjXHuJV655SVskQD/khTKvT7Q3SnVCnxwaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha3Pa/aNcEju1IT2rVX631S01ZhJSthG7H1STyZHxwE=;
 b=Dnzt7/VOTuxiVPackJtIS6fhRp0m/iR8w5V1YLaabScea2bOWjL8NOAIYO/uY/XCclMmqORQOmALwZBS6M7/krpLZFNDHkNZ0pCp324wBqlX8SKYN9Ll/805aM+FVpMASSiVQe7zEVdet4wZ0kWzwMmeJh+fK78zIJQ/OrZ1LaU=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5584.eurprd04.prod.outlook.com (20.178.123.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 14:57:53 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 14:57:53 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
Thread-Topic: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
Thread-Index: AQHVmyeZDID07b0oVkajwef04uXjmg==
Date:   Mon, 16 Dec 2019 14:57:53 +0000
Message-ID: <VI1PR04MB702396D09FCED6CBA49B6AE7EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <CGME20191114201049epcas5p4a24607634af7b31e6a2dbdb4166dd862@epcas5p4.samsung.com>
 <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
 <8734a934-79e2-7445-c3e5-a0bb59afd4a8@samsung.com>
 <047990a5-263d-d447-7f0a-77a99e4b1f63@samsung.com>
 <25e3177f-e2b9-6be4-cfb8-24f87ccba45b@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a808776-19e6-4860-aed9-08d7823853f1
x-ms-traffictypediagnostic: VI1PR04MB5584:|VI1PR04MB5584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5584D0368221C648C430B5EFEE510@VI1PR04MB5584.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(51444003)(71200400001)(7696005)(8676002)(81166006)(86362001)(81156014)(44832011)(478600001)(316002)(6506007)(26005)(76116006)(4326008)(8936002)(66946007)(53546011)(66556008)(186003)(66476007)(64756008)(7416002)(2906002)(54906003)(52536014)(66446008)(5660300002)(55016002)(110136005)(91956017)(33656002)(9686003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5584;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LFtQVYCNye8/rUMv5Y5sWfI6yF4B1NpG03+BV5dKzzfD4kx4MX0vzGBNf5YTUJAIXUU3QXf0aSH2/ibvXL7pKoiFQPAQy1+9jvkPp8ma0sI6KZa3tA+TrWLum1X4yRdcOCP1EJaLdaTKAcCblu3ECj0dIapffLE0UlQym/f+8xgrXNlr+mo4beZiUZKmOxBPfBz3DDpWHJxNrX4dIZ9YmjES450sWveDwqXjehUQtFtSwlR1YETkXDGRpSRu0XIV+1AZ/iDxG4gdDCLU5S2Joq6Ir4h5kHq7M35Ww7TyLmSvYkXAXm/jnkP/BDKY3tgkkWqVvjIOylHJIw0TidxiaH9Av3R1zk3LA8qDML6m+rFaNvzqmwonceXcYynOWKKiQx67YnqZVknFZGeJJ2AGXXCDVkJ0LK1lNpa9Q92LEivGjEZzHYfilEeCmBntHjsyklFtrTuRxNAjCGB5aR6yCWVs0WpIThGqOtfPFltgbUhydrkjNJOl6LMQD1+As2x/g7LTCIy5TL66+7ZkDtZog==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a808776-19e6-4860-aed9-08d7823853f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 14:57:53.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBsO7XmckbAox0ugrf3zXGeDi9+4riFb9OQijpVzXX+WsfNxPYeRD8/OVvKzh3fR9Yx2dFWUVwwhwgM7QiDJog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5584
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16.12.2019 03:00, Chanwoo Choi wrote:=0A=
> Hi,=0A=
> =0A=
> Also, I think that 'devfreq' word is not proper for device driver name.=
=0A=
> imx-bus.c or imx-noc.c or others to inform the role of this driver of dev=
eloper.=0A=
=0A=
I'll rename to "imx-bus". Calling it "imx-noc" is not appropriate =0A=
because I also want to use it for PL301 NICs.=0A=
=0A=
> And, I have a question.=0A=
> This driver adds the devfreq device with either passive governor=0A=
> or userspace governor.=0A=
> =0A=
> As I understood, the devfreq device with passive governor=0A=
> will be operated with imx8m-ddrc.c driver.=0A=
> But, when is operating with userspace governor?=0A=
=0A=
There are multiple scalable buses inside the SOC, for example there's a =0A=
NIC for display controllers and one for (pci+usb). They can use =0A=
userspace governor for explicit frequency control.=0A=
=0A=
> I think that you better to add the explanation to description=0A=
> for two scenarios how to operate with interconnect provider=0A=
> on either passive governor or userspace governor usage case.=0A=
=0A=
I'll elaborate the example in bindings.=0A=
=0A=
> On 12/13/19 10:51 AM, Chanwoo Choi wrote:=0A=
>> On 12/13/19 10:30 AM, Chanwoo Choi wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:=0A=
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
>>>>   drivers/devfreq/Kconfig       |   9 ++=0A=
>>>>   drivers/devfreq/Makefile      |   1 +=0A=
>>>>   drivers/devfreq/imx-devfreq.c | 150 ++++++++++++++++++++++++++++++++=
++=0A=
>>>>   3 files changed, 160 insertions(+)=0A=
>>>>   create mode 100644 drivers/devfreq/imx-devfreq.c=0A=
>>>>=0A=
>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig=0A=
>>>> index 923a6132e741..fef5ce831e90 100644=0A=
>>>> --- a/drivers/devfreq/Kconfig=0A=
>>>> +++ b/drivers/devfreq/Kconfig=0A=
>>>> @@ -98,10 +98,19 @@ config ARM_IMX8M_DDRC_DEVFREQ=0A=
>>>>   	select DEVFREQ_GOV_USERSPACE=0A=
>>>>   	help=0A=
>>>>   	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It al=
lows=0A=
>>>>   	  adjusting DRAM frequency.=0A=
>>>>   =0A=
>>>> +config ARM_IMX_DEVFREQ=0A=
>>>> +	tristate "i.MX Generic DEVFREQ Driver"=0A=
>>>> +	depends on ARCH_MXC || COMPILE_TEST=0A=
>>>> +	select DEVFREQ_GOV_PASSIVE=0A=
>>>> +	select DEVFREQ_GOV_USERSPACE=0A=
>>>> +	help=0A=
>>>> +	  This adds the generic DEVFREQ driver for i.MX interconnects. It=0A=
>>>> +	  allows adjusting NIC/NOC frequency.=0A=
>>>> +=0A=
>>>>   config ARM_TEGRA_DEVFREQ=0A=
>>>>   	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"=0A=
>>>>   	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \=0A=
>>>>   		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \=0A=
>>>>   		ARCH_TEGRA_210_SOC || \=0A=
>>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile=0A=
>>>> index 3eb4d5e6635c..61d0edee16f7 100644=0A=
>>>> --- a/drivers/devfreq/Makefile=0A=
>>>> +++ b/drivers/devfreq/Makefile=0A=
>>>> @@ -8,10 +8,11 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor_us=
erspace.o=0A=
>>>>   obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=3D governor_passive.o=0A=
>>>>   =0A=
>>>>   # DEVFREQ Drivers=0A=
>>>>   obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o=0A=
>>>>   obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+=3D imx8m-ddrc.o=0A=
>>>> +obj-$(CONFIG_ARM_IMX_DEVFREQ)		+=3D imx-devfreq.o=0A=
>>>>   obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+=3D rk3399_dmc.o=0A=
>>>>   obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra30-devfreq.o=0A=
>>>>   obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+=3D tegra20-devfreq.o=0A=
>>>>   =0A=
>>>>   # DEVFREQ Event Drivers=0A=
>>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfr=
eq.c=0A=
>>>> new file mode 100644=0A=
>>>> index 000000000000..620b344e87aa=0A=
>>>> --- /dev/null=0A=
>>>> +++ b/drivers/devfreq/imx-devfreq.c=0A=
>>>> @@ -0,0 +1,150 @@=0A=
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
>>>> +struct imx_devfreq {=0A=
>>>> +	struct devfreq_dev_profile profile;=0A=
>>>> +	struct devfreq *devfreq;=0A=
>>>> +	struct clk *clk;=0A=
>>>> +	struct devfreq_passive_data passive_data;=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +static int imx_devfreq_target(struct device *dev,=0A=
>>>> +			      unsigned long *freq, u32 flags)=0A=
>>>=0A=
>>> Don't use space for the indentation. Please use only tab.=0A=
=0A=
OK=0A=
=0A=
>>>> +{=0A=
>>>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
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
>>>> +	dev_pm_opp_put(new_opp);=0A=
>>>> +=0A=
>>>> +	return clk_set_rate(priv->clk, new_freq);=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx_devfreq_get_cur_freq(struct device *dev, unsigned long=
 *freq)=0A=
>>>> +{=0A=
>>>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
>>>> +=0A=
>>>> +	*freq =3D clk_get_rate(priv->clk);=0A=
>>>> +=0A=
>>>> +	return 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx_devfreq_get_dev_status(struct device *dev,=0A=
>>>> +				      struct devfreq_dev_status *stat)=0A=
>>>=0A=
>>> ditto. Please use tab for the indentation.=0A=
>>>=0A=
>>>> +{=0A=
>>>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
>>>> +=0A=
>>>> +	stat->busy_time =3D 0;=0A=
>>>> +	stat->total_time =3D 0;=0A=
>>>> +	stat->current_frequency =3D clk_get_rate(priv->clk);=0A=
>>>> +=0A=
>>>> +	return 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static void imx_devfreq_exit(struct device *dev)=0A=
>>>> +{=0A=
>>>> +	dev_pm_opp_of_remove_table(dev);=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx_devfreq_probe(struct platform_device *pdev)=0A=
>>>> +{=0A=
>>>> +	struct device *dev =3D &pdev->dev;=0A=
>>>> +	struct imx_devfreq *priv;=0A=
>>>=0A=
>>> How about changing the variable name 'priv' to 'imx' or 'imx_data'?=0A=
>>> because it is not easy to catch the role of 'priv' from variable name.=
=0A=
=0A=
The name "priv" refers to private data of current device: it is short =0A=
and not ambiguous in this context. I don't think that mentioning "imx" =0A=
adds any additional useful information.=0A=
=0A=
It doesn't seem like there's much of a convention for "local variable =0A=
containing private data", for example exynos-bus.c uses "struct =0A=
exynos_bus* bus" internally.=0A=
=0A=
>>>=0A=
>>>> +	const char *gov =3D DEVFREQ_GOV_USERSPACE;=0A=
>>>> +	void *govdata =3D NULL;=0A=
>>>=0A=
>>> How about changing the variable name 'govdata' to 'gov_data'?=0A=
>>> - govdata -> gov_data=0A=
=0A=
OK=0A=
=0A=
>>>> +	int ret;=0A=
>>>> +=0A=
>>>> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);=0A=
>>>> +	if (!priv)=0A=
>>>> +		return -ENOMEM;=0A=
>>>> +=0A=
>>>> +	priv->clk =3D devm_clk_get(dev, NULL);=0A=
>>>=0A=
>>> nitpick: because the clock-name is not mandatory.=0A=
>>> Don't need to specify the clock name to inform the role of clock=0A=
>>> of other developer/user?=0A=
>>>=0A=
>>> For example, "ddr", "bus" and so on.=0A=
=0A=
I'll call this bus, but I'm not sure it's useful when a single clock is =0A=
involved.=0A=
=0A=
>> And, this driver doesn't include the 'clk_prepare_enable'.=0A=
>> how to enable the clock?=0A=
=0A=
Clocks are either always on or perhaps controlled by some other =0A=
peripheral. This driver only provides scaling.=0A=
=0A=
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
>>>> +	priv->profile.target =3D imx_devfreq_target;=0A=
>>>> +	priv->profile.get_dev_status =3D imx_devfreq_get_dev_status;=0A=
>>>> +	priv->profile.exit =3D imx_devfreq_exit;=0A=
>>>> +	priv->profile.get_cur_freq =3D imx_devfreq_get_cur_freq;=0A=
>>>> +	priv->profile.initial_freq =3D clk_get_rate(priv->clk);=0A=
>>>> +=0A=
>>>> +	/* Handle passive devfreq parent link */=0A=
>>>> +	priv->passive_data.parent =3D devfreq_get_devfreq_by_phandle(dev, 0)=
;=0A=
>>>> +	if (!IS_ERR(priv->passive_data.parent)) {=0A=
>>>> +		dev_info(dev, "setup passive link to %s\n",=0A=
>>>> +			 dev_name(priv->passive_data.parent->dev.parent));=0A=
>>>> +		gov =3D DEVFREQ_GOV_PASSIVE;=0A=
>>>> +		govdata =3D &priv->passive_data;=0A=
>>>> +	} else if (priv->passive_data.parent !=3D ERR_PTR(-ENODEV)) {=0A=
>>>> +		// -ENODEV means no parent: not an error.=0A=
>>>> +		ret =3D PTR_ERR(priv->passive_data.parent);=0A=
>>>> +		if (ret !=3D -EPROBE_DEFER)=0A=
>>>> +			dev_warn(dev, "failed to get initialize passive parent: %d\n",=0A=
>>>> +				 ret);=0A=
>>>> +		goto err;=0A=
>>>> +	}=0A=
>>>=0A=
>>> You better to change the exception handling as following: It is more si=
mple.=0A=
>>>=0A=
>>> 	} else if (PTR_ERR(priv->passive_data.parent) =3D=3D -EPROBE_DEFER)=0A=
>>> 			|| PTR_ERR(priv->passive_data.parent) =3D=3D -ENODEV) {=0A=
>>> 		goto err;=0A=
>>> 	} else {=0A=
>>> 		ret =3D PTR_ERR(priv->passive_data.parent);=0A=
>>> 		dev_err(dev, "failed to get initialize passive parent: %d\n", ret);=
=0A=
>>> 		goto err;=0A=
>>> 	}=0A=
=0A=
But -ENODEV is not an error, it means no passive parent was found.=0A=
=0A=
>>>> +	priv->devfreq =3D devm_devfreq_add_device(dev, &priv->profile,=0A=
>>>> +						gov, govdata);=0A=
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
>>>> +static const struct of_device_id imx_devfreq_of_match[] =3D {=0A=
>>>> +	{ .compatible =3D "fsl,imx8m-noc", },=0A=
>>>> +	{ .compatible =3D "fsl,imx8m-nic", },=0A=
>>>> +	{ /* sentinel */ },=0A=
>>>> +};=0A=
>>>> +MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);=0A=
>>>> +=0A=
>>>> +static struct platform_driver imx_devfreq_platdrv =3D {=0A=
>>>> +	.probe		=3D imx_devfreq_probe,=0A=
>>>> +	.driver =3D {=0A=
>>>> +		.name	=3D "imx-devfreq",=0A=
>>>> +		.of_match_table =3D of_match_ptr(imx_devfreq_of_match),=0A=
>>>> +	},=0A=
>>>> +};=0A=
>>>> +module_platform_driver(imx_devfreq_platdrv);=0A=
>>>> +=0A=
>>>> +MODULE_DESCRIPTION("Generic i.MX bus frequency driver");=0A=
>>>=0A=
>>> If this driver is for bus frequency, you better to use 'bus' for the cl=
ock-name=0A=
>>> for the readability.=0A=
=0A=
OK=0A=
