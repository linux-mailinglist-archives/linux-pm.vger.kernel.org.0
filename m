Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290B420AE5E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgFZIYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 04:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgFZIYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 04:24:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E5AC08C5C1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 01:24:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so8616856wrn.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R7Evw+hb459XiYsGH+Vi+eNq0D7kmPSCBdf5k4rfVcY=;
        b=q1odrzjyZY1tNyKxp9JyPIk0Pt0zB5Bg+tu8Z+X4nhJvMytgJkjWs1CMXFf0VGk0kB
         JyIvaALMurHhsXifgMI4kN4w3DXEB8ewsGBtx1qX7dPG1LVX0uTl2X2uZj+BzxRjAD9g
         ovA6GpYEIy/zHYsXDzTjEhlnWDggFXNQlRNEQ2K90eLTvrD2IrjIAgv27VwbgRWUBUFu
         wNWIHn0bOcGZDJ+gPbCUHFJEFdxU5epgCFeKxA93JznCr9F6Ua9JuRGJZzjeSlb5h45k
         KIKtSR1WyjM0qmus6ErfDwfIryPra3xxPaEvrYf+blS55f58lhul/jeduGK1wz8huj6t
         zdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7Evw+hb459XiYsGH+Vi+eNq0D7kmPSCBdf5k4rfVcY=;
        b=acacGQJ5TEyinETyiY4mx6H5y8HdNAm/6Z/oXaBIm4XM3Hso6edA3nbzXv54eCjZjL
         qIhWtAUSqxrBBSeIEpOlrHit8xNwTWLqj95hEnECLbqfDSer7hscV4oek8A/DwgJySGM
         5hj2lX0KPHKuSPEsdoYWF88TBA2fAg+61A1emMIr1Ognh9fkQRCsDMUF8WKbuAwajFED
         ZuA9mFyckyF3zukYlQ+tuSgt4KrKfS/Mc/jZblQ2zjeltDTAHktkL1uXZU2Ls+ZtTs8K
         G3faci7dK1/tYdJfqVGhV6LUPvurBBVl5UbJwS4I5PdToePIwbb59exdtuah3l8EyWSg
         qI1w==
X-Gm-Message-State: AOAM530eqGrHwSpj1MDyi9bCU60c7GISRZOMpCUTVnIfIRHTIufZWPUO
        xMVU3rl+Vfm6TrDfHdrWDTWemw==
X-Google-Smtp-Source: ABdhPJzZmGQUKf+yqWXsRV27GJ6qG/7+zFrbPtoOSiYNAxz2SchfIUNtGbFpCYpfhP342BZNjnuRow==
X-Received: by 2002:adf:df03:: with SMTP id y3mr2332182wrl.376.1593159877423;
        Fri, 26 Jun 2020 01:24:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id x1sm10005457wrp.10.2020.06.26.01.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:24:36 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:24:33 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] cpufreq: Fix locking issues with governors
Message-ID: <20200626082433.GA284605@google.com>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
 <f366ed3dd3dd111e42173b366fe4dd5a0e4647fd.1593143118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f366ed3dd3dd111e42173b366fe4dd5a0e4647fd.1593143118.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 26 Jun 2020 at 09:21:42 (+0530), Viresh Kumar wrote:
> The locking around governors handling isn't adequate currently. The list
> of governors should never be traversed without locking in place. Also we
> must make sure the governor isn't removed while it is still referenced
> by code.
> 
> Reported-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 59 ++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0128de3603df..e798a1193bdf 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -621,6 +621,24 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
>  	return NULL;
>  }
>  
> +static struct cpufreq_governor *get_governor(const char *str_governor)
> +{
> +	struct cpufreq_governor *t;
> +
> +	mutex_lock(&cpufreq_governor_mutex);
> +	t = find_governor(str_governor);
> +	if (!t)
> +		goto unlock;
> +
> +	if (!try_module_get(t->owner))
> +		t = NULL;
> +
> +unlock:
> +	mutex_unlock(&cpufreq_governor_mutex);
> +
> +	return t;
> +}
> +
>  static unsigned int cpufreq_parse_policy(char *str_governor)
>  {
>  	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN))
> @@ -640,28 +658,14 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
>  {
>  	struct cpufreq_governor *t;
>  
> -	mutex_lock(&cpufreq_governor_mutex);
> -
> -	t = find_governor(str_governor);
> -	if (!t) {
> -		int ret;
> -
> -		mutex_unlock(&cpufreq_governor_mutex);
> -
> -		ret = request_module("cpufreq_%s", str_governor);
> -		if (ret)
> -			return NULL;
> -
> -		mutex_lock(&cpufreq_governor_mutex);
> +	t = get_governor(str_governor);
> +	if (t)
> +		return t;
>  
> -		t = find_governor(str_governor);
> -	}
> -	if (t && !try_module_get(t->owner))
> -		t = NULL;
> -
> -	mutex_unlock(&cpufreq_governor_mutex);
> +	if (request_module("cpufreq_%s", str_governor))
> +		return NULL;
>  
> -	return t;
> +	return get_governor(str_governor);
>  }
>  
>  /**
> @@ -815,12 +819,14 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
>  		goto out;
>  	}
>  
> +	mutex_lock(&cpufreq_governor_mutex);
>  	for_each_governor(t) {
>  		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
>  		    - (CPUFREQ_NAME_LEN + 2)))
> -			goto out;
> +			break;
>  		i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
>  	}
> +	mutex_unlock(&cpufreq_governor_mutex);
>  out:
>  	i += sprintf(&buf[i], "\n");
>  	return i;
> @@ -1058,11 +1064,14 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  	struct cpufreq_governor *def_gov = cpufreq_default_governor();
>  	struct cpufreq_governor *gov = NULL;
>  	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> +	bool put_governor = false;
> +	int ret;
>  
>  	if (has_target()) {
>  		/* Update policy governor to the one used before hotplug. */
> -		gov = find_governor(policy->last_governor);
> +		gov = get_governor(policy->last_governor);
>  		if (gov) {
> +			put_governor = true;
>  			pr_debug("Restoring governor %s for cpu %d\n",
>  				 policy->governor->name, policy->cpu);
>  		} else if (def_gov) {
> @@ -1089,7 +1098,11 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  			return -ENODATA;
>  	}
>  
> -	return cpufreq_set_policy(policy, gov, pol);
> +	ret = cpufreq_set_policy(policy, gov, pol);
> +	if (put_governor)
> +		module_put(gov->owner);

Nit: I think you could safely do

	if (gov)
		module_put(gov->owner);

and get rid of 'put_governor', given that try_module_get() and
module_put() are nops if owner is NULL (which is guaranteed for
the result of cpufreq_default_governor() as it is builtin).

But other than that:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks!
