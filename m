Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A95F79D7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 18:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKKRXt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 12:23:49 -0500
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:30886
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726960AbfKKRXt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 12:23:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buVBkTXzTcKIgx75oZU3TxmBF3zmBS3/lX9iFShFozDxm++Ge/yjBsUIHA6BOehwJf1wqHdVa6O0+wduhls1nIBSCJf4E9aifN38IJOcxVCKqtu7QQSojX4GonUwoDx/pTT6IzQRE6W0KsaY9/GCurpnztv9rZR02laBrrz01Ac2ood1+NtxcFYjDnqMVViV0e+ov51qjfeft87OB6vZqjbedPQ0zhMaM8C8zAePiL9afUsuEzpVz7qi3JH/k+wQMkXq90azyx+3XS8iQzn4Wo7Y1jaHcxMP1XLLEZryOJC3nRxLKXCIYs7LrzxjamUVA5cz4PQNArNCh4NNPPuWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdDQtIU+DfDL5Ni7m3RU7KBoLGDHbbZvFxFssPIQjw8=;
 b=CfTwjQnRgdk6ImcTn0g6/6G7z+LAE+YPMFhzKUZuqPeetRfZfAI3UbJM/uWo+4ICQNVzUePrGii0pKB2BX0PThb7DUhArV9tG++XUbfe/DOu1uohKnb99s8VH0VACeyZ+GJnxq/4rIHlRsZYLO86KLLStlHNCdlz6iEeXa8hlWljl3rnEeVceM69Vp42NXG63ZvOUoIlJ2OTbma3ah+Z7nLt67pdFq0LqED8UUj1hIgXJeLbIA0I2Vt5fzEA0Iz3z1AEDso01CZlVlWsWfFZyvAhfJRyYQoQbXMaabrel5frAlhwOtedS31NXQTIUJavzb29EyehgWxd6liwH6uGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdDQtIU+DfDL5Ni7m3RU7KBoLGDHbbZvFxFssPIQjw8=;
 b=jslsi6znxfiOc3AgWDx0J5p1jyAW/U/mt8OCT7qN1Ffpdh1LEsgoB0Fyf2gBSF8yNAB5l9Vu8OK5tf1bzROGMWoB3CzjWwcrSm37OXP2KcvLIOmGFjYwj1CszUAGooKT80q0Pyr5KhST+0R+oQFn5eAE36ysXH6QFvqq3svGsxE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4157.eurprd04.prod.outlook.com (52.133.15.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 17:23:38 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 17:23:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 4/6] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Thread-Topic: [PATCH v4 4/6] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Thread-Index: AQHVloV+JlVzz2gms0Gh8HYpk8Otrw==
Date:   Mon, 11 Nov 2019 17:23:38 +0000
Message-ID: <VI1PR04MB7023A07C682C9DA006D1BEF1EE740@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
 <CGME20191108224026epcas1p35263d69e63d2e7357f82b2e41d9efe07@epcas1p3.samsung.com>
 <675f35b1e92f49e0d7889675c87e944d454d4e38.1573252696.git.leonard.crestez@nxp.com>
 <9eeb496b-2d7e-590c-3e9e-765a9e996481@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09b10c91-795e-41b1-f074-08d766cbe406
