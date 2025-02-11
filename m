Return-Path: <linux-pm+bounces-21775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617BCA303C2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 07:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDDD3A608A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 06:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D41D79A6;
	Tue, 11 Feb 2025 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQQngsmA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9926BD90;
	Tue, 11 Feb 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739256287; cv=none; b=HjOeEuj5bO6294EkWgZGEp8HKkx53AEJ8ZlhMPLOFadjESCQDTDvr+ALq2lK8Fw1FW4xjMWYmdotVQfYgR/9h83V+NYlJor/GLN+hnpcNbWAKpX2azlF008snoJZGV3Kv4LZM6RspaSQuXIwOWzPxynRKoKNe90ijBhYBSvQAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739256287; c=relaxed/simple;
	bh=NCyVfDIX0SRvprF8hupDS+zjKAdjMv9UmBS8H7XYoeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSAZZEFS6WhoHfPItGggPC6h6GWkk85q0lsNZMVsPQa4RQLNOX7hfumhAcJ5tYPyVZikNcm+RkNhZcpNR3Asf6/daOCIxoiytggVlqOU488clYlqzKStapNOyzWr2+g86CdSGk3FwdXUPN2KILqII4t+6AJYe1HuZJ5lwLzco6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQQngsmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6F8C4CEDD;
	Tue, 11 Feb 2025 06:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739256286;
	bh=NCyVfDIX0SRvprF8hupDS+zjKAdjMv9UmBS8H7XYoeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQQngsmAAbS4lLB3FmvvAzOT+VP8iRabAq8ygVgtDGhRRPDNK+N1nfH51QWZCWz6f
	 ri+KV1UcTN0ZKTei48OszF6wuL15E+uIv8ht5B4WLQttxBMC3GlVl1H5KzdXfaTFJe
	 TDOG6tPmrotnodYJLIwT4ocVqnWQdVchm3+z5uxI=
Date: Tue, 11 Feb 2025 07:43:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
	dakr@kernel.org, stern@rowland.harvard.edu,
	linux-pm@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] PM: sleep: core: Set is_prepared to false before
 checking direct_complete
Message-ID: <2025021127-cofounder-spinning-ba7d@gregkh>
References: <20250211034423.833783-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211034423.833783-1-xu.yang_2@nxp.com>

On Tue, Feb 11, 2025 at 11:44:23AM +0800, Xu Yang wrote:
> Currently, if power.no_callbacks is true for a device, device_prepare()
> will also set power.direct_complete to true. When device_resume() check
> power.direct_complete, setting power.is_prepared will be skipped if it
> can directly complete. This will cause a warning when add new devices
> during resume() stage.
> 
> Although power.is_prepared should be cleared in complete() state, commit
> (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
> clear it in earlier resume() stage. However, we need set is_prepared to
> false before checking direct_complete after including direct complete
> support.
> 
> Take USB as example:
> The usb_interface is such a device which setting power.no_callbacks to
> true. Then if the user call usb_set_interface() during resume() stage,
> the kernel will print below warning since the system will create and
> add ep devices.
> 
> [  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_hdrc
> [  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
> [  187.105010] PM: resume devices took 0.936 seconds
> 
> Fixes: aae4518b3124 ("PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily")
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/base/power/main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 40e1d8d8a589..69d0f9ca7051 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -929,6 +929,12 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
>  	if (dev->power.syscore)
>  		goto Complete;
>  
> +	/*
> +	 * This is a fib.  But we'll allow new children to be added below
> +	 * a resumed device, even if the device hasn't been completed yet.
> +	 */
> +	dev->power.is_prepared = false;
> +
>  	if (dev->power.direct_complete) {
>  		/* Match the pm_runtime_disable() in device_suspend(). */
>  		pm_runtime_enable(dev);
> @@ -941,12 +947,6 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
>  	dpm_watchdog_set(&wd, dev);
>  	device_lock(dev);
>  
> -	/*
> -	 * This is a fib.  But we'll allow new children to be added below
> -	 * a resumed device, even if the device hasn't been completed yet.
> -	 */
> -	dev->power.is_prepared = false;
> -
>  	if (!dev->power.is_suspended)
>  		goto Unlock;
>  
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

