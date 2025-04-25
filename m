Return-Path: <linux-pm+bounces-26235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA740A9CF50
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B2A7ADE71
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0501DE3CA;
	Fri, 25 Apr 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GVXmDSBR"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C91DE3C1
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601271; cv=none; b=ZwdCl0R2nSlNjq+VWRJ+QuXUWZRr4jdZdQLFtRcuDd5xJYjzfe28L7lsP4QeKVGszC99KzfA4qMCwkwLYhMlbJTfTH6gm2f1oQ1RAn3aswtDn29E4M5aUGpQIdXJ5o/7uUUjZQUhPxFtVlYDGPOPP9iyZMh8ZiCpaDYkDaf3m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601271; c=relaxed/simple;
	bh=xDbZxDJFIusrxmYrFN1b3l22rU68GRLxUNx+mEoirpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqJd0QuLHjf2RIAu7gF2eqaw2h0UsOL0ZZ7hNwpAcVOfM1JsE+Jdghc6L9LATYxrs4xeyGYKlTevhf5VpL004Td6hfBGgmCcc9PFM5Y0Y1iGdJNQ/6LfWii7D/1tDusNwojOCcLq4OkrEPfsL3uIB+r16ht+XYyubMABWiw6DiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GVXmDSBR; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <30acf520-c137-4b49-8b69-08e35a7c5969@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745601266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6DLrO2Q4qtiuClsf/uksu1pDJHL8/bIE28qq6F3Ww8=;
	b=GVXmDSBR2LHpVPi6b1jnBFxkF36uUD+nMcIboY+dU7GzwAeXHQDoCfFtrr64hfKLtb4jYy
	Y/MVZkZGnhJuR1FsXwR/+hQ1bK1No/cJUoMn7zmXiWAFpWWTwOx8e8PcfFnmhsdnvKDiUg
	/Ers0GDCF7imvS/NqytOaImsrtGleRw=
Date: Fri, 25 Apr 2025 19:12:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] soundwire: intel_auxdevice: Fix system suspend/resume
 handling
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-sound@vger.kernel.org
References: <5891540.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <5891540.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 20:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The code in intel_suspend() and intel_resume() needs to be properly
> synchronized with runtime PM which is not the case currently, so fix
> it.
> 
> First of all, prevent runtime PM from triggering after intel_suspend()
> has started because the changes made by it to the device might be
> undone by a runtime resume of the device.  For this purpose, add a
> pm_runtime_disable() call to intel_suspend().

Allow me to push back on this, because we have to be very careful with a hidden state transition that needs to happen.

If a controller was suspended by pm_runtime, it will enter the clock stop mode.

If the system needs to suspend, the controller has to be forced to exit the clock stop mode and the bus has to restart before we can suspend it, and that's why we had those pm_runtime_resume().

Disabling pm_runtime when entering system suspend would be problematic for Intel hardware, it's a known can of worms.

It's quite possible that some of the code in intel_suspend() is no longer required because the .prepare will resume the bus properly, but I wanted to make sure this state transition out of clock-stop is known and taken into consideration.

Bard, is this a configuration you've tested?
 
> Next, once runtime PM has been disabled, the runtime PM status of the
> device cannot change, so pm_runtime_status_suspended() can be used
> instead of pm_runtime_suspended() in intel_suspend().
> 
> Moreover, checking the runtime PM status of the device in intel_resume()
> is pointless because the device is going to be resumed anyway and the
> code running in the case when the pm_runtime_suspended() check in
> intel_resume() returns 'true' is harmful.  Namely, calling
> pm_runtime_resume() right after pm_runtime_set_active() has no effect
> and calling pm_runtime_idle() on the device at that point is invalid
> because the device is technically still suspended (it has not been
> resumed yet).  Remove that code altogether along with the check leading
> to it.
> 
> Finally, call pm_runtime_set_active() at the end intel_resume() to set
> the runtime PM status of the device to "active" because it has just been
> resumed and re-enable runtime PM for it after that.



