Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD142D3DD
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 04:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfE2Cg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 22:36:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40197 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfE2Cg0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 22:36:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so387016pgm.7;
        Tue, 28 May 2019 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UqRabNjRPQnvgjnJWF/HLeVUAOQcKrxoLjz5Ks5Zk14=;
        b=OJXX/kFsoeR3LwmcfwQsZnMVH3PNFHcXhM9qHlO/L/wpIMSIaTvv8+ING/er21ZLqE
         Te++GrRmdRj7xB/Nv5yC843zINnESjIZp0W7Dsd2qtBP6N526UHClF4iyvHvFR3JJUxm
         Uc4APeNqqfVl+hm+zZuQu8AnM+4unTrPVzr3jPQaTRqcpDFm5MBAdSXnhhNH6As7Juhv
         Vw4NBvgClLUaXBeQi3E9Qs2Bx524dOyUgUWHu2gH0tWxJkYD6n21bIdKfObJIn6UfxnL
         AzDLh6LKUk5SxkBJSYP3dkO50jmqMMXJO8kilJC55tTJKtA/80rcxenJvtkj4sPf121j
         oVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UqRabNjRPQnvgjnJWF/HLeVUAOQcKrxoLjz5Ks5Zk14=;
        b=rskH8luBAqJtqggcuwHUYvAGhTNaxDmPh61iXZN6yMwEn0covnKVczP8CSO/wpQ9Pf
         bz2wL4N1NYwaHc/eTqUZXpLXQXfCO+SmbOiLme8T9CIHeiQYMie6xUDjD7IM8DqmCCUF
         i/82du4bxsUH9oHhm1m2iFrpfhYykwGZRF3jdhzkUdEVwOS7UIpWtKQTYuFtdPAk+jeZ
         eyDszRehuWe8llcvUy7iXtK4lm4oLkQ3LjJxAgGUcBXB0K3A1AI2IAUe/GE4riFQ/m9A
         MVntrOrHhN3nGdCq9uyNZ7MfKVpzfwuhn414NqqZyRDFiIBmqd+kh/dE/r4KMmPA5hGB
         AkJQ==
X-Gm-Message-State: APjAAAU4tJ3wlkaTXPGKuLL3sY6MFN5rkkNoEUYI2JgEdv4NqU4RxHLm
        Q6b6aqdu36g7T5+cbMPxsVE81LwN
X-Google-Smtp-Source: APXvYqy7Tb1qacbicU7i1ZlMIo/eFWYRgK/f9iQ3mA7RBuJKkvK6SCuLdC6rTS01CvHhhQt+FH4Gew==
X-Received: by 2002:a05:6a00:43:: with SMTP id i3mr68656219pfk.113.1559097385629;
        Tue, 28 May 2019 19:36:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id f186sm19896792pfb.5.2019.05.28.19.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 19:36:24 -0700 (PDT)
Date:   Tue, 28 May 2019 19:36:22 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: tsens: Remove unnecessary comparison of
 unsigned integer with < 0
Message-ID: <20190529023619.GA12875@localhost.localdomain>
References: <20190527160825.GA24219@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527160825.GA24219@embeddedor>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Gustavo,

On Mon, May 27, 2019 at 11:08:25AM -0500, Gustavo A. R. Silva wrote:
> There is no need to compare hw_id with < 0 because such comparison
> of an unsigned value is always false.
> 
> Fix this by removing such comparison.


Thanks for fixing this. But we had to revert the commit that introduces
this issue. So this patch is no longer applicable.

> 
> Addresses-Coverity-ID: 1445440 ("Unsigned compared against 0")
> Fixes: 3e6a8fb33084 ("drivers: thermal: tsens: Add new operation to check if a sensor is enabled")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/thermal/qcom/tsens-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 928e8e81ba69..94878ad35464 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -69,7 +69,7 @@ bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
>  	u32 val;
>  	int ret;
>  
> -	if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
> +	if (hw_id > priv->num_sensors - 1)
>  		return -EINVAL;
>  	ret = regmap_field_read(priv->rf[SENSOR_EN], &val);
>  	if (ret)
