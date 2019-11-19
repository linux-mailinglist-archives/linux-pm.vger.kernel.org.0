Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C7B102C85
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 20:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKSTZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 14:25:38 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:15149 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfKSTZi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 14:25:38 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Nov 2019 14:25:37 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574191536;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=nAQDzc44S0D7ebDb9POc/if1in8vRfNH8cRKGjIZFDA=;
        b=twfuVIfWcW8fP/AvowOr2XcJkz6tERhSKU5QuKrjc5o29NsZgRo2K3qe94d8YZvwR+
        cuN71YIbmRRcmHSZWM4uVWFEftz1smrS2Yl5mqpVWCa0NhF2PSZ8YkEhea9qZGiu4zbf
        lXwUJi+3KWyLld4guNYIhsIkxX4o4wGt79NtaHpHTXtCFRtbQ7saYaKP+Gor0UlRXuZO
        MSNbSIZJTIIEVX4iXj0fgoiUn1AtznG6eW2P7HWQGAgSQqsVsjFSaSCoYQxYGm0UjEdJ
        YC1JkzIgejqhu5q8gC5/4ChmgnHe1p7fuKImbB9uLeQYmehOAUn4R8yeOHAwTH+prPja
        tYow==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJL0fVrtcA="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAJJJXoYa
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 19 Nov 2019 20:19:33 +0100 (CET)
Date:   Tue, 19 Nov 2019 20:19:26 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: db8500: Depromote debug print
Message-ID: <20191119191926.GA910@gerhold.net>
References: <20191119074650.2664-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119074650.2664-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 19, 2019 at 08:46:50AM +0100, Linus Walleij wrote:
> We are not interested in getting this debug print on our
> console all the time.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Fixes: 6c375eccded4 ("thermal: db8500: Rewrite to be a pure OF sensor")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I noticed those as well. Thanks for the patch!

FWIW:
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/thermal/db8500_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index 372dbbaaafb8..21d4d6e6409a 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -152,8 +152,8 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
>  		db8500_thermal_update_config(th, idx, THERMAL_TREND_RAISING,
>  					     next_low, next_high);
>  
> -		dev_info(&th->tz->device,
> -			 "PRCMU set max %ld, min %ld\n", next_high, next_low);
> +		dev_dbg(&th->tz->device,
> +			"PRCMU set max %ld, min %ld\n", next_high, next_low);
>  	} else if (idx == num_points - 1)
>  		/* So we roof out 1 degree over the max point */
>  		th->interpolated_temp = db8500_thermal_points[idx] + 1;
> -- 
> 2.21.0
> 
