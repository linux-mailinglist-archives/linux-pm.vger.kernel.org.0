Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3C061C7D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfGHJhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 05:37:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33220 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfGHJhn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 05:37:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so7948708plo.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 02:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vedL+wIoU+mEdWmUG13/OZVf8QdxKuBQKUVoH2fXU0A=;
        b=YNFX47lL3EYgQ0NYvCwcpd08U68G9uyruglWm6phhQHgxmjTLlD8nlyn72p9gzEKqx
         Xpfpgb8//dtNgAXH1WaOjCyVG1WfdmvOQJTyX+Kn4oNbHxnjiy3Emka2mYXXG8R+g6o3
         d0qxK+fdbjkdYNzjpngJcF9Y/b07k5k1RMhw9Y2G9bmGeBQFJT9B7xP6u1ukjBy3N99f
         vsuLnPBI58PijSAqW28wu6AoEHVku0BeA8d1+wYgQ/IA2c+UKkKiva0NPK8ROC6x2M61
         rJoeUbhEnGaV5YnxhNe+454Qnk7xC5/bpLl6V6ps9geHmL4vQJBI4Nic+BXvsq4eXND9
         OaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vedL+wIoU+mEdWmUG13/OZVf8QdxKuBQKUVoH2fXU0A=;
        b=DqGxGiV16V9zn3zlNVd+ZvdD0KzWmH7XjiyKAVClkpeLrnd8n9EakTJS1CCSUNpw0E
         aBEWXI1+Hti1dFLi9UAbKiXsCK6xMOMbcfK5usRl+LB8tNoT66EhegJxhIshlTpP+G6p
         coJhEMeZ2xxB1MJMkfP2yHWda5G+f0/3G2slVQUqT337N1OrbBJFGwk5PvCJ2ZawQmUH
         GPnWm194mLGf93Gh7fqtuicRaqJ7n4bRyr2K3H+G3GamehWEC31nO4bsuwYpt2myyZ8y
         tUaR4FLmMP9BjN1kR0DDciBvaEUtlY1UOdSKdduCJvQQLzq+6N0CaeQN7ljSkRhEtKHj
         cCYg==
X-Gm-Message-State: APjAAAVfUKem7x1QnxLTfpoDemiE7jYEFd7HC3/0lESAeD8NVM2SaZiN
        fgUesnFNGpojUYP+u2DVnJVtWA==
X-Google-Smtp-Source: APXvYqwydc3vWShp+4az6iGvABfR12RwY+U4spCpYv26wrM7dwJS2xSGhHHDwjWoNCNoM6WyYjs79A==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr23195899pls.256.1562578662575;
        Mon, 08 Jul 2019 02:37:42 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id m4sm35996014pff.108.2019.07.08.02.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 02:37:41 -0700 (PDT)
Date:   Mon, 8 Jul 2019 15:07:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: Fix covert rate_limit_us to
 freq_update_delay_ns overflow
Message-ID: <20190708093740.pbcnl7ytjmmpy3bz@vireshk-i7>
References: <1562575583-99575-1-git-send-email-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562575583-99575-1-git-send-email-zhangxiaoxu5@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-07-19, 16:46, ZhangXiaoxu wrote:
> When covert rate_limit_us to freq_update_delay_ns, it maybe overflow
> and lead an undefined behavior.

freq_update_delay_ns is s64, still overflow can happen ?

> So, limit the rate_limit_us to UINT_MAX / NSEC_PER_USEC.
> 
> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 962cf34..01e05f3 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -590,6 +590,9 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
>  	if (kstrtouint(buf, 10, &rate_limit_us))
>  		return -EINVAL;
>  
> +	if (rate_limit_us > UINT_MAX / NSEC_PER_USEC)
> +		return -EINVAL;
> +
>  	tunables->rate_limit_us = rate_limit_us;
>  
>  	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
> -- 
> 2.7.4

-- 
viresh
