Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6B11DBC8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 02:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLMBom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 20:44:42 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:53786 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfLMBol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 20:44:41 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191213014437epoutp039c0d3f076c3ce1e19d40edf751787eef~fyuRrOaTH1312013120epoutp03M
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2019 01:44:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191213014437epoutp039c0d3f076c3ce1e19d40edf751787eef~fyuRrOaTH1312013120epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576201477;
        bh=G70sE884u4PRNAfAjQy/4jv9Of7ugPUE1oJGHD6+/bo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SvsPA3yd8kIQQ2Y9vlj8UEqIoVdiJnkk1bDEPzIvEF6RY2BC0KJG6mj0TmGI2+YUQ
         WOMH4tlBWa8bpKhqGPmHwQpNu/kQ4jSR8mo5nOx+bU8l+fz9SxXi7KkUN5fvhRc9mU
         i5nwQxAVZwJN0qhmxG/pj1ElnhR+8KGqGN5/erqc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191213014435epcas1p4e9a21b0801dbdbd03960ee1c9abaeb38~fyuQmKY850512405124epcas1p4Q;
        Fri, 13 Dec 2019 01:44:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Ytkn1dwszMqYkp; Fri, 13 Dec
        2019 01:44:33 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.FD.57028.10DE2FD5; Fri, 13 Dec 2019 10:44:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191213014432epcas1p3356896a2a3139811e77b71cdb4696eb5~fyuNXn1SR3044030440epcas1p3Q;
        Fri, 13 Dec 2019 01:44:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213014432epsmtrp18782810d013f44cb2facf84fae62bc42~fyuNWUIu42167221672epsmtrp1L;
        Fri, 13 Dec 2019 01:44:32 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-30-5df2ed01efc8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.61.06569.00DE2FD5; Fri, 13 Dec 2019 10:44:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191213014431epsmtip17cd4d85e79ffbf058b39d826768e4d97~fyuM-FLbj0547605476epsmtip1B;
        Fri, 13 Dec 2019 01:44:31 +0000 (GMT)
