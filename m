Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614EE10F988
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 09:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLCIOf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 03:14:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38675 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfLCIOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 03:14:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id t3so1332183pgl.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 00:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EeQ6q+w00vvPgQlS6aRmOccyGWu66BElC10DaTgBqfg=;
        b=YdFc8WrWIbyz/CCaJ/uiHFcOZgvX/iBUI2b3KItUEmUAKByu/80JHFa6DnxHIneKpP
         WAujxKD/EUvXCu7xaj0e/rmHbj7Cq22pcI3UUAPQrJ4iwcXRykC0+yZcyyc2LP+0TJn/
         ATRnWHU2URo5oW9Zx8gBIuTgxRb+onD8XOcXUCNZh7USozMZkXqQV6PixsCWPlvFR/Wl
         bbk+Rbi6I5yFcXhRqDNEZ0iHWApFW1mZ7KGg36xN3lIVGtCLOAB2VMJ30IK3ocTS0Cux
         +OVCi7GZ4plntZgSTSfGdKxY1uKoAd1uSaj39iOS7szawVSHKfNjZCd29FsPH7lTHl9U
         xPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EeQ6q+w00vvPgQlS6aRmOccyGWu66BElC10DaTgBqfg=;
        b=asYRoz91YsuLSG3IdPzAkd276wQpZ4+YsNUuIQcfpOBrXKX/BcA65PbKLRbDvZ5em2
         gZ1jveAnOjfypmbgrfITyrV+BcVyrKXm35zyIx327+A+QjaXVC9g1dxutwedVtabR4I2
         Gtaj14E7a+s5bNraiqN3lBGclo1R8NcdYyymuwYow3uJOXB656h39BYCBbjf61P7x7Wq
         XWxKGhyDZtsZf8p3ljr6vOtOmU5vupzjLzfBD/qB9TFZrVruFb/M0gosp7LEKWrT8Hya
         NBgVBuC3j26MdnOObQ7G5Gj2UDUnQH/mVV1oNvaIHV5mysX7oU3raGlkcBlayUfuFoXq
         mqLQ==
X-Gm-Message-State: APjAAAUyH4xkIgW9xFrc/jhm5HWHEKsQ99Dd24O0la+XBQk76wYzemew
        fOpyPTVYksjJ1inU0I6Lt/PAiQ==
X-Google-Smtp-Source: APXvYqxlzgXgUvDzLmuqe3Oab24VyyMgq9LPRNa4/qb4zG4G8XKwroSNVubsb1EdT6LW8WUJ7tBayA==
X-Received: by 2002:a63:66c6:: with SMTP id a189mr3738218pgc.401.1575360874762;
        Tue, 03 Dec 2019 00:14:34 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id s18sm2339440pfm.27.2019.12.03.00.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 00:14:33 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:44:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, edubezval@gmail.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/4] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20191203081431.zddvzuaw2hx5e4u5@vireshk-i7>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
 <20191202202815.22731-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202202815.22731-3-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-12-19, 21:28, Daniel Lezcano wrote:
> +/**
> + * cpuidle_of_cooling_register - Idle cooling device initialization function
> + * @drv: a cpuidle driver structure pointer

@np missing here.

> + *
> + * This function is in charge of creating a cooling device per cpuidle
> + * driver and register it to thermal framework.
> + *
> + * Returns a valid pointer to a thermal cooling device, a PTR_ERR

s/, a/, or a/ ?

> + * corresponding to the error detected in the underlying subsystems.
> + */
> +struct thermal_cooling_device *
> +__init cpuidle_of_cooling_register(struct device_node *np,
> +				   struct cpuidle_driver *drv)
> +{
> +	struct idle_inject_device *ii_dev;
> +	struct cpuidle_cooling_device *idle_cdev;
> +	struct thermal_cooling_device *cdev;
> +	char dev_name[THERMAL_NAME_LENGTH];
> +	int id, ret;
> +
> +	idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
> +	if (!idle_cdev) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	id = ida_simple_get(&cpuidle_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		ret = id;
> +		goto out_kfree;
> +	}
> +
> +	ii_dev = idle_inject_register(drv->cpumask);
> +	if (IS_ERR(ii_dev)) {
> +		ret = PTR_ERR(ii_dev);
> +		goto out_id;
> +	}
> +
> +	idle_inject_set_duration(ii_dev, 0, TICK_USEC);
> +	
> +	idle_cdev->ii_dev = ii_dev;
> +
> +	snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", id);
> +
> +	cdev = thermal_of_cooling_device_register(np, dev_name, idle_cdev,
> +						  &cpuidle_cooling_ops);
> +	if (IS_ERR(cdev)) {
> +		ret = PTR_ERR(cdev);
> +		goto out_unregister;
> +	}
> +
> +	return cdev;
> +
> +out_unregister:
> +	idle_inject_unregister(ii_dev);
> +out_id:
> +	ida_simple_remove(&cpuidle_ida, id);
> +out_kfree:
> +	kfree(idle_cdev);
> +out:
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * cpuidle_cooling_register - Idle cooling device initialization function
> + * @drv: a cpuidle driver structure pointer
> + *
> + * This function is in charge of creating a cooling device per cpuidle
> + * driver and register it to thermal framework.
> + *
> + * Returns a valid pointer to a thermal cooling device, a PTR_ERR
> + * corresponding to the error detected in the underlying subsystems.
> + */
> +struct thermal_cooling_device *
> +__init cpuidle_cooling_register(struct cpuidle_driver *drv)
> +{
> +	return cpuidle_of_cooling_register(NULL, drv);
> +}
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index 3cdd85f987d7..da0970183d1f 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -60,4 +60,26 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  }
>  #endif /* CONFIG_CPU_FREQ_THERMAL */
>  
> +struct cpuidle_driver;
> +
> +#ifdef CONFIG_CPU_IDLE_THERMAL
> +extern struct thermal_cooling_device *
> +__init cpuidle_cooling_register(struct cpuidle_driver *drv);
> +extern struct thermal_cooling_device *
> +__init cpuidle_of_cooling_register(struct device_node *np,
> +				   struct cpuidle_driver *drv);

Maybe just drop the "extern" thing here as it is redundant really.

> +#else /* CONFIG_CPU_IDLE_THERMAL */
> +static inline struct thermal_cooling_device *
> +__init cpuidle_cooling_register(struct cpuidle_driver *drv)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +static inline struct thermal_cooling_device *
> +__init cpuidle_of_cooling_register(struct device_node *np,
> +				   struct cpuidle_driver *drv)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +#endif /* CONFIG_CPU_IDLE_THERMAL */
> +
>  #endif /* __CPU_COOLING_H__ */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
