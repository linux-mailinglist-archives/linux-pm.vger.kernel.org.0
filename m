Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17761B55
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 09:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfGHHog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 03:44:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40717 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGHHog (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 03:44:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so7212211pgj.7
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 00:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6yYLvyLEBI35unTfoBpTYZgBgYmEeKFbJbiIi6+Pm18=;
        b=jrhAt7QHn1hfUTP3COeeH51Er61boYoW+oDIVMrr9COFzd9Upo4q27t48s4EWqhesa
         KU35Ls9UQB0G45UVMerTSq1UJtXZFQ0YLdfSQ85nM3K3OTu4UzbX3fAjwNHPwxiF6i22
         VWG+UdqpRCKTCF9pdkdySwfX2u8PuvZQNWb46wVpftzUmWNaBcyYsyf345kYKJBb/m28
         FzLoPFg2ZkEOGzujoHE7dbijdRbLwq5RDamzdQv7GxV1z1Bbw2MxdeLiX9zp2SJpSxb+
         1rNtxFARtLOqF4CLByMmOpiZIC/Ax2w4yn8VwnjE6QtO5m/DWsujGLML9vga4AY+jYyd
         YXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6yYLvyLEBI35unTfoBpTYZgBgYmEeKFbJbiIi6+Pm18=;
        b=eMG1MFbVILsTgQiVb1Hq4l4ul/xOGecomoT1dlFk9eA42aWnG9kJ3fHBe4f8fw3Uzk
         sA6mpl480IMACCYzWPLj+rsU6+K+FoYptHVfusQARruBOUKshd386vi3V65eoK2RVRlQ
         CGdWT9tRaE0pSEiqAVmmD4CbYbjZrqEpD4mbD5FGsNk5sUZLzkKxzW6popjiJYPrZSOD
         yMEUnaaLpBid9aPqyhKY97Y85zGUaArQVTEqdVXLdb3jnstGFYsGLncmlrb4r+Nq52uQ
         DWtj1k8IDT6wVLR4iE0/FMwnSyC0kg6y2y3SvkNYI/sdtBJ3AZXwy8qjtwMssRMp0DMn
         HFxQ==
X-Gm-Message-State: APjAAAWrJB98VCzxGvlpU+TPMPdf5ZME+SNah3TF9271z7cBzXRQAeDi
        MH72UWXZWvZI6VKS+eW5Njo1l915q0c=
X-Google-Smtp-Source: APXvYqwZWf9LLc+ir3bbSRqwnYrobSk3zS9QKp8UXA6ZaA547Hc+q9BjEik4iR2j0FZUtVmgXY79Og==
X-Received: by 2002:a65:42c3:: with SMTP id l3mr21652248pgp.372.1562571875771;
        Mon, 08 Jul 2019 00:44:35 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id p13sm46332015pjb.30.2019.07.08.00.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 00:44:34 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:14:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <20190708074432.56q2e3ig5ehiee5f@vireshk-i7>
References: <1562570393-8684-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562570393-8684-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-07-19, 15:19, Wen Yang wrote:
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
> v2: clean up the code according to the advice of viresh.
> 
>  drivers/cpufreq/pasemi-cpufreq.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 6b1e4ab..c6d464b 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -128,20 +128,18 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	int cur_astate, idx;
>  	struct resource res;
>  	struct device_node *cpu, *dn;
> -	int err = -ENODEV;
> +	int err;
>  
>  	cpu = of_get_cpu_node(policy->cpu, NULL);
> -
> -	of_node_put(cpu);
>  	if (!cpu)
> -		goto out;
> +		return -ENODEV;
>  


>  	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
>  	if (!dn)
>  		dn = of_find_compatible_node(NULL, NULL,
>  					     "pasemi,pwrficient-sdc");
>  	if (!dn)
> -		goto out;
> +		return -ENODEV;

This change looks incorrect. You still need to drop reference to cpu ?

>  	err = of_address_to_resource(dn, 0, &res);
>  	of_node_put(dn);
>  	if (err)
> @@ -196,6 +194,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = pas_freqs[cur_astate].frequency;
>  	ppc_proc_freq = policy->cur * 1000ul;
>  
> +	of_node_put(cpu);
>  	return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
>  
>  out_unmap_sdcpwr:
> @@ -204,6 +203,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