Subject: Re: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
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
Message-ID: <047990a5-263d-d447-7f0a-77a99e4b1f63@samsung.com>
Date:   Fri, 13 Dec 2019 10:51:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <8734a934-79e2-7445-c3e5-a0bb59afd4a8@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGc3pvby+ysmuxciSZK1dIJgnQWuqOC+Ccst1kLpBN9scmY1e4
        AUK/0lvIxJkhGYiNX2QyY51DrZDSmUArYDUgoxYdLCKdW8cAcQssMOXDFdswDMv6ZcZ/v/O+
        z3Pe85yTQ2ISpyiRLNcaOYOWVdPEOrz79tb0NDDvK5T/cTwWue50iZD/xyGAWn8aAOhZ000M
        TT0aB+j6uWLU7B4WIvu1cRyd7XUQyNZ0A0f373eI0L3aORGyPvxbiBxTXiEyrbRhaOmEG6CW
        Xz0C5LU2CtFSxxRAnqFcNH7ESqDvhvsJdOFZE4bqet0iZHKtEuhfrx1Hs50JqMXixZDdz7z5
        CtNksgLm6rdXAbM4Widiztd4cOaio5Jx2I4RzIS3h2CuXfmCsS84BUz/Qo+AObUqZ1ZuS5mT
        nTbALDk258d9VJFVxrElnEHGaYt1JeXa0mz63Q+KdheptssVaYod6HVapmU1XDa9Z29+2tvl
        6uDN0LIqVl0ZLOWzPE9n5GQZdJVGTlam443ZNKcvUet36NN5VsNXakvTi3WaNxRy+TZVUPhp
        RZnFFiD0X+/67IdmH14DfJkmEENCKhP+/PQEMIF1pIRyArg40i4MNSSUD8An9vWRRgBA83xA
        +MJhHusVRBq9AJ7/xy+MLBYBXLnbFlbFU+/DS+1teIgJKhX2zY4SId5AHYKn79WG3Rj1mwh+
        P3ALhBovU0nwl+WpMIupHLjQtRo0kCROpcChx9WhspT6EA52fxmVrIeD56bD+8dQO6Gl+4Eg
        xBiVAMemm6P8Krw+/w0WmgUpNwlXHa14JMIe6J12iyIcDx/f7YxyIvzrVH2UD8G2QTcRMTcA
        2Nk3Es2vhH0tXwlCh8OorbD9ZkaknARvPL8AIoPj4IL/uDAkgZQYNtRLIpIt8MHvDwUR3gQt
        R48RpwFtXhPHvCaCeU0E8//DLgLcBjZyel5TyvEKvWLtaztA+NekqpzgzPBeF6BIQL8ktrK+
        QomQreIPalwAkhi9Qbzz82BJXMIerOYMuiJDpZrjXUAVvOxGLFFarAv+Qa2xSKHaplQqUaZi
        u0qhoBPE5LKnUEKVskauguP0nOGFT0DGJNaARs+mgYX4RfeTicnXqOSCXbXJs5N5Sc0HZt6r
        P7wfeUS3RrP7d5vO3jnTiqoL4t6yvKMeTpHKVh21ySNHlSc7PlmemKtK/jgrbyx2Y8rMn0zu
        0JUeZ4Lb8Dwj94C2YaybqDNeLtiXty+wefJI1tPe0RltzhZ/YA60dq3sT390WBpL43wZq0jF
        DDz7H7QjollLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3bOzo6j1Wm2/DTLHEU1SO0ifGGkQcGJKCooujB06cFJbo4d
        V2lBKl1HWmGrPJUuZjZXkVteZjVkm5otVKa1JK3QWVmklZfIysjNAv/78bzPj+efl8TEJn4E
        maHOZrRqRaaUEOK1bunCFTMGh+VxXLMYuZprBGjsmQegio4mgEYNDzHkf9sNUF1JKiprbOMj
        64NuHF1x2AhkMdTjqL29SoBaCz4LkPn1Nz6y+X18pP9ZiaGRwkaAbr308pDPfJGPRqr8AHk9
        m1B3vplAd9qcBLoxasDQSUejAOldEwT647PiaKA6DN0y+TBkHaOTFtAGvRnQd0vvAvpL10kB
        fS3Pi9NGm462Wc4SdI/vMUE/KD9OW4fsPNo59JhHn5+Io3+6JXRRtQXQI7aF22ftE65LYzIz
        DjHa2PUpQqXJ8p3QXN5wpKVsGM8Dw2v0IISE1BrIvXLw9EBIiqlHAPoqurCpQzi87G2aZHKS
        Q6HbzU51BgGs6ijgBzqh1E54834lHmCCksGGgS4iwHOpo/D3+ydYQMCo1wJ49dyTfwtXeNBh
        6Qnas6lo+OKHHwRYRK2HQzUTRGANp5ZAz6fcQCyhdsP6cj9vqjIHPi3pD46FUInQVNsZzDFq
        Kfxd2oFNcRh81V/2L4+CdYPXsQsglJumc9MUbprCTVOMALeAcEbDqtJV7ErNKjVzOIZVqFid
        Oj0mNUtlA8HXkcnsoKUl2QUoEkhnisyKYbmYrzjE5qhcAJKYdK4o8dhkJEpT5OQy2qxkrS6T
        YV1gPolLw0RRWc17xVS6Ips5yDAaRvv/yiNDIvLAvUfON+1pphIel8DsP/srMnY8qceYeCDp
        w/ipnhO7IuPGP+py7IVU38bNzq0f0GbJ2tv5i971Uc+3XSiqj+KW1RY18CNT4recrl6cxnjU
        DVxvV6HgWvEMTfyl5UpjYrQ8wbtztly3Y11v6+qYgQj5u2LJxJl5yq/2zgxh8fM9v/qkOKtU
        rJRhWlbxFyfQRlY2AwAA
