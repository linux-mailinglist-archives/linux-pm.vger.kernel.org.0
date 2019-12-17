Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2E122835
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 11:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLQKCJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 05:02:09 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:18300 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfLQKCJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 05:02:09 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191217100205epoutp0372ef6299825869f0ffee663cd4774ff2~hIFxC5B8r1843218432epoutp03e
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 10:02:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191217100205epoutp0372ef6299825869f0ffee663cd4774ff2~hIFxC5B8r1843218432epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576576925;
        bh=JnDHtsKVse5qbxPZE12i8FqY5KenMgul4NNtd3cn7lQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OOHtG9yNfeIrmCRakcDVHL87XpUyZcRmrgrUnE/2aHF8xKJwhL8wBwYFohmiUqSew
         37k1SOK1K7ZmiEW1Qp5xz8XD3rOCTFtHcNjh8suZDEucw4yNJM//vph9vX48zBosPN
         oiB5W/bpJVzlBoYorRN1OmrwClLwnr0RXEh+1vak=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191217100204epcas1p40b1432eeaa2f8caf5ce6598e121ded75~hIFwTpUYc1066710667epcas1p4C;
        Tue, 17 Dec 2019 10:02:04 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47cYZw5LJSzMqYkg; Tue, 17 Dec
        2019 10:02:00 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.65.52419.897A8FD5; Tue, 17 Dec 2019 19:02:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191217100200epcas1p2dd8a436ffe11e247299fa425f99e7336~hIFscPkRd1006710067epcas1p2D;
        Tue, 17 Dec 2019 10:02:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191217100200epsmtrp23ffac60c97a2ea017d5a3199d4e980ed~hIFsbdkqN0274602746epsmtrp2w;
        Tue, 17 Dec 2019 10:02:00 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-ca-5df8a798bce4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.F5.06569.897A8FD5; Tue, 17 Dec 2019 19:02:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191217100159epsmtip21fbba5e3799b5629b4a3716af351806f~hIFsHgfmT0466804668epsmtip28;
        Tue, 17 Dec 2019 10:01:59 +0000 (GMT)
