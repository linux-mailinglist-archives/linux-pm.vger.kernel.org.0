Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB4A362DCC
	for <lists+linux-pm@lfdr.de>; Sat, 17 Apr 2021 06:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhDQE5k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Apr 2021 00:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhDQE5k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Apr 2021 00:57:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A6AC061574
        for <linux-pm@vger.kernel.org>; Fri, 16 Apr 2021 21:57:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id 12so28560905wrz.7
        for <linux-pm@vger.kernel.org>; Fri, 16 Apr 2021 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JrhmhIl/zhGbk6XFbxC+wKuQyPiAESBYDekvQYnTwUo=;
        b=kTENIkt3ohnfY8gzDt9X9UpyWfrG2z+vcRKHpiVcW37n2oW6MxYYRforPRt0I/4Vq6
         u8Lffpmzm85G7upERi/9EcMjIE3G4xAVRqBmTi3gUbwkx09ej1uxI0SvcxXL+Pf4nphc
         0IQcI+rVpHRGaqwFXkCDqBQSUQCPTWF5EQD2qn0MoJUw2acoz0OIE4Fuga6iVMjgCQ7i
         xR/NlQJgxgsmLlui/aDmOqoDbPE060sdl9Fyv4U2ieQ14l371ZGLNDJptHz7hyCAaQ4P
         tEq3CqomTDQM1L2xAgIokyu0W64+VkosDXPANrnV3gh+fejePG2/Mf+ZYTXSbuIPmHIs
         dipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JrhmhIl/zhGbk6XFbxC+wKuQyPiAESBYDekvQYnTwUo=;
        b=PE22gDLMUjHl5F1Cr028cFWz4gtNQ0CsITLFmN7IDNjTzqFiYip91jDm7oQLjlLvkU
         aFNONOd2v/nJLqkKpnIL0q1E0vkEG9wdZi1INT39WKyq7NG0wif+K83kt7osFbJMyzcF
         r1V83MMsADjv8LRaqXGo2N4J61RwcaPfLZpbY7N9DOftBFo2TzS9/58FJy7tKSUubMB3
         G3QxYFo8pxzZKPF9XZrHbqcZyw+UPc8Zbh5Lf3CCmjAFj4uX0bs3Z41CX5xjLe35hj1h
         neO++CQ/aIUdnhef2Yk4j8pYMMiWmC2Ypa1ZH2C2xQKaUfDF1X332SjgzM/Dve/XC6WP
         7d1Q==
X-Gm-Message-State: AOAM533ZKqt0PldNNeZ4RhkF/PgeV/DDdRcOeQ0maSWm0umHOhiL/n5O
        nvYefN3hzosltbPm6JgqhN2eg80zn/jnHaRe
X-Google-Smtp-Source: ABdhPJwdlA0oLxm64mxca7Gh2rEvsG06SVMGsYf7lk9AZu4FeXneCvbU8Tt+uVhYxvDI91e4aX7SXA==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr2414964wrp.173.1618635432685;
        Fri, 16 Apr 2021 21:57:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:689d:e652:825c:501e? ([2a01:e34:ed2f:f020:689d:e652:825c:501e])
        by smtp.googlemail.com with ESMTPSA id x25sm11567040wmj.34.2021.04.16.21.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:57:12 -0700 (PDT)
Subject: Re: [PATCH v7 2/9] reboot: thermal: Export hardware protection
 shutdown
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org
References: <cover.1618377272.git.matti.vaittinen@fi.rohmeurope.com>
 <adf417797006c996605a03c8bacfb4961e8f0b42.1618377272.git.matti.vaittinen@fi.rohmeurope.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7e231384-77c9-d32d-a0e0-63b735072b2d@linaro.org>
