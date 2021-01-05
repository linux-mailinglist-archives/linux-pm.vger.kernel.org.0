Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845082EA428
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbhAEDy4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 22:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhAEDy4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 22:54:56 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628FC061793
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 19:54:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s15so15654714plr.9
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 19:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2EgidPs9i3+WSoRNwFT2rOqPzzdIfF25VjEgaOjsvQ=;
        b=YpCabG+Kz0rCRQLVEZEpC6mLNAG2DUk00mYxciiTaaAHfs85cuRI824ILTKlOCr9Kt
         dhOcA7TwmWN9RVT9OABvfp+v0xfCjxDHgdRe01Weymi+x+Llwj8kGuOenyseni5XDdJf
         sOsAw/JG3dWCXds4s2EzJCjtHeY9kSjXNoV0NNGoZM9YlSOQQCmDjpP+LD68BHSVMKpM
         ufKYaYLDWGajxHLC0gz35/dHNDLxIci701CZeSnxJ8EJX+9hI2gkTRDRoIGWovEuZrDT
         5K8cD0+PxvPv5eXw6pxj07WewLVmtt52jFNa//yEfIb7pVDKgi4dWKNgz2pOPK5oqwiX
         33Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2EgidPs9i3+WSoRNwFT2rOqPzzdIfF25VjEgaOjsvQ=;
        b=HTyX7Cw5T9zYfIL0vEi2jR4aZ4fKa+XABD4B6OCbNjMAX81ZaR0oaO2fyZa14MkXD1
         Py/IZ1gTTuvBCJk0s7/kA63UkVHcSiKG4iAqnYTZY7XTxymTtLCJe7xePOxzN/VkN4Ju
         /0g/k1rirJ02l46/AITgugIsRRhQq/TSm43/rykRcokyQv4RgVBYYP0BLX32HL4A+SXt
         mhcRmcXiAna7k6X4408tqc2rEW329GtOF2rHIa4OR5WAHeMfZ2GbMOkRRQ721m9KIhIa
         JzTPdId9KJboXlWiJZRG3D/34WkojXTKE1X6s5xQCitkMW6VRYduE3/1H1kuegQzLC9m
         OVjg==
X-Gm-Message-State: AOAM5306VktJbM4COTu6jbcRBbkO/zC/PGq9A17nkYe7afkrh9mf+85N
        AqWvoLeoqb+8HG3tjdffaiPWvg==
X-Google-Smtp-Source: ABdhPJzurKr5qukIuZHHQ/C/W6YFRUFFgmzlEbEzjxdF2NW7GI7DyRqdAAstPJXZjo3s1JdslvN/Fw==
X-Received: by 2002:a17:90b:46d2:: with SMTP id jx18mr2165415pjb.106.1609818849340;
        Mon, 04 Jan 2021 19:54:09 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id u12sm56134276pfh.98.2021.01.04.19.54.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 19:54:08 -0800 (PST)
Date:   Tue, 5 Jan 2021 09:24:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Warren <swarren@nvidia.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] cpufreq: powernow-k8: add null check to policy to
 avoid null pointer dereference
Message-ID: <20210105035404.c47atgdsiqoa2wuc@vireshk-i7>
References: <20210104130227.35354-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104130227.35354-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-01-21, 13:02, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there is an unlikely case where cpufreq_cpu_get returns a
> null policy and this will cause a null pointer dereference later on.
> Fix this by adding a null check and adding an error return.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: b43a7ffbf33b ("cpufreq: Notify all policy->cpus in cpufreq_notify_transition()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/cpufreq/powernow-k8.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 0acc9e241cd7..c5368545ba1f 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -913,6 +913,8 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,

The caller already has a pointer to the policy, you should rather pass
that here instead of doing cpufreq_cpu_get/put.

>  	freqs.new = find_khz_freq_from_fid(fid);
>  
>  	policy = cpufreq_cpu_get(smp_processor_id());
> +	if (!policy)
> +		return 1;
>  	cpufreq_cpu_put(policy);
>  
>  	cpufreq_freq_transition_begin(policy, &freqs);
> -- 
> 2.29.2

-- 
viresh
