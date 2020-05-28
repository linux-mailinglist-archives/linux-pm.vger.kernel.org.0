Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD91E587E
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 09:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgE1HZV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 03:25:21 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:35990 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgE1HZV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 03:25:21 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200528072517epoutp01b3cc89887c947616163afda39cd1b697~TIGZJtS8E2777827778epoutp01b
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 07:25:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200528072517epoutp01b3cc89887c947616163afda39cd1b697~TIGZJtS8E2777827778epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590650717;
        bh=63sggEwMXFg5//iy9mkhqyXY/p5ye2eUye4JI3aTFNA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gzzRRRewTL8AIphaaUgjbLkvqTt87CD7NN3eScUgUUcfC7a2JYDYTRzlW6sO6N5Ah
         1OXDJf5fsWVnPVAUujo57rjLzqtD/UbDAXSGrgVtz6ouFYx8CY1EKtMxZ3u76t5rS2
         v7HBLV80AYDTI43JklQ/xza8d4rDg8cYqujRJSPs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200528072516epcas1p38cb7bc241406202fa3d3619e1e3f5f7b~TIGYoNgOh0411404114epcas1p35;
        Thu, 28 May 2020 07:25:16 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49XfNm60qLzMqYkk; Thu, 28 May
        2020 07:25:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.A2.04388.8576FCE5; Thu, 28 May 2020 16:25:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200528072512epcas1p14d1270ffbc287a95423f195c2cd7c163~TIGU9DDpf0387903879epcas1p1a;
        Thu, 28 May 2020 07:25:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200528072512epsmtrp240f422f53f859ac2b0ef15a9fc0e2169~TIGU7c6-L0618806188epsmtrp2u;
        Thu, 28 May 2020 07:25:12 +0000 (GMT)
X-AuditID: b6c32a35-77bff70000001124-27-5ecf67586260
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.05.08382.8576FCE5; Thu, 28 May 2020 16:25:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200528072512epsmtip1a21d95c302e8e9fe3f4f911374c2d3fa~TIGUj993O3158331583epsmtip1j;
        Thu, 28 May 2020 07:25:12 +0000 (GMT)