Date:   Sat, 17 Apr 2021 06:57:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <adf417797006c996605a03c8bacfb4961e8f0b42.1618377272.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/04/2021 07:52, Matti Vaittinen wrote:
> Thermal core contains a logic for safety shutdown. System is attempted to
> be powered off if temperature exceeds safety limits.
> 
> Currently this can be also utilized by regulator subsystem as a final
> protection measure if PMICs report dangerous over-voltage, over-current or
> over-temperature and if per regulator counter measures fail or do not
> exist.
> 
> Move this logic to kernel/reboot.c and export the functionality for other
> subsystems to use. Also replace the mutex with a spinlock to allow using
> the function from any context.
> 
> Also the EMIF bus code has implemented a safety shut-down. EMIF does not
> attempt orderly_poweroff at all. Thus the EMIF code is not converted to use
> this new function.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> Changelog
>  v7:
>   - new patch
> 
> Please note - this patch has received only a minimal amount of testing.
> (The new API call was tested to shut-down my system at driver probe but
> no odd corner-cases have been tested).
> 
> Any testing for thermal shutdown is appreciated.

You can test it easily by enabling the option CONFIG_THERMAL_EMULATION

Then in any thermal zone:

Assuming the critical temp is below the one specified in the command:

echo 100000 > /sys/class/thermal/thermal_zone0/emul_temp

