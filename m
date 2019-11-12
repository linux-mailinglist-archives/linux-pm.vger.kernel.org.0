Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538F5F99A2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 20:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKLTWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 14:22:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33899 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfKLTWs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 14:22:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so14078133pff.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 11:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=luJmse4qyPM7h1duRVVj4w9vtvYZ5N4OxnAMNKQuEwE=;
        b=m16JaE0tMOWtKv1tqF+/ZWdvaOBM4HlTIkpMmeFucRm5m959uTSk/fcL/apBRI3BFt
         h8GgmusICQJZhhiTgshtPUUlSnORNdufj5yL0fmAN/If3aSA/nKvgqeyY0YHCiRWM09u
         2odKLe6PykEV5dVoLFdJHIY827tkpLhe9n2arNALTus4Bxjdbj/d8lljWkt881mrtvOx
         3qHv1rerAHnw00bm0MJLYhf6ZsvevbRzfEauwdw9n3XdouFliMpMysHVbKvg6zc7wfoN
         WTOkwdTnjGXLKFimj3/T2/+3VsDKEE8n5+O/VANZFd/zadb/u+7PuYV2hKjBlofehj8B
         K4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=luJmse4qyPM7h1duRVVj4w9vtvYZ5N4OxnAMNKQuEwE=;
        b=LHUUx5R7egF6jLQq8ERg9LJCQlqN3+tEWiRDvw3A74Pb1WAmZYrWsaRR0d6Dh42z3t
         qQzoNnmd0Los1+WJ0sW2EkgjaZPijDYuej9zJoETrkve8bbHuBOywnMhZ1QgFe4kZlAF
         UYcnU+fICTUHbkQKpPXaL7IsF6riStQjoie8zmLjy8hARSm1Yq4Ry/MsyvGm83gKufmX
         w8+hl3bU7Nym/lsoHT5+6ZSb2FeDoG8zjLglovQ8l/4NhG07PGGWRbJLVFL3bNxe0oaJ
         LuP5U1qwMvqi3t0Zn+CrjBtcoSE9K59REkOdh71IPZQyVL5jj2TXvW75SIZHrLtwSy6K
         XSdw==
X-Gm-Message-State: APjAAAWJjNulilfe+VSsgBaWGSjPCg/bnmrd2XxHFZfX1iSSK07tjMAm
        pef72P5RmFh7K3/FoGPodhOgwA==
X-Google-Smtp-Source: APXvYqysD+TiqAUSvdUCYG2LXpASlGJtt1tzc0lSVX4vWFlJ3Z5O7G8bMlEUHEuFLgsKBKbcpTg2Ww==
X-Received: by 2002:a63:586:: with SMTP id 128mr27395209pgf.198.1573586567270;
        Tue, 12 Nov 2019 11:22:47 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i22sm3220287pjx.1.2019.11.12.11.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:22:46 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:22:44 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: thermal: tsens: Add watchdog support
Message-ID: <20191112192244.GB3140946@builder>
References: <cover.1573499020.git.amit.kucheria@linaro.org>
 <c08cf285b8696c4fd00706b85cd3c88d12f97df3.1573499020.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08cf285b8696c4fd00706b85cd3c88d12f97df3.1573499020.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 11 Nov 11:21 PST 2019, Amit Kucheria wrote:

> TSENS IP v2.3 onwards adds support for a watchdog to detect if the TSENS
> HW FSM is frozen. Add support to detect and restart the FSM in the
> driver. The watchdog is configured by the bootloader, we just enable the
> feature in the kernel.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 41 +++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens-v2.c     | 10 +++++++
>  drivers/thermal/qcom/tsens.h        | 12 +++++++++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 2989cb952cdb..9432518502a7 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -378,6 +378,28 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
>  	bool enable = true, disable = false;
>  	unsigned long flags;
>  	int temp, ret, i;
> +	u32 wdog_status, wdog_count, ver_minor;
> +
> +	ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);

The version is unlikely to change from one interrupt to the next, so I
suggest that you add a boolean "has_watchdog" to your context that you
populate in init_common.

> +	if (ret)
> +		return ret;
> +
> +	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
> +		/* Watchdog is present only on v2.3+ */
> +		ret = regmap_field_read(priv->rf[WDOG_BARK_STATUS], &wdog_status);
> +		if (ret)
> +			return ret;
> +
> +		/* Clear WDOG interrupt */
> +		regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
> +		regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
> +
> +		ret = regmap_field_read(priv->rf[WDOG_BARK_COUNT], &wdog_count);
> +		if (ret)
> +			return ret;
> +		if (wdog_count)
> +			dev_err(priv->dev, "%s: watchdog count: %d\n", __func__, wdog_count);

