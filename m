Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C4D3DF3C4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhHCRRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 13:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237782AbhHCRRI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 13:17:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4E6A6024A;
        Tue,  3 Aug 2021 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628011016;
        bh=BAMrNVzMZWAInL5hwQzL8TACoUeg0SZlB6RB2hYEniU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiibfRJwiE4CRoYlkKKwCDzkyTl9k+CKMqkkqf/qq0EN7GiJ6cex1FBxaNBVc4pmn
         3+yw/+pWoex3nK6vK+KhbfqJBuIwJmBAohrM1pU764qoyq2c0pkL3hMH3C7og5nUFX
         s2GBCXBvQw9mEd+xj6yNcUZF++3c2oqWfRymvAWQ=
Date:   Tue, 3 Aug 2021 19:16:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: sleep: core: Avoid setting power.must_resume to false
Message-ID: <YQl6Bnjrnypbsz/s@kroah.com>
References: <1627313074-436260-1-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627313074-436260-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 26, 2021 at 08:24:34AM -0700, Prasad Sodagudi wrote:
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
> dev->power.usage_count variables. This is leading to failure to call
> resume handler for some of the devices suspended in early suspend phase.
> So check device's DPM_FLAG_MAY_SKIP_RESUME flag before
> setting power.must_resume variable.
> 
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  drivers/base/power/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index d568772..8eebc4d 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1642,7 +1642,11 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  	}
>  
>  	dev->power.may_skip_resume = true;
> -	dev->power.must_resume = false;
> +	if ((atomic_read(&dev->power.usage_count) <= 1) &&
> +			(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME)))

What is preventing that atomic value from changing _right_ after you
just read this?

and very odd indentation, checkpatch didn't complain about this?

What commit does this fix?  Does it need to be backported to older
kernels?

Wait, how is your "noirq" device even getting called here?  Shouldn't
__device_suspend_noirq() be called instead?  Why isn't that the path for
your device?

thanks,

greg k-h
