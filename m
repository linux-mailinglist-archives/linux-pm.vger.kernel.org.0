Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE51243F7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 11:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRKKz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 05:10:55 -0500
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:33669
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfLRKKy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 05:10:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6HApREaDlW03sQlL/J5vZof/Ze1CsgeNPvKvMM8IekaYcRI93JjW55nhcRKQBu3f4fR2r7NpFAxWtrF/Tq9f1gVK9v+lynVuP84nt2MT2WO63UNXWYEMBVUHCBZIkSool8SquA1dWQPI/EnulmvlSrKEaXmLMljFLmV1RLxELTw+bjROwv2o9aDsOomAMITl563ZBtVMNQjji6+OvmeaQCGqekATttPxExKpaOI7ZKanGj6pAcVeUTObo8YWj1NEfhr25X7Ru3k7iqlSxICzBEFsJGPD6WsaMFEVBVnC818vwM5g2+p8cZEV2QigWJP/nizgX6qNx3qwOAmMLOIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3vZ5VTEfro/5zfF+x14NopQuC0XDBVQ+f6pKW8DLMA=;
 b=nY/fTFKEx93gP1eIY6T8ssdUmSRWICGlu3EEM+is+2vlpwHgNWMtJ9SP/LT0SJRcPSgnfJ+zVd7iZrmgGIzTQ75xk3vra4uagcqqFnqvNqMZQ7WgIpQlcp29aNr1aSvsVqLEE7xB1Ip4/lZVHfdGsb7pbyxumTb3kUtw2wIpvTc5hmRFi2gyzZDEp9DtJuf/dnmUpucXTlCZxN8dHPDxm0OySCclKr2eG07v6W39LokC8JeqJb617kpq3Zh6Mhq44FZxWOzelVZqZT9Sg9tw0kDtjRY9cEmjyqmtCBAZARcQbpd1FS3VH/v0GSq/gNBzcSJd8nevSUH9lcFtS6MWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3vZ5VTEfro/5zfF+x14NopQuC0XDBVQ+f6pKW8DLMA=;
 b=iPA66yGUiNSiqk7svTqYoX1rr9wEh+8oR1bAptMBbwfEpsc6edybHwP39mFv5iX+ZTKdFnPub+AQF48Y3pM5QqEnEaRxUfhywedVRkaZX5jw/XXrHBa5lq5Olk4BrBIYoLDivMbcnK6xMTjiDFoDxjEcedYsdMHujysGJqdW0vc=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4384.eurprd04.prod.outlook.com (20.177.55.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 10:10:44 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 10:10:44 +0000
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
Date:   Wed, 18 Dec 2019 10:10:44 +0000
Message-ID: <VI1PR04MB7023AE8CE3E05FE3E70D1FEEEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <CGME20191114201049epcas5p4a24607634af7b31e6a2dbdb4166dd862@epcas5p4.samsung.com>
 <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
 <8734a934-79e2-7445-c3e5-a0bb59afd4a8@samsung.com>
 <047990a5-263d-d447-7f0a-77a99e4b1f63@samsung.com>
 <25e3177f-e2b9-6be4-cfb8-24f87ccba45b@samsung.com>
 <VI1PR04MB702396D09FCED6CBA49B6AE7EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <698357b4-32e7-7f4b-3e67-59f5890f574a@samsung.com>
 <VI1PR04MB7023F0CCD7FAF5EEA74C7873EE500@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <f4267efa-1345-4fab-e6a7-73fca674dd72@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:500:9200:9d5e:ad7d:41e0:989]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c599b84c-590f-4f35-9fc5-08d783a28b86
