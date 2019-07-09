Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8FA62FBC
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 06:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfGIErG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 00:47:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfGIErG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jul 2019 00:47:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jVCq5LvKz9sMQ;
        Tue,  9 Jul 2019 14:47:03 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq/pasemi: fix an use-after-free in pas_cpufreq_cpu_init()
In-Reply-To: <1562575726-17438-1-git-send-email-wen.yang99@zte.com.cn>
References: <1562575726-17438-1-git-send-email-wen.yang99@zte.com.cn>
Date:   Tue, 09 Jul 2019 14:47:03 +1000
Message-ID: <87muhnhl14.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Wen Yang <wen.yang99@zte.com.cn> writes:

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
> v3: fix a leaked reference.
> v2: clean up the code according to the advice of viresh.
>
>  drivers/cpufreq/pasemi-cpufreq.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 6b1e4ab..9dc5163 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -128,20 +128,20 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
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

I don't think introducing another exit path is an improvement.

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
> @@ -196,6 +196,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = pas_freqs[cur_astate].frequency;
>  	ppc_proc_freq = policy->cur * 1000ul;
>  
> +	of_node_put(cpu);
>  	return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
>  
>  out_unmap_sdcpwr:
> @@ -204,6 +205,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  out_unmap_sdcasr:
>  	iounmap(sdcasr_mapbase);
>  out:
> +	of_node_put(cpu);
>  	return err;
>  }

Notice that cpu is only used for the max_freq calculation, so we could
instead do:

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 6b1e4abe3248..42a0a4b8e87d 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -131,11 +131,20 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	int err = -ENODEV;
 
 	cpu = of_get_cpu_node(policy->cpu, NULL);
-
-	of_node_put(cpu);
 	if (!cpu)
 		goto out;
 
+	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
+	if (!max_freqp) {
+		of_node_put(cpu);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* we need the freq in kHz */
+	max_freq = *max_freqp / 1000;
+	of_node_put(cpu);
+
 	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
 	if (!dn)
 		dn = of_find_compatible_node(NULL, NULL,
@@ -172,15 +181,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
 
-	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
-	if (!max_freqp) {
-		err = -EINVAL;
-		goto out_unmap_sdcpwr;
-	}
-
-	/* we need the freq in kHz */
-	max_freq = *max_freqp / 1000;
-
 	pr_debug("max clock-frequency is at %u kHz\n", max_freq);
 	pr_debug("initializing frequency table\n");
 

Though arguably this function should hold a reference to cpu anyway,
because it doesn't want the CPU to removed out from under it. It's a
CPUfreq driver after all.

cheers