Subject: Re: [PATCH 09/12] devfreq: add mediatek cci devfreq
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c39e4f30-805a-78c4-b1c4-e55a03e2408e@samsung.com>
Date:   Thu, 28 May 2020 16:35:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200520034307.20435-10-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wTZxjed3c9DrLq5yHzG384OPUPidUete5zAbNNslwyF4lOYsxCd6G3
        Quiv9FodW1QERgHnInNO6ajMTKcii1KZ/JiViE0MUUBAEMcYgkSZQxbp2jRbsq3HYcZ/z/u+
        z/O+7/P9YEh2jk5liuxuyWUXrRydRF29uVan223py9ef6+Fx66VpDT4+MUXjhlCvBveUzSTg
        6L0qAgceDWvwYEc9jQfL+wEOHwkBfPZ+P4HLKgx49NB5Gs/Eegh85/aABn8WDCXgf4abKXxi
        jMXNEeFNVmg61QSEdt9YghBorKaFX4av0cKVMweFiu5OSmgZ8lLCFy2NQLg10koI4cDK3KQ9
        xVmFkmiWXGmSvcBhLrJbsrl3d5q2moyb9LyO34xf59Lsok3K5nK25ereKbLGLXFpe0WrJ57K
        FWWZ27Aly+XwuKW0QofszuYkp9nq3OxcL4s22WO3rC9w2N7g9fpMY5z4YXHh94cjlDOc+3Hv
        QBsoBT+9VQMSGQQ3ov6yy3QNSGJY2AZQXcBPqcEcQF9f8y9UogDFaseoF5LJ4acLrCBAZx78
        ANTgD4DOx+7RCisZZqFzp8s0Cl4OR0l09Jv3FRIJbwB0YqCfUAo0zECd0yPzgqUwHQ3FHsU7
        MYwWbkHRqKSkKbgGzU6MzvdJgXmo+2oFULAWLkPddVPzGyXCrcjbd5xUMAlXoJ+nGggVv4Za
        n9WTylwEjyUi74h/wUIOuvjgrwQVJ6Ont1oWcCoKzwZpFX+KLnSHaFVcBVBL512NWjCgzrPH
        CGVREq5Flzo2qOl01P63H6iDl6DZyOcahYKgFlVVsiplFRp8OEao+FX0nbeaPgo43yI7vkUW
        fIss+P4f9i2gGsErklO2WSSZd/KLrzsA5t97hrENfNW7rQtABnAva/VCbz6rEffKJbYugBiS
        W659u+d2Pqs1iyWfSC6HyeWxSnIXMMZPu5ZMTSlwxH+P3W3ijZkGgwFv5DcZeZ5boW2I3cln
        oUV0S8WS5JRcL3QEk5haClLy/OM/vrQrZ7VQ2rjdQFeXm8HO9sx/O2qT3frLhDUaHK8JXtFN
        nHJOTz6vFFfaTOvC79U1GT9Y8/jArv0371fsYJ88WZ23e11waZGPf5ZezlX6m8cf18/9KV/v
        azI3DJ3ct6NyJmDcH/FMHvGeLjnwW3PKR78uOfS7GIocJq/LX3KUXCjyGaRLFv8DR32ctQUE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSnG5E+vk4g6Y7Ehbb179gtZj68Amb
        xfwj51gtzja9Ybf4dqWDyWLT42usFpd3zWGzuNx8kdHic+8RRoul1y8yWTS1GFvcblzBZvHm
        x1kmizOnL7FatO49wm7x79pGFovpd4UsNn71cBDyWDNvDaPHzll32T02repk87hzbQ+bx+Yl
        9R4tJ/ezeGy52s7i0bdlFaPH8RvbmTw+b5IL4IrisklJzcksSy3St0vgyljW/ZWl4HNAxblL
        OxgbGHc7djFyckgImEg8uvaKpYuRi0NIYDejxNru2ywQCUmJaRePMncxcgDZwhKHDxdD1Lxl
        lDg26y9YjbCAjcTyhU2sIAkRgfvMEsvvXmUDcZgFDjJKPOv+ww7Rco5R4v2eDYwgLWwCWhL7
        X9xgA7H5BRQlrv54zAiyglfATuLbt1SQMIuAqsS7h7dZQWxRgTCJnUseM4HYvAKCEidnPgHb
        zCngLNF+fioziM0soC7xZ94lKFtc4taT+UwQtrzE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZ
        xSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHOlamjsYt6/6oHeIkYmD8RCjBAezkgiv
        09nTcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5bxQujBMSSE8sSc1OTS1ILYLJMnFwSjUwTVzC
        fO3kTnfBwh+3/NLeWqrdTn3jNiFrW5IPc+SX/0H72Gs2lFzZHfJwc1L35OT1ixctyDm9zLAt
        pE4sluF+Xsc1qy5Z//+/J1f8TmB7mqjtpHuKV8JHPW2q2nvRZ0HVCcfV+2Kvsx/dJhZ1yTtC
        V+K16MEzC9/VX0y4FnF6g2vKwhdqp974vuT5z9jIc8js9B0OkwPhpyOMPnyd9uL40namgN4M
        DiXHs8sX32LcZ/FESrJApkzZVLrmAC/f51kvPa5EvMkM+zEz8fuPe98/vlWf9qfom0Y2m+D+
        6++O/4zVkYrSDKx7O0840aDYKFoyUlzIKbK3/pF9aRTj5K6Zd/QPMyv3vL9kY2Q35bSwEktx
        RqKhFnNRcSIAxBSLJGMDAAA=
X-CMS-MailID: 20200528072512epcas1p14d1270ffbc287a95423f195c2cd7c163
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200520034338epcas1p1b3c7eb91a37dfd1d9cfc150a2310f120
References: <20200520034307.20435-1-andrew-sh.cheng@mediatek.com>
        <CGME20200520034338epcas1p1b3c7eb91a37dfd1d9cfc150a2310f120@epcas1p1.samsung.com>
        <20200520034307.20435-10-andrew-sh.cheng@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andrew-sh.Cheng,

On 5/20/20 12:43 PM, Andrew-sh.Cheng wrote:
> This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
> of the Mediatek MT8183.
> 
> On the MT8183 the CCI is supplied by the same regulator as the LITTLE
> cores. The driver is notified when the regulator voltage changes
> (driven by cpufreq) and adjusts the CCI frequency to the maximum
> possible value.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/devfreq/Kconfig              |  10 ++
>  drivers/devfreq/Makefile             |   1 +
>  drivers/devfreq/mt8183-cci-devfreq.c | 206 +++++++++++++++++++++++++++++++++++

The mt8183-cci.c is enough for driver name.

