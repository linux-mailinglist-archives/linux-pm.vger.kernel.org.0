Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604A5171017
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 06:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgB0FT0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 00:19:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46273 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB0FT0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 00:19:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id o24so700015pfp.13
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 21:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZP2jhJvp86yVLBWzdI2zrvme2g80v6ApFuAlAeSIwcE=;
        b=pO5q61A0vgRls2tfv5TJcxuv8zMz4IKCLRFP1zAS5Amigja/75HNUVOXagNoD9QcKs
         N2QpjrdRvT9rttoC9iPrZerD+2I39mTs4RQ6F05NNIZIN2zkkWUxvLytP9vG+SExp5W7
         P8M8ytQO7c39DsWIkHmPyd3YcZuLSk0fkdy2s6EEmOnCRO8MYXpTxsagZsjgeBl/8234
         /Oa2BrARMDSkYs3nUe9zn/YSEKgR3yOxqdKm4NzDvH/CbYuD44RGxE7zM/efbSibWOHN
         zmLBdAMueF+OvX8oRGWXmpDoochVB7HCQ/tou8ylXID5zp3MqJieT6m68j7U+phH4HtS
         7IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZP2jhJvp86yVLBWzdI2zrvme2g80v6ApFuAlAeSIwcE=;
        b=e39EItnQ2gCD3nVWy1Q+d7+2mqDi88Jq2E/jEXRlYa0Eur8L7VbYbc9qO/CnB4625J
         Gf0u9PzDgV3gjvKxQE0HcBBWbBA5JlRnEu24A99nf/vslUUsR+401NEmyUixiOQSL9uh
         kZ0aRncRSTAKyxPodaplrzMMgO5MxxUXGzRd1JrQfs2o89nFC4eXjMNqq2h+ItlmrQIg
         cn3mWqIbpcF84d5/QMY8zcvJCIzjUnqC4syC3WVVEcyWJoXDPPgFZwTs38owOKnToPgj
         dykfwGlEysQwH2kNAhfpwhD8pmWsyh2wCJRT0BQDhR8iheXGpI2ZjUDsmYJay9FFjdhy
         luAQ==
X-Gm-Message-State: APjAAAWUEDRcM/kdJyiBNcKrc1rE18zmkVBsWE2W0N60Xm12aoAFWXY1
        5V2NcBkXvGrzfClLR9lAnR85GA==
X-Google-Smtp-Source: APXvYqxvSTXg/y63EEPo3Ex9/cwdpbHih/WUeNLGyvSflaAvWNwceNo35Qt9XKCyYdcHlpLbbWsPbQ==
X-Received: by 2002:a63:c30e:: with SMTP id c14mr2497552pgd.168.1582780765502;
        Wed, 26 Feb 2020 21:19:25 -0800 (PST)
Received: from localhost ([223.226.55.170])
        by smtp.gmail.com with ESMTPSA id x7sm1164992pgp.0.2020.02.26.21.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 21:19:24 -0800 (PST)
Date:   Thu, 27 Feb 2020 10:49:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] cpufreq: Fix policy initialization for internal governor
 drivers
Message-ID: <20200227051923.rh6xtq3t2bkoqroh@vireshk-i7>
References: <3873122.F9s1CIEcb3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3873122.F9s1CIEcb3@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-02-20, 22:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Before commit 1e4f63aecb53 ("cpufreq: Avoid creating excessively
> large stack frames") the initial value of the policy field in struct
> cpufreq_policy set by the driver's ->init() callback was implicitly
> passed from cpufreq_init_policy() to cpufreq_set_policy() if the
> default governor was neither "performance" nor "powersave".  After
> that commit, however, cpufreq_init_policy() must take that case into
> consideration explicitly and handle it as appropriate, so make that
> happen.
> 
> Fixes: 1e4f63aecb53 ("cpufreq: Avoid creating excessively large stack frames")
> Link: https://lore.kernel.org/linux-pm/39fb762880c27da110086741315ca8b111d781cd.camel@gmail.com/
> Reported-by: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Note that I'm going to fast-track this patch for 5.6-rc4 which means that
> it will go into my linux-next branch as soon as it shows up in the lists.
> 
> Thanks and sorry for the breakage!
> 
> ---
>  drivers/cpufreq/cpufreq.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1076,9 +1076,17 @@ static int cpufreq_init_policy(struct cp
>  			pol = policy->last_policy;
>  		} else if (def_gov) {
>  			pol = cpufreq_parse_policy(def_gov->name);
> -		} else {
> -			return -ENODATA;
> +			/*
> +			 * In case the default governor is neiter "performance"
> +			 * nor "powersave", fall back to the initial policy
> +			 * value set by the driver.
> +			 */
> +			if (pol == CPUFREQ_POLICY_UNKNOWN)
> +				pol = policy->policy;
>  		}
> +		if (pol != CPUFREQ_POLICY_PERFORMANCE &&
> +		    pol != CPUFREQ_POLICY_POWERSAVE)
> +			return -ENODATA;
>  	}
>  
>  	return cpufreq_set_policy(policy, gov, pol);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
