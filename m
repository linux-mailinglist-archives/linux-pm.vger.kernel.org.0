Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFA346216
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhCWO5L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhCWO4w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 10:56:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C09C061574;
        Tue, 23 Mar 2021 07:56:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v2so11959394pgk.11;
        Tue, 23 Mar 2021 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ssQ3rdEV5yf/YeyNyTJdaflOgBWGr685A+V9rQo8a0w=;
        b=e0HOuAUcXtHN2np3pKQ/263Tt0FqEON1Xe0/7tRPTNUxSuPV+Y3Bw4ECQPoljtrjic
         w4NjlP4dkKPQS4kvGGF0ReSgkcEQXCvZXGBVklVSlg+lgBDf9wUlOzIqt8+CgZiKHK6J
         Yk04xXgSN4ZZoAY2e9pTWVdHz814Mrgo6gcb69lYzVpstRMQL6un2L8Wrz4+MZR317s6
         dNFv+w2tVlG/p6RLHsRlF9IWm3C9ow0uVTnR3dHSsmxD4oqEnuzogtMGd8nztKZdIJpI
         XCN9Wg0GBQJP245+9Jq9Qk/kBTKehidb379o1VgrewZsMxNSsR/NmXyv0OYS+dawrTjm
         ZDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ssQ3rdEV5yf/YeyNyTJdaflOgBWGr685A+V9rQo8a0w=;
        b=X6A6gKAucoVfSozFsfiq5uCL4kctZBFzo/7kOXjXOM68H04ssgDkjZk1+7BpyxaZCG
         kg0RILCuding1GJtha6/4ArIVsCL4Lx3CVM8X1suyg8zcby8rSpqwEsROo2SM9xS7aPF
         R+gf8FnSYrXiDgzrnnc0aQ6rHvTEhlr9cKsH79dWxPTnuAGPVXDxAkl5PNeJvcBKt05V
         m8tc0p2964acXTxcO9GO0FaykOU755QSm5RO6uZm8qN/RuWv2jjQ1AZw+00WllB1Knbv
         C92W+v9yivBdFoQ5JeHKyOEP3reU2eP4oiJz2ox15SQ1gn36/l32xAPS+EZbzK3RZm14
         nGpA==
X-Gm-Message-State: AOAM530FR0EoQGrr0MCMOGV6JbyrmKhqzqjXwdkRomRVZAnrNh7sdqSz
        7Oo1OHJnen3Qrpsctq+n5SA=
X-Google-Smtp-Source: ABdhPJzKtqinvjOAfdWt8juPwVzv+UN8SYu52AL0AubTu7Jtb9zWITgPxd7JBnFIrlrOvf3Nx0n+QQ==
X-Received: by 2002:a17:902:223:b029:e6:e989:964f with SMTP id 32-20020a1709020223b02900e6e989964fmr6086364plc.82.1616511411386;
        Tue, 23 Mar 2021 07:56:51 -0700 (PDT)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id o18sm2891816pji.10.2021.03.23.07.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 07:56:50 -0700 (PDT)
Subject: Re: [PATCH V2 RESEND 4/4] PM / devfreq: imx8m-ddrc: remove
 imx8m_ddrc_get_dev_status
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
 <1616484011-26702-5-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <4f0cb67c-7f68-580a-9fbe-43b02d74c8a0@gmail.com>
Date:   Tue, 23 Mar 2021 23:56:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1616484011-26702-5-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 23. 오후 4:20, Dong Aisheng wrote:
> Current driver actually does not support simple ondemand governor
> as it's unable to provide device load information. So removing
> the unnecessary callback to avoid confusing.
> Right now the driver is using userspace governor by default.
> 
> polling_ms was also dropped as it's not needed for non-ondemand
> governor.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/imx8m-ddrc.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index bc82d3653bff..ecb9375aa877 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -280,18 +280,6 @@ static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
>   	return 0;
>   }
>   
> -static int imx8m_ddrc_get_dev_status(struct device *dev,
> -				     struct devfreq_dev_status *stat)
> -{
> -	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> -
> -	stat->busy_time = 0;
> -	stat->total_time = 0;
> -	stat->current_frequency = clk_get_rate(priv->dram_core);
> -
> -	return 0;
> -}
> -
>   static int imx8m_ddrc_init_freq_info(struct device *dev)
>   {
>   	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> @@ -429,9 +417,7 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		goto err;
>   
> -	priv->profile.polling_ms = 1000;
>   	priv->profile.target = imx8m_ddrc_target;
> -	priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
>   	priv->profile.exit = imx8m_ddrc_exit;
>   	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
>   	priv->profile.initial_freq = clk_get_rate(priv->dram_core);
> 

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
