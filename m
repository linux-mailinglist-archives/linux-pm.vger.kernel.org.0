Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6E7123DB0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 04:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLRDIo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 22:08:44 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:33153 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRDIo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 22:08:44 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191218030840epoutp0251fcd3dd303e4cccba9762f944542496~hWGGY2nSS2661826618epoutp02a
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2019 03:08:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191218030840epoutp0251fcd3dd303e4cccba9762f944542496~hWGGY2nSS2661826618epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576638520;
        bh=xn49s49OtlLDMzIknCw0bNKStJXTULf/wwxXcFls5lw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LpKvTTTqqbnVsVDXf3ziFiJhPGSmdGvdqM+vVolqm6mvlLouSCWNI/7zEVOb9+XPt
         3QCuJr5qqAFBh5/lUOu+ZgWktW7WpzWEJqRH6IPi20nW4rHyJoAn/Ci1tFQ5e8ocMy
         CZDdmaLzCrSP58WJeEsm78nh/CQC+gh+ciyRi0K0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191218030839epcas1p159ab1ed2ec1dddfb968c70e3f464ba17~hWGFjK8G42733727337epcas1p1y;
        Wed, 18 Dec 2019 03:08:39 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47d0MT2QG8zMqYkX; Wed, 18 Dec
        2019 03:08:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.D3.52419.53899FD5; Wed, 18 Dec 2019 12:08:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191218030835epcas1p3c4dd6079de65e9b68f3709daf2d54345~hWGB6ygBe1631216312epcas1p3r;
        Wed, 18 Dec 2019 03:08:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191218030835epsmtrp1479f4098e72a5263e9b49677e631ea4d~hWGB5lg5A2833328333epsmtrp1E;
        Wed, 18 Dec 2019 03:08:35 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-6e-5df998353643
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.80.10238.33899FD5; Wed, 18 Dec 2019 12:08:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191218030835epsmtip118a3939e951d66a5a4f057eb5828a3aa~hWGBdc3Wd1193811938epsmtip1B;
        Wed, 18 Dec 2019 03:08:35 +0000 (GMT)
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
Message-ID: <f4267efa-1345-4fab-e6a7-73fca674dd72@samsung.com>
Date:   Wed, 18 Dec 2019 12:15:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023F0CCD7FAF5EEA74C7873EE500@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wTZxjHfXvt9SCrnlXoKyETzu0PuiAtpfC62M6oW87MJeg2FrcQvLQX
        aOiv9Fqjc4m4IELncG5hSJkTcZ1Q2UoLqagwNihR3IZUZjEyohkuYRMkWHDiAtu1xzL++zzP
        832e532eNw+Byb+RphEmq5N1WBkzhSeLQ/1ZOdna0wvFqkA9ieZ/vAHQ17cGAJqru4KhiXtj
        AF1qMKCz4SEJCnSMiVF9TxBHvrrLYnTzZrsU/fzhlBS1jM9KUHAiKkHuZ60Yin0cBsg7GhGh
        aMspCYq1TwAUufEqGjvagqOLQz/g6MxcHYaO9YSlyN23iKOlaECMJjsVyHs+iqHAPL0tna5z
        twC67cs2QM/cOSalGysiYrop6KKDvhqc/jXajdMdXx2hA4+6RPTJRRX9rD+Fru30AToWfL5Q
        9m751jKWMbKODNZqsBlN1lId9fqbJTtKtPkqdbZ6CyqgMqyMhdVRO3cXZr9mMvP7oDIOMGYX
        7ypkOI7K0W912FxONqPMxjl1FGs3mu1b7Js5xsK5rKWbDTbLy2qVKlfLC/eXlzV2DEjsYcvB
        xuZmaQV4vM8NCAKSebCqe4cbJBFysgvAqPclN0jm+TGAkckBXDCe8IGGeXFcFU+InV4QC4Ee
        XjX+GxCMGQC/exiSxlXryL3wnL81kbGe3Ae7r44kGCN/IuDV321xxkkl7J28g8d5DZkJbz+d
        AHGWkXp4b/Rhoo6YfBHOVs4lOIUsgoOhymXNWjjY8CBRM4ksht96/bhQXwHvPjgrEngjvDT9
        BRZ/HCS/5/veal4eYSdsmxrFBF4H/7zWKRU4Df5xsmqZD8PWwTAuJFcD2Nk7LBECGtjr/UwU
        Xx5GZkH/lRzBnQkv/30GCI1Xw0fzJyTCfmWwukouSDbBkfvjIoE3wPPHa/BPAOVZMY5nxQie
        FSN4/m/WBMQ+kMraOUspy6ntmpWfHQSJU1EWdIH2od19gCQA9ZxMtWqhWC5hDnCHLH0AEhi1
        XjZWzbtkRubQ+6zDVuJwmVmuD2j5bZ/C0lIMNv7wrM4StTZXo9GgPHW+Vq2mFDLiaaRYTpYy
        TracZe2s4788EZGUVgGOHFwa8ZCZ8sPKz9d+sPFCQZLiL3vTC2D7Bbaoyx7DZodDRl9q6qrk
        o9cV44v67Mn8PZL+6bvbwqtDNQW/LOmiTwy+t6X1J16Bw/6PNvh3Vb1xG5lym95T1n56nXtn
        /z+V1XunPHpd70ztW7o8Sn9t+3T68cFz9x2RNUWmrPSLlQpKzJUxaiXm4Jh/Afl3NmJABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGe3fOzo7T0XEavvaxahGVULoKegmTSKKTVESQZWA17DBLt8aO
        LjWYFvY16EPK1Fm6dMZcVm5a6UyqbWZqWbOalpbFlBx92iZkaeQ2Av9dPPd1P8+fh8SEZdzZ
        5EFFFqNSSDPFBB+/axeLlq8qHU+Na6ldica6OgG63tMGkK/YiiH3YD9A98rSUKWjm4vMDf04
        Kmm1EMhU3Iyj58/reejZ8S88ZHw3ykUWt4uLtL9rMeQ96wCoptfJQS5jERd5690AOTs3ov5j
        RgLd6H5EoKu+YgydaHXwkNY2SaC/LjOORhqjUE21C0PmMXr9XLpYawR0XUUdoL/3neDR5QVO
        nNZbsmmL6QxBD7juE3SDIZ82f2vi0Ocn4+jf9ln0uUYToL0W0XbBHn78ASbzoJpRxSbs56eX
        N7RxlQ55TnlVFa8A/EzRghASUquht3Qc1wI+KaRaANR3fcKCQTS87GybYnKKI6DdzgadrwC+
        6XjC8TsR1A547XYt7udIKgW2e3xcv4RRL0j4Qufl+QMhNYDDom8ZfiaoGPhgpI/w80xqIXz9
        yw38LKAS4GDv54CPU4vhaKEvwLOoZNhscHOCTjjsKBsKHAuhUuGtmtuBPRi1BE5U9GBBjoJv
        hyo5QZ4P7329gl0AEbppdd20im5aRTetoge4CUQzSlYuk7MSpUTBHFnBSuVstkK2Iu2w3AIC
        DxOzrAm8NOyzAYoE4jBB3IzxVCFXqmZz5TYASUwcKeg/PTUSHJDm5jGqw/tU2ZkMawNzSFwc
        JRhWPE4RUjJpFpPBMEpG9T/lkCGzC4B+04e9Va+3HFrzMHFbfETsB1mYedHHkpLwzT1Ld221
        7Tyf7NGkV1pP9Q5qQnc/PZmRqF63QS/ylO6VcIrUxieioQXDmxSv8tCpO4xVPe9lfeHI3Rk/
        NJfOJp1LW9ualGzoDuX/aXmvkeVMXBBV23Pzuy4mLfawJe1bTh+1PrvZ2XhIjLPpUkkMpmKl
        /wBzi+OYLAMAAA==
