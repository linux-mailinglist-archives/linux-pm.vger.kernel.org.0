Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221F462E47
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 04:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGICm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 22:42:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34731 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGICm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 22:42:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so3921699pfo.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N3ZRbdsvjb/D9ul4Io/biNGoMRXfxsqZ68h/ywmeG3w=;
        b=oQuVf51puIsvyNvkx1cQUc0gxF/XXJbXQir1A6N/zGhQ8ZxsvDOE4wU9nDW5TUD+sN
         c7zFsrC//363lNbCHiNN6m5z3e0frziUO4WqR0CZmmNRF87hS+akddpOTWQCFogBwHuP
         jnZIndnU8gtrnd3B+xM9KJ+WaPFc2G4lcbU7l0E44CVObHDIQBnNYAHPYjBhYV0apkSe
         eWrF4V9cAfn/TYGgD29SS2C7A7FEm0arF519pkj3Y3pIAq5CQDBi3yoR+KJ1OkZ0tFoZ
         e4PitwPNZhLrgg1O+tbqmxxUx2yr8yRbjx0KzEYQU0uy2v2rBi4Elr5tpXPoLCmGkjfv
         yAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N3ZRbdsvjb/D9ul4Io/biNGoMRXfxsqZ68h/ywmeG3w=;
        b=a4RUNNTWf18BFBKhiBbWNARJkhAwPw8lS/CXw8ZzNGbzABfC5yvhug2D71sNmXJlbE
         Gq+LfqG4liQW4NZi9PHDkyJanUrGAAuIT/bxq1NnuBl2dolmDJM3iIlcL+221yldyUx9
         x6J43uLCMnePvRGv8eKW6JVcPbi5ps34BwkVx3lMImZ/g9+AeAyM7Pj2NhcNKFYU8HrL
         EDC/dpxDm/Rn2mAuxfZI2cCp8rSFHqkKTnuehix8hrdCsQ4zGtH/Tk9Lhtq/XitRi/PZ
         P2YmZ06UxEiWE7hVoY1vyK0+Jry3HbJwpUO94DoOe+uZDBEUMHp1RXxl8h36SvWb5+CY
         D6cw==
X-Gm-Message-State: APjAAAXn6tqPUuujLNsH+mO5ftfv/Bgbk4heE2+HbHuGnCB3rUoCv30y
        8lsEXpF8pY5nM4ynpX/YO1wRXA==
X-Google-Smtp-Source: APXvYqwXb+lG4wfrVmwIc+3kveiWWNUbdUhgx7Y6Fyih8hmcxfb9FXdcVe7BJVFYRwXkUWHKlhedYg==
X-Received: by 2002:a63:24c1:: with SMTP id k184mr28173703pgk.120.1562640147020;
        Mon, 08 Jul 2019 19:42:27 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 81sm11500964pfx.111.2019.07.08.19.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 19:42:25 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:12:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <20190709024221.evyukzbis6lnok4f@vireshk-i7>
References: <1562629144-13584-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562629144-13584-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-07-19, 07:39, Wen Yang wrote:
> The cpu variable is still being used in the of_get_property() call
> after the of_node_put() call, which may result in use-after-free.
> 
> Fixes: a9acc26b75f ("cpufreq/pasemi: fix possible object reference leak")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v4: restore the blank line.

I don't find it restored in the below code.

> v3: fix a leaked reference.
> v2: clean up the code according to the advice of viresh.
> 
>  drivers/cpufreq/pasemi-cpufreq.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 6b1e4ab..f0c98fc 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -128,20 +128,21 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	int cur_astate, idx;
>  	struct resource res;
>  	struct device_node *cpu, *dn;
> -	int err = -ENODEV;
> +	int err;
>  
>  	cpu = of_get_cpu_node(policy->cpu, NULL);
>  
> -	of_node_put(cpu);
>  	if (!cpu)
> -		goto out;
> +		return -ENODEV;
>  
>  	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
>  	if (!dn)
>  		dn = of_find_compatible_node(NULL, NULL,
>  					     "pasemi,pwrficient-sdc");
> -	if (!dn)
> +	if (!dn) {
> +		err = -ENODEV;
>  		goto out;
> +	}
>  	err = of_address_to_resource(dn, 0, &res);
>  	of_node_put(dn);
>  	if (err)
> @@ -196,6 +197,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = pas_freqs[cur_astate].frequency;
>  	ppc_proc_freq = policy->cur * 1000ul;
>  
> +	of_node_put(cpu);
>  	return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
>  
>  out_unmap_sdcpwr:
> @@ -204,6 +206,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  out_unmap_sdcasr:
>  	iounmap(sdcasr_mapbase);
>  out:
> +	of_node_put(cpu);
>  	return err;
>  }
>  
> -- 
> 2.9.5

-- 
viresh
