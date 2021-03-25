Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852D8348A5B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 08:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYHrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 03:47:42 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50368 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhCYHrT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 03:47:19 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210325074717epoutp04c81830c101a62442058c19ad68b9e127~vhkiYs9gb1642216422epoutp04q
        for <linux-pm@vger.kernel.org>; Thu, 25 Mar 2021 07:47:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210325074717epoutp04c81830c101a62442058c19ad68b9e127~vhkiYs9gb1642216422epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616658437;
        bh=C/URtM00/Ssre5OU/ywN9SCFUEu/3oYD6cyNtoTj0M8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Lx5lI/9ieHTD6viX76T2OjN3rJ/jFpkKpn8+egWYPeHNTTQ5d/BO1cSwyPqboNbsL
         UZl7MFLR+D7JgoBxI1M5nDJfSazNCLXK7dnshsyphVGIQhse6qDE50tJSi7SCqBRYI
         p0DWKMTdeyFVbzwktUSjuXIClZO9ztDwLPSnzvcs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210325074716epcas1p4ddc629ddbf34a1af9817f20fc5cd2302~vhkhxGA6Z1424014240epcas1p4R;
        Thu, 25 Mar 2021 07:47:16 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4F5cdD4vJCz4x9Py; Thu, 25 Mar
        2021 07:47:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.2B.10347.DFF3C506; Thu, 25 Mar 2021 16:47:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210325074709epcas1p216c8211f89347c40aec85ce7e4bc60ae~vhka5h6I12289822898epcas1p2g;
        Thu, 25 Mar 2021 07:47:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210325074709epsmtrp1ccbf89c6bdd74c11bdd82f9f2dc520ff~vhka4Z-Ob2138121381epsmtrp1v;
        Thu, 25 Mar 2021 07:47:09 +0000 (GMT)
X-AuditID: b6c32a39-147ff7000002286b-18-605c3ffdd474
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.4F.33967.DFF3C506; Thu, 25 Mar 2021 16:47:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210325074708epsmtip1ad965d6fc9f8c0dc05580877a229e095~vhkaR8rgx2641226412epsmtip1z;
        Thu, 25 Mar 2021 07:47:08 +0000 (GMT)
