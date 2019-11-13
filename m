Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7431CFB115
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 14:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMNK0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 08:10:26 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:55054
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbfKMNK0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 08:10:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jok8u2FZlbN7/3OrN8OdDLQG96FpNNE6Oa+/Y34xeYTyt0JB+yxAm3Uf1R/ltBOcTSk95t4NFs6RnkF8X2ec3lg40mMyIDFyhnBFEJ38GhWfB9c2/FDW4J7xikjRaSmKfZggMKjh8LIf0ww557pMDjiQ74RISyRD5CAfe2y19rMXuCcOBe6NE/X4KJROYyOdIFPQfpcgqh5vCCBrmLY1GeyxLGiIi3frEhPGqDg0i+rxm9QHAwgk5dG01Nauk8M0QNBw3eWYATnEeyT6ix6uz6jDBs2kNZWuq/Ghy0QkdIbnSX12NKAT89b2wAwkE3oGQwL0jN5NjhVlU/2dxJhW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc9L/4HCVZPbv6qxOp8w0MsaOoissAp0hMBih0R54wQ=;
 b=oNaC874ZT78EmMYhVVRfGeS6JJjBJJAz3XC89BdYXuGFR84+6fbDNQyMXNLL67uFUpCalE49iDvlG/yHue595ZgvkJjqYz3txMvAIzlao3R6IFVk6GvkMyk/qmrkPwOCmBQUJ9WTE86znV6CpQ1knVc7kwWYwqnardqRrBpQMUwNuMwGPZMyd8awuFQkQya3vbZ92A7j/4E+7ZvNLupj+edzXbpukCLsjFieIHeyCDG1J2GIjTAlXQPWqJHGwtjxMJcsdbOSoGJjGZw6fMGciyoWY/oVk1gWV1xaAM7VuX2p/spl7s31d6vNriuVKW5PcKTXX/C+rGwvVtS7ZJUtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc9L/4HCVZPbv6qxOp8w0MsaOoissAp0hMBih0R54wQ=;
 b=lqnuvzjCRfFeGJKx8+GvytJ+b6XAcUHRjotAntQULXleI+rygPuY3iihZGeOt4vNZ05P4kkdo/ghZBbnvn0INR32ZJKj4u3TAMKyrzJNqPEgX7tKFzY5ZMcOnW20fNuXBqNlulOirHjHPZLiveXjj2HiGIl4WW//+H7O5owftOw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6862.eurprd04.prod.outlook.com (52.133.244.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 13:10:10 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 13:10:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Thread-Topic: [PATCH v5 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Thread-Index: AQHVmaNOsaN7UjD1dEWSlMW3gWLuow==
Date:   Wed, 13 Nov 2019 13:10:10 +0000
Message-ID: <VI1PR04MB70238C187E23AFAA6DB3281CEE760@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573595318.git.leonard.crestez@nxp.com>
 <CGME20191112215123epcas5p47d93a1e1837accf16ba0430963d03858@epcas5p4.samsung.com>
 <d33acdcc043ce12713a9279636e32d039da5ee54.1573595319.git.leonard.crestez@nxp.com>
 <0c416a08-811d-f3bc-af37-9e182f7c4d37@samsung.com>
 <6d9ace7b-3177-9bb2-82e6-7ee47f0fdf1c@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27005398-4bce-4ff8-6b77-08d7683ad053
