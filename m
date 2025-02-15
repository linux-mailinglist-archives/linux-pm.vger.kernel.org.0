Return-Path: <linux-pm+bounces-22152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752B0A36E76
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 14:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868B63B2505
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F71ACEC6;
	Sat, 15 Feb 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iYd+UBly"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59278F35;
	Sat, 15 Feb 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739625945; cv=none; b=pSXU/n6LHdUeKHhMDTnT3NdEc4cB3XySXc4YeOjPyTQ/FsM8R56oIiocSf9mV47M0w81eYgs3RlVnIv5ni+RBjHK0xSNvznv1fKjWA60zx4MYGWnSPMVbr73cE4sKcVnITVPcmlVjkXTIyf3gyoIHTSVW1jh7rYrjbVhy3vhjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739625945; c=relaxed/simple;
	bh=iG6VMukGPc/hgAfKcP4d3ou1L72wlxfihRu1g+yvA5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlRypw4zlQ2T90PQi1L49Dl6Nalggg3dC1gIHpPqUNntcY276sLRK8e7jnNGsERNCkt9Lc1FZXfsl/uESlafx5z9BHX1x0nnNyhmJJEo3v9++LPFQq9iPFdLIbLnfql3X2DzSnzHAiBj5K5d7AQFBP/DNPuIu0H0pltH2Xhb5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iYd+UBly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6A4C4CEDF;
	Sat, 15 Feb 2025 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739625944;
	bh=iG6VMukGPc/hgAfKcP4d3ou1L72wlxfihRu1g+yvA5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYd+UBlyE29k/KHy9iorTBKgRbEr19knJ+iMu0p5afMdDIElXB6VB8xlzO4oOP0io
	 GiEX65U4jgkx3BEhJZqQQq+U+FG3Q5PN098/Bm9PIefkShV3vM61jMWCwZ1/XwZRVM
	 nzP31WsI596lOiEWoMr+ul5CGcZLmRm/7cuJ2/ao=
Date: Sat, 15 Feb 2025 14:25:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, dakr@kernel.org, jic23@kernel.org,
	ulf.hansson@linaro.org, daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
Message-ID: <2025021539-untrained-prompter-a48f@gregkh>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>

On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
> clocks are managed through PM domains. These PM domains, registered on
> behalf of the clock controller driver, are configured with
> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
> clocks are enabled/disabled using runtime PM APIs. The power domains may
> also have power_on/power_off support implemented. After the device PM
> domain is powered off any CPU accesses to these domains leads to system
> aborts.
> 
> During probe, devices are attached to the PM domain controlling their
> clocks and power. Similarly, during removal, devices are detached from the
> PM domain.
> 
> The detachment call stack is as follows:
> 
> device_driver_detach() ->
>   device_release_driver_internal() ->
>     __device_release_driver() ->
>       device_remove() ->
>         platform_remove() ->
> 	  dev_pm_domain_detach()
> 
> During driver unbind, after the device is detached from its PM domain,
> the device_unbind_cleanup() function is called, which subsequently invokes
> devres_release_all(). This function handles devres resource cleanup.
> 
> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
> cleanup process triggers the action or reset function for disabling runtime
> PM. This function is pm_runtime_disable_action(), which leads to the
> following call stack of interest when called:
> 
> pm_runtime_disable_action() ->
>   pm_runtime_dont_use_autosuspend() ->
>     __pm_runtime_use_autosuspend() ->
>       update_autosuspend() ->
>         rpm_idle()
> 
> The rpm_idle() function attempts to resume the device at runtime. However,
> at the point it is called, the device is no longer part of a PM domain
> (which manages clocks and power states). If the driver implements its own
> runtime PM APIs for specific functionalities - such as the rzg2l_adc
> driver - while also relying on the power domain subsystem for power
> management, rpm_idle() will invoke the driver's runtime PM API. However,
> since the device is no longer part of a PM domain at this point, the PM
> domain's runtime PM APIs will not be called. This leads to system aborts on
> Renesas SoCs.
> 
> Another identified case is when a subsystem performs various cleanups
> using device_unbind_cleanup(), calling driver-specific APIs in the process.
> A known example is the thermal subsystem, which may call driver-specific
> APIs to disable the thermal device. The relevant call stack in this case
> is:
> 
> device_driver_detach() ->
>   device_release_driver_internal() ->
>     device_unbind_cleanup() ->
>       devres_release_all() ->
>         devm_thermal_of_zone_release() ->
> 	  thermal_zone_device_disable() ->
> 	    thermal_zone_device_set_mode() ->
> 	      struct thermal_zone_device_ops::change_mode()
> 
> At the moment the driver-specific change_mode() API is called, the device
> is no longer part of its PM domain. Accessing its registers without proper
> power management leads to system aborts.
> 
> Open a devres group before calling the driver probe, and close it
> immediately after the driver remove function is called and before
> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
> reset functions are executed immediately after the driver remove function
> completes. Additionally, it prevents driver-specific runtime PM APIs from
> being called when the device is no longer part of its power domain.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Hi,
> 
> Although Ulf gave its green light for the approaches on both IIO [1],
> [2] and thermal subsystems [3], Jonathan considered unacceptable the
> approaches in [1], [2] as he considered it may lead to dificult to
> maintain code and code opened to subtle bugs (due to the potential of
> mixing devres and non-devres calls). He pointed out a similar approach
> that was done for the I2C bus [4], [5].
> 
> As the discussions in [1], [2] stopped w/o a clear conclusion, this
> patch tries to revive it by proposing a similar approach that was done
> for the I2C bus.
> 
> Please let me know you input.

I'm with Jonathan here, the devres stuff is getting crazy here and you
have drivers mixing them and side affects happening and lots of
confusion.  Your change here is only going to make it even more
confusing, and shouldn't actually solve it for other busses (i.e. what
about iio devices NOT on the platform bus?)

Why can't your individual driver handle this instead?

thanks,

greg k-h