> Additionally, drop the setting of DPM_FLAG_SMART_SUSPEND from the
> driver because it has never been necessary and should not have been
> done.

IIRC it was your recommendation to add this flag many moons ago... No issue to remove it, it's just not something any of the 'SoundWire' folks are knowledgeable with.

> This addresses a functional regression after commit bca84a7b93fd ("PM:
> sleep: Use DPM_FLAG_SMART_SUSPEND conditionally") that effectively
> caused the fatal pm_runtime_suspended() check in intel_resume() to
> trigger.
> 
> Fixes: bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally")
> Cc: 6.2+ <stable@vger.kernel.org> # 6.2+
> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This change fixes an issue predating commit bca84a7b93fd that simply
> uncovered the problem and it needs to be backported to 6.2 and later
> kernels.
> 
> Since it fixes a recent regression in 6.15-rc, I can route it through the
> PM tree unless that would be a major concern.
> 
> ---
>  drivers/soundwire/intel_auxdevice.c |   36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> --- a/drivers/soundwire/intel_auxdevice.c
> +++ b/drivers/soundwire/intel_auxdevice.c
> @@ -353,9 +353,6 @@
>  	/* use generic bandwidth allocation algorithm */
>  	sdw->cdns.bus.compute_params = sdw_compute_params;
>  
> -	/* avoid resuming from pm_runtime suspend if it's not required */
> -	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
> -
>  	ret = sdw_bus_master_add(bus, dev, dev->fwnode);
>  	if (ret) {
>  		dev_err(dev, "sdw_bus_master_add fail: %d\n", ret);
> @@ -640,7 +637,10 @@
>  		return 0;
>  	}
>  
> -	if (pm_runtime_suspended(dev)) {
> +	/* Prevent runtime PM from racing with the code below. */
> +	pm_runtime_disable(dev);
> +
> +	if (pm_runtime_status_suspended(dev)) {
>  		dev_dbg(dev, "pm_runtime status: suspended\n");
>  
>  		clock_stop_quirks = sdw->link_res->clock_stop_quirks;
> @@ -648,7 +648,7 @@
>  		if ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) ||
>  		    !clock_stop_quirks) {
>  
> -			if (pm_runtime_suspended(dev->parent)) {
> +			if (pm_runtime_status_suspended(dev->parent)) {
>  				/*
>  				 * paranoia check: this should not happen with the .prepare
>  				 * resume to full power
> @@ -715,7 +715,6 @@
>  	struct sdw_cdns *cdns = dev_get_drvdata(dev);
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
>  	struct sdw_bus *bus = &cdns->bus;
> -	int link_flags;
>  	int ret;
>  
>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
> @@ -724,23 +723,6 @@
>  		return 0;
>  	}
>  
> -	if (pm_runtime_suspended(dev)) {
> -		dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
> -
> -		/* follow required sequence from runtime_pm.rst */
> -		pm_runtime_disable(dev);
> -		pm_runtime_set_active(dev);
> -		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_enable(dev);
> -
> -		pm_runtime_resume(bus->dev);
> -
> -		link_flags = md_flags >> (bus->link_id * 8);
> -
> -		if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
> -			pm_runtime_idle(dev);
> -	}
> -
>  	ret = sdw_intel_link_power_up(sdw);
>  	if (ret) {
>  		dev_err(dev, "%s failed: %d\n", __func__, ret);
> @@ -761,6 +743,14 @@
>  	}
>  
>  	/*
> +	 * Runtime PM has been disabled in intel_suspend(), so set the status
> +	 * to active because the device has just been resumed and re-enable
> +	 * runtime PM.
> +	 */
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	/*
>  	 * after system resume, the pm_runtime suspend() may kick in
>  	 * during the enumeration, before any children device force the
>  	 * master device to remain active.  Using pm_runtime_get()
> 
> 
> 


