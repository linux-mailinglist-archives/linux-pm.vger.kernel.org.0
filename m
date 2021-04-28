Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8965E36DD6E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbhD1QsU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbhD1QsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 12:48:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4892C061573
        for <linux-pm@vger.kernel.org>; Wed, 28 Apr 2021 09:47:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i12so32661533qke.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Apr 2021 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d5gcaLFkHTsHl3fSpK+mJvUIAigQB4OGxVY2NlUdHS4=;
        b=lhlZvSJJsG9coISuaIljcJxg7ev6vBymOQm+7m1cfIRbaclhHHNe5Xsiy7TU7mtLAp
         tW/EVQK+AWFdZ3fp9xF/i9t9OIV8pdGSqY4vdf04yp0O7L1Eq6sMAsNzDlfJVz6EQuwu
         1ED2eQ8twnk4oJZuYdgJMyHRSBQFDUcY+SEZB2/vzN6wMzWBVymqA3MXJZTnvj+/fRTQ
         d8sMzExvkZgLB2tYG/ObJTrvdo0BwXjcsOcARP5fcGuEZHztKPX2YvLd6D4T7WoZvCTi
         FJmuDTwHwfE1tyPWk5d/9vNf3AaArOu/QZumDCCMs3ZutQ610xI998Lff5qzkZ3ET/4w
         iH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d5gcaLFkHTsHl3fSpK+mJvUIAigQB4OGxVY2NlUdHS4=;
        b=YNtmVIu95spb0+02+0POkeSZxlQVV3WAOX4jKcZnHdGfy9VvdszpUy+R6Fru72a+Fn
         wLkTcJVkrgs0C1ug24k544BDIOKxfDed286xh+1M7XRq0gZ+Wn5YSqgM8nPTwUk8XUQD
         khcMMc66rO0lvNL4Su4gFX/4XeWs8itANBZzhXPuNPuS6frt+xwIyl3a5bM78h4Ad8Yh
         3hU4sBSL5I1gDMgW27rvelhaovUpdtAAhgMd/NE30UJUcG8SH1adHEjozJcizNnbxdV+
         ftapB9uhkgAJ3kCa3hIYV2WPwugvjpeJOk+f/K4ZFHYKq1L4T3H67gMSrk3x1hiRdPbG
         PVRA==
X-Gm-Message-State: AOAM532LoGiW1ss/jUakqmizEkuPfaDM6oytfEZ041uGi+PH4MBpwddE
        kGcnFCUbGq/3cN1jquUUWwghBw==
X-Google-Smtp-Source: ABdhPJwrZ/ARz760EsoZkEI7kPgF2Hv5R9DjyVFzafhWupMWPoCp5/6i7qZtp8Tys4gJ+GayIAslKw==
X-Received: by 2002:a05:620a:49c:: with SMTP id 28mr30266953qkr.39.1619628452055;
        Wed, 28 Apr 2021 09:47:32 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id d2sm397426qtg.85.2021.04.28.09.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 09:47:31 -0700 (PDT)
Subject: Re: [thermal-next PATCH 2/2] thermal: qcom: tsens: simplify debugfs
 init function
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210419012930.7727-1-ansuelsmth@gmail.com>
 <20210419012930.7727-2-ansuelsmth@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <8e679407-07e7-244a-48fa-0d4d451d744d@linaro.org>
Date:   Wed, 28 Apr 2021 12:47:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210419012930.7727-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Please include a cover letter next time describing the patch series.

On 4/18/21 9:29 PM, Ansuel Smith wrote:
> Simplify debugfs init function.
> - Drop useless variables
> - Add check for existing dev directory.
> - Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
>    incorrectly reported)
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   drivers/thermal/qcom/tsens.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index f9d50a67e..b086d1496 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
>   			return ret;
>   		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
>   	} else {
> -		seq_puts(s, "0.1.0\n");
> +		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
>   	}
>   
>   	return 0;
> @@ -704,21 +704,19 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
>   static void tsens_debug_init(struct platform_device *pdev)
>   {
>   	struct tsens_priv *priv = platform_get_drvdata(pdev);
> -	struct dentry *root, *file;
>   
> -	root = debugfs_lookup("tsens", NULL);
> -	if (!root)
> +	priv->debug_root = debugfs_lookup("tsens", NULL);
> +	if (!priv->debug_root)
>   		priv->debug_root = debugfs_create_dir("tsens", NULL);
> -	else
> -		priv->debug_root = root;
>   
> -	file = debugfs_lookup("version", priv->debug_root);
> -	if (!file)
> +	if (!debugfs_lookup("version", priv->debug_root))
>   		debugfs_create_file("version", 0444, priv->debug_root,
>   				    pdev, &dbg_version_fops);
>   
>   	/* A directory for each instance of the TSENS IP */
> -	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);

Unconditionally creating priv->debug here is correct. The below if 
(!priv->debug) will never be true because as per your patch 1, we call 
tsens_debug_init once per instance of tsens.

> +	priv->debug = debugfs_lookup(dev_name(&pdev->dev), priv->debug_root);
> +	if (!priv->debug)
> +		priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
>   	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
>   }
>   #else
> 

-- 
Warm Regards
Thara
