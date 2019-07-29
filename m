Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E707870B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfG2IM0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 04:12:26 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:48310 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfG2IM0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 04:12:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5FE39FB03;
        Mon, 29 Jul 2019 10:12:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3avP_g3MYwj1; Mon, 29 Jul 2019 10:12:22 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9C4E846BAF; Mon, 29 Jul 2019 10:12:21 +0200 (CEST)
Date:   Mon, 29 Jul 2019 10:12:21 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Anson.Huang@nxp.com
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        leonard.crestez@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 4/6] thermal: qoriq: Add clock operations
Message-ID: <20190729081221.GA2523@bogon.m.sigxcpu.org>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-4-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705045612.27665-4-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anson,
On Fri, Jul 05, 2019 at 12:56:10PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Some platforms like i.MX8MQ has clock control for this module,
> need to add clock operations to make sure the driver is working
> properly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 2b2f79b..0813c1b 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -2,6 +2,7 @@
>  //
>  // Copyright 2016 Freescale Semiconductor, Inc.
>  
> +#include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/err.h>
> @@ -72,6 +73,7 @@ struct qoriq_sensor {
>  
>  struct qoriq_tmu_data {
>  	struct qoriq_tmu_regs __iomem *regs;
> +	struct clk *clk;
>  	bool little_endian;
>  	struct qoriq_sensor	*sensor[SITES_MAX];
>  };
> @@ -208,6 +210,19 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  		return PTR_ERR(data->regs);
>  	}
>  
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk)) {
> +		if (PTR_ERR(data->clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		data->clk = NULL;
> +	}

Wouldn't devm_clk_get_optional make more sense?

> +
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to enable clock\n");
> +		return ret;
> +	}
> +
>  	qoriq_tmu_init_device(data);	/* TMU initialization */
>  
>  	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
> @@ -235,6 +250,8 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
>  	/* Disable monitoring */
>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
>  
> +	clk_disable_unprepare(data->clk);
> +
>  	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
> @@ -250,14 +267,21 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
>  	tmr &= ~TMR_ME;
>  	tmu_write(data, tmr, &data->regs->tmr);
>  
> +	clk_disable_unprepare(data->clk);
> +
>  	return 0;
>  }
>  
>  static int __maybe_unused qoriq_tmu_resume(struct device *dev)
>  {
>  	u32 tmr;
> +	int ret;
>  	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
>  
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret)
> +		return ret;
> +
>  	/* Enable monitoring */
>  	tmr = tmu_read(data, &data->regs->tmr);
>  	tmr |= TMR_ME;

Apart from that it looks like what Fabio sent and what i tested so

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido

> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
