Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B76D3AE8D3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFUMOt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFUMOt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 08:14:49 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79EC061574;
        Mon, 21 Jun 2021 05:12:32 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so17492054oti.2;
        Mon, 21 Jun 2021 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7prD3+xyczLmEe+2BW6g+fySkx140ZkBVmo1/PVnD/0=;
        b=fm4gnMesUyw40L3SKOPhrgTBm5DZNGB6NREf6eSHQIwbSBIi+4MV1hRSGtSenQQxyf
         V4mpB8XuBmtgMc/a1Pmx64AkTmBWXrf0SOiFEb6Vk7eElheahMKgLtxL8nzvyC0jOrPJ
         yM5oBJNk5yUSRRhuGAI9QEOQKcj0BbehVsPR45t0hrHCowVswteZtm796p+F80NDqBO3
         8qntcKBPouxTWLp6BCnU6wtgXeyJU6rCEPzG/wyMWzNZqEXj0opDAWcGgBflhoM8LXYV
         uzAwlkJyIDIpE2/V2E48Cj5z54hu2HtLQDLDmRdYL5Cw8AAWLT/AUN5o4md8eNjFu4r7
         TfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7prD3+xyczLmEe+2BW6g+fySkx140ZkBVmo1/PVnD/0=;
        b=tnEaapHFLKPRx7KAVwXjEoodolxc2dahDa5lrzv2HSzJWqRZnmbLTJjqrHD8G9b6EW
         N/Y5VVQVBjwd82Vq63kpnvxU30NEeH/VUrxgXBw8RVh/hAJ+3CT6EfbfStF/owKJyX2S
         aYN26x/T7E+zkA+KZuCazQMlF90vASY1FZH2cOsvgx+Z/CamC4yXO4Y7YlCgw74pllEq
         tTZ8qTGmEIn0qrlxXv+CLPD7cWKiMLcXXjxX02++wetfz/WNv3u4+ujqkjuwECIjI8sE
         ygqK+Mm2jH1mb7CQ7c5AHUYeqJPFF9YD8JJ2VaiXxDQQDDMh/+0wLPoYuMMV7/vm9ovQ
         zy5A==
X-Gm-Message-State: AOAM531ugoGOYjyASSw0bBAP4AyLkvZbamLFsO3NfuCaY7Wt81yzEZYT
        VeB0CNw4wBtNEw7VvSOfE/Y=
X-Google-Smtp-Source: ABdhPJz8s0vLG/6CFPlnj29FKy2jKzk7XkGcEWsdltHcIj7UMrnV4h5GbExX/F3zaZ+Rs5GLcq9Acg==
X-Received: by 2002:a9d:2f0:: with SMTP id 103mr20486373otl.174.1624277551825;
        Mon, 21 Jun 2021 05:12:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n20sm4086841otj.11.2021.06.21.05.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 05:12:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 21 Jun 2021 05:12:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (lm90) Prevent integer overflow of
 temperature calculations
Message-ID: <20210621121229.GB116119@roeck-us.net>
References: <20210620211408.3893-1-digetx@gmail.com>
 <20210620211408.3893-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210620211408.3893-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 21, 2021 at 12:14:07AM +0300, Dmitry Osipenko wrote:
> The minimum temperature value that is passed to the driver is unlimited
> and value that is close to INT_MIN results in integer overflow of
> temperature calculations made by the driver. Limit the value in order
> to prevent the overflow. For now the overflow condition is harmless,
> but thermal framework won't work properly once we will support the
> set_trips() callback because it will pass INT_MIN value to the driver.
> 

AFAICS that should only happen for lm99 because all other values
are bound in the temp_to_xxx functions. Where else do you see an
overflow (or underflow) ?

Thanks,
Guenter

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/hwmon/lm90.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index b53f17511b05..6e2fa976098f 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -1028,6 +1028,9 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
>  	struct reg *regp = &reg[index];
>  	int err;
>  
> +	/* prevent integer overflow */
> +	val = max(val, -128000l);
> +
>  	/* +16 degrees offset for temp2 for the LM99 */
>  	if (data->kind == lm99 && index <= 2)
>  		val -= 16000;
> @@ -1088,6 +1091,9 @@ static int lm90_set_temp8(struct lm90_data *data, int index, long val)
>  	struct i2c_client *client = data->client;
>  	int err;
>  
> +	/* prevent integer overflow */
> +	val = max(val, -128000l);
> +
>  	/* +16 degrees offset for temp2 for the LM99 */
>  	if (data->kind == lm99 && index == 3)
>  		val -= 16000;
> -- 
> 2.30.2
> 
