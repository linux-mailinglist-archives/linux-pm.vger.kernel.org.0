Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B929121FD4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 01:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfLQAfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 19:35:02 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63578 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfLQAfB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 19:35:01 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191217003458epoutp047e1953bf47d2383795cfed28b47f7b99~hAWnE7GWX1425914259epoutp04u
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 00:34:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191217003458epoutp047e1953bf47d2383795cfed28b47f7b99~hAWnE7GWX1425914259epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576542898;
        bh=0Hi0iKXO/pl07y+g9P0AKETobeg4g1d3JvBl8msibjY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aYfafqAJdz0I7/xS5A3urePVf8aKdzba5BngmrmjV+sGViy3cOQ7lyu2ATmyv7ioB
         l1LqOvjIMtBjsJqVeYczw2dVPlC7jx0QNn5/8HstMJZNq7fl1WEeVv1pZp4GwZ47vD
         f0fjNWu6mFa0x4Ol3dNm0XgSZToQ0GEc5IJvouaE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191217003457epcas1p488817b0e039b8e1d3ca57dd290b5cdb0~hAWmPp8171969619696epcas1p4g;
        Tue, 17 Dec 2019 00:34:57 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47cK0Z6lWDzMqYkV; Tue, 17 Dec
        2019 00:34:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.BF.52419.EA228FD5; Tue, 17 Dec 2019 09:34:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191217003454epcas1p3ed40f9280119b335f96be4b0b5427690~hAWjaZ5271490214902epcas1p3t;
        Tue, 17 Dec 2019 00:34:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191217003454epsmtrp1a2407a4407c8d32283e003b784c7505b~hAWjZQJIB1563415634epsmtrp1j;
        Tue, 17 Dec 2019 00:34:54 +0000 (GMT)
X-AuditID: b6c32a37-a10cb9c00001ccc3-45-5df822aefbc4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.81.10238.EA228FD5; Tue, 17 Dec 2019 09:34:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191217003453epsmtip161dd5499623792662829f40c8da403ac~hAWi4yG9K1021610216epsmtip1H;
        Tue, 17 Dec 2019 00:34:53 +0000 (GMT)
