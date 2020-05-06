Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678891C702C
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgEFMUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 08:20:23 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:32216 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFMUX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 May 2020 08:20:23 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49HFzT23TZz5r;
        Wed,  6 May 2020 14:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588767621; bh=00xim0fFXyQsLgYT9jxI76ylXaBQliYZoWOKhrPGYRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPuVxYu7WDNPubvXe6Or5+7OMjMqfgFHo57eSQnaIHK3JrKwyzlic1BCuI2viKe2R
         Kjx1Ss9Q91P/cD8mfyQzjGy7nZWM65CUYyOvkS5M4KCNgjxxwKXCvBWMfHAtD2obM6
         qK9YtLNSGnid3UPBVRLQo1hyeMmrFImcqyuOK+Ru0yqnouB1g+pNwyzKw8ND8o5jWp
         HTnI4+7sxE8iMzV902hDG2dAzehEYBzkLkkFq4efYwKtX3c/JvJRozh7UaYihwXP02
         1dVSCX9DRNnYMWp7Bn46sGrY0bWY/rrn3S+SE6+otB1GIQmoh5k6KCYgMtxtLZCKIK
         p72+dZOHUUcbQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 6 May 2020 14:20:20 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: bq25890: unlock on error paths in bq25890_resume()
Message-ID: <20200506122019.GB18376@qmqm.qmqm.pl>
References: <20200506101116.GA77004@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506101116.GA77004@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 06, 2020 at 01:11:16PM +0300, Dan Carpenter wrote:
> We introduced some new locking here, but need to update the error
> paths so they unlock before returning.

Reviewed-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>


> Fixes: 72d9cd9cdc18 ("power: bq25890: protect view of the chip's state")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 9339e216651ff..20b9824ef5acd 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -978,21 +978,22 @@ static int bq25890_resume(struct device *dev)
>  
>  	ret = bq25890_get_chip_state(bq, &bq->state);
>  	if (ret < 0)
> -		return ret;
> +		goto unlock;
>  
>  	/* Re-enable ADC only if charger is plugged in. */
>  	if (bq->state.online) {
>  		ret = bq25890_field_write(bq, F_CONV_START, 1);
>  		if (ret < 0)
> -			return ret;
> +			goto unlock;
>  	}
>  
>  	/* signal userspace, maybe state changed while suspended */
>  	power_supply_changed(bq->charger);
>  
> +unlock:
>  	mutex_unlock(&bq->lock);
>  
> -	return 0;
> +	return ret;
>  }
>  #endif
>  
> -- 
> 2.26.2
> 
