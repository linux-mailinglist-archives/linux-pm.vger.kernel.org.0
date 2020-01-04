Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095DD1303D9
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2020 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgADSV0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 13:21:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgADSVZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Jan 2020 13:21:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B87E8222C4;
        Sat,  4 Jan 2020 18:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578162085;
        bh=OffE6GW1fEHEsKz4lJ2UtasvfPdaubXshXY9rYrJGGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFkVpF4CJX1T67ffFbREBgsanbynhohqOoCBZyn4eKk7wE3YQXY1LqUrOH1ZS85GO
         qP0fXt6AlakACLEvz6FbVhYPVOEsUVf1OQDKgA0HBLBqE7Um/QEQiMkuEB/JwsETuJ
         6fHnD1eXtpd3+0Xs3C948YuQhDcUXQfctb9GC80U=
Date:   Sat, 4 Jan 2020 19:21:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM-runtime: add tracepoints for usage_count changes
Message-ID: <20200104182123.GA1485543@kroah.com>
References: <cb199a03895f8a11d9039209e6ac1cd92b1d1fb9.1578155207.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb199a03895f8a11d9039209e6ac1cd92b1d1fb9.1578155207.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 04, 2020 at 05:27:57PM +0100, Michał Mirosław wrote:
> Add tracepoints to remaining places where device's power.usage_count
> is changed. This helps debugging where and why autosuspend is prevented.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/base/power/runtime.c | 13 +++++++++++--
>  include/trace/events/rpm.h   |  6 ++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 48616f358854..16134a69bf6f 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1006,8 +1006,10 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
>  	int retval;
>  
>  	if (rpmflags & RPM_GET_PUT) {
> -		if (!atomic_dec_and_test(&dev->power.usage_count))
> +		if (!atomic_dec_and_test(&dev->power.usage_count)) {
> +			trace_rpm_usage_rcuidle(dev, rpmflags);

Who and what is really going to use these tracepoints?

And putting them in these if statements seems odd, are you sure that's
the correct place?  What do these show to userspace?

>  			return 0;
> +		}
>  	}
>  
>  	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> @@ -1038,8 +1040,10 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
>  	int retval;
>  
>  	if (rpmflags & RPM_GET_PUT) {
> -		if (!atomic_dec_and_test(&dev->power.usage_count))
> +		if (!atomic_dec_and_test(&dev->power.usage_count)) {
> +			trace_rpm_usage_rcuidle(dev, rpmflags);
>  			return 0;
> +		}
>  	}
>  
>  	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> @@ -1101,6 +1105,7 @@ int pm_runtime_get_if_in_use(struct device *dev)
>  	retval = dev->power.disable_depth > 0 ? -EINVAL :
>  		dev->power.runtime_status == RPM_ACTIVE
>  			&& atomic_inc_not_zero(&dev->power.usage_count);
> +	trace_rpm_usage_rcuidle(dev, 0);

Why this one?


>  	spin_unlock_irqrestore(&dev->power.lock, flags);
>  	return retval;
>  }
> @@ -1434,6 +1439,8 @@ void pm_runtime_allow(struct device *dev)
>  	dev->power.runtime_auto = true;
>  	if (atomic_dec_and_test(&dev->power.usage_count))
>  		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
> +	else
> +		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);

Are you sure this is correct?

These feel odd...

thanks,

greg k-h