x-ms-traffictypediagnostic: VI1PR04MB6862:|VI1PR04MB6862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6862F755AA6505DE72B80597EE760@VI1PR04MB6862.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(51444003)(6506007)(66066001)(66476007)(52536014)(446003)(7696005)(66446008)(64756008)(478600001)(54906003)(66556008)(26005)(476003)(6436002)(76116006)(91956017)(5660300002)(66946007)(71200400001)(33656002)(9686003)(74316002)(486006)(316002)(71190400001)(44832011)(7736002)(305945005)(99286004)(14454004)(7416002)(55016002)(6116002)(3846002)(2906002)(229853002)(25786009)(186003)(102836004)(8676002)(81166006)(81156014)(4326008)(8936002)(76176011)(6246003)(86362001)(14444005)(53546011)(110136005)(30864003)(256004)(32563001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6862;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffrXmrjxZDzH6P+QdMFYttjgieYnnde6WfV+rDd2VMUZeicu5s3vr4NlF5pKhevRghAiyHaMf2w7OfxVcQXYOET2ZDDaMrH7x37DEUH3KmXqoSqOasfiEUbxzKCz7JwHbO0PPe70lTFdweOybyLjOd2l0w2xumCL9MjqJJOMZPxprr3+JmJYu/IBbaPuatJX6WXbls8ULcDXfANiILlJswNeSyUujMNjgFffHZ4dNa/Pq+zMGnWpbN/KFVMEtujycokVlPJZySDgKsQsghovZ36bpEzXOla8jV45hSOSPVkGApRkJOHxWn+nx9+C/25uNCS1FjVbmuCDHLl6D0zqpGG6k72nHOjerkvkswDfwkh8bBiG8E+q0XKuznGaZHcas6OKcc6E1DHckAfgjC/D6S7F+XcO/GreAyyQW5QT1OlQxKh9fegsG0eX1Hu/Sdh0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27005398-4bce-4ff8-6b77-08d7683ad053
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 13:10:10.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTQnuFjYee3F5P8zZLnTph2eUzC8ncbVOR+k9QS38Tl2JB0ErMqUEkZGRrd73DMJSscj6yD7fbwhE7Z2G0Z8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6862
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.11.2019 08:23, Chanwoo Choi wrote:=0A=
> On 11/13/19 11:30 AM, Chanwoo Choi wrote:=0A=
>> Hi Leonard,=0A=
>>=0A=
>> On 11/13/19 6:50 AM, Leonard Crestez wrote:=0A=
>>> Add driver for dynamic scaling the DDR Controller on imx8m chips. Actua=
l=0A=
>>> frequency switching is implemented inside TF-A, this driver wraps the=
=0A=
>>> SMC calls and synchronizes the clk tree.=0A=
>>>=0A=
>>> The DRAM clocks on imx8m have the following structure (abridged):=0A=
>>>=0A=
>>>   +----------+       |\            +------+=0A=
>>>   | dram_pll |-------|M| dram_core |      |=0A=
>>>   +----------+       |U|---------->| D    |=0A=
>>>                   /--|X|           |  D   |=0A=
>>>     dram_alt_root |  |/            |   R  |=0A=
>>>                   |                |    C |=0A=
>>>              +---------+           |      |=0A=
>>>              |FIX DIV/4|           |      |=0A=
>>>              +---------+           |      |=0A=
>>>    composite:     |                |      |=0A=
>>>   +----------+    |                |      |=0A=
>>>   | dram_alt |----/                |      |=0A=
>>>   +----------+                     |      |=0A=
>>>   | dram_apb |-------------------->|      |=0A=
>>>   +----------+                     +------+=0A=
>>>=0A=
>>> The dram_pll is used for higher rates and dram_alt is used for lower=0A=
>>> rates. The dram_alt and dram_apb clocks are "imx composite" and their=
=0A=
>>> parent can also be modified.=0A=
>>>=0A=
>>> This driver will prepare/enable the new parents ahead of switching (so=
=0A=
>>> that the expected roots are enabled) and afterwards it will call=0A=
>>> clk_set_parent to ensure the parents in clock framework are up-to-date.=
=0A=
>>>=0A=
>>> The driver relies on dram_pll dram_alt and dram_apb being marked with=
=0A=
>>> CLK_GET_RATE_NOCACHE for rate updates.=0A=
>>>=0A=
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>> ---=0A=
>>>   drivers/devfreq/Kconfig      |   9 +=0A=
>>>   drivers/devfreq/Makefile     |   1 +=0A=
>>>   drivers/devfreq/imx8m-ddrc.c | 460 ++++++++++++++++++++++++++++++++++=
+=0A=
>>>   3 files changed, 470 insertions(+)=0A=
>>>   create mode 100644 drivers/devfreq/imx8m-ddrc.c=0A=
>>>=0A=
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig=0A=
>>> index 066e6c4efaa2..923a6132e741 100644=0A=
>>> --- a/drivers/devfreq/Kconfig=0A=
>>> +++ b/drivers/devfreq/Kconfig=0A=
>>> @@ -89,10 +89,19 @@ config ARM_EXYNOS_BUS_DEVFREQ=0A=
>>>   	  Each memory bus group could contain many memoby bus block. It read=
s=0A=
>>>   	  PPMU counters of memory controllers by using DEVFREQ-event device=
=0A=
>>>   	  and adjusts the operating frequencies and voltages with OPP suppor=
t.=0A=
>>>   	  This does not yet operate with optimal voltages.=0A=
>>>   =0A=
>>> +config ARM_IMX8M_DDRC_DEVFREQ=0A=
>>> +	tristate "i.MX8M DDRC DEVFREQ Driver"=0A=
>>> +	depends on ARCH_MXC || COMPILE_TEST=0A=
>>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND=0A=
>>> +	select DEVFREQ_GOV_USERSPACE=0A=
>>> +	help=0A=
>>> +	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allo=
ws=0A=
>>> +	  adjusting DRAM frequency.=0A=
>>> +=0A=
>>>   config ARM_TEGRA_DEVFREQ=0A=
>>>   	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"=0A=
>>>   	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \=0A=
>>>   		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \=0A=
>>>   		ARCH_TEGRA_210_SOC || \=0A=
>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile=0A=
>>> index 338ae8440db6..3eb4d5e6635c 100644=0A=
>>> --- a/drivers/devfreq/Makefile=0A=
>>> +++ b/drivers/devfreq/Makefile=0A=
>>> @@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+=3D governor_pow=
ersave.o=0A=
>>>   obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor_userspace.o=0A=
>>>   obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=3D governor_passive.o=0A=
>>>   =0A=
>>>   # DEVFREQ Drivers=0A=
>>>   obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o=0A=
>>> +obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+=3D imx8m-ddrc.o=0A=
>>>   obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+=3D rk3399_dmc.o=0A=
>>>   obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra30-devfreq.o=0A=
>>>   obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+=3D tegra20-devfreq.o=0A=
>>>   =0A=
>>>   # DEVFREQ Event Drivers=0A=
>>> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.=
c=0A=
>>> new file mode 100644=0A=
>>> index 000000000000..62abb9b79d8a=0A=
>>> --- /dev/null=0A=
>>> +++ b/drivers/devfreq/imx8m-ddrc.c=0A=
>>> @@ -0,0 +1,460 @@=0A=
>>> +// SPDX-License-Identifier: GPL-2.0=0A=
>>> +/*=0A=
>>> + * Copyright 2019 NXP=0A=
>>> + */=0A=
>>> +=0A=
>>> +#include <linux/module.h>=0A=
>>> +#include <linux/device.h>=0A=
>>> +#include <linux/of_device.h>=0A=
>>> +#include <linux/platform_device.h>=0A=
>>> +#include <linux/devfreq.h>=0A=
>>> +#include <linux/pm_opp.h>=0A=
>>> +#include <linux/clk.h>=0A=
>>> +#include <linux/clk-provider.h>=0A=
>>> +#include <linux/arm-smccc.h>=0A=
>>> +=0A=
>>> +#define IMX_SIP_DDR_DVFS			0xc2000004=0A=
>>> +=0A=
>>> +/* Values starting from 0 switch to specific frequency */=0A=
>>> +#define IMX_SIP_DDR_FREQ_SET_HIGH		0x00=0A=
>>> +=0A=
>>> +/* Deprecated after moving IRQ handling to ATF */=0A=
>>> +#define IMX_SIP_DDR_DVFS_WAIT_CHANGE		0x0F=0A=
>>> +=0A=
>>> +/* Query available frequencies. */=0A=
>>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_COUNT		0x10=0A=
>>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_INFO		0x11=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * This should be in a 1:1 mapping with devicetree OPPs but=0A=
>>> + * firmware provides additional info.=0A=
>>> + */=0A=
>>> +struct imx8m_ddrc_freq {=0A=
>>> +	unsigned long rate;=0A=
>>> +	unsigned long smcarg;=0A=
>>> +	int dram_core_parent_index;=0A=
>>> +	int dram_alt_parent_index;=0A=
>>> +	int dram_apb_parent_index;=0A=
>>> +};=0A=
>>> +=0A=
>>> +/* Hardware limitation */=0A=
>>> +#define IMX8M_DDRC_MAX_FREQ_COUNT 4=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * i.MX8M DRAM Controller clocks have the following structure (abridge=
d):=0A=
>>> + *=0A=
>>> + * +----------+       |\            +------+=0A=
>>> + * | dram_pll |-------|M| dram_core |      |=0A=
>>> + * +----------+       |U|---------->| D    |=0A=
>>> + *                 /--|X|           |  D   |=0A=
>>> + *   dram_alt_root |  |/            |   R  |=0A=
>>> + *                 |                |    C |=0A=
>>> + *            +---------+           |      |=0A=
>>> + *            |FIX DIV/4|           |      |=0A=
>>> + *            +---------+           |      |=0A=
>>> + *  composite:     |                |      |=0A=
>>> + * +----------+    |                |      |=0A=
>>> + * | dram_alt |----/                |      |=0A=
>>> + * +----------+                     |      |=0A=
>>> + * | dram_apb |-------------------->|      |=0A=
>>> + * +----------+                     +------+=0A=
>>> + *=0A=
>>> + * The dram_pll is used for higher rates and dram_alt is used for lowe=
r rates.=0A=
>>> + *=0A=
>>> + * Frequency switching is implemented in TF-A (via SMC call) and can c=
hange the=0A=
>>> + * configuration of the clocks, including mux parents. The dram_alt an=
d=0A=
>>> + * dram_apb clocks are "imx composite" and their parent can change too=
.=0A=
>>> + *=0A=
>>> + * We need to prepare/enable the new mux parents head of switching and=
 update=0A=
