Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA798912
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 03:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfHVBrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 21:47:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36684 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHVBrA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 21:47:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so2477716pgm.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 18:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RdxKL1dPvs4eqhjlv3uZAUE21ZttRHMY9QEWG6r7QBI=;
        b=jY0DRLU15rFRwyK9jVvnCLtG+SR4L9WluRqAq8IKH+nLqfK2jRJLRvEaYIQ2yYFOv2
         n2rANRGGuHTZVkLTQ6UCChtw71Zk54AkNqZeo4H5I/M7goXVIK/qTc9o1IGxL9RIvJtq
         4zZeZyPYOVTXbgRRql82X4b6IXO+tfYj4Fc0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RdxKL1dPvs4eqhjlv3uZAUE21ZttRHMY9QEWG6r7QBI=;
        b=nJkfUDoKIPYQZB1jESrzlQtZ/SPJl1uRkk5keO3SHlU7wufOqGHvSUPinv9zurc6lH
         dQDHbQVzVzGHu66t3Frv4yFYu/0vEiVea/VupwTpwPyw2wrmAR+7voHBwPIl4IVJRNzL
         ne4WL+A8179o3DOgWQjUGlAvfuc06z0ykSk96V2pF/hdlSL6EYmAC3CL9drrLMDXEsuQ
         dNrybvEz3W28NICVW3qxZXcwhVqaFUqufgzc+LiKUsYBIZerdGewpZ+IYIFka5qt/eUh
         nEW7rPN11Sx56je+jSrKPwe+ghLGfrnbZS9+j52dVQ13LAF2Zj58rX+OunufZHG4nQ0y
         yPoQ==
X-Gm-Message-State: APjAAAXKXuQEJPDjN0Ptl5tjaOvBPtzuy1m7UBjl+0WG/A5BIytCs8Ui
        oS2byDIaezBmBsLGb7q/fInNr9IkleA=
X-Google-Smtp-Source: APXvYqw62UWND7zkAXSmqnXHz3SP+ZmoQVq6Bi59XPfG53fPwpSJK4wNIvMYYgh7jUzU/r+aiZG1Zg==
X-Received: by 2002:a65:4546:: with SMTP id x6mr30995170pgr.266.1566438419522;
        Wed, 21 Aug 2019 18:46:59 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id s7sm999101pjn.28.2019.08.21.18.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 18:46:58 -0700 (PDT)
Date:   Wed, 21 Aug 2019 18:46:56 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Michael Nosthoff <committed@heine.so>
Cc:     linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: sbs-battery: only return health when
 battery present
Message-ID: <20190822014655.GA165945@google.com>
References: <20190816075842.27333-1-committed@heine.so>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816075842.27333-1-committed@heine.so>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 16, 2019 at 09:58:42AM +0200, Michael Nosthoff wrote:
> when the battery is set to sbs-mode and  no gpio detection is enabled
> "health" is always returning a value even when the battery is not present.
> All other fields return "not present".
> This leads to a scenario where the driver is constantly switching between
> "present" and "not present" state. This generates a lot of constant
> traffic on the i2c.

That depends on how often you're checking the "health" attribute,
doesn't it? But anyway, the bug is real.

> This commit changes the response of "health" to an error when the battery
> is not responding leading to a consistent "not present" state.

Ack, and thanks for the fix.

> Fixes: 76b16f4cdfb8 ("power: supply: sbs-battery: don't assume
> MANUFACTURER_DATA formats")
> 
> Signed-off-by: Michael Nosthoff <committed@heine.so>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

> ---
>  drivers/power/supply/sbs-battery.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 2e86cc1e0e35..f8d74e9f7931 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -314,17 +314,22 @@ static int sbs_get_battery_presence_and_health(
>  {
>  	int ret;
>  
> -	if (psp == POWER_SUPPLY_PROP_PRESENT) {
> -		/* Dummy command; if it succeeds, battery is present. */
> -		ret = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> -		if (ret < 0)
> -			val->intval = 0; /* battery disconnected */
> -		else
> -			val->intval = 1; /* battery present */
> -	} else { /* POWER_SUPPLY_PROP_HEALTH */
> +	/* Dummy command; if it succeeds, battery is present. */
> +	ret = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> +
> +	if (ret < 0) { /* battery not present*/
> +		if (psp == POWER_SUPPLY_PROP_PRESENT) {
> +			val->intval = 0;
> +			return 0;

Technically, you don't need the 'return 0' (and if we care about
symmetry: the TI version doesn't), since the caller knows that "not
present" will yield errors. I'm not sure which version makes more sense.

> +		}
> +		return ret;
> +	}
> +
> +	if (psp == POWER_SUPPLY_PROP_PRESENT)
> +		val->intval = 1; /* battery present */
> +	else /* POWER_SUPPLY_PROP_HEALTH */
>  		/* SBS spec doesn't have a general health command. */
>  		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
> -	}
>  
>  	return 0;
>  }
> @@ -626,6 +631,8 @@ static int sbs_get_property(struct power_supply *psy,
>  		else
>  			ret = sbs_get_battery_presence_and_health(client, psp,
>  								  val);
> +
> +		/* this can only be true if no gpio is used */
>  		if (psp == POWER_SUPPLY_PROP_PRESENT)
>  			return 0;
>  		break;
> -- 
> 2.20.1
> 
