Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5ED16790F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 10:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBUJLT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 04:11:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32829 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgBUJLS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 04:11:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id m10so4696118wmc.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 01:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=azk1Q7pvujWav83kMuWej4FskuG4+RLdHCFFEc4Heqw=;
        b=z2T3cugDBfcE9X09MGRjd1QXuGNe3k89XEsa3u0eDeWOjb3aCWK7Ft/FfZK/LaBp5S
         mzIVECOghk4NpHUsInWmKqapwZC/g4y0SeeaJRHeXOhBNDJbuLJz+Nyc7jvkzsLPKiii
         FuFaEvWrnG8eDMWl3EKLJrSY2eoIeqEaDiZzR5HMvECjyYnN1bjVGuTMPjIJWvypDWH6
         8M+ghap0Yu9P8fqWKEC2v3RavqEHHLRV4CxBb3p8tpN7PblBBfBHF/qC89Xr1rU3UZjk
         7cXlSzm2/U6bWYXYtYr/47MqGjJlaD9W/zyzzhgE5xO3NSUNm1WRL8SwIFIH8V6tAsZ1
         O1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=azk1Q7pvujWav83kMuWej4FskuG4+RLdHCFFEc4Heqw=;
        b=Q6grUG38p2QN7l24YD+qJPZ4uHuxelCLo5VOZK8EsPtdi7NgWos3RmBNdfdSYIpU/j
         shWMIdI0DWRZPOhwuFOdJ4bWWFk0LfrP4DrFsquyr3FNhykhyt+cUhQ21SYMun3a8wsS
         Z3KRF8eXtqHN86I74At4eAQwGKP7aLKILH2de3DxOekhteeaQfcCAl941Qu9zPqyeCVR
         F4LYWPEro7GLdNp+JqHtXTOABQjPfn3Z+FHOvPPK3C/9fko6ysmS76Cql42LAabxg2vj
         U8VCLHlnwBfuECfHzX3yHtFsxhGh0WkyaXM5BkluPYwvALSrw9CgSyLeah4e2DMRrCAs
         TERQ==
X-Gm-Message-State: APjAAAUV41TubPUm/K9yO6OcgJ7eep6HdqKo8qU1eZvhJFsNOzKmsBKd
        J2AZ3yCvn+Amak2TBN7Zxkw0Yg==
X-Google-Smtp-Source: APXvYqyS0hUOw4p2ui00nsj3c5MOAkh4BV79wy3Sn7j7GPpD+1H3vzOFdO/cs7FwCSTWi1sGit46/w==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr2534616wmi.71.1582276276286;
        Fri, 21 Feb 2020 01:11:16 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:2dfb:b5ce:9043:4adb])
        by smtp.gmail.com with ESMTPSA id u23sm3032858wmu.14.2020.02.21.01.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 01:11:15 -0800 (PST)
Date:   Fri, 21 Feb 2020 10:11:12 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, aisheng.dong@nxp.com,
        linux@roeck-us.net, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, fugang.duan@nxp.com, peng.fan@nxp.com,
        daniel.baluta@nxp.com, bjorn.andersson@linaro.org, olof@lixom.net,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V15 RESEND 2/5] thermal: of-thermal: add API for getting
 sensor ID from DT
