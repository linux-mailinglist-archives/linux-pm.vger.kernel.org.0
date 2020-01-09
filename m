Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6E136258
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 22:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgAIVRs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 16:17:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35814 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVRs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 16:17:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so8973861wro.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2020 13:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qyCXD4vr+CxrllLBvsL4+jVtHYuViKNKBfxikWr3PLM=;
        b=oRoij5JnWSAzDoK+ggWMXcAqnWhKoBf/TwQrJL3Gd9j4PxZIOAR8KqBO9MB8uHfGnX
         Y2GZwLjcQRCIbMmjJwv/OkYagNEIppnFmO/sF4Fzm0lch6vUJAVdgELnxoVwH/KhEyg3
         ekOZUKipGGhrY1E8z5yBttQpWCLLqlAu6UwxZod69xVmwITFG0j+68LltOp0Dp2UoAT7
         MivWhDveT1P6FYVNCC6fZJWaY5z1njBz6tk+Xyv9vnuOBIlPfHoyziSlBYXhcAtBOoWv
         3Rd/SfD9LCLBH6pa7FdWVhBGoEb7rtV2Krpre7Hj8Q83qdxLt6swFg69HCsloczWJv1q
         EM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qyCXD4vr+CxrllLBvsL4+jVtHYuViKNKBfxikWr3PLM=;
        b=lL1d+4l/U3WrMNO00LZvBfAL3Nn7/iERxFEbJVGJswNufvemqUvI4yPyk+NCpR6jKO
         HO5CcP7G/PT0Z53IZ3XkQEwZgc9a/0MiYSEyz49+nYCWYKrvTVOpmV6519frvR0BgYZe
         jU3hQLonOmWNnuGpLgOzuceklDUu5Gtw6I+toQlaREUU71y0fimFABMhM5RwkSRof/s2
         7XrlagVkpSnGhhshJDeXj21Ux+EErKny4gVaHkg6XW3Z7C6SRgFp45a2Q7fW8C1cHX+F
         xYfHUKhsi8oYXjho5ke3NrX0Xc1ABcgopr1aj6ie14QMPd3ghxd604hAtKErZ2QWoKNU
         8tgQ==
X-Gm-Message-State: APjAAAVDVnlnoxqbPkcLOWrDQb/c1eZ0LdKmE55xIwfXW1fcCl4jXAAt
        AMy171bub4OusVNZDERnYrfDSg==
X-Google-Smtp-Source: APXvYqxsXWMWUZCh/HEmygjcgJ8fi+WlzDrhxZ5x0b/eKvFt06A6uu6ebKswkzOKN89tLFRMo+/RVg==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr13221008wrw.188.1578604664754;
        Thu, 09 Jan 2020 13:17:44 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f1d5:61e0:e9d8:1c3d? ([2a01:e34:ed2f:f020:f1d5:61e0:e9d8:1c3d])
        by smtp.googlemail.com with ESMTPSA id m7sm4111134wma.39.2020.01.09.13.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 13:17:44 -0800 (PST)
Subject: Re: [PATCH v2 2/6] thermal: brcmstb_thermal: Prepare to support a
 different process
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191211203143.2952-1-f.fainelli@gmail.com>
 <20191211203143.2952-3-f.fainelli@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a8e6cb1a-fa03-a443-eaa2-2a6385ac6a37@linaro.org>