Subject: Re: [v5, PATCH 3/5] devfreq: add mediatek cci devfreq
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <bc023722-824c-167e-1a9e-1ebbaef3892b@samsung.com>
Date:   Tue, 17 Dec 2019 19:08:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1574769046-28449-4-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNJsWRmVeSWpSXmKPExsWy7bCmvu6M5T9iDeZP17bYvv4Fq8X8I+dY
        Lb7d+c1kcbbpDbvFpsfXWC0u75rDZnG5+SKjxefeI4wWS69fZLJoajG2uN24gs3izY+zTBZn
        Tl9itWjde4Td4t+1jSwW0+8KWWz86uEg6LFm3hpGj52z7rJ7bFrVyeZx59oeNo/NS+o9Wk7u
        Z/HYcrWdxaNvyypGj+M3tjN5fN4kF8AVlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhr
        aGlhrqSQl5ibaqvk4hOg65aZA/SNkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA
        skCvODG3uDQvXS85P9fK0MDAyBSoMCE748Dcf4wFSwIrHhyZw97AeN6hi5GTQ0LAROLVn1OM
        XYxcHEICOxglTv57ywqSEBL4xCix+pkWhP2NUeL7Z3uYhlkzZzBBNOxllNiy6jGU8x6oYe5U
        9i5GDg5hATuJnTedQeIiApOYJSZsfsAI0s0scItR4vV+NhCbTUBLYv+LG2A2v4CixNUfj8Fq
        eIF6m/88BbuCRUBV4u/VXjBbVCBM4uS2FqgaQYmTM5+wgNicAr4Si9acYoKYLy5x68l8KFte
        YvvbOcwgR0gI3GKXONu3gxHiBReJvmc/2SFsYYlXx7dA2VISn9/tZYOwqyVWnjzCBtHcAfTm
        /gusEAljif1LJzOBfMksoCmxfpc+RFhRYufvuVBP8km8+9rDClIiIcAr0dEmBFGiLHH5wV0m
        CFtSYnF7J9sERqVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAmPkyN7ECE7oWuY7GDec
        8znEKMDBqMTDW1D2PVaINbGsuDL3EKMEB7OSCO8OBaAQb0piZVVqUX58UWlOavEhRlNgaE9k
        lhJNzgdmm7ySeENTI2NjYwsTQzNTQ0MlcV6OHxdjhQTSE0tSs1NTC1KLYPqYODilGhj1Zm5g
        znjyTvFFnMieFx3dM7WnRoe0rdsZ1Ln3Q46eYofZ8lU/a8wWiuy59T7mzXaJJ0+cY89utTgs
        uCyMm3WSwPu1u5LVfy9uZjvuVbDz0pvvukIzePNuTg2pK7L4WGN1b45b2JqLQd6z+szWhvhv
        +ri976PGxbIDSw4sbqytZ0/OfsHg0DJFiaU4I9FQi7moOBEAtS84y/4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCSvO6M5T9iDe7dYbPYvv4Fq8X8I+dY
        Lb7d+c1kcbbpDbvFpsfXWC0u75rDZnG5+SKjxefeI4wWS69fZLJoajG2uN24gs3izY+zTBZn
        Tl9itWjde4Td4t+1jSwW0+8KWWz86uEg6LFm3hpGj52z7rJ7bFrVyeZx59oeNo/NS+o9Wk7u
        Z/HYcrWdxaNvyypGj+M3tjN5fN4kF8AVxWWTkpqTWZZapG+XwJVxYO4/xoIlgRUPjsxhb2A8
        79DFyMkhIWAiMWvmDKYuRi4OIYHdjBLvf+5ngUhISky7eJS5i5EDyBaWOHy4GKLmLaPE/M59
        LCBxYQE7iZ03nUHiIgLTmCWe/nvNBuIwC9xilNjUfIQdouMxo8TDKX+YQaayCWhJ7H9xgw3E
        5hdQlLj64zEjiM0LNKn5z1NWEJtFQFXi79VeMFtUIExi55LHTBA1ghInZz4Bu45TwFdi0ZpT
        YHFmAXWJP/MuMUPY4hK3nsyHistLbH87h3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5
        xYYFRnmp5XrFibnFpXnpesn5uZsYwfGtpbWD8cSJ+EOMAhyMSjy8EiXfY4VYE8uKK3MPMUpw
        MCuJ8O5QAArxpiRWVqUW5ccXleakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLglGpg
        ZJnUpy789+KDtT+NV+ZPUpJZcv5huszZaq9tXp3xDkFfZs1jrzSdbzdVuZl5pkurwuWrnVYu
        jF9P/lw12+pMYHq3Yfolq4frzs1YeioiM+zkn8iFy5tyRTdus9wv+unSJ+dJp1i2hRs8qjvD
        0bcoYae74UHN0xMs7vsYTV0Vnn9fuerq14QLr5RYijMSDbWYi4oTAexo4iTrAgAA
X-CMS-MailID: 20191217100200epcas1p2dd8a436ffe11e247299fa425f99e7336
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191126115136epcas5p241f7e64102dab29530370fb5e7f9c6fc
References: <1574769046-28449-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20191126115136epcas5p241f7e64102dab29530370fb5e7f9c6fc@epcas5p2.samsung.com>
        <1574769046-28449-4-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

"mtk_cci_vmon" governor looks like the devfreq passive governor.
But, the existing devfreq passive governor depend on the other devfreq device.
"mtk_cci_vmon" governor depend on the regulator with regulator notifier.

I think that it is better to extend the passive governor
in order to support the regulator notifier.
It is possible because passive governor already used
the devfreq notifier. 

