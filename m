Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CD71A83E8
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 17:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390841AbgDNP50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 11:57:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45260 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbgDNP5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 11:57:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0D0582A04F7
Subject: Re: [PATCH 3/4] power: supply: generic-adc-battery: Prepare for const
 properties
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
 <20200413183853.1088823-4-sebastian.reichel@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <7ae59eca-35b2-59ed-8fc9-212fdb8decc5@collabora.com>
Date:   Tue, 14 Apr 2020 17:57:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413183853.1088823-4-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 13/4/20 20:38, Sebastian Reichel wrote:
> This prepares the driver to work with the properties entry
> in power_supply_desc marked as const.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/power/supply/generic-adc-battery.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
> index bc462d1ec963..caa829738ef7 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -241,6 +241,7 @@ static int gab_probe(struct platform_device *pdev)
>  	struct power_supply_desc *psy_desc;
>  	struct power_supply_config psy_cfg = {};
>  	struct gab_platform_data *pdata = pdev->dev.platform_data;
> +	enum power_supply_property *properties;
>  	int ret = 0;
>  	int chan;
>  	int index = ARRAY_SIZE(gab_props);
> @@ -268,16 +269,16 @@ static int gab_probe(struct platform_device *pdev)
>  	 * copying the static properties and allocating extra memory for holding
>  	 * the extra configurable properties received from platform data.
>  	 */
> -	psy_desc->properties = kcalloc(ARRAY_SIZE(gab_props) +
> -					ARRAY_SIZE(gab_chan_name),
> -					sizeof(*psy_desc->properties),
> -					GFP_KERNEL);
> -	if (!psy_desc->properties) {
> +	properties = kcalloc(ARRAY_SIZE(gab_props) +
> +			     ARRAY_SIZE(gab_chan_name),
> +			     sizeof(*properties),
> +			     GFP_KERNEL);
> +	if (!properties) {
>  		ret = -ENOMEM;
>  		goto first_mem_fail;
>  	}
>  
> -	memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
> +	memcpy(properties, gab_props, sizeof(gab_props));
>  
>  	/*
>  	 * getting channel from iio and copying the battery properties
> @@ -294,13 +295,11 @@ static int gab_probe(struct platform_device *pdev)
>  			int index2;
>  
>  			for (index2 = 0; index2 < index; index2++) {
> -				if (psy_desc->properties[index2] ==
> -				    gab_dyn_props[chan])
> +				if (properties[index2] == gab_dyn_props[chan])
>  					break;	/* already known */
>  			}
>  			if (index2 == index)	/* really new */
> -				psy_desc->properties[index++] =
> -					gab_dyn_props[chan];
> +				properties[index++] = gab_dyn_props[chan];
>  			any = true;
>  		}
>  	}
> @@ -317,6 +316,7 @@ static int gab_probe(struct platform_device *pdev)
>  	 * as come channels may be not be supported by the device.So
>  	 * we need to take care of that.
>  	 */
> +	psy_desc->properties = properties;
>  	psy_desc->num_properties = index;
>  
>  	adc_bat->psy = power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
> @@ -358,7 +358,7 @@ static int gab_probe(struct platform_device *pdev)
>  			iio_channel_release(adc_bat->channel[chan]);
>  	}
>  second_mem_fail:
> -	kfree(psy_desc->properties);
> +	kfree(properties);
>  first_mem_fail:
>  	return ret;
>  }
> 
