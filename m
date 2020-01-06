Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54544131873
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 20:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgAFTPC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 14:15:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40332 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgAFTPC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 14:15:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id s21so19459290plr.7
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 11:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GFwzTDfVSEsQlAMMcJbbQMcZerRfZ61wXIEvCkNUZdQ=;
        b=s9VOlBQnwNsApUHOQQ2PUWXHKhgrwqrmhv8WBjlrxXSF27zy+XeWF/hA6zXnaatq0l
         EVDNxLaF77qE9ebp+sEHfaS2d3stCllbQouOS8kipKrzF+/8iS2kFvsNodIiujx7Y3aC
         yZK5gq0y5gtU5NA6PdJ6IM4YDylADfIzFCNmjPU8IGzyzndZhP1OBF+Sk5Vsm50KHwfz
         Yjv9yIKAUl3tsnTB5FPV9EmFZR7cYeoZZhChIWReipv8C5/c3Ido6yZKa1xH3q+Y1fqM
         Ewao0SzZ3Iy1XQw+t7y+5UlkZLf9dB8ZamsB+eh4To0t1SbVWIwVS4REjkxXbwO01/Hc
         fGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GFwzTDfVSEsQlAMMcJbbQMcZerRfZ61wXIEvCkNUZdQ=;
        b=fr34TlmxSvsCp+aP6+DLMJHyyTwWnYpOj0znpPBT31DkmgksEDUTnBSaMrfCRXw8u9
         ybKNVOLFkHolyttTTx6y7AEyUKp4Mm50Lg7+XoecX6wj6EQu9+3+ZxJGuxTxDpPghQdN
         GDt0uERsQoovLlE7L6vdN0HT7ah7eyFNSxgUpuGS6JC1c2Kwb7idgvVmTASEXAhl/lMa
         a+OJeU368T24vNRB7+6WqhCyfaaY1f+75xDPaANAlzZPye5oV+3mntsE9v0/bzba0AIO
         v+XfvG3PbSweVqfS6tAGfwoPM5OjOx8jTtnva7IGdESTFwMwSxYHOnWaRkJwQNOOkQ1l
         3Ccw==
X-Gm-Message-State: APjAAAUEqfuS40VNy9696avxafqA5sStnYaJLWVr8BJOSbR2My7V0Rxl
        lIY2m08stUu/2Pk6h8hFCzZ/iA==
X-Google-Smtp-Source: APXvYqxa4AUZrWKk56M6JY/TJLxdtIqbX+Uo+ysj7McsHKpTpJ2onOc3GwFjpLOQcKAu1t9I6vxC0Q==
X-Received: by 2002:a17:902:b788:: with SMTP id e8mr109469537pls.1.1578338101538;
        Mon, 06 Jan 2020 11:15:01 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i2sm71718552pgi.94.2020.01.06.11.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:15:00 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:14:58 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: avs: fix uninitialized error return on
 failed cpr_read_fuse_uV call
Message-ID: <20200106191458.GV3755841@builder>
References: <20200106120558.37758-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106120558.37758-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 06 Jan 04:05 PST 2020, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call cpr_read_fuse_uV returns an error the value in the
> uninitialized variable ret is returned. Fix this by instread returning the
> error value in the variable uV.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/avs/qcom-cpr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> index 9247f53550b3..0321729431a5 100644
> --- a/drivers/power/avs/qcom-cpr.c
> +++ b/drivers/power/avs/qcom-cpr.c
> @@ -922,7 +922,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
>  		uV = cpr_read_fuse_uV(desc, fdata, fuses->init_voltage,
>  				      step_volt, drv);
>  		if (uV < 0)
> -			return ret;
> +			return uV;
>  
>  		fuse->min_uV = fdata->min_uV;
>  		fuse->max_uV = fdata->max_uV;
> -- 
> 2.24.0
> 
