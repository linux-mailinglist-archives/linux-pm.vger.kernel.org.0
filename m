Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841D446571
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfFNROy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 13:14:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44285 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfFNROy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 13:14:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so1823914pfe.11
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r5tXhiANsxn6YQdl37418WiLHhdChm3AD299PfiCsoU=;
        b=NbXyTVK3WaxmIeOt1OopzS29eKK5sL0zVVNJL08beb9YGBPHrdMbO43tYK1Gb99EyA
         S9hkqIewhwbzU0RvY8QzoINoWW3/iA5SsDzApt/AWknhXmBJHBWWa0UksTvw7a3OpCOz
         /eZiD50teroJQ2NCRVjKhypUDil5wslWZEWsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r5tXhiANsxn6YQdl37418WiLHhdChm3AD299PfiCsoU=;
        b=k0MwkkUXb4MMeUs3mdlwrsTmmmlUynF2HYiT2ZUB9BJglRtWiWD0/L6AWKi23+Ocus
         dVmpllCgsfkJh15iyBsYNw7n8W8mbrJWuBg4jojsY83aFR6A8rTKyYmsXhrK0doNDZu/
         +OQlaa6qhBrhO1J8K+yDPY9u9J5CTDLIER95YxKhMqzpB8nVmjsRFoVfIcThCRqQ0a4y
         B6cnwWfIfFQ0fMWMOAQbB5uBxG/1E7fGVp40pp+lf5EOdwW5MnjW7c4Z/ORnBRsBjOFT
         69yn88QVrIrqrfB+MeKNxY4On0Ic4412vmUiDyCkrU9RYisfmUqdnTfq1zorRpJ9Udmd
         B+Og==
X-Gm-Message-State: APjAAAVaPISeVpZnGdR4+lVne7xeEWv8bvkPnUNu76ABp8x8p3Oogrq/
        oJuAXABtb+1ce8ccv8srPRLpRxmmX3w=
X-Google-Smtp-Source: APXvYqxsi04hmYAh6uAF7MpkalRo5RRTNCaD8ZvmYUW26pTiZVJfnw21mkvJkIZ5A+XCCpS6vgQHlQ==
X-Received: by 2002:a17:90a:1b48:: with SMTP id q66mr11665697pjq.83.1560532493642;
        Fri, 14 Jun 2019 10:14:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l44sm3870729pje.29.2019.06.14.10.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 10:14:52 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:14:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/5] cpufreq: Add QoS requests for userspace
 constraints
Message-ID: <20190614171450.GQ137143@google.com>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <d1a7585539ad2ced2bfcc9e232cf859b1ec9c71a.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1a7585539ad2ced2bfcc9e232cf859b1ec9c71a.1560163748.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Mon, Jun 10, 2019 at 04:21:36PM +0530, Viresh Kumar wrote:
> This implements QoS requests to manage userspace configuration of min
> and max frequency.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 92 +++++++++++++++++++--------------------
>  include/linux/cpufreq.h   |  8 +---
>  2 files changed, 47 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 547d221b2ff2..ff754981fcb4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -720,23 +720,15 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>  static ssize_t store_##file_name					\
>  (struct cpufreq_policy *policy, const char *buf, size_t count)		\
>  {									\
> -	int ret, temp;							\
> -	struct cpufreq_policy new_policy;				\
> +	unsigned long val;						\
> +	int ret;							\
>  									\
> -	memcpy(&new_policy, policy, sizeof(*policy));			\
> -	new_policy.min = policy->user_policy.min;			\
> -	new_policy.max = policy->user_policy.max;			\
> -									\
> -	ret = sscanf(buf, "%u", &new_policy.object);			\
> +	ret = sscanf(buf, "%lu", &val);					\
>  	if (ret != 1)							\
>  		return -EINVAL;						\
>  									\
> -	temp = new_policy.object;					\
> -	ret = cpufreq_set_policy(policy, &new_policy);		\
> -	if (!ret)							\
> -		policy->user_policy.object = temp;			\
> -									\
> -	return ret ? ret : count;					\
> +	ret = dev_pm_qos_update_request(policy->object##_freq_req, val);\
> +	return ret && ret != 1 ? ret : count;				\

nit: I wonder if

  return (ret >= 0) ? count : ret;

would be clearer.

Other than that:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
