Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACEB2C4AB2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 23:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgKYWNC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 17:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgKYWNC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 17:13:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC05C0613D4
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2020 14:13:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id z7so18571wrn.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2020 14:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nyuZB6pe2aVr8Jr1Y0KmQ//+PGX3XaEKFQv1Cw25khI=;
        b=KDGJAoW+H5ZOeq3z7CcJdvNkJSc9GX6I7RdvmhuBWTw34HLRNRqS/WAYwPmds/JP4N
         9BLely5o4sAXLMB7L8M1yhWb1MjNq6zTgILIJBVHFHg3M9BevtvpmitbJH3M9en5WWN2
         Dxow2NQRG7WLRIp/g5SJJZyvTO3E+0SMJ2SamBaT8Mgk9N35C15onCF6kaaH8Xbw/zan
         2lH4/ScO4ViS6mtMHBsiwch/PMhANeH2EeLFFynb2dB20kfg4PCVjuu+mGnOgBBCeamo
         Rhtieayez7zymmo3yLCIBvskn2lYAYHaUfbqT4nQaCk1femzAI/vmyIv+oDNMXLpReWw
         ymLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nyuZB6pe2aVr8Jr1Y0KmQ//+PGX3XaEKFQv1Cw25khI=;
        b=KqcGLVq0sZp9CqIYjzvJNpDV4PPtXcKBFAPapsCRqi2CgA74tp4I1GdVmnja+OL4Q4
         VAaYwTugyIWsLu64w1qIXta1yWFr5EiYNBfmzyple/TpReJB7jz7OIX88c0vfb2P0iu5
         TR5z9jcr2AY66iFgnkDTyj2XSa/vlmFKdep/30+kCQAk0fcYPD26MowK3H3rjJgHMU8c
         sSmiQNhUp7pGefvQ5UJFI8n21eZNhSHtmXUiRGRAEe4Fye/V3Z13SVy2UPqSLAg5l6HP
         00e8OIjuuri7VjjvVzw5SLJLVqg92ebwTST9ExobGzqw1BEU7qCjuumGQM5J4sow8AUv
         QsQQ==
X-Gm-Message-State: AOAM5323PrzopqCt20DBoN64qdn6nyfI/HqI72Tm/xJ78Hq1eBUdsGpP
        nYazjGorCgjg+YXT4R7r7zyWgQ==
X-Google-Smtp-Source: ABdhPJwYYULUn86F9g4PzkbFNiPxMnLmOm0+6lcdwnFM4qThLCzo2lAaMWCogymQ+JgprSNFNd1CDg==
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr38927wrn.408.1606342380540;
        Wed, 25 Nov 2020 14:13:00 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:c023:e75f:e8c4:d86? ([2a01:e34:ed2f:f020:c023:e75f:e8c4:d86])
        by smtp.googlemail.com with ESMTPSA id a131sm6423875wmh.30.2020.11.25.14.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 14:12:59 -0800 (PST)
Subject: Re: [PATCH] thermal: amlogic_thermal: Add hwmon support
To:     Dongjin Kim <tobetter@gmail.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201125162405.GA1263100@paju>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c9e48840-2a96-4d90-38aa-27f95a31eef3@linaro.org>
Date:   Wed, 25 Nov 2020 23:12:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125162405.GA1263100@paju>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

Thanks for your patch but exactly the same patch was submitted and
merged [1]

  -- Daniel

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/next&id=cb68a8580e2086fad38597af4c60d39de8df0cde

On 25/11/2020 17:24, Dongjin Kim wrote:
> Expose Amlogic thermal as HWMON devices.
> 
> 	$ sensors
> 	cpu_thermal-virtual-0
> 	Adapter: Virtual device
> 	temp1:        +32.2 C  (crit = +110.0 C)
> 
> 	ddr_thermal-virtual-0
> 	Adapter: Virtual device
> 	temp1:        +33.4 C  (crit = +110.0 C)
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  drivers/thermal/amlogic_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index ccb1fe18e993..2fce96c32586 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -29,6 +29,7 @@
>  #include <linux/thermal.h>
>  
>  #include "thermal_core.h"
> +#include "thermal_hwmon.h"
>  
>  #define TSENSOR_CFG_REG1			0x4
>  	#define TSENSOR_CFG_REG1_RSET_VBG	BIT(12)
> @@ -291,6 +292,9 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (devm_thermal_add_hwmon_sysfs(pdata->tzd))
> +		dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
> +
>  	ret = amlogic_thermal_enable(pdata);
>  
>  	return ret;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
