Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF98D29530E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 21:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409794AbgJUTnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409780AbgJUTnA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 15:43:00 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DDDC0613D2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 12:43:00 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l28so4573887lfp.10
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y84p6tfQj5a5ufC8cVAYYecBEzVsSbhLXjpiNjIVQbQ=;
        b=MfyZo6Or8kl6lV16zl9GfMos/tof+E3Zn3bakSOq9Tb7OStRvHEzNwAiG55wyV05y2
         Fz3XC5t3tV1VDRDA0a3zvEBJP9eKAnBbN/1bPG2tr3ZQRqw5ZaLuWDcleI9zjBRx16Vq
         bsEsHp//RVAUbkYuFG6d4uDa82fs3sLv+O0O+vVGkSYDGz8WeKVqzar66LnU8CFrzc2z
         ibmKyLRuwChKcpzoi/5c5QQYG/FMRATcoA2nnD7vlPlC/feDJAEniIWJGsTtSFkDt+Za
         ijyZgqUuGM8JisvtDlTNz7gqmY6N2S0W2JKs9Gt3VM0qU74JPMQ88JLneYWVuVtGb4Fk
         vctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y84p6tfQj5a5ufC8cVAYYecBEzVsSbhLXjpiNjIVQbQ=;
        b=PH5zM5rScC/NWXCcT6wwxhnLiAAjiWGa1Jkm+BhzYIxahvmguGNqb6E/OKLGeT0JQJ
         umt3/mKUEl+l6iMEN5G6dgItu4JGFSYspaT/esCYNYJtYI2euory3DVJzhzmRYGKNU9t
         fJmmIiXESES+evG8CtibsTJ1Af1IOvGoZjDfxO7+cBHuDKWKTUa1if7oSJ4PhF1ezpRB
         YfdfQGZgWCwiK6DNug1FZf7xQwIJpKn46pVCyU4xaLU85awZqYqUhcgdVLKhejY5OSq4
         3h9FTEg46bdkTTNe1A77WosnTyS2CzNG3tUKPT20RsWPqjq6VwdosrxY645UEslIpeuS
         LLhw==
X-Gm-Message-State: AOAM533zGY+q9FfJarYdcHMueKXebElU6b/U75dN92kXIvR3gaHY5JVC
        q4sr6XpTdHkx+nVji493AylzAg==
X-Google-Smtp-Source: ABdhPJzZiQXKD29K8yjK+gf68pdWVoqABf52guyMOgucOEfOY+MwhLpz2ehLBTkBKz41U4RwuW/HnA==
X-Received: by 2002:a19:4ac8:: with SMTP id x191mr1655063lfa.155.1603309378893;
        Wed, 21 Oct 2020 12:42:58 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id f129sm527344lfd.201.2020.10.21.12.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:42:57 -0700 (PDT)
Date:   Wed, 21 Oct 2020 21:42:57 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: replace spin_lock_irqsave by spin_lock in hard
 IRQ
Message-ID: <20201021194257.GC2158081@oden.dyn.berto.se>
References: <1603249530-25218-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1603249530-25218-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tian,

Thanks for your work.

On 2020-10-21 11:05:30 +0800, Tian Tao wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_thermal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 5c2a13b..6ae757d 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -409,16 +409,15 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
>  {
>  	struct rcar_thermal_common *common = data;
>  	struct rcar_thermal_priv *priv;
> -	unsigned long flags;
>  	u32 status, mask;
>  
> -	spin_lock_irqsave(&common->lock, flags);
> +	spin_lock(&common->lock);
>  
>  	mask	= rcar_thermal_common_read(common, INTMSK);
>  	status	= rcar_thermal_common_read(common, STR);
>  	rcar_thermal_common_write(common, STR, 0x000F0F0F & mask);
>  
> -	spin_unlock_irqrestore(&common->lock, flags);
> +	spin_unlock(&common->lock);
>  
>  	status = status & ~mask;
>  
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
