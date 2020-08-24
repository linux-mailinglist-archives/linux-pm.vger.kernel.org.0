Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE46250893
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 20:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHXSzY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgHXSzY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 14:55:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD8C061573;
        Mon, 24 Aug 2020 11:55:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w14so10904441ljj.4;
        Mon, 24 Aug 2020 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qq+FwKaAL0+i+v9B+INTc0h8RAmxp7NQuyM7xAAxgP4=;
        b=rxx2CzweB1rd+Z9fgBd8jNjjrS7CPMKwQcKUql4L6YBEzJSjR/wbXY1yE8trzq40wz
         dWEeONiwi/DR9ws1D+fE102ak1bsSI3DJ4XIPblj4+rQWEVc4eJbOq01CzkjC4W9Vy3K
         QokcS3iGm1gkC+xSzusq/wSGqKsymeBWx/5r03ZfDF0chjAvO0caMJRTzwQMthtcvEAE
         aPYD6NlDs5237Nl2f4h7c9Q72PTTtjD0tJrn76aIzkMzsWDrw2yXZN2nOCuPpPgiIfyY
         FkXt9Y/qBunn3Uxk+6d3rs8yIXVFAOizoKCpgcFpCfz6XH+QnBSyM1AN9BGQWGOo6NZz
         3Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qq+FwKaAL0+i+v9B+INTc0h8RAmxp7NQuyM7xAAxgP4=;
        b=p4iwJbd9uZPU+zCK/qSWdeEjgMF5OS1wuPrhrTbHVgNkhfS6rcXH69ehL/aF7dr+qS
         S5Iu+nuQUYJFdvwMDt96eRO/CIefRHELTxi4nAjxG3G1gk/0sjNu39Jk4P/IOjRLpges
         7cPI6cpRxnpiTmt8cUVQDjPNyXP1qgn2WLQ3dv7PvOmlVdiAx5uV3SfUdae0ifcTEtlO
         6aeVaz4KobEyt8dXsyRFB0t+5/uN5obnHMFZdIFfyUmRWl9vX107N2i1QdXieOCZLKsb
         3l/LI7EzPMAfXvGh0I5XNxhVKgAuc8HGxzuS6lCVECo/kj4w1KBnO+MVACTFLsmhGbKc
         DDNg==
X-Gm-Message-State: AOAM531aZOGDPkA9aeWLYTpTRI6ySiGiUnLPWIHu5OI6zXwEd1bW5VER
        WbgjCdFTdekpl2mEXYTPmACSov2hqe4=
X-Google-Smtp-Source: ABdhPJzWwTyU3v6bW25kjpxAXFiQU4GbZLc10ZygwhVenWjgzbqGxjhdCEEbHk9fUUyGsaH7gHH01A==
X-Received: by 2002:a2e:96d9:: with SMTP id d25mr3476883ljj.408.1598295317815;
        Mon, 24 Aug 2020 11:55:17 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id r1sm2442954lfc.44.2020.08.24.11.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:55:17 -0700 (PDT)
Subject: Re: [PATCH v1 2/6] power: supply: Add battery gauge driver for Acer
 Iconia Tab A500
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-3-digetx@gmail.com>
 <20200824140718.apoavlny6hlkm2ql@earth.universe>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <31ec6865-4a33-bde8-73a6-20c188ec2ee7@gmail.com>
Date:   Mon, 24 Aug 2020 21:55:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824140718.apoavlny6hlkm2ql@earth.universe>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.08.2020 17:07, Sebastian Reichel пишет:
> Hi,
...
>> +static int a500_battery_get_serial_number(struct a500_battery *bat,
>> +					  union power_supply_propval *val)
>> +{
>> +	unsigned int i;
>> +	s32 ret = 0;
>> +
>> +	if (bat->serial[0])
>> +		goto done;
>> +
>> +	a500_ec_lock(bat->ec_chip);
>> +	for (i = 0; i < BATTERY_SERIAL_LEN / 2; i++) {
>> +		ret = a500_ec_read_locked(bat->ec_chip,
>> +					  &ec_data[REG_SERIAL_NUMBER].cmd);
>> +		if (ret < 0) {
>> +			bat->serial[0] = '\0';
>> +			break;
>> +		}
>> +
>> +		bat->serial[i * 2 + 0] = (ret >> 0) & 0xff;
>> +		bat->serial[i * 2 + 1] = (ret >> 8) & 0xff;
>> +	}
>> +	a500_ec_unlock(bat->ec_chip);
>> +done:
>> +	val->strval = bat->serial;
>> +
>> +	return ret;
>> +}
> 
> If battery is swapped, this will keep the old serial.

Hello, Sebastian! The battery isn't hot-swappable on A500, but it also
should be okay to always re-read the serialno. I'll consider removing
the caching in the v2, thanks.

...
>> +	bat->psy = devm_power_supply_register_no_ws(&pdev->dev,
>> +						    &a500_battery_desc,
>> +						    &psy_cfg);
>> +	err = PTR_ERR_OR_ZERO(bat->psy);
>> +	if (err) {
>> +		if (err == -EPROBE_DEFER)
>> +			dev_dbg(&pdev->dev, "failed to register battery, deferring probe\n");
>> +		else
>> +			dev_err(&pdev->dev, "failed to register battery: %d\n",
>> +				err);
>> +		return err;
>> +	}
> 
> if (IS_ERR(bat->psy))
>     return dev_err_probe(&pdev->dev, PTR_ERR(err), "failed to register battery\n");

I didn't know that dev_err_probe() is available now, very nice! I'll use
it in the v2, thanks.

...
>> +MODULE_DESCRIPTION("Battery gauge driver for Acer Iconia Tab A500");
>> +MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
>> +MODULE_ALIAS("platform:acer-a500-iconia-battery");
>> +MODULE_LICENSE("GPL v2");
> 
> MODULE_LICENSE("GPL");
> 
> Otherwise looks good to me.

Okay, thank you!