X-CMS-MailID: 20191213014432epcas1p3356896a2a3139811e77b71cdb4696eb5
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/13/19 10:30 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 11/15/19 5:09 AM, Leonard Crestez wrote:
>> Add initial support for dynamic frequency switching on pieces of the imx
>> interconnect fabric.
>>
>> All this driver does is set a clk rate based on an opp table, it does
>> not map register areas.
>>
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>> ---
>>  drivers/devfreq/Kconfig       |   9 ++
>>  drivers/devfreq/Makefile      |   1 +
>>  drivers/devfreq/imx-devfreq.c | 150 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 160 insertions(+)
>>  create mode 100644 drivers/devfreq/imx-devfreq.c
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 923a6132e741..fef5ce831e90 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -98,10 +98,19 @@ config ARM_IMX8M_DDRC_DEVFREQ
>>  	select DEVFREQ_GOV_USERSPACE
>>  	help
>>  	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
>>  	  adjusting DRAM frequency.
>>  
>> +config ARM_IMX_DEVFREQ
>> +	tristate "i.MX Generic DEVFREQ Driver"
>> +	depends on ARCH_MXC || COMPILE_TEST
>> +	select DEVFREQ_GOV_PASSIVE
>> +	select DEVFREQ_GOV_USERSPACE
>> +	help
>> +	  This adds the generic DEVFREQ driver for i.MX interconnects. It
>> +	  allows adjusting NIC/NOC frequency.
>> +
>>  config ARM_TEGRA_DEVFREQ
>>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>>  		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>>  		ARCH_TEGRA_210_SOC || \
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>> index 3eb4d5e6635c..61d0edee16f7 100644
>> --- a/drivers/devfreq/Makefile
>> +++ b/drivers/devfreq/Makefile
>> @@ -8,10 +8,11 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>>  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>  
>>  # DEVFREQ Drivers
>>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>> +obj-$(CONFIG_ARM_IMX_DEVFREQ)		+= imx-devfreq.o
>>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>>  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>>  
>>  # DEVFREQ Event Drivers
>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
>> new file mode 100644
>> index 000000000000..620b344e87aa
>> --- /dev/null
>> +++ b/drivers/devfreq/imx-devfreq.c
>> @@ -0,0 +1,150 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2019 NXP
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/devfreq.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +struct imx_devfreq {
>> +	struct devfreq_dev_profile profile;
>> +	struct devfreq *devfreq;
>> +	struct clk *clk;
>> +	struct devfreq_passive_data passive_data;
>> +};
>> +
>> +static int imx_devfreq_target(struct device *dev,
>> +			      unsigned long *freq, u32 flags)
> 
> Don't use space for the indentation. Please use only tab.
> 
>> +{
>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>> +	struct dev_pm_opp *new_opp;
>> +	unsigned long new_freq;
>> +	int ret;
>> +
>> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
>> +	if (IS_ERR(new_opp)) {
>> +		ret = PTR_ERR(new_opp);
>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);
>> +		return ret;
>> +	}
>> +	new_freq = dev_pm_opp_get_freq(new_opp);
>> +	dev_pm_opp_put(new_opp);
>> +
>> +	return clk_set_rate(priv->clk, new_freq);
>> +}
>> +
>> +static int imx_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
>> +{
>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>> +
>> +	*freq = clk_get_rate(priv->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int imx_devfreq_get_dev_status(struct device *dev,
>> +				      struct devfreq_dev_status *stat)
> 
> ditto. Please use tab for the indentation.
> 
>> +{
>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>> +
>> +	stat->busy_time = 0;
>> +	stat->total_time = 0;
>> +	stat->current_frequency = clk_get_rate(priv->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static void imx_devfreq_exit(struct device *dev)
>> +{
>> +	dev_pm_opp_of_remove_table(dev);
>> +}
>> +
>> +static int imx_devfreq_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct imx_devfreq *priv;
> 
> How about changing the variable name 'priv' to 'imx' or 'imx_data'?
> because it is not easy to catch the role of 'priv' from variable name.
> 
>> +	const char *gov = DEVFREQ_GOV_USERSPACE;
>> +	void *govdata = NULL;
> 
> How about changing the variable name 'govdata' to 'gov_data'?
> - govdata -> gov_data
> 
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->clk = devm_clk_get(dev, NULL);
> 
> nitpick: because the clock-name is not mandatory.
> Don't need to specify the clock name to inform the role of clock
> of other developer/user?
> 
> For example, "ddr", "bus" and so on.

And, this driver doesn't include the 'clk_prepare_enable'.
how to enable the clock?

> 
>> +	if (IS_ERR(priv->clk)) {
>> +		ret = PTR_ERR(priv->clk);
>> +		dev_err(dev, "failed to fetch clk: %d\n", ret);
>> +		return ret;
>> +	}
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	ret = dev_pm_opp_of_add_table(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get OPP table\n");
>> +		return ret;
>> +	}
>> +
>> +	priv->profile.polling_ms = 1000;
>> +	priv->profile.target = imx_devfreq_target;
>> +	priv->profile.get_dev_status = imx_devfreq_get_dev_status;
>> +	priv->profile.exit = imx_devfreq_exit;
>> +	priv->profile.get_cur_freq = imx_devfreq_get_cur_freq;
>> +	priv->profile.initial_freq = clk_get_rate(priv->clk);
>> +
>> +	/* Handle passive devfreq parent link */
>> +	priv->passive_data.parent = devfreq_get_devfreq_by_phandle(dev, 0);
>> +	if (!IS_ERR(priv->passive_data.parent)) {
>> +		dev_info(dev, "setup passive link to %s\n",
>> +			 dev_name(priv->passive_data.parent->dev.parent));
>> +		gov = DEVFREQ_GOV_PASSIVE;
>> +		govdata = &priv->passive_data;
>> +	} else if (priv->passive_data.parent != ERR_PTR(-ENODEV)) {
>> +		// -ENODEV means no parent: not an error.
>> +		ret = PTR_ERR(priv->passive_data.parent);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_warn(dev, "failed to get initialize passive parent: %d\n",
>> +				 ret);
>> +		goto err;
>> +	}
> 
> You better to change the exception handling as following: It is more simple.
> 
> 	} else if (PTR_ERR(priv->passive_data.parent) == -EPROBE_DEFER)
> 			|| PTR_ERR(priv->passive_data.parent) == -ENODEV) {
> 		goto err;
> 	} else {
> 		ret = PTR_ERR(priv->passive_data.parent);
> 		dev_err(dev, "failed to get initialize passive parent: %d\n", ret);
> 		goto err;
> 	}
> 
>> +
>> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
>> +						gov, govdata);
>> +	if (IS_ERR(priv->devfreq)) {
>> +		ret = PTR_ERR(priv->devfreq);
>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);
>> +		goto err;
>> +	}
>> +
>> +	return 0;
>> +
>> +err:
>> +	dev_pm_opp_of_remove_table(dev);
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id imx_devfreq_of_match[] = {
>> +	{ .compatible = "fsl,imx8m-noc", },
>> +	{ .compatible = "fsl,imx8m-nic", },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
>> +
>> +static struct platform_driver imx_devfreq_platdrv = {
>> +	.probe		= imx_devfreq_probe,
>> +	.driver = {
>> +		.name	= "imx-devfreq",
>> +		.of_match_table = of_match_ptr(imx_devfreq_of_match),
>> +	},
>> +};
>> +module_platform_driver(imx_devfreq_platdrv);
>> +
>> +MODULE_DESCRIPTION("Generic i.MX bus frequency driver");
> 
> If this driver is for bus frequency, you better to use 'bus' for the clock-name
> for the readability.
> 
>> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
>> +MODULE_LICENSE("GPL v2");
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