x-ms-traffictypediagnostic: VI1PR04MB4157:|VI1PR04MB4157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB41578EEEA79AF6C957ABC65BEE740@VI1PR04MB4157.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(51444003)(189003)(199004)(5660300002)(54906003)(2906002)(14444005)(86362001)(7736002)(256004)(91956017)(81156014)(81166006)(76116006)(66066001)(8676002)(110136005)(7416002)(8936002)(52536014)(6246003)(305945005)(4326008)(55016002)(71200400001)(71190400001)(99286004)(9686003)(64756008)(33656002)(478600001)(6116002)(3846002)(66446008)(476003)(229853002)(446003)(26005)(74316002)(486006)(186003)(30864003)(102836004)(6436002)(44832011)(76176011)(6506007)(14454004)(316002)(66946007)(66476007)(7696005)(53546011)(25786009)(66556008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4157;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfqPO3HQgwpikTvvuc6BnhDMmPxD0EhekcCPrb9hh9rN56jJoh5QVa6NrUsJN+dMiraZFFJGwUjiz/Wz0Ms8fNiWP2LzfbbnMg1SaA3gdxqlHH14+BPVqnB6HYk/V0ujBcUMV6a2b3c8NRKmSqTMY5xtiOW3RuntNXLTj1qc79XLUh6tgHl8rjn+q1pW972RoDFjHyeprvh6TqXN+y1M7OgI8QypkYZAknTTR65Vcm1qLSs6e6K2r4DCnP8C2bkjAp5h4ohNLM9GY9Ps9bvgVPJL1o3I9dTk0jEiLFAtNlPFNauwztCseHe4GzviPqYMBxDhAoyTO5/6fCxphcwwb4LGJR7jgwSz+EyhutCFSOlJHfxNX/ezT2nmtDU4IInOgHgZuYf0qhdPQgnHQiN8O8GG+xlbDH9kHcu2cCZV9EfbQ+GPFTiJ1FvsyhYriTHX
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b10c91-795e-41b1-f074-08d766cbe406
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 17:23:38.4635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbqiO9YLmNkufjMtvVrLO5opxtc/KCAXYDw6PAibtGy7AYpt9/4XOyMeZqHIU1MlOzwLSlP2uMYzeHwhgxULqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4157
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11.11.2019 05:18, Chanwoo Choi wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> On 11/9/19 7:39 AM, Leonard Crestez wrote:=0A=
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
>>   drivers/devfreq/Kconfig      |  10 +=0A=
>>   drivers/devfreq/Makefile     |   1 +=0A=
>>   drivers/devfreq/imx8m-ddrc.c | 416 +++++++++++++++++++++++++++++++++++=
=0A=
>>   3 files changed, 427 insertions(+)=0A=
>>   create mode 100644 drivers/devfreq/imx8m-ddrc.c=0A=
>>=0A=
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig=0A=
>> index defe1d438710..c519fd27808f 100644=0A=
>> --- a/drivers/devfreq/Kconfig=0A=
>> +++ b/drivers/devfreq/Kconfig=0A=
>> @@ -90,10 +90,20 @@ config ARM_EXYNOS_BUS_DEVFREQ=0A=
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
>> +	select PM_OPP=0A=
> =0A=
> It doesn't need to add. CONFIG_DEVFREQ add 'select PM_OPP'=0A=
> because 'PM_OPP' is mandatory for devfreq.=0A=
=0A=
OK.=0A=
=0A=
All other drivers select PM_OPP, this was just copied=0A=
=0A=
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
>> index 000000000000..51903fee21a7=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/devfreq/imx8m-ddrc.c=0A=
>> @@ -0,0 +1,416 @@=0A=
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
> =0A=
> local_irq_disable is more proper than local_irq_save()?=0A=
=0A=
There's no need to use save/restore because we know that irqs are =0A=
enabled when entering the function. This is only called from devfreq =0A=
set_target which runs in process context.=0A=
=0A=
> =0A=
>> +=0A=
>> +	for_each_online_cpu(cpu)=0A=
>> +		online_cpus |=3D (1 << (cpu * 8));=0A=
>> +=0A=
>> +	/* change the ddr freqency */=0A=
>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,=0A=
>> +			0, 0, 0, 0, 0, &res);=0A=
>> +=0A=
>> +	local_irq_enable();=0A=
> =0A=
> ditto. local_irq_restore() instead of local_irq_enable()=0A=
> =0A=
>> +}=0A=
>> +=0A=
>> +struct clk *clk_get_parent_by_index(struct clk *clk, int index)=0A=
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
>> +	new_dram_core_parent =3D clk_get_parent_by_index(=0A=
>  > You can use 'clk_hw_get_parent_by_index' directly.=0A=
=0A=
The helper above avoids duplicating ?:=0A=
=0A=
> And, you need to check whether the return value is NULL or not.=0A=
Yes for dram_core_parent but others are deliberately allowed to be NULL. =
=0A=
For some setpoints some parents might be indifferent or require no =0A=
changes. For example when dram_core has pll as parent the expectation is =
=0A=
that dram_all will be OFF so parent is irrelevant.=0A=
=0A=
Driver relies on the fact that clock API ignores prepare/enable for NULL =
=0A=
clocks. I can add a comment explaining that.=0A=
=0A=
>> +			priv->dram_core, freq->dram_core_parent_index - 1);=0A=
>> +	new_dram_alt_parent =3D clk_get_parent_by_index(=0A=
> =0A=
> ditto.=0A=
> =0A=
>> +			priv->dram_alt, freq->dram_alt_parent_index - 1);=0A=
>> +	new_dram_apb_parent =3D clk_get_parent_by_index(=0A=
> =0A=
> ditto.=0A=
=0A=
>> +			priv->dram_apb, freq->dram_apb_parent_index - 1);=0A=
>> +=0A=
>> +	/* increase reference counts and ensure clks are ON before switch */=
=0A=
>> +	ret =3D clk_prepare_enable(new_dram_core_parent);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(dev, "failed enable new dram_core parent: %d\n", ret);=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +	ret =3D clk_prepare_enable(new_dram_alt_parent);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(dev, "failed enable new dram_alt parent: %d\n", ret);=0A=
>> +		goto out_dis_core;=0A=
> =0A=
> I think that 'dis' is not general expression for 'disable'.=0A=
> Just, I think that 'out_disable_core' is better than 'out_dis_core'.=0A=
=0A=
OK=0A=
=0A=
>> +	}=0A=
>> +	ret =3D clk_prepare_enable(new_dram_apb_parent);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(dev, "failed enable new dram_apb parent: %d\n", ret);=0A=
>> +		goto out_dis_alt;=0A=
> =0A=
> ditto.=0A=
> =0A=
>> +	}=0A=
>> +=0A=
>> +	imx8m_ddrc_smc_set_freq(freq->smcarg);=0A=
>> +=0A=
>> +	/* update parents in clk tree after switch. */=0A=
>> +	ret =3D clk_set_parent(priv->dram_core, new_dram_core_parent);=0A=
>> +	if (ret)=0A=
>> +		dev_err(dev, "failed set dram_core parent: %d\n", ret);=0A=
> =0A=
> if you don't return directly, you better to use 'dev_warn' instead of 'de=
v_err'.=0A=
=0A=
OK.=0A=
=0A=
>> +	if (new_dram_alt_parent) {=0A=
>> +		ret =3D clk_set_parent(priv->dram_alt, new_dram_alt_parent);=0A=
>> +		if (ret)=0A=
>> +			dev_err(dev, "failed set dram_alt parent: %d\n", ret);=0A=
> =0A=
> ditto. Use dev_warn.=0A=
>   =0A=
>> +	}=0A=
>> +	if (new_dram_apb_parent) {=0A=
>> +		ret =3D clk_set_parent(priv->dram_apb, new_dram_apb_parent);=0A=
>> +		if (ret)=0A=
>> +			dev_err(dev, "failed set dram_apb parent: %d\n", ret);=0A=
> =0A=
> ditto. Use dev_warn.=0A=
> =0A=
>> +	}=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Explicitly refresh dram PLL rate.=0A=
>> +	 *=0A=
>> +	 * Even if it's marked with CLK_GET_RATE_NOCACHE the rate will not be=
=0A=
> =0A=
> nitpick:=0A=
> What is more proper description either or 'Even if' or 'if' ?=0A=
=0A=
Rate updates work for dram_alt/apb but not for dram_pll because =0A=
additional clocks might be present between the PLL and dram_core mux. =0A=
This happens *even if* pll is marked with CLK_GET_RATE_NOCACHE.=0A=
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
>> +out_dis_alt:=0A=
>> +	clk_disable_unprepare(new_dram_alt_parent);=0A=
>> +out_dis_core:=0A=
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
>> +	ret =3D imx8m_ddrc_set_freq(dev, freq_info);=0A=
> =0A=
> Need to check whether 'ret' is valid or not.=0A=
> =0A=
>> +=0A=
>> +	/* Also read back the clk rate to verify switch was correct */=0A=
>> +	new_freq =3D clk_get_rate(priv->dram_core);=0A=
>> +	if (ret || *freq !=3D new_freq)=0A=
> =0A=
> You should check 'ret' right after imx8m_ddrc_set_freq()=0A=
> instead of this position.=0A=
=0A=
OK, I can add two error paths.=0A=
=0A=
>> +		dev_err(dev, "ddrc failed freq set to %lu from %lu, now at %lu\n",=0A=
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
>> +static int imx8m_ddrc_init_freq_info(struct device *dev)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +	struct arm_smccc_res res;=0A=
>> +	int index;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * An error here means DDR DVFS API not supported by firmware=0A=
>> +	 */=0A=
> =0A=
> Don't need to add multiple line comments. It is possible to be change as =
following:=0A=
> =0A=
> 	/* An error here means DDR DVFS API not supported by firmware */=0A=
=0A=
OK.=0A=
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
>> +				index, 0, 0, 0, 0, 0, &res);=0A=
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
>> +/* imx8m_ddrc_check_opps() - disable OPPs not supported by firmware */=
=0A=
> =0A=
> nitpick:=0A=
> On this driver, there are no some description for internal function.=0A=
> In order to keep the coding style, you better to move this comment=0A=
> into function before 'freq =3D ULONG_MAX'.=0A=
=0A=
Is it a problem if only some internal functions have documentation? I =0A=
can add docs to more functions.=0A=
=0A=
BTW: how can I generate devfreq documentation from these comments?=0A=
=0A=
>> +static int imx8m_ddrc_check_opps(struct device *dev)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +	struct imx8m_ddrc_freq *freq_info;=0A=
>> +	struct dev_pm_opp *opp;=0A=
>> +	unsigned long freq;=0A=
>> +=0A=
>> +	freq =3D ULONG_MAX;=0A=
>> +	while (true) {=0A=
>> +		opp =3D dev_pm_opp_find_freq_floor(dev, &freq);=0A=
>> +		if (opp =3D=3D ERR_PTR(-ERANGE))=0A=
>> +			break;=0A=
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
>> +=0A=
>> +		freq--;=0A=
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
=0A=
