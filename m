Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A41925CA
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 11:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgCYKhw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 06:37:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55216 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgCYKhv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 06:37:51 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9e7838f87465dcf7; Wed, 25 Mar 2020 11:37:49 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org,
        swboyd@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, irgeorgiev@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PM / wakeup: Skip wakeup_source_sysfs_remove if device is not added
Date:   Wed, 25 Mar 2020 11:37:49 +0100
Message-ID: <45310800.nJ51lTlq64@kreacher>
In-Reply-To: <1584940131-1591-1-git-send-email-neeraju@codeaurora.org>
References: <1584940131-1591-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, March 23, 2020 6:08:51 AM CET Neeraj Upadhyay wrote:
> Skip wakeup_source_sysfs_remove(), to fix null pinter access of
> ws->dev, if wakeup source is unregistered before wakeup class
> is registered from device_add().
> 
> Fixes: 2ca3d1ecb8c4 ("PM / wakeup: Register wakeup class kobj after device is added")
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  drivers/base/power/wakeup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 27f3e60..f8f8c0a 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -241,7 +241,8 @@ void wakeup_source_unregister(struct wakeup_source *ws)
>  {
>  	if (ws) {
>  		wakeup_source_remove(ws);
> -		wakeup_source_sysfs_remove(ws);
> +		if (ws->dev)
> +			wakeup_source_sysfs_remove(ws);
>  		wakeup_source_destroy(ws);
>  	}
>  }
> 

Applied (with some minor changes) as 5.7 material, thanks!



