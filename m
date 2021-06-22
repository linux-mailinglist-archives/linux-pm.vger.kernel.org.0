Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878903B106D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 01:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFVXRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 19:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVXRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 19:17:45 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA9C061574;
        Tue, 22 Jun 2021 16:15:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so141673otl.3;
        Tue, 22 Jun 2021 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=34Auh1i6SvV+PBtkaz/fxO2ERpD1y8V1fbGL4UoV/dw=;
        b=iJMJxXaQl7gppQkFvDhkR4EEKSYBvulgsxvAfAkeb4ANcMmuK8dUSpf1zld7LHO9df
         LGEKvJA21HiPAUhBTOYfwedrqppcmg3QrkWdpzrqN5Hw21Rvk6VAutHVmkXnmKQ8GSiB
         D3lT8HgDTreYJaKda3sW19nRPDdPN/JPxu+XzWLzY+2mGPCc1ASKDFuV3xtyYFhh9WFP
         3TEZfCNpFgmiKTvlhEIj6Tm2NvaUSkLk6Ae/FZ59p2S1f762cFm7NU8XMw7CcVva1Ujs
         +SKRmt5AZh0A+uEThBM03IcxT2L1raTRkSsiUwv5Lm3hbIeR7nS3SJQe2gfXYjPG4Q2C
         fVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=34Auh1i6SvV+PBtkaz/fxO2ERpD1y8V1fbGL4UoV/dw=;
        b=KjKHbgeXMIeEMCdAx+IiqWJ6f/lmuI/6hU+c0uAoE0BHPxOlqJWFbZH6sEhj5l1K3n
         gT7ANnKrOQIc7nhUKAnJMHgoj2vF56ExNJTPjA9UzK9Iyb/iOYPhngYe65kwYr6vU28j
         8AB6SDQkbjuMpIHLAzC4xS9caMh9btRFDJ6BVt0uL2iHyYRS6x8dwaf7rmMRTb3NB3t3
         KaOld1aB7CqkPfdWidmt6xWASKTAzDFO5ygq9Lc62Kupm+AXY8MaZvHipCOR9JKst7EI
         b/50eeQ/6bhhOMSJ/LhnHV/kFuqn62NjDTpdgerH2bQ1Jh/Rgl6C1tM8pHFt6PITYj6I
         TK2A==
X-Gm-Message-State: AOAM532npHluXS10T9ELTz+F5stR0S0u7U/24t0gNiHZezBBPzt2cWP+
        qwzPfxlbiD1ZQHK/edp6CCs=
X-Google-Smtp-Source: ABdhPJwzeEqXe7k2vbDXHeOHLeWXEg7LqqDVSWKDOHOuntGn1dNeQvi44DTLZVhVL1ntFUdHb4XPSQ==
X-Received: by 2002:a9d:264a:: with SMTP id a68mr5216174otb.50.1624403727283;
        Tue, 22 Jun 2021 16:15:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i15sm196444ots.39.2021.06.22.16.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 16:15:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Jun 2021 16:15:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hwmon: (lm90) Prevent integer underflows of
 temperature calculations
Message-ID: <20210622231525.GA1299338@roeck-us.net>
References: <20210621213153.28247-1-digetx@gmail.com>
 <20210621213153.28247-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621213153.28247-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 12:31:52AM +0300, Dmitry Osipenko wrote:
> The min/max/crit and all other temperature values that are passed to
> the driver are unlimited and value that is close to INT_MIN results in
> integer underflow of the temperature calculations made by the driver
> for LM99 sensor. Temperature hysteresis is among those values that need
> to be limited, but limiting of hysteresis is independent from the sensor
> version. Add the missing limits.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/hwmon/lm90.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index b53f17511b05..ee6b8190f08e 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -1028,6 +1028,9 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
>  	struct reg *regp = &reg[index];
>  	int err;
>  
> +	/* prevent integer underflow */
> +	val = max(val, -128000l);
> +

This and the adjustment below can be moved into the if() statement for lm99.
There is no need to affect other chips.

>  	/* +16 degrees offset for temp2 for the LM99 */
>  	if (data->kind == lm99 && index <= 2)
>  		val -= 16000;
> @@ -1088,6 +1091,9 @@ static int lm90_set_temp8(struct lm90_data *data, int index, long val)
>  	struct i2c_client *client = data->client;
>  	int err;
>  
> +	/* prevent integer underflow */
> +	val = max(val, -128000l);
> +
>  	/* +16 degrees offset for temp2 for the LM99 */
>  	if (data->kind == lm99 && index == 3)
>  		val -= 16000;
> @@ -1130,6 +1136,9 @@ static int lm90_set_temphyst(struct lm90_data *data, long val)
>  	int temp;
>  	int err;
>  
> +	/* prevent integer underflow */
> +	val = max(val, -128000l);
> +
Please move this further below, just before val is used, to better
show the context why it is needed.

Thanks,
Guenter

>  	if (data->kind == adt7461 || data->kind == tmp451)
>  		temp = temp_from_u8_adt7461(data, data->temp8[LOCAL_CRIT]);
>  	else if (data->kind == max6646)
> -- 
> 2.30.2
> 
