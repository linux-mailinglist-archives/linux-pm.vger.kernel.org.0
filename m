Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BFD1DEC0F
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgEVPgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgEVPgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 11:36:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C983C08C5C0
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 08:36:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so10244274wmu.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qO//5STrxgCU0oKi08sL7FpWxjHQ0iLeOfPsLNCOOZ8=;
        b=X4mrlj2e0WLmcGe/Ul79eRybo7mfJ/zxXq3t98QPMOzuRrsCG1ErAiK5oRaplnTt/N
         NkqskvRtT/mvacSW80iJRo0WfcusZWQTYCRG8TfxDfPWmaVhSadqf/xR371SrYkZN5vE
         B2F3gLC2M5zEsFtS2KK52DicNOVGvFFL6dJp+F3PUPi1bnJNYA1Bxfqdn2CjmB93Kn0t
         olyDt7OUcrTj0Onr9GqFPtAPWTLF40VCyRzqSWbCTKpkqCmkbu7jbHLsUJMdMhlJFZi1
         5a4fSy+nSmJVL/UQ/H+Ch5lp8wjo0J6ttaahWUUNBKeMa8ZVV5+R1MK/4M2wxOSUsV5Y
         K6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qO//5STrxgCU0oKi08sL7FpWxjHQ0iLeOfPsLNCOOZ8=;
        b=qLseUVp6mCLtoMZBisX/k5u23sm2ICSKTVx19cbacQ32WSm+lE34wHHQi4prZSB2xL
         f8Ev+OgOQ0nY7fa7SIwLjvZb5MRQeNR8D8bym3bEst20I18hFrIMnTVW2nHRPQNuuuT6
         Ywc1wfDkvKeJR3eUgsyhX976LNDfKBmDATborIiKI5Ka/DEceQF0fz/jXMJna7915YII
         WD05AYw68qSdp3V10fTQYy/w4odVVecX4N+Htxueo3Oanlxu/nvjKQpythlPw7zZwD85
         PB2X09GBI9CXPeoQk+MD6lefyNGeXPEMkRIRg8lU59iE0EyAa+m/q1fnUoSrq2YX5dPZ
         87Bw==
X-Gm-Message-State: AOAM532TAY90w1AR77E+6a2cS4CgE0HCFRG42XBhnzrJWjQR+7DJMFre
        rHqvQbLBKw85OA3OrAAdGdT9zQ==
X-Google-Smtp-Source: ABdhPJw+HNRTr+VjCPf0xBBfdVoukyQWtW53930UGkPXuO6c31SE4S/MMuWxdD4uhCH7Xi53i4AiRQ==
X-Received: by 2002:a1c:6706:: with SMTP id b6mr13779520wmc.54.1590161806908;
        Fri, 22 May 2020 08:36:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id s19sm6109825wmj.21.2020.05.22.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 08:36:46 -0700 (PDT)
Subject: Re: [v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL
To:     Michael Kao <michael.kao@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200323121537.22697-1-michael.kao@mediatek.com>
 <20200323121537.22697-8-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1afbf412-fbeb-8abe-66d8-bd7ac4e9dd83@linaro.org>
Date:   Fri, 22 May 2020 17:36:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200323121537.22697-8-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/03/2020 13:15, Michael Kao wrote:
> From: "michael.kao" <michael.kao@mediatek.com>
> 
> The driver of thermal and svs will use the
> same register for the project which should select
> bank before reading sensor value.

Here there is a design problem AFAICT. The sensor should not be using
external locks.



> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 9eaca432920e..594ad4f0f8cd 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -22,6 +22,7 @@
>  #include <linux/thermal.h>
>  #include <linux/reset.h>
>  #include <linux/types.h>
> +#include <linux/power/mtk_svs.h>
>  
>  /* AUXADC Registers */
>  #define AUXADC_CON1_SET_V	0x008
> @@ -262,7 +263,7 @@ struct mtk_thermal {
>  	struct clk *clk_peri_therm;
>  	struct clk *clk_auxadc;
>  	/* lock: for getting and putting banks */
> -	struct mutex lock;
> +	unsigned long flags;
>  
>  	/* Calibration values */
>  	s32 adc_ge;
> @@ -561,7 +562,7 @@ static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
>  	u32 val;
>  
>  	if (mt->conf->need_switch_bank) {
> -		mutex_lock(&mt->lock);
> +		mt->flags = claim_mtk_svs_lock();
>  
>  		val = readl(mt->thermal_base + PTPCORESEL);
>  		val &= ~0xf;
> @@ -581,7 +582,7 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>  	struct mtk_thermal *mt = bank->mt;
>  
>  	if (mt->conf->need_switch_bank)
> -		mutex_unlock(&mt->lock);
> +		release_mtk_svs_lock(mt->flags);
>  }
>  
>  /**
> @@ -938,8 +939,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	mutex_init(&mt->lock);
> -
>  	mt->dev = &pdev->dev;
>  
>  	auxadc = of_parse_phandle(np, "mediatek,auxadc", 0);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