Subject: Re: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <698357b4-32e7-7f4b-3e67-59f5890f574a@samsung.com>
Date:   Tue, 17 Dec 2019 09:41:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB702396D09FCED6CBA49B6AE7EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwbZRzH8/Su1wPtPMqQZ2RqObc/RgR6lMKzZSwmbnrOzeA2FzU2eGkv
        FOlbeoU4XbQaQWhQhgYWOrexMAiwjdHSsPJmY0G7bsLspqUTyZzd3DRzczIcQRFbrov89/m9
        fH9vTx4SU/TKssgKs523mTkjTaTiA2MbVLm99LxWdaC+CM2dPwdQ58WvALrXPISh2JVpgM60
        6tDR8UkpcvdP4+jgqIdAPc2DOLpwoU+GJj64JUNdM3elyBOLSJFzoRtDsx+PA9QxFZagSFeT
        FM32xQAKn9uGpt/vItCJyS8JdPheM4ZqRsdlyBlYJNC/ETeObnozUUd7BEPuOfbptWyzswuw
        J4+cBOydaI2MPeQI42ybp4r19NQT7I+REYLtP/4e677tk7CNiyp2YSyD/cTbA9hZz+Ol8tcq
        Nxt4Ts/blLxZZ9FXmMtL6Bd2lz1TpilSMbnMRlRMK82ciS+ht+4ozX22whi/B62s5oxVcVcp
        Jwh0/pbNNkuVnVcaLIK9hOateqN1ozVP4ExClbk8T2cxbWJUqgJNPPGNSkNvJCy1Rl95a6ml
        XeIAp1gnSCEhVQijtUHgBKmkgvIBONX4adL4E8Cl1impaPwFYJuvRfJA0lA3JBMDowDWHx9O
        Su4AeD+0CBJZ6dQueOx0N57g1dSrcGT40jJj1DckHL5uSTBB5UD/zSiR4EeobPj9fCyuJUk5
        tQV+7X834cap9fDu6B/SBGdQe2Fo4MPl8nIqDYZary2XTKG08IjfLxHLZ8Ifrh1N8hPwzO+f
        Y4nZIOUlYeOxWkzcYCtscQ7iIqfD34JemchZ8NfG2iS/A7tD44QorgPQ6/9WKgbU0N/xmSQx
        KEZtgKeH8kV3Nhz8+zAQG6+Ct+capIkUSMlhXa1CTHkSXvppJnnENbD9o3riAKBdK9ZxrVjB
        tWIF1//N2gDeAx7lrYKpnBcYq3rla3vA8l/JKfaBvskdAUCRgH5Ybq2+r1VIuWphnykAIInR
        q+U+Zdwl13P73uZtljJblZEXAkATv3YTlpWhs8R/ntlexmgK1Go1KmSKNAxDZ8rJ+bBWQZVz
        dr6S56287YFOQqZkOYBrQv+FASrWxMb2F6jn3XseO3H18kXbSN/VtLSHbnQ+j4IlTOvBgV7r
        2ctro+tqGH8wOHPqu7Pb9XvfbNgU2r5N+dzolOGKxJDbv/DirT3Fuhs/r6pwPCXpCh6yaHT5
        E4GdL+1+fef51OudS7skZr++UDm9P73pH7L+5bxqxy8Z2UYtjQsGjsnBbAL3H6Vu9YtBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3cuO0qjkxd81dIcSCRkWlJvVBJEcKgvlmBamA49TGmba0dN
        I9IUQ5dpRVquvIQX1MzLNK/J8I5m6symZRI6CxOtbGprealNA7/9+D//y5eHwmxyCCcqUhbN
        KmQiiZC0xus7hC77K4XGYK+VWQFaet0HUMlwF0CLWc0Y0n8aB6ghJwzldw4QqKZ2HEePWtUk
        Ks9qwtHgYDUfvUma46PSiQUCqfU6AilNZRgy3O0EqHhUy0O60vsEMlTrAdL2nUbjt0pJ9Hyg
        jUS5i1kYSmnt5CNl+yqJ1nQ1OJqpc0DFhToM1SwxJ3cxWcpSwFTkVQDm+1gKn3mSqMWZAnUM
        oy5PI5mPulckU1uUwNR8a+QxmatejKnDnsmoKweMQe3iJ7hofTyclUTGsooDvqHWEZU6LSEf
        C4xbzy7kJYIXjBJYUZD2gempzXwlsKZs6BYAk3X9YOPgCLO1XZgSUP/YFnZ0cBueeQBvp84R
        Zo8tfR4+qyrDzWxHB8Ger4uE2YTRQxQcUhk2W0cw2PBgytJK0h5QMzNGmnkH7QbfGfXAvCCg
        fWG35qZZxml3uND6wzJgTwfApiI9z8wCeifszZm2jFnRwTBPo7HoGL0XruQNYxvsAD9M52/q
        rrBh/il2D9iqtsRVWyKqLRHVlkgBwMuBIyvnpGIp5y33lrHXPDmRlIuRiT3DoqRqYHkYj32N
        4G1RSDugKSDcLoDRv4JtCFEsFy9tB5DChHaCxj3/JEG4KP46q4gKUcRIWK4dOFO40EHwWdYd
        ZEOLRdHsFZaVs4r/Vx5l5ZQIxO/tVIV+ve7dJ1Ibi42aU8I76GxfQuzVyUOm4ZaUc8E99bYF
        OdU+mZLZPn6Jf/9R16r0+WlxfVruQMCxy5LRI/67152TjHH8VEeRsS38z0jzpYbll78NZQcH
        LwTQE5O9N0yeLVNry4HJvtsyzvjOm7TTg4dDh+UuX6of/nR7bMcJcS5C5O2BKTjRX2dd2cgs
        AwAA
