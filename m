Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E43472DDFE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 11:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbjFMJoI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjFMJoH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 05:44:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DF8EC
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:44:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8d1eb535eso2160175e9.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686649443; x=1689241443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GS4ZDwPdVKcB752SYSIB+ydV97yO49nogAsemi0GPWI=;
        b=nVGmNwy9Q14ecN48btygx3eRBRvrmo4+1pPDbypMH4BxMQNYdA5EkjKJ4s0lC2QDSw
         k/bXRsogPeCkrmnhBYZr+lnnEGoh75fOrgq3bexsZPPmY820jmPnh53VanLJqZx8u3If
         /NmAgA6kpQnJ5ERxrPWpYwm+f7vLjn1ib49YWx5HWoBON8uOxpgmZL6o2h5HXVshe58X
         fVaoIRnJ1Peb9NhKedgJv9t/M5uHPbryFV+NeXU6Rg+va9iPw1Ws7Ab7Ep94BPhWEdIH
         GQO1yd10DSdWYdsmJoL9YUM82DYjWzwhrdOBdej8JjUjiPCquTAqB3dcPh2D6h7jpBvI
         bkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686649443; x=1689241443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GS4ZDwPdVKcB752SYSIB+ydV97yO49nogAsemi0GPWI=;
        b=ZDlIUgB/dI7izWpuxVjwg6mZfXPkksO8W1cqgmEtATSyEvPOl+6kG+RxJoErGuqyrM
         MjZbF0wmUuKbH8Mk0uLVgOJiFBalLGCd0bg6z+GFgDmvypGgHkyAPdqzLjdpd6k8MhTw
         CTeKevnbtyo9J3e6r9DWhNQm6NKStdPCRgVUDo++O80HSmxg44OgrjWygRYTRK4GO8mi
         LlMkiCTW7mSjvRKqoCOT7LACSMQXdDE2zWCoq/9HK9eO493dNo2pCCVnLExpdGF9/e6Q
         4AYUVoTwoMdJ0yGlwSZUfbXexOGgsjm4ys421kk9vt92OGt6Bw4Q3imKlgeJgeKjYhLU
         azjQ==
X-Gm-Message-State: AC+VfDzQykaHyLFC/cwuCgxuGFZClGmEL7FB24xUZ+KZ1/mS8J3RyYkD
        gbrAT0NUoNFZCv39NScFFxBTIg==
X-Google-Smtp-Source: ACHHUZ5aRKh3Ud2ou9GmjJW8cZ863CitZMIdu+JB0o8GhAQucSHx3tjIG0Oz9oZoA0/TYAOPtEEXeg==
X-Received: by 2002:a1c:7203:0:b0:3f7:f584:579b with SMTP id n3-20020a1c7203000000b003f7f584579bmr7364121wmc.9.1686649443481;
        Tue, 13 Jun 2023 02:44:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d6bf:b78b:2fff:653a? ([2a05:6e02:1041:c10:d6bf:b78b:2fff:653a])
        by smtp.googlemail.com with ESMTPSA id c18-20020a7bc852000000b003f42158288dsm13853752wml.20.2023.06.13.02.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 02:44:03 -0700 (PDT)
Message-ID: <3a840fbf-8250-9870-3caa-3e12c468aa24@linaro.org>
Date:   Tue, 13 Jun 2023 11:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal/drivers/generic-adc: Register thermal zones as
 hwmon sensors
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20230613093054.2067340-1-wenst@chromium.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230613093054.2067340-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/06/2023 11:30, Chen-Yu Tsai wrote:
> Register thermal zones as hwmon sensors to let userspace read
> temperatures using standard hwmon interface.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/thermal/thermal-generic-adc.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> index 017b0ce52122..e95dc354f192 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -13,6 +13,8 @@
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
>   
> +#include "thermal_hwmon.h"
> +
>   struct gadc_thermal_info {
>   	struct device *dev;
>   	struct thermal_zone_device *tz_dev;
> @@ -153,6 +155,12 @@ static int gadc_thermal_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
> +		return ret;
> +	}

Usually, if the hwmon registering fails this is not fatal.

> +
>   	return 0;
>   }
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

