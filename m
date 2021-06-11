Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348F63A3F1F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 11:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFKJgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 05:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhFKJgS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 05:36:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D174C0617AF
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 02:34:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so8088645wmq.5
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A8TIz1cDlej9+ZUNsR4O5xhIVt925U9+N5LJUNgO/fQ=;
        b=CVaNBmMn5NZaDL8wN6U1Sq99oo2mhoYCZqF9PKZHXIgvVAkYkNOr+KV+1jYNPlzrq+
         aCUcQR1v9BxZzj0x4czDI08Ae4WEkHlyyJlXAEtQpdc77gA63wM0QlbzPPuKmC9gCd9K
         r+D/abexRY/D0eXRTYT6Tk9YInO4eRGuznpIxV46cKzr6gXl7R71peun9wCrgCO7C+0l
         bPCTf8lOCXanzrGmoN5/GeIrAFDNh8FDVVVTlHwwKmiwhQ9FKt9ocbKXDjm2LRbYvKOv
         ABmSsj5wdgpz67bVIy439wV1me3kp+y92MVxej4Vu8iZXKoJJGBSpL/G2F2RUdkEJ1Rm
         SobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8TIz1cDlej9+ZUNsR4O5xhIVt925U9+N5LJUNgO/fQ=;
        b=ToP2JWY8rmnGBlSHk27bneFzLm9un3fC1iuksywrCoAbSoov8qJZoyerEDNoZZl+UP
         xLDnTQ6fw/Wkh0ly23iHXMsILKGV0rHg7c8Fu2k6H2tiwiJUkFRwugXSbeSQ5XkF0sob
         5bmXEhomlcaWXiOKNEQSPpUQfamfjceFxZN+Ws0tENOZQ32lBtGFhQDBOMEYXCGyMP9J
         9F5S/Zn+60CEaBah1sGC1XLTsu5znsbwNX+tZKjwmiMZNBIVPJxRG9I4ZpLBqG4HUtaR
         iDlS1GCFWY2fBS0NGZTVXM+7PnDArE1rwVQ4HmUGx5nq3A0ULddOYP5jvq5lTYDDVyjv
         /hoQ==
X-Gm-Message-State: AOAM532O9DCuA632tpWzvb4lkuWh4wVxpmrk8mdJzT8QMg+RTGWUMKHc
        ROJG8hzVsWlvNttDxpdNpMxhCA==
X-Google-Smtp-Source: ABdhPJzKJJFONGN/6bSPuZcs8dM9cVLYpIrC7eLXiCIro9zRisQdbkwTqpXI+Nz3xKNyUwdvbHkpOg==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr3033049wmf.146.1623404058646;
        Fri, 11 Jun 2021 02:34:18 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e537:d458:d3c4:18e1? ([2a01:e34:ed2f:f020:e537:d458:d3c4:18e1])
        by smtp.googlemail.com with ESMTPSA id g10sm6489552wrq.12.2021.06.11.02.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:34:18 -0700 (PDT)
Subject: Re: [PATCH] thermal: sprd: Add missing MODULE_DEVICE_TABLE
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-pm@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
References: <20210512093752.243168-1-zhang.lyra@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cfe9b793-47a6-b6ad-74f0-3342e5ed4d4b@linaro.org>
Date:   Fri, 11 Jun 2021 11:34:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512093752.243168-1-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/05/2021 11:37, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> MODULE_DEVICE_TABLE is used to extract the device information out of the
> driver and builds a table when being compiled. If using this macro,
> kernel can find the driver if available when the device is plugged in,
> and then loads that driver and initializes the device.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Applied, and added the Fixes tag:

Fixes: 554fdbaf19b18 ("thermal: sprd: Add Spreadtrum thermal driver
support")

> ---
>  drivers/thermal/sprd_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index 3682edb2f466..fe06cccf14b3 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -532,6 +532,7 @@ static const struct of_device_id sprd_thermal_of_match[] = {
>  	{ .compatible = "sprd,ums512-thermal", .data = &ums512_data },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, sprd_thermal_of_match);
>  
>  static const struct dev_pm_ops sprd_thermal_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(sprd_thm_suspend, sprd_thm_resume)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
