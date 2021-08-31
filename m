Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3D3FC208
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 07:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhHaE7j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 00:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhHaE7i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 00:59:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA74C061575
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 21:58:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x16so8223051pll.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 21:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lMvtZYwT8DJqB49zIvv4NMVWPbw5ZHxU3mSA2W3Wh1M=;
        b=dxH9UPBLpBwzZdBf8QWm1Go+CRH0L/xL+3CCqnGDyNMBh4ck3PCfKVsKYhf3h4ii+u
         pX+eomrUibK7XYItSWzK4Dmeo+GjrbLtOf28KUs/Cx+sAQK6Zs9VzgjFcAz68wDb/+YO
         QEOh99M5LQY+ANhRUT+3wvrR+ZDLa0f9iBMBLSaslIluxJCQfYeH3JxvnVMUQW8ZUBzJ
         nCD39MElLEVZbJfgYGpwlqWV9xRDVF905C7x5fKN5SWWrUjh8yjULHluV70RSvxNoIrn
         nl/FDQb9I5s8+Qp+DGAHAiGhEmTSWp7jn4s6m7iptQ77ac39sTlH34d6NTmK3st4vRoV
         8Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lMvtZYwT8DJqB49zIvv4NMVWPbw5ZHxU3mSA2W3Wh1M=;
        b=bB2H5tk6DKMG/A5bDsD2yd3KSt0soVKk0U3YklXUnHqZT+QNkghlgcXsUM/jiuAWIM
         xeMOuONrxzJaTXBRtsANNyjv6oD4HHmqvWkpWSI3QZ4cvmhP3kqLH/FvQwVrkgYLBp1O
         w4buA/mkU/EN/lBWV4DFgoShKYhoVOLfVJJpoPV6gkHkevgpVcf39oSB0Gt5U+tLcCaq
         nHOd5oGgrd8LzF4dTrC2asAPHjTqRMNJgXOjK4z/qds7IbRGuQY2sU00Pe/FHd9K7OmO
         EfhlJa6wYQ3ur0S8wqxExYU9g6dXGNf06DqIWnBAjnq1OxA5FLOtdApdrP09WvKnOWpM
         uQ1A==
X-Gm-Message-State: AOAM5322HdtMptq5wqJSmU1t5khrtiINOOhMWbxyHcdwpbx4xZ4qAkzC
        7Oh3nFeSVBSxaSibXzPEirQ3wQ==
X-Google-Smtp-Source: ABdhPJwBnkHqnITiHDLxTLus6wkzCQJVQGXRODw+XTEkZdvfNLROZb8XgSelWszx71G+3rNoovVgJw==
X-Received: by 2002:a17:90a:b105:: with SMTP id z5mr3079538pjq.64.1630385923612;
        Mon, 30 Aug 2021 21:58:43 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id y23sm15518249pfe.129.2021.08.30.21.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 21:58:43 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:28:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     schspa <schspa@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq_ondemand: fix bad auto calculated frequency.
Message-ID: <20210831045841.qoeh2aifxxinlss3@vireshk-i7>
References: <20210827081752.54337-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827081752.54337-1-schspa@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-08-21, 16:17, schspa wrote:
> We can litmit cpufreq range by change min & max from cpufreq_policy.
> So cpu frequency target should be in range [policy->min, policy->max].
> 
> Signed-off-by: schspa <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index ac361a8b1d3b..8afb2c84c38c 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -151,8 +151,8 @@ static void od_update(struct cpufreq_policy *policy)
>  		/* Calculate the next frequency proportional to load */
>  		unsigned int freq_next, min_f, max_f;
>  
> -		min_f = policy->cpuinfo.min_freq;
> -		max_f = policy->cpuinfo.max_freq;
> +		min_f = policy->min;
> +		max_f = policy->max;
>  		freq_next = min_f + load * (max_f - min_f) / 100;

No. The current calculations are right. The new frequency is proportional to
current load and it needs to take into account the entire freq range of the
CPUs. Note that we will eventually try to get the resultant frequency within
policy->min/max range in __cpufreq_driver_target().

-- 
viresh
