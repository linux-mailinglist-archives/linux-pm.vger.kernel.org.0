Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373B323B0A5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 01:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHCXDb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 19:03:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:23282 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgHCXDa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 19:03:30 -0400
IronPort-SDR: jTHnkkyOL5/1TxmIMm2BvW1OcGVWHimSyZrstQid+Pnen+2tHjfGlakidMXLv7Pj5dbkKrjdII
 l9bNGQ9XnaHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="170307901"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="170307901"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 16:03:27 -0700
IronPort-SDR: TgtKtGH8T6UbnRZBc8qciAaCqirkGcqsrkOhPuAeRupXE3zbB9zD1vnDUN+O8nTQRJMISkXul+
 e0220VBuMvTg==
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="492149886"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 16:03:25 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id A148D20878; Tue,  4 Aug 2020 02:03:23 +0300 (EEST)
Date:   Tue, 4 Aug 2020 02:03:23 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] PM: runtime: Add kerneldoc comments to multiple helpers
Message-ID: <20200803230323.GA13316@paasikivi.fi.intel.com>
References: <2672940.cHDmkauF2A@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2672940.cHDmkauF2A@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

One more comment below.

On Fri, Jul 31, 2020 at 07:03:26PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add kerneldoc comments to multiple PM-runtime helper functions
> defined as static inline wrappers around lower-level routines to
> provide quick reference decumentation of their behavior.
> 
> Some of them are similar to each other with subtle differences only
> and the behavior of some of them may appear as counter-intuitive, so
> clarify all that to avoid confusion.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/pm_runtime.h |  246 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 246 insertions(+)
> 
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -60,58 +60,151 @@ extern void pm_runtime_put_suppliers(str
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device *dev);
>  
> +/**
> + * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
> + * @dev: Target device.
> + *
> + * Increment the runtime PM usage counter of @dev if its runtime PM status is
> + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.
> + */
>  static inline int pm_runtime_get_if_in_use(struct device *dev)
>  {
>  	return pm_runtime_get_if_active(dev, false);
>  }
>  
> +/**
> + * pm_suspend_ignore_children - Set runtime PM behavior regarding children.
> + * @dev: Target device.
> + * @enable: Whether or not to ignore possible dependencies on children.
> + *
> + * The dependencies of @dev on its children will not be taken into account by
> + * the runtime PM framework going forward if @enable is %true, or they will
> + * be taken into account otherwise.
> + */
>  static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
>  {
>  	dev->power.ignore_children = enable;
>  }
>  
> +/**
> + * pm_runtime_get_noresume - Bump up runtime PM usage counter of a device.
> + * @dev: Target device.
> + */
>  static inline void pm_runtime_get_noresume(struct device *dev)
>  {
>  	atomic_inc(&dev->power.usage_count);
>  }
>  
> +/**
> + * pm_runtime_put_noidle - Drop runtime PM usage counter of a device.
> + * @dev: Target device.
> + *
> + * Decrement the runtime PM usage counter of @dev unless it is 0 already.
> + */
>  static inline void pm_runtime_put_noidle(struct device *dev)
>  {
>  	atomic_add_unless(&dev->power.usage_count, -1, 0);
>  }
>  
> +/**
> + * pm_runtime_suspended - Check whether or not a device is runtime-suspended.
> + * @dev: Target device.
> + *
> + * Return %true if runtime PM is enabled for @dev and its runtime PM status is
> + * %RPM_SUSPENDED, or %false otherwise.
> + *
> + * Note that the return value of this function can only be trusted if it is
> + * called under the runtime PM lock of @dev or under conditions in which
> + * runtime PM cannot be either disabled or enabled for @dev and its runtime PM
> + * status cannot change.
> + */
>  static inline bool pm_runtime_suspended(struct device *dev)
>  {
>  	return dev->power.runtime_status == RPM_SUSPENDED
>  		&& !dev->power.disable_depth;
>  }
>  
> +/**
> + * pm_runtime_active - Check whether or not a device is runtime-active.
> + * @dev: Target device.
> + *
> + * Return %true if runtime PM is enabled for @dev and its runtime PM status is
> + * %RPM_ACTIVE, or %false otherwise.
> + *
> + * Note that the return value of this function can only be trusted if it is
> + * called under the runtime PM lock of @dev or under conditions in which
> + * runtime PM cannot be either disabled or enabled for @dev and its runtime PM
> + * status cannot change.
> + */
>  static inline bool pm_runtime_active(struct device *dev)
>  {
>  	return dev->power.runtime_status == RPM_ACTIVE
>  		|| dev->power.disable_depth;
>  }
>  
> +/**
> + * pm_runtime_status_suspended - Check if runtime PM status is "suspended".
> + * @dev: Target device.
> + *
> + * Return %true if the runtime PM status of @dev is %RPM_SUSPENDED, or %false
> + * otherwise, regardless of whether or not runtime PM has been enabled for @dev.
> + *
> + * Note that the return value of this function can only be trusted if it is
> + * called under the runtime PM lock of @dev or under conditions in which the
> + * runtime PM status of @dev cannot change.
> + */
>  static inline bool pm_runtime_status_suspended(struct device *dev)
>  {
>  	return dev->power.runtime_status == RPM_SUSPENDED;
>  }
>  
> +/**
> + * pm_runtime_enabled - Check if runtime PM is enabled.
> + * @dev: Target device.
> + *
> + * Return %true if runtime PM is enabled for @dev or %false otherwise.
> + *
> + * Note that the return value of this function can only be trusted if it is
> + * called under the runtime PM lock of @dev or under conditions in which
> + * runtime PM cannot be either disabled or enabled for @dev.
> + */
>  static inline bool pm_runtime_enabled(struct device *dev)
>  {
>  	return !dev->power.disable_depth;
>  }
>  
> +/**
> + * pm_runtime_has_no_callbacks - Check if runtime PM callbacks may be present.
> + * @dev: Target device.
> + *
> + * Return %true if @dev is a special device without runtime PM callbacks or
> + * %false otherwise.
> + */
>  static inline bool pm_runtime_has_no_callbacks(struct device *dev)
>  {
>  	return dev->power.no_callbacks;
>  }
>  
> +/**
> + * pm_runtime_mark_last_busy - Update the last access time of a device.
> + * @dev: Target device.
> + *
> + * Update the last access time of @dev used by the runtime PM autosuspend
> + * mechanism to the current time as returned by ktime_get_mono_fast_ns().
> + */
>  static inline void pm_runtime_mark_last_busy(struct device *dev)
>  {
>  	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
>  }
>  
> +/**
> + * pm_runtime_is_irq_safe - Check if runtime PM can work in interrupt context.
> + * @dev: Target device.
> + *
> + * Return %true if @dev has been marked as an "IRQ-safe" device (with respect
> + * to runtime PM), in which case its runtime PM callabcks can be expected to
> + * work correctly when invoked from interrupt handlers.
> + */
>  static inline bool pm_runtime_is_irq_safe(struct device *dev)
>  {
>  	return dev->power.irq_safe;
> @@ -191,97 +284,250 @@ static inline void pm_runtime_drop_link(
>  
>  #endif /* !CONFIG_PM */
>  
> +/**
> + * pm_runtime_idle - Conditionally set up autosuspend of a device or suspend it.
> + * @dev: Target device.
> + *
> + * Invoke the "idle check" callback of @dev and, depending on its return value,
> + * set up autosuspend of @dev or suspend it (depending on whether or not
> + * autosuspend has been enabled for it).
> + */
>  static inline int pm_runtime_idle(struct device *dev)
>  {
>  	return __pm_runtime_idle(dev, 0);
>  }
>  
> +/**
> + * pm_runtime_suspend - Suspend a device synchronously.
> + * @dev: Target device.
> + */
>  static inline int pm_runtime_suspend(struct device *dev)
>  {
>  	return __pm_runtime_suspend(dev, 0);
>  }
>  
> +/**
> + * pm_runtime_autosuspend - Set up autosuspend of a device or suspend it.
> + * @dev: Target device.
> + *
> + * Set up autosuspend of @dev or suspend it (depending on whether or not
> + * autosuspend is enabled for it) without engaging its "idle check" callback.
> + */
>  static inline int pm_runtime_autosuspend(struct device *dev)
>  {
>  	return __pm_runtime_suspend(dev, RPM_AUTO);
>  }
>  
> +/**
> + * pm_runtime_resume - Resume a device synchronously.
> + * @dev: Target device.
> + */
>  static inline int pm_runtime_resume(struct device *dev)
>  {
>  	return __pm_runtime_resume(dev, 0);
>  }
>  
> +/**
> + * pm_request_idle - Queue up "idle check" execution for a device.
> + * @dev: Target device.
> + *
> + * Queue up a work item to run an equivalent of pm_runtime_idle() for @dev
> + * asynchronously.
> + */
>  static inline int pm_request_idle(struct device *dev)
>  {
>  	return __pm_runtime_idle(dev, RPM_ASYNC);
>  }
>  
> +/**
> + * pm_request_resume - Queue up runtime-resume of a device.
> + * @dev: Target device.
> + */
>  static inline int pm_request_resume(struct device *dev)
>  {
>  	return __pm_runtime_resume(dev, RPM_ASYNC);
>  }
>  
> +/**
> + * pm_request_autosuspend - Queue up autosuspend of a device.
> + * @dev: Target device.
> + *
> + * Queue up a work item to run an equivalent pm_runtime_autosuspend() for @dev
> + * asynchronously.
> + */
>  static inline int pm_request_autosuspend(struct device *dev)
>  {
>  	return __pm_runtime_suspend(dev, RPM_ASYNC | RPM_AUTO);
>  }
>  
> +/**
> + * pm_runtime_get - Bump up usage counter and queue up resume of a device.
> + * @dev: Target device.
> + *
> + * Bump up the runtime PM usage counter of @dev and queue up a work item to
> + * carry out runtime-resume of it.
> + */
>  static inline int pm_runtime_get(struct device *dev)
>  {
>  	return __pm_runtime_resume(dev, RPM_GET_PUT | RPM_ASYNC);
>  }
>  
> +/**
> + * pm_runtime_get_sync - Bump up usage counter of a device and resume it.
> + * @dev: Target device.
> + *
> + * Bump up the runtime PM usage counter of @dev and carry out runtime-resume of
> + * it synchronously.
> + *
> + * The possible return values of this function are the same as for
> + * pm_runtime_resume() and the runtime PM usage counter of @dev remains

I think it's fine to refer to return values of pm_runtime_resume(), but the
return values of pm_runtime_resume() are not documented above. Could you
add them?

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