Previously, the patch[1] tried to add the cpu based scaling to passive governor.
[1] https://lore.kernel.org/patchwork/patch/1101049/
- [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor

Regards,
Chanwoo Choi

On 11/26/19 8:50 PM, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
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
>  drivers/devfreq/mt8183-cci-devfreq.c | 247 +++++++++++++++++++++++++++++++++++
>  3 files changed, 258 insertions(+)
>  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index defe1d438710..76bc42657787 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -92,6 +92,16 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  and adjusts the operating frequencies and voltages with OPP support.
>  	  This does not yet operate with optimal voltages.
>  
> +config ARM_MT8183_CCI_DEVFREQ
> +	tristate "MT8183 CCI DEVFREQ Driver"
> +	depends on ARM_MEDIATEK_CPUFREQ
> +	help
> +		This adds a devfreq driver for Cache Coherent Interconnect
> +		of Mediatek MT8183, which is shared the same regulator
> +		with cpu cluster.
> +		It can track buck voltage and update a proper cci frequency.
> +		Use notification to get regulator status.
> +
>  config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 338ae8440db6..1fa05e39e4ff 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> +obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
> diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> new file mode 100644
> index 000000000000..818a167c442f
> --- /dev/null
> +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
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
> +
> +#include "governor.h"
> +
> +struct cci_devfreq {
> +	struct devfreq *devfreq;
> +	struct regulator *proc_reg;
> +	unsigned long proc_reg_uV;																																																																																															
> +	struct clk *cci_clk;
> +	struct notifier_block nb;
> +};
> +
> +static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
> +					  unsigned long val, void *data)
> +{
> +	int ret;
> +	struct cci_devfreq *cci_df =
> +		container_of(nb, struct cci_devfreq, nb);
> +
> +	/* deal with reduce frequency */
> +	if (val & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
> +		struct pre_voltage_change_data *pvc_data = data;
> +
> +		if (pvc_data->min_uV < pvc_data->old_uV) {
> +			cci_df->proc_reg_uV =
> +				(unsigned long)(pvc_data->min_uV);
> +			mutex_lock(&cci_df->devfreq->lock);
> +			ret = update_devfreq(cci_df->devfreq);
> +			if (ret)
> +				pr_err("Fail to reduce cci frequency: %d\n",
> +				       ret);
> +			mutex_unlock(&cci_df->devfreq->lock);
> +		}
> +	} else if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) &&
> +	    ((unsigned long)data > cci_df->proc_reg_uV)) {
> +		cci_df->proc_reg_uV = (unsigned long)data;
> +		mutex_lock(&cci_df->devfreq->lock);
> +		ret = update_devfreq(cci_df->devfreq);
> +		if (ret)
> +			pr_err("Fail to raise cci frequency back: %d\n", ret);
> +		mutex_unlock(&cci_df->devfreq->lock);
> +	} else if ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&
> +	    (cci_df->proc_reg_uV < (unsigned long)data)) {
> +		/* deal with increase frequency */
> +		cci_df->proc_reg_uV = (unsigned long)data;
> +		mutex_lock(&cci_df->devfreq->lock);
> +		ret = update_devfreq(cci_df->devfreq);
> +		if (ret)
> +			pr_err("Fail to raise cci frequency: %d\n", ret);
> +		mutex_unlock(&cci_df->devfreq->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_governor_get_target(struct devfreq *devfreq,
> +				       unsigned long *freq)
> +{
> +	struct cci_devfreq *cci_df;
> +	struct dev_pm_opp *opp;
> +
> +	cci_df = dev_get_drvdata(devfreq->dev.parent);
> +
> +	/* find available frequency */
> +	opp = dev_pm_opp_find_freq_ceil_by_volt(devfreq->dev.parent,
> +						cci_df->proc_reg_uV);
> +	*freq = dev_pm_opp_get_freq(opp);
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
> +					  unsigned int event, void *data)
> +{
> +	int ret;
> +	struct cci_devfreq *cci_df;
> +	struct notifier_block *nb;
> +
> +	cci_df = dev_get_drvdata(devfreq->dev.parent);
> +	nb = &cci_df->nb;
> +
> +	switch (event) {
> +	case DEVFREQ_GOV_START:
> +	case DEVFREQ_GOV_RESUME:
> +		nb->notifier_call = cci_devfreq_regulator_notifier;
> +		ret = regulator_register_notifier(cci_df->proc_reg,
> +						  nb);
> +		if (ret)
> +			pr_err("%s: failed to add governor: %d\n", __func__,
> +			       ret);
> +		break;
> +
> +	case DEVFREQ_GOV_STOP:
> +	case DEVFREQ_GOV_SUSPEND:
> +		ret = regulator_unregister_notifier(cci_df->proc_reg,
> +						    nb);
> +		if (ret)
> +			pr_err("%s: failed to add governor: %d\n", __func__,
> +			       ret);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct devfreq_governor mtk_cci_devfreq_governor = {
> +	.name = "mtk_cci_vmon",
> +	.get_target_freq = mtk_cci_governor_get_target,
> +	.event_handler = mtk_cci_governor_event_handler,
> +	.immutable = true
> +};
> +
> +static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
> +				  u32 flags)
> +{
> +	int ret;
> +	struct cci_devfreq *cci_df = dev_get_drvdata(dev);
> +
> +	if (!cci_df)
> +		return -EINVAL;
> +
> +	ret = clk_set_rate(cci_df->cci_clk, *freq);
> +	if (ret) {
> +		pr_err("%s: failed cci to set rate: %d\n", __func__,
> +		       ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile cci_devfreq_profile = {
> +	.target = mtk_cci_devfreq_target,
> +};
> +
> +static int mtk_cci_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct cci_devfreq *cci_df;
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
> +
> +	ret = dev_pm_opp_of_add_table(cci_dev);
> +	if (ret) {
> +		dev_err(cci_dev, "Fail to init CCI OPP table: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, cci_df);
> +
> +	cci_df->devfreq = devm_devfreq_add_device(cci_dev,
> +						  &cci_devfreq_profile,
> +						  "mtk_cci_vmon",
> +						  NULL);
> +	if (IS_ERR(cci_df->devfreq)) {
> +		ret = PTR_ERR(cci_df->devfreq);
> +		dev_err(cci_dev, "cannot create cci devfreq device:%d\n", ret);
> +		dev_pm_opp_of_remove_table(cci_dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const __maybe_unused struct of_device_id
> +	mediatek_cci_devfreq_of_match[] = {
> +	{ .compatible = "mediatek,mt8183-cci" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mediatek_cci_devfreq_of_match);
> +
> +static struct platform_driver cci_devfreq_driver = {
> +	.probe	= mtk_cci_devfreq_probe,
> +	.driver = {
> +		.name = "mediatek-cci-devfreq",
> +		.of_match_table = of_match_ptr(mediatek_cci_devfreq_of_match),
> +	},
> +};
> +
> +static int __init mtk_cci_devfreq_init(void)
> +{
> +	int ret;
> +
> +	ret = devfreq_add_governor(&mtk_cci_devfreq_governor);
> +	if (ret) {
> +		pr_err("%s: failed to add governor: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&cci_devfreq_driver);
> +	if (ret)
> +		devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +
> +	return ret;
> +}
> +module_init(mtk_cci_devfreq_init)

Use module_platform_driver

> +
> +static void __exit mtk_cci_devfreq_exit(void)
> +{
> +	int ret;
> +
> +	ret = devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +	if (ret)
> +		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
> +
> +	platform_driver_unregister(&cci_devfreq_driver);
> +}
> +module_exit(mtk_cci_devfreq_exit)
> +
> +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> +MODULE_AUTHOR("Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
