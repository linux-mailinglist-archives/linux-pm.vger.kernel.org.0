Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDDE11FC69
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 02:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfLPBAF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 20:00:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:57344 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPBAF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 20:00:05 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191216010000epoutp01be481ef6267ee5d0e8b1029ebe2552ba~gtDLb8iTS1899318993epoutp01_
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 01:00:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191216010000epoutp01be481ef6267ee5d0e8b1029ebe2552ba~gtDLb8iTS1899318993epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576458000;
        bh=UHz8miwCsStCk7x4OhXxqR1MgVUMnyw8pTG8bj8lXKw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bjI9t4/Su8furkVauRwFhKB366NtzDJoMdJaj5AkdxeEU4eOzzsdKmSXiC0ZmfM0w
         perEZqzMNHhzGCW2tm5OKhoUcU70Ze+E5jHkDXijjMwSdOxXo0F7V/q5PVtPI0Eddz
         jLjMj8EXikZsiDev+NVakj6dHmCTHCqyr+AdQWSA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191216005959epcas1p43d9f20c8a1dfc59693da8c7b774e0d8e~gtDKpg9vw0859708597epcas1p4O;
        Mon, 16 Dec 2019 00:59:59 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47bjbw0mR4zMqYkh; Mon, 16 Dec
        2019 00:59:56 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.FA.57028.C07D6FD5; Mon, 16 Dec 2019 09:59:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191216005955epcas1p48aeb95c6015292220cf0498396290b8e~gtDHT4JKR0322803228epcas1p4B;
        Mon, 16 Dec 2019 00:59:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191216005955epsmtrp18de3761690431996684448af40d7d9ed~gtDHSzmXU2772127721epsmtrp1C;
        Mon, 16 Dec 2019 00:59:55 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-2b-5df6d70cb118
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.2B.06569.B07D6FD5; Mon, 16 Dec 2019 09:59:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191216005955epsmtip2fb5fbd6c8e8081be254d754781d77dd6~gtDG_HOFo0385803858epsmtip2N;
        Mon, 16 Dec 2019 00:59:55 +0000 (GMT)
