Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9862B58BC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 05:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgKQEP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 23:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgKQEP7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 23:15:59 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E43C0617A6
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 20:15:59 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id m9so5579689pgb.4
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 20:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5lv6RfP8qJF5zkeuOHJR2hccKAcSS2SlN9owQue64IU=;
        b=CsMzAUSREoHBdOFlF17Kh8CLBA0AOwM7j9djxKPsNMLczyCCKIrDjqJypaW6xrc73j
         BcQyU9ga/xqoTAQHq8b22DznzWXVX+olP97SKTMInqsim2q5A2Sc4qpEeTJcbZNCJlqN
         gxlO8zY3VjlZOwbn4WVZt8QswZ0lbWsqCevhyd1RagEUzh+sbZs7uzqcSS4rsKp7/Bqn
         QrJa0jxAY9duJ+c3wZqwNFs6xo8vpBfamCdHtDwrShSsHbJBIUO7BuclicfWqBzFFtQV
         iH0WsmGLyMTQQl2sEkC0XVH1JlcacAi7bTR7E4oVbYKTunOoTQmfGG1MEn04IIagMeqQ
         Mmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5lv6RfP8qJF5zkeuOHJR2hccKAcSS2SlN9owQue64IU=;
        b=hRegrgbOjoTb3dZJVtLzF3OvaRAUVwXA26bsGU5qKAOFC3Uz0PLZ4IjEYC7eUAU+N9
         aY4Opm9Dp+uCFDH6KmVvOTR+cVE+TMyZgaxAguPDPSqjSjpBe2ONzcaAOkNbKMTKrmIz
         RY7Oo145f0Rl0V7eFWHe+tI0Ah0G2isHAMUbHIt3uRSBOr0YOyLouV6YIV/9/rkv2UlV
         Bs5vP8cqCZbuMVSk1Zsf9VjgkDe/HSscpee4s1t4OBxEE03931iGSVIYvwjjInMTMX/Z
         pNjG52cWF25tmFHGHxo7wptxV7HGAMIRp1r7ZZ8EIXdfySrlWTAcHavZ1R1aY3fFsqVA
         lnfA==
X-Gm-Message-State: AOAM532w0Z8HVk//QZ7tEBgAzjQx2Vl03Ki7Q82Rx5dFt8juVNJVL6LZ
        c7p4JOHpzc+DuVt52wE9BsfWBi43QRMFTQ==
X-Google-Smtp-Source: ABdhPJxZI7TLqwlvaZVVQPdPJ1Gdy8UhRZbKM9zVBUc3nS3eQPpIbSfErrRc2XuX/2Su3/fPCDTuOw==
X-Received: by 2002:a62:5e06:0:b029:164:a9ca:b07e with SMTP id s6-20020a625e060000b0290164a9cab07emr16459338pfb.36.1605586558858;
        Mon, 16 Nov 2020 20:15:58 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 131sm3889341pfw.117.2020.11.16.20.15.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 20:15:58 -0800 (PST)
Date:   Tue, 17 Nov 2020 09:45:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] cpufreq: schedutil: Simplify sugov_update_next_freq()
Message-ID: <20201117041555.s6x7wpjpnhfq7y3m@vireshk-i7>
References: <25503091.Kiabxektef@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25503091.Kiabxektef@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-11-20, 20:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rearrange a conditional to make it more straightforward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -102,12 +102,10 @@ static bool sugov_should_update_freq(str
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
> -	if (!sg_policy->need_freq_update) {
> -		if (sg_policy->next_freq == next_freq)
> -			return false;
> -	} else {
> +	if (sg_policy->need_freq_update)
>  		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> -	}
> +	else if (sg_policy->next_freq == next_freq)
> +		return false;
>  
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