What's the benefit of reading wdog_count and who's the audience for this
print? What do I do when this goes to 11?

Regards,
Bjorn

> +	}
>  
>  	for (i = 0; i < priv->num_sensors; i++) {
>  		struct tsens_sensor *s = &priv->sensor[i];
> @@ -685,6 +707,7 @@ int __init init_common(struct tsens_priv *priv)
>  {
>  	void __iomem *tm_base, *srot_base;
>  	struct device *dev = priv->dev;
> +	u32 ver_minor;
>  	struct resource *res;
>  	u32 enabled;
>  	int ret, i, j;
> @@ -734,6 +757,9 @@ int __init init_common(struct tsens_priv *priv)
>  			if (IS_ERR(priv->rf[i]))
>  				return PTR_ERR(priv->rf[i]);
>  		}
> +		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
> +		if (ret)
> +			goto err_put_device;
>  	}
>  
>  	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
> @@ -794,6 +820,21 @@ int __init init_common(struct tsens_priv *priv)
>  		}
>  	}
>  
> +	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
> +		/* Watchdog is present only on v2.3+ */
> +		for (i = 0, j = WDOG_BARK_STATUS; j <= CC_MON_MASK; i++, j++) {
> +			priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> +							      priv->fields[j]);
> +			if (IS_ERR(priv->rf[j])) {
> +				ret = PTR_ERR(priv->rf[j]);
> +				goto err_put_device;
> +			}
> +		}
> +		/* Enable WDOG and disable cycle completion monitoring */
> +		regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> +		regmap_field_write(priv->rf[CC_MON_MASK], 1);
> +	}
> +
>  	spin_lock_init(&priv->ul_lock);
>  	tsens_enable_irq(priv);
>  	tsens_debug_init(op);
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 47d831df0803..4184850d1e42 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -24,6 +24,7 @@
>  #define TM_Sn_CRITICAL_THRESHOLD_OFF	0x0060
>  #define TM_Sn_STATUS_OFF		0x00a0
>  #define TM_TRDY_OFF			0x00e4
> +#define TM_WDOG_LOG_OFF		0x013c
>  
>  /* v2.x: 8996, 8998, sdm845 */
>  
> @@ -66,6 +67,15 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_CLEAR,  TM_CRITICAL_INT_CLEAR_OFF),
>  	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_MASK,   TM_CRITICAL_INT_MASK_OFF),
>  
> +	/* WATCHDOG on v2.3 or later */
> +	[WDOG_BARK_STATUS] = REG_FIELD(TM_CRITICAL_INT_STATUS_OFF, 31, 31),
> +	[WDOG_BARK_CLEAR]  = REG_FIELD(TM_CRITICAL_INT_CLEAR_OFF,  31, 31),
> +	[WDOG_BARK_MASK]   = REG_FIELD(TM_CRITICAL_INT_MASK_OFF,   31, 31),
> +	[CC_MON_STATUS]    = REG_FIELD(TM_CRITICAL_INT_STATUS_OFF, 30, 30),
> +	[CC_MON_CLEAR]     = REG_FIELD(TM_CRITICAL_INT_CLEAR_OFF,  30, 30),
> +	[CC_MON_MASK]      = REG_FIELD(TM_CRITICAL_INT_MASK_OFF,   30, 30),
> +	[WDOG_BARK_COUNT]  = REG_FIELD(TM_WDOG_LOG_OFF,             0,  7),
> +
>  	/* Sn_STATUS */
>  	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
>  	REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 21,  21),
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 9b5a30533c52..7608e7877a7b 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -440,6 +440,18 @@ enum regfield_ids {
>  	CRIT_THRESH_13,
>  	CRIT_THRESH_14,
>  	CRIT_THRESH_15,
> +
> +	/* WATCHDOG */
> +	WDOG_BARK_STATUS,
> +	WDOG_BARK_CLEAR,
> +	WDOG_BARK_MASK,
> +	WDOG_BARK_COUNT,
> +
> +	/* CYCLE COMPLETION MONITOR */
> +	CC_MON_STATUS,
> +	CC_MON_CLEAR,
> +	CC_MON_MASK,
> +
>  	MIN_STATUS_0,		/* MIN threshold violated */
>  	MIN_STATUS_1,
>  	MIN_STATUS_2,
> -- 
> 2.17.1
> 
