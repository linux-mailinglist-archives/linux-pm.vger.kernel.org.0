Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849753EB153
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 09:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhHMHYG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 03:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238787AbhHMHYF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Aug 2021 03:24:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E53056103E;
        Fri, 13 Aug 2021 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628839419;
        bh=Op1DPt7UoLm4Jfz2g7mIQzK9pON5ZGq4qTreOrFk/m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsaIxPhhom0jQ/AqNnv8daSMfvwEbIbS0HThsquNyVmdxm8oUoZTxtMHGUQoLJ++A
         hX+mkdfu9o7cOfCnI3k8Wx1xoS3fJA4ONUKxHCi7H8r9xKLYzmWx6dnxcZ1R/ktW14
         yGBYJpCAUGVW9UsoppIsrK8Y05cGRB+cxvWbB8rs=
Date:   Fri, 13 Aug 2021 09:23:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rjw@rjwysocki.net, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz
Subject: Re: [PATCH v3] PM: sleep: core: Avoid setting power.must_resume to
 false
Message-ID: <YRYd+dSdWa7Mr+n9@kroah.com>
References: <1628625938-149376-1-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628625938-149376-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 10, 2021 at 01:05:38PM -0700, Prasad Sodagudi wrote:
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
>  V2 -> V3: Format issues patch posting
>  V1 -> V2: Fixed indentation and commit text to include scenario
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

Again, what happens if the usage_count changes right after reading the
value?  What protects that from happening?

thanks,

greg k-h