Subject: Re: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Organization: Samsung Electronics
Message-ID: <25e3177f-e2b9-6be4-cfb8-24f87ccba45b@samsung.com>
Date:   Mon, 16 Dec 2019 10:06:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <047990a5-263d-d447-7f0a-77a99e4b1f63@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwbZRzHfXrX67GsenYgj406uGHMmGw9oPhgB5JsmjNbIjrmH4uE3eCk
        pK/2WiZb1DrtWJvJRrAqhb04ZIEC2doSxhYYE+oQJkzUdYtscaYzGXWCyEtwE2Pb6yL/fX6/
        fL+/tycPiSm6ZEqyymjlLUZOTxOr8J6h9aqs1dcXS1U9dThauDIK0OkfvgFo3n0BQ+FfJgE6
        11iOTgTHpcgXmMTR5/1+Annd53F09epZGRo7cE+G2m7NSpE/HJIi1/12DM19EgSo9fqEBIXa
        6qVo7mwYoInRl9Hkh20E6hj/mkDH5t0YcvQHZcg1uEygf0M+HN3tTkWtLSEM+RbYoqdYt6sN
        sJ3HOwE7c8MhY5vsEzh70m9j/V4nwd4M9RFs4KsPWN90r4Q9sqxi7w+lsHXdXsDO+Z8plu/S
        bdbyXAVvSeON5aaKKmNlAb1tR9mWMnWeisli8tELdJqRM/AF9NbtxVmvVOmj96DTqjm9LZoq
        5gSB3lS42WKyWfk0rUmwFtC8uUJvzjdvFDiDYDNWbiw3GV5kVKpsdVS4W6dt/rva3Mm+2+Sr
        w+2gXuMCSSSkcuHUR06pC6wiFVQvgFP2RokY/AWgo7ZDGlMpqEUAf7r0/kPHTGAh4egH8Nps
        HSEGM1HR0CweU62h3oBfnmmPM0FlwoG7N4gYJ1P74dGxA5IYY9RnMvjAnR/jx6h0eG0pDGIs
        pwphw7Iz7sWpZ2Hznw3xKVKoN+FIz8cJzeNwpPFOXJNEvQQvd0RkYs1U+POdE4n6a+G5P5qx
        2HCQ6iJhcOwLTFxhK7ztbJKKvAZGhrtlIivh1JGDCd4P20eChGg+BGD3wPcJQw4caG2IdiCj
        HdbDMxc2iel0eP7BMSA2fhROLxyWxiSQksNDBxWiZB388fYtichPwpZaJ3EU0J4V63hWrOBZ
        sYLn/2YnAe4FT/BmwVDJC4yZWfnYfhD/KpnqXvDp+PZBQJGAXi0v0i2WKqRctVBjGASQxOhk
        Ob9hrlQhr+Bq9vEWU5nFpueFQaCOXrseU6aUm6Ifz2gtY9TZOTk5KJfJUzMMnSonlyZKFVQl
        Z+V1PG/mLQ99EjJJaQfb9nx3Ki/S9zp6xDgMX+XuvXXx8oiutiR8UTi+N2O4T72za+Zpqigg
        1VZf2dWy02Ke3jdAMb9mthZmvBcZifyT4QnkuZ4r2bvDVfP2b5pSDb68JeXbDUt2w3zJJW8T
        o+nc/U7278nyRv50cFF5eO3zSzf3jJ5yaHId3Yr0nKx1r5loXNByTCZmEbj/ANRVUPJABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGeXfOzo6rQ29T8dWk6eiCq9RW1AtdCZRDn6IoumA29KDhpmPH
        rSwoiyycZJnMcC61UplzoNvES2XlvFSWysSmZBGxIWbZBdNStMs2Ar/9eJ7nB/8Pf5qQlAuj
        6NPZuZw2W6mSUWKypUsm3bRsZDYlccG2Bs+87AO4bqgH4B/GBwT2vh8DuLU8DVd1Dwix3TlG
        4tsdDgpbje0kHhxsEuH+y59F2PLuuxA7vB4hNszXE3j6ejfAtSNuAfZYSoR4uskLsLsvCY9d
        slC4YaCTwnd+GAlc0NEtwgbXIoV/e+wknmiOwLX3PQS2z7B7o1mjwQJYW6UNsF9HC0RsRb6b
        ZKsdOtZhLaTYt55HFOusucjav7QJ2BuLiex8Vzhb3GwF7LRj9QHmuHhnOqc6ree0CbtPiTPN
        c3qNjT1bYS8m80HJDgMIoRHcir46Z4QGIKYl8CFArrZOYbCIRGXuHsIA6H8cirq6+OBmCqAP
        j/so/yYUHkR3G+tJP1NQjp5MjAbyMHgeLYw/I/wCAU0i5Ctyk0H7lQB9af8UMFbAWPT6lxf4
        mYG7UeliYSAn4Vpk/lYauCIcHkHtNV5BcLMSvSj3BTYhcA/qbZgU+ZmA69FC5RAR5Aj0xlcl
        CLIUtU6ZiZsg1LRENy1RTEsU0xKlGpBWEMlpeHWGmt+sUWRzZ+J5pZrXZWfEp+WoHSDwMHJ5
        G3j+PNUFIA1ky5m9WbMpEqFSz+epXQDRhCyM4TZMp0iYdGXeOU6bk6rVqTjeBVbRpCyCkeb0
        HpPADGUul8VxGk77vxXQIVH5IDYn7mP3xha94pai70/+utxCJ+TfJqelS7fPgft55bO6mPph
        qepwuCKrOnrSqdHvPyzPIMXDuv7fI4l1zTajIe5V1BbsM19TxGxjDpXBF+5lNQ2WfZ3OkyU3
        Cp86VeZig+tetLGp0dcznsT0wp/WXVcvnEhgiq4km5MGmo/KSD5TuVlOaHnlX+jR8R8sAwAA
X-CMS-MailID: 20191216005955epcas1p48aeb95c6015292220cf0498396290b8e
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Also, I think that 'devfreq' word is not proper for device driver name.
imx-bus.c or imx-noc.c or others to inform the role of this driver of developer.

And, I have a question.
This driver adds the devfreq device with either passive governor
or userspace governor.

As I understood, the devfreq device with passive governor
will be operated with imx8m-ddrc.c driver.
But, when is operating with userspace governor?

