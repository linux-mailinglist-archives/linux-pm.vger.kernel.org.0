Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA237B585
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 07:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhELFhx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 01:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhELFhx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 01:37:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105CC06174A
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 22:36:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i190so17660601pfc.12
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 22:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ifo9croMydmJDq8tVTBmjMUam90Lc+s7rOdOzubXklE=;
        b=agHLsJAoym4mAxL5ZbgKFvYlFEOR4OOQAOYhJ5XL6zGFdXJTNW4ILyNtIcpp9yBgWu
         WGiFqBgjT8jdwWMZEEBeaCuxu3R9F6JWpU5mTBExX2j8kfB6AE+viouqAsO+RaLKOja2
         aWMHOrhc3nlqUO/fB8z+BAMqBkXNeQ8TMjUP1rPfYwO3iJxQcwGHpuSEjRoVkWbL0hZ5
         ED7JTdff4rrrkT4GaOq/oAtxwhrZnduoyKXKextYZlUE3OfryuNdWAEqB77tz6ppExO9
         z0X9ADhSj6j1JxyAJBcryBF1+7fbqoS/I3hgAi1UyrDTQGtLFGPeSJFFEDd+d4qN4C5O
         veVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ifo9croMydmJDq8tVTBmjMUam90Lc+s7rOdOzubXklE=;
        b=DKxg5XaEAm8FpucsVb40arrLs5k26uv/v9l37JBIINhHLKZL6QNq0obxc7u7aMR9ih
         rvQSHuTJMfuvcTucD46KY/xBweImonkzewvQ2jWKaigIKypFMfltHRxrSIEjxw4L8Hw3
         KXZJ+GJXLTm8wXY22s82ZnrzwYIhJPmvN4Sx6Wc3z+sJglRt3OWGDPOyp6Gl2ignL05R
         JhuEzKafCBsvLrAuX6+qJMooXG88sp2Ml2mn4sLoY9YYA0OdWOlrrXc1Xd2Zrx3I5ITg
         /VpEplrwFeG5XS9U7sCpS6R6U4X/4jHzyORnOA/KHzr/lhsBidvanbckrd8zgkWPGcjE
         3Aag==
X-Gm-Message-State: AOAM532N9OHwrmlNb+nIMAXITWt67ahuUC1pVLv7wqTJUmaVA+h2Zzm9
        gDdWimkhXdzg1/L8W+/83w49fcNgNtWBxg==
X-Google-Smtp-Source: ABdhPJxG5HFk1BVt87iNZIgnUiokph6k9IgeqiusOSQfY+cfYd6jn7ckZgLDJf5/yFz2AyFt27T+0w==
X-Received: by 2002:a63:eb47:: with SMTP id b7mr7593796pgk.227.1620797805698;
        Tue, 11 May 2021 22:36:45 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id m2sm14853917pgv.87.2021.05.11.22.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 22:36:44 -0700 (PDT)
Date:   Wed, 12 May 2021 11:06:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net
Subject: Re: [PATCH -next] cpufreq: cppc: Remove unnecessary INIT_LIST_HEAD()
Message-ID: <20210512053642.74so7tkzsjbthybf@vireshk-i7>
References: <20210511114703.3790524-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511114703.3790524-1-yangyingliang@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-05-21, 19:47, Yang Yingliang wrote:
> The list_head cpu_data_list is initialized statically.
> It is unnecessary to initialize by INIT_LIST_HEAD().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 3848b4c222e1..b312fa210a39 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -723,8 +723,6 @@ static int __init cppc_cpufreq_init(void)
>  	if ((acpi_disabled) || !acpi_cpc_valid())
>  		return -ENODEV;
>  
> -	INIT_LIST_HEAD(&cpu_data_list);
> -
>  	cppc_check_hisi_workaround();
>  
>  	ret = cpufreq_register_driver(&cppc_cpufreq_driver);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
