Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07942D412
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 05:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfE2DCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 23:02:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36186 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2DCc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 23:02:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so431518pgb.3;
        Tue, 28 May 2019 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X6hCgGrg1/EebBkiZczSeiIYTj567ezCT4B+Qvt2s6Q=;
        b=E7MD6iUCYh7UBE8D8v6Tj9XnZ+OUEjLsn2t7PjrybNOo62FmkyX8L6GN+YvLcvreBf
         1K/b9tbQ1rSkY+RJnEpVfTgNzLxYFF6usqJTmHXT+jDAo0jfSt/XLCnXIx70y9IYfxti
         CqvXgmkijrm0NNrTeidIZWiufx4mLZZDvLr3TgD/+VqLGthmsv80JpGVXSNZ7u5UTaKU
         65tp8D8zynwlLPjy4TGsnQgZa3bOZJ8lZb77FNu+9s7Mgu55R77DLLy8AxMfyyM/P8pg
         vc4s/pueNLcGft20cBN2Z2nthMGvUjBkHoSnWgJS8zswD2cBuLQ8XbEUt+lAP0AoGHCB
         hTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X6hCgGrg1/EebBkiZczSeiIYTj567ezCT4B+Qvt2s6Q=;
        b=nVGi9+CKmwkmZQ/93Y6Us1zCGrHByvXt/c/M79el38S6ByByx5b2PI0l1X5FX8aDpe
         hveTupG+IAPwQWZdDru0novvCu3meY1NzzU09jaG7jXjAwabI2Ow901TXObdhdrSVKtO
         m3dRD9Y41jBOczZ4r289ZtIJ93NNATbcdH+Q5KvjqIog/AlA5dX1PfxS6H1sXIyFMPzp
         dkbpbAJA4k7tTkI8V0P1RC98E5NoGwGnxuFgLJ5GjBkhjfzb/k6Mxk1qG46/y7YQLqXi
         r8mwXP36hk0TY2CoiCvTf/nh9iL1QCHh3PqrTjtPBuMXuH1+77tBYM4vB/89JraWKORR
         LxBg==
X-Gm-Message-State: APjAAAVcmDjFNiQK4Li82WsbuzcIGvXRQiBEqoH6r7QONDLkw2aC17QZ
        tLYs2MibHYhOKI19g4Sf8Wr3x4Ee6v0=
X-Google-Smtp-Source: APXvYqyPsBpkG44hSDy7mXOJP8h3S5s7ICBOVNki4QTwaMsFGNf1xnTpWdMo6loLPLw8LZJQ9Rgn+A==
X-Received: by 2002:a17:90a:b885:: with SMTP id o5mr9397531pjr.52.1559098951071;
        Tue, 28 May 2019 20:02:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id d9sm13532565pgl.20.2019.05.28.20.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 20:02:30 -0700 (PDT)
Date:   Tue, 28 May 2019 20:02:27 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will.deacon@arm.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, aisheng.dong@nxp.com,
        ulf.hansson@linaro.org, peng.fan@nxp.com, daniel.baluta@nxp.com,
        maxime.ripard@bootlin.com, olof@lixom.net,
        jagan@amarulasolutions.com, horms+renesas@verge.net.au,
        leonard.crestez@nxp.com, bjorn.andersson@linaro.org,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH RESEND V13 2/5] thermal: of-thermal: add API for getting
 sensor ID from DT
Message-ID: <20190529030225.GA2662@localhost.localdomain>
References: <20190528060621.47342-1-Anson.Huang@nxp.com>
 <20190528060621.47342-2-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528060621.47342-2-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 28, 2019 at 02:06:18PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> On some platforms like i.MX8QXP, the thermal driver needs a
> real HW sensor ID from DT thermal zone, the HW sensor ID is
> used to get temperature from SCU firmware, and the virtual
> sensor ID starting from 0 to N is NOT used at all, this patch
> adds new API thermal_zone_of_get_sensor_id() to provide the
> feature of getting sensor ID from DT thermal zone's node.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V12:
> 	- adjust the second parameter of thermal_zone_of_get_sensor_id() API, then caller no need
> 	  to pass the of_phandle_args structure and put the sensor_specs.np manually, also putting
> 	  the sensor node device check inside this API to make it easy for usage;

What happened to using nxp,resource-id property in your driver?
Why do we need this as an API in of-thermal? What other drivers may
benefit of this?

Regardless, this patch needs to document the new API under
Documentation/

> ---
>  drivers/thermal/of-thermal.c | 66 +++++++++++++++++++++++++++++++++-----------
>  include/linux/thermal.h      | 10 +++++++
>  2 files changed, 60 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index dc5093b..a53792b 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -449,6 +449,54 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>  }
>  
>  /**
> + * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
> + * @tz_np: a valid thermal zone device node.
> + * @sensor_np: a sensor node of a valid sensor device.
> + * @id: a sensor ID pointer will be passed back.
> + *
> + * This function will get sensor ID from a given thermal zone node, use
> + * "thermal-sensors" as list name, and get sensor ID from first phandle's
> + * argument.
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
> @@ -499,36 +547,22 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
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
> -
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
> index 15a4ca5..5edffe6 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -375,6 +375,9 @@ struct thermal_trip {
>  
>  /* Function declarations */
>  #ifdef CONFIG_THERMAL_OF
> +int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
> +				  struct device_node *sensor_np,
> +				  u32 *id);
>  struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
>  				const struct thermal_zone_of_device_ops *ops);
> @@ -386,6 +389,13 @@ struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
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