Subject: Re: [PATCH V8 4/8] devfreq: add mediatek cci devfreq
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Message-ID: <58938ccf-d115-d52a-1260-eb29729e6bbd@samsung.com>
Date:   Thu, 25 Mar 2021 17:04:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1616499241-4906-5-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc27b24LruBTYzjBTuJvGkQAtUHYgY7JHlusgSGaiC1kslV4p
        obQ3vXRCl2U4EQrZ2FijbMjW4QRdhS3tGhgE5GENNsAijwHyiNjhxhBQS6goTO2DRf77/H7n
        +83vfM9DwBE9xsMFeepCWquWq0g8kNvy7T5x9LPXT2WLGzb2o9a78zz0yc9zODLZH/DQ4PlF
        PnKPGjBkfTTGQyPtdTga+WgIoJWLdoAaxocwdL40Hk19+BWOFtcGMTTQP8xDH3fa+eifMQsX
        1cyIkGWVShVRTTeaANVWO8OnrOYKnJoe68Cpe1+co0odXVzK9rCcS1XZzIDqm2jFqBXrS5mB
        WfkHlLRcQWsjaHWORpGnzk0h096SHZFJE8WSaEkS2k9GqOUFdAp5ND0z+lieyhOJjDgtV+k8
        rUw5y5KxBw9oNbpCOkKpYQtTSJpRqJgkJoaVF7A6dW5MjqYgWSIWx0k9wux85ZO5Dh5jOlJk
        cP+BlYAriZUgQACJBPjXwCJWCQIFIuI+gH31pXx/4QLQutyD+ws3gJ86O7nPLcPmlU1LJ4AX
        LZO4d0FE/AZgxcR2L4cQKdDpbgReUSgxyYHfdJs43oJD9ABYMzyEeVU4EQW75id87iAiEj5c
        ewS8LCQOwunbGz4Nl3gFXuio4Hk5jHgbOlpKNzXB0HFtzrelACIdPmiq9PU5xE44OWfC/Pwy
        bF2q8w2GhDEAmptMPH+Go3D1sgH4OQQu9Nn4fg6HTy+VbfIZeNthx/1mA4C2rh82zfGwq8Ho
        mSDwTNgH77bH+tuRsG39+uYmtsPl1Qs8rwQSQmgoE/kle+DI7Azm513wVnkFfhmQtVvi1G6J
        ULslQu3/w24CrhnsoBm2IJdmJYx0631bge/BRyXdBzVLv8f0AkwAegEUcMhQYek7J7NFQoW8
        WE9rNTKtTkWzvUDqOeBqTnhYjsbzY9SFMok0Lj4+HiVIEqUSCblT+J54ViYicuWFdD5NM7T2
        uQ8TBISXYBky80JBjTNBeeewpYIxMXVketkLIVqmcayKGti2cvpYi+5W3a96QpU1P3TplPPN
        XSeS06nqYPEeXuz4zN4zb8RIjB+8e8J19m9hVV37tasZVzMsz/j9xS823gxW6n6sPzfjYuOa
        XZ9HrPd//do2/b28ZX3b9+vJgVLu7GRXb3WQNc7dvca4Ta9WLtQvOR2pKOvfG7vDsmy7d0zf
        KRJMuzTHr5f1dEce6v4sZHKqpPOXKuOo8VDoanMHlaofzbfpz4YWrWWM2R147uiXcyfHryj6
        f3IwivK2jvcPy4JcafPZNfbjzuLQ6r1Pm74LSfvT+dhSNdXam2lo7m9wDA8+2agmuaxSLoni
        aFn5f3GK1QZ5BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA03Re0hTURzA8c69d3fX0eq2aR4tF64iFFpbWRx7WFHgLYSiP3qDG3XToU7Z
        7bUgzGlmK8Uelo2pFVa2zGg9lmVEm2JqWrOaM9fDOaxoC2tlghZ1G4H/fc75ne/550fhkudE
        LKXV7Wb1Ok22nBQRd51y2dxfy7erle5gNLLf+ChAFf1+EtU0dwlQpzEgRMMvSzBkG3AL0Iv7
        FhK9KHQBFCptBuhSjwtDxqIFqK+gjkSBkU4MPe3oFqDDD5uF6Lf7JoHOvpGgmz+YFRKmvroe
        MI3mN0LGZj1KMl53E8ncqs1nitoeEcztV0cIpuy2FTCtHjvGhGyy9aKtoqU72WztXlY/L0Ut
        yvzgbxLk1azaXzL8FTsETi4ygQgK0kmw2xrCTEBESegHAPrqXHh4EAPPuFr+mvprKXQ6Of5a
        QgcBtFxU8JbSy6Bv+DLg20j6LQ6/nB7F+QNOPwZw8NiYMPxrP4CuQpuQT0g6ET766CF5T6bj
        4auRAcBbTKdA79UxjDdBz4bHm44KeEfRG2Fj7QAWfjMFtp3zE7wj6DTYVW/61+L0HDhW3Y2H
        HQ1f+2uwsGdAe9CClwOpeVxuHpeYxyXmccl5QFhBDJvH5WTkcKo8lY7dp+A0OdweXYZiR26O
        DfxbemLCPWC3DikcAKOAA0AKl0eKizZtVkvEOzWGA6w+N12/J5vlHGAaRcijxc9NbekSOkOz
        m81i2TxW/3+KURGxh7AT3gPzrROHtM6+yuTVWnvVwQ3TC4TFV6p08sEslaxJOjnYGlf85ILC
        2DM281N7zzffDkN37c9tjjjTkazVyYXrA7KzRMOoMVWdG1lh7Cw1NCd0yKZ/8Slrljvrto+G
        MuTStK8L25UbEzb9CiR7zddXtqVmlqnXbLb2tczaq/dMUDaSlgaB9pqy97tjYeyGUlN5Wuo7
        y7djFcH+11L/4sundhmSJkwRz6tqiEr3VZZvGWq4kD+pZ7Q4aTB+ZF9tmZsMlCxZ67ojpKN6
        NczVrnby80Cl9/eypXEqx5ypKZCs9nge986c/x3PN3C5Lfq0zx2lodT3BbOfxRDOdbeKW+UE
        l6lRJeJ6TvMHIScQfmMDAAA=