Date:   Thu, 9 Jan 2020 22:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211203143.2952-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/12/2019 21:31, Florian Fainelli wrote:
> The driver is currently assuming that it is operating with a 28nm
> process chip, which has a specific formula to convert temperature to a
> code and vice versa. Update the code to support providing two key
> values: offset and multiplier to derive the correct formulas.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 54 ++++++++++++++++------
>  1 file changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 680f1a070606..68f89f7c7e7f 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -102,18 +102,27 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
>  	},
>  };
>  
> +struct brcmstb_thermal_params {
> +	unsigned int offset;
> +	unsigned int mult;
> +};
> +
>  struct brcmstb_thermal_priv {
>  	void __iomem *tmon_base;
>  	struct device *dev;
>  	struct thermal_zone_device *thermal;
> +	/* Process specific thermal parameters used for calculations */
> +	struct brcmstb_thermal_params temp_params;
>  };
>  
>  /* Convert a HW code to a temperature reading (millidegree celsius) */
> -static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
> +static inline int avs_tmon_code_to_temp(struct brcmstb_thermal_priv *priv,
>  					u32 code)
>  {
> -	return (AVS_TMON_TEMP_OFFSET -
> -		(int)((code & AVS_TMON_TEMP_MAX) * AVS_TMON_TEMP_SLOPE));
> +	int offset = priv->temp_params.offset;
> +	int mult = priv->temp_params.mult;
> +
> +	return (offset - (int)((code & AVS_TMON_TEMP_MASK) * mult));
>  }
>  
>  /*
> @@ -122,21 +131,22 @@ static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
>   * @temp: temperature to convert
>   * @low: if true, round toward the low side
>   */
> -static inline u32 avs_tmon_temp_to_code(struct thermal_zone_device *tz,
> +static inline u32 avs_tmon_temp_to_code(struct brcmstb_thermal_priv *priv,
>  					int temp, bool low)
>  {
> +	int offset = priv->temp_params.offset;
> +	int mult = priv->temp_params.mult;
> +
>  	if (temp < AVS_TMON_TEMP_MIN)
> -		return AVS_TMON_TEMP_MAX;	/* Maximum code value */
> +		return AVS_TMON_TEMP_MASK;	/* Maximum code value */

Why this change?

>  
> -	if (temp >= AVS_TMON_TEMP_OFFSET)
> +	if (temp >= offset)
>  		return 0;	/* Minimum code value */
>  
>  	if (low)
> -		return (u32)(DIV_ROUND_UP(AVS_TMON_TEMP_OFFSET - temp,
> -					  AVS_TMON_TEMP_SLOPE));
> +		return (u32)(DIV_ROUND_UP(offset - temp, mult));
>  	else
> -		return (u32)((AVS_TMON_TEMP_OFFSET - temp) /
> -			      AVS_TMON_TEMP_SLOPE);
> +		return (u32)((offset - temp) / mult);
>  }
>  
>  static int brcmstb_get_temp(void *data, int *temp)
> @@ -154,7 +164,7 @@ static int brcmstb_get_temp(void *data, int *temp)
>  
>  	val = (val & AVS_TMON_STATUS_data_msk) >> AVS_TMON_STATUS_data_shift;
>  
> -	t = avs_tmon_code_to_temp(priv->thermal, val);
> +	t = avs_tmon_code_to_temp(priv, val);
>  	if (t < 0)
>  		*temp = 0;
>  	else
> @@ -188,7 +198,7 @@ static int avs_tmon_get_trip_temp(struct brcmstb_thermal_priv *priv,
>  	val &= trip->reg_msk;
>  	val >>= trip->reg_shift;
>  
> -	return avs_tmon_code_to_temp(priv->thermal, val);
> +	return avs_tmon_code_to_temp(priv, val);
>  }
>  
>  static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
> @@ -201,7 +211,7 @@ static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
>  	dev_dbg(priv->dev, "set temp %d to %d\n", type, temp);
>  
>  	/* round toward low temp for the low interrupt */
> -	val = avs_tmon_temp_to_code(priv->thermal, temp,
> +	val = avs_tmon_temp_to_code(priv, temp,
>  				    type == TMON_TRIP_TYPE_LOW);
>  
>  	val <<= trip->reg_shift;
> @@ -218,7 +228,7 @@ static int avs_tmon_get_intr_temp(struct brcmstb_thermal_priv *priv)
>  	u32 val;
>  
>  	val = __raw_readl(priv->tmon_base + AVS_TMON_TEMP_INT_CODE);
> -	return avs_tmon_code_to_temp(priv->thermal, val);
> +	return avs_tmon_code_to_temp(priv, val);
>  }
>  
>  static irqreturn_t brcmstb_tmon_irq_thread(int irq, void *data)
> @@ -282,19 +292,32 @@ static const struct thermal_zone_of_device_ops of_ops = {
>  	.set_trips	= brcmstb_set_trips,
>  };
>  
> +static const struct brcmstb_thermal_params brcmstb_28nm_params = {
> +	.offset	= 410040,
> +	.mult	= 487,
> +};
> +
>  static const struct of_device_id brcmstb_thermal_id_table[] = {
> -	{ .compatible = "brcm,avs-tmon" },
> +	{ .compatible = "brcm,avs-tmon", .data = &brcmstb_28nm_params },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, brcmstb_thermal_id_table);
>  
>  static int brcmstb_thermal_probe(struct platform_device *pdev)
>  {
> +	const struct brcmstb_thermal_params *params;
> +	const struct of_device_id *of_id = NULL;
>  	struct thermal_zone_device *thermal;
>  	struct brcmstb_thermal_priv *priv;
>  	struct resource *res;
>  	int irq, ret;
>  
> +	of_id = of_match_node(brcmstb_thermal_id_table, pdev->dev.of_node);
> +	if (!of_id || !of_id->data)
> +		return -EINVAL;

of_device_get_match_data(&pdev->dev) ?

> +	params = of_id->data;
> +
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> @@ -304,6 +327,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->tmon_base))
>  		return PTR_ERR(priv->tmon_base);
>  
> +	memcpy(&priv->temp_params, params, sizeof(priv->temp_params));

Do you really need a copy here? Why not convert to a pointer and assign it?

>  	priv->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, priv);
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

