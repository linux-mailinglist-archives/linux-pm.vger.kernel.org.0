Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E199E10E774
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 10:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLBJMV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 04:12:21 -0500
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:6867
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfLBJMV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 04:12:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxYSKdSp71zxbDWyvB+lUJ+YLkNgP1r/7HuMwFgce4JRY+Iv6cPlRo1BniBmurjDvF5N6Ssu/b8S/RjdFL4UBjpZ03uULB7tAmaCyWUwE+nDZrKS7F+pQ/VY6MhsJqvb/GwPaKYGSghySuj5E3hfVNbyA4QM8+6wJOFpq6F4zoikoe9RmSCo5t3kLhiWh/2mJaHN8R24it2mUrkocWc24YqzaH7+/3ofRfvm2+a3GeEDaAGlQl8LyudxVj7Xe1Jbu0+9Lhp23njoXsUlDm3ZrI0VsU6QS55Edu/xwqkI3Qh0epUeJCDRk4d6cwT9pg/fpSn2yLJaQNc3DhO4SDDTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1lAghbsehuGUkObX/2N39noCyI7M2frzmfou/uP8/s=;
 b=D/L9wCZ5uCZHTTJiJAlmnOicIy0vouOaRWFD4Htzo6sQgvyZWKQGV+wvjQz915fCCOQJYi41HtlBQFxLS0vDSG0H9Biq494txj6s6CcFNs/YrQ/+cnjvSOfDz9ei+oKjXOMM9D9nUyLFZzHzJnuievm4ib7p6CeV6CN7Iawo9cafvzQXIBTEIjsL/JK8vqyEcjZZbEzGhHOtZGTYueuX38m5LgX+6+o9bNlhWFrlU2mtOwu9biN913UeLX9cpBZtNGEkqo/19OgvrP5/hK6C04btpnTpinEv5owklPJi5H5MuSYAWzn9LuoiudCr78Dtx3LB1HmR05DA/Npa3p+SrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1lAghbsehuGUkObX/2N39noCyI7M2frzmfou/uP8/s=;
 b=ETut1sO0AwpcCjz9auFQ9Nw7sKN0NKfMTRPk7fHkbAPfrTULLN/8dcYe/T5CLYMKWjA1uEBQasifp09Qw9k4Lu2Mqza/jbHnmhxDuYGmeDsc4WC8S0l/74YWkesNhFCOpDLPIYVLqr6IFYsxHWI/4aII+B1TX9P/QjoLzPJTxrM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4224.eurprd04.prod.outlook.com (52.134.122.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 09:12:13 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 09:12:12 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
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
Subject: Re: [PATCH v3 4/6] PM / devfreq: Add dynamic scaling for imx ddr
 controller
Thread-Topic: [PATCH v3 4/6] PM / devfreq: Add dynamic scaling for imx ddr
 controller
Thread-Index: AQHVkDU751yT9FzEn0iAYnZvaAii3w==
Date:   Mon, 2 Dec 2019 09:12:12 +0000
Message-ID: <VI1PR04MB70234400D6CF248C18321FDBEE430@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1572558427.git.leonard.crestez@nxp.com>
 <5fcf829265ecde1af32cb1369528c97361c76992.1572558427.git.leonard.crestez@nxp.com>
 <20191202053847.GC9767@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5718e995-a24e-4822-663a-08d77707b7e3
x-ms-traffictypediagnostic: VI1PR04MB4224:|VI1PR04MB4224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB42246E50A4262B5E61B861A5EE430@VI1PR04MB4224.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:289;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(199004)(189003)(316002)(2906002)(8936002)(54906003)(110136005)(305945005)(74316002)(81166006)(81156014)(7736002)(25786009)(3846002)(6116002)(99286004)(8676002)(26005)(66066001)(4326008)(44832011)(14444005)(256004)(446003)(14454004)(6436002)(71200400001)(71190400001)(33656002)(6246003)(186003)(86362001)(229853002)(478600001)(64756008)(966005)(66446008)(66556008)(66476007)(66946007)(76176011)(7696005)(76116006)(53546011)(91956017)(6506007)(102836004)(5660300002)(6306002)(55016002)(9686003)(52536014)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4224;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3zAas3Y0OC+W9ocksV5y89GwgG8A0kJXSxkR0mIulGXBLbQhzYcAzso35XQ3AxNktMDcFmkUNfYaLoLQ9UpyEHamENq29NGkGzJd0G7Sl+fhaaiABSyPRgXHZIf3QgJhAOEgLpxRtHDHpSo7k1fyANdiOPrKw5qJEY5FyvUqYVP7VpoHtKzrHPRn+Zs8LQ1GcTWCW4r48W964d+fXyn0jAG73F903XGaMuXDm0qBhzOHyIdG1oAaYifziLjBQqZ7v9zlV7yHyFfPIr5SzbWJtKh+zLiEfujF/l5XBqQ7YjpayNllstz4XZjFBgiAywTsmre6qp/VeFL7gaCWyVhCjBFsegwIsgiAXA+0Kgc8dsJsnOpTVHniNn4pbbaNrUX6rdrnMj/GTQuatnyMXJ11ISThVY8KP31wij6HiV32Ty/HBdwlIGO6OJ1H3DY/2vFk73xGnaEoYPS2MP0+m+sp6a8GER+6U8QuFiFW7hU2rA=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5718e995-a24e-4822-663a-08d77707b7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 09:12:12.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOrvi4VQh6iSbWirD49Ten+f5zibfkJMCsK88205W/Fips7VbB08GYhqU4j+77a8bjgLFMcpKU2HgDwr0Uli9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-12-02 7:39 AM, Shawn Guo wrote:=0A=
> On Thu, Oct 31, 2019 at 11:50:25PM +0200, Leonard Crestez wrote:=0A=
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
=0A=
A more recent version of this patch is already in next:=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=
=3Ddevfreq-next&id=3D518e99e2a22e318944d531a92aab5082fabb4d38=0A=
=0A=
>>   drivers/devfreq/Makefile   |   1 +=0A=
>>   drivers/devfreq/imx-ddrc.c | 430 +++++++++++++++++++++++++++++++++++++=
=0A=
>>   2 files changed, 431 insertions(+)=0A=
>>   create mode 100644 drivers/devfreq/imx-ddrc.c=0A=
=0A=
>> +++ b/drivers/devfreq/imx-ddrc.c=0A=
>> @@ -0,0 +1,430 @@=0A=
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
> =0A=
> This is a header that should ideally be used by clock drivers only.=0A=
> =0A=
>> +#include <linux/arm-smccc.h>=0A=
>> +=0A=
>> +#define IMX_SIP_DDR_DVFS			0xc2000004=0A=
>> +=0A=
>> +/* Values starting from 0 switch to specific frequency */=0A=
>> +#define IMX_SIP_DDR_FREQ_SET_HIGH		0x00=0A=
>> +=0A=
>> +/* Deprecated after moving IRQ handling to ATF */=0A=
>> +#define IMX_SIP_DDR_DVFS_WAIT_CHANGE		0x0F=0A=
> =0A=
> These two defines are not used.  Will be?=0A=
=0A=
No, can post a separate patch to remove them.=0A=
> =0A=
>> +=0A=
>> +/* Query available frequencies. */=0A=
>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_COUNT		0x10=0A=
>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_INFO		0x11=0A=
>> +=0A=
>> +/*=0A=
>> + * This should be in a 1:1 mapping with devicetree OPPs but=0A=
>> + * firmware provides additional info.=0A=
>> + */=0A=
>> +struct imx_ddrc_freq {=0A=
>> +	unsigned long rate;=0A=
>> +	unsigned long smcarg;=0A=
>> +	int dram_core_parent_index;=0A=
>> +	int dram_alt_parent_index;=0A=
>> +	int dram_apb_parent_index;=0A=
>> +};=0A=
>> +=0A=
>> +/* Hardware limitation */=0A=
>> +#define IMX_DDRC_MAX_FREQ_COUNT 4=0A=
>> +=0A=
>> +/*=0A=
>> + * imx DRAM controller=0A=
>> + *=0A=
>> + * imx DRAM controller clocks have the following structure (abridged):=
=0A=
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
>> +struct imx_ddrc {=0A=
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
>> +	struct imx_ddrc_freq freq_table[IMX_DDRC_MAX_FREQ_COUNT];=0A=
>> +};=0A=
>> +=0A=
=0A=
... snip ...=0A=
=0A=
>> +static void imx_ddrc_smc_set_freq(int target_freq)=0A=
>> +{=0A=
>> +	struct arm_smccc_res res;=0A=
>> +	u32 online_cpus =3D 0;=0A=
>> +	int cpu;=0A=
>> +=0A=
>> +	local_irq_disable();=0A=
>> +=0A=
>> +	for_each_online_cpu(cpu)=0A=
>> +		online_cpus |=3D (1 << (cpu * 8));=0A=
> =0A=
> Nit: one level of unnecessary parentheses.=0A=
=0A=
Yes=0A=
=0A=
>> +=0A=
>> +	/* change the ddr freqency */=0A=
>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,=0A=
>> +			0, 0, 0, 0, 0, &res);=0A=
>> +=0A=
>> +	local_irq_enable();=0A=
>> +}=0A=
>> +=0A=
>> +struct clk *clk_get_parent_by_index(struct clk *clk, int index)=0A=
>> +{=0A=
>> +	struct clk_hw *hw;=0A=
>> +=0A=
>> +	hw =3D clk_hw_get_parent_by_index(__clk_get_hw(clk), index);=0A=
> =0A=
> Okay, this is why you need clk-provider.h.  But this=0A=
> clk_get_parent_by_index() function looks completely generic, and should=
=0A=
> be proposed to clock core?=0A=
=0A=
There are very few driver users of clk_hw_get_parent_by_index:=0A=
=0A=
$ git grep -wl clk_hw_get_parent_by_index |grep -v drivers/clk=0A=
arch/mips/alchemy/common/clock.c=0A=
drivers/cpufreq/qoriq-cpufreq.c=0A=
drivers/devfreq/imx8m-ddrc.c=0A=
drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c=0A=
drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c=0A=
drivers/media/platform/atmel/atmel-isc-base.c=0A=
drivers/rtc/rtc-ac100.c=0A=
include/linux/clk-provider.h=0A=
=0A=
Even clk_get_parent has few users and it contains this strange comment:=0A=
=0A=
/* TODO: Create a per-user clk and change callers to call clk_put */=0A=
=0A=
That proposed change effectively creates a new API? I didn't want to add =
=0A=
a new clk core API with unclear semantics.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
