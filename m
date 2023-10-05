Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5FF7B9F74
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJEOYv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Oct 2023 10:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjJEOWi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2023 10:22:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEDE23D15
        for <linux-pm@vger.kernel.org>; Thu,  5 Oct 2023 04:03:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c61acd1285so5491735ad.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Oct 2023 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696503804; x=1697108604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlcMpFTEGkun5fY2EQzH5O3YtCneY5PYvuzDAb/3BCc=;
        b=Ifsau/CbOFHhHiKCQCz/Un93uMTQsNKQa8mYyAoCqpnJoNr9zELfRZ2Q9OpJrDPfAG
         dNGNA8Z2QuGNIDx8Rb8S1zUUdhZORX7hDwwcjMX5drTvviABmjnEaKFbZQybnY6JErQM
         wrX0AeLfwOGjrRwtDyrfuKZuR5vPnH/9/eqo0TD9BXM4A2Py1wmMSyCxIFdGu30KVy/X
         b5LXMYnK5YmsEKnOu5YcCu4J8UxEgEL3gGWBXhXck4bTcO5vI/v7IdrPn1mlnhrKMQio
         Hs7UIHUjiRCkakY/e8DdpgtNA68AHyHOjbYgE9zmt6XA7kzy78IBotNd589Y8B6Bq2F1
         BwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696503804; x=1697108604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlcMpFTEGkun5fY2EQzH5O3YtCneY5PYvuzDAb/3BCc=;
        b=LyoufthdswTmNmJDfDIhqQe72Qw9W4czPcvqMr8lv4ASVFBHG4ge3GnZRMj36NJDur
         n2bVUPqNSYocC97+hzbsFxg/nXKcii6qtkFtvjKiZiaIfhSe9fdJMz2CkftLJaMrRYeC
         FZtWFsPaYxSOKDBzg5ENkvvhGx86rrSTxCsdhlkO9hHH41jRUI1Zm7fW7CeCXgifILTo
         a7SfioTjVRHcnd+4Y+CuGoHA1ernpgD3woW4JSscHSS4CZQbJHyTLAhlMDxhclxh4Eit
         EBbD7o0Eddgy4HgKgjGqxEWDlrNiMWZqI9lg6Ym1+j86D86ee3ePmn7czFZRgWdESWNn
         GJBA==
X-Gm-Message-State: AOJu0YzE0RHP9QCoAkK0qYbW2gExICa4fhT0PKvTHl3yYFHSGxEj7OZp
        C+kbSBanH6J6UBJ57USk29w21w==
X-Google-Smtp-Source: AGHT+IEE30y5cggjo7TIaKZK9gXoRYY8q0eXCt0k1bfV/W+365AotNoCtt2rx3tPShczRgXukld3bQ==
X-Received: by 2002:a17:902:6bc1:b0:1c3:6e38:3943 with SMTP id m1-20020a1709026bc100b001c36e383943mr4092169plt.56.1696503803794;
        Thu, 05 Oct 2023 04:03:23 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001b89536974bsm1351261pll.202.2023.10.05.04.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 04:03:23 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:33:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: userspace: Move is_managed indicator into
 per-policy structure
Message-ID: <20231005110321.ythrdcueqwjrksbq@vireshk-i7>
References: <20230912061057.2516963-1-liaochang1@huawei.com>
 <20230912061057.2516963-2-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912061057.2516963-2-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-09-23, 06:10, Liao Chang wrote:
> The userspace governor use the 'cpu' field of cpufreq_policy structure
> to track if it is allowed to set the speed of policy.  However, there is
> a window where the 'cpu' field is equal to the value of nr_cpus_id when
> all affected CPUs of policy are offline, which is an illegal value to
> get the per-CPU variable. To avoid this issue, this patch uses a
> per-policy indicator to track if the policy is managed.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_userspace.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
> index 442e31060d62..2c42fee76daa 100644
> --- a/drivers/cpufreq/cpufreq_userspace.c
> +++ b/drivers/cpufreq/cpufreq_userspace.c
> @@ -15,9 +15,8 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  
> -static DEFINE_PER_CPU(unsigned int, cpu_is_managed);
> -
>  struct userspace_policy {
> +	unsigned int is_managed;
>  	unsigned int setspeed;
>  	struct mutex mutex;
>  };
> @@ -37,7 +36,7 @@ static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
>  	pr_debug("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
>  
>  	mutex_lock(&userspace->mutex);
> -	if (!per_cpu(cpu_is_managed, policy->cpu))
> +	if (!userspace->is_managed)
>  		goto err;
>  
>  	userspace->setspeed = freq;
> @@ -85,7 +84,7 @@ static int cpufreq_userspace_policy_start(struct cpufreq_policy *policy)
>  	pr_debug("started managing cpu %u\n", policy->cpu);
>  
>  	mutex_lock(&userspace->mutex);
> -	per_cpu(cpu_is_managed, policy->cpu) = 1;
> +	userspace->is_managed = 1;
>  	userspace->setspeed = policy->cur;
>  	mutex_unlock(&userspace->mutex);
>  	return 0;
> @@ -98,7 +97,7 @@ static void cpufreq_userspace_policy_stop(struct cpufreq_policy *policy)
>  	pr_debug("managing cpu %u stopped\n", policy->cpu);
>  
>  	mutex_lock(&userspace->mutex);
> -	per_cpu(cpu_is_managed, policy->cpu) = 0;
> +	userspace->is_managed = 0;
>  	userspace->setspeed = 0;
>  	mutex_unlock(&userspace->mutex);
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