X-CMS-MailID: 20191218030835epcas1p3c4dd6079de65e9b68f3709daf2d54345
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
        <698357b4-32e7-7f4b-3e67-59f5890f574a@samsung.com>
        <VI1PR04MB7023F0CCD7FAF5EEA74C7873EE500@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/18/19 6:05 AM, Leonard Crestez wrote:
> On 17.12.2019 02:35, Chanwoo Choi wrote:
>> On 12/16/19 11:57 PM, Leonard Crestez wrote:
>>> On 16.12.2019 03:00, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> Also, I think that 'devfreq' word is not proper for device driver name.
>>>> imx-bus.c or imx-noc.c or others to inform the role of this driver of developer.
>>>
>>> I'll rename to "imx-bus". Calling it "imx-noc" is not appropriate
>>> because I also want to use it for PL301 NICs.
>>
>> OK.
>>
>>>
>>>> And, I have a question.
>>>> This driver adds the devfreq device with either passive governor
>>>> or userspace governor.
>>>>
>>>> As I understood, the devfreq device with passive governor
>>>> will be operated with imx8m-ddrc.c driver.
>>>> But, when is operating with userspace governor?
>>>
>>> There are multiple scalable buses inside the SOC, for example there's a
>>> NIC for display controllers and one for (pci+usb). They can use
>>> userspace governor for explicit frequency control.
>>>
>>>> I think that you better to add the explanation to description
>>>> for two scenarios how to operate with interconnect provider
>>>> on either passive governor or userspace governor usage case.
>>>
>>> I'll elaborate the example in bindings.
>>
>> OK.
>>
>>>
>>>> On 12/13/19 10:51 AM, Chanwoo Choi wrote:
>>>>> On 12/13/19 10:30 AM, Chanwoo Choi wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:
>>>>>>> Add initial support for dynamic frequency switching on pieces of the imx
>>>>>>> interconnect fabric.
>>>>>>>
>>>>>>> All this driver does is set a clk rate based on an opp table, it does
>>>>>>> not map register areas.
>>>>>>>
>>>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>>>>> ---
>>>>>>>    drivers/devfreq/Kconfig       |   9 ++
>>>>>>>    drivers/devfreq/Makefile      |   1 +
>>>>>>>    drivers/devfreq/imx-devfreq.c | 150 ++++++++++++++++++++++++++++++++++
>>>>>>>    3 files changed, 160 insertions(+)
>>>>>>>    create mode 100644 drivers/devfreq/imx-devfreq.c
>>>>>>>
>>>>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>>>>>> index 923a6132e741..fef5ce831e90 100644
>>>>>>> --- a/drivers/devfreq/Kconfig
>>>>>>> +++ b/drivers/devfreq/Kconfig
>>>>>>> @@ -98,10 +98,19 @@ config ARM_IMX8M_DDRC_DEVFREQ
>>>>>>>    	select DEVFREQ_GOV_USERSPACE
>>>>>>>    	help
>>>>>>>    	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
>>>>>>>    	  adjusting DRAM frequency.
>>>>>>>    
>>>>>>> +config ARM_IMX_DEVFREQ
>>>>>>> +	tristate "i.MX Generic DEVFREQ Driver"
>>>>>>> +	depends on ARCH_MXC || COMPILE_TEST
>>>>>>> +	select DEVFREQ_GOV_PASSIVE
>>>>>>> +	select DEVFREQ_GOV_USERSPACE
>>>>>>> +	help
>>>>>>> +	  This adds the generic DEVFREQ driver for i.MX interconnects. It
>>>>>>> +	  allows adjusting NIC/NOC frequency.
>>>>>>> +
>>>>>>>    config ARM_TEGRA_DEVFREQ
>>>>>>>    	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>>>>>>>    	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>>>>>>>    		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>>>>>>>    		ARCH_TEGRA_210_SOC || \
>>>>>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>>>>>>> index 3eb4d5e6635c..61d0edee16f7 100644
>>>>>>> --- a/drivers/devfreq/Makefile
>>>>>>> +++ b/drivers/devfreq/Makefile
>>>>>>> @@ -8,10 +8,11 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>>>>>>>    obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>>>>>>    
>>>>>>>    # DEVFREQ Drivers
>>>>>>>    obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>>>>>>    obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>>>>>>> +obj-$(CONFIG_ARM_IMX_DEVFREQ)		+= imx-devfreq.o
>>>>>>>    obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>>>>>>>    obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>>>>>>>    obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>>>>>>>    
>>>>>>>    # DEVFREQ Event Drivers
>>>>>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..620b344e87aa
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/devfreq/imx-devfreq.c
>>>>>>> @@ -0,0 +1,150 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>> +/*
>>>>>>> + * Copyright 2019 NXP
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/clk.h>
>>>>>>> +#include <linux/devfreq.h>
>>>>>>> +#include <linux/device.h>
>>>>>>> +#include <linux/module.h>
>>>>>>> +#include <linux/of_device.h>
>>>>>>> +#include <linux/pm_opp.h>
>>>>>>> +#include <linux/platform_device.h>
>>>>>>> +#include <linux/slab.h>
>>>>>>> +
>>>>>>> +struct imx_devfreq {
>>>>>>> +	struct devfreq_dev_profile profile;
>>>>>>> +	struct devfreq *devfreq;
>>>>>>> +	struct clk *clk;
>>>>>>> +	struct devfreq_passive_data passive_data;
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int imx_devfreq_target(struct device *dev,
>>>>>>> +			      unsigned long *freq, u32 flags)
>>>>>>
>>>>>> Don't use space for the indentation. Please use only tab.
>>>
>>> OK
> 
> The spaces are required in order to align arguments to open paranthesis. 
> Should I drop that?
> 
> It seems that check_patch.pl and process/coding-style.rst doesn't have a 
> strong opinion on this; my personal preference is for long argument 
> lists to just use double indentation.

Generally, almost patches use the tab for the indentation.
I don't use space for the indentation. If use the tab
for the indentation, it is not harmful for the readability.

If use the space for the pretty to make the alignment between parameter,
I think it it not good.

> 
>>>>>>> +{
>>>>>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>>>>>> +	struct dev_pm_opp *new_opp;
>>>>>>> +	unsigned long new_freq;
>>>>>>> +	int ret;
>>>>>>> +
>>>>>>> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>>>> +	if (IS_ERR(new_opp)) {
>>>>>>> +		ret = PTR_ERR(new_opp);
>>>>>>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);
>>>>>>> +		return ret;
>>>>>>> +	}
>>>>>>> +	new_freq = dev_pm_opp_get_freq(new_opp);
>>>>>>> +	dev_pm_opp_put(new_opp);
>>>>>>> +
>>>>>>> +	return clk_set_rate(priv->clk, new_freq);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int imx_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
>>>>>>> +{
>>>>>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>>>>>> +
>>>>>>> +	*freq = clk_get_rate(priv->clk);
>>>>>>> +
>>>>>>> +	return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int imx_devfreq_get_dev_status(struct device *dev,
>>>>>>> +				      struct devfreq_dev_status *stat)
>>>>>>
>>>>>> ditto. Please use tab for the indentation.
>>>>>>
>>>>>>> +{
>>>>>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>>>>>> +
>>>>>>> +	stat->busy_time = 0;
>>>>>>> +	stat->total_time = 0;
>>>>>>> +	stat->current_frequency = clk_get_rate(priv->clk);
>>>>>>> +
>>>>>>> +	return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void imx_devfreq_exit(struct device *dev)
>>>>>>> +{
>>>>>>> +	dev_pm_opp_of_remove_table(dev);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int imx_devfreq_probe(struct platform_device *pdev)
>>>>>>> +{
>>>>>>> +	struct device *dev = &pdev->dev;
>>>>>>> +	struct imx_devfreq *priv;
>>>>>>
>>>>>> How about changing the variable name 'priv' to 'imx' or 'imx_data'?
>>>>>> because it is not easy to catch the role of 'priv' from variable name.
>>>
>>> The name "priv" refers to private data of current device: it is short
>>> and not ambiguous in this context. I don't think that mentioning "imx"
>>> adds any additional useful information.
>>>
>>> It doesn't seem like there's much of a convention for "local variable
>>> containing private data", for example exynos-bus.c uses "struct
>>> exynos_bus* bus" internally.
>>
>> OK. it is nitpick. Keep your style.
>>
>>>
>>>>>>
>>>>>>> +	const char *gov = DEVFREQ_GOV_USERSPACE;
>>>>>>> +	void *govdata = NULL;
>>>>>>
>>>>>> How about changing the variable name 'govdata' to 'gov_data'?
>>>>>> - govdata -> gov_data
>>>
>>> OK
>>>
>>>>>>> +	int ret;
>>>>>>> +
>>>>>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>>>>> +	if (!priv)
>>>>>>> +		return -ENOMEM;
>>>>>>> +
>>>>>>> +	priv->clk = devm_clk_get(dev, NULL);
>>>>>>
>>>>>> nitpick: because the clock-name is not mandatory.
>>>>>> Don't need to specify the clock name to inform the role of clock
>>>>>> of other developer/user?
>>>>>>
>>>>>> For example, "ddr", "bus" and so on.
>>>
>>> I'll call this bus, but I'm not sure it's useful when a single clock is
>>> involved.
>>>
>>>>> And, this driver doesn't include the 'clk_prepare_enable'.
>>>>> how to enable the clock?
>>>
>>> Clocks are either always on or perhaps controlled by some other
>>> peripheral. This driver only provides scaling.
>>
>> It is not proper use-case of clock. If device driver
>> want to control the clock, it have to be enabled on device driver.
> 
>> Even it clock is always, the user don't know the state of clock.
>> Also, user can't know what kind of device driver control the clock.
>>
>> It have to be controlled on this device driver
>> before changing the clock frequency.
> 
>  From clock framework perspective prepare/enable and rate bits can be 
> controlled separately.
> 
> Many peripherals are grouped with their own bus (for example a PL301 
> NIC) which is normally off and only gets enabled when explicitly 
> requested by drivers. If this devfreq driver always enabled bus clocks 
> then it would waste power for no reason.

You can save the power with following sequence.
You are keeping the following sequence without any problem.
	clk_prepare_enable()
	clk_set_rate()
	clk_disable_unprepare()

clk API support the reference count for the clock user.
It doesn't affect the any behavior of other device sharing the bus clock
and waste any power-consumption because it will always restore
the reference count after changing the clock rate. 

> 
> For example a display controller will first enable clocks to allow 
> access to device registers, then configure a resolution and make a 
> bandwith request which gets translated a min_freq request. Then when the 
> display is blanked the entire display bus should be powered off, even if 
> this makes control registers inaccessible.
> 
> This series only enables scaling for the main NOC which can't be turned 
> off anyway.
> 
>>>>>>> +	if (IS_ERR(priv->clk)) {
>>>>>>> +		ret = PTR_ERR(priv->clk);
>>>>>>> +		dev_err(dev, "failed to fetch clk: %d\n", ret);
>>>>>>> +		return ret;
>>>>>>> +	}
>>>>>>> +	platform_set_drvdata(pdev, priv);
>>>>>>> +
>>>>>>> +	ret = dev_pm_opp_of_add_table(dev);
>>>>>>> +	if (ret < 0) {
>>>>>>> +		dev_err(dev, "failed to get OPP table\n");
>>>>>>> +		return ret;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	priv->profile.polling_ms = 1000;
>>>>>>> +	priv->profile.target = imx_devfreq_target;
>>>>>>> +	priv->profile.get_dev_status = imx_devfreq_get_dev_status;
>>>>>>> +	priv->profile.exit = imx_devfreq_exit;
>>>>>>> +	priv->profile.get_cur_freq = imx_devfreq_get_cur_freq;
>>>>>>> +	priv->profile.initial_freq = clk_get_rate(priv->clk);
>>>>>>> +
>>>>>>> +	/* Handle passive devfreq parent link */
>>>>>>> +	priv->passive_data.parent = devfreq_get_devfreq_by_phandle(dev, 0);
>>>>>>> +	if (!IS_ERR(priv->passive_data.parent)) {
>>>>>>> +		dev_info(dev, "setup passive link to %s\n",
>>>>>>> +			 dev_name(priv->passive_data.parent->dev.parent));
>>>>>>> +		gov = DEVFREQ_GOV_PASSIVE;
>>>>>>> +		govdata = &priv->passive_data;
>>>>>>> +	} else if (priv->passive_data.parent != ERR_PTR(-ENODEV)) {
>>>>>>> +		// -ENODEV means no parent: not an error.
>>>>>>> +		ret = PTR_ERR(priv->passive_data.parent);
>>>>>>> +		if (ret != -EPROBE_DEFER)
>>>>>>> +			dev_warn(dev, "failed to get initialize passive parent: %d\n",
>>>>>>> +				 ret);
>>>>>>> +		goto err;
>>>>>>> +	}
>>>>>>
>>>>>> You better to change the exception handling as following: It is more simple.
>>>>>>
>>>>>> 	} else if (PTR_ERR(priv->passive_data.parent) == -EPROBE_DEFER)
>>>>>> 			|| PTR_ERR(priv->passive_data.parent) == -ENODEV) {
>>>>>> 		goto err;
>>>>>> 	} else {
>>>>>> 		ret = PTR_ERR(priv->passive_data.parent);
>>>>>> 		dev_err(dev, "failed to get initialize passive parent: %d\n", ret);
>>>>>> 		goto err;
>>>>>> 	}
>>>
>>> But -ENODEV is not an error, it means no passive parent was found.
>>
>> OK. just I want to make 'if statement' more simple. This style
>> is complicated.
> 
> I can avoid handling EPROBE_DEFER in a nested if.

