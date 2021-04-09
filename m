Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385A4359775
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhDIIQV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 04:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhDIIQU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 04:16:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A31C061760
        for <linux-pm@vger.kernel.org>; Fri,  9 Apr 2021 01:16:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 12so2440162wmf.5
        for <linux-pm@vger.kernel.org>; Fri, 09 Apr 2021 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LRj04aylh/M/utY6Vb5m6Brz3i8rRk89mp42xbGh50c=;
        b=Y1Ye8Pu1vzTfpaMER5fLdOOHuYOydweGzPny7okrNuORSfaLyQm1nP3qMuwfQi1MUU
         iE0KlyYkAWj3ExylYBFMoly7Ns7Dpf7fcKW/LATImCn7chh4AP8/WIT4SjWZ+1qUWwTt
         4CGsRmxprOJthB1JXY1MLsZr9KUJcoMaBny3rTWp+XU9Jbe7mtdcChkz9WbR/Keru0yr
         iIyzpUX54xlUqP8eET7sHoKYCIfhii8dLC1++yUIugvalYMSoEoCggbYZbj4uhSNXPFI
         lbKw2l8vSIjsPz22udPFlOq/QyXAfevUiW8enCN7H+sbo4bSWuv3CU44pdRRUIqzGJCG
         DMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LRj04aylh/M/utY6Vb5m6Brz3i8rRk89mp42xbGh50c=;
        b=Xeq6HhDTbCp8d47dpLH4wGuvglWU03PoNlysA++YdatHsLNK0Qtnl3YSmsZ8U1YEcq
         zuoPFlVnInx71XXA0D9A3xewYWfa5WL7wADKrDdq8NfNJE1QD1RxBYNCX8LWzxqgpgQL
         sDQtmF1bt5N9Z9xhiEIPbhlOYyGB6+MluXS00FKftLAg0Uc63Ve7YOMM/ohcajKxcYYZ
         wrpdTrwsTZKieaFTBT3rmN6uCgUaZZvbfJtZgxvi1wrlOHppUxKU7t4C6ulR5SeN6Yci
         NK6hMcV1hz4cd4SdLlKk4+5DembrGQGhwY0Zgt8/9p1jDYSr31XSZZ2dhw4cd8EYKjM2
         QzGw==
X-Gm-Message-State: AOAM530onVLHbrrwJoTAAckAsAVyDn11NyMlTZiGzmtujf8Vr7sBU4O7
        GZqUvG91NGohh0GPf7abFvdX8Q==
X-Google-Smtp-Source: ABdhPJxC8OUe5wkOGAsqADIeWX+ybHtiZ41Qw6+hkby8yn3SMoV79nHh+S2e94pcqlrgUd/tFtGliQ==
X-Received: by 2002:a05:600c:3541:: with SMTP id i1mr12594653wmq.97.1617956166600;
        Fri, 09 Apr 2021 01:16:06 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5d29:55c:ba8e:9bff? ([2a01:e34:ed2f:f020:5d29:55c:ba8e:9bff])
        by smtp.googlemail.com with ESMTPSA id z1sm3313831wrt.8.2021.04.09.01.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 01:16:06 -0700 (PDT)
Subject: Re: [v7,3/3] thermal: mediatek: add another get_temp ops for thermal
 sensors
To:     Michael Kao <michael.kao@mediatek.com>, fan.chen@mediatek.com,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210316070144.28440-1-michael.kao@mediatek.com>
 <20210316070144.28440-4-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dac1f9bc-6caa-9cb7-97d6-882a8bd20fea@linaro.org>
Date:   Fri, 9 Apr 2021 10:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316070144.28440-4-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/03/2021 08:01, Michael Kao wrote:
> Provide thermal zone to read thermal sensor
> in the SoC. We can read all the thermal sensors
> value in the SoC by the node /sys/class/thermal/
> 
> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
> on the first read of sensor that often are bogus values.
> This can avoid following warning on boot:
> 
>   thermal thermal_zone6: failed to read out thermal zone (-13)

This patch is changing more things than described in the changelog.

Is it possible to share some technical details about how the sensor(s)
are working or point to some documentation if any ? and possibly the
layout ?

IIUC there is a fake thermal zone zero with the purpose of aggregating
all the other sensors by taking the max temperature of all the sensors.

This patch adds a thermal zone per sensor, and each sensor is per CPU.
CPU0 being actually the max of all the other sensors, right ?


> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/thermal/mtk_thermal.c | 100 +++++++++++++++++++++++++---------
>  1 file changed, 75 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 149c6d7fd5a0..57e4f08a947e 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -245,6 +245,11 @@ enum mtk_thermal_version {
>  
>  struct mtk_thermal;
>  
> +struct mtk_thermal_zone {
> +	struct mtk_thermal *mt;
> +	int id;
> +};
> +
>  struct thermal_bank_cfg {
>  	unsigned int num_sensors;
>  	const int *sensors;
> @@ -637,6 +642,30 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>  		mutex_unlock(&mt->lock);
>  }
>  
> +static u32 _get_sensor_temp(struct mtk_thermal *mt, int id)
> +{
> +	u32 raw;
> +	int temp;
> +
> +	raw = readl(mt->thermal_base + mt->conf->msr[id]);
> +
> +	if (mt->conf->version == MTK_THERMAL_V1)
> +		temp = raw_to_mcelsius_v1(mt, id, raw);
> +	else
> +		temp = raw_to_mcelsius_v2(mt, id, raw);
> +
> +	/*
> +	 * The first read of a sensor often contains very high bogus
> +	 * temperature value. Filter these out so that the system does
> +	 * not immediately shut down.
> +	 */
> +
> +	if (temp > 200000)
> +		return -EAGAIN;
> +	else
> +		return temp;
> +}
> +
>  /**
>   * mtk_thermal_bank_temperature - get the temperature of a bank
>   * @bank:	The bank
> @@ -647,28 +676,11 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>  static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>  {
>  	struct mtk_thermal *mt = bank->mt;
> -	const struct mtk_thermal_data *conf = mt->conf;
>  	int i, temp = INT_MIN, max = INT_MIN;
> -	u32 raw;
> -
> -	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> -		raw = readl(mt->thermal_base + conf->msr[i]);
>  
> -		if (mt->conf->version == MTK_THERMAL_V1) {
> -			temp = raw_to_mcelsius_v1(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		} else {
> -			temp = raw_to_mcelsius_v2(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		}
> +	for (i = 0; i < mt->conf->bank_data[bank->id].num_sensors; i++) {
>  
> -		/*
> -		 * The first read of a sensor often contains very high bogus
> -		 * temperature value. Filter these out so that the system does
> -		 * not immediately shut down.
> -		 */
> -		if (temp > 200000)
> -			temp = 0;
> +		temp = _get_sensor_temp(mt, i);
>  
>  		if (temp > max)
>  			max = temp;
> @@ -679,7 +691,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>  
>  static int mtk_read_temp(void *data, int *temperature)
>  {
> -	struct mtk_thermal *mt = data;
> +	struct mtk_thermal_zone *tz = data;
> +	struct mtk_thermal *mt = tz->mt;
>  	int i;
>  	int tempmax = INT_MIN;
>  
> @@ -698,10 +711,28 @@ static int mtk_read_temp(void *data, int *temperature)
>  	return 0;
>  }
>  
> +static int mtk_read_sensor_temp(void *data, int *temperature)
> +{
> +	struct mtk_thermal_zone *tz = data;
> +	struct mtk_thermal *mt = tz->mt;
> +	int id = tz->id - 1;
> +
> +	if (id < 0)
> +		return -EACCES;
> +
> +	*temperature = _get_sensor_temp(mt, id);
> +
> +	return 0;
> +}
> +
>  static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
>  	.get_temp = mtk_read_temp,
>  };
>  
> +static const struct thermal_zone_of_device_ops mtk_thermal_sensor_ops = {
> +	.get_temp = mtk_read_sensor_temp,
> +};
> +
>  static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>  				  u32 apmixed_phys_base, u32 auxadc_phys_base,
>  				  int ctrl_id)
> @@ -992,6 +1023,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  	u64 auxadc_phys_base, apmixed_phys_base;
>  	struct thermal_zone_device *tzdev;
>  	void __iomem *apmixed_base, *auxadc_base;
> +	struct mtk_thermal_zone *tz;
>  
>  	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>  	if (!mt)
> @@ -1080,11 +1112,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mt);
>  
> -	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
> -						     &mtk_thermal_ops);
> -	if (IS_ERR(tzdev)) {
> -		ret = PTR_ERR(tzdev);
> -		goto err_disable_clk_peri_therm;
> +	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> +		if (!tz)
> +			return -ENOMEM;
> +
> +		tz->mt = mt;
> +		tz->id = i;
> +
> +		tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i, tz, (i == 0) ?
> +							     &mtk_thermal_ops :
> +							     &mtk_thermal_sensor_ops);
> +
> +		if (IS_ERR(tzdev)) {
> +			if (PTR_ERR(tzdev) == -ENODEV) {
> +				dev_warn(&pdev->dev,
> +					 "sensor %d not registered in thermal zone in dt\n", i);
> +				continue;
> +			}
> +			if (PTR_ERR(tzdev) == -EACCES) {
> +				ret = PTR_ERR(tzdev);
> +				goto err_disable_clk_peri_therm;
> +			}
> +		}
>  	}
>  
>  	return 0;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
