Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49ACD9FE97
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 11:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfH1Jgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 05:36:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:6016 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfH1Jgg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 05:36:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 02:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="381226739"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by fmsmga006.fm.intel.com with ESMTP; 28 Aug 2019 02:36:29 -0700
Message-ID: <36f8f79c1353622bf0bb109296cd6229ac23e648.camel@intel.com>
Subject: Re: [PATCH] thermal: mediatek: add suspend/resume callback
From:   Zhang Rui <rui.zhang@intel.com>
To:     michael.kao@mediatek.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Louis Yu <louis.yu@mediatek.com>
Date:   Wed, 28 Aug 2019 17:36:38 +0800
In-Reply-To: <1562058985-27538-1-git-send-email-michael.kao@mediatek.com>
References: <1562058985-27538-1-git-send-email-michael.kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-07-02 at 17:16 +0800, michael.kao@mediatek.com wrote:
> From: Louis Yu <louis.yu@mediatek.com>
> 
> Add suspend/resume callback to disable/enable Mediatek thermal sensor
> respectively. Since thermal power domain is off in suspend, thermal
> driver
> needs re-initialization during resume.
> 
> Signed-off-by: Louis Yu <louis.yu@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
> This patch series base on these patches [1][2][3].
> 
> [1]thermal: mediatek: mt8183: fix bank number settings (
> https://patchwork.kernel.org/patch/10938817/)
> [2]thermal: mediatek: add another get_temp ops for thermal sensors (
> https://patchwork.kernel.org/patch/10938829/)
> [3]thermal: mediatek: use spinlock to protect PTPCORESEL (
> https://patchwork.kernel.org/patch/10938841/)
> 
all these patches are not sent to linux-pm mailing list, thus they
never got chance to get merged. please resend them to linux-pm.

I don't know what the first part of the patch set do, so I'm wondering
if there is any dependency?

thanks,
rui

>  drivers/thermal/mtk_thermal.c | 134
> +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 125 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c
> b/drivers/thermal/mtk_thermal.c
> index 3d01153..61d4114 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -30,6 +30,7 @@
>  #include <linux/thermal.h>
>  #include <linux/reset.h>
>  #include <linux/types.h>
> +#include <linux/iopoll.h>
>  
>  /* AUXADC Registers */
>  #define AUXADC_CON1_SET_V	0x008
> @@ -39,6 +40,8 @@
>  
>  #define APMIXED_SYS_TS_CON1	0x604
>  
> +#define APMIXED_SYS_TS_CON1_BUFFER_OFF	0x30
> +
>  /* Thermal Controller Registers */
>  #define TEMP_MONCTL0		0x000
>  #define TEMP_MONCTL1		0x004
> @@ -46,6 +49,7 @@
>  #define TEMP_MONIDET0		0x014
>  #define TEMP_MONIDET1		0x018
>  #define TEMP_MSRCTL0		0x038
> +#define TEMP_MSRCTL1		0x03c
>  #define TEMP_AHBPOLL		0x040
>  #define TEMP_AHBTO		0x044
>  #define TEMP_ADCPNP0		0x048
> @@ -95,6 +99,9 @@
>  #define TEMP_ADCVALIDMASK_VALID_HIGH		BIT(5)
>  #define TEMP_ADCVALIDMASK_VALID_POS(bit)	(bit)
>  
> +#define TEMP_MSRCTL1_BUS_STA	(BIT(0) | BIT(7))
> +#define TEMP_MSRCTL1_SENSING_POINTS_PAUSE	0x10E
> +
>  /* MT8173 thermal sensors */
>  #define MT8173_TS1	0
>  #define MT8173_TS2	1
> @@ -266,6 +273,10 @@ struct mtk_thermal_data {
>  struct mtk_thermal {
>  	struct device *dev;
>  	void __iomem *thermal_base;
> +	void __iomem *apmixed_base;
> +	void __iomem *auxadc_base;
> +	u64 apmixed_phys_base;
> +	u64 auxadc_phys_base;
>  
>  	struct clk *clk_peri_therm;
>  	struct clk *clk_auxadc;
> @@ -795,6 +806,42 @@ static void mtk_thermal_init_bank(struct
> mtk_thermal *mt, int num,
>  	mtk_thermal_put_bank(bank);
>  }
>  
> +static int mtk_thermal_disable_sensing(struct mtk_thermal *mt, int
> num)
> +{
> +	struct mtk_thermal_bank *bank = &mt->banks[num];
> +	u32 val;
> +	unsigned long timeout;
> +	void __iomem *addr;
> +	int ret = 0;
> +
> +	bank->id = num;
> +	bank->mt = mt;
> +
> +	mtk_thermal_get_bank(bank);
> +
> +	val = readl(mt->thermal_base + TEMP_MSRCTL1);
> +	/* pause periodic temperature measurement for sensing points */
> +	writel(val | TEMP_MSRCTL1_SENSING_POINTS_PAUSE,
> +	       mt->thermal_base + TEMP_MSRCTL1);
> +
> +	/* wait until temperature measurement bus idle */
> +	timeout = jiffies + HZ;
> +	addr = mt->thermal_base + TEMP_MSRCTL1;
> +
> +	ret = readl_poll_timeout(addr, val, (val &
> TEMP_MSRCTL1_BUS_STA) == 0x0,
> +				 0, timeout);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* disable periodic temperature meausrement on sensing points
> */
> +	writel(0x0, mt->thermal_base + TEMP_MONCTL0);
> +
> +out:
> +	mtk_thermal_put_bank(bank);
> +
> +	return ret;
> +}
> +
>  static u64 of_get_phys_base(struct device_node *np)
>  {
>  	u64 size64;
> @@ -917,7 +964,6 @@ static int mtk_thermal_probe(struct
> platform_device *pdev)
>  	struct device_node *auxadc, *apmixedsys, *np = pdev-
> >dev.of_node;
>  	struct mtk_thermal *mt;
>  	struct resource *res;
> -	u64 auxadc_phys_base, apmixed_phys_base;
>  	struct thermal_zone_device *tzdev;
>  	struct mtk_thermal_zone *tz;
>  
> @@ -954,11 +1000,11 @@ static int mtk_thermal_probe(struct
> platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	auxadc_phys_base = of_get_phys_base(auxadc);
> +	mt->auxadc_phys_base = of_get_phys_base(auxadc);
>  
>  	of_node_put(auxadc);
>  
> -	if (auxadc_phys_base == OF_BAD_ADDR) {
> +	if (mt->auxadc_phys_base == OF_BAD_ADDR) {
>  		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
>  		return -EINVAL;
>  	}
> @@ -969,11 +1015,12 @@ static int mtk_thermal_probe(struct
> platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	apmixed_phys_base = of_get_phys_base(apmixedsys);
> +	mt->apmixed_phys_base = of_get_phys_base(apmixedsys);
> +	mt->apmixed_base = of_iomap(apmixedsys, 0);
>  
>  	of_node_put(apmixedsys);
>  
> -	if (apmixed_phys_base == OF_BAD_ADDR) {
> +	if (mt->apmixed_phys_base == OF_BAD_ADDR) {
>  		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
>  		return -EINVAL;
>  	}
> @@ -985,19 +1032,19 @@ static int mtk_thermal_probe(struct
> platform_device *pdev)
>  	ret = clk_prepare_enable(mt->clk_auxadc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n",
> ret);
> -		return ret;
> +		goto err_disable_clk_auxadc;
>  	}
>  
>  	ret = clk_prepare_enable(mt->clk_peri_therm);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Can't enable peri clk: %d\n",
> ret);
> -		goto err_disable_clk_auxadc;
> +		goto err_disable_clk_peri_therm;
>  	}
>  
>  	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ;
> ctrl_id++)
>  		for (i = 0; i < mt->conf->num_banks; i++)
> -			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
> -					      auxadc_phys_base,
> ctrl_id);
> +			mtk_thermal_init_bank(mt, i, mt-
> >apmixed_phys_base,
> +					      mt->auxadc_phys_base,
> ctrl_id);
>  
>  	platform_set_drvdata(pdev, mt);
>  
> @@ -1041,11 +1088,80 @@ static int mtk_thermal_remove(struct
> platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused mtk_thermal_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct mtk_thermal *mt = platform_get_drvdata(pdev);
> +	int i, ret;
> +
> +	for (i = 0; i < mt->conf->num_banks; i++) {
> +		ret = mtk_thermal_disable_sensing(mt, i);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/* disable buffer */
> +	writel(readl(mt->apmixed_base + APMIXED_SYS_TS_CON1) |
> +	       APMIXED_SYS_TS_CON1_BUFFER_OFF,
> +	       mt->apmixed_base + APMIXED_SYS_TS_CON1);
> +
> +	clk_disable_unprepare(mt->clk_peri_therm);
> +	clk_disable_unprepare(mt->clk_auxadc);
> +
> +	return 0;
> +
> +out:
> +	dev_err(&pdev->dev, "Failed to wait until bus idle\n");
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused mtk_thermal_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct mtk_thermal *mt = platform_get_drvdata(pdev);
> +	int i, ret, ctrl_id;
> +
> +	ret = device_reset(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(mt->clk_auxadc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n",
> ret);
> +		goto err_disable_clk_auxadc;
> +	}
> +
> +	ret = clk_prepare_enable(mt->clk_peri_therm);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't enable peri clk: %d\n",
> ret);
> +		goto err_disable_clk_peri_therm;
> +	}
> +
> +	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ;
> ctrl_id++)
> +		for (i = 0; i < mt->conf->num_banks; i++)
> +			mtk_thermal_init_bank(mt, i, mt-
> >apmixed_phys_base,
> +					      mt->auxadc_phys_base,
> ctrl_id);
> +
> +	return 0;
> +
> +err_disable_clk_peri_therm:
> +	clk_disable_unprepare(mt->clk_peri_therm);
> +err_disable_clk_auxadc:
> +	clk_disable_unprepare(mt->clk_auxadc);
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mtk_thermal_pm_ops,
> +			 mtk_thermal_suspend, mtk_thermal_resume);
> +
>  static struct platform_driver mtk_thermal_driver = {
>  	.probe = mtk_thermal_probe,
>  	.remove = mtk_thermal_remove,
>  	.driver = {
>  		.name = "mtk-thermal",
> +		.pm = &mtk_thermal_pm_ops,
>  		.of_match_table = mtk_thermal_of_match,
>  	},
>  };

