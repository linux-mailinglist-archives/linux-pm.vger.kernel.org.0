Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BECB4552F5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbhKRC6W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242519AbhKRC6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:58:19 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917BC061766
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:55:19 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id s9so3522637qvk.12
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kWiOAOI7r4izu6h5VlKdS2Lb/oHkyFKg0ELscvXQ1wI=;
        b=hJpdylaj3Mj9C8reUqg+M614ul/ESL0NUF+w4YCmGX/WadQ1th7ITOczm5lIZ7IZy9
         rgJOd/6iHXMV5m8WJleM7d/edA1QSYpzYTTXD34NBWyxxh3qwxaMHn6NA2jAy8W5sUeb
         OLZvgt1jpsVWYhrZHvSXPh5jwlcrDLSBdWzBx1IcHkh/1ZP4izJsKYcNBLswA9zywT4Q
         OVb+x7u5Y1CM//vUAQlUx0N94+L2Jxy7WBvvDYNXThFNc6dwWjdcMa5OQk06P+kbohEt
         spFdGgrSpKeXnaj2v9XamIykGdRbrg4RtxHEc5Iz/IgPEposElPsGP4WwZ1zwTWSP+a1
         WP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kWiOAOI7r4izu6h5VlKdS2Lb/oHkyFKg0ELscvXQ1wI=;
        b=PrEd0ClYPS5qFti8i1MJnr51+LEvwXWduL/XwIxsEm5C9Td6hJRNfEE62mh6hNusQd
         H9CAOx6sm445X+ujJSohcIyDLjFLSd9XGNs2F2cPgvBZ1nDD3QlhfhCEE3Cx/kX6k1s+
         1qfdEH+8taMpOH4JgpZmNZnkIt0j6YcEhujYZRkAtUfFgDEALtU4ERL3amsBJoMmG0Ht
         BFn44geRwMOh+mR61QkZEzY69u/ZOlSpJCcgXEW/K4oYNZt1mJBxDmXFtlTfMwgxALVM
         rUVygjksDmVJyYNyB6lnK8SCfrHlR5MNL4bmxCBS1cHDKFG09Eh0naYbDXnQLgLhMNev
         T59w==
X-Gm-Message-State: AOAM532bSPdSrm+bBvCmaNIPZgiY5uYx80qOtq/mHZ/rVzsV3vqpWr19
        NcswS+WN1gD/Or74dkgXjy7EEBshp2TScg==
X-Google-Smtp-Source: ABdhPJx511Llxs8jzWRybvtGDNoFOkV+sSOeHd47g7Td2oUCzsToJYqpJJ1fZHLnVBfhkQVLymeISw==
X-Received: by 2002:a0c:eb90:: with SMTP id x16mr61264369qvo.41.1637204118630;
        Wed, 17 Nov 2021 18:55:18 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id i7sm1003069qkn.0.2021.11.17.18.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 18:55:17 -0800 (PST)
Subject: Re: [PATCH] cpufreq: qcom-hw: Use optional irq API
To:     Stephen Boyd <swboyd@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20211117020346.4088302-1-swboyd@chromium.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <76b103ec-7034-e6c1-1ab4-174cf16f9fc8@linaro.org>
Date:   Wed, 17 Nov 2021 21:55:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211117020346.4088302-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Stephen,

Thanks for the patch

On 11/16/21 9:03 PM, Stephen Boyd wrote:
> Use platform_get_irq_optional() to avoid a noisy error message when the
> irq isn't specified. The irq is definitely optional given that we only
> care about errors that are -EPROBE_DEFER here.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index a2be0df7e174..b442d4983a22 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -382,9 +382,11 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>   	 * Look for LMh interrupt. If no interrupt line is specified /
>   	 * if there is an error, allow cpufreq to be enabled as usual.
>   	 */
> -	data->throttle_irq = platform_get_irq(pdev, index);
> -	if (data->throttle_irq <= 0)
> -		return data->throttle_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;
> +	data->throttle_irq = platform_get_irq_optional(pdev, index);
> +	if (data->throttle_irq == -ENXIO)
> +		return 0;
> +	if (data->throttle_irq < 0)
> +		return data->throttle_irq;

Here the idea is to return only -EPROBE_DEFER error. Else return a 0 , 
so that cpufreq is enabled even if lmh interrupt is inaccessible. The 
above check returns errors other than -EPROBE_DEFER as well. So I would 
say make irq optional and keep the below check

if (data->throttle_irq <= 0)
	return data->throttle_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;

>   
>   	data->cancel_throttle = false;
>   	data->policy = policy;
> 
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> 

-- 
Warm Regards
Thara (She/Her/Hers)
