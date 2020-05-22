Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1431DEBE2
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgEVPcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbgEVPcJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 11:32:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02FEC05BD43
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 08:32:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g14so4634450wme.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=otTjOhB3pQfb5rvNf3iE/1EF+uvqWUVNS9VHLDzOq6I=;
        b=YjORt36Ol5Z1zqcZJ9PdVDQlWbU2xMv+HuUp2H6cXcxLt9hXl7O4guMpdaJSCxMlk/
         F0ZgAw2FvlH34VcN4fni2/NgLuZkYmwMItA0MjVGnZ5p9uL6jvhBff0Q4CTl85Yw1pw3
         rvDo4oOuVmI951FS3NPpy9tLJaA5xxllVZY0spCqdqsRGD2+abdJquNCoJXQpWfgPgGu
         ZCn9yjxdzIlUYRfFPLW4aL2snRBCG82tP7948zBCVceR9ovXv0brb7+4rimzBnUS+lwv
         j8ylwDgWE60TyNowyMK8CQRJ2u9gxTZKcsVP1PX2qZIf9VY10WFDjw1Xh8dRTP1Yiq0I
         zC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=otTjOhB3pQfb5rvNf3iE/1EF+uvqWUVNS9VHLDzOq6I=;
        b=cAnRXKEvmFKjrYFoxl8oAZGcaDtZIAZ5Br8wU8ON061evxjGr5tOHIoT3hDZiFnTSq
         WjKnKrbr8ICnzONgBFIq+w/v3G9QP7OEL4sA29qmFt9CAkEkhPOVaZyE1eZKKiVz3l45
         tb6ZZFTsJqWq8gMOADTjJr+YmZZSWrxfhUTnO5t6CW6HdxpKV+Tk6Ag8U5jZRXXCy4jq
         5wkjcdjDDZlWexYXmuFcTdI8EL2VCOAqQnMoTbSQ5Caa9/ENxRiodtNyS4NQrBhYdgGE
         SXh53WaDFCM19y+LeBFuS6jSd1qR6LdFQDxrVGCuLESikm/BP7tc8r8YySMZqpx3BEdu
         bDaQ==
X-Gm-Message-State: AOAM53048XX3+fZZXZXJ7zfAG0D6cEF6MD+ibcsMbr+itQFkmTLGgjt0
        TsMrOpKbldpKUx1QA6wd8u45xA==
X-Google-Smtp-Source: ABdhPJxZhfb8FvGiHXbP4WIrzNxdJ9R0OJbYjAm99WLd9VjIJX2ehUsAjztVxh8MlTgphwpbBpEHEA==
X-Received: by 2002:a1c:1983:: with SMTP id 125mr13524236wmz.43.1590161526337;
        Fri, 22 May 2020 08:32:06 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id x17sm9694035wrp.71.2020.05.22.08.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 08:32:05 -0700 (PDT)
Subject: Re: [v4,6/7] thermal: mediatek: add another get_temp ops for thermal
 sensors
To:     Michael Kao <michael.kao@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200323121537.22697-1-michael.kao@mediatek.com>
 <20200323121537.22697-7-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fa43c55b-96c2-30c8-eb7e-983177dad13d@linaro.org>
Date:   Fri, 22 May 2020 17:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200323121537.22697-7-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/03/2020 13:15, Michael Kao wrote:
> Provide thermal zone to read thermal sensor
> in the SoC. We can read all the thermal sensors
> value in the SoC by the node /sys/class/thermal/
> 
> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
> on the first read of sensor that often are bogus values.
> This can avoid following warning on boot:
> 
>   thermal thermal_zone6: failed to read out thermal zone (-13)

What the source problem of the sensor returning bogus values?



> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/thermal/mtk_thermal.c | 74 +++++++++++++++++++++++++++++++----
>  1 file changed, 67 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 6b7ef1993d7e..9eaca432920e 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -225,6 +225,11 @@ enum {
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
> @@ -607,7 +612,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>  		 * not immediately shut down.
>  		 */
>  		if (temp > 200000)
> -			temp = 0;
> +			temp = -EAGAIN;
>  
>  		if (temp > max)
>  			max = temp;
> @@ -618,7 +623,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>  
>  static int mtk_read_temp(void *data, int *temperature)
>  {
> -	struct mtk_thermal *mt = data;
> +	struct mtk_thermal_zone *tz = data;
> +	struct mtk_thermal *mt = tz->mt;
>  	int i;
>  	int tempmax = INT_MIN;
>  
> @@ -637,10 +643,44 @@ static int mtk_read_temp(void *data, int *temperature)
>  	return 0;
>  }
>  
> +static int mtk_read_sensor_temp(void *data, int *temperature)
> +{
> +	struct mtk_thermal_zone *tz = data;
> +	struct mtk_thermal *mt = tz->mt;
> +	const struct mtk_thermal_data *conf = mt->conf;
> +	int id = tz->id - 1;
> +	int temp = INT_MIN;
> +	u32 raw;
> +
> +	if (id < 0)
> +		return  -EACCES;
> +
> +	raw = readl(mt->thermal_base + conf->msr[id]);
> +
> +	temp = raw_to_mcelsius(mt, id, raw);
> +
> +	/*
> +	 * The first read of a sensor often contains very high bogus
> +	 * temperature value. Filter these out so that the system does
> +	 * not immediately shut down.
> +	 */
> +
> +	if (temp > 200000)
> +		return  -EAGAIN;
> +
> +	*temperature = temp;
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
> @@ -873,6 +913,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	u64 auxadc_phys_base, apmixed_phys_base;
>  	struct thermal_zone_device *tzdev;
> +	struct mtk_thermal_zone *tz;
>  
>  	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>  	if (!mt)
> @@ -954,11 +995,30 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mt);
>  
> -	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
> -						     &mtk_thermal_ops);
> -	if (IS_ERR(tzdev)) {
> -		ret = PTR_ERR(tzdev);
> -		goto err_disable_clk_peri_therm;
> +	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +		tz = kmalloc(sizeof(*tz), GFP_KERNEL);
> +		if (!tz)
> +			return -ENOMEM;
> +
> +		tz->mt = mt;
> +		tz->id = i;
> +
> +		tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i,
> +							     tz, (i == 0) ?
> +				&mtk_thermal_ops : &mtk_thermal_sensor_ops);
> +
> +		if (IS_ERR(tzdev)) {
> +			if (PTR_ERR(tzdev) == -ENODEV) {
> +				dev_warn(&pdev->dev,
> +					 "sensor %d not registered in thermal zone in dt\n",
> +					 i);
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
