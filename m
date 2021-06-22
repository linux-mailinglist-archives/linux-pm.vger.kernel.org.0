Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B813B05B6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFVNWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 09:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhFVNWF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Jun 2021 09:22:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58EF561002;
        Tue, 22 Jun 2021 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624367989;
        bh=aNJwvphEwnfCtNAE71J4L94BMKp7pifcEHe8Gw+0fTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eq6lqzQX1Z33N5mBc4qYQawgdwCsxDQHfMUzAwbYN9bld1rySQKR/CbSNHPxhhjme
         RDISXluPPbXGUAXbb7RZXWo3YK6BfhHlOp95xEQFryq1hFh2oH+CP/C3qiWmgEcdWq
         +rhwqWXwls2/vbfx7iA7CyEm6zAoXCzHS2/Chi5U=
Date:   Tue, 22 Jun 2021 15:19:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pingshuo <pingshuo@uniontech.com>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hibernation:stop resume screen during hibernation
Message-ID: <YNHjcuSwxb4713gK@kroah.com>
References: <20210622124547.28317-1-pingshuo@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622124547.28317-1-pingshuo@uniontech.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 08:45:47PM +0800, pingshuo wrote:
> The display will be woken up during hibernation.
> if the computer equipment is poor, it will cause the screen to flicker.
> Skip to reusme the display devices in "thaw".
> 
> Signed-off-by: pingshuo <pingshuo@uniontech.com>
> ---
>  drivers/base/power/main.c | 43 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index f893c3c5af07..f3e92ac7b4b3 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -35,11 +35,14 @@
>  #include <linux/cpuidle.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
> +#include <linux/pci.h>

That right there is a clue that perhaps this is not the place to be
making this change.

Please do this in the driver for the specific device, you do not want to
do this in the driver core for every individual device type.

Also be more careful, your change here:

> @@ -737,6 +778,8 @@ static void dpm_noirq_resume_devices(pm_message_t state)
>  	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
>  }
>  
> +
> +
>  /**
>   * dpm_resume_noirq - Execute "noirq resume" callbacks for all devices.
>   * @state: PM transition of the system being carried out.

Was not needed at all.

thanks,

greg k-h
