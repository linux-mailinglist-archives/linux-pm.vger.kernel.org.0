Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48BE31E8CC
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 11:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBRKpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 05:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhBRKN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 05:13:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0717AC061794
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 02:05:13 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cl8so1060656pjb.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QqUlEVqUFxLYYj8AnwL4tFC5BJXkPMxniJs3C6hKrpM=;
        b=FQVsNk7fKcaL9PiZFVq1VKNicrBTsDaKguZ6Q6e3lgpdbFD8gljU3ok+bRuVyhz4Vs
         nSH2P1gRCuo9nfUXYBXmG8OdMMJNBxaP7H2ouoOCixARy18S5XvZKXSQHHE4OeOquGY6
         tHPB4sHGc6+hJ8FT1yy1jREvCfRYE4mzvIDL8QAn5mZlmCZnpUbHZ33mq+q/DvBLl6EG
         WfQyKCATHs9vbyeZ73rxMNGs2nE4jiJ9zKEhhNtgvCCGV2ghmT7b96KwvIKMErDrw+2R
         84Q+BfvH/AEsGzpaUNFpv2ESIxZSMbeY+4yZGs9WR5y9pDUX77kGeapU4q6GKetvoTCE
         zjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QqUlEVqUFxLYYj8AnwL4tFC5BJXkPMxniJs3C6hKrpM=;
        b=Arw0HTZm6C4TSAIpOmb/RFO+7rOdWHjvmsNWkVPMKfewDYUM6wUP0kbAxJzZxqDlUv
         jYYorwPhogd83+EdD1T1eMGadH8g7XRe/kAV5LoATa/j+WXesmMbYrz0jY5yYsBmKOR/
         ol4PHGupMWBYq9BdQ7x2w+zmqX/RJWrBzDudp4rNwUF5g3UNkGKxlNecy0N9ZXmbPTWX
         iXlHNqAdqf35IhGpMNOPZi2MXaTuw+o1MdJrflhzOEJr6Q02+Bfn/EUroD5tOFRVVDgz
         5Rcb7T1yxR9DnKZVXDM6t96mHwQn5AQbZnX6WXT/zp8rXbxeLfzZyCwYsBcyA5MryREO
         fRuA==
X-Gm-Message-State: AOAM5305XKzza8pHPZEeMmOKE/nbZwxNqtHFI7jqBjMm2fuocgFmdOY6
        +ZD6cofbsk56xdfPNvPWTuS0Uw==
X-Google-Smtp-Source: ABdhPJyEDHRWzw5hc3tHKGnukExfAzOn9IIufBXE3DJwmLdE78T34qelXx7qDFAm6qY6CyLN6NfjQg==
X-Received: by 2002:a17:90b:46cb:: with SMTP id jx11mr3353038pjb.45.1613642713510;
        Thu, 18 Feb 2021 02:05:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y20sm5532912pfo.210.2021.02.18.02.05.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 02:05:13 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:35:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Fix typo in comments
Message-ID: <20210218100511.nsjgtu3mdkr6f4zf@vireshk-i7>
References: <20210218095338.1766-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218095338.1766-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-02-21, 17:53, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Change 'Terget' to 'Target'.
> 
> Should be Target.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d0a3525..e4ec74d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2101,7 +2101,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>   * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
>   * @cpu: Target CPU.
>   * @min_perf: Minimum (required) performance level (units of @capacity).
> - * @target_perf: Terget (desired) performance level (units of @capacity).
> + * @target_perf: Target (desired) performance level (units of @capacity).
>   * @capacity: Capacity of the target CPU.
>   *
>   * Carry out a fast performance level switch of @cpu without sleeping.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