x-ms-traffictypediagnostic: VI1PR04MB4384:|VI1PR04MB4384:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB438416867FB3196FC8BAA2ECEE530@VI1PR04MB4384.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(51444003)(52314003)(55016002)(5660300002)(8676002)(71200400001)(54906003)(8936002)(6506007)(7416002)(53546011)(316002)(81166006)(9686003)(110136005)(30864003)(81156014)(86362001)(66556008)(64756008)(76116006)(66446008)(33656002)(66476007)(91956017)(52536014)(478600001)(44832011)(4326008)(7696005)(186003)(2906002)(66946007)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4384;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q/leyaFsZQWYDGNYI9A1+V/M8ohVKViKfNJIqqzp4G9KxQQkgPNjoxZtgZ2+ZGqgqNHBnunuOJMWLBzDcfst/Nm9p4WSnUAhRU5KdC3hk3QhQMfggg127BsQrouxaJajwram7ijTAKpGTKJn8+VN6RoWsYCjIiGckpcpFguNRiskIzP4YihhnI2fFCvui7louj5TVEnzAGuFduB2HfcqBfjbfBjp4rhNykn7e1L5gC/4ss+FBF3yfANiXF6NLGkmxqoJXyRUUWFP0R8eEPne6GltDCAez7SpgJEtvfYwM4JkkyVMjBUM9FOlYg8BAfchr1lMor41r1MZx7QwMRiNOKLKExdDfV5RLTImYLfamkVcYcYkMTq3xkFRm4wsuoraH+J85m3XHVxyZToM6DUciAwNwNmBfNcIThqUQ0b3h+Lqh+/hXYdVuGhDTzm8sS4q8NjW2qb32OwzM4d+0Dbhd1UpAtmQaXWA5n9aaMrt+uSrz0pNh5t0d/nyYv3PYWa5JA03A4iFtrtLuDL8WwyJ80aBEwjywLk8h2aHINBp99w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c599b84c-590f-4f35-9fc5-08d783a28b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 10:10:44.3736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGkv2H1wHr6DNqfo5VaUPaLg9AKnGmfcBplssF5Cb5ohIfwv+56Ml9FhozzjVtTGQN5W/YJqGRjO4MFGr85uJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4384
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18.12.2019 05:08, Chanwoo Choi wrote:=0A=
> On 12/18/19 6:05 AM, Leonard Crestez wrote:=0A=
>> On 17.12.2019 02:35, Chanwoo Choi wrote:=0A=
>>> On 12/16/19 11:57 PM, Leonard Crestez wrote:=0A=
>>>> On 16.12.2019 03:00, Chanwoo Choi wrote:=0A=
>>>>> Hi,=0A=
>>>>>=0A=
>>>>> Also, I think that 'devfreq' word is not proper for device driver nam=
e.=0A=
>>>>> imx-bus.c or imx-noc.c or others to inform the role of this driver of=
 developer.=0A=
