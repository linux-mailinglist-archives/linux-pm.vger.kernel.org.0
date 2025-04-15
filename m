Return-Path: <linux-pm+bounces-25437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92371A896C1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D7F3A78F6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EEC2820C5;
	Tue, 15 Apr 2025 08:31:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB42820A4;
	Tue, 15 Apr 2025 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705880; cv=none; b=tVTql/NnKdRH2sAwyFyFVQ+vrsZgvgh1At7myB08RbuRQ2+GkOkHp8SUjO1VrnxhZJA8xm959hws3RFaSTKtgdt31tviP7ZJVXmpsK/EV+vaBB0DvbzpkpJTvZKtAnz1RV9KwBve72/tPnWJSx4RfyQQx+8oCvPwf1bFfh4rm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705880; c=relaxed/simple;
	bh=Pwxu9zhvfv34pQqIHOPHl37aXod6oVxsH7nMhW0hsVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8wrF3AcQHwrMrBX1hNI0p26SXLXsjKbJH2BT73YWKFr5aVCJUaOJt0jpn1zrjlDjKe3F4z0NY9O5tM9Cftwbs1T7E3dYfFWtHL1uBIx6qvx4KTDmWDYYw9FELoI54gEComdjj4Lh4S0/6QcfOLPqgmicZFgKngKxMzJu20cmJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C867339;
	Tue, 15 Apr 2025 01:31:15 -0700 (PDT)
Received: from [10.57.68.100] (unknown [10.57.68.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 745883F694;
	Tue, 15 Apr 2025 01:31:15 -0700 (PDT)
Message-ID: <d29e4ea6-2bfe-4017-b7c8-0d77613959f4@arm.com>
Date: Tue, 15 Apr 2025 09:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: Add inotify support when the energy model is
 updated.
To: Changwoo Min <changwoo@igalia.com>, rafael@kernel.org
Cc: christian.loehle@arm.com, tj@kernel.org, len.brown@intel.com,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, pavel@kernel.org
References: <20250415004215.48757-1-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250415004215.48757-1-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Changwoo,

Thanks for the patch.

On 4/15/25 01:42, Changwoo Min wrote:
> The sched_ext schedulers [1] currently access the energy model through the
> debugfs to make energy-aware scheduling decisions [2]. The userspace part
> of a sched_ext scheduler feeds the necessary (post-processed) energy-model
> information to the BPF part of the scheduler.

This is very interesting use case!

> 
> However, there is a limitation in the current debugfs support of the energy
> model. When the energy model is updated (em_dev_update_perf_domain), there
> is no way for the userspace part to know such changes (besides polling the
> debugfs files).
> 
> Therefore, add inotify support (IN_MODIFY) when the energy model is
> updated. With this inotify support, the sched_ext scheduler can monitor the
> energy model change in userspace using the regular inotify interface and
> feed the updated energy model information to make energy-aware scheduling
> decisions.
> 
> [1] https://lwn.net/Articles/922405/
> [2] https://github.com/sched-ext/scx/pull/1624
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/energy_model.c | 47 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d9b7e2b38c7a..0c06e0278df6 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -14,6 +14,7 @@
>   #include <linux/cpumask.h>
>   #include <linux/debugfs.h>
>   #include <linux/energy_model.h>
> +#include <linux/fsnotify.h>
>   #include <linux/sched/topology.h>
>   #include <linux/slab.h>
>   
> @@ -156,9 +157,53 @@ static int __init em_debug_init(void)
>   	return 0;
>   }
>   fs_initcall(em_debug_init);
> +
> +static void em_debug_update_ps(struct em_perf_domain *em_pd, int i,
> +			       struct dentry *pd)
> +{
> +	static const char *names[] = {
> +		"frequency",
> +		"power",
> +		"cost",
> +		"performance",
> +		"inefficient",
> +	};
> +	struct em_perf_state *table;
> +	unsigned long freq;
> +	struct dentry *d, *cd;
> +	char name[24];
> +	int j;
> +
> +	rcu_read_lock();
> +	table = em_perf_state_from_pd(em_pd);
> +	freq = table[i].frequency;
> +	rcu_read_unlock();
> +
> +	snprintf(name, sizeof(name), "ps:%lu", freq);
> +	d = debugfs_lookup(name, pd);
> +
> +	for (j = 0; j < ARRAY_SIZE(names); j++) {
> +		cd = debugfs_lookup(names[j], d);
> +		if (!cd)
> +			return;
> +		fsnotify_dentry(cd, FS_MODIFY);
> +		cond_resched();
> +	}
> +}
> +
> +static void em_debug_update(struct device *dev)
> +{
> +	struct dentry *d;
> +	int i;
> +
> +	d = debugfs_lookup(dev_name(dev), rootdir);
> +	for (i = 0; i < dev->em_pd->nr_perf_states; i++)
> +		em_debug_update_ps(dev->em_pd, i, d);
> +}
>   #else /* CONFIG_DEBUG_FS */
>   static void em_debug_create_pd(struct device *dev) {}
>   static void em_debug_remove_pd(struct device *dev) {}
> +static void em_debug_update(struct device *dev) {}
>   #endif
>   
>   static void em_release_table_kref(struct kref *kref)
> @@ -323,6 +368,8 @@ int em_dev_update_perf_domain(struct device *dev,
>   
>   	em_table_free(old_table);
>   
> +	em_debug_update(dev);
> +

I would move this out of the locked section, below the mutex
unlock. Looking at the code in em_debug_update() you are trying
to send such notification for each EM's table entry * number of
fields, which is heavy. The RCU copy that you get will make sure
you have consistent view on the data and you don't have to
be under the mutex lock.

A different question would be if the notification has to be
that heavy?
Can we just 'ping' the user-space that there is a change and ask to read
the new values?

Another question, but this time to Rafael would be if for such use case
we can use debugfs, or we need a sysfs?

>   	mutex_unlock(&em_pd_mutex);
>   	return 0;
>   }


Regards,
Lukasz