X-CMS-MailID: 20191217003454epcas1p3ed40f9280119b335f96be4b0b5427690
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191114201049epcas5p4a24607634af7b31e6a2dbdb4166dd862
References: <cover.1573761527.git.leonard.crestez@nxp.com>
        <CGME20191114201049epcas5p4a24607634af7b31e6a2dbdb4166dd862@epcas5p4.samsung.com>
        <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
        <8734a934-79e2-7445-c3e5-a0bb59afd4a8@samsung.com>
        <047990a5-263d-d447-7f0a-77a99e4b1f63@samsung.com>
        <25e3177f-e2b9-6be4-cfb8-24f87ccba45b@samsung.com>
        <VI1PR04MB702396D09FCED6CBA49B6AE7EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/16/19 11:57 PM, Leonard Crestez wrote:
> On 16.12.2019 03:00, Chanwoo Choi wrote:
>> Hi,
>>
>> Also, I think that 'devfreq' word is not proper for device driver name.
>> imx-bus.c or imx-noc.c or others to inform the role of this driver of developer.
> 
> I'll rename to "imx-bus". Calling it "imx-noc" is not appropriate 
> because I also want to use it for PL301 NICs.

OK.

> 
>> And, I have a question.
>> This driver adds the devfreq device with either passive governor
>> or userspace governor.
>>
>> As I understood, the devfreq device with passive governor
>> will be operated with imx8m-ddrc.c driver.
>> But, when is operating with userspace governor?
> 
> There are multiple scalable buses inside the SOC, for example there's a 
> NIC for display controllers and one for (pci+usb). They can use 
> userspace governor for explicit frequency control.
> 
>> I think that you better to add the explanation to description
>> for two scenarios how to operate with interconnect provider
>> on either passive governor or userspace governor usage case.
> 
> I'll elaborate the example in bindings.

OK.

