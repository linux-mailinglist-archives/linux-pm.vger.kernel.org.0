Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742E418B109
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 11:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgCSKS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 06:18:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50372 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSKS2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 06:18:28 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 723c13f3574c4ab3; Thu, 19 Mar 2020 11:18:26 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, pratik.r.sampat@gmail.com,
        ego@linux.vnet.ibm.com, dja@axtens.net,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: powernv: Fix frame-size-overflow in powernv_cpufreq_work_fn
Date:   Thu, 19 Mar 2020 11:18:26 +0100
Message-ID: <1921198.IfoiWgUDIW@kreacher>
In-Reply-To: <20200316135743.57735-1-psampat@linux.ibm.com>
References: <20200316135743.57735-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, March 16, 2020 2:57:43 PM CET Pratik Rajesh Sampat wrote:
> The patch avoids allocating cpufreq_policy on stack hence fixing frame
> size overflow in 'powernv_cpufreq_work_fn'
> 
> Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

Any objections or concerns here?

If not, I'll queue it up.

> ---
>  drivers/cpufreq/powernv-cpufreq.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 56f4bc0d209e..20ee0661555a 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -902,6 +902,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
> +	struct cpufreq_policy *policy;
>  	unsigned int cpu;
>  	cpumask_t mask;
>  
> @@ -916,12 +917,14 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
>  	chip->restore = false;
>  	for_each_cpu(cpu, &mask) {
>  		int index;
> -		struct cpufreq_policy policy;
>  
> -		cpufreq_get_policy(&policy, cpu);
> -		index = cpufreq_table_find_index_c(&policy, policy.cur);
> -		powernv_cpufreq_target_index(&policy, index);
> -		cpumask_andnot(&mask, &mask, policy.cpus);
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			continue;
> +		index = cpufreq_table_find_index_c(policy, policy->cur);
> +		powernv_cpufreq_target_index(policy, index);
> +		cpumask_andnot(&mask, &mask, policy->cpus);
> +		cpufreq_cpu_put(policy);
>  	}
>  out:
>  	put_online_cpus();
> 