>>> + * their information afterwards.=0A=
>>> + */=0A=
>>> +struct imx8m_ddrc {=0A=
>>> +	struct devfreq_dev_profile profile;=0A=
>>> +	struct devfreq *devfreq;=0A=
>>> +=0A=
>>> +	/* For frequency switching: */=0A=
>>> +	struct clk *dram_core;=0A=
>>> +	struct clk *dram_pll;=0A=
>>> +	struct clk *dram_alt;=0A=
>>> +	struct clk *dram_apb;=0A=
>>> +=0A=
>>> +	int freq_count;=0A=
>>> +	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];=0A=
>>> +};=0A=
>>> +=0A=
>>> +static struct imx8m_ddrc_freq *imx8m_ddrc_find_freq(struct imx8m_ddrc =
*priv,=0A=
>>> +						    unsigned long rate)=0A=
>>> +{=0A=
>>> +	struct imx8m_ddrc_freq *freq;=0A=
>>> +	int i;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Firmware reports values in MT/s, so we round-down from Hz=0A=
>>> +	 * Rounding is extra generous to ensure a match.=0A=
>>> +	 */=0A=
>>> +	rate =3D DIV_ROUND_CLOSEST(rate, 250000);=0A=
>>> +	for (i =3D 0; i < priv->freq_count; ++i) {=0A=
>>> +		freq =3D &priv->freq_table[i];=0A=
>>> +		if (freq->rate =3D=3D rate ||=0A=
>>> +				freq->rate + 1 =3D=3D rate ||=0A=
>>> +				freq->rate - 1 =3D=3D rate)=0A=
>>> +			return freq;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	return NULL;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static void imx8m_ddrc_smc_set_freq(int target_freq)=0A=
>>> +{=0A=
>>> +	struct arm_smccc_res res;=0A=
>>> +	u32 online_cpus =3D 0;=0A=
>>> +	int cpu;=0A=
>>> +=0A=
>>> +	local_irq_disable();=0A=
>>> +=0A=
>>> +	for_each_online_cpu(cpu)=0A=
>>> +		online_cpus |=3D (1 << (cpu * 8));=0A=
>>> +=0A=
>>> +	/* change the ddr freqency */=0A=
>>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,=0A=
>>> +			0, 0, 0, 0, 0, &res);=0A=
>>> +=0A=
>>> +	local_irq_enable();=0A=
>>> +}=0A=
>>> +=0A=
>>> +struct clk *clk_get_parent_by_index(struct clk *clk, int index)=0A=
>>> +{=0A=
>>> +	struct clk_hw *hw;=0A=
>>> +=0A=
>>> +	hw =3D clk_hw_get_parent_by_index(__clk_get_hw(clk), index);=0A=
>>> +=0A=
>>> +	return hw ? hw->clk : NULL;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int imx8m_ddrc_set_freq(struct device *dev, struct imx8m_ddrc_f=
req *freq)=0A=
>>> +{=0A=
>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>> +	struct clk *new_dram_core_parent;=0A=
>>> +	struct clk *new_dram_alt_parent;=0A=
>>> +	struct clk *new_dram_apb_parent;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Fetch new parents=0A=
>>> +	 *=0A=
>>> +	 * new_dram_alt_parent and new_dram_apb_parent are optional but=0A=
>>> +	 * new_dram_core_parent is not.=0A=
>>> +	 */=0A=
>>> +	new_dram_core_parent =3D clk_get_parent_by_index(=0A=
>>> +			priv->dram_core, freq->dram_core_parent_index - 1);=0A=
>>> +	if (!new_dram_core_parent) {=0A=
>>> +		dev_err(dev, "failed to fetch new dram_core parent\n");=0A=
>>> +		return -EINVAL;=0A=
>>> +	}=0A=
>>> +	if (freq->dram_alt_parent_index) {=0A=
>>> +		new_dram_alt_parent =3D clk_get_parent_by_index(=0A=
>>> +				priv->dram_alt,=0A=
>>> +				freq->dram_alt_parent_index - 1);=0A=
>>> +		if (!new_dram_alt_parent) {=0A=
>>> +			dev_err(dev, "failed to fetch new dram_alt parent\n");=0A=
>>> +			return -EINVAL;=0A=
>>> +		}=0A=
>>> +	} else=0A=
>>> +		new_dram_alt_parent =3D NULL;=0A=
>>> +=0A=
>>> +	if (freq->dram_alt_parent_index) {=0A=
>>> +		new_dram_apb_parent =3D clk_get_parent_by_index(=0A=
>>> +				priv->dram_apb, freq->dram_apb_parent_index - 1);=0A=
>>> +		if (!new_dram_alt_parent) {=0A=
>>> +			dev_err(dev, "failed to fetch new dram_apb parent\n");=0A=
>>> +			return -EINVAL;=0A=
>>> +		}=0A=
>>> +	} else=0A=
>>> +		new_dram_apb_parent =3D NULL;=0A=
>>> +=0A=
>>> +	/* increase reference counts and ensure clks are ON before switch */=
=0A=
>>> +	ret =3D clk_prepare_enable(new_dram_core_parent);=0A=
>>> +	if (ret) {=0A=
>>> +		dev_err(dev, "failed enable new dram_core parent: %d\n", ret);=0A=
>>=0A=
>> s/failed enable/failed to enable=0A=
>>=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +	ret =3D clk_prepare_enable(new_dram_alt_parent);=0A=
>>> +	if (ret) {=0A=
>>> +		dev_err(dev, "failed enable new dram_alt parent: %d\n", ret);=0A=
>>=0A=
>> s/failed enable/failed to enable=0A=
>>=0A=
>>> +		goto out_disable_core_parent;=0A=
>>> +	}=0A=
>>> +	ret =3D clk_prepare_enable(new_dram_apb_parent);=0A=
>>> +	if (ret) {=0A=
>>> +		dev_err(dev, "failed enable new dram_apb parent: %d\n", ret);=0A=
>>=0A=
>> s/failed enable/failed to enable=0A=
>>=0A=
>>> +		goto out_disable_alt_parent;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	imx8m_ddrc_smc_set_freq(freq->smcarg);=0A=
>>> +=0A=
>>> +	/* update parents in clk tree after switch. */=0A=
>>> +	ret =3D clk_set_parent(priv->dram_core, new_dram_core_parent);=0A=
>>> +	if (ret)=0A=
>>> +		dev_warn(dev, "failed set dram_core parent: %d\n", ret);=0A=
>>=0A=
>> s/failed set/failed to set=0A=
>>=0A=
>>> +	if (new_dram_alt_parent) {=0A=
>>> +		ret =3D clk_set_parent(priv->dram_alt, new_dram_alt_parent);=0A=
>>> +		if (ret)=0A=
>>> +			dev_warn(dev, "failed set dram_alt parent: %d\n", ret);=0A=
>>=0A=
>> s/failed set/failed to set=0A=
>>=0A=
>>> +	}=0A=
>>> +	if (new_dram_apb_parent) {=0A=
>>> +		ret =3D clk_set_parent(priv->dram_apb, new_dram_apb_parent);=0A=
>>> +		if (ret)=0A=
>>> +			dev_warn(dev, "failed set dram_apb parent: %d\n", ret);=0A=
>>=0A=
>> s/failed set/failed to set=0A=
=0A=
OK, but this might make a few messages longer than 80 chars.=0A=
=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Explicitly refresh dram PLL rate.=0A=
>>> +	 *=0A=
>>> +	 * Even if it's marked with CLK_GET_RATE_NOCACHE the rate will not be=
=0A=
>>> +	 * automatically refreshed when clk_get_rate is called on children.=
=0A=
>>> +	 */=0A=
>>> +	clk_get_rate(priv->dram_pll);=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * clk_set_parent transfer the reference count from old parent.=0A=
>>> +	 * now we drop extra reference counts used during the switch=0A=
>>> +	 */=0A=
>>> +	clk_disable_unprepare(new_dram_apb_parent);=0A=
>>> +out_disable_alt_parent:=0A=
>>> +	clk_disable_unprepare(new_dram_alt_parent);=0A=
>>> +out_disable_core_parent:=0A=
>>> +	clk_disable_unprepare(new_dram_core_parent);=0A=
>>> +out:=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, =
u32 flags)=0A=
>>> +{=0A=
>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>> +	struct imx8m_ddrc_freq *freq_info;=0A=
>>> +	struct dev_pm_opp *new_opp;=0A=
>>> +	unsigned long old_freq, new_freq;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	new_opp =3D devfreq_recommended_opp(dev, freq, flags);=0A=
>>> +	if (IS_ERR(new_opp)) {=0A=
>>> +		ret =3D PTR_ERR(new_opp);=0A=
>>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);=0A=
>>> +		return ret;=0A=
>>> +	}=0A=
>>> +	dev_pm_opp_put(new_opp);=0A=
>>> +=0A=
>>> +	old_freq =3D clk_get_rate(priv->dram_core);=0A=
>>> +	if (*freq =3D=3D old_freq)=0A=
>>> +		return 0;=0A=
>>> +=0A=
>>> +	freq_info =3D imx8m_ddrc_find_freq(priv, *freq);=0A=
>>> +	if (!freq_info)=0A=
>>> +		return -EINVAL;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Read back the clk rate to verify switch was correct and so that=0A=
>>> +	 * we can report it on all error paths.=0A=
>>> +	 */=0A=
>>> +	ret =3D imx8m_ddrc_set_freq(dev, freq_info);=0A=
>>> +=0A=
>>> +	new_freq =3D clk_get_rate(priv->dram_core);=0A=
>>> +	if (ret)=0A=
>>> +		dev_err(dev, "ddrc failed freq switch to %lu from %lu: error %d. now=
 at %lu\n",=0A=
>>> +			old_freq, *freq, ret, new_freq);=0A=
>>> +	else if (*freq !=3D new_freq)=0A=
>>> +		dev_err(dev, "ddrc failed freq update to %lu from %lu, now at %lu\n"=
,=0A=
>>> +			old_freq, *freq, new_freq);=0A=
>>=0A=
>> Actually, is it error? When use clk_set_rate with target_freq,=0A=
>> if target_freq is not same with supported clock of h/w clock,=0A=
>> the clk_set_rate set the similiar clock rate among the supported clock t=
able.=0A=
>>=0A=
>> It means that if the user of clock_set_rate() enters the unsupported clo=
ck rate,=0A=
>> the case of (*freq !=3D new_freq) happen.=0A=
>>=0A=
>> Are you sure that you want to show the error when this case (*freq !=3D =
new_freq)?=0A=
>> The your origin code is not wrong. Just question from me.=0A=
=0A=
The assumption here is that the OPP table will contain the precise =0A=
frequency as reported by clk_get_rate after a switch.=0A=
=0A=
For example imx8mq-evk.dts has an OPP of exactly 166935483 Hz.=0A=
=0A=
>>> +	else=0A=
>>> +		dev_dbg(dev, "ddrc freq set to %lu (was %lu)\n",=0A=
>>> +			*freq, old_freq);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *=
freq)=0A=
>>> +{=0A=
>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>> +=0A=
>>> +	*freq =3D clk_get_rate(priv->dram_core);=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int imx8m_ddrc_get_dev_status(struct device *dev,=0A=
>>> +				     struct devfreq_dev_status *stat)=0A=
>>=0A=
>> get_dev_status() callback is called by only simpleondemand governor.=0A=
>> When userspace governor is used, this function is never called.=0A=
>> So, need to drop this function and then add this function on next time.=
=0A=
=0A=
Then you get an oops on "echo simple_ondemand > governor".=0A=
=0A=
In theory the simple_ondemand governor could check for NULL =0A=
"get_dev_status" or devfreq core could reject switching to =0A=
simple_ondemand if no get_dev_status is implemented. For example a =0A=
devfreq_governor.validate callback could be implemented?=0A=
=0A=
But right now the "get_dev_status" callback is NOT optional.=0A=
=0A=
>>> +{=0A=
>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>> +=0A=
>>> +	stat->busy_time =3D 0;=0A=
>>> +	stat->total_time =3D 0;=0A=
>>> +	stat->current_frequency =3D clk_get_rate(priv->dram_core);=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int imx8m_ddrc_init_freq_info(struct device *dev)=0A=
>>> +{=0A=
>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>> +	struct arm_smccc_res res;=0A=
>>> +	int index;=0A=
>>> +=0A=
>>> +	/* An error here means DDR DVFS API not supported by firmware */=0A=
>>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_COUNT,=0A=
>>> +			0, 0, 0, 0, 0, 0, &res);=0A=
>>> +	priv->freq_count =3D res.a0;=0A=
>>> +	if (priv->freq_count <=3D 0 ||=0A=
>>> +			priv->freq_count > IMX8M_DDRC_MAX_FREQ_COUNT)=0A=
>>> +		return -ENODEV;=0A=
>>> +=0A=
>>> +	for (index =3D 0; index < priv->freq_count; ++index) {=0A=
>>> +		struct imx8m_ddrc_freq *freq =3D &priv->freq_table[index];=0A=
>>> +=0A=
>>> +		arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_INFO,=0A=
>>> +			      index, 0, 0, 0, 0, 0, &res);=0A=
>>> +		/* Result should be strictly positive */=0A=
>>> +		if ((long)res.a0 <=3D 0)=0A=
>>> +			return -ENODEV;=0A=
>>> +=0A=
>>> +		freq->rate =3D res.a0;=0A=
>>> +		freq->smcarg =3D index;=0A=
>>> +		freq->dram_core_parent_index =3D res.a1;=0A=
>>> +		freq->dram_alt_parent_index =3D res.a2;=0A=
>>> +		freq->dram_apb_parent_index =3D res.a3;=0A=
>>> +=0A=
>>> +		/* dram_core has 2 options: dram_pll or dram_alt_root */=0A=
>>> +		if (freq->dram_core_parent_index !=3D 1 &&=0A=
>>> +				freq->dram_core_parent_index !=3D 2)=0A=
>>> +			return -ENODEV;=0A=
>>> +		/* dram_apb and dram_alt have exactly 8 possible parents */=0A=
>>> +		if (freq->dram_alt_parent_index > 8 ||=0A=
>>> +				freq->dram_apb_parent_index > 8)=0A=
>>> +			return -ENODEV;=0A=
>>> +		/* dram_core from alt requires explicit dram_alt parent */=0A=
>>> +		if (freq->dram_core_parent_index =3D=3D 2 &&=0A=
>>> +				freq->dram_alt_parent_index =3D=3D 0)=0A=
>>> +			return -ENODEV;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int imx8m_ddrc_check_opps(struct device *dev)=0A=
>>> +{=0A=
>>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>> +	struct imx8m_ddrc_freq *freq_info;=0A=
>>> +	struct dev_pm_opp *opp;=0A=
>>> +	unsigned long freq;=0A=
>>> +=0A=
>>> +	/* Enumerate DT OPPs and disable those not supported by firmware */=
=0A=
>>> +	freq =3D ULONG_MAX;=0A=
>>> +	while (true) {=0A=
> =0A=
> You can get the number of OPP entries int the opp table=0A=
> with dev_pm_opp_get_count(dev). I think that better to=0A=
> use the correct number of OPP entries instead of 'while(true)' style.=0A=
=0A=
I need to enumerate frequencies and there's no "get_freq_by_index" in =0A=
opp core that I can find so I'd still need to use =0A=
dev_pm_opp_find_freq_floor.=0A=
=0A=
It's strange that OPP core doesn't offer additional support for =0A=
enumerating OPPs like a for_each macro?=0A=
=0A=
>>> +		opp =3D dev_pm_opp_find_freq_floor(dev, &freq);=0A=
>>> +		if (opp =3D=3D ERR_PTR(-ERANGE))=0A=
>>> +			break;=0A=
>>> +		if (IS_ERR(opp)) {=0A=
>>> +			dev_err(dev, "Failed enumerating OPPs: %ld\n",=0A=
>>> +				PTR_ERR(opp));=0A=
>>> +			return PTR_ERR(opp);=0A=
>>> +		}=0A=
>>> +		dev_pm_opp_put(opp);=0A=
>>> +=0A=
>>> +		freq_info =3D imx8m_ddrc_find_freq(priv, freq);=0A=
>>> +		if (!freq_info) {=0A=
>>> +			dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",=0A=
>>> +					freq, DIV_ROUND_CLOSEST(freq, 250000));=0A=
>>> +			dev_pm_opp_disable(dev, freq);=0A=
>>> +		}=0A=
>>> +=0A=
>>> +		freq--;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static void imx8m_ddrc_exit(struct device *dev)=0A=
>>> +{=0A=
>>> +	dev_pm_opp_of_remove_table(dev);=0A=
>>> +}=0A=
>>> +=0A=
>>> +static int imx8m_ddrc_probe(struct platform_device *pdev)=0A=
>>> +{=0A=
>>> +	struct device *dev =3D &pdev->dev;=0A=
>>> +	struct imx8m_ddrc *priv;=0A=
>>> +	const char *gov =3D DEVFREQ_GOV_USERSPACE;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);=0A=
>>> +	if (!priv)=0A=
>>> +		return -ENOMEM;=0A=
>>> +=0A=
>>> +	platform_set_drvdata(pdev, priv);=0A=
>>> +=0A=
>>> +	ret =3D imx8m_ddrc_init_freq_info(dev);=0A=
>>> +	if (ret) {=0A=
>>> +		dev_err(dev, "failed to init firmware freq info: %d\n", ret);=0A=
>>> +		return ret;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	priv->dram_core =3D devm_clk_get(dev, "core");=0A=
>>> +	priv->dram_pll =3D devm_clk_get(dev, "pll");=0A=
>>> +	priv->dram_alt =3D devm_clk_get(dev, "alt");=0A=
>>> +	priv->dram_apb =3D devm_clk_get(dev, "apb");=0A=
>>> +	if (IS_ERR(priv->dram_core) ||=0A=
>>> +		IS_ERR(priv->dram_pll) ||=0A=
>>> +		IS_ERR(priv->dram_alt) ||=0A=
>>> +		IS_ERR(priv->dram_apb)) {=0A=
>>> +		ret =3D PTR_ERR(priv->devfreq);=0A=
>>> +		dev_err(dev, "failed to fetch clocks: %d\n", ret);=0A=
>>> +		return ret;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	ret =3D dev_pm_opp_of_add_table(dev);=0A=
>>> +	if (ret < 0) {=0A=
>>> +		dev_err(dev, "failed to get OPP table\n");=0A=
>>> +		return ret;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	ret =3D imx8m_ddrc_check_opps(dev);=0A=
>>> +	if (ret < 0)=0A=
>>> +		goto err;=0A=
>>> +=0A=
>>> +	priv->profile.polling_ms =3D 1000;=0A=
>>> +	priv->profile.target =3D imx8m_ddrc_target;=0A=
>>> +	priv->profile.get_dev_status =3D imx8m_ddrc_get_dev_status;=0A=
>>=0A=
>> ditto. It is not used on this patch. On later, add the get_dev_status=0A=
>> for the ondemand governor.=0A=
>>=0A=
>>> +	priv->profile.exit =3D imx8m_ddrc_exit;=0A=
>>> +	priv->profile.get_cur_freq =3D imx8m_ddrc_get_cur_freq;=0A=
>>> +	priv->profile.initial_freq =3D clk_get_rate(priv->dram_core);=0A=
>>> +=0A=
>>> +	priv->devfreq =3D devm_devfreq_add_device(dev, &priv->profile,=0A=
>>> +						gov, NULL);=0A=
>>> +	if (IS_ERR(priv->devfreq)) {=0A=
>>> +		ret =3D PTR_ERR(priv->devfreq);=0A=
>>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);=0A=
>>> +		goto err;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +=0A=
>>> +err:=0A=
>>> +	dev_pm_opp_of_remove_table(dev);=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>> +static const struct of_device_id imx8m_ddrc_of_match[] =3D {=0A=
>>> +	{ .compatible =3D "fsl,imx8m-ddrc", },=0A=
>>> +	{ /* sentinel */ },=0A=
>>> +};=0A=
>>> +MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);=0A=
>>> +=0A=
>>> +static struct platform_driver imx8m_ddrc_platdrv =3D {=0A=
>>> +	.probe		=3D imx8m_ddrc_probe,=0A=
>>> +	.driver =3D {=0A=
>>> +		.name	=3D "imx8m-ddrc-devfreq",=0A=
>>> +		.of_match_table =3D of_match_ptr(imx8m_ddrc_of_match),=0A=
>>> +	},=0A=
>>> +};=0A=
>>> +module_platform_driver(imx8m_ddrc_platdrv);=0A=
>>> +=0A=
>>> +MODULE_DESCRIPTION("i.MX8M DDR Controller frequency driver");=0A=
>>> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");=0A=
>>> +MODULE_LICENSE("GPL v2");=0A=
