Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556B924FBA7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHXKkm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXKkj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:40:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9496DC061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:40:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 83so7823883wme.4
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xXjN98vY17whUxsx/oA3AARLFaFdhmecrXTXMA2ceZ0=;
        b=lomQdcUNQx+/BxL2/+icLxnlxbiRV/LR5R2ymI+4HGtFQ8RSLrGnfqXK2lMYpZvZG2
         8TabI/D0LBChfXt6c99KjWo8mAci6c4SMSc1rJPArLIen1a1dSlhRjk1YxVf3b7WQkWR
         E3DdXYxofDOIVNKMlxTKIbzVlc3xkhggRGR3bChMVlJLyUE/+ZJtq1M8CrTvTFnz+dUt
         tb7TdOkzaGhbz2jRs+gMTXT7BBbDqAbnvkot5a1Gau0fzfzv6sDOXKA/hBvPKoRkHUlj
         vpUd9JV73CmvJxUpat2KioQEW21uLmhmY5OrgpEIR5blEN2m4M+dKgyW74PCaSjLq51/
         q5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xXjN98vY17whUxsx/oA3AARLFaFdhmecrXTXMA2ceZ0=;
        b=s4mEiXlGimP3rd3phyPM6+kYUTbYgKcGXr2D1IqxSOnOBKLCoAJ6wVai+e8PtQh3Kr
         oaW2V9QspJEvs1gpBD6L5g9U2QGlBpEBoSDfMT/sKoD9ppXrBoJN/UrcW+J0Sv/DExOc
         ShYPbDXumG43RXTb58KxW+gLUU7uDcIAJXpVighjy7KxWog1oGdJaS7igiYc61HO4aYW
         zKLuAnyerZuxP0zZ5hvgT/PFsi6zg1xp6jkOpLNV1XL2KZtsO/xJElLr6CFH/azGNN1M
         WXDzlOVB1CWm0fqKrOp3QIVHDNaUMJt7N6U70mE/4zIO1OdNagvryuR1tqRatkNenhUi
         /hkw==
X-Gm-Message-State: AOAM530wBeb92D83f2bsx4fHRhwjsS/GKWz2F6mJmLdLytWo3Y+4LqTX
        MP5WA+jRuHT2ADn5cupMzl2uBQ==
X-Google-Smtp-Source: ABdhPJxFuPfgQN+XAAAD/huWOB+bvWyVMgaMusM4/pvjAeoiSzfFV78YiImZRZfoXOaKrvd5GngR7Q==
X-Received: by 2002:a1c:96d7:: with SMTP id y206mr5011905wmd.9.1598265637208;
        Mon, 24 Aug 2020 03:40:37 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id k13sm23239684wmj.14.2020.08.24.03.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:40:36 -0700 (PDT)
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling device's
 statistics
To:     Yue Hu <zbestahu@gmail.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
References: <20200818063005.13828-1-zbestahu@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
Date:   Mon, 24 Aug 2020 12:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818063005.13828-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/08/2020 08:30, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We observed warning about kzalloc() when register thermal cooling device
> in backlight_device_register(). backlight display can be a cooling device
> since reducing screen brightness will can help reduce temperature.
> 
> However, ->get_max_state of backlight will assign max brightness of 1024
> to states. The memory size can be getting 1MB+ due to states * states.

What are the benefits of a 1024 states cooling device ? Is the
difference noticeable with a such small step ?


> That is so large to trigger kmalloc() warning.
> 
> So, let's remove it and try vzalloc() if kzalloc() fails.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb..9bae0b6 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -16,6 +16,8 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
>  #include <linux/string.h>
>  #include <linux/jiffies.h>
>  
> @@ -919,7 +921,9 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>  	var += sizeof(*stats->time_in_state) * states;
>  	var += sizeof(*stats->trans_table) * states * states;
>  
> -	stats = kzalloc(var, GFP_KERNEL);
> +	stats = kzalloc(var, GFP_KERNEL | __GFP_NOWARN);
> +	if (!stats)
> +		stats = vzalloc(var);
>  	if (!stats)
>  		return;
>  
> @@ -938,7 +942,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>  
>  static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
>  {
> -	kfree(cdev->stats);
> +	kvfree(cdev->stats);
>  	cdev->stats = NULL;
>  }
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
