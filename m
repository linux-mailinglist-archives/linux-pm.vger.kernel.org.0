Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0382100783
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKROhY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 09:37:24 -0500
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:5779
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726739AbfKROhY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Nov 2019 09:37:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNUTUO01miyJs/aeiyZvuztwM36efjfkZYyEYar67cFJIKE1ukISTV/gUJ05VB2W3ilU74UB75xJhYzf8lzAKJIZmcUIalNraCXg5kzesjvnNlDJtX4p5h5tdn/aVeaFoLOE7KeIpBSc5CL3ije52UC2BYf0VmSaRhW6lFXAeECu+qejkZjn5aX+aQ/30A+S2rMZOomYT4mHnRnVOxw7yojKxf0kDj6Yxr3K2rqICp4Roc1vGKf5VTjJ10y6j1OtyiDiTnqV0p8+dhTmkHrJZRGqsWynEdjzojSJxmk4LbiH93DBItQ42MNt3KcLLwdhrS1Lvt3dhOpAMoE2tBvUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOSdlPc0NauEtCCORsdWYnmQA8S1kFLnsrlYsuEPICU=;
 b=LTCygsSM+cwn7v2XkjyJc4l4uz3SktEE/RATtUR14ELiBgy0ymP52JheObSVQ2K+w208n2wsZlYVB/6Jm2CmbuLci5uyYpEbqhFKLkHBs+rrYP9yy2JQNne5yJLv6EGovFBJ+GypFwa7sot85hTD0/RCXRE5vMBvfjv9VqbhvD3JuMrMSayz+SxonkT73g6NHQk/dALJZYuVhxDkG5Am3oZx0CPOL7jqY3Mgt5p5G657CQ2vlkMojjg/JRTcw4edrqIvgyEZtRB2GLQOCtBgfznei5HCETe5yUU2eFWV34kqeYfLQxf5s4roei2Pi4piRgoh6Op903mFO/oS/CM03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOSdlPc0NauEtCCORsdWYnmQA8S1kFLnsrlYsuEPICU=;
 b=REzZO+NvGdH+H99loECYP+HwI5VMwEhv+xezjc/+DM0l41dZHNC9ZWZ/qo4POqG3oqm3vFV6pC+C24dB9Reu8T/9lFxQilCGNfGRuLZcP+yzi+N3z9cXHRytrTRKIvH/GiwRPGs5Jue/F2tcNCEjw52P/9AmzALdG0fbzDtlGOw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6189.eurprd04.prod.outlook.com (20.179.27.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Mon, 18 Nov 2019 14:37:12 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 14:37:12 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Thread-Topic: [PATCH v6 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Thread-Index: AQHVmxoGYJ8XuY6e4EKoz+zZoN9ijg==
Date:   Mon, 18 Nov 2019 14:37:12 +0000
Message-ID: <VI1PR04MB7023C4B9CF43BA2EB2D6A66BEE4D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573756360.git.leonard.crestez@nxp.com>
 <CGME20191114183341epcas1p362ecf4d86e6bdb9352f2a4b932f3204e@epcas1p3.samsung.com>
 <3b1341a9a0c0dcaae1f37aebff25b773db7429cf.1573756360.git.leonard.crestez@nxp.com>
 <b0146aad-f9f5-875e-74aa-5afc4ccafb2e@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c951343c-a9b1-428d-187c-08d76c34ccd4
x-ms-traffictypediagnostic: VI1PR04MB6189:|VI1PR04MB6189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB61896CBEBE4922551F8BD34DEE4D0@VI1PR04MB6189.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(189003)(199004)(14444005)(74316002)(229853002)(99286004)(33656002)(76116006)(25786009)(110136005)(53546011)(102836004)(54906003)(76176011)(9686003)(6306002)(478600001)(6636002)(66476007)(66946007)(55016002)(66556008)(64756008)(66446008)(4326008)(6246003)(7696005)(2906002)(256004)(14454004)(91956017)(5660300002)(66066001)(6436002)(30864003)(6506007)(6116002)(86362001)(52536014)(8936002)(4001150100001)(966005)(486006)(3846002)(446003)(476003)(44832011)(26005)(7736002)(186003)(316002)(8676002)(81166006)(305945005)(71200400001)(71190400001)(7416002)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6189;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQmnPn2RnblC6OrX+6CPGN2M2TjfRwvZqQpoj0R7UjDgIg2WUKZX02ErJmqpkjuG9BJNAbj9lkwsKvQqMN0DykQiA+nHh5GDAxyCMJ/2LnsH3V4H4dqHWh3BF4J2AYEbGkGyNZaBEFHlAWSt/6FeBSGEuyZ+QL47VYdsRSCAiO2izDizf8wQjt4JJkz1SL3TJra12r3iyAzjJ1+NaaiqrDuRW4r6KLMQmfVvFgehKDtNVxkjEHIjEUnd6AEyHTMPEsft1DzCUIyx+1jVxX/jd04dHC2rHjeb0Y6Gpq9Bhc/Gtnyc8EqxHoZK7hhYemmBac+JOcETXxPQW0OrLkHZCtlNz0mFYk2KDrVJD13s3sdeiNs5TASHdReBIBWmjOcHJGXBqKvQLEsnkg3vA6oi5luT6D7fih37eh5Tg12ZLUVdlZqtFTCxqp0pPRByCMjW
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c951343c-a9b1-428d-187c-08d76c34ccd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 14:37:12.5192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HppPCE0phn5eE/QZsgpeQ6s4ZSpR2xZeqeinkioY7ENIMrrKFPWj6Dr6tRti2YAlzhPWS7LC/u3PgZR7iS/wUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6189
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-11-15 3:26 AM, Chanwoo Choi wrote:=0A=
> After reviewing the dt-binding patch from DT maintainer,=0A=
> I'll take patch3/patch4 to devfreq git.=0A=
> =0A=
> Or, Should I have to finish the review of patch1/patch2?=0A=
Patches 1/2 were already reviewed but they conflict with other pending =0A=
series doing clk_hw cleanups:=0A=
=0A=
     https://patchwork.kernel.org/cover/11224933/=0A=
     https://patchwork.kernel.org/cover/11217881/=0A=
=0A=
Those cleanups would conflict with most imx8m clk changes, it might make =
=0A=
sense to wait for them to enter first and then I'll send a v7 of devfreq =
=0A=
with solved conflicts and collected acks.=0A=
=0A=
Shawn / Stephen: How should we proceed?=0A=
=0A=
> Regards,=0A=
> Chanwoo Choi=0A=
> =0A=
> On 11/15/19 3:33 AM, Leonard Crestez wrote:=0A=
>> Add driver for dynamic scaling the DDR Controller on imx8m chips. Actual=
=0A=
>> frequency switching is implemented inside TF-A, this driver wraps the=0A=
>> SMC calls and synchronizes the clk tree.=0A=
>>=0A=
>> The DRAM clocks on imx8m have the following structure (abridged):=0A=
>>=0A=
>>   +----------+       |\            +------+=0A=
>>   | dram_pll |-------|M| dram_core |      |=0A=
>>   +----------+       |U|---------->| D    |=0A=
>>                   /--|X|           |  D   |=0A=
>>     dram_alt_root |  |/            |   R  |=0A=
>>                   |                |    C |=0A=
>>              +---------+           |      |=0A=
>>              |FIX DIV/4|           |      |=0A=
>>              +---------+           |      |=0A=
>>    composite:     |                |      |=0A=
>>   +----------+    |                |      |=0A=
>>   | dram_alt |----/                |      |=0A=
>>   +----------+                     |      |=0A=
>>   | dram_apb |-------------------->|      |=0A=
>>   +----------+                     +------+=0A=
>>=0A=
>> The dram_pll is used for higher rates and dram_alt is used for lower=0A=
>> rates. The dram_alt and dram_apb clocks are "imx composite" and their=0A=
>> parent can also be modified.=0A=
>>=0A=
>> This driver will prepare/enable the new parents ahead of switching (so=
=0A=
>> that the expected roots are enabled) and afterwards it will call=0A=
>> clk_set_parent to ensure the parents in clock framework are up-to-date.=
=0A=
>>=0A=
>> The driver relies on dram_pll dram_alt and dram_apb being marked with=0A=
>> CLK_GET_RATE_NOCACHE for rate updates.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/devfreq/Kconfig      |   9 +=0A=
>>   drivers/devfreq/Makefile     |   1 +=0A=
>>   drivers/devfreq/imx8m-ddrc.c | 465 +++++++++++++++++++++++++++++++++++=
=0A=
>>   3 files changed, 475 insertions(+)=0A=
>>   create mode 100644 drivers/devfreq/imx8m-ddrc.c=0A=
>>=0A=
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig=0A=
>> index 066e6c4efaa2..923a6132e741 100644=0A=
>> --- a/drivers/devfreq/Kconfig=0A=
>> +++ b/drivers/devfreq/Kconfig=0A=
>> @@ -89,10 +89,19 @@ config ARM_EXYNOS_BUS_DEVFREQ=0A=
>>   	  Each memory bus group could contain many memoby bus block. It reads=
=0A=
>>   	  PPMU counters of memory controllers by using DEVFREQ-event device=
=0A=
>>   	  and adjusts the operating frequencies and voltages with OPP support=
.=0A=
>>   	  This does not yet operate with optimal voltages.=0A=
>>   =0A=
>> +config ARM_IMX8M_DDRC_DEVFREQ=0A=
>> +	tristate "i.MX8M DDRC DEVFREQ Driver"=0A=
>> +	depends on ARCH_MXC || COMPILE_TEST=0A=
>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND=0A=
>> +	select DEVFREQ_GOV_USERSPACE=0A=
>> +	help=0A=
>> +	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allow=
s=0A=
>> +	  adjusting DRAM frequency.=0A=
>> +=0A=
>>   config ARM_TEGRA_DEVFREQ=0A=
>>   	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"=0A=
>>   	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \=0A=
>>   		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \=0A=
>>   		ARCH_TEGRA_210_SOC || \=0A=
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile=0A=
>> index 338ae8440db6..3eb4d5e6635c 100644=0A=
>> --- a/drivers/devfreq/Makefile=0A=
>> +++ b/drivers/devfreq/Makefile=0A=
>> @@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+=3D governor_powe=
rsave.o=0A=
>>   obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor_userspace.o=0A=
>>   obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=3D governor_passive.o=0A=
>>   =0A=
>>   # DEVFREQ Drivers=0A=
>>   obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o=0A=
>> +obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+=3D imx8m-ddrc.o=0A=
>>   obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+=3D rk3399_dmc.o=0A=
>>   obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra30-devfreq.o=0A=
>>   obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+=3D tegra20-devfreq.o=0A=
>>   =0A=
>>   # DEVFREQ Event Drivers=0A=
>> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c=
=0A=
>> new file mode 100644=0A=
>> index 000000000000..fea169619c59=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/devfreq/imx8m-ddrc.c=0A=
>> @@ -0,0 +1,465 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +/*=0A=
>> + * Copyright 2019 NXP=0A=
>> + */=0A=
>> +=0A=
>> +#include <linux/module.h>=0A=
>> +#include <linux/device.h>=0A=
>> +#include <linux/of_device.h>=0A=
>> +#include <linux/platform_device.h>=0A=
>> +#include <linux/devfreq.h>=0A=
>> +#include <linux/pm_opp.h>=0A=
>> +#include <linux/clk.h>=0A=
>> +#include <linux/clk-provider.h>=0A=
>> +#include <linux/arm-smccc.h>=0A=
>> +=0A=
>> +#define IMX_SIP_DDR_DVFS			0xc2000004=0A=
>> +=0A=
>> +/* Values starting from 0 switch to specific frequency */=0A=
>> +#define IMX_SIP_DDR_FREQ_SET_HIGH		0x00=0A=
>> +=0A=
>> +/* Deprecated after moving IRQ handling to ATF */=0A=
>> +#define IMX_SIP_DDR_DVFS_WAIT_CHANGE		0x0F=0A=
>> +=0A=
>> +/* Query available frequencies. */=0A=
>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_COUNT		0x10=0A=
>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_INFO		0x11=0A=
>> +=0A=
>> +/*=0A=
>> + * This should be in a 1:1 mapping with devicetree OPPs but=0A=
>> + * firmware provides additional info.=0A=
>> + */=0A=
>> +struct imx8m_ddrc_freq {=0A=
>> +	unsigned long rate;=0A=
>> +	unsigned long smcarg;=0A=
>> +	int dram_core_parent_index;=0A=
>> +	int dram_alt_parent_index;=0A=
>> +	int dram_apb_parent_index;=0A=
>> +};=0A=
>> +=0A=
>> +/* Hardware limitation */=0A=
>> +#define IMX8M_DDRC_MAX_FREQ_COUNT 4=0A=
>> +=0A=
>> +/*=0A=
>> + * i.MX8M DRAM Controller clocks have the following structure (abridged=
):=0A=
>> + *=0A=
>> + * +----------+       |\            +------+=0A=
>> + * | dram_pll |-------|M| dram_core |      |=0A=
>> + * +----------+       |U|---------->| D    |=0A=
>> + *                 /--|X|           |  D   |=0A=
>> + *   dram_alt_root |  |/            |   R  |=0A=
>> + *                 |                |    C |=0A=
>> + *            +---------+           |      |=0A=
>> + *            |FIX DIV/4|           |      |=0A=
>> + *            +---------+           |      |=0A=
>> + *  composite:     |                |      |=0A=
>> + * +----------+    |                |      |=0A=
>> + * | dram_alt |----/                |      |=0A=
>> + * +----------+                     |      |=0A=
>> + * | dram_apb |-------------------->|      |=0A=
>> + * +----------+                     +------+=0A=
>> + *=0A=
>> + * The dram_pll is used for higher rates and dram_alt is used for lower=
 rates.=0A=
>> + *=0A=
>> + * Frequency switching is implemented in TF-A (via SMC call) and can ch=
ange the=0A=
>> + * configuration of the clocks, including mux parents. The dram_alt and=
=0A=
>> + * dram_apb clocks are "imx composite" and their parent can change too.=
=0A=
>> + *=0A=
>> + * We need to prepare/enable the new mux parents head of switching and =
update=0A=
>> + * their information afterwards.=0A=
>> + */=0A=
>> +struct imx8m_ddrc {=0A=
>> +	struct devfreq_dev_profile profile;=0A=
>> +	struct devfreq *devfreq;=0A=
>> +=0A=
>> +	/* For frequency switching: */=0A=
>> +	struct clk *dram_core;=0A=
>> +	struct clk *dram_pll;=0A=
>> +	struct clk *dram_alt;=0A=
>> +	struct clk *dram_apb;=0A=
>> +=0A=
>> +	int freq_count;=0A=
>> +	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];=0A=
>> +};=0A=
>> +=0A=
>> +static struct imx8m_ddrc_freq *imx8m_ddrc_find_freq(struct imx8m_ddrc *=
priv,=0A=
>> +						    unsigned long rate)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc_freq *freq;=0A=
>> +	int i;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Firmware reports values in MT/s, so we round-down from Hz=0A=
>> +	 * Rounding is extra generous to ensure a match.=0A=
>> +	 */=0A=
>> +	rate =3D DIV_ROUND_CLOSEST(rate, 250000);=0A=
>> +	for (i =3D 0; i < priv->freq_count; ++i) {=0A=
>> +		freq =3D &priv->freq_table[i];=0A=
>> +		if (freq->rate =3D=3D rate ||=0A=
>> +				freq->rate + 1 =3D=3D rate ||=0A=
>> +				freq->rate - 1 =3D=3D rate)=0A=
>> +			return freq;=0A=
>> +	}=0A=
>> +=0A=
>> +	return NULL;=0A=
>> +}=0A=
>> +=0A=
>> +static void imx8m_ddrc_smc_set_freq(int target_freq)=0A=
>> +{=0A=
>> +	struct arm_smccc_res res;=0A=
>> +	u32 online_cpus =3D 0;=0A=
>> +	int cpu;=0A=
>> +=0A=
>> +	local_irq_disable();=0A=
>> +=0A=
>> +	for_each_online_cpu(cpu)=0A=
>> +		online_cpus |=3D (1 << (cpu * 8));=0A=
>> +=0A=
>> +	/* change the ddr freqency */=0A=
>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,=0A=
>> +			0, 0, 0, 0, 0, &res);=0A=
>> +=0A=
>> +	local_irq_enable();=0A=
>> +}=0A=
>> +=0A=
>> +static struct clk *clk_get_parent_by_index(struct clk *clk, int index)=
=0A=
>> +{=0A=
>> +	struct clk_hw *hw;=0A=
>> +=0A=
>> +	hw =3D clk_hw_get_parent_by_index(__clk_get_hw(clk), index);=0A=
>> +=0A=
>> +	return hw ? hw->clk : NULL;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_set_freq(struct device *dev, struct imx8m_ddrc_fr=
eq *freq)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +	struct clk *new_dram_core_parent;=0A=
>> +	struct clk *new_dram_alt_parent;=0A=
>> +	struct clk *new_dram_apb_parent;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Fetch new parents=0A=
>> +	 *=0A=
>> +	 * new_dram_alt_parent and new_dram_apb_parent are optional but=0A=
>> +	 * new_dram_core_parent is not.=0A=
>> +	 */=0A=
>> +	new_dram_core_parent =3D clk_get_parent_by_index(=0A=
>> +			priv->dram_core, freq->dram_core_parent_index - 1);=0A=
>> +	if (!new_dram_core_parent) {=0A=
>> +		dev_err(dev, "failed to fetch new dram_core parent\n");=0A=
>> +		return -EINVAL;=0A=
>> +	}=0A=
>> +	if (freq->dram_alt_parent_index) {=0A=
>> +		new_dram_alt_parent =3D clk_get_parent_by_index(=0A=
>> +				priv->dram_alt,=0A=
>> +				freq->dram_alt_parent_index - 1);=0A=
>> +		if (!new_dram_alt_parent) {=0A=
>> +			dev_err(dev, "failed to fetch new dram_alt parent\n");=0A=
>> +			return -EINVAL;=0A=
>> +		}=0A=
>> +	} else=0A=
>> +		new_dram_alt_parent =3D NULL;=0A=
>> +=0A=
>> +	if (freq->dram_apb_parent_index) {=0A=
>> +		new_dram_apb_parent =3D clk_get_parent_by_index(=0A=
>> +				priv->dram_apb,=0A=
>> +				freq->dram_apb_parent_index - 1);=0A=
>> +		if (!new_dram_apb_parent) {=0A=
>> +			dev_err(dev, "failed to fetch new dram_apb parent\n");=0A=
>> +			return -EINVAL;=0A=
>> +		}=0A=
>> +	} else=0A=
>> +		new_dram_apb_parent =3D NULL;=0A=
>> +=0A=
>> +	/* increase reference counts and ensure clks are ON before switch */=
=0A=
>> +	ret =3D clk_prepare_enable(new_dram_core_parent);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(dev, "failed to enable new dram_core parent: %d\n",=0A=
>> +			ret);=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +	ret =3D clk_prepare_enable(new_dram_alt_parent);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(dev, "failed to enable new dram_alt parent: %d\n",=0A=
>> +			ret);=0A=
>> +		goto out_disable_core_parent;=0A=
>> +	}=0A=
>> +	ret =3D clk_prepare_enable(new_dram_apb_parent);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(dev, "failed to enable new dram_apb parent: %d\n",=0A=
>> +			ret);=0A=
>> +		goto out_disable_alt_parent;=0A=
>> +	}=0A=
>> +=0A=
>> +	imx8m_ddrc_smc_set_freq(freq->smcarg);=0A=
>> +=0A=
>> +	/* update parents in clk tree after switch. */=0A=
>> +	ret =3D clk_set_parent(priv->dram_core, new_dram_core_parent);=0A=
>> +	if (ret)=0A=
>> +		dev_warn(dev, "failed to set dram_core parent: %d\n", ret);=0A=
>> +	if (new_dram_alt_parent) {=0A=
>> +		ret =3D clk_set_parent(priv->dram_alt, new_dram_alt_parent);=0A=
>> +		if (ret)=0A=
>> +			dev_warn(dev, "failed to set dram_alt parent: %d\n",=0A=
>> +				 ret);=0A=
>> +	}=0A=
>> +	if (new_dram_apb_parent) {=0A=
>> +		ret =3D clk_set_parent(priv->dram_apb, new_dram_apb_parent);=0A=
>> +		if (ret)=0A=
>> +			dev_warn(dev, "failed to set dram_apb parent: %d\n",=0A=
>> +				 ret);=0A=
>> +	}=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Explicitly refresh dram PLL rate.=0A=
>> +	 *=0A=
>> +	 * Even if it's marked with CLK_GET_RATE_NOCACHE the rate will not be=
=0A=
>> +	 * automatically refreshed when clk_get_rate is called on children.=0A=
>> +	 */=0A=
>> +	clk_get_rate(priv->dram_pll);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * clk_set_parent transfer the reference count from old parent.=0A=
>> +	 * now we drop extra reference counts used during the switch=0A=
>> +	 */=0A=
>> +	clk_disable_unprepare(new_dram_apb_parent);=0A=
>> +out_disable_alt_parent:=0A=
>> +	clk_disable_unprepare(new_dram_alt_parent);=0A=
>> +out_disable_core_parent:=0A=
>> +	clk_disable_unprepare(new_dram_core_parent);=0A=
>> +out:=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u=
32 flags)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +	struct imx8m_ddrc_freq *freq_info;=0A=
>> +	struct dev_pm_opp *new_opp;=0A=
>> +	unsigned long old_freq, new_freq;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	new_opp =3D devfreq_recommended_opp(dev, freq, flags);=0A=
>> +	if (IS_ERR(new_opp)) {=0A=
>> +		ret =3D PTR_ERR(new_opp);=0A=
>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +	dev_pm_opp_put(new_opp);=0A=
>> +=0A=
>> +	old_freq =3D clk_get_rate(priv->dram_core);=0A=
>> +	if (*freq =3D=3D old_freq)=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	freq_info =3D imx8m_ddrc_find_freq(priv, *freq);=0A=
>> +	if (!freq_info)=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Read back the clk rate to verify switch was correct and so that=0A=
>> +	 * we can report it on all error paths.=0A=
>> +	 */=0A=
>> +	ret =3D imx8m_ddrc_set_freq(dev, freq_info);=0A=
>> +=0A=
>> +	new_freq =3D clk_get_rate(priv->dram_core);=0A=
>> +	if (ret)=0A=
>> +		dev_err(dev, "ddrc failed freq switch to %lu from %lu: error %d. now =
at %lu\n",=0A=
>> +			old_freq, *freq, ret, new_freq);=0A=
>> +	else if (*freq !=3D new_freq)=0A=
>> +		dev_err(dev, "ddrc failed freq update to %lu from %lu, now at %lu\n",=
=0A=
>> +			old_freq, *freq, new_freq);=0A=
>> +	else=0A=
>> +		dev_dbg(dev, "ddrc freq set to %lu (was %lu)\n",=0A=
>> +			*freq, old_freq);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *f=
req)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +=0A=
>> +	*freq =3D clk_get_rate(priv->dram_core);=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_get_dev_status(struct device *dev,=0A=
>> +				     struct devfreq_dev_status *stat)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +=0A=
>> +	stat->busy_time =3D 0;=0A=
>> +	stat->total_time =3D 0;=0A=
>> +	stat->current_frequency =3D clk_get_rate(priv->dram_core);=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_init_freq_info(struct device *dev)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +	struct arm_smccc_res res;=0A=
>> +	int index;=0A=
>> +=0A=
>> +	/* An error here means DDR DVFS API not supported by firmware */=0A=
>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_COUNT,=0A=
>> +			0, 0, 0, 0, 0, 0, &res);=0A=
>> +	priv->freq_count =3D res.a0;=0A=
>> +	if (priv->freq_count <=3D 0 ||=0A=
>> +			priv->freq_count > IMX8M_DDRC_MAX_FREQ_COUNT)=0A=
>> +		return -ENODEV;=0A=
>> +=0A=
>> +	for (index =3D 0; index < priv->freq_count; ++index) {=0A=
>> +		struct imx8m_ddrc_freq *freq =3D &priv->freq_table[index];=0A=
>> +=0A=
>> +		arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_INFO,=0A=
>> +			      index, 0, 0, 0, 0, 0, &res);=0A=
>> +		/* Result should be strictly positive */=0A=
>> +		if ((long)res.a0 <=3D 0)=0A=
>> +			return -ENODEV;=0A=
>> +=0A=
>> +		freq->rate =3D res.a0;=0A=
>> +		freq->smcarg =3D index;=0A=
>> +		freq->dram_core_parent_index =3D res.a1;=0A=
>> +		freq->dram_alt_parent_index =3D res.a2;=0A=
>> +		freq->dram_apb_parent_index =3D res.a3;=0A=
>> +=0A=
>> +		/* dram_core has 2 options: dram_pll or dram_alt_root */=0A=
>> +		if (freq->dram_core_parent_index !=3D 1 &&=0A=
>> +				freq->dram_core_parent_index !=3D 2)=0A=
>> +			return -ENODEV;=0A=
>> +		/* dram_apb and dram_alt have exactly 8 possible parents */=0A=
>> +		if (freq->dram_alt_parent_index > 8 ||=0A=
>> +				freq->dram_apb_parent_index > 8)=0A=
>> +			return -ENODEV;=0A=
>> +		/* dram_core from alt requires explicit dram_alt parent */=0A=
>> +		if (freq->dram_core_parent_index =3D=3D 2 &&=0A=
>> +				freq->dram_alt_parent_index =3D=3D 0)=0A=
>> +			return -ENODEV;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_check_opps(struct device *dev)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +	struct imx8m_ddrc_freq *freq_info;=0A=
>> +	struct dev_pm_opp *opp;=0A=
>> +	unsigned long freq;=0A=
>> +	int i, opp_count;=0A=
>> +=0A=
>> +	/* Enumerate DT OPPs and disable those not supported by firmware */=0A=
>> +	opp_count =3D dev_pm_opp_get_opp_count(dev);=0A=
>> +	if (opp_count < 0)=0A=
>> +		return opp_count;=0A=
>> +	for (i =3D 0, freq =3D 0; i < opp_count; ++i, ++freq) {=0A=
>> +		opp =3D dev_pm_opp_find_freq_ceil(dev, &freq);=0A=
>> +		if (IS_ERR(opp)) {=0A=
>> +			dev_err(dev, "Failed enumerating OPPs: %ld\n",=0A=
>> +				PTR_ERR(opp));=0A=
>> +			return PTR_ERR(opp);=0A=
>> +		}=0A=
>> +		dev_pm_opp_put(opp);=0A=
>> +=0A=
>> +		freq_info =3D imx8m_ddrc_find_freq(priv, freq);=0A=
>> +		if (!freq_info) {=0A=
>> +			dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",=0A=
>> +					freq, DIV_ROUND_CLOSEST(freq, 250000));=0A=
>> +			dev_pm_opp_disable(dev, freq);=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static void imx8m_ddrc_exit(struct device *dev)=0A=
>> +{=0A=
>> +	dev_pm_opp_of_remove_table(dev);=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_probe(struct platform_device *pdev)=0A=
>> +{=0A=
>> +	struct device *dev =3D &pdev->dev;=0A=
>> +	struct imx8m_ddrc *priv;=0A=
>> +	const char *gov =3D DEVFREQ_GOV_USERSPACE;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);=0A=
>> +	if (!priv)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	platform_set_drvdata(pdev, priv);=0A=
>> +=0A=
>> +	ret =3D imx8m_ddrc_init_freq_info(dev);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(dev, "failed to init firmware freq info: %d\n", ret);=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	priv->dram_core =3D devm_clk_get(dev, "core");=0A=
>> +	priv->dram_pll =3D devm_clk_get(dev, "pll");=0A=
>> +	priv->dram_alt =3D devm_clk_get(dev, "alt");=0A=
>> +	priv->dram_apb =3D devm_clk_get(dev, "apb");=0A=
>> +	if (IS_ERR(priv->dram_core) ||=0A=
>> +		IS_ERR(priv->dram_pll) ||=0A=
>> +		IS_ERR(priv->dram_alt) ||=0A=
>> +		IS_ERR(priv->dram_apb)) {=0A=
>> +		ret =3D PTR_ERR(priv->devfreq);=0A=
>> +		dev_err(dev, "failed to fetch clocks: %d\n", ret);=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D dev_pm_opp_of_add_table(dev);=0A=
>> +	if (ret < 0) {=0A=
>> +		dev_err(dev, "failed to get OPP table\n");=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D imx8m_ddrc_check_opps(dev);=0A=
>> +	if (ret < 0)=0A=
>> +		goto err;=0A=
>> +=0A=
>> +	priv->profile.polling_ms =3D 1000;=0A=
>> +	priv->profile.target =3D imx8m_ddrc_target;=0A=
>> +	priv->profile.get_dev_status =3D imx8m_ddrc_get_dev_status;=0A=
>> +	priv->profile.exit =3D imx8m_ddrc_exit;=0A=
>> +	priv->profile.get_cur_freq =3D imx8m_ddrc_get_cur_freq;=0A=
>> +	priv->profile.initial_freq =3D clk_get_rate(priv->dram_core);=0A=
>> +=0A=
>> +	priv->devfreq =3D devm_devfreq_add_device(dev, &priv->profile,=0A=
>> +						gov, NULL);=0A=
>> +	if (IS_ERR(priv->devfreq)) {=0A=
>> +		ret =3D PTR_ERR(priv->devfreq);=0A=
>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);=0A=
>> +		goto err;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +=0A=
>> +err:=0A=
>> +	dev_pm_opp_of_remove_table(dev);=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static const struct of_device_id imx8m_ddrc_of_match[] =3D {=0A=
>> +	{ .compatible =3D "fsl,imx8m-ddrc", },=0A=
>> +	{ /* sentinel */ },=0A=
>> +};=0A=
>> +MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);=0A=
>> +=0A=
>> +static struct platform_driver imx8m_ddrc_platdrv =3D {=0A=
>> +	.probe		=3D imx8m_ddrc_probe,=0A=
>> +	.driver =3D {=0A=
>> +		.name	=3D "imx8m-ddrc-devfreq",=0A=
>> +		.of_match_table =3D of_match_ptr(imx8m_ddrc_of_match),=0A=
>> +	},=0A=
>> +};=0A=
>> +module_platform_driver(imx8m_ddrc_platdrv);=0A=
>> +=0A=
>> +MODULE_DESCRIPTION("i.MX8M DDR Controller frequency driver");=0A=
>> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");=0A=
>> +MODULE_LICENSE("GPL v2");=0A=
>>=0A=
> =0A=
=0A=
