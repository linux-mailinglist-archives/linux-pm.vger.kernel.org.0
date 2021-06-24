Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD13B3117
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFXORM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhFXORM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 10:17:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADDEC061756;
        Thu, 24 Jun 2021 07:14:52 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso5682419otu.10;
        Thu, 24 Jun 2021 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PltV1dDZIj1E5BryefLYmXslgsXDB9xPKP51qS/jnz0=;
        b=W1OLsto6Gj045hEpKGYZ0B2mTHZyojCO2CvrzyXAd2VTPRHlmjK0RIKAmp1n0GWdFi
         F27aJKcv5qLYdCQeMUPj4T4fgP6raZOmlGIfwZkCs6CREEQjjjg5+CSCGQSSoAEuilGX
         w9AKS4fG6Z+s70h4jVnRo+vL9ivfmpEHHDw6Ti2Jk72Y5kb18IZtGHmy6pRYhHKwk73d
         2PvRtKRC0xr4TWH8JTYlWcTEMvylIN0Z7Vkjv4DgnCI839YAWr1i2fxPZdLcQHKWWhU7
         sGXah0t2b5K7prqA1yX4MWpGQ/7D83E89Qh+dH98m4zG7AFVMxA48NdIH+THlukNtYLb
         0P6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PltV1dDZIj1E5BryefLYmXslgsXDB9xPKP51qS/jnz0=;
        b=CVo07bAU5ItWeETC8iePWp7QdQF4VqWHbksauYWPLhRZD0G9zROV9LV3v5pan22qMn
         C7cs3dAWiNnc71WGXnpw+ntC7/cUDeHndWco6BK+X6glTwxt3rBzUXSfKONHRFKXQhJ4
         KqLj+6ZBFOdKeNkZYc3wyGRd9tzobb9PDU+x5q7dVvFF3PZrFIILJsVPNd1duR15+kAG
         psc7J7FFubugvHNjC6Uh+nbsffCdF9s56/BIiQN6EFQbSxZCEIsDJ0CWGZXOxvtv6Zim
         BxoLIqj1zjQ6QPPmdVqjR0uqbhewYaYixOFIQ7X85J+raR38MJzVwW5Ne9390owWHFVa
         pLGA==
X-Gm-Message-State: AOAM531KuPb1fxGK4GXsMJO+ivnWh9atc1XdQQQHyVDzZSy4jjBpH7e9
        Q9TWp/wu8ocXHSXgu3mUeg8=
X-Google-Smtp-Source: ABdhPJwnNTR1KnX36TMCG0aIp4+cm+Rtg5S0BASEQG7634PuHiwjrqG+KJdgAXE/5mfLd/aQL8vYwg==
X-Received: by 2002:a9d:6a83:: with SMTP id l3mr4845954otq.189.1624544090563;
        Thu, 24 Jun 2021 07:14:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2sm611897ooa.39.2021.06.24.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 07:14:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Jun 2021 07:14:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 1/2] hwmon: (lm90) Prevent integer underflows of
 temperature calculations
Message-ID: <20210624141448.GA3691705@roeck-us.net>
References: <20210623042231.16008-1-digetx@gmail.com>
 <20210623042231.16008-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623042231.16008-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 23, 2021 at 07:22:30AM +0300, Dmitry Osipenko wrote:
> The min/max/crit and all other temperature values that are passed to
> the driver are unlimited and value that is close to INT_MIN results in
> integer underflow of the temperature calculations made by the driver
> for LM99 sensor. Temperature hysteresis is among those values that need
> to be limited, but limiting of hysteresis is independent from the sensor
> version. Add the missing limits.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/lm90.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index b53f17511b05..567b7c521f38 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -1029,8 +1029,11 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
>  	int err;
>  
>  	/* +16 degrees offset for temp2 for the LM99 */
> -	if (data->kind == lm99 && index <= 2)
> +	if (data->kind == lm99 && index <= 2) {
> +		/* prevent integer underflow */
> +		val = max(val, -128000l);
>  		val -= 16000;
> +	}
>  
>  	if (data->kind == adt7461 || data->kind == tmp451)
>  		data->temp11[index] = temp_to_u16_adt7461(data, val);
> @@ -1089,8 +1092,11 @@ static int lm90_set_temp8(struct lm90_data *data, int index, long val)
>  	int err;
>  
>  	/* +16 degrees offset for temp2 for the LM99 */
> -	if (data->kind == lm99 && index == 3)
> +	if (data->kind == lm99 && index == 3) {
> +		/* prevent integer underflow */
> +		val = max(val, -128000l);
>  		val -= 16000;
> +	}
>  
>  	if (data->kind == adt7461 || data->kind == tmp451)
>  		data->temp8[index] = temp_to_u8_adt7461(data, val);
> @@ -1137,6 +1143,9 @@ static int lm90_set_temphyst(struct lm90_data *data, long val)
>  	else
>  		temp = temp_from_s8(data->temp8[LOCAL_CRIT]);
>  
> +	/* prevent integer underflow */
> +	val = max(val, -128000l);
> +
>  	data->temp_hyst = hyst_to_reg(temp - val);
>  	err = i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
>  					data->temp_hyst);