> 
>> On 12/13/19 10:51 AM, Chanwoo Choi wrote:
>>> On 12/13/19 10:30 AM, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:
>>>>> Add initial support for dynamic frequency switching on pieces of the imx
>>>>> interconnect fabric.
>>>>>
>>>>> All this driver does is set a clk rate based on an opp table, it does
>>>>> not map register areas.
>>>>>
>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>>> ---
>>>>>   drivers/devfreq/Kconfig       |   9 ++
>>>>>   drivers/devfreq/Makefile      |   1 +
>>>>>   drivers/devfreq/imx-devfreq.c | 150 ++++++++++++++++++++++++++++++++++
>>>>>   3 files changed, 160 insertions(+)
>>>>>   create mode 100644 drivers/devfreq/imx-devfreq.c
>>>>>
>>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>>>> index 923a6132e741..fef5ce831e90 100644
>>>>> --- a/drivers/devfreq/Kconfig
>>>>> +++ b/drivers/devfreq/Kconfig
>>>>> @@ -98,10 +98,19 @@ config ARM_IMX8M_DDRC_DEVFREQ
>>>>>   	select DEVFREQ_GOV_USERSPACE
>>>>>   	help
>>>>>   	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
>>>>>   	  adjusting DRAM frequency.
>>>>>   
>>>>> +config ARM_IMX_DEVFREQ
>>>>> +	tristate "i.MX Generic DEVFREQ Driver"
>>>>> +	depends on ARCH_MXC || COMPILE_TEST
>>>>> +	select DEVFREQ_GOV_PASSIVE
>>>>> +	select DEVFREQ_GOV_USERSPACE
>>>>> +	help
>>>>> +	  This adds the generic DEVFREQ driver for i.MX interconnects. It
>>>>> +	  allows adjusting NIC/NOC frequency.
>>>>> +
>>>>>   config ARM_TEGRA_DEVFREQ
>>>>>   	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>>>>>   	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>>>>>   		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>>>>>   		ARCH_TEGRA_210_SOC || \
>>>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>>>>> index 3eb4d5e6635c..61d0edee16f7 100644
>>>>> --- a/drivers/devfreq/Makefile
>>>>> +++ b/drivers/devfreq/Makefile
>>>>> @@ -8,10 +8,11 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>>>>>   obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>>>>   
>>>>>   # DEVFREQ Drivers
>>>>>   obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>>>>   obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>>>>> +obj-$(CONFIG_ARM_IMX_DEVFREQ)		+= imx-devfreq.o
>>>>>   obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>>>>>   obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>>>>>   obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>>>>>   
>>>>>   # DEVFREQ Event Drivers
>>>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
>>>>> new file mode 100644
>>>>> index 000000000000..620b344e87aa
>>>>> --- /dev/null
>>>>> +++ b/drivers/devfreq/imx-devfreq.c
>>>>> @@ -0,0 +1,150 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Copyright 2019 NXP
>>>>> + */
>>>>> +
>>>>> +#include <linux/clk.h>
>>>>> +#include <linux/devfreq.h>
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/of_device.h>
>>>>> +#include <linux/pm_opp.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/slab.h>
>>>>> +
>>>>> +struct imx_devfreq {
>>>>> +	struct devfreq_dev_profile profile;
>>>>> +	struct devfreq *devfreq;
>>>>> +	struct clk *clk;
>>>>> +	struct devfreq_passive_data passive_data;
>>>>> +};
>>>>> +
>>>>> +static int imx_devfreq_target(struct device *dev,
>>>>> +			      unsigned long *freq, u32 flags)
>>>>
>>>> Don't use space for the indentation. Please use only tab.
> 
> OK
> 
>>>>> +{
>>>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>>>> +	struct dev_pm_opp *new_opp;
>>>>> +	unsigned long new_freq;
>>>>> +	int ret;
>>>>> +
>>>>> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>> +	if (IS_ERR(new_opp)) {
>>>>> +		ret = PTR_ERR(new_opp);
>>>>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +	new_freq = dev_pm_opp_get_freq(new_opp);
>>>>> +	dev_pm_opp_put(new_opp);
>>>>> +
>>>>> +	return clk_set_rate(priv->clk, new_freq);
>>>>> +}
>>>>> +
>>>>> +static int imx_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
>>>>> +{
>>>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>>>> +
>>>>> +	*freq = clk_get_rate(priv->clk);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int imx_devfreq_get_dev_status(struct device *dev,
>>>>> +				      struct devfreq_dev_status *stat)
>>>>
>>>> ditto. Please use tab for the indentation.
>>>>
>>>>> +{
>>>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>>>> +
>>>>> +	stat->busy_time = 0;
>>>>> +	stat->total_time = 0;
>>>>> +	stat->current_frequency = clk_get_rate(priv->clk);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static void imx_devfreq_exit(struct device *dev)
>>>>> +{
>>>>> +	dev_pm_opp_of_remove_table(dev);
>>>>> +}
>>>>> +
>>>>> +static int imx_devfreq_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +	struct imx_devfreq *priv;
>>>>
>>>> How about changing the variable name 'priv' to 'imx' or 'imx_data'?
>>>> because it is not easy to catch the role of 'priv' from variable name.
> 
> The name "priv" refers to private data of current device: it is short 
> and not ambiguous in this context. I don't think that mentioning "imx" 
> adds any additional useful information.
> 
> It doesn't seem like there's much of a convention for "local variable 
> containing private data", for example exynos-bus.c uses "struct 
> exynos_bus* bus" internally.

OK. it is nitpick. Keep your style.

> 
>>>>
>>>>> +	const char *gov = DEVFREQ_GOV_USERSPACE;
>>>>> +	void *govdata = NULL;
>>>>
>>>> How about changing the variable name 'govdata' to 'gov_data'?
>>>> - govdata -> gov_data
> 
> OK
> 
>>>>> +	int ret;
>>>>> +
>>>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>>> +	if (!priv)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	priv->clk = devm_clk_get(dev, NULL);
>>>>
>>>> nitpick: because the clock-name is not mandatory.
>>>> Don't need to specify the clock name to inform the role of clock
>>>> of other developer/user?
>>>>
>>>> For example, "ddr", "bus" and so on.
> 
> I'll call this bus, but I'm not sure it's useful when a single clock is 
> involved.
> 
>>> And, this driver doesn't include the 'clk_prepare_enable'.
>>> how to enable the clock?
> 
> Clocks are either always on or perhaps controlled by some other 
> peripheral. This driver only provides scaling.

It is not proper use-case of clock. If device driver
want to control the clock, it have to be enabled on device driver.

Even it clock is always, the user don't know the state of clock.
Also, user can't know what kind of device driver control the clock.

It have to be controlled on this device driver
before changing the clock frequency.

> 
>>>>> +	if (IS_ERR(priv->clk)) {
>>>>> +		ret = PTR_ERR(priv->clk);
>>>>> +		dev_err(dev, "failed to fetch clk: %d\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +	platform_set_drvdata(pdev, priv);
>>>>> +
>>>>> +	ret = dev_pm_opp_of_add_table(dev);
>>>>> +	if (ret < 0) {
>>>>> +		dev_err(dev, "failed to get OPP table\n");
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	priv->profile.polling_ms = 1000;
>>>>> +	priv->profile.target = imx_devfreq_target;
>>>>> +	priv->profile.get_dev_status = imx_devfreq_get_dev_status;
>>>>> +	priv->profile.exit = imx_devfreq_exit;
>>>>> +	priv->profile.get_cur_freq = imx_devfreq_get_cur_freq;
>>>>> +	priv->profile.initial_freq = clk_get_rate(priv->clk);
>>>>> +
>>>>> +	/* Handle passive devfreq parent link */
>>>>> +	priv->passive_data.parent = devfreq_get_devfreq_by_phandle(dev, 0);
>>>>> +	if (!IS_ERR(priv->passive_data.parent)) {
>>>>> +		dev_info(dev, "setup passive link to %s\n",
>>>>> +			 dev_name(priv->passive_data.parent->dev.parent));
>>>>> +		gov = DEVFREQ_GOV_PASSIVE;
>>>>> +		govdata = &priv->passive_data;
>>>>> +	} else if (priv->passive_data.parent != ERR_PTR(-ENODEV)) {
>>>>> +		// -ENODEV means no parent: not an error.
>>>>> +		ret = PTR_ERR(priv->passive_data.parent);
>>>>> +		if (ret != -EPROBE_DEFER)
>>>>> +			dev_warn(dev, "failed to get initialize passive parent: %d\n",
>>>>> +				 ret);
>>>>> +		goto err;
>>>>> +	}
>>>>
>>>> You better to change the exception handling as following: It is more simple.
>>>>
>>>> 	} else if (PTR_ERR(priv->passive_data.parent) == -EPROBE_DEFER)
>>>> 			|| PTR_ERR(priv->passive_data.parent) == -ENODEV) {
>>>> 		goto err;
>>>> 	} else {
>>>> 		ret = PTR_ERR(priv->passive_data.parent);
>>>> 		dev_err(dev, "failed to get initialize passive parent: %d\n", ret);
>>>> 		goto err;
>>>> 	}
> 
> But -ENODEV is not an error, it means no passive parent was found.

OK. just I want to make 'if statement' more simple. This style
is complicated.

> 
>>>>> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
>>>>> +						gov, govdata);
>>>>> +	if (IS_ERR(priv->devfreq)) {
>>>>> +		ret = PTR_ERR(priv->devfreq);
>>>>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);
>>>>> +		goto err;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +err:
>>>>> +	dev_pm_opp_of_remove_table(dev);
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static const struct of_device_id imx_devfreq_of_match[] = {
>>>>> +	{ .compatible = "fsl,imx8m-noc", },
>>>>> +	{ .compatible = "fsl,imx8m-nic", },
>>>>> +	{ /* sentinel */ },
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
>>>>> +
>>>>> +static struct platform_driver imx_devfreq_platdrv = {
>>>>> +	.probe		= imx_devfreq_probe,
>>>>> +	.driver = {
>>>>> +		.name	= "imx-devfreq",
>>>>> +		.of_match_table = of_match_ptr(imx_devfreq_of_match),
>>>>> +	},
>>>>> +};
>>>>> +module_platform_driver(imx_devfreq_platdrv);
>>>>> +
>>>>> +MODULE_DESCRIPTION("Generic i.MX bus frequency driver");
>>>>
>>>> If this driver is for bus frequency, you better to use 'bus' for the clock-name
>>>> for the readability.
> 
> OK
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