> ---
>  drivers/thermal/thermal_core.c | 63 ++-----------------------
>  include/linux/reboot.h         |  1 +
>  kernel/reboot.c                | 86 ++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 996c038f83a4..b1444845af38 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -36,10 +36,8 @@ static LIST_HEAD(thermal_governor_list);
>  
>  static DEFINE_MUTEX(thermal_list_lock);
>  static DEFINE_MUTEX(thermal_governor_lock);
> -static DEFINE_MUTEX(poweroff_lock);
>  
>  static atomic_t in_suspend;
> -static bool power_off_triggered;
>  
>  static struct thermal_governor *def_governor;
>  
> @@ -327,70 +325,18 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
>  		       def_governor->throttle(tz, trip);
>  }
>  
> -/**
> - * thermal_emergency_poweroff_func - emergency poweroff work after a known delay
> - * @work: work_struct associated with the emergency poweroff function
> - *
> - * This function is called in very critical situations to force
> - * a kernel poweroff after a configurable timeout value.
> - */
> -static void thermal_emergency_poweroff_func(struct work_struct *work)
> -{
> -	/*
> -	 * We have reached here after the emergency thermal shutdown
> -	 * Waiting period has expired. This means orderly_poweroff has
> -	 * not been able to shut off the system for some reason.
> -	 * Try to shut down the system immediately using kernel_power_off
> -	 * if populated
> -	 */
> -	WARN(1, "Attempting kernel_power_off: Temperature too high\n");
> -	kernel_power_off();
> -
> -	/*
> -	 * Worst of the worst case trigger emergency restart
> -	 */
> -	WARN(1, "Attempting emergency_restart: Temperature too high\n");
> -	emergency_restart();
> -}
> -
> -static DECLARE_DELAYED_WORK(thermal_emergency_poweroff_work,
> -			    thermal_emergency_poweroff_func);
> -
> -/**
> - * thermal_emergency_poweroff - Trigger an emergency system poweroff
> - *
> - * This may be called from any critical situation to trigger a system shutdown
> - * after a known period of time. By default this is not scheduled.
> - */
> -static void thermal_emergency_poweroff(void)
> +void thermal_zone_device_critical(struct thermal_zone_device *tz)
>  {
> -	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
>  	/*
>  	 * poweroff_delay_ms must be a carefully profiled positive value.
> -	 * Its a must for thermal_emergency_poweroff_work to be scheduled
> +	 * Its a must for forced_emergency_poweroff_work to be scheduled.
>  	 */
> -	if (poweroff_delay_ms <= 0)
> -		return;
> -	schedule_delayed_work(&thermal_emergency_poweroff_work,
> -			      msecs_to_jiffies(poweroff_delay_ms));
> -}
> +	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
>  
> -void thermal_zone_device_critical(struct thermal_zone_device *tz)
> -{
>  	dev_emerg(&tz->device, "%s: critical temperature reached, "
>  		  "shutting down\n", tz->type);
>  
> -	mutex_lock(&poweroff_lock);
> -	if (!power_off_triggered) {
> -		/*
> -		 * Queue a backup emergency shutdown in the event of
> -		 * orderly_poweroff failure
> -		 */
> -		thermal_emergency_poweroff();
> -		orderly_poweroff(true);
> -		power_off_triggered = true;
> -	}
> -	mutex_unlock(&poweroff_lock);
> +	hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
>  }
>  EXPORT_SYMBOL(thermal_zone_device_critical);
>  
> @@ -1549,7 +1495,6 @@ static int __init thermal_init(void)
>  	ida_destroy(&thermal_cdev_ida);
>  	mutex_destroy(&thermal_list_lock);
>  	mutex_destroy(&thermal_governor_lock);
> -	mutex_destroy(&poweroff_lock);
>  	return result;
>  }
>  postcore_initcall(thermal_init);
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 3734cd8f38a8..af907a3d68d1 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -79,6 +79,7 @@ extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
>  
>  extern void orderly_poweroff(bool force);
>  extern void orderly_reboot(void);
> +void hw_protection_shutdown(const char *reason, int ms_until_forced);
>  
>  /*
>   * Emergency restart, callable from an interrupt handler.
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index a6ad5eb2fa73..1b5fa6d213d4 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -518,6 +518,92 @@ void orderly_reboot(void)
>  }
>  EXPORT_SYMBOL_GPL(orderly_reboot);
>  
> +/**
> + * hw_failure_emergency_poweroff_func - emergency poweroff work after a known delay
> + * @work: work_struct associated with the emergency poweroff function
> + *
> + * This function is called in very critical situations to force
> + * a kernel poweroff after a configurable timeout value.
> + */
> +static void hw_failure_emergency_poweroff_func(struct work_struct *work)
> +{
> +	/*
> +	 * We have reached here after the emergency shutdown waiting period has
> +	 * expired. This means orderly_poweroff has not been able to shut off
> +	 * the system for some reason.
> +	 *
> +	 * Try to shut down the system immediately using kernel_power_off
> +	 * if populated
> +	 */
> +	WARN(1, "Hardware protection timed-out. Trying forced poweroff\n");
> +	kernel_power_off();
> +
> +	/*
> +	 * Worst of the worst case trigger emergency restart
> +	 */
> +	WARN(1,
> +	     "Hardware protection shutdown failed. Trying emergency restart\n");
> +	emergency_restart();
> +}
> +
> +static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
> +			    hw_failure_emergency_poweroff_func);
> +
> +/**
> + * hw_failure_emergency_poweroff - Trigger an emergency system poweroff
> + *
> + * This may be called from any critical situation to trigger a system shutdown
> + * after a given period of time. If time is negative this is not scheduled.
> + */
> +static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
> +{
> +	if (poweroff_delay_ms <= 0)
> +		return;
> +	schedule_delayed_work(&hw_failure_emergency_poweroff_work,
> +			      msecs_to_jiffies(poweroff_delay_ms));
> +}
> +
> +static bool prot_power_off_triggered;
> +static DEFINE_SPINLOCK(poweroff_lock);
> +
> +/**
> + * hw_protection_shutdown - Trigger an emergency system poweroff
> + *
> + * @reason:		Reason of emergency shutdown to be printed.
> + * @ms_until_forced:	Time to wait for orderly shutdown before tiggering a
> + *			forced shudown. Negative value disables the forced
> + *			shutdown.
> + *
> + * Initiate an emergency system shutdown in order to protect hardware from
> + * further damage. Usage examples include a thermal protection or a voltage or
> + * current regulator failures.
> + * NOTE: The request is ignored if protection shutdown is already pending even
> + * if the previous request has given a large timeout for forced shutdown.
> + * Can be called from any context.
> + */
> +void hw_protection_shutdown(const char *reason, int ms_until_forced)
> +{
> +	unsigned long flags;
> +
> +	pr_emerg("HARDWARE PROTECTION shutdown (%s)\n", reason);
> +
> +	spin_lock_irqsave(&poweroff_lock, flags);
> +	if (prot_power_off_triggered) {
> +		spin_unlock(&poweroff_lock);
> +		return;
> +	}
> +	prot_power_off_triggered = true;
> +	spin_unlock_irqrestore(&poweroff_lock, flags);
> +
> +	/*
> +	 * Queue a backup emergency shutdown in the event of
> +	 * orderly_poweroff failure
> +	 */
> +	hw_failure_emergency_poweroff(ms_until_forced);
> +	orderly_poweroff(true);
> +}
> +EXPORT_SYMBOL_GPL(hw_protection_shutdown);
> +
>  static int __init reboot_setup(char *str)
>  {
>  	for (;;) {
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
