Return-Path: <linux-pm+bounces-11234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC8937083
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 00:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F2EB21556
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E5145B30;
	Thu, 18 Jul 2024 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhOmgyuM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8131459ED;
	Thu, 18 Jul 2024 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340204; cv=none; b=MaFsPYGoKYmVXLwQLk+JawOqtXi1ljzWFp7p+UivLkYE7ymz/YWdWlCBbeH/UvtwEtyw0hbdrRr6EDxiV84VI7a16oLke89yeRac4Jdafz4bz7CJneaF9oVy5Qj2yBJZv4FiLhq3SYOqbtIvggRNunz5atJVx40IBwfVpSZ/7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340204; c=relaxed/simple;
	bh=6OyBPYPMnBJGM+6F64l7Q9yrxKTPe2JBHU7Pq5T3I5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qke1iKbLk+QtGzEeTw0j3gPSxDp6TJWcQTfF3KEkFI8SXw84BqB3OXgDwuvXeViQCZ+lJWurZumt0HvfgvQRV2j8AaXZtxvPcKmQLGbqjCT3TQC3SeeRMARXsVa4WQvnTMjtj6HVn5j1es5/rqZNPvrV/cY3ncHMEXxmjwsKOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhOmgyuM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721340202; x=1752876202;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6OyBPYPMnBJGM+6F64l7Q9yrxKTPe2JBHU7Pq5T3I5Y=;
  b=MhOmgyuM6aODhAeknvLqjFphCY+exYYBMk9Cla+l+AulvPZjHIlC81pD
   9lQZ9SL2XYTgBWe6oqi7PpLQrAWLZhUKiCF+ZRCat7e9WiuOvQBk/5Wiy
   EQsXnrC9tcWr5obK39GwpxFl60WJ5lDTDcgaP275W+5kV8tKEO4LQCjdE
   AS8v+6tmUQv6PzMoqy8aIQbArRq8Sn9aPxAIBto02tqGIPKd/DFzXg6eD
   Oiepd1pHyxeBZw/VNWu0Cp3Qk6GpBtB/dZOKeVpQGBuOomm3QLkNVmAy9
   ZZOg517wKhl90rg+baaETG9LtgDDcUb27LLQRdcmLG+t3Oi2dp+shpebd
   Q==;
X-CSE-ConnectionGUID: Rctf+VLjQHeH70JJQUX+Pg==
X-CSE-MsgGUID: m+10Cf4gQD+0prDlXr3nfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="44358579"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="44358579"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 15:03:04 -0700
X-CSE-ConnectionGUID: d5eUzs88SN2Wg//5JFQhUQ==
X-CSE-MsgGUID: LqGUorbFTmiqPfavkBN1zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="50875778"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.193]) ([10.125.108.193])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 15:03:04 -0700
Message-ID: <b07c39fab5ac0e32e7768ed3e8a799c8eb68802a.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: queue policy->update work to rt thread to
 reduce  its schedule latency
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gaowei Pu <pugaowei@oppo.com>, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2024 15:03:04 -0700
In-Reply-To: <20240717063321.629-1-pugaowei@oppo.com>
References: <20240717063321.629-1-pugaowei@oppo.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-17 at 14:33 +0800, Gaowei Pu wrote:
> Currently we encountered a problem that the cpufreq boost latency
> is about 10 milliseconds or worse when we boost through cpufreq QOS reque=
st
> under high workload scenarios, while the boost latency mainly consumed by
> schedule latency of policy->update work.

What is the tail latency now after your change?

>=20
> We should ensure the low schedule latency of cpu frequency limits work
> to meet performance and power demands. so queue the policy->update work
> to rt thread to reduce its schedule latency.

If my understanding is correct, kthread has a default nice
value of 0 and is not a rt thread.=C2=A0

I think the gain you see is
your patch created a dedicated kthread work queue on CPU 0.
The work from policy change no longer have to compete time with other
requests coming from schedule_work().=20

If the policy change really needs to get ahead
of other tasks, I think you need a dedicated
workqueue with alloc_workqueue() using WQ_HIGHPRI flag.

Tim