>  3 files changed, 217 insertions(+)
>  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index d9067950af6a..4ed7116271ee 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -103,6 +103,16 @@ config ARM_IMX8M_DDRC_DEVFREQ
>  	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
>  	  adjusting DRAM frequency.
>  
> +config ARM_MT8183_CCI_DEVFREQ
> +	tristate "MT8183 CCI DEVFREQ Driver"
> +	depends on ARM_MEDIATEK_CPUFREQ
> +	help
> +		This adds a devfreq driver for Cache Coherent Interconnect
> +		of Mediatek MT8183, which is shared the same regulator
> +		with cpu cluster.
> +		It can track buck voltage and update a proper cci frequency.

s/cci/CCI

> +		Use notification to get regulator status.
> +
>  config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 3eb4d5e6635c..5b1b670c954d 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
> +obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
> diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> new file mode 100644
> index 000000000000..cd7929a83bf8
> --- /dev/null
> +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.

s/2019/2020

> +
> + * Author: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/time.h>
> +
> +#include "governor.h"

It is not needed. Please remove it.

> +
> +#define MAX_VOLT_LIMIT		(1150000)
> +
> +struct cci_devfreq {
> +	struct devfreq *devfreq;
> +	struct regulator *proc_reg;

'proc' means the 'processor'?
Instead of 'proc_reg', you better to use 'cpu_reg'.

> +	struct clk *cci_clk;
> +	int old_vproc;
> +	unsigned long old_freq;
> +};
> +
> +static int mtk_cci_set_voltage(struct cci_devfreq *cci_df, int vproc)
> +{
> +	int ret;
> +
> +	ret = regulator_set_voltage(cci_df->proc_reg, vproc,
> +				    MAX_VOLT_LIMIT);
> +	if (!ret)
> +		cci_df->old_vproc = vproc;
> +	return ret;
> +}
> +
> +static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
> +				  u32 flags)
> +{
> +	int ret;
> +	struct cci_devfreq *cci_df = dev_get_drvdata(dev);
> +	struct dev_pm_opp *opp;
> +	unsigned long opp_rate, opp_voltage, old_voltage;
> +
> +	if (!cci_df)
> +		return -EINVAL;
> +
> +	if (cci_df->old_freq == *freq)
> +		return 0;
> +
> +	opp_rate = *freq;
> +	opp = dev_pm_opp_find_freq_floor(dev, &opp_rate);
> +	opp_voltage = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);


You can use the helper function for getting the rate 
with devfreq_recommended_opp(). You can refer the following code
in drivers/devfreq/exynos-bus.c

	opp = devfreq_recommended_opp(dev, freq, flags);
	if (IS_ERR(opp)) {
		dev_err(dev, "failed to get recommended opp instance\n");
		return PTR_ERR(opp);
	}
	dev_pm_opp_put(opp);

> +
> +	old_voltage = cci_df->old_vproc;
> +	if (old_voltage == 0)
> +		old_voltage = regulator_get_voltage(cci_df->proc_reg);
> +
> +	// scale up: set voltage first then freq
> +	if (opp_voltage > old_voltage) {
> +		ret = mtk_cci_set_voltage(cci_df, opp_voltage);
> +		if (ret) {
> +			pr_err("cci: failed to scale up voltage\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_set_rate(cci_df->cci_clk, *freq);
> +	if (ret) {
> +		pr_err("%s: failed cci to set rate: %d\n", __func__,
> +		       ret);
> +		mtk_cci_set_voltage(cci_df, old_voltage);
> +		return ret;
> +	}
> +
> +	// scale down: set freq first then voltage
> +	if (opp_voltage < old_voltage) {
> +		ret = mtk_cci_set_voltage(cci_df, opp_voltage);
> +		if (ret) {
> +			pr_err("cci: failed to scale down voltage\n");
> +			clk_set_rate(cci_df->cci_clk, cci_df->old_freq);
> +			return ret;
> +		}
> +	}


I recommend that dev_pm_opp_set_rate() and dev_pm_opp_set_regulator()
instead of 'clk_set_rate' and 'regulator_set_voltage'.
In the dev_pm_opp_set_rate(), handle the these sequence.
You can refer the merged patch[1].

[1] commit 4294a779bd8dff6c65e7e85ffe7a1ea236e92a68
- PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()


> +
> +	cci_df->old_freq = *freq;
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile cci_devfreq_profile = {
> +	.target = mtk_cci_devfreq_target,

Need to add '.exit' for calling dev_pm_opp_of_remove_table().
You can refer the merged devfreq patches like exynos_bus.c, imx-bus.c.

> +};
> +
> +static int mtk_cci_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct cci_devfreq *cci_df;
> +	struct devfreq_passive_data *passive_data;
> +	int ret;
> +
> +	cci_df = devm_kzalloc(cci_dev, sizeof(*cci_df), GFP_KERNEL);
> +	if (!cci_df)
> +		return -ENOMEM;
> +
> +	cci_df->cci_clk = devm_clk_get(cci_dev, "cci_clock");
> +	ret = PTR_ERR_OR_ZERO(cci_df->cci_clk);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cci_dev, "failed to get clock for CCI: %d\n",
> +				ret);
> +		return ret;
> +	}
> +	cci_df->proc_reg = devm_regulator_get_optional(cci_dev, "proc");
> +	ret = PTR_ERR_OR_ZERO(cci_df->proc_reg);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cci_dev, "failed to get regulator for CCI: %d\n",
> +				ret);
> +		return ret;
> +	}

