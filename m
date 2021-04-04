Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1011535372C
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 09:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhDDHVz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 03:21:55 -0400
Received: from muru.com ([72.249.23.125]:50606 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhDDHVy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Apr 2021 03:21:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 54A6B804D;
        Sun,  4 Apr 2021 07:22:56 +0000 (UTC)
Date:   Sun, 4 Apr 2021 10:21:46 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] power: supply: cpcap-charger: Add usleep to cpcap
 charger to avoid usb plug bounce
Message-ID: <YGlpCr26qU6F/Uwl@atomide.com>
References: <20210117224853.3602368391c9785e74748239@uvos.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117224853.3602368391c9785e74748239@uvos.xyz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Carl Philipp Klemm <philipp@uvos.xyz> [210117 23:48]:
> Adds 80000 us sleep when the usb cable is plugged in to hopefully avoid
> bouncing contacts.
> 
> Upon pluging in the usb cable vbus will bounce for some time, causing cpcap to
> dissconnect charging due to detecting an undervoltage condition. This is a
> scope of vbus on xt894 while quickly inserting the usb cable with firm force,
> probed at the far side of the usb socket and vbus loaded with approx 1k:
> http://uvos.xyz/maserati/usbplug.jpg.
> 
> As can clearly be seen, vbus is all over the place for the first 15 ms or so
> with a small blip at ~40 ms this causes the cpcap to trip up and disable
> charging again.
> 
> The delay helps cpcap_usb_detect avoid the worst of this. It is, however, still
> not ideal as strong vibrations can cause the issue to reapear any time during
> charging. I have however not been able to cause the device to stop charging due
> to this in practice as it is hard to vibrate the device such that the vbus pins
> start bouncing again but cpcap_usb_detect is not called again due to a detected
> disconnect/reconnect event.
> 
> Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>

This patch fixes an issue where connecting a charger often fails for me:

Tested-by: Tony Lindgren <tony@atomide.com>


> ---
>  drivers/power/supply/cpcap-charger.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
> index be7d1da7a5a5..3e5fbdbdd645 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -650,6 +650,9 @@ static void cpcap_usb_detect(struct work_struct *work)
>  		return;
>  	}
>  
> +	/* Delay for 80ms to avoid vbus bouncing when usb cable is plugged in */
> +	usleep_range(80000, 120000);
> +
>  	/* Throttle chrgcurr2 interrupt for charger done and retry */
>  	switch (ddata->status) {
>  	case POWER_SUPPLY_STATUS_CHARGING:
> -- 
> 2.29.2
> 
