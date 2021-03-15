Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB333AA93
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 05:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhCOExT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 00:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCOExF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Mar 2021 00:53:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDFFC06175F
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 21:53:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so14067167pjb.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 21:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jlkZc4l57z4gYpyUQhwFM4YMqSzrWiY9Ig9xmWZ6CM=;
        b=pGoQ3T8HqHZEyJXEatYySB5WORzlCF9PNfWlOpWXhw6jcEuay5IW7JD85GFR+K8SGh
         8Y+u0LeCZhPO55P/eg2HEjPpjd90w3SafcUUWmRdzJAQ/iSwLDjtr1mremDYrsOs/+JD
         uDBhIi4fjJ0fFDGGQ2iQDMD9E1bFLlqY2dF+uBpb0+WB/pYxbXRC58h7ROPWgMiCA0KV
         mIYNHAPr/fRqXP654nOQangoyHSPjm3J1COuc9Tcco80HdjzVhlNLjYz2MtBJUDh+qjD
         AMj6N9kFJte6G+20v07srvUhYdC8OtBYffvUMShBRMh7mhKz3z2mBquM+ER2T3+BXXEz
         /eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jlkZc4l57z4gYpyUQhwFM4YMqSzrWiY9Ig9xmWZ6CM=;
        b=L4GxNiOP+sOzJyRF2t6P1c6Jv4crEaR9veXNW4UJAPURqUCGTlzw8ZpX2lsfUVUCr+
         XyVEUOnc7Dmkyg09tBlkq4rytxP1YjLH9cSpavatIuMmxGrygQ/Ck2ywDpUAx6eFO6AM
         Bl2aIMwPU5DUcNn7msHy+5Ss7uXjrEcXrsuvqhgDT2tzCY03AAhu6dspAS4/LcC4gZqk
         ojmusOySX/PvzdIUj1HSS23x0BpSO3dEdpZ9r1jgoR6JzbZY3lGOzA8KzemVB7J2snXm
         /ExzGgT4I+xX+9wjJmoP1e2FKn9JHafGv+lYX3S3jfLYmJyU2jddQuLF5nzhHISjrOK3
         e0sQ==
X-Gm-Message-State: AOAM530mTTivksvPHy60dXJZJw/EI6BLbxyzMwcU0YY/uIBwj49Wg4Vj
        xS6/AvxYm7fDFdHeURjX0WnHmw==
X-Google-Smtp-Source: ABdhPJyy7I1OkZgc4AkQUPBPTiQ7mj6++oGWXw9qnwTSeqFRDGqwzlOIcW/m6hQeVd08Xgli2eFfiw==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr10767093pjb.55.1615783985061;
        Sun, 14 Mar 2021 21:53:05 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id ms21sm9350052pjb.5.2021.03.14.21.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 21:53:04 -0700 (PDT)
Date:   Mon, 15 Mar 2021 10:23:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cppc: simplify default delay_us setting
Message-ID: <20210315045302.hdmu5ca4f7z3y5ki@vireshk-i7>
References: <35ac53f3efdfe58337fb66ad899b548dfa3bbc1b.1615603452.git.tom.saeger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ac53f3efdfe58337fb66ad899b548dfa3bbc1b.1615603452.git.tom.saeger@oracle.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-03-21, 19:50, Tom Saeger wrote:
> Simplify case when setting default in cppc_cpufreq_get_transition_delay_us.
> 
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 8a482c434ea6..2f769b1630c5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -216,26 +216,16 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
>  {
>  	unsigned long implementor = read_cpuid_implementor();
>  	unsigned long part_num = read_cpuid_part_number();
> -	unsigned int delay_us = 0;
>  
>  	switch (implementor) {
>  	case ARM_CPU_IMP_QCOM:
>  		switch (part_num) {
>  		case QCOM_CPU_PART_FALKOR_V1:
>  		case QCOM_CPU_PART_FALKOR:
> -			delay_us = 10000;
> -			break;
> -		default:
> -			delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> -			break;
> +			return 10000;
>  		}
> -		break;
> -	default:
> -		delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> -		break;
>  	}
> -
> -	return delay_us;
> +	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
>  }

Applied. Thanks.

-- 
viresh