>=20
> Signed-off-by: Gaowei Pu <pugaowei@oppo.com>
> ---
>  drivers/cpufreq/cpufreq.c | 24 ++++++++++++++++++------
>  include/linux/cpufreq.h   |  4 +++-
>  2 files changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a45aac17c20f..e6e42a3ba9ab 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1193,7 +1193,7 @@ void refresh_frequency_limits(struct cpufreq_policy=
 *policy)
>  }
>  EXPORT_SYMBOL(refresh_frequency_limits);
> =20
> -static void handle_update(struct work_struct *work)
> +static void handle_update(struct kthread_work *work)
>  {
>  	struct cpufreq_policy *policy =3D
>  		container_of(work, struct cpufreq_policy, update);
> @@ -1209,7 +1209,7 @@ static int cpufreq_notifier_min(struct notifier_blo=
ck *nb, unsigned long freq,
>  {
>  	struct cpufreq_policy *policy =3D container_of(nb, struct cpufreq_polic=
y, nb_min);
> =20
> -	schedule_work(&policy->update);
> +	kthread_queue_work(policy->worker, &policy->update);
>  	return 0;
>  }
> =20
> @@ -1218,7 +1218,7 @@ static int cpufreq_notifier_max(struct notifier_blo=
ck *nb, unsigned long freq,
>  {
>  	struct cpufreq_policy *policy =3D container_of(nb, struct cpufreq_polic=
y, nb_max);
> =20
> -	schedule_work(&policy->update);
> +	kthread_queue_work(policy->worker, &policy->update);
>  	return 0;
>  }
> =20
> @@ -1301,15 +1301,25 @@ static struct cpufreq_policy *cpufreq_policy_allo=
c(unsigned int cpu)
>  		goto err_min_qos_notifier;
>  	}
> =20
> +	policy->worker =3D kthread_create_worker_on_cpu(cpu, 0, "policy_worker%=
d", cpu);
> +	if (IS_ERR(policy->worker)) {
> +		dev_err(dev, "Failed to create policy_worker%d\n", cpu);
> +		goto err_max_qos_notifier;
> +	}
> +
> +	sched_set_fifo_low(policy->worker->task);
>  	INIT_LIST_HEAD(&policy->policy_list);
>  	init_rwsem(&policy->rwsem);
>  	spin_lock_init(&policy->transition_lock);
>  	init_waitqueue_head(&policy->transition_wait);
> -	INIT_WORK(&policy->update, handle_update);
> +	kthread_init_work(&policy->update, handle_update);
> =20
>  	policy->cpu =3D cpu;
>  	return policy;
> =20
> +err_max_qos_notifier:
> +	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MAX,
> +				 &policy->nb_max);
>  err_min_qos_notifier:
>  	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
>  				 &policy->nb_min);
> @@ -1353,7 +1363,9 @@ static void cpufreq_policy_free(struct cpufreq_poli=
cy *policy)
>  				 &policy->nb_min);
> =20
>  	/* Cancel any pending policy->update work before freeing the policy. */
> -	cancel_work_sync(&policy->update);
> +	kthread_cancel_work_sync(&policy->update);
> +	if (policy->worker)
> +		kthread_destroy_worker(policy->worker);
> =20
>  	if (policy->max_freq_req) {
>  		/*
> @@ -1802,7 +1814,7 @@ static unsigned int cpufreq_verify_current_freq(str=
uct cpufreq_policy *policy, b
> =20
>  		cpufreq_out_of_sync(policy, new_freq);
>  		if (update)
> -			schedule_work(&policy->update);
> +			kthread_queue_work(policy->worker, &policy->update);
>  	}
> =20
>  	return new_freq;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 20f7e98ee8af..73029daddfc5 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -20,6 +20,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/sysfs.h>
>  #include <linux/minmax.h>
> +#include <linux/kthread.h>
> =20
>  /*********************************************************************
>   *                        CPUFREQ INTERFACE                          *
> @@ -77,8 +78,9 @@ struct cpufreq_policy {
>  	void			*governor_data;
>  	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
> =20
> -	struct work_struct	update; /* if update_policy() needs to be
> +	struct kthread_work	update; /* if update_policy() needs to be
>  					 * called, but you're in IRQ context */
> +	struct kthread_worker *worker;
> =20
>  	struct freq_constraints	constraints;
>  	struct freq_qos_request	*min_freq_req;


