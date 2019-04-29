Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D21DB6B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 07:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfD2FPN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 01:15:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46942 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfD2FPM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 01:15:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so4559525pgg.13
        for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2019 22:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIME1K5OMKPPfQtpraZOqL2Q3gyeTv99Vp+Caun75D0=;
        b=kDuax2RabxYq1bY+PtLu3ES6rWjuC7gw/M4tY+SKKmRjrXYdaKM5o8ipuECBox5p6j
         hmlI/2MJwvwxb4DJddtdtWyXPiYiYG4982eZbYbNFo1jPGWZemUuMVH27UsU1+MXTUD3
         iydBtG1z85cD4ErUtGo2VRLGWrU2KEzOgKLryalNFBhF7sVFYdNOAw1IiELnhzWMLA9O
         vgiypRGbvBSrCCT2xHM+XQpjSFmx2T0YyUu+jMxc1rQE3G2nCnpbU9R8EmgOIHE6+hwZ
         pcMZgfbaoYLsSqKHhCQNvx97+uL1HVbQwC8KJMypPAteaB2zZZ/8mB074cKpnz87loVf
         VkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIME1K5OMKPPfQtpraZOqL2Q3gyeTv99Vp+Caun75D0=;
        b=t6E0vARTblEt6tr8/2DeZKXzXwSF+2xqCl6cNmot4/QAWf2Gj405w+02p3qKqVWrLv
         ACFElTzdW/ZGx3G5WuZI/JpJypos1bh1sUWJBFrrAJQ68j1tAxE947I40gogZrFIDiCN
         Bo2QNzvlb7IOD7/eCC4PTgwzDaS+BF1Bc60Fdn0rn/y7sJ5ln+BIymgRbxQM08zYWy76
         UJmN7cq9KF/CgjOgxZhgIY3F82RnAHhNsArgz1OascrSlgrDH5AOyDIjmumWuQPfCHhp
         FixYwcGdugILMsVj/KWWcD43ky0fyfGpWkkO1Qjqewhjq1nA/BSmPUjxcMr1tLccV2/M
         CBCg==
X-Gm-Message-State: APjAAAXoPEF3hErYF25dVmbDYOc3qvU3DkBY5PjWuI0IUEX7plhc/SUt
        3N157zomQj6SPyremM7L9GK5PQ==
X-Google-Smtp-Source: APXvYqwqRr6sATj+rovLxwBoSHlxaCOo43GpTipvozXEPvTgUzonZE4tNXPQZdgxPQNsMQf3BOV16w==
X-Received: by 2002:aa7:9ac2:: with SMTP id x2mr11585597pfp.221.1556514911517;
        Sun, 28 Apr 2019 22:15:11 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id v19sm64007058pfa.138.2019.04.28.22.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 22:15:09 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:45:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH v2] cpufreq: Don't find governor for setpolicy drivers in
 cpufreq_init_policy()
Message-ID: <20190429051507.cabsr62rhc5evka5@vireshk-i7>
References: <20190426063135.5200-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426063135.5200-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-04-19, 14:31, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> In cpufreq_init_policy() we will check if there's last_governor for target
> and setpolicy type. However last_governor is set only if has_target() is
> true in cpufreq_offline(). That means find last_governor for setpolicy
> type is pointless. Also new_policy.governor will not be used if ->setpolicy
> callback is set in cpufreq_set_policy().
> 
> Moreover, there's duplicate ->setpolicy check in using default policy path.
> Let's add a new helper function to avoid it. Also fix a little comment.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
> v2: fix ->setplicy typo.
> 
>  drivers/cpufreq/cpufreq.c | 66 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0322cce..b822a3e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -578,6 +578,20 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
>  	return NULL;
>  }
>  
> +static int cpufreq_parse_static_governor(char *str_governor,
> +					struct cpufreq_policy *policy)
> +{
> +	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
> +		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> +		return 0;
> +	}
> +	if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
> +		policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>  /**
>   * cpufreq_parse_governor - parse a governor string
>   */
> @@ -585,15 +599,7 @@ static int cpufreq_parse_governor(char *str_governor,
>  				  struct cpufreq_policy *policy)
>  {

There were only two callers of cpufreq_parse_governor() and one of them you have
removed already.

>  	if (cpufreq_driver->setpolicy) {
> -		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
> -			policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> -			return 0;
> -		}
> -
> -		if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
> -			policy->policy = CPUFREQ_POLICY_POWERSAVE;
> -			return 0;
> -		}
> +		return cpufreq_parse_static_governor(str_governor, policy);

So I will rather remove above completely from here and let
cpufreq_parse_governor() governor only handle !set_policy.

>  	} else {
>  		struct cpufreq_governor *t;
>  
> @@ -1020,32 +1026,40 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
>  
>  static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  {
> -	struct cpufreq_governor *gov = NULL;
> +	struct cpufreq_governor *gov = NULL, *def_gov = NULL;
>  	struct cpufreq_policy new_policy;
>  
>  	memcpy(&new_policy, policy, sizeof(*policy));
>  
> -	/* Update governor of new_policy to the governor used before hotplug */
> -	gov = find_governor(policy->last_governor);
> -	if (gov) {
> -		pr_debug("Restoring governor %s for cpu %d\n",
> +	def_gov = cpufreq_default_governor();
> +
> +	if (has_target()) {
> +		/*
> +		 * Update governor of new_policy to the governor used before
> +		 * hotplug
> +		 */
> +		gov = find_governor(policy->last_governor);
> +		if (gov)

You must use {} here in the if block as well for two reasons:
- Below pr_debug is across multiple lines
- And else part already uses {}

> +			pr_debug("Restoring governor %s for cpu %d\n",
>  				policy->governor->name, policy->cpu);
> +		else {
> +			if (!def_gov)
> +				return -ENODATA;
> +			gov = def_gov;
> +		}
> +		new_policy.governor = gov;
>  	} else {
> -		gov = cpufreq_default_governor();
> -		if (!gov)
> -			return -ENODATA;
> -	}
> -
> -	new_policy.governor = gov;
> -
> -	/* Use the default policy if there is no last_policy. */
> -	if (cpufreq_driver->setpolicy) {
> +		/* Use the default policy if there is no last_policy. */
>  		if (policy->last_policy)
>  			new_policy.policy = policy->last_policy;
> -		else
> -			cpufreq_parse_governor(gov->name, &new_policy);
> +		else {
> +			if (!def_gov)
> +				return -ENODATA;
> +			cpufreq_parse_static_governor(def_gov->name,
> +						      &new_policy);
> +		}
>  	}
> -	/* set default policy */
> +	/* Set new policy */

Just drop the comment and make it a blank line.

>  	return cpufreq_set_policy(policy, &new_policy);
>  }
>  
> -- 
> 1.9.1

-- 
viresh
