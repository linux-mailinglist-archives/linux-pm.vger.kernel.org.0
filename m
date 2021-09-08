Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6E40400C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 22:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350134AbhIHUBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 16:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349670AbhIHUBP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Sep 2021 16:01:15 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED9CC061575
        for <linux-pm@vger.kernel.org>; Wed,  8 Sep 2021 13:00:07 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso1166383ooq.8
        for <linux-pm@vger.kernel.org>; Wed, 08 Sep 2021 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RtxwRt2rTuC496QAV96NN3FjKBQdlap5HoR2ATAA9hU=;
        b=RsOiPsYODfTsIryeJE0IlLhSwf62h5Se7YksEGS0zegwU3Il8jCzlrJ5if1mEFhhWZ
         ydKf5ZGJ6tTV/T4rdQn0/ly2reLSXSyVv2w7UYsfWj56TP4Bkqsbt/pB9G03uZUbkKXL
         qWoY1WnDs4Stetsc1dJaf4YW/bNtlFlNXxvCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RtxwRt2rTuC496QAV96NN3FjKBQdlap5HoR2ATAA9hU=;
        b=Ce4kWsnxVMZjArI4fC1uWD6Or/FB7jImVtjMulIPkZ/0lvfZPVQYVHcg4/VN8Faloe
         /sqy4T4syGcgOPnAEp4YhxXdBIjylInolyHHDBcBoKz58FKuXytW3exkra1kk5CM0/RE
         x7vBMiroNk9Gw3LYGeoiVb18AMQhQbePA4tqzDD+jLuE47SLLpnRMgtoI6SsqvIjfNZy
         j+jjIMe45lPX407NYWMvQVhv+MhXUz5bBKblLOt+0mQ4v+ytiBa4jJtGIQ8TjSu4t+D8
         9kf5x6mutH0gJlRMemMNF30tf8iXabCnzpRWnxDlB/Fya4uDmuZmgSUyWjGSGcYq5Pt5
         kfGA==
X-Gm-Message-State: AOAM533OTUah6G30wYQtG2zevuwp59bLP/gTo/aFHXd0vnODcUtblrpc
        hO2JFlQvp0+yrr2XrGZrhcbZWg==
X-Google-Smtp-Source: ABdhPJxVIKlbDojIl6ZNygmPq7kE1gZ8MAYMaX+VkWQ1Tv7ShdXJr5e2KhVp5DP7gFiCu0ty2mXMfQ==
X-Received: by 2002:a05:6820:613:: with SMTP id e19mr21508oow.67.1631131206643;
        Wed, 08 Sep 2021 13:00:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z18sm14301oib.27.2021.09.08.13.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 13:00:06 -0700 (PDT)
Subject: Re: [PATCH 01/19] x86/cpufreatures: add AMD CPPC extension feature
 flag
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-2-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c8c57be3-5a86-062c-bd5c-5132d05dde3f@linuxfoundation.org>
Date:   Wed, 8 Sep 2021 14:00:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210908150001.3702552-2-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/21 8:59 AM, Huang Rui wrote:
> Add Collaborative Processor Performance Control Extension feature flag
> for AMD processors.
> 

Please add a couple of sentences about the feature and what it does.

> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   arch/x86/include/asm/cpufeatures.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d0ce5cfd3ac1..f7aea50e3371 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -313,6 +313,7 @@
>   #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>   #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>   #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_AMD_CPPC_EXT	(13*32+27) /* Collaborative Processor Performance Control Extension */
>   
>   /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>   #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
> 

thanks,
-- Shuah
