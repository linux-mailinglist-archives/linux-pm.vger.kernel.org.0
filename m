Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E35213C270
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 14:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAONRS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 08:17:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42155 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAONRR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 08:17:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so15638032wro.9
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 05:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=47hCYL70WTpNP7Akm85PDFCwata8ahjVYsDrpIntcWE=;
        b=qd3uTQ1T83OFbtoQnVV+IV6ZDGMFyymqNr2oMcSseX8vVi9cSJmW0PHP8p+cbBFgfK
         Tlq2asGySjyuBzsuUkt2TasDhsjLfiqNQhuEi2VLGS16rMUCjkUSXSFLuQoibjvYGiUx
         nBei54/f75wpBdRDYfEO+ynfxHfGHe+cq8Y8uoNL1TEenlD3tFpzGCXzTZmiag6pmDCP
         DMxoMqEMj5afTYj8SxvrocJXVKcjzjykiiDHqbHhtqTpoLJjlZefH1SYociI33bcUjaF
         EKKjRC5NwViCk2yYRcxSDTby03wquDHmr3eGKoChnpWIC3r8pv46t3WAL0x8je6rSU+r
         oHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=47hCYL70WTpNP7Akm85PDFCwata8ahjVYsDrpIntcWE=;
        b=mjdI/Ha/km4VRVymesrb5wVcWockXY9pfDoON8A7vaHBgV/d9q1oOp3NpQ3ZN8GYdn
         9pLauyIc5K64+wXgMp2ZxgnTnvPY7w4yXSEfYcM5hpJ3O6+eIcst9uWaLX8aOJZiQjzH
         qSHavxYQjIrI455NXc2v3t1gp+WvoOCwGrgk4J3wpzGPj2xwW7Qc5G5V4UzbULkulNxi
         PdUOTlABbxz6HLUFcYHHCJ1goUCpEiSYCoRYJqlfMwrQ9gMaS8fuxHy1o3xJuB3LseW0
         Axs1hYZ7U2U4h/tI3PXU/T79IMd+g3dq2BAiWJmuL3uqfQyiUVJrEa0vOZoyjkcfozJq
         wT+g==
X-Gm-Message-State: APjAAAXAuPaalaz96FoMMGyDK4m43YJDbFgbUjv1OpHi5sT6USkUul5g
        tKgyI9g+W5kCyTrobeJNoVm+Pg==
X-Google-Smtp-Source: APXvYqzGkd7OWJa2tDkeMu9YeeEjZwvNadbTG5GzFgmm/KAxBLlFoPbgA7VGXtyC0jQmxltswYp7nA==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr28994855wrt.381.1579094235856;
        Wed, 15 Jan 2020 05:17:15 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ac8b:fcee:b80:ebae? ([2a01:e34:ed2f:f020:ac8b:fcee:b80:ebae])
        by smtp.googlemail.com with ESMTPSA id w13sm24302200wru.38.2020.01.15.05.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 05:17:15 -0800 (PST)
Subject: Re: [PATCH] thermal: rcar_thermal: Use usleep_range() instead of
 udelay()
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20200115125417.5263-1-geert+renesas@glider.be>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <09365ed8-6fcc-cd9a-c2b7-2e12a2a12017@linaro.org>
Date:   Wed, 15 Jan 2020 14:17:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115125417.5263-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/01/2020 13:54, Geert Uytterhoeven wrote:
> rcar_thermal_update_temp() takes a mutex, so it is always called in a
> context that can sleep.  Hence replace the 300 µs busy loop by a call to
> usleep_range(), to allow other threads to run.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/thermal/rcar_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index d0873de718da9218..a8dd96d2d24c4ce5 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -219,7 +219,7 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
>  		 * to get stable temperature.
>  		 * see "Usage Notes" on datasheet
>  		 */
> -		udelay(300);
> +		usleep_range(300, 400);
>  
>  		new = rcar_thermal_read(priv, THSSR) & CTEMP;
>  		if (new == old) {
> 

Applied to the testing branch. If there is no problem it will be merged
to the linux-next branch.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

