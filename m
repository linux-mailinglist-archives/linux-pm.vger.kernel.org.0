Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5EC3F92F2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 15:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfKLOra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 09:47:30 -0500
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:26048
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbfKLOra (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 09:47:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrlQ5T6Ec3PRBYpSgNS5W6/WN6MPI1FPOJrYLiGzNEIpcd1v9PYqxh4tNN9MGVeOtlniX+6DFqbyDcbTiW4DYBtUjOh06OEU9B1a8z0zZHV3DQn9xTmGx46oa7Na9IHBKrU1nZ9Gxu2aSAxaVZXCnyR+29r8ItzsUIwBEexG+ijObqyWsqfPUOQZRYaf6rGI1a/Nv4QugZxCUpU669DiCbxt0NbPb4xsUJKiFFnLBX+k+0CvsdIC0JiYTk0ta/BVrKkCOOhnfC6uL95H1LXpmB7FmnaIqj2h+nntef5XKaOtr21gXtvIlZVWAv9KamSJJZN8TbQHkcVxU0hOH4rGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7r7nwsuXqfLeeoSXcTxIRIXYGVS2Pjyyb5P7DJpPSo=;
 b=Dxd1LHDqX9ftcby+L+KKDGGvUq7dr2RMGRl1Q2dn6TIF+rzRHqxEAS3PyK/A9JoNB3Y5VsrmnOKaFXzQ0WwDiITySXRbiuouRtfBPeOoo1hSaYSP0g9ZpGNt49O59+1AKsJ5eZNpg4WvcvJYsozaaa2Yx98zaq7ySZarGiFAZOSzTE7ggAiIg+V3luks1s4sNELpejfYwR2qT6WJIDK47Zqm0N9LhXeL8tx3a4xWIOfjJ0o5xK6sxwcv8Y+TI8CXD6kguIHCtd2NlUffZcvGl+WQ0th8iQy1BWmwBYhS8YDT6xJLHNr/cUIEgINlWfGBY68fvUEdke6x/XMVX1971g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7r7nwsuXqfLeeoSXcTxIRIXYGVS2Pjyyb5P7DJpPSo=;
 b=FwWIkayOWk9CkmwZpCElWddjmL6FMHErm6QPPCawge4bE1sYWRyECqgxXu67kQQY5eEORHmlVMRith9f0/M69fzpiX95Ui2dd5LqUmeEED2Oht3WmtIz1QhfcGXOY1olXn20Xx+FnLxQDnILcBHvP38i9hh/KOqeEWS0YuLS9U4=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5950.eurprd04.prod.outlook.com (20.178.121.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 14:47:19 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 14:47:19 +0000
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
Date:   Tue, 12 Nov 2019 14:47:19 +0000
Message-ID: <VI1PR04MB70239B081072BDEFF25772B7EE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
 <CGME20191108224026epcas1p35263d69e63d2e7357f82b2e41d9efe07@epcas1p3.samsung.com>
 <675f35b1e92f49e0d7889675c87e944d454d4e38.1573252696.git.leonard.crestez@nxp.com>
 <9eeb496b-2d7e-590c-3e9e-765a9e996481@samsung.com>
 <VI1PR04MB7023A07C682C9DA006D1BEF1EE740@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <45f4471b-55b2-498a-463c-2adbd03e84df@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d62ea603-abd5-4b99-c966-08d7677f37e1
x-ms-traffictypediagnostic: VI1PR04MB5950:|VI1PR04MB5950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB595081328F17D9C86EF1EA5DEE770@VI1PR04MB5950.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(51444003)(4326008)(14454004)(6436002)(9686003)(26005)(99286004)(33656002)(6246003)(66066001)(71190400001)(446003)(25786009)(54906003)(71200400001)(186003)(229853002)(256004)(14444005)(76116006)(91956017)(316002)(110136005)(478600001)(30864003)(305945005)(3846002)(7736002)(6116002)(81166006)(81156014)(486006)(55016002)(102836004)(74316002)(86362001)(5660300002)(44832011)(6506007)(66556008)(66446008)(64756008)(7416002)(53546011)(52536014)(76176011)(2906002)(476003)(8676002)(66946007)(66476007)(7696005)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5950;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ux5gPfenGuB2dreH9/Zu6PXZWII6QQLH7TS+cdOYYq9Tu7hmVwIU/B1dMfkqlNlcmAP+CpQ6DkYU73teczu5At4+bzEeEPIG/FcMb+S1dApepDDEDXimcVn85ffPTj/0wlXYGKCE8uo23dxbzT3n6UNpQvyjruBLWqloD161TH9iIFo3sd+JecXlMzFUFnSNurY7/8EE+Bep3i7M3YFA6JK7rNTXGxc8zufJEC2WZBb6W5cEccqYDWDtSAH8/V1nWM22A3kPhCryG5e/23I1Lz5yDBWPkCd4qMnx89WAUTfLgH8VyOcaauZXJ6UO91zIHUkau/ixcy6FBMl7AhUhzsr1mtvOduoXjny1zTvD18cn34wjHoq7nDfPi+1+2u2p3Wga2xOlDZJmMY6FVycSQOX7hDgB9bkpLeMm1NxGTg6TjbDCTFXVg4zWO5xdioh
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62ea603-abd5-4b99-c966-08d7677f37e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 14:47:19.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zceDC2t0VXpZvKivrdTN40tA8mi2XtJ9E6um77GMqqOqeVQ1jR2Rlp0t2v0XdMAePZJ98LX0UYr0ztcI/cVJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5950
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12.11.2019 02:54, Chanwoo Choi wrote:=0A=
> On 11/12/19 2:23 AM, Leonard Crestez wrote:=0A=
>> On 11.11.2019 05:18, Chanwoo Choi wrote:=0A=
>>> Hi Leonard,=0A=
>>>=0A=
>>> On 11/9/19 7:39 AM, Leonard Crestez wrote:=0A=
>>>> Add driver for dynamic scaling the DDR Controller on imx8m chips. Actu=
al=0A=
>>>> frequency switching is implemented inside TF-A, this driver wraps the=
=0A=
>>>> SMC calls and synchronizes the clk tree.=0A=
>>>>=0A=
>>>> The DRAM clocks on imx8m have the following structure (abridged):=0A=
>>>>=0A=
>>>>    +----------+       |\            +------+=0A=
>>>>    | dram_pll |-------|M| dram_core |      |=0A=
>>>>    +----------+       |U|---------->| D    |=0A=
>>>>                    /--|X|           |  D   |=0A=
>>>>      dram_alt_root |  |/            |   R  |=0A=
>>>>                    |                |    C |=0A=
>>>>               +---------+           |      |=0A=
>>>>               |FIX DIV/4|           |      |=0A=
>>>>               +---------+           |      |=0A=
>>>>     composite:     |                |      |=0A=
>>>>    +----------+    |                |      |=0A=
>>>>    | dram_alt |----/                |      |=0A=
>>>>    +----------+                     |      |=0A=
>>>>    | dram_apb |-------------------->|      |=0A=
>>>>    +----------+                     +------+=0A=
>>>>=0A=
>>>> The dram_pll is used for higher rates and dram_alt is used for lower=
=0A=
>>>> rates. The dram_alt and dram_apb clocks are "imx composite" and their=
=0A=
>>>> parent can also be modified.=0A=
>>>>=0A=
>>>> This driver will prepare/enable the new parents ahead of switching (so=
=0A=
>>>> that the expected roots are enabled) and afterwards it will call=0A=
>>>> clk_set_parent to ensure the parents in clock framework are up-to-date=
.=0A=
>>>>=0A=
>>>> The driver relies on dram_pll dram_alt and dram_apb being marked with=
=0A=
>>>> CLK_GET_RATE_NOCACHE for rate updates.=0A=
>>>>=0A=
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>> ---=0A=
>>>>    drivers/devfreq/Kconfig      |  10 +=0A=
>>>>    drivers/devfreq/Makefile     |   1 +=0A=
>>>>    drivers/devfreq/imx8m-ddrc.c | 416 ++++++++++++++++++++++++++++++++=
+++=0A=
>>>>    3 files changed, 427 insertions(+)=0A=
>>>>    create mode 100644 drivers/devfreq/imx8m-ddrc.c=0A=
>>>>=0A=
>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig=0A=
>>>> index defe1d438710..c519fd27808f 100644=0A=
>>>> --- a/drivers/devfreq/Kconfig=0A=
>>>> +++ b/drivers/devfreq/Kconfig=0A=
>>>> @@ -90,10 +90,20 @@ config ARM_EXYNOS_BUS_DEVFREQ=0A=
>>>>    	  Each memory bus group could contain many memoby bus block. It re=
ads=0A=
>>>>    	  PPMU counters of memory controllers by using DEVFREQ-event devic=
e=0A=
>>>>    	  and adjusts the operating frequencies and voltages with OPP supp=
ort.=0A=
>>>>    	  This does not yet operate with optimal voltages.=0A=
>>>>    =0A=
>>>> +config ARM_IMX8M_DDRC_DEVFREQ=0A=
>>>> +	tristate "i.MX8M DDRC DEVFREQ Driver"=0A=
>>>> +	depends on ARCH_MXC || COMPILE_TEST=0A=
>>>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND=0A=
>>>> +	select DEVFREQ_GOV_USERSPACE=0A=
>>>> +	select PM_OPP=0A=
>>>=0A=
>>> It doesn't need to add. CONFIG_DEVFREQ add 'select PM_OPP'=0A=
>>> because 'PM_OPP' is mandatory for devfreq.=0A=
>>=0A=
>> OK.=0A=
>>=0A=
>> All other drivers select PM_OPP, this was just copied=0A=
>>=0A=
>>>> +	help=0A=
>>>> +	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It all=
ows=0A=
>>>> +	  adjusting DRAM frequency.=0A=
>>>> +=0A=
>>>>    config ARM_TEGRA_DEVFREQ=0A=
>>>>    	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"=0A=
>>>>    	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \=0A=
>>>>    		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \=0A=
>>>>    		ARCH_TEGRA_210_SOC || \=0A=
>>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile=0A=
>>>> index 338ae8440db6..3eb4d5e6635c 100644=0A=
>>>> --- a/drivers/devfreq/Makefile=0A=
>>>> +++ b/drivers/devfreq/Makefile=0A=
>>>> @@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+=3D governor_po=
wersave.o=0A=
>>>>    obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor_userspace.o=0A=
>>>>    obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=3D governor_passive.o=0A=
>>>>    =0A=
>>>>    # DEVFREQ Drivers=0A=
>>>>    obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o=0A=
>>>> +obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+=3D imx8m-ddrc.o=0A=
>>>>    obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+=3D rk3399_dmc.o=0A=
>>>>    obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra30-devfreq.o=0A=
>>>>    obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+=3D tegra20-devfreq.o=0A=
>>>>    =0A=
>>>>    # DEVFREQ Event Drivers=0A=
>>>> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc=
.c=0A=
>>>> new file mode 100644=0A=
>>>> index 000000000000..51903fee21a7=0A=
>>>> --- /dev/null=0A=
>>>> +++ b/drivers/devfreq/imx8m-ddrc.c=0A=
>>>> @@ -0,0 +1,416 @@=0A=
>>>> +// SPDX-License-Identifier: GPL-2.0=0A=
>>>> +/*=0A=
>>>> + * Copyright 2019 NXP=0A=
>>>> + */=0A=
>>>> +=0A=
>>>> +#include <linux/module.h>=0A=
>>>> +#include <linux/device.h>=0A=
>>>> +#include <linux/of_device.h>=0A=
>>>> +#include <linux/platform_device.h>=0A=
>>>> +#include <linux/devfreq.h>=0A=
>>>> +#include <linux/pm_opp.h>=0A=
>>>> +#include <linux/clk.h>=0A=
>>>> +#include <linux/clk-provider.h>=0A=
>>>> +#include <linux/arm-smccc.h>=0A=
>>>> +=0A=
>>>> +#define IMX_SIP_DDR_DVFS			0xc2000004=0A=
>>>> +=0A=
>>>> +/* Values starting from 0 switch to specific frequency */=0A=
>>>> +#define IMX_SIP_DDR_FREQ_SET_HIGH		0x00=0A=
>>>> +=0A=
>>>> +/* Deprecated after moving IRQ handling to ATF */=0A=
>>>> +#define IMX_SIP_DDR_DVFS_WAIT_CHANGE		0x0F=0A=
>>>> +=0A=
>>>> +/* Query available frequencies. */=0A=
>>>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_COUNT		0x10=0A=
>>>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_INFO		0x11=0A=
>>>> +=0A=
>>>> +/*=0A=
>>>> + * This should be in a 1:1 mapping with devicetree OPPs but=0A=
>>>> + * firmware provides additional info.=0A=
>>>> + */=0A=
>>>> +struct imx8m_ddrc_freq {=0A=
>>>> +	unsigned long rate;=0A=
>>>> +	unsigned long smcarg;=0A=
>>>> +	int dram_core_parent_index;=0A=
>>>> +	int dram_alt_parent_index;=0A=
>>>> +	int dram_apb_parent_index;=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +/* Hardware limitation */=0A=
>>>> +#define IMX8M_DDRC_MAX_FREQ_COUNT 4=0A=
>>>> +=0A=
>>>> +/*=0A=
>>>> + * i.MX8M DRAM Controller clocks have the following structure (abridg=
ed):=0A=
>>>> + *=0A=
>>>> + * +----------+       |\            +------+=0A=
>>>> + * | dram_pll |-------|M| dram_core |      |=0A=
>>>> + * +----------+       |U|---------->| D    |=0A=
>>>> + *                 /--|X|           |  D   |=0A=
>>>> + *   dram_alt_root |  |/            |   R  |=0A=
>>>> + *                 |                |    C |=0A=
>>>> + *            +---------+           |      |=0A=
>>>> + *            |FIX DIV/4|           |      |=0A=
>>>> + *            +---------+           |      |=0A=
>>>> + *  composite:     |                |      |=0A=
>>>> + * +----------+    |                |      |=0A=
>>>> + * | dram_alt |----/                |      |=0A=
>>>> + * +----------+                     |      |=0A=
>>>> + * | dram_apb |-------------------->|      |=0A=
>>>> + * +----------+                     +------+=0A=
>>>> + *=0A=
>>>> + * The dram_pll is used for higher rates and dram_alt is used for low=
er rates.=0A=
>>>> + *=0A=
>>>> + * Frequency switching is implemented in TF-A (via SMC call) and can =
change the=0A=
>>>> + * configuration of the clocks, including mux parents. The dram_alt a=
nd=0A=
>>>> + * dram_apb clocks are "imx composite" and their parent can change to=
o.=0A=
>>>> + *=0A=
>>>> + * We need to prepare/enable the new mux parents head of switching an=
d update=0A=
>>>> + * their information afterwards.=0A=
>>>> + */=0A=
>>>> +struct imx8m_ddrc {=0A=
>>>> +	struct devfreq_dev_profile profile;=0A=
>>>> +	struct devfreq *devfreq;=0A=
>>>> +=0A=
>>>> +	/* For frequency switching: */=0A=
>>>> +	struct clk *dram_core;=0A=
>>>> +	struct clk *dram_pll;=0A=
>>>> +	struct clk *dram_alt;=0A=
>>>> +	struct clk *dram_apb;=0A=
>>>> +=0A=
>>>> +	int freq_count;=0A=
>>>> +	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];=0A=
>>>> +};=0A=
>>>> +=0A=
>>>> +static struct imx8m_ddrc_freq *imx8m_ddrc_find_freq(struct imx8m_ddrc=
 *priv,=0A=
>>>> +						    unsigned long rate)=0A=
>>>> +{=0A=
>>>> +	struct imx8m_ddrc_freq *freq;=0A=
>>>> +	int i;=0A=
>>>> +=0A=
>>>> +	/*=0A=
>>>> +	 * Firmware reports values in MT/s, so we round-down from Hz=0A=
>>>> +	 * Rounding is extra generous to ensure a match.=0A=
>>>> +	 */=0A=
>>>> +	rate =3D DIV_ROUND_CLOSEST(rate, 250000);=0A=
>>>> +	for (i =3D 0; i < priv->freq_count; ++i) {=0A=
>>>> +		freq =3D &priv->freq_table[i];=0A=
>>>> +		if (freq->rate =3D=3D rate ||=0A=
>>>> +				freq->rate + 1 =3D=3D rate ||=0A=
>>>> +				freq->rate - 1 =3D=3D rate)=0A=
>>>> +			return freq;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	return NULL;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static void imx8m_ddrc_smc_set_freq(int target_freq)=0A=
>>>> +{=0A=
>>>> +	struct arm_smccc_res res;=0A=
>>>> +	u32 online_cpus =3D 0;=0A=
>>>> +	int cpu;=0A=
>>>> +=0A=
>>>> +	local_irq_disable();=0A=
>>>=0A=
>>> local_irq_disable is more proper than local_irq_save()?=0A=
>>=0A=
>> There's no need to use save/restore because we know that irqs are=0A=
>> enabled when entering the function. This is only called from devfreq=0A=
>> set_target which runs in process context.=0A=
> =0A=
> local_irq might affect the whole architecture and other running device dr=
iver=0A=
> which requires the some CPU irq at the same time. Don't need to save the =
irqflag?=0A=
=0A=
As far as I know IRQ disabling implicitly disables all forms of =0A=
preemption, no other code can run until irqs are restored.=0A=
=0A=
The difference between disable/enable and save/restore is that the =0A=
latter also works when function is called with irqs already disabled but =
=0A=
that is not required here. We know that devfreq set_target is called in =0A=
process context with irqs enabled, otherwise it would be impossible to =0A=
use the OPP framework (it uses mutexes internally) or touch regulators =0A=
(they frequently sleep waiting on i2c transactions).=0A=
=0A=
>>>> +	for_each_online_cpu(cpu)=0A=
>>>> +		online_cpus |=3D (1 << (cpu * 8));=0A=
>>>> +=0A=
>>>> +	/* change the ddr freqency */=0A=
>>>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,=0A=
>>>> +			0, 0, 0, 0, 0, &res);=0A=
>>>> +=0A=
>>>> +	local_irq_enable();=0A=
>>>=0A=
>>> ditto. local_irq_restore() instead of local_irq_enable()=0A=
>>>=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +struct clk *clk_get_parent_by_index(struct clk *clk, int index)=0A=
>>>> +{=0A=
>>>> +	struct clk_hw *hw;=0A=
>>>> +=0A=
>>>> +	hw =3D clk_hw_get_parent_by_index(__clk_get_hw(clk), index);=0A=
>>>> +=0A=
>>>> +	return hw ? hw->clk : NULL;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx8m_ddrc_set_freq(struct device *dev, struct imx8m_ddrc_=
freq *freq)=0A=
>>>> +{=0A=
>>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>>> +	struct clk *new_dram_core_parent;=0A=
>>>> +	struct clk *new_dram_alt_parent;=0A=
>>>> +	struct clk *new_dram_apb_parent;=0A=
>>>> +	int ret;=0A=
>>>> +=0A=
>>>> +	new_dram_core_parent =3D clk_get_parent_by_index(=0A=
>>>   > You can use 'clk_hw_get_parent_by_index' directly.=0A=
>>=0A=
>> The helper above avoids duplicating ?:=0A=
> =0A=
> I think that it is not duplicate. You use 'clk_hw_get_parent_by_index' fu=
nction=0A=
> and check the return value. it is essential behavior.=0A=
=0A=
The clk_hw_get_parent_by_index function returns a clk_hw and I'm using =0A=
the inner hw->clk. Without clk_get_parent_by_index I'd have to write:=0A=
=0A=
     hw =3D clk_hw_get_parent_by_index=0A=
     if (!hw || !hw->clk) {=0A=
         dev_err(...);=0A=
         return=0A=
     }=0A=
     clk =3D hw->clk;=0A=
=0A=
This seems pointlessly verbose.=0A=
=0A=
>>> And, you need to check whether the return value is NULL or not.=0A=
=0A=
>> Yes for dram_core_parent but others are deliberately allowed to be NULL.=
=0A=
>> For some setpoints some parents might be indifferent or require no=0A=
>> changes. For example when dram_core has pll as parent the expectation is=
=0A=
>> that dram_all will be OFF so parent is irrelevant.=0A=
> =0A=
> If all case is not same as you commented, you just add the proper dev_war=
n=0A=
> or dev_info message according to the h/w characteristic. Because user=0A=
> cannot know the detailed reason why don't check the return value.=0A=
=0A=
Really it's only freq->dram_alt/apb_parent_index which can be zero, if =0A=
that has a valid value then clk fetching shouldn't fail for any other =0A=
reason. Current code could indeed hide some errors.=0A=
>> Driver relies on the fact that clock API ignores prepare/enable for NULL=
=0A=
>> clocks. I can add a comment explaining that.=0A=
>>=0A=
>>>> +			priv->dram_core, freq->dram_core_parent_index - 1);=0A=
>>>> +	new_dram_alt_parent =3D clk_get_parent_by_index(=0A=
>>>=0A=
>>> ditto.=0A=
>>>=0A=
>>>> +			priv->dram_alt, freq->dram_alt_parent_index - 1);=0A=
>>>> +	new_dram_apb_parent =3D clk_get_parent_by_index(=0A=
>>>=0A=
>>> ditto.=0A=
>>=0A=
>>>> +			priv->dram_apb, freq->dram_apb_parent_index - 1);=0A=
>>>> +=0A=
>>>> +	/* increase reference counts and ensure clks are ON before switch */=
=0A=
>>>> +	ret =3D clk_prepare_enable(new_dram_core_parent);=0A=
>>>> +	if (ret) {=0A=
>>>> +		dev_err(dev, "failed enable new dram_core parent: %d\n", ret);=0A=
>>>> +		goto out;=0A=
>>>> +	}=0A=
>>>> +	ret =3D clk_prepare_enable(new_dram_alt_parent);=0A=
>>>> +	if (ret) {=0A=
>>>> +		dev_err(dev, "failed enable new dram_alt parent: %d\n", ret);=0A=
>>>> +		goto out_dis_core;=0A=
>>>=0A=
>>> I think that 'dis' is not general expression for 'disable'.=0A=
>>> Just, I think that 'out_disable_core' is better than 'out_dis_core'.=0A=
>>=0A=
>> OK=0A=
>>=0A=
>>>> +	}=0A=
>>>> +	ret =3D clk_prepare_enable(new_dram_apb_parent);=0A=
>>>> +	if (ret) {=0A=
>>>> +		dev_err(dev, "failed enable new dram_apb parent: %d\n", ret);=0A=
>>>> +		goto out_dis_alt;=0A=
>>>=0A=
>>> ditto.=0A=
>>>=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	imx8m_ddrc_smc_set_freq(freq->smcarg);=0A=
>>>> +=0A=
>>>> +	/* update parents in clk tree after switch. */=0A=
>>>> +	ret =3D clk_set_parent(priv->dram_core, new_dram_core_parent);=0A=
>>>> +	if (ret)=0A=
>>>> +		dev_err(dev, "failed set dram_core parent: %d\n", ret);=0A=
>>>=0A=
>>> if you don't return directly, you better to use 'dev_warn' instead of '=
dev_err'.=0A=
>>=0A=
>> OK.=0A=
>>=0A=
>>>> +	if (new_dram_alt_parent) {=0A=
>>>> +		ret =3D clk_set_parent(priv->dram_alt, new_dram_alt_parent);=0A=
>>>> +		if (ret)=0A=
>>>> +			dev_err(dev, "failed set dram_alt parent: %d\n", ret);=0A=
>>>=0A=
>>> ditto. Use dev_warn.=0A=
>>>    =0A=
>>>> +	}=0A=
>>>> +	if (new_dram_apb_parent) {=0A=
>>>> +		ret =3D clk_set_parent(priv->dram_apb, new_dram_apb_parent);=0A=
>>>> +		if (ret)=0A=
>>>> +			dev_err(dev, "failed set dram_apb parent: %d\n", ret);=0A=
>>>=0A=
>>> ditto. Use dev_warn.=0A=
>>>=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	/*=0A=
>>>> +	 * Explicitly refresh dram PLL rate.=0A=
>>>> +	 *=0A=
>>>> +	 * Even if it's marked with CLK_GET_RATE_NOCACHE the rate will not b=
e=0A=
>>>=0A=
>>> nitpick:=0A=
>>> What is more proper description either or 'Even if' or 'if' ?=0A=
>>=0A=
>> Rate updates work for dram_alt/apb but not for dram_pll because=0A=
>> additional clocks might be present between the PLL and dram_core mux.=0A=
>> This happens *even if* pll is marked with CLK_GET_RATE_NOCACHE.=0A=
> =0A=
> ok.=0A=
> =0A=
>>=0A=
>>>> +	 * automatically refreshed when clk_get_rate is called on children.=
=0A=
>>>> +	 */=0A=
>>>> +	clk_get_rate(priv->dram_pll);=0A=
>>>> +=0A=
>>>> +	/*=0A=
>>>> +	 * clk_set_parent transfer the reference count from old parent.=0A=
>>>> +	 * now we drop extra reference counts used during the switch=0A=
>>>> +	 */=0A=
>>>> +	clk_disable_unprepare(new_dram_apb_parent);=0A=
>>>> +out_dis_alt:=0A=
>>>> +	clk_disable_unprepare(new_dram_alt_parent);=0A=
>>>> +out_dis_core:=0A=
>>>> +	clk_disable_unprepare(new_dram_core_parent);=0A=
>>>> +out:=0A=
>>>> +	return ret;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx8m_ddrc_target(struct device *dev, unsigned long *freq,=
 u32 flags)=0A=
>>>> +{=0A=
>>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>>> +	struct imx8m_ddrc_freq *freq_info;=0A=
>>>> +	struct dev_pm_opp *new_opp;=0A=
>>>> +	unsigned long old_freq, new_freq;=0A=
>>>> +	int ret;=0A=
>>>> +=0A=
>>>> +	new_opp =3D devfreq_recommended_opp(dev, freq, flags);=0A=
>>>> +	if (IS_ERR(new_opp)) {=0A=
>>>> +		ret =3D PTR_ERR(new_opp);=0A=
>>>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);=0A=
>>>> +		return ret;=0A=
>>>> +	}=0A=
>>>> +	dev_pm_opp_put(new_opp);=0A=
>>>> +=0A=
>>>> +	old_freq =3D clk_get_rate(priv->dram_core);=0A=
>>>> +	if (*freq =3D=3D old_freq)=0A=
>>>> +		return 0;=0A=
>>>> +=0A=
>>>> +	freq_info =3D imx8m_ddrc_find_freq(priv, *freq);=0A=
>>>> +	if (!freq_info)=0A=
>>>> +		return -EINVAL;=0A=
>>>> +	ret =3D imx8m_ddrc_set_freq(dev, freq_info);=0A=
>>>=0A=
>>> Need to check whether 'ret' is valid or not.=0A=
>>>=0A=
>>>> +=0A=
>>>> +	/* Also read back the clk rate to verify switch was correct */=0A=
>>>> +	new_freq =3D clk_get_rate(priv->dram_core);=0A=
>>>> +	if (ret || *freq !=3D new_freq)=0A=
>>>=0A=
>>> You should check 'ret' right after imx8m_ddrc_set_freq()=0A=
>>> instead of this position.=0A=
>>=0A=
>> OK, I can add two error paths.=0A=
>>=0A=
>>>> +		dev_err(dev, "ddrc failed freq set to %lu from %lu, now at %lu\n",=
=0A=
>>>> +			old_freq, *freq, new_freq);=0A=
>>>> +	else=0A=
>>>> +		dev_dbg(dev, "ddrc freq set to %lu (was %lu)\n",=0A=
>>>> +			*freq, old_freq);=0A=
>>>> +=0A=
>>>> +	return ret;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long =
*freq)=0A=
>>>> +{=0A=
>>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>>> +=0A=
>>>> +	*freq =3D clk_get_rate(priv->dram_core);=0A=
>>>> +=0A=
>>>> +	return 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +static int imx8m_ddrc_init_freq_info(struct device *dev)=0A=
>>>> +{=0A=
>>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>>> +	struct arm_smccc_res res;=0A=
>>>> +	int index;=0A=
>>>> +=0A=
>>>> +	/*=0A=
>>>> +	 * An error here means DDR DVFS API not supported by firmware=0A=
>>>> +	 */=0A=
>>>=0A=
>>> Don't need to add multiple line comments. It is possible to be change a=
s following:=0A=
>>>=0A=
>>> 	/* An error here means DDR DVFS API not supported by firmware */=0A=
>>=0A=
>> OK.=0A=
>>>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_COUNT,=0A=
>>>> +			0, 0, 0, 0, 0, 0, &res);=0A=
>>>> +	priv->freq_count =3D res.a0;=0A=
>>>> +	if (priv->freq_count <=3D 0 ||=0A=
>>>> +			priv->freq_count > IMX8M_DDRC_MAX_FREQ_COUNT)=0A=
>>>> +		return -ENODEV;=0A=
>>>> +=0A=
>>>> +	for (index =3D 0; index < priv->freq_count; ++index) {=0A=
>>>> +		struct imx8m_ddrc_freq *freq =3D &priv->freq_table[index];=0A=
>>>> +=0A=
>>>> +		arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_INFO,=0A=
>>>> +				index, 0, 0, 0, 0, 0, &res);=0A=
>>>> +		/* Result should be strictly positive */=0A=
>>>> +		if ((long)res.a0 <=3D 0)=0A=
>>>> +			return -ENODEV;=0A=
>>>> +=0A=
>>>> +		freq->rate =3D res.a0;=0A=
>>>> +		freq->smcarg =3D index;=0A=
>>>> +		freq->dram_core_parent_index =3D res.a1;=0A=
>>>> +		freq->dram_alt_parent_index =3D res.a2;=0A=
>>>> +		freq->dram_apb_parent_index =3D res.a3;=0A=
>>>> +=0A=
>>>> +		/* dram_core has 2 options: dram_pll or dram_alt_root */=0A=
>>>> +		if (freq->dram_core_parent_index !=3D 1 &&=0A=
>>>> +				freq->dram_core_parent_index !=3D 2)=0A=
>>>> +			return -ENODEV;=0A=
>>>> +		/* dram_apb and dram_alt have exactly 8 possible parents */=0A=
>>>> +		if (freq->dram_alt_parent_index > 8 ||=0A=
>>>> +				freq->dram_apb_parent_index > 8)=0A=
>>>> +			return -ENODEV;=0A=
>>>> +		/* dram_core from alt requires explicit dram_alt parent */=0A=
>>>> +		if (freq->dram_core_parent_index =3D=3D 2 &&=0A=
>>>> +				freq->dram_alt_parent_index =3D=3D 0)=0A=
>>>> +			return -ENODEV;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	return 0;=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +/* imx8m_ddrc_check_opps() - disable OPPs not supported by firmware *=
/=0A=
>>>=0A=
>>> nitpick:=0A=
>>> On this driver, there are no some description for internal function.=0A=
>>> In order to keep the coding style, you better to move this comment=0A=
>>> into function before 'freq =3D ULONG_MAX'.=0A=
>>=0A=
>> Is it a problem if only some internal functions have documentation? I=0A=
>> can add docs to more functions.=0A=
> =0A=
> It is not problem. It is just preferable way to add the comment.=0A=
> Usually, if the function is public and exported, I added the detailed=0A=
> function comment as following example of devfreq_add_device().=0A=
> =0A=
> /**=0A=
>   656  * devfreq_add_device() - Add devfreq feature to the device=0A=
>   657  * @dev:        the device to add devfreq feature.=0A=
>   658  * @profile:    device-specific profile to run devfreq.=0A=
>   659  * @governor_name:      name of the policy to choose frequency.=0A=
>   660  * @data:       private data for the governor. The devfreq framewor=
k does not=0A=
>   661  *              touch this value.=0A=
>   662  */=0A=
>   663 struct devfreq *devfreq_add_device(struct device *dev,=0A=
>   664                                    struct devfreq_dev_profile *prof=
ile,=0A=
>   665                                    const char *governor_name,=0A=
>   666                                    void *data)=0A=
> =0A=
> =0A=
> Otherwise, if function is used in the only local with static keyword,=0A=
> usually I don't add the above detailed description. Instead,=0A=
> add the detailed comment into the function.=0A=
> =0A=
> It is not the standard way. Just preferable way for the function descript=
ion=0A=
> if possible.=0A=
> =0A=
> =0A=
> =0A=
>>=0A=
>> BTW: how can I generate devfreq documentation from these comments?=0A=
>>=0A=
