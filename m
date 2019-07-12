Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2AA6652B
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 05:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfGLDoN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 23:44:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43065 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbfGLDoN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 23:44:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so3882518pgv.10
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 20:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FJEg1PSZtBDvEUaB1tANRkyXMe9y2BhABHvlVqK15CM=;
        b=om4dUHnrAVTcB6VZSX3QaRGG8cW4pe28ysXcQAfegtJ9471WnmQy48pbF/6w4twSkP
         g9C0CVRJtW+e4mKQ9V6wimOpulHkGb76sMC5DttiDZD22y2T60DwP/IUSYghEFaRj5ZM
         gLtjjXwnDsEdq4Qtn44XjgYZPKez0Z3HjMw8mbzgaZ8WDnLepMfeX/+tVUp8ehaxdI2q
         Du90ZLjjAGk//30F6fGpSGHt3jsHLnNtKHLwSgw50p019+YT7qel+pJid5MwWqap7MfP
         VrCNXES1a3iO02buE5VDyxiA3wv7mC6iAeYra06n4kss0+U81cJ7sGedf7kn6BhBM8cQ
         ZDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FJEg1PSZtBDvEUaB1tANRkyXMe9y2BhABHvlVqK15CM=;
        b=Suh1yHelmR+D5EjGUald48v+YfSt0JwQD6MhzeaMhO912t6B8cJv8uWEGn4QLlDbV8
         UEExM92d2Sg0Yq5Yd4FKiT8Cix0A7PXRqiaMZukHzBMJVvPgKsZ0cPjKkW3wDKPj35JM
         gaz3B0Ua3jT9I7XxCUPR7sCGI3cxkOFfTgC1DT+LEFWl0o+XywF81CbsYPzuPO9yUpcb
         vti8SgMHnE7e5w9yR8L1zjdXspBbvzgTCZGv0b3UN02lEO84z3rwhgNT0cJMs0n0mDMT
         AE4ilh42awffSdXMJ8V5+oBuAIcdfxwBgceOJLFK6xZSsbFeG7moqFt0NauhoNm2nden
         CgyQ==
X-Gm-Message-State: APjAAAWUykAWSJ5COL0YsCC3bTR691C0toRP+jR7/tqgPFrSC3SdwbNN
        Ioc1ZH0gzDQWDH2IcYZBN38C8Q==
X-Google-Smtp-Source: APXvYqy9857Wgh/Qw5sD0c6p/uGpEMX3EoZjvjany601DZQGRDvfT7z/hTLtd+HWVqwjoJjgYV9amw==
X-Received: by 2002:a63:c342:: with SMTP id e2mr8105277pgd.79.1562903052070;
        Thu, 11 Jul 2019 20:44:12 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 201sm9836656pfz.24.2019.07.11.20.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 20:44:11 -0700 (PDT)
Date:   Fri, 12 Jul 2019 09:14:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     rjw@rjwysocki.net, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <20190712034409.zyl6sskrr6ra5nd3@vireshk-i7>
References: <1562899461-24045-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562899461-24045-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-07-19, 10:44, Wen Yang wrote:
> The cpu variable is still being used in the of_get_property() call
> after the of_node_put() call, which may result in use-after-free.
> 
> Fixes: a9acc26b75f6 ("cpufreq/pasemi: fix possible object reference leak")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v6: keep the blank line and fix warning: label 'out_unmap_sdcpwr' defined but not used.
> v5: put together the code to get, use, and release cpu device_node.
> v4: restore the blank line.
> v3: fix a leaked reference.
> v2: clean up the code according to the advice of viresh.
> 
>  drivers/cpufreq/pasemi-cpufreq.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 6b1e4ab..7d557f9 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -131,10 +131,18 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	int err = -ENODEV;
>  
>  	cpu = of_get_cpu_node(policy->cpu, NULL);
> +	if (!cpu)
> +		goto out;
>  
> +	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
>  	of_node_put(cpu);
> -	if (!cpu)
> +	if (!max_freqp) {
> +		err = -EINVAL;
>  		goto out;
> +	}
> +
> +	/* we need the freq in kHz */
> +	max_freq = *max_freqp / 1000;
>  
>  	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
>  	if (!dn)
> @@ -171,16 +179,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  
>  	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
> -
> -	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
> -	if (!max_freqp) {
> -		err = -EINVAL;
> -		goto out_unmap_sdcpwr;
> -	}
> -
> -	/* we need the freq in kHz */
> -	max_freq = *max_freqp / 1000;
> -
>  	pr_debug("max clock-frequency is at %u kHz\n", max_freq);
>  	pr_debug("initializing frequency table\n");
>  
> @@ -196,7 +194,11 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = pas_freqs[cur_astate].frequency;
>  	ppc_proc_freq = policy->cur * 1000ul;
>  
> -	return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
> +	err = cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());

So you are trying to fix an earlier issue here with this. Should have
been a separate patch. Over that I have just sent a patch now to make
this routine return void.

https://lore.kernel.org/lkml/ee8cf5fb4b4a01fdf9199037ff6d835b935cfd13.1562902877.git.viresh.kumar@linaro.org/

So all you need to do is to remove the label out_unmap_sdcpwr instead.

> +	if (err)
> +		goto out_unmap_sdcpwr;
> +
> +	return 0;
>  
>  out_unmap_sdcpwr:
>  	iounmap(sdcpwr_mapbase);
> -- 
> 2.9.5

-- 
viresh
