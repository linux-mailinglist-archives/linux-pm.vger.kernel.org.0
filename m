Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B617B1E63
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjI1NaZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 09:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjI1NaY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 09:30:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5900196
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 06:30:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32488a22810so493112f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695907820; x=1696512620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3BAVqy+qfS/cVmNVQK4vLJ+dsKgcVNx9yqoPCnc3SY=;
        b=r/80SD0tQ2qb/EsOjdSRaLJN80zrY6ultNdQoosrGWHTnGO6cRTzIQaIgTQqkpEcuc
         J+r+cmlbL1SWbrNCuNYcwGPCWVPCjuTcmDYCC+PaL+EwfDa1QXTgQoivBHyKHe2++bgr
         63xL2puQUtl/k4n0Fz9D55GuS6RN80SK8wCFFNra3GFl1TIPtdHqsu2k1q2pme7mXm9k
         ZTZgi0utdGaNxWya0dg65r1TLQJ7X1DlE9YpjLCizF4NmRVPjr93L04Sav2OeDtjlJoe
         6UZRXF+Wqgti2vW+KBRSPd8JdtE4C8jNzd0Gv9VOAZykuVPvAR6nM9RQAGx1ptM94Sgh
         DMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695907820; x=1696512620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3BAVqy+qfS/cVmNVQK4vLJ+dsKgcVNx9yqoPCnc3SY=;
        b=cGwUQB1XsgwCdV3YhfosGfeN2xJp0Qn9hD9qV1jnOMxQ2kKQZfKeOtJkKR5j7WyJ4B
         KrGlOa8ScmVSTh/Q5PFnfAw9L9scviAbB3K7w5nuNB/lZlXCiNVNhEExTVsFlO/msFEQ
         aPwtQggBMumaE2j0dK/O3ThefroPTCCIF7Bt7ouXWys061hA7OHBwIZ06oxwCBdRgZ3b
         vPnZZpIkJYtjV7bUFX/ntPiv78HXm618NoDQ8cUVrwMaYowYfBDM7mnefUKl9drpM8cT
         QjM+AgMOikSUUuwBpJV5nE5vDnViN3HAocio1YRDyz4suqU0B4Kkde2YjzeVMYXb9Mlz
         tfRQ==
X-Gm-Message-State: AOJu0YwQVVaSTQGNX8dCvCxLj2g92wU/LimJm+Zg7YPMTJA0mvJ7JCuo
        2My0yqFOZj/wTsXKF34KzoNUvA==
X-Google-Smtp-Source: AGHT+IGLevxbNUf8Gqjsfxu6yEyM+B+FCCyhNilYi8pdaRk+ZAhumB2jx6pNWexTvaZAoiS5jj9wvw==
X-Received: by 2002:adf:f0c2:0:b0:31f:fb7f:d701 with SMTP id x2-20020adff0c2000000b0031ffb7fd701mr1263245wro.9.1695907820092;
        Thu, 28 Sep 2023 06:30:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id s5-20020adf9785000000b003232380ffd7sm11339780wrb.102.2023.09.28.06.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:30:19 -0700 (PDT)
Message-ID: <88523b6a-bf3b-b29b-b9e7-1d72f38ed9be@linaro.org>
Date:   Thu, 28 Sep 2023 15:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 3/3] thermal: thermal_core: Allow rebooting after
 critical temp
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
References: <20230916014928.2848737-1-festevam@gmail.com>
 <20230916014928.2848737-3-festevam@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230916014928.2848737-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/09/2023 03:49, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, the default mechanism is to trigger a shutdown after the
> critical temperature is reached.
> 
> In some embedded cases, such behavior does not suit well, as the board may
> be unattended in the field and rebooting may be a better approach.
> 
> The bootloader may also check the temperature and only allow the boot to
> proceed when the temperature is below a certain threshold.
> 
> Introduce support for allowing a reboot to be triggered after the
> critical temperature is reached.
> 
> If the "critical-action" devicetree property is not found, fall back to
> the shutdown action to preserve the existing default behavior.
> 
> Tested on a i.MX8MM board with the following devicetree changes:
> 
> 	thermal-zones {
> 		critical-action = "reboot";
> 	};
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---

The changes are too invasive.

The driver can not set their own default critical callback because it 
will be overwritten by the changes. Moreover the changes should stay in 
thermal-of.

Basically in thermal_of_zone_register(... ops):

if (!ops->critical && trip->reboot)
	ops->critical = thermal_of_reboot();

That will result in:

  - if the driver does not specify its own critical ops, then if no 
action is in the trip point, we keep the old way (shutdown), if reboot 
property is set, then assign our own thermal-of-reboot function.



> Changes since v7:
> - Search for the 'critical-action' property in the parent thermal-zone node. (Rafael)
> 
>   drivers/thermal/thermal_core.c |  6 +++++-
>   drivers/thermal/thermal_of.c   | 16 ++++++++++++++++
>   include/linux/thermal.h        |  6 ++++++
>   3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 0bdde1ab5d8b..bfa704516957 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -320,11 +320,15 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
>   	 * Its a must for forced_emergency_poweroff_work to be scheduled.
>   	 */
>   	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
> +	static const char *msg = "Temperature too high";
>
>   	dev_emerg(&tz->device, "%s: critical temperature reached, "
>   		  "shutting down\n", tz->type);
>   
> -	hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
> +	if (tz->action == THERMAL_CRITICAL_ACTION_REBOOT)
> +		hw_protection_reboot(msg, poweroff_delay_ms);
> +	else
> +		hw_protection_shutdown(msg, poweroff_delay_ms);
>   }
>   EXPORT_SYMBOL(thermal_zone_device_critical);
>   
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 4ca905723429..a1472a1965eb 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -218,6 +218,20 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>   	return tz;
>   }
>   
> +static void thermal_of_get_critical_action(struct device_node *np,
> +					   enum thermal_action *action)
> +{
> +	const char *action_string;
> +	int ret;
> +
> +	ret = of_property_read_string(np->parent, "critical-action", &action_string);
> +	if (ret < 0)
> +		*action = THERMAL_CRITICAL_ACTION_SHUTDOWN;
> +
> +	if (!strcasecmp(action_string, "reboot"))
> +		*action = THERMAL_CRITICAL_ACTION_REBOOT;
> +}
> +
>   static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdelay)
>   {
>   	int ret;
> @@ -516,6 +530,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   		goto out_kfree_trips;
>   	}
>   
> +	thermal_of_get_critical_action(np, &tz->action);
> +
>   	ret = thermal_zone_device_enable(tz);
>   	if (ret) {
>   		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index eb17495c8acc..8ea761bead79 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -34,6 +34,11 @@ struct thermal_cooling_device;
>   struct thermal_instance;
>   struct thermal_attr;
>   
> +enum thermal_action {
> +	THERMAL_CRITICAL_ACTION_SHUTDOWN = 0, /* shutdown when crit temperature is reached */
> +	THERMAL_CRITICAL_ACTION_REBOOT, /* reboot when crit temperature is reached */
> +};
> +
>   enum thermal_trend {
>   	THERMAL_TREND_STABLE, /* temperature is stable */
>   	THERMAL_TREND_RAISING, /* temperature is raising */
> @@ -183,6 +188,7 @@ struct thermal_zone_device {
>   	struct list_head node;
>   	struct delayed_work poll_queue;
>   	enum thermal_notify_event notify_event;
> +	enum thermal_action action;
>   };
>   
>   /**

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

