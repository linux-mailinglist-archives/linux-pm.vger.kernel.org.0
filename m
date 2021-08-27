Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F273F968B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 10:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbhH0I7B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 04:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232757AbhH0I6y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Aug 2021 04:58:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2120A608FE;
        Fri, 27 Aug 2021 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630054685;
        bh=77yL8U8+buC1Srr5lcXcqgg1GZ5TiZMsD9z6Pe25ohA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTvx7NUb9j2WXBbHdWdpnh2el917e6I0ArcOvvSYF8r1z0T0HXm6sZIewdkoJR6LL
         HSJWk6TB5jjO8Xkvr+BYQNG28Zim2EMSHT2eMy/BR1uoWG7ks9FAtuFYrncU9lbySe
         4oKkWzKTSxfmoUalOhYOB9mNN2tBYcEn7vZdgxhQ=
Date:   Fri, 27 Aug 2021 10:57:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prasad Sodagudi <psodagud@codeaurora.org>, rjw@rjwysocki.net
Cc:     len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH v4] PM: sleep: core: Avoid setting power.must_resume to
 false
Message-ID: <YSipF4KG130rw9lc@kroah.com>
References: <1629732470-155444-1-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629732470-155444-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 23, 2021 at 08:27:50AM -0700, Prasad Sodagudi wrote:
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
> function without checking device's DPM_FLAG_MAY_SKIP_RESUME settings.
> In problematic scenario, where all the devices in the suspend_late
> stage are successful and some device can fail to suspend in
> suspend_noirq phase. So some devices successfully suspended in suspend_late
> stage are not getting chance to execute __device_suspend_noirq()
> to set dev->power.must_resume variable to true and not getting
> resumed in early_resume phase.
> 
> Add a check for device's DPM_FLAG_MAY_SKIP_RESUME flag before
> setting power.must_resume variable in __device_suspend function.
> 
> Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  V3 -> V4: Remove dev->power.usage_count variable check
>  V2 -> V3: Format issues patch posting
>  V1 -> V2: Fixed indentation and commit text to include scenario
>  drivers/base/power/main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index d568772..50e8ea3 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1642,7 +1642,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  	}
>  
>  	dev->power.may_skip_resume = true;
> -	dev->power.must_resume = false;
> +	if (dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME))
> +		dev->power.must_resume = false;
> +	else
> +		dev->power.must_resume = true;
>  
>  	dpm_watchdog_set(&wd, dev);
>  	device_lock(dev);

Seems sane, Rafael, any comments?

thanks,

greg k-h