I think that you better to add the explanation to description
for two scenarios how to operate with interconnect provider
on either passive governor or userspace governor usage case.

On 12/13/19 10:51 AM, Chanwoo Choi wrote:
> On 12/13/19 10:30 AM, Chanwoo Choi wrote:
>> Hi,
>>
>> On 11/15/19 5:09 AM, Leonard Crestez wrote:
>>> Add initial support for dynamic frequency switching on pieces of the imx
>>> interconnect fabric.
>>>
>>> All this driver does is set a clk rate based on an opp table, it does
>>> not map register areas.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> ---
>>>  drivers/devfreq/Kconfig       |   9 ++
>>>  drivers/devfreq/Makefile      |   1 +
>>>  drivers/devfreq/imx-devfreq.c | 150 ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 160 insertions(+)
>>>  create mode 100644 drivers/devfreq/imx-devfreq.c
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index 923a6132e741..fef5ce831e90 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -98,10 +98,19 @@ config ARM_IMX8M_DDRC_DEVFREQ
>>>  	select DEVFREQ_GOV_USERSPACE
>>>  	help
>>>  	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
>>>  	  adjusting DRAM frequency.
>>>  
>>> +config ARM_IMX_DEVFREQ
>>> +	tristate "i.MX Generic DEVFREQ Driver"
>>> +	depends on ARCH_MXC || COMPILE_TEST
>>> +	select DEVFREQ_GOV_PASSIVE
>>> +	select DEVFREQ_GOV_USERSPACE
>>> +	help
>>> +	  This adds the generic DEVFREQ driver for i.MX interconnects. It
>>> +	  allows adjusting NIC/NOC frequency.
>>> +
>>>  config ARM_TEGRA_DEVFREQ
>>>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>>>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>>>  		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>>>  		ARCH_TEGRA_210_SOC || \
>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>>> index 3eb4d5e6635c..61d0edee16f7 100644
>>> --- a/drivers/devfreq/Makefile
>>> +++ b/drivers/devfreq/Makefile
>>> @@ -8,10 +8,11 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>>>  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>>  
>>>  # DEVFREQ Drivers
>>>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>>> +obj-$(CONFIG_ARM_IMX_DEVFREQ)		+= imx-devfreq.o
>>>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>>>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>>>  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>>>  
>>>  # DEVFREQ Event Drivers
>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
>>> new file mode 100644
>>> index 000000000000..620b344e87aa
>>> --- /dev/null
>>> +++ b/drivers/devfreq/imx-devfreq.c
>>> @@ -0,0 +1,150 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright 2019 NXP
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/devfreq.h>
>>> +#include <linux/device.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/pm_opp.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +
>>> +struct imx_devfreq {
>>> +	struct devfreq_dev_profile profile;
>>> +	struct devfreq *devfreq;
>>> +	struct clk *clk;
>>> +	struct devfreq_passive_data passive_data;
>>> +};
>>> +
>>> +static int imx_devfreq_target(struct device *dev,
>>> +			      unsigned long *freq, u32 flags)
>>
>> Don't use space for the indentation. Please use only tab.
>>
>>> +{
>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>> +	struct dev_pm_opp *new_opp;
>>> +	unsigned long new_freq;
>>> +	int ret;
>>> +
>>> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>> +	if (IS_ERR(new_opp)) {
>>> +		ret = PTR_ERR(new_opp);
>>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +	new_freq = dev_pm_opp_get_freq(new_opp);
>>> +	dev_pm_opp_put(new_opp);
>>> +
>>> +	return clk_set_rate(priv->clk, new_freq);
>>> +}
>>> +
>>> +static int imx_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
>>> +{
>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>> +
>>> +	*freq = clk_get_rate(priv->clk);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_devfreq_get_dev_status(struct device *dev,
>>> +				      struct devfreq_dev_status *stat)
>>
>> ditto. Please use tab for the indentation.
>>
>>> +{
>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>> +
>>> +	stat->busy_time = 0;
>>> +	stat->total_time = 0;
>>> +	stat->current_frequency = clk_get_rate(priv->clk);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void imx_devfreq_exit(struct device *dev)
>>> +{
>>> +	dev_pm_opp_of_remove_table(dev);
>>> +}
>>> +
>>> +static int imx_devfreq_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct imx_devfreq *priv;
>>
>> How about changing the variable name 'priv' to 'imx' or 'imx_data'?
>> because it is not easy to catch the role of 'priv' from variable name.
>>
>>> +	const char *gov = DEVFREQ_GOV_USERSPACE;
>>> +	void *govdata = NULL;
>>
>> How about changing the variable name 'govdata' to 'gov_data'?
>> - govdata -> gov_data
>>
>>> +	int ret;
>>> +
>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->clk = devm_clk_get(dev, NULL);
>>
>> nitpick: because the clock-name is not mandatory.
>> Don't need to specify the clock name to inform the role of clock
>> of other developer/user?
>>
>> For example, "ddr", "bus" and so on.
> 
> And, this driver doesn't include the 'clk_prepare_enable'.
> how to enable the clock?
> 
>>
>>> +	if (IS_ERR(priv->clk)) {
>>> +		ret = PTR_ERR(priv->clk);
>>> +		dev_err(dev, "failed to fetch clk: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +	platform_set_drvdata(pdev, priv);
>>> +
>>> +	ret = dev_pm_opp_of_add_table(dev);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "failed to get OPP table\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	priv->profile.polling_ms = 1000;
>>> +	priv->profile.target = imx_devfreq_target;
>>> +	priv->profile.get_dev_status = imx_devfreq_get_dev_status;
>>> +	priv->profile.exit = imx_devfreq_exit;
>>> +	priv->profile.get_cur_freq = imx_devfreq_get_cur_freq;
>>> +	priv->profile.initial_freq = clk_get_rate(priv->clk);
>>> +
>>> +	/* Handle passive devfreq parent link */
>>> +	priv->passive_data.parent = devfreq_get_devfreq_by_phandle(dev, 0);
>>> +	if (!IS_ERR(priv->passive_data.parent)) {
>>> +		dev_info(dev, "setup passive link to %s\n",
>>> +			 dev_name(priv->passive_data.parent->dev.parent));
>>> +		gov = DEVFREQ_GOV_PASSIVE;
>>> +		govdata = &priv->passive_data;
>>> +	} else if (priv->passive_data.parent != ERR_PTR(-ENODEV)) {
>>> +		// -ENODEV means no parent: not an error.
>>> +		ret = PTR_ERR(priv->passive_data.parent);
>>> +		if (ret != -EPROBE_DEFER)
>>> +			dev_warn(dev, "failed to get initialize passive parent: %d\n",
>>> +				 ret);
>>> +		goto err;
>>> +	}
>>
>> You better to change the exception handling as following: It is more simple.
>>
>> 	} else if (PTR_ERR(priv->passive_data.parent) == -EPROBE_DEFER)
>> 			|| PTR_ERR(priv->passive_data.parent) == -ENODEV) {
>> 		goto err;
>> 	} else {
>> 		ret = PTR_ERR(priv->passive_data.parent);
>> 		dev_err(dev, "failed to get initialize passive parent: %d\n", ret);
>> 		goto err;
>> 	}
>>
>>> +
>>> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
>>> +						gov, govdata);
>>> +	if (IS_ERR(priv->devfreq)) {
>>> +		ret = PTR_ERR(priv->devfreq);
>>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);
>>> +		goto err;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +err:
>>> +	dev_pm_opp_of_remove_table(dev);
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct of_device_id imx_devfreq_of_match[] = {
>>> +	{ .compatible = "fsl,imx8m-noc", },
>>> +	{ .compatible = "fsl,imx8m-nic", },
>>> +	{ /* sentinel */ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
>>> +
>>> +static struct platform_driver imx_devfreq_platdrv = {
>>> +	.probe		= imx_devfreq_probe,
>>> +	.driver = {
>>> +		.name	= "imx-devfreq",
>>> +		.of_match_table = of_match_ptr(imx_devfreq_of_match),
>>> +	},
>>> +};
>>> +module_platform_driver(imx_devfreq_platdrv);
>>> +
>>> +MODULE_DESCRIPTION("Generic i.MX bus frequency driver");
>>
>> If this driver is for bus frequency, you better to use 'bus' for the clock-name
>> for the readability.
>>
>>> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