I recommend that use dev_pm_opp_set_regulators.
You can refer the merged patch[1].

[1] commit 4294a779bd8dff6c65e7e85ffe7a1ea236e92a68
- PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()


> +	ret = regulator_enable(cci_df->proc_reg);
> +	if (ret) {
> +		pr_warn("enable buck for cci fail\n");

Use dev_err instead of 'pr_warn'.

> +		return ret;
> +	}
> +
> +	ret = dev_pm_opp_of_add_table(cci_dev);
> +	if (ret) {
> +		dev_err(cci_dev, "Fail to init CCI OPP table: %d\n", ret);

How about changing the error log as following
because in this driver, use the 'failed to' sentence for error handling?

	failed to get OPP table for CCI:L %d

> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, cci_df);
> +
> +	passive_data = devm_kzalloc(cci_dev, sizeof(*passive_data), GFP_KERNEL);
> +	if (!passive_data)
> +		return -ENOMEM;

On this error case, you have to call dev_pm_opp_of_remove_table().
You better to make the 'err_opp' jump lable and then add 'goto err_opp'.

> +
> +	passive_data->parent_type = CPUFREQ_PARENT_DEV;
> +
> +	cci_df->devfreq = devm_devfreq_add_device(cci_dev,
> +						  &cci_devfreq_profile,
> +						  DEVFREQ_GOV_PASSIVE,
> +						  passive_data);
> +	if (IS_ERR(cci_df->devfreq)) {
> +		ret = PTR_ERR(cci_df->devfreq);
> +		dev_err(cci_dev, "cannot create cci devfreq device:%d\n", ret);
> +		dev_pm_opp_of_remove_table(cci_dev);

Instead of direct call, use 'goto err_opp'.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_devfreq_remove(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct cci_devfreq *cci_df;
> +	struct notifier_block *opp_nb;
> +
> +	cci_df = platform_get_drvdata(pdev);
> +	opp_nb = &cci_df->opp_nb;
> +
> +	dev_pm_opp_unregister_notifier(cci_dev, opp_nb);

This patch doesn't call the dev_pm_opp_register_notifier.
Please remove it.

> +	devm_devfreq_remove_device(cci_dev, cci_df->devfreq);

Don't need to call this function because you used devm_devfreq_add_device().

> +	dev_pm_opp_of_remove_table(cci_dev)> +	regulator_disable(cci_df->proc_reg);
> +
> +	return 0;
> +}
> +
> +static const __maybe_unused struct of_device_id
> +	mediatek_cci_devfreq_of_match[] = {

Make it on one line and remove '__maybe_unused' keyword.
- mediatek_cci_devfreq_of_match-> mediatek_cci_of_match

> +	{ .compatible = "mediatek,mt8183-cci" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mediatek_cci_devfreq_of_match);

ditto.

> +
> +static struct platform_driver cci_devfreq_driver = {
> +	.probe	= mtk_cci_devfreq_probe,
> +	.remove	= mtk_cci_devfreq_remove,
> +	.driver = {
> +		.name = "mediatek-cci-devfreq",
> +		.of_match_table = of_match_ptr(mediatek_cci_devfreq_of_match),

ditto.

> +	},
> +};
> +
> +static int __init mtk_cci_devfreq_init(void)
> +{
> +	return platform_driver_register(&cci_devfreq_driver);
> +}
> +module_init(mtk_cci_devfreq_init)
> +
> +static void __exit mtk_cci_devfreq_exit(void)
> +{
> +	platform_driver_unregister(&cci_devfreq_driver);
> +}
> +module_exit(mtk_cci_devfreq_exit)

Use 'module_platform_driver' instead of module_init and module_exit.

> +
> +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> +MODULE_AUTHOR("Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