Anyway, if you make the exception more simple, I'm ok. 

> 
>>>>>>> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
>>>>>>> +						gov, govdata);
>>>>>>> +	if (IS_ERR(priv->devfreq)) {
>>>>>>> +		ret = PTR_ERR(priv->devfreq);
>>>>>>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);
>>>>>>> +		goto err;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	return 0;
>>>>>>> +
>>>>>>> +err:
>>>>>>> +	dev_pm_opp_of_remove_table(dev);
>>>>>>> +	return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static const struct of_device_id imx_devfreq_of_match[] = {
>>>>>>> +	{ .compatible = "fsl,imx8m-noc", },
>>>>>>> +	{ .compatible = "fsl,imx8m-nic", },
>>>>>>> +	{ /* sentinel */ },
>>>>>>> +};
>>>>>>> +MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
>>>>>>> +
>>>>>>> +static struct platform_driver imx_devfreq_platdrv = {
>>>>>>> +	.probe		= imx_devfreq_probe,
>>>>>>> +	.driver = {
>>>>>>> +		.name	= "imx-devfreq",
>>>>>>> +		.of_match_table = of_match_ptr(imx_devfreq_of_match),
>>>>>>> +	},
>>>>>>> +};
>>>>>>> +module_platform_driver(imx_devfreq_platdrv);
>>>>>>> +
>>>>>>> +MODULE_DESCRIPTION("Generic i.MX bus frequency driver");
>>>>>>
>>>>>> If this driver is for bus frequency, you better to use 'bus' for the clock-name
>>>>>> for the readability.
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