>>>>=0A=
>>>> I'll rename to "imx-bus". Calling it "imx-noc" is not appropriate=0A=
>>>> because I also want to use it for PL301 NICs.=0A=
>>>=0A=
>>> OK.=0A=
>>>=0A=
>>>>=0A=
>>>>> And, I have a question.=0A=
>>>>> This driver adds the devfreq device with either passive governor=0A=
>>>>> or userspace governor.=0A=
>>>>>=0A=
>>>>> As I understood, the devfreq device with passive governor=0A=
>>>>> will be operated with imx8m-ddrc.c driver.=0A=
>>>>> But, when is operating with userspace governor?=0A=
>>>>=0A=
>>>> There are multiple scalable buses inside the SOC, for example there's =
a=0A=
>>>> NIC for display controllers and one for (pci+usb). They can use=0A=
>>>> userspace governor for explicit frequency control.=0A=
>>>>=0A=
>>>>> I think that you better to add the explanation to description=0A=
>>>>> for two scenarios how to operate with interconnect provider=0A=
>>>>> on either passive governor or userspace governor usage case.=0A=
>>>>=0A=
>>>> I'll elaborate the example in bindings.=0A=
>>>=0A=
>>> OK.=0A=
>>>=0A=
>>>>=0A=
>>>>> On 12/13/19 10:51 AM, Chanwoo Choi wrote:=0A=
>>>>>> On 12/13/19 10:30 AM, Chanwoo Choi wrote:=0A=
>>>>>>> Hi,=0A=
>>>>>>>=0A=
>>>>>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:=0A=
>>>>>>>> Add initial support for dynamic frequency switching on pieces of t=
he imx=0A=
>>>>>>>> interconnect fabric.=0A=
>>>>>>>>=0A=
>>>>>>>> All this driver does is set a clk rate based on an opp table, it d=
oes=0A=
>>>>>>>> not map register areas.=0A=
>>>>>>>>=0A=
>>>>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>>>>>> ---=0A=
>>>>>>>>     drivers/devfreq/Kconfig       |   9 ++=0A=
>>>>>>>>     drivers/devfreq/Makefile      |   1 +=0A=
>>>>>>>>     drivers/devfreq/imx-devfreq.c | 150 ++++++++++++++++++++++++++=
++++++++=0A=
>>>>>>>>     3 files changed, 160 insertions(+)=0A=
>>>>>>>>     create mode 100644 drivers/devfreq/imx-devfreq.c=0A=
>>>>>>>>=0A=
>>>>>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig=0A=
>>>>>>>> index 923a6132e741..fef5ce831e90 100644=0A=
>>>>>>>> --- a/drivers/devfreq/Kconfig=0A=
>>>>>>>> +++ b/drivers/devfreq/Kconfig=0A=
>>>>>>>> @@ -98,10 +98,19 @@ config ARM_IMX8M_DDRC_DEVFREQ=0A=
>>>>>>>>     	select DEVFREQ_GOV_USERSPACE=0A=
>>>>>>>>     	help=0A=
>>>>>>>>     	  This adds the DEVFREQ driver for the i.MX8M DDR Controller.=
 It allows=0A=
