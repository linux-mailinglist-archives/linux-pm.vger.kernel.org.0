Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3B3E7BAD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhHJPGN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 11:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhHJPGN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 11:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C423B60FDA;
        Tue, 10 Aug 2021 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628607951;
        bh=C6ZAVOPqfmZA7ZtDBXi1h4fWPOAurp4igkoiZMj3Rx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyM/2X2c2DWj8BU4GZX7bz8cQTZnAjjSfQT0KJH3qE0FINtOLd1k9TzYW3rA/pZor
         QzrgMxYNV3CC/vysyRI1A0KH3AVaUdhcSiIny1psfELlIWJOR03B8NOqf9l1jtJpO4
         ibl7w3MUUUecmJcwR1noEWK9vYwYk2qQed/2a99c=
Date:   Tue, 10 Aug 2021 17:05:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rjw@rjwysocki.net, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz
Subject: Re: [PATCH v2] PM: sleep: core: Avoid setting power.must_resume to
 false
Message-ID: <YRKVzD9gnigxDjEC@kroah.com>
References: <1628602932-246733-1-git-send-email-psodagud@codeaurora.org>
 <1628602932-246733-2-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628602932-246733-2-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 10, 2021 at 06:42:12AM -0700, Prasad Sodagudi wrote:
> There are variables(power.may_skip_resume and dev->power.must_resume)
> and DPM_FLAG_MAY_SKIP_RESUME flags to control the resume of devices after
> a system wide suspend transition.
> 
> Setting the DPM_FLAG_MAY_SKIP_RESUME flag means that the driver allows
> its "noirq" and "early" resume callbacks to be skipped if the device
> can be left in suspend after a system-wide transition into the working
> state. PM core determines that the driver's "noirq" and "early" resume
> callbacks should be skipped or not with dev_pm_skip_resume() function by
> checking power.may_skip_resume variable.
> 
> power.must_resume variable is getting set to false in __device_suspend()
> function without checking device's DPM_FLAG_MAY_SKIP_RESUME and
> dev->power.usage_count variables. In problematic scenario, where
> all the devices in the suspend_late stage are successful and some
> device can fail to suspend in suspend_noirq phase. So some devices
> successfully suspended in suspend_late stage are not getting chance
> to execute __device_suspend_noirq() to set dev->power.must_resume
> variable to true and not getting resumed in early_resume phase.
> 
> Add a check for device's DPM_FLAG_MAY_SKIP_RESUME flag before
> setting power.must_resume variable in __device_suspend function.
> 
> Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  drivers/base/power/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index d568772..9ee6987 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1642,7 +1642,11 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  	}
>  
>  	dev->power.may_skip_resume = true;
> -	dev->power.must_resume = false;
> +	if ((atomic_read(&dev->power.usage_count) <= 1) &&
> +	     (dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME)))
> +		dev->power.must_resume = false;
> +	else
> +		dev->power.must_resume = true;
>  
>  	dpm_watchdog_set(&wd, dev);
>  	device_lock(dev);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
