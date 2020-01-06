Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33800130D41
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 06:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgAFFsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 00:48:14 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34464 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgAFFsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 00:48:14 -0500
Received: by mail-pj1-f65.google.com with SMTP id s94so4052826pjc.1
        for <linux-pm@vger.kernel.org>; Sun, 05 Jan 2020 21:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ittmWLzoiwbYfzA04b4FRh3oV8Mt00ekdOIO1DGBia4=;
        b=PCgb8ZzsvivfjE9d60WEMDMyQbNBzEHv5fBK7m3g+KRKmJWigbH5K1vjI2ggSi7juH
         HZhxqwZvLlxCGMbISviW9+xituKp0g0kxYOff5eS7vH2ZjXUOm2g1g6i/UDEiUaB6ga4
         HWKRqfxhjX6jwLoDoTY5NRJpWervYA1ksV0EESrmsJX8eZUly31FDgtdL4x2rv3y+QjF
         ppQA3qywUSgo6nlLkTaBFRp48rA1AtwpypHyQsb/2ggxnfe/mPfSEx5qOxc/aYYW6APm
         aMzObXB6sDp7jt7vOWa2wDlO2JX8yi1QnBLwF4ZSGVkbXA3X5GxaNKC4XB6LuqQ9w8R3
         Upvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ittmWLzoiwbYfzA04b4FRh3oV8Mt00ekdOIO1DGBia4=;
        b=BTPtYs2/9GqBn2omJPWKugnw+NxImVegK7wOdV9l2FjdoblVTBTg8LY7NrqRHL0PNe
         vvCBuD/+H1w+uhXmr4U8ZhOqXJIssVWDYCbWgSA8ND0T5EGt95YcWtwFLmZhtiVPnERc
         rpysBuI3zfZYrrG/z8p4cW1CRbOxXE54IeLN/q/7KyY/+MnZKhBnIEt0l+jDycNF4xvo
         sYqru5HuPy8r+Bgf8RYkitYZ0vUKQpplJ+P84RP9evWxzwuu9qGBAYU5FScYYVbZbv0m
         NqnJJfbgegnMEu9LPUPvyEORnrbNnspITaDR/CO2fmWoKtYSowFd/qS6O8lqo0L8OmQP
         CJTg==
X-Gm-Message-State: APjAAAVh6vNVva9rCuUYHoudYmWDWTMtAqBKnvG6BnY1WwOgrZJ4n3rA
        5Gf6b7dsJOtLiMhWIMaH7F2+7pvWZls=
X-Google-Smtp-Source: APXvYqzY7Y/N3u1EIAlYonSqEdQqQr5D/DGlIXfcIAtx/yQ+I9zoC0IR+vPRp+fuNusv/Ptc8RdGSA==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr41233347pji.63.1578289693795;
        Sun, 05 Jan 2020 21:48:13 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id 64sm73939461pfd.48.2020.01.05.21.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 21:48:13 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:18:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qiwuchen55@gmail.com
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] cpufreq: s3c: avoid use after free issue in
 xxx_cpufreq_reboot_notifier_evt()
Message-ID: <20200106054811.uduf2qdn5ecvbwrc@vireshk-i7>
References: <1577515439-14477-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577515439-14477-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-12-19, 14:43, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> There is a potential UAF issue in xxx_cpufreq_reboot_notifier_evt() that
> the cpufreq policy of cpu0 has been released before using it. So we should
> make a judgement to avoid it.

There is no UAF problem here, but that we do cpufreq_cpu_get() with a
corresponding cpufreq_cpu_put().

> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/cpufreq/s3c2416-cpufreq.c | 11 ++++++++++-
>  drivers/cpufreq/s5pv210-cpufreq.c | 10 +++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
> index 1069103..0f576ba 100644
> --- a/drivers/cpufreq/s3c2416-cpufreq.c
> +++ b/drivers/cpufreq/s3c2416-cpufreq.c
> @@ -304,6 +304,7 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
>  {
>  	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
>  	int ret;
> +	struct cpufreq_policy policy;
>  
>  	mutex_lock(&cpufreq_lock);
>  
> @@ -318,7 +319,15 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
>  	 */
>  	if (s3c_freq->is_dvs) {
>  		pr_debug("cpufreq: leave dvs on reboot\n");
> -		ret = cpufreq_driver_target(cpufreq_cpu_get(0), FREQ_SLEEP, 0);
> +
> +		memset(&policy, 0, sizeof(policy));
> +		ret = cpufreq_get_policy(&policy, 0);
> +		if (ret < 0) {
> +			pr_debug("cpufreq: get no policy for cpu0\n");
> +			return NOTIFY_BAD;
> +		}
> +

This doesn't make sense to me, why don't you do cpufreq_cpu_get() and
put() instead ?

> +		ret = cpufreq_driver_target(&policy, FREQ_SLEEP, 0);
>  		if (ret < 0)
>  			return NOTIFY_BAD;
>  	}
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 5d10030..d99b4b1 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -555,8 +555,16 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
>  						 unsigned long event, void *ptr)
>  {
>  	int ret;
> +	struct cpufreq_policy *policy;
>  
> -	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
> +	policy = cpufreq_cpu_get(0);
> +	if (!policy) {
> +		pr_debug("cpufreq: get no policy for cpu0\n");
> +		return NOTIFY_BAD;
> +	}
> +
> +	ret = cpufreq_driver_target(policy, SLEEP_FREQ, 0);
> +	cpufreq_cpu_put(policy);

Like what is done here.

Also add a blank line here.

>  	if (ret < 0)
>  		return NOTIFY_BAD;
>  
> -- 
> 1.9.1

-- 
viresh
