Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57D58948
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 19:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF0Rtv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 13:49:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41283 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfF0Rtv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 13:49:51 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 6e6e2abbf5608c5b; Thu, 27 Jun 2019 19:49:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tbroch@google.com, rajatja@google.com
Subject: Re: [PATCH] power: Do not clear events_check_enabled in pm_wakeup_pending()
Date:   Thu, 27 Jun 2019 19:49:48 +0200
Message-ID: <6609527.OrdeQrBG9Y@kreacher>
In-Reply-To: <20190619175142.237794-1-ravisadineni@chromium.org>
References: <20190619175142.237794-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, June 19, 2019 7:51:42 PM CEST Ravi Chandra Sadineni wrote:
> events_check_enabled bool is set when wakeup_count sysfs attribute
> is written. User level daemon is expected to write this attribute
> just before suspend.
> 
> When this boolean is set, calls to pm_wakeup_event() will result in
> increment of per device and global wakeup count that helps in
> identifying the wake source. global wakeup count is also used by
> pm_wakeup_pending() to identify if there are any pending events that
> should result in an suspend abort.
> 
> Currently calls to pm_wakeup_pending() also clears events_check_enabled.
> This can be a problem when there are multiple wake events or when the
> suspend is aborted due to an interrupt on a shared interrupt line.
> For example an Mfd device can create several platform devices which
> might fetch the state on resume in the driver resume method and increment
> the wakeup count if needed. But if events_check_enabled is cleared before
> resume methods get to execute, wakeup count will not be incremented. Thus
> let us not reset the bool here.
> 
> Note that events_check_enabled is also cleared in suspend.c/enter_state()
> on every resume at the end.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  drivers/base/power/wakeup.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5b2b6a05a4f3..88aade871589 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -838,7 +838,6 @@ bool pm_wakeup_pending(void)
>  
>  		split_counters(&cnt, &inpr);
>  		ret = (cnt != saved_count || inpr > 0);
> -		events_check_enabled = !ret;

This effectively changes the meaning of the wakeup_count metric. so it cannot be applied.

>  	}
>  	raw_spin_unlock_irqrestore(&events_lock, flags);
>  
> 




