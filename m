Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3032FC240
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbhASVZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbhASSq0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 13:46:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F556C061575
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 10:45:46 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e15so697033wme.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 10:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/fM6ZKegC2tG0NRDag/j4tHgHZ38hRrg41AR1jJxjxw=;
        b=KbSiT2HHZ+souT3aDvW/ZWlIIr+DKhkwOGwgrscS/2/BafdzRMTj+xs//a2BwKCPuj
         JY8wGEcst+ErbTR/yu8sYie7HfXL4sLVoKe42K6DRgdWThWVb1QFZPHKNShpR3Bm/VBM
         aAa1bJOTwVpm8h1CBfgUQ34H84h3VOIpbpHVEhGBGYB8f7fpf2f4u0HUOtsNRCs4wiEN
         TDL3Zqj9zcs2TcLqG8QMYs8QHQgxE3h1HlDznEwPZ2EQ9eVQ3+rs7VRlkZo7hJXia8B1
         AF+ykYH0TdoZ2yy4+Ky7GsXa0dRKKiezXxHQS9f/JWqNAMoM+3N5/zM+mTTSdYI7X67b
         7Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/fM6ZKegC2tG0NRDag/j4tHgHZ38hRrg41AR1jJxjxw=;
        b=CczhE0va4aY8LxnApU8SBWrWz/mBXdlAVp8eHTv7sElOo+1Wx9LeL5HmcGVhu9Xh2U
         Xv+F7vGtzXL8slN98Ln/+u6I7AB38IiS+PpZ3eMB/O57w7wsrdwFcSsnev/kL4hhgGEH
         CF/aofzt35arrjHWzpXGv3XRo2vYtHKtj/2k7CtaNTgd4p1X0ZmV68yIa1z6ntDDKPKF
         xnuxzAcf4iO5Tst22oEb8UNkOzDkONxahz/8v5RPgkk6cp0hSXaTuP3M9wIf+AK6XBR3
         qYMlpJG5XYBqkY6aRzo0AiviqJXUq1Lb5BewsKWC9XE/xxoZhBKwfV3Gv7gbrGMF+YIh
         Utlw==
X-Gm-Message-State: AOAM5325nn254OcN3iaCKkwVO2O8jg6WWhnx3D0BMz0IrQ1FCiFRpAI2
        i06rwiiNXDevs0j0DPCKjMC7ZA==
X-Google-Smtp-Source: ABdhPJyXahTgdED5eJ8tWfl9ABrXXVsuMiCwp/GWYC0ormp+KLzCr4C4vIF/Bbr12NaNkh28KWwZ8g==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr932539wme.146.1611081944619;
        Tue, 19 Jan 2021 10:45:44 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id o124sm6074944wmb.5.2021.01.19.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:45:44 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Nicolas Pitre <npitre@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / clk: make PM clock layer compatible with clocks
 that must sleep
In-Reply-To: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz>
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz>
Date:   Tue, 19 Jan 2021 10:45:41 -0800
Message-ID: <7him7sydd6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[ + Geert.. renesas SoCs are the primary user of PM clk ]

Nicolas Pitre <npitre@baylibre.com> writes:

> The clock API splits its interface into sleepable ant atomic contexts:
>
> - clk_prepare/clk_unprepare for stuff that might sleep
>
> - clk_enable_clk_disable for anything that may be done in atomic context
>
> The code handling runtime PM for clocks only calls clk_disable() on
> suspend requests, and clk_enable on resume requests. This means that
> runtime PM with clock providers that only have the prepare/unprepare
> methods implemented is basically useless.
>
> Many clock implementations can't accommodate atomic contexts. This is
> often the case when communication with the clock happens through another
> subsystem like I2C or SCMI.
>
> Let's make the clock PM code useful with such clocks by safely invoking
> clk_prepare/clk_unprepare upon resume/suspend requests. Of course, when
> such clocks are registered with the PM layer then pm_runtime_irq_safe()
> can't be used, and neither pm_runtime_suspend() nor pm_runtime_resume()
> may be invoked in atomic context.
>
> For clocks that do implement the enable and disable methods then 
> everything just works as before.
>
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index ced6863a16..a62fb0f9b1 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -23,6 +23,7 @@
>  enum pce_status {
>  	PCE_STATUS_NONE = 0,
>  	PCE_STATUS_ACQUIRED,
> +	PCE_STATUS_PREPARED,
>  	PCE_STATUS_ENABLED,
>  	PCE_STATUS_ERROR,
>  };
> @@ -32,8 +33,102 @@ struct pm_clock_entry {
>  	char *con_id;
>  	struct clk *clk;
>  	enum pce_status status;
> +	bool enabled_when_prepared;
>  };
>  
> +/**
> + * pm_clk_list_lock - ensure exclusive access for modifying the PM clock
> + *		      entry list.
> + * @psd: pm_subsys_data instance corresponding to the PM clock entry list
> + *	 and clk_op_might_sleep count to be modified.
> + *
> + * Get exclusive access before modifying the PM clock entry list and the
> + * clock_op_might_sleep count to guard against concurrent modifications.
> + * This also protects against a concurrent clock_op_might_sleep and PM clock
> + * entry list usage in pm_clk_suspend()/pm_clk_resume() that may or may not
> + * happen in atomic context, hence both the mutex and the spinlock must be
> + * taken here.
> + */
> +static void pm_clk_list_lock(struct pm_subsys_data *psd)
> +{
> +	mutex_lock(&psd->clock_mutex);
> +	spin_lock_irq(&psd->lock);
> +}
> +
> +/**
> + * pm_clk_list_unlock - counterpart to pm_clk_list_lock().
> + * @psd: the same pm_subsys_data instance previously passed to
> + *	 pm_clk_list_lock().
> + */
> +static void pm_clk_list_unlock(struct pm_subsys_data *psd)
> +{
> +	spin_unlock_irq(&psd->lock);
> +	mutex_unlock(&psd->clock_mutex);
> +}
> +
> +/**
> + * pm_clk_op_lock - ensure exclusive access for performing clock operations.
> + * @psd: pm_subsys_data instance corresponding to the PM clock entry list
> + *	 and clk_op_might_sleep count being used.
> + * @flags: stored irq flags.
> + * @fn: string for the caller function's name.
> + *
> + * This is used by pm_clk_suspend() and pm_clk_resume() to guard
> + * against concurrent modifications to the clock entry list and the
> + * clock_op_might_sleep count. If clock_op_might_sleep is != 0 then
> + * only the mutex can be locked and those functions can only be used in
> + * non atomic context. If clock_op_might_sleep == 0 then these functions
> + * may be used in any context and only the spinlock can be locked.
> + * Returns -EINVAL if called in atomic context when clock ops might sleep.
> + */
> +static int pm_clk_op_lock(struct pm_subsys_data *psd, unsigned long *flags,
> +			  const char *fn)
> +{
> +	bool atomic_context = in_atomic() || irqs_disabled();
> +
> +try_again:
> +	spin_lock_irqsave(&psd->lock, *flags);
> +	if (!psd->clock_op_might_sleep)
> +		return 0;
> +
> +	/* bail out if in atomic context */
> +	if (atomic_context) {
> +		pr_err("%s: atomic context with clock_ops_might_sleep = %d",
> +		       fn, psd->clock_op_might_sleep);
> +		spin_unlock_irqrestore(&psd->lock, *flags);
> +		might_sleep();
> +		return -EPERM;
> +	}
> +
> +	/* we must switch to the mutex */
> +	spin_unlock_irqrestore(&psd->lock, *flags);
> +	mutex_lock(&psd->clock_mutex);
> +
> +	/*
> +	 * There was a possibility for psd->clock_op_might_sleep
> +	 * to become 0 above. Keep the mutex only if not the case.
> +	 */
> +	if (likely(psd->clock_op_might_sleep))
> +		return 0;
> +
> +	mutex_unlock(&psd->clock_mutex);
> +	goto try_again;
> +}
> +
> +/**
> + * pm_clk_op_unlock - counterpart to pm_clk_op_lock().
> + * @psd: the same pm_subsys_data instance previously passed to
> + *	 pm_clk_op_lock().
> + * @flags: irq flags provided by pm_clk_op_lock().
> + */
> +static void pm_clk_op_unlock(struct pm_subsys_data *psd, unsigned long *flags)
> +{
> +	if (psd->clock_op_might_sleep)
> +		mutex_unlock(&psd->clock_mutex);
> +	else
> +		spin_unlock_irqrestore(&psd->lock, *flags);
> +}
> +
>  /**
>   * pm_clk_enable - Enable a clock, reporting any errors
>   * @dev: The device for the given clock
> @@ -43,14 +138,21 @@ static inline void __pm_clk_enable(struct device *dev, struct pm_clock_entry *ce
>  {
>  	int ret;
>  
> -	if (ce->status < PCE_STATUS_ERROR) {
> +	switch (ce->status) {
> +	case PCE_STATUS_ACQUIRED:
> +		ret = clk_prepare_enable(ce->clk);
> +		break;
> +	case PCE_STATUS_PREPARED:
>  		ret = clk_enable(ce->clk);
> -		if (!ret)
> -			ce->status = PCE_STATUS_ENABLED;
> -		else
> -			dev_err(dev, "%s: failed to enable clk %p, error %d\n",
> -				__func__, ce->clk, ret);
> +		break;
> +	default:
> +		return;
>  	}
> +	if (!ret)
> +		ce->status = PCE_STATUS_ENABLED;
> +	else
> +		dev_err(dev, "%s: failed to enable clk %p, error %d\n",
> +			__func__, ce->clk, ret);
>  }
>  
>  /**
> @@ -64,17 +166,20 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
>  		ce->clk = clk_get(dev, ce->con_id);
>  	if (IS_ERR(ce->clk)) {
>  		ce->status = PCE_STATUS_ERROR;
> +		return;
> +	} else if (clk_is_enabled_when_prepared(ce->clk)) {
> +		/* we defer preparing the clock in that case */
> +		ce->status = PCE_STATUS_ACQUIRED;
> +		ce->enabled_when_prepared = true;
> +	} else if (clk_prepare(ce->clk)) {
> +		ce->status = PCE_STATUS_ERROR;
> +		dev_err(dev, "clk_prepare() failed\n");
> +		return;
>  	} else {
> -		if (clk_prepare(ce->clk)) {
> -			ce->status = PCE_STATUS_ERROR;
> -			dev_err(dev, "clk_prepare() failed\n");
> -		} else {
> -			ce->status = PCE_STATUS_ACQUIRED;
> -			dev_dbg(dev,
> -				"Clock %pC con_id %s managed by runtime PM.\n",
> -				ce->clk, ce->con_id);
> -		}
> +		ce->status = PCE_STATUS_PREPARED;
>  	}
> +	dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",
> +		ce->clk, ce->con_id);
>  }
>  
>  static int __pm_clk_add(struct device *dev, const char *con_id,
> @@ -106,9 +211,11 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
>  
>  	pm_clk_acquire(dev, ce);
>  
> -	spin_lock_irq(&psd->lock);
> +	pm_clk_list_lock(psd);
>  	list_add_tail(&ce->node, &psd->clock_list);
> -	spin_unlock_irq(&psd->lock);
> +	if (ce->enabled_when_prepared)
> +		psd->clock_op_might_sleep++;
> +	pm_clk_list_unlock(psd);
>  	return 0;
>  }
>  
> @@ -239,14 +346,20 @@ static void __pm_clk_remove(struct pm_clock_entry *ce)
>  	if (!ce)
>  		return;
>  
> -	if (ce->status < PCE_STATUS_ERROR) {
> -		if (ce->status == PCE_STATUS_ENABLED)
> -			clk_disable(ce->clk);
> -
> -		if (ce->status >= PCE_STATUS_ACQUIRED) {
> -			clk_unprepare(ce->clk);
> +	switch (ce->status) {
> +	case PCE_STATUS_ENABLED:
> +		clk_disable(ce->clk);
> +		fallthrough;
> +	case PCE_STATUS_PREPARED:
> +		clk_unprepare(ce->clk);
> +		fallthrough;
> +	case PCE_STATUS_ACQUIRED:
> +	case PCE_STATUS_ERROR:
> +		if (!IS_ERR(ce->clk))
>  			clk_put(ce->clk);
> -		}
> +		break;
> +	default:
> +		break;
>  	}
>  
>  	kfree(ce->con_id);
> @@ -269,7 +382,7 @@ void pm_clk_remove(struct device *dev, const char *con_id)
>  	if (!psd)
>  		return;
>  
> -	spin_lock_irq(&psd->lock);
> +	pm_clk_list_lock(psd);
>  
>  	list_for_each_entry(ce, &psd->clock_list, node) {
>  		if (!con_id && !ce->con_id)
> @@ -280,12 +393,14 @@ void pm_clk_remove(struct device *dev, const char *con_id)
>  			goto remove;
>  	}
>  
> -	spin_unlock_irq(&psd->lock);
> +	pm_clk_list_unlock(psd);
>  	return;
>  
>   remove:
>  	list_del(&ce->node);
> -	spin_unlock_irq(&psd->lock);
> +	if (ce->enabled_when_prepared)
> +		psd->clock_op_might_sleep--;
> +	pm_clk_list_unlock(psd);
>  
>  	__pm_clk_remove(ce);
>  }
> @@ -307,19 +422,21 @@ void pm_clk_remove_clk(struct device *dev, struct clk *clk)
>  	if (!psd || !clk)
>  		return;
>  
> -	spin_lock_irq(&psd->lock);
> +	pm_clk_list_lock(psd);
>  
>  	list_for_each_entry(ce, &psd->clock_list, node) {
>  		if (clk == ce->clk)
>  			goto remove;
>  	}
>  
> -	spin_unlock_irq(&psd->lock);
> +	pm_clk_list_unlock(psd);
>  	return;
>  
>   remove:
>  	list_del(&ce->node);
> -	spin_unlock_irq(&psd->lock);
> +	if (ce->enabled_when_prepared)
> +		psd->clock_op_might_sleep--;
> +	pm_clk_list_unlock(psd);
>  
>  	__pm_clk_remove(ce);
>  }
> @@ -330,13 +447,16 @@ EXPORT_SYMBOL_GPL(pm_clk_remove_clk);
>   * @dev: Device to initialize the list of PM clocks for.
>   *
>   * Initialize the lock and clock_list members of the device's pm_subsys_data
> - * object.
> + * object, set the count of clocks that might sleep to 0.
>   */
>  void pm_clk_init(struct device *dev)
>  {
>  	struct pm_subsys_data *psd = dev_to_psd(dev);
> -	if (psd)
> +	if (psd) {
>  		INIT_LIST_HEAD(&psd->clock_list);
> +		mutex_init(&psd->clock_mutex);
> +		psd->clock_op_might_sleep = 0;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(pm_clk_init);
>  
> @@ -372,12 +492,13 @@ void pm_clk_destroy(struct device *dev)
>  
>  	INIT_LIST_HEAD(&list);
>  
> -	spin_lock_irq(&psd->lock);
> +	pm_clk_list_lock(psd);
>  
>  	list_for_each_entry_safe_reverse(ce, c, &psd->clock_list, node)
>  		list_move(&ce->node, &list);
> +	psd->clock_op_might_sleep = 0;
>  
> -	spin_unlock_irq(&psd->lock);
> +	pm_clk_list_unlock(psd);
>  
>  	dev_pm_put_subsys_data(dev);
>  
> @@ -397,23 +518,30 @@ int pm_clk_suspend(struct device *dev)
>  	struct pm_subsys_data *psd = dev_to_psd(dev);
>  	struct pm_clock_entry *ce;
>  	unsigned long flags;
> +	int ret;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
>  	if (!psd)
>  		return 0;
>  
> -	spin_lock_irqsave(&psd->lock, flags);
> +	ret = pm_clk_op_lock(psd, &flags, __func__);
> +	if (ret)
> +		return ret;
>  
>  	list_for_each_entry_reverse(ce, &psd->clock_list, node) {
> -		if (ce->status < PCE_STATUS_ERROR) {
> -			if (ce->status == PCE_STATUS_ENABLED)
> +		if (ce->status == PCE_STATUS_ENABLED) {
> +			if (ce->enabled_when_prepared) {
> +				clk_disable_unprepare(ce->clk);
> +				ce->status = PCE_STATUS_ACQUIRED;
> +			} else {
>  				clk_disable(ce->clk);
> -			ce->status = PCE_STATUS_ACQUIRED;
> +				ce->status = PCE_STATUS_PREPARED;
> +			}
>  		}
>  	}
>  
> -	spin_unlock_irqrestore(&psd->lock, flags);
> +	pm_clk_op_unlock(psd, &flags);
>  
>  	return 0;
>  }
> @@ -428,18 +556,21 @@ int pm_clk_resume(struct device *dev)
>  	struct pm_subsys_data *psd = dev_to_psd(dev);
>  	struct pm_clock_entry *ce;
>  	unsigned long flags;
> +	int ret;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
>  	if (!psd)
>  		return 0;
>  
> -	spin_lock_irqsave(&psd->lock, flags);
> +	ret = pm_clk_op_lock(psd, &flags, __func__);
> +	if (ret)
> +		return ret;
>  
>  	list_for_each_entry(ce, &psd->clock_list, node)
>  		__pm_clk_enable(dev, ce);
>  
> -	spin_unlock_irqrestore(&psd->lock, flags);
> +	pm_clk_op_unlock(psd, &flags);
>  
>  	return 0;
>  }
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8c1d04db99..3d751ae5bc 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1164,6 +1164,27 @@ int clk_enable(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_enable);
>  
> +/**
> + * clk_is_enabled_when_prepared - indicate if preparing a clock also enables it.
> + * @clk: clock source
> + *
> + * Returns true if clk_prepare() implicitly enables the clock, effectively
> + * making clk_enable()/clk_disable() no-ops, false otherwise.
> + *
> + * This is of interest mainly to power management code where actually
> + * disabling the clock also requires unpreparing it to have any material
> + * effect.
> + *
> + * Regardless of the value returned here, the caller must always invoke
> + * clk_enable() or clk_prepare_enable()  and counterparts for usage counts
> + * to be right.
> + */
> +bool clk_is_enabled_when_prepared(struct clk *clk)
> +{
> +	return clk && !(clk->core->ops->enable && clk->core->ops->disable);
> +}
> +EXPORT_SYMBOL_GPL(clk_is_enabled_when_prepared);
> +
>  static int clk_core_prepare_enable(struct clk_core *core)
>  {
>  	int ret;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 31ff1bf1b7..71295906a2 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -554,6 +554,23 @@ void clk_disable(struct clk *clk);
>   */
>  void clk_bulk_disable(int num_clks, const struct clk_bulk_data *clks);
>  
> +/**
> + * clk_is_enabled_when_prepared - indicate if preparing a clock also enables it.
> + * @clk: clock source
> + *
> + * Returns true if clk_prepare() implicitly enables the clock, effectively
> + * making clk_enable()/clk_disable() no-ops, false otherwise.
> + *
> + * This is of interest mainly to the power management code where actually
> + * disabling the clock also requires unpreparing it to have any material
> + * effect.
> + *
> + * Regardless of the value returned here, the caller must always invoke
> + * clk_enable() or clk_prepare_enable()  and counterparts for usage counts
> + * to be right.
> + */
> +bool clk_is_enabled_when_prepared(struct clk *clk);
> +
>  /**
>   * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
>   *		  This is only valid once the clock source has been enabled.
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 47aca6bac1..482313a8cc 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -537,6 +537,8 @@ struct pm_subsys_data {
>  	spinlock_t lock;
>  	unsigned int refcount;
>  #ifdef CONFIG_PM_CLK
> +	unsigned int clock_op_might_sleep;
> +	struct mutex clock_mutex;
>  	struct list_head clock_list;
>  #endif
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
