Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0230E29DA02
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 00:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgJ1XKd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 19:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgJ1XJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 19:09:42 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D22C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 16:09:42 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c72so1316995oig.9
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rEqCJekFVdJTMohcwUl8YdkY5G5aqFn/B9lOvlebXSk=;
        b=gWrTCdIfiB04joDQpWiGtlCqzLYQ86OtHnVZUZ5/AcNpr0RsnNsZmMHQ6wi/oYUxey
         ipo8OMsx9z+YGFnF/mvfsgUHdiufYDOWghZ8PM/jZM9cBjJjjv5XmnDC+kgvlNgbcsLJ
         A1UFuJ27R0xMrwiw8kWH+I80EJpyiFe8llpFohPKsqaGIr2hRPl6xTVor7dePBF0JMK+
         4U9tU0rp/a2ZUgwQot2c5RLbb/Y9XprKkakugEmenZkY4g+l+A/uSD0O1C+QKkDxLx8W
         4gwPbbyYoHvpPXpBvQu5Zn3CjS5B/h2REIdr8jXdpPv7uk8e9xcUJFPFBy+Lm+UP4o12
         Axhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rEqCJekFVdJTMohcwUl8YdkY5G5aqFn/B9lOvlebXSk=;
        b=SrtBorHJpetFNZNiqe/SOYttUqhV7XGRNGuP1f5I7A9esBPMmKMBFq6qvD7bx4TPtw
         llr/gwb9rBLZrWmGoepS1QVhcKxnC7D6K22l/pGZCHr9HQ7IRNkSIJUKCnCuyUUNp0w9
         sq4zzEtrWgQ3dqMjqJg8EUOdCVwu7xgbmoxj/5UCONVduvIgr9MhZ8TA/BnHfBRIm4og
         OsBryYCTEFmIcfdqSs9t1Z+YBlceAFPr/cdQY12VyYglgRSXgJi/kj2hd4AJMCutkvfY
         HnlJTrTK9OGkgKer5uzF1NIs/Xy8vMHGPgV+v1PAeHU5IL7eGiudjyEsmjj+lUcobwMO
         IX+Q==
X-Gm-Message-State: AOAM530RXAFZB/S7wbuJf7CtXF1hEJnkrfoT8MafT0y8a0rAMHoy5JKU
        lLJQj/hdNPbzEWqcKQoGGZXRLRylnWgpvQ==
X-Google-Smtp-Source: ABdhPJwKbSsxu4QC2yqarwx4WNYvFSoRu8Xrp9BhVFRsY6CB8akaUjVrmdLW/5JnZRdWzczkQmaq9w==
X-Received: by 2002:a17:90a:7c03:: with SMTP id v3mr4924794pjf.233.1603857427232;
        Tue, 27 Oct 2020 20:57:07 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id i22sm4186169pfq.160.2020.10.27.20.57.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 20:57:06 -0700 (PDT)
Date:   Wed, 28 Oct 2020 09:27:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2.1 4/4] cpufreq: schedutil: Always call driver if
 need_freq_update is set
Message-ID: <20201028035702.75f6rnbkvfaic4si@vireshk-i7>
References: <2183878.gTFULuzKx9@kreacher>
 <1905098.zDJocX6404@kreacher>
 <12275472.W5IoEtXICo@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12275472.W5IoEtXICo@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-10-20, 16:35, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -102,11 +102,12 @@ static bool sugov_should_update_freq(str
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
> -	if (sg_policy->next_freq == next_freq)
> +	if (sg_policy->next_freq == next_freq && !sg_policy->need_freq_update)
>  		return false;
>  
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
> +	sg_policy->need_freq_update = false;
>  
>  	return true;
>  }
> @@ -161,10 +162,12 @@ static unsigned int get_next_freq(struct
>  
>  	freq = map_util_freq(util, freq, max);
>  
> -	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> +	if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> +		sg_policy->need_freq_update = true;
> +	else if (freq == sg_policy->cached_raw_freq &&
> +		 !sg_policy->need_freq_update)
>  		return sg_policy->next_freq;
>  
> -	sg_policy->need_freq_update = false;
>  	sg_policy->cached_raw_freq = freq;
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }

What about just this instead ?

  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
  				   unsigned int next_freq)
  {
 -	if (sg_policy->next_freq == next_freq)
 +	if (sg_policy->next_freq == next_freq &&
 +          !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
  		return false;
  
  	sg_policy->next_freq = next_freq;
  	sg_policy->last_freq_update_time = time;
  
  	return true;
  }

-- 
viresh