Message-ID: <20200221091112.GA10516@linaro.org>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582161028-2844-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, Feb 20, 2020 at 09:10:25AM +0800, Anson Huang wrote:
> This patch adds new API thermal_zone_of_get_sensor_id() to
> provide the feature of getting sensor ID from DT thermal
> zone's node. It's useful for thermal driver to register the
> specific thermal zone devices from DT in a common way.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> Changes since V14:
> 	- improve the commit message and comment, no code change.
> ---
>  drivers/thermal/of-thermal.c | 65 +++++++++++++++++++++++++++++++++-----------
>  include/linux/thermal.h      | 10 +++++++
>  2 files changed, 59 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index ef0baa9..0f57108 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -449,6 +449,53 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>  }
>  
>  /**
> + * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
> + * @tz_np: a valid thermal zone device node.
> + * @sensor_np: a sensor node of a valid sensor device.
> + * @id: the sensor ID returned if success.
> + *
> + * This function will get sensor ID from a given thermal zone node and
> + * the sensor node must match the temperature provider @sensor_np.
> + *
> + * Return: 0 on success, proper error code otherwise.
> + */
> +
> +int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
> +				  struct device_node *sensor_np,
> +				  u32 *id)
> +{
> +	struct of_phandle_args sensor_specs;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_args(tz_np,
> +					 "thermal-sensors",
> +					 "#thermal-sensor-cells",
> +					 0,
> +					 &sensor_specs);
> +	if (ret)
> +		return ret;
> +
> +	if (sensor_specs.np != sensor_np) {
> +		of_node_put(sensor_specs.np);
> +		return -ENODEV;
> +	}
> +
> +	if (sensor_specs.args_count >= 1) {

For the sake of clarity, move the sanity tests before:

	if (sensor_specs.args_count > 1)
		pr_warn("...");

	*id = sensor_specs.args_count ? sensor_specs.args[0] : 0;

> +		*id = sensor_specs.args[0];
> +		WARN(sensor_specs.args_count > 1,
> +		     "%pOFn: too many cells in sensor specifier %d\n",
> +		     sensor_specs.np, sensor_specs.args_count);
> +	} else {
> +		*id = 0;
> +	}
> +
> +	of_node_put(sensor_specs.np);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_of_get_sensor_id);
> +
> +/**
>   * thermal_zone_of_sensor_register - registers a sensor to a DT thermal zone
>   * @dev: a valid struct device pointer of a sensor device. Must contain
>   *       a valid .of_node, for the sensor node.
> @@ -499,36 +546,22 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
>  	sensor_np = of_node_get(dev->of_node);
>  
>  	for_each_available_child_of_node(np, child) {
> -		struct of_phandle_args sensor_specs;
>  		int ret, id;
>  
>  		/* For now, thermal framework supports only 1 sensor per zone */
> -		ret = of_parse_phandle_with_args(child, "thermal-sensors",
> -						 "#thermal-sensor-cells",
> -						 0, &sensor_specs);
> +		ret = thermal_zone_of_get_sensor_id(child, sensor_np, &id);
>  		if (ret)
>  			continue;
>  
> -		if (sensor_specs.args_count >= 1) {
> -			id = sensor_specs.args[0];
> -			WARN(sensor_specs.args_count > 1,
> -			     "%pOFn: too many cells in sensor specifier %d\n",
> -			     sensor_specs.np, sensor_specs.args_count);
> -		} else {
> -			id = 0;
> -		}

Please take also the opportunity to factor out the function
thermal_zone_of_sensor_register().

> -		if (sensor_specs.np == sensor_np && id == sensor_id) {
> +		if (id == sensor_id) {
>  			tzd = thermal_zone_of_add_sensor(child, sensor_np,
>  							 data, ops);
>  			if (!IS_ERR(tzd))
>  				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
>  
> -			of_node_put(sensor_specs.np);
>  			of_node_put(child);
>  			goto exit;
>  		}
> -		of_node_put(sensor_specs.np);
>  	}
>  exit:
>  	of_node_put(sensor_np);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 126913c6..53e6f67 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -364,6 +364,9 @@ struct thermal_trip {
>  
>  /* Function declarations */
>  #ifdef CONFIG_THERMAL_OF
> +int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
> +				  struct device_node *sensor_np,
> +				  u32 *id);
>  struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
>  				const struct thermal_zone_of_device_ops *ops);
> @@ -375,6 +378,13 @@ struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
>  void devm_thermal_zone_of_sensor_unregister(struct device *dev,
>  					    struct thermal_zone_device *tz);
>  #else
> +
> +static int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
> +					 struct device_node *sensor_np,
> +					 u32 *id)
> +{
> +	return -ENOENT;
> +}
>  static inline struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
>  				const struct thermal_zone_of_device_ops *ops)
> -- 
> 2.7.4
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