>>>>>>>>     	  adjusting DRAM frequency.=0A=
>>>>>>>>     =0A=
>>>>>>>> +config ARM_IMX_DEVFREQ=0A=
>>>>>>>> +	tristate "i.MX Generic DEVFREQ Driver"=0A=
>>>>>>>> +	depends on ARCH_MXC || COMPILE_TEST=0A=
>>>>>>>> +	select DEVFREQ_GOV_PASSIVE=0A=
>>>>>>>> +	select DEVFREQ_GOV_USERSPACE=0A=
>>>>>>>> +	help=0A=
>>>>>>>> +	  This adds the generic DEVFREQ driver for i.MX interconnects. I=
t=0A=
>>>>>>>> +	  allows adjusting NIC/NOC frequency.=0A=
>>>>>>>> +=0A=
>>>>>>>>     config ARM_TEGRA_DEVFREQ=0A=
>>>>>>>>     	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"=0A=
>>>>>>>>     	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \=0A=
>>>>>>>>     		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \=0A=
>>>>>>>>     		ARCH_TEGRA_210_SOC || \=0A=
>>>>>>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile=
=0A=
>>>>>>>> index 3eb4d5e6635c..61d0edee16f7 100644=0A=
>>>>>>>> --- a/drivers/devfreq/Makefile=0A=
>>>>>>>> +++ b/drivers/devfreq/Makefile=0A=
>>>>>>>> @@ -8,10 +8,11 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governo=
r_userspace.o=0A=
>>>>>>>>     obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=3D governor_passive.o=0A=
>>>>>>>>     =0A=
>>>>>>>>     # DEVFREQ Drivers=0A=
>>>>>>>>     obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o=0A=
>>>>>>>>     obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+=3D imx8m-ddrc.o=0A=
>>>>>>>> +obj-$(CONFIG_ARM_IMX_DEVFREQ)		+=3D imx-devfreq.o=0A=
>>>>>>>>     obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+=3D rk3399_dmc.o=0A=
>>>>>>>>     obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra30-devfreq.o=0A=
>>>>>>>>     obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+=3D tegra20-devfreq.o=0A=
>>>>>>>>     =0A=
>>>>>>>>     # DEVFREQ Event Drivers=0A=
>>>>>>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-d=
evfreq.c=0A=
>>>>>>>> new file mode 100644=0A=
>>>>>>>> index 000000000000..620b344e87aa=0A=
>>>>>>>> --- /dev/null=0A=
>>>>>>>> +++ b/drivers/devfreq/imx-devfreq.c=0A=
>>>>>>>> @@ -0,0 +1,150 @@=0A=
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0=0A=
>>>>>>>> +/*=0A=
>>>>>>>> + * Copyright 2019 NXP=0A=
>>>>>>>> + */=0A=
>>>>>>>> +=0A=
>>>>>>>> +#include <linux/clk.h>=0A=
>>>>>>>> +#include <linux/devfreq.h>=0A=
>>>>>>>> +#include <linux/device.h>=0A=
>>>>>>>> +#include <linux/module.h>=0A=
>>>>>>>> +#include <linux/of_device.h>=0A=
>>>>>>>> +#include <linux/pm_opp.h>=0A=
>>>>>>>> +#include <linux/platform_device.h>=0A=
>>>>>>>> +#include <linux/slab.h>=0A=
>>>>>>>> +=0A=
>>>>>>>> +struct imx_devfreq {=0A=
>>>>>>>> +	struct devfreq_dev_profile profile;=0A=
>>>>>>>> +	struct devfreq *devfreq;=0A=
>>>>>>>> +	struct clk *clk;=0A=
>>>>>>>> +	struct devfreq_passive_data passive_data;=0A=
>>>>>>>> +};=0A=
>>>>>>>> +=0A=
>>>>>>>> +static int imx_devfreq_target(struct device *dev,=0A=
>>>>>>>> +			      unsigned long *freq, u32 flags)=0A=
>>>>>>>=0A=
>>>>>>> Don't use space for the indentation. Please use only tab.=0A=
>>>>=0A=
>>>> OK=0A=
>>=0A=
>> The spaces are required in order to align arguments to open paranthesis.=
=0A=
>> Should I drop that?=0A=
>>=0A=
>> It seems that check_patch.pl and process/coding-style.rst doesn't have a=
=0A=
>> strong opinion on this; my personal preference is for long argument=0A=
>> lists to just use double indentation.=0A=
> =0A=
> Generally, almost patches use the tab for the indentation.=0A=
> I don't use space for the indentation. If use the tab=0A=
> for the indentation, it is not harmful for the readability.=0A=
> =0A=
> If use the space for the pretty to make the alignment between parameter,=
=0A=
> I think it it not good.=0A=
=0A=
OK, I'll just use two tabs. This also matches my personal preference.=0A=
=0A=
>>>>>>>> +{=0A=
>>>>>>>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
>>>>>>>> +	struct dev_pm_opp *new_opp;=0A=
>>>>>>>> +	unsigned long new_freq;=0A=
>>>>>>>> +	int ret;=0A=
>>>>>>>> +=0A=
>>>>>>>> +	new_opp =3D devfreq_recommended_opp(dev, freq, flags);=0A=
>>>>>>>> +	if (IS_ERR(new_opp)) {=0A=
>>>>>>>> +		ret =3D PTR_ERR(new_opp);=0A=
>>>>>>>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);=0A=
>>>>>>>> +		return ret;=0A=
>>>>>>>> +	}=0A=
>>>>>>>> +	new_freq =3D dev_pm_opp_get_freq(new_opp);=0A=
>>>>>>>> +	dev_pm_opp_put(new_opp);=0A=
>>>>>>>> +=0A=
>>>>>>>> +	return clk_set_rate(priv->clk, new_freq);=0A=
>>>>>>>> +}=0A=
>>>>>>>> +=0A=
>>>>>>>> +static int imx_devfreq_get_cur_freq(struct device *dev, unsigned =
long *freq)=0A=
>>>>>>>> +{=0A=
>>>>>>>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
>>>>>>>> +=0A=
>>>>>>>> +	*freq =3D clk_get_rate(priv->clk);=0A=
>>>>>>>> +=0A=
>>>>>>>> +	return 0;=0A=
>>>>>>>> +}=0A=
>>>>>>>> +=0A=
>>>>>>>> +static int imx_devfreq_get_dev_status(struct device *dev,=0A=
>>>>>>>> +				      struct devfreq_dev_status *stat)=0A=
>>>>>>>=0A=
>>>>>>> ditto. Please use tab for the indentation.=0A=
>>>>>>>=0A=
>>>>>>>> +{=0A=
>>>>>>>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
>>>>>>>> +=0A=
>>>>>>>> +	stat->busy_time =3D 0;=0A=
>>>>>>>> +	stat->total_time =3D 0;=0A=
>>>>>>>> +	stat->current_frequency =3D clk_get_rate(priv->clk);=0A=
>>>>>>>> +=0A=
>>>>>>>> +	return 0;=0A=
>>>>>>>> +}=0A=
>>>>>>>> +=0A=
>>>>>>>> +static void imx_devfreq_exit(struct device *dev)=0A=
>>>>>>>> +{=0A=
>>>>>>>> +	dev_pm_opp_of_remove_table(dev);=0A=
>>>>>>>> +}=0A=
>>>>>>>> +=0A=
>>>>>>>> +static int imx_devfreq_probe(struct platform_device *pdev)=0A=
>>>>>>>> +{=0A=
>>>>>>>> +	struct device *dev =3D &pdev->dev;=0A=
>>>>>>>> +	struct imx_devfreq *priv;=0A=
>>>>>>>=0A=
>>>>>>> How about changing the variable name 'priv' to 'imx' or 'imx_data'?=
=0A=
>>>>>>> because it is not easy to catch the role of 'priv' from variable na=
me.=0A=
>>>>=0A=
>>>> The name "priv" refers to private data of current device: it is short=
=0A=
>>>> and not ambiguous in this context. I don't think that mentioning "imx"=
=0A=
>>>> adds any additional useful information.=0A=
>>>>=0A=
>>>> It doesn't seem like there's much of a convention for "local variable=
=0A=
>>>> containing private data", for example exynos-bus.c uses "struct=0A=
>>>> exynos_bus* bus" internally.=0A=
>>>=0A=
>>> OK. it is nitpick. Keep your style.=0A=
>>>=0A=
>>>>=0A=
>>>>>>>=0A=
>>>>>>>> +	const char *gov =3D DEVFREQ_GOV_USERSPACE;=0A=
>>>>>>>> +	void *govdata =3D NULL;=0A=
>>>>>>>=0A=
>>>>>>> How about changing the variable name 'govdata' to 'gov_data'?=0A=
>>>>>>> - govdata -> gov_data=0A=
>>>>=0A=
>>>> OK=0A=
>>>>=0A=
>>>>>>>> +	int ret;=0A=
>>>>>>>> +=0A=
>>>>>>>> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);=0A=
>>>>>>>> +	if (!priv)=0A=
>>>>>>>> +		return -ENOMEM;=0A=
>>>>>>>> +=0A=
>>>>>>>> +	priv->clk =3D devm_clk_get(dev, NULL);=0A=
>>>>>>>=0A=
>>>>>>> nitpick: because the clock-name is not mandatory.=0A=
>>>>>>> Don't need to specify the clock name to inform the role of clock=0A=
>>>>>>> of other developer/user?=0A=
>>>>>>>=0A=
>>>>>>> For example, "ddr", "bus" and so on.=0A=
>>>>=0A=
>>>> I'll call this bus, but I'm not sure it's useful when a single clock i=
s=0A=
>>>> involved.=0A=
>>>>=0A=
>>>>>> And, this driver doesn't include the 'clk_prepare_enable'.=0A=
>>>>>> how to enable the clock?=0A=
>>>>=0A=
>>>> Clocks are either always on or perhaps controlled by some other=0A=
>>>> peripheral. This driver only provides scaling.=0A=
>>>=0A=
>>> It is not proper use-case of clock. If device driver=0A=
>>> want to control the clock, it have to be enabled on device driver.=0A=
>>=0A=
>>> Even it clock is always, the user don't know the state of clock.=0A=
>>> Also, user can't know what kind of device driver control the clock.=0A=
>>>=0A=
>>> It have to be controlled on this device driver=0A=
>>> before changing the clock frequency.=0A=
>>=0A=
>>   From clock framework perspective prepare/enable and rate bits can be=
=0A=
>> controlled separately.=0A=
>>=0A=
>> Many peripherals are grouped with their own bus (for example a PL301=0A=
>> NIC) which is normally off and only gets enabled when explicitly=0A=
>> requested by drivers. If this devfreq driver always enabled bus clocks=
=0A=
>> then it would waste power for no reason.=0A=
> =0A=
> You can save the power with following sequence.=0A=
> You are keeping the following sequence without any problem.=0A=
> 	clk_prepare_enable()=0A=
> 	clk_set_rate()=0A=
> 	clk_disable_unprepare()=0A=
> =0A=
> clk API support the reference count for the clock user.=0A=
> It doesn't affect the any behavior of other device sharing the bus clock=
=0A=
> and waste any power-consumption because it will always restore=0A=
> the reference count after changing the clock rate.=0A=
=0A=
But this doesn't serve any purpose?=0A=
=0A=
In some cases (depending on clock flags like CLK_SET_RATE_GATE or =0A=
CLK_SET_RATE_UNGATE flags) the clk_set_rate function can require than =0A=
clocks are either on or off and otherwise return an error.=0A=
=0A=
For imx bus clocks there is no such requirement.=0A=
=0A=
>> For example a display controller will first enable clocks to allow=0A=
>> access to device registers, then configure a resolution and make a=0A=
>> bandwith request which gets translated a min_freq request. Then when the=
=0A=
>> display is blanked the entire display bus should be powered off, even if=
=0A=
>> this makes control registers inaccessible.=0A=
>>=0A=
>> This series only enables scaling for the main NOC which can't be turned=
=0A=
>> off anyway.=0A=
>>=0A=
>>>>>>>> +	if (IS_ERR(priv->clk)) {=0A=
>>>>>>>> +		ret =3D PTR_ERR(priv->clk);=0A=
>>>>>>>> +		dev_err(dev, "failed to fetch clk: %d\n", ret);=0A=
>>>>>>>> +		return ret;=0A=
>>>>>>>> +	}=0A=
>>>>>>>> +	platform_set_drvdata(pdev, priv);=0A=
>>>>>>>> +=0A=
>>>>>>>> +	ret =3D dev_pm_opp_of_add_table(dev);=0A=
>>>>>>>> +	if (ret < 0) {=0A=
>>>>>>>> +		dev_err(dev, "failed to get OPP table\n");=0A=
>>>>>>>> +		return ret;=0A=
>>>>>>>> +	}=0A=
>>>>>>>> +=0A=
>>>>>>>> +	priv->profile.polling_ms =3D 1000;=0A=
>>>>>>>> +	priv->profile.target =3D imx_devfreq_target;=0A=
>>>>>>>> +	priv->profile.get_dev_status =3D imx_devfreq_get_dev_status;=0A=
>>>>>>>> +	priv->profile.exit =3D imx_devfreq_exit;=0A=
>>>>>>>> +	priv->profile.get_cur_freq =3D imx_devfreq_get_cur_freq;=0A=
>>>>>>>> +	priv->profile.initial_freq =3D clk_get_rate(priv->clk);=0A=
>>>>>>>> +=0A=
>>>>>>>> +	/* Handle passive devfreq parent link */=0A=
>>>>>>>> +	priv->passive_data.parent =3D devfreq_get_devfreq_by_phandle(dev=
, 0);=0A=
>>>>>>>> +	if (!IS_ERR(priv->passive_data.parent)) {=0A=
>>>>>>>> +		dev_info(dev, "setup passive link to %s\n",=0A=
>>>>>>>> +			 dev_name(priv->passive_data.parent->dev.parent));=0A=
>>>>>>>> +		gov =3D DEVFREQ_GOV_PASSIVE;=0A=
>>>>>>>> +		govdata =3D &priv->passive_data;=0A=
>>>>>>>> +	} else if (priv->passive_data.parent !=3D ERR_PTR(-ENODEV)) {=0A=
>>>>>>>> +		// -ENODEV means no parent: not an error.=0A=
>>>>>>>> +		ret =3D PTR_ERR(priv->passive_data.parent);=0A=
>>>>>>>> +		if (ret !=3D -EPROBE_DEFER)=0A=
>>>>>>>> +			dev_warn(dev, "failed to get initialize passive parent: %d\n",=
=0A=
>>>>>>>> +				 ret);=0A=
>>>>>>>> +		goto err;=0A=
>>>>>>>> +	}=0A=
>>>>>>>=0A=
>>>>>>> You better to change the exception handling as following: It is mor=
e simple.=0A=
>>>>>>>=0A=
>>>>>>> 	} else if (PTR_ERR(priv->passive_data.parent) =3D=3D -EPROBE_DEFER=
)=0A=
>>>>>>> 			|| PTR_ERR(priv->passive_data.parent) =3D=3D -ENODEV) {=0A=
>>>>>>> 		goto err;=0A=
>>>>>>> 	} else {=0A=
>>>>>>> 		ret =3D PTR_ERR(priv->passive_data.parent);=0A=
>>>>>>> 		dev_err(dev, "failed to get initialize passive parent: %d\n", ret=
);=0A=
>>>>>>> 		goto err;=0A=
>>>>>>> 	}=0A=
>>>>=0A=
>>>> But -ENODEV is not an error, it means no passive parent was found.=0A=
>>>=0A=
>>> OK. just I want to make 'if statement' more simple. This style=0A=
>>> is complicated.=0A=
>>=0A=
>> I can avoid handling EPROBE_DEFER in a nested if.=0A=
> =0A=
> Anyway, if you make the exception more simple, I'm ok.=0A=
> =0A=
>>=0A=
>>>>>>>> +	priv->devfreq =3D devm_devfreq_add_device(dev, &priv->profile,=
=0A=
>>>>>>>> +						gov, govdata);=0A=
>>>>>>>> +	if (IS_ERR(priv->devfreq)) {=0A=
>>>>>>>> +		ret =3D PTR_ERR(priv->devfreq);=0A=
>>>>>>>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);=0A=
>>>>>>>> +		goto err;=0A=
>>>>>>>> +	}=0A=
>>>>>>>> +=0A=
>>>>>>>> +	return 0;=0A=
>>>>>>>> +=0A=
>>>>>>>> +err:=0A=
>>>>>>>> +	dev_pm_opp_of_remove_table(dev);=0A=
>>>>>>>> +	return ret;=0A=
>>>>>>>> +}=0A=
>>>>>>>> +=0A=
>>>>>>>> +static const struct of_device_id imx_devfreq_of_match[] =3D {=0A=
>>>>>>>> +	{ .compatible =3D "fsl,imx8m-noc", },=0A=
>>>>>>>> +	{ .compatible =3D "fsl,imx8m-nic", },=0A=
>>>>>>>> +	{ /* sentinel */ },=0A=
>>>>>>>> +};=0A=
>>>>>>>> +MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);=0A=
>>>>>>>> +=0A=
>>>>>>>> +static struct platform_driver imx_devfreq_platdrv =3D {=0A=
>>>>>>>> +	.probe		=3D imx_devfreq_probe,=0A=
>>>>>>>> +	.driver =3D {=0A=
>>>>>>>> +		.name	=3D "imx-devfreq",=0A=
>>>>>>>> +		.of_match_table =3D of_match_ptr(imx_devfreq_of_match),=0A=
>>>>>>>> +	},=0A=
>>>>>>>> +};=0A=
>>>>>>>> +module_platform_driver(imx_devfreq_platdrv);=0A=
>>>>>>>> +=0A=
>>>>>>>> +MODULE_DESCRIPTION("Generic i.MX bus frequency driver");=0A=
>>>>>>>=0A=
>>>>>>> If this driver is for bus frequency, you better to use 'bus' for th=
e clock-name=0A=
>>>>>>> for the readability.=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
