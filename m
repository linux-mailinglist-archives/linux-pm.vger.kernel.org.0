Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5CA3AF6DB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 22:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUUdD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 16:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUUdC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 16:33:02 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38633C061574;
        Mon, 21 Jun 2021 13:30:47 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso19029063otu.10;
        Mon, 21 Jun 2021 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mQv3Z7D0iMF3aOJrwwNHkFbnP6xGshyBJZOccBybwCI=;
        b=eOboM+Q6MjsdtqO/ld6VirBXOlQSSHx5jF2cxLvj+n/zJlgEoxSSOyCumPuHukyTHh
         maN3yjss+MpgTFynXinqj/Tr7DWghQdfwdtAIyxC7i1APrMeNjtmgvgMwrKV4ySpeoDy
         K8urpj6gMC5qU9SucCN7Km12Xjd+rLcsY40poxaADwyZAJrOTsrQiZn7MrICTBIPVpto
         zVR/Ez+0SORmbC2Dq35P/fNvYF8cs8s7/KmJeyo5+H2Snl67e1O/p/hRXmKtTtjQp7Fp
         7Y0WWdvdLoKaJbDsZXBoxabdPWEqlWQBguHDxRSDrcZtHlrUVuYYPwTUt6n6JBuWqW9/
         h6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mQv3Z7D0iMF3aOJrwwNHkFbnP6xGshyBJZOccBybwCI=;
        b=ZVzrkPGdeeBF+ro2S7Y9InuKbxVQkAIm4f5wqPlkoYjjt30f/qOqyL2GhnuVsAOTlf
         ZHd46qxVZwDq0BKw6aWwO8QvlpmDvw88GewjNKxwfji6qg+N7qb+Q3aOshMdDgbIzIWU
         1ezZc/712fkfGX5c0n+1xvngfa7z85NmBtjZj4AiHiFefPhN6QhqIFvh6OtCHaEXKZ0R
         P4ZRH1gUIbq8jhyuYHY0ka4s7LFVC9zo3ANSSbh88buPRbmC3r/8o9jJ+oeaD2Sp3dFj
         aTCG7KSnMAXBY+F1DkWJV6FJGDfcW44VY3nUhfJOsvTdOv1arGZDzQTSFPBBJPtMtnql
         8w2g==
X-Gm-Message-State: AOAM532HSEJZzcT7FleuacKcOlA8BtkaExgUmCdri5CnG654CNbtaobY
        zMjnVo0L3Qo+PRSIWMTS2KY=
X-Google-Smtp-Source: ABdhPJy2ZZPf4fuo+WrxWBLKMlQkXf75CFR+UbxKiLrGQ0k0zym8y4pH9vrUQwyXVyCGb8RvHtCQMg==
X-Received: by 2002:a9d:6f93:: with SMTP id h19mr252183otq.292.1624307446495;
        Mon, 21 Jun 2021 13:30:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w200sm3814390oie.10.2021.06.21.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:30:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 21 Jun 2021 13:30:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: Support set_trips() of thermal device ops
Message-ID: <20210621203044.GA631670@roeck-us.net>
References: <20210621184058.4110-1-digetx@gmail.com>
 <20210621184058.4110-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621184058.4110-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 21, 2021 at 09:40:58PM +0300, Dmitry Osipenko wrote:
> Support set_trips() callback of thermal device ops. This allows HWMON
> device to operatively notify thermal core about temperature changes, which
> is very handy to have in a case where HWMON sensor is used by CPU thermal
> zone that performs passive cooling and emergency shutdown on overheat.
> Thermal core will be able to react faster to temperature changes.
> 

I think that warrants an explanation why it doesn't matter if the
code doesn't really set any trip points.

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/hwmon/hwmon.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index fd47ab4e6892..e74dc81e650d 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -153,8 +153,40 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
>  	return 0;
>  }
>  
> +static int hwmon_thermal_set_trips(void *data, int low, int high)
> +{
> +	struct hwmon_thermal_data *tdata = data;
> +	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
> +	const struct hwmon_chip_info *chip = hwdev->chip;
> +	const struct hwmon_channel_info **info = chip->info;
> +	unsigned int i;
> +
> +	if (!chip->ops->write)
> +		return 0;
> +
> +	for (i = 1; info[i] && info[i]->type != hwmon_temp; i++)
> +		continue;

Why start with index 1 ? While index 0 is commonly used for chip data,
that is not mandatory.

> +
> +	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MIN) {
> +		int err = chip->ops->write(tdata->dev, hwmon_temp,
> +					   hwmon_temp_min, tdata->index, low);

checkpatch will complain here because it expects an empty line after a
declaration. Since err is used in multiple conditionals, I would suggest
to declare it once in the function header.

> +		if (err < 0 && err != -EOPNOTSUPP)

"< 0" is unnecessary.

> +			return err;
> +	}
> +
> +	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MAX) {
> +		int err = chip->ops->write(tdata->dev, hwmon_temp,
> +					   hwmon_temp_max, tdata->index, high);
> +		if (err < 0 && err != -EOPNOTSUPP)

"< 0" is unnecessary.

> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct thermal_zone_of_device_ops hwmon_thermal_ops = {
>  	.get_temp = hwmon_thermal_get_temp,
> +	.set_trips = hwmon_thermal_set_trips,
>  };
>  
>  static void hwmon_thermal_remove_sensor(void *data)