X-CMS-MailID: 20210325074709epcas1p216c8211f89347c40aec85ce7e4bc60ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210323113411epcas1p3dcc8649a2e3bed66866e3470d7aab447
References: <1616499241-4906-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20210323113411epcas1p3dcc8649a2e3bed66866e3470d7aab447@epcas1p3.samsung.com>
        <1616499241-4906-5-git-send-email-andrew-sh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/23/21 8:33 PM, Andrew-sh.Cheng wrote:
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
>  drivers/devfreq/mt8183-cci-devfreq.c | 198 +++++++++++++++++++++++++++++++++++
>  3 files changed, 209 insertions(+)
>  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index f56132b0ae64..2538255ac2c1 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -111,6 +111,16 @@ config ARM_IMX8M_DDRC_DEVFREQ
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
> +		It can track buck voltage and update a proper CCI frequency.
> +		Use notification to get regulator status.
> +
>  config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index a16333ea7034..991ef7740759 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
> +obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  
> diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> new file mode 100644
> index 000000000000..018543db7bae
> --- /dev/null
> +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
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
> +#define MAX_VOLT_LIMIT		(1150000)
> +
> +struct cci_devfreq {
> +	struct devfreq *devfreq;
> +	struct regulator *cpu_reg;
> +	struct clk *cci_clk;
> +	int old_vproc;

nitpick. how about using 'old_voltage'?
because 'vproc' is not easy for understanding.

> +	unsigned long old_freq;
> +};
> +
> +static int mtk_cci_set_voltage(struct cci_devfreq *cci_df, int vproc)

nitpick: how about changing 'vproc -> voltage'?

> +{
> +	int ret;
> +
> +	ret = regulator_set_voltage(cci_df->cpu_reg, vproc,
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
> +	opp = devfreq_recommended_opp(dev, &opp_rate, 1);
> +	opp_voltage = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +
> +	old_voltage = cci_df->old_vproc;
> +	if (old_voltage == 0)
> +		old_voltage = regulator_get_voltage(cci_df->cpu_reg);
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
> +
> +	cci_df->old_freq = *freq;
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

Use dev_err_probe() to handle EPROBE_DEFER case. It makes code more simple.

> +		return ret;
> +	}
> +	cci_df->cpu_reg = devm_regulator_get_optional(cci_dev, "proc");
> +	ret = PTR_ERR_OR_ZERO(cci_df->cpu_reg);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cci_dev, "failed to get regulator for CCI: %d\n",
> +				ret);

ditto. Use dev_err_probe()

> +		return ret;
> +	}
> +	ret = regulator_enable(cci_df->cpu_reg);
> +	if (ret) {
> +		dev_err(cci_dev, "enable buck for cci fail\n");
> +		return ret;
> +	}
> +
> +	ret = dev_pm_opp_of_add_table(cci_dev);
> +	if (ret) {
> +		dev_err(cci_dev, "Fail to get OPP table for CCI: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, cci_df);
> +
> +	passive_data = devm_kzalloc(cci_dev, sizeof(*passive_data), GFP_KERNEL);
> +	if (!passive_data) {
> +		ret = -ENOMEM;
> +		goto err_opp;
> +	}
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
> +		goto err_opp;
> +	}
> +
> +	return 0;
> +
> +err_opp:
> +	dev_pm_opp_of_remove_table(cci_dev);
> +	return ret;
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

Why do you call this function without registration?
If you want to catch the OPP changes of devfreq,
you can use devfreq_register_opp_notifier/devfreq_unregister_opp_notifier
functions.

> +	dev_pm_opp_of_remove_table(cci_dev);
> +	regulator_disable(cci_df->cpu_reg);
> +
> +	return 0;
> +}
> +
> +static const __maybe_unused struct of_device_id
> +	mediatek_cci_of_match[] = {

Need to change it as following at same line:
static const __maybe_unused struct of_device_idmediatek_cci_of_match[] = {


> +	{ .compatible = "mediatek,mt8183-cci" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mediatek_cci_of_match);
> +
> +static struct platform_driver cci_devfreq_driver = {
> +	.probe	= mtk_cci_devfreq_probe,
> +	.remove	= mtk_cci_devfreq_remove,
> +	.driver = {
> +		.name = "mediatek-cci-devfreq",
> +		.of_match_table = of_match_ptr(mediatek_cci_of_match),
> +	},
> +};
> +
> +module_platform_driver(cci_devfreq_driver);
> +
> +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> +MODULE_AUTHOR("Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
