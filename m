Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528602DC181
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 14:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgLPNqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 08:46:17 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42867 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLPNqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 08:46:17 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EDD5560013;
        Wed, 16 Dec 2020 13:45:32 +0000 (UTC)
Date:   Wed, 16 Dec 2020 14:45:32 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: reset: at91-sama5d2_shdwc: add support for
 sama7g5
Message-ID: <20201216134532.GH2814589@piout.net>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
 <1608123453-1423-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608123453-1423-4-git-send-email-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/12/2020 14:57:33+0200, Claudiu Beznea wrote:
> Add support for SAMA7G5 by adding proper struct reg_config structure
> and since SAMA7G5 is not currently on LPDDR setups the commit also
> avoid the mapping of DDR controller.
> 

Honestly, I wouldn't leave the LPDDR part out because there is no
guarantee anyone will think about it when they have a design with LPDDR
and as a consequence, their device will behave properly but will be
very short lived.

> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 72 ++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index 3996167f676f..a3342c8c3728 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -78,9 +78,15 @@ struct pmc_reg_config {
>  	u8 mckr;
>  };
>  
> +struct ddrc_reg_config {
> +	u32 type_offset;
> +	u32 type_mask;
> +};
> +
>  struct reg_config {
>  	struct shdwc_reg_config shdwc;
>  	struct pmc_reg_config pmc;
> +	struct ddrc_reg_config ddrc;
>  };
>  
>  struct shdwc {
> @@ -262,6 +268,10 @@ static const struct reg_config sama5d2_reg_config = {
>  	.pmc = {
>  		.mckr		= 0x30,
>  	},
> +	.ddrc = {
> +		.type_offset	= AT91_DDRSDRC_MDR,
> +		.type_mask	= AT91_DDRSDRC_MD
> +	},
>  };
>  
>  static const struct reg_config sam9x60_reg_config = {
> @@ -275,6 +285,23 @@ static const struct reg_config sam9x60_reg_config = {
>  	.pmc = {
>  		.mckr		= 0x28,
>  	},
> +	.ddrc = {
> +		.type_offset	= AT91_DDRSDRC_MDR,
> +		.type_mask	= AT91_DDRSDRC_MD
> +	},
> +};
> +
> +static const struct reg_config sama7g5_reg_config = {
> +	.shdwc = {
> +		.wkup_pin_input = 0,
> +		.mr_rtcwk_shift = 17,
> +		.mr_rttwk_shift = 16,
> +		.sr_rtcwk_shift = 5,
> +		.sr_rttwk_shift = 4,
> +	},
> +	.pmc = {
> +		.mckr		= 0x28,
> +	},
>  };
>  
>  static const struct of_device_id at91_shdwc_of_match[] = {
> @@ -285,6 +312,10 @@ static const struct of_device_id at91_shdwc_of_match[] = {
>  	{
>  		.compatible = "microchip,sam9x60-shdwc",
>  		.data = &sam9x60_reg_config,
> +	},
> +	{
> +		.compatible = "microchip,sama7g5-shdwc",
> +		.data = &sama7g5_reg_config,
>  	}, {
>  		/*sentinel*/
>  	}
> @@ -294,6 +325,7 @@ MODULE_DEVICE_TABLE(of, at91_shdwc_of_match);
>  static const struct of_device_id at91_pmc_ids[] = {
>  	{ .compatible = "atmel,sama5d2-pmc" },
>  	{ .compatible = "microchip,sam9x60-pmc" },
> +	{ .compatible = "microchip,sama7g5-pmc" },
>  	{ /* Sentinel. */ }
>  };
>  
> @@ -355,30 +387,34 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
>  		goto clk_disable;
>  	}
>  
> -	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
> -	if (!np) {
> -		ret = -ENODEV;
> -		goto unmap;
> -	}
> +	if (at91_shdwc->rcfg->ddrc.type_mask) {
> +		np = of_find_compatible_node(NULL, NULL,
> +					     "atmel,sama5d3-ddramc");
> +		if (!np) {
> +			ret = -ENODEV;
> +			goto unmap;
> +		}
>  
> -	at91_shdwc->mpddrc_base = of_iomap(np, 0);
> -	of_node_put(np);
> +		at91_shdwc->mpddrc_base = of_iomap(np, 0);
> +		of_node_put(np);
>  
> -	if (!at91_shdwc->mpddrc_base) {
> -		ret = -ENOMEM;
> -		goto unmap;
> +		if (!at91_shdwc->mpddrc_base) {
> +			ret = -ENOMEM;
> +			goto unmap;
> +		}
> +
> +		ddr_type = readl(at91_shdwc->mpddrc_base +
> +				 at91_shdwc->rcfg->ddrc.type_offset) &
> +				 at91_shdwc->rcfg->ddrc.type_mask;
> +		if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
> +		    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
> +			iounmap(at91_shdwc->mpddrc_base);
> +			at91_shdwc->mpddrc_base = NULL;
> +		}
>  	}
>  
>  	pm_power_off = at91_poweroff;
>  
> -	ddr_type = readl(at91_shdwc->mpddrc_base + AT91_DDRSDRC_MDR) &
> -			 AT91_DDRSDRC_MD;
> -	if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
> -	    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
> -		iounmap(at91_shdwc->mpddrc_base);
> -		at91_shdwc->mpddrc_base = NULL;
> -	}
> -
>  	return 0;
>  
>  unmap:
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
