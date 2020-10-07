Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7641B28580A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 07:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJGFLd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 01:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgJGFLc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 01:11:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0533CC061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 22:11:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w21so656951pfc.7
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 22:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wa3QyR27/uKaRnYGJkCF/PrkW0s0ETyJE8CGrYRcJBs=;
        b=ICEW1xe62FusKkz+9GEJmdW5GerVlO6lZQCBt+1UzzuUbL84UBjCHqvI/wfMyJTqo2
         +X68PdxcjTIw8u28c2/+lWAgb248Ji8LfAiV4QS8kS1M2nuhTxMc6IcQ6/BAG8uCBVUO
         ljDx1U4bToRQiYPK5sjE0LLPWSM1rLZlOmFSXJcbsGS8qGcX5Kyfz33b5vmvL80z2qAe
         lf27k5ixa/Opa/u4wkoTzMJVt/cX6FIXxeDWjFBrtOZ5imkn8PzsNc7N713U2S6Ebo1s
         cyKyXnvuGIc40tknOFaPZMtF7T35nHSdYizvl1u3GADaHhx9M6FZH3L7V0tlZbJZjEJr
         UxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wa3QyR27/uKaRnYGJkCF/PrkW0s0ETyJE8CGrYRcJBs=;
        b=gTxHokUG8Ue+F6e7nt5bssIMbF2JFZyTL6+VEaFwacb4Fmh38hiMyeCLz4lSKvbCjg
         XW1P8fjCqw0E5bfWo8AGrk/Vghq6SnMTpbtzJSdeK0anO2cn0BvK1GylyrlIv9Kum1tm
         nxpWhzO6J9aqZGaeqvG/BWu12tzs/B72cKDneooN/vR3UYTn7KVJEzpIZ3JXHO3bzVHq
         p2hZimDEOOU6mFjfHTSHHX+NMlyQxFHcJVUyVy20gq3oLb41XH1ExKrJ7pcZBVD/V8eR
         tpCTBZkPV0akG3YdWeXSholxTI5kyFRej3yMXfxmRRZL+c3N4M591ThFfbiZsj2T7G9d
         pJlA==
X-Gm-Message-State: AOAM533BCGIQFd1zmosMJdFBx0PLWf7C0lkG8JN0DIuShGJw4t9TK9nX
        TVTCT6cagxIdiyD+Mf5S2MZ79A==
X-Google-Smtp-Source: ABdhPJxK65lMzsCkOqno0BB/4bExkoyFG+PzvYDAB9VCj3V7AH0SDSadbBB3+J2lJhnUx2G0qQNWbQ==
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id s7-20020aa782870000b0290142250139ecmr1275936pfm.59.1602047491518;
        Tue, 06 Oct 2020 22:11:31 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e2sm733590pjw.13.2020.10.06.22.11.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 22:11:30 -0700 (PDT)
Date:   Wed, 7 Oct 2020 10:41:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: Simplify sugov_fast_switch()
Message-ID: <20201007051128.odqiwuex3vqwxumo@vireshk-i7>
References: <1869109.WhRmcVd4D2@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1869109.WhRmcVd4D2@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-10-20, 14:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop a redundant local variable definition from sugov_fast_switch()
> and rearrange the code in there to avoid the redundant logical
> negation.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The code reads a bit easier after this change IMV.
> 
> linux-next material.
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -114,12 +114,8 @@ static bool sugov_update_next_freq(struc
>  static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
>  			      unsigned int next_freq)
>  {
> -	struct cpufreq_policy *policy = sg_policy->policy;
> -
> -	if (!sugov_update_next_freq(sg_policy, time, next_freq))
> -		return;
> -
> -	cpufreq_driver_fast_switch(policy, next_freq);
> +	if (sugov_update_next_freq(sg_policy, time, next_freq))
> +		cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
>  }
>  
>  static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
