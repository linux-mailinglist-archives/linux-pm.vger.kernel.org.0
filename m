Return-Path: <linux-pm+bounces-19146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701659EF41F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2A2901D3
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7DA223E9D;
	Thu, 12 Dec 2024 17:04:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5E2144A2;
	Thu, 12 Dec 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023052; cv=none; b=J95h/UFgBx83ZGif16qsX8bv6LuhpbWEU3eBd+6fkBI7eTu00rF+HxE340t385MyyFsF4OOXAVUFhnAhD5j8mx7zvJzBJeh+yTyIFHjXkYj95K+VUmaawiM++Pf1iiw1280qF38UTHm6fSMEFLecLeLYYFUF8aYLPhjo/alIzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023052; c=relaxed/simple;
	bh=qEEzfqsh2vdv8z94+nPCE2Myefm6po3pERQ9A6NZWZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bayp2ETzDyJrExyUU0JSFGvrhqb5xrsgqrqmJjTYOQdc2cOgYmflOSxKh7ZXO7/+IvvWtNQqAMSvEhRn+92b3dbRnK8dqDHLZgdVEVDtswa0m4ka4AHimbEbkhggwvv/4ZrUoSVfppS6fJXXKt3Z+jx2zskxWQG9o4S/hBsWotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD641762;
	Thu, 12 Dec 2024 09:04:37 -0800 (PST)
Received: from [10.1.37.59] (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4D643F58B;
	Thu, 12 Dec 2024 09:04:06 -0800 (PST)
Message-ID: <ea90a77e-91fa-423d-9f11-9345db6d1482@arm.com>
Date: Thu, 12 Dec 2024 17:04:04 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v021 8/9] cpufreq: intel_pstate: Introduce hybrid
 domains
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
 <2030654.usQuhbGJ8B@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2030654.usQuhbGJ8B@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 16:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Hybrid platforms contain different types of CPUs.  They may differ
> by micro-architecture, by cache topology, by manufacturing process, by
> the interconnect access design etc.  Of course, this means that power-
> performance curves for CPUs of different types are generally different.
> 
> Because of these differences, CPUs of different types need to be handled
> differently in certain situations and so it is convenient to operate
> groups of CPUs that each contain CPUs of the same type.  In intel_pstate,
> each of them will be represented by a struct hybrid_domain object and
> referred to as a hybrid domain.
> 
> A key problem is how to identify the type of a CPUs so as to know which
> hybrid domain it belongs to.  In principle, there are a few ways to do
> it, but none of them is perfectly reliable.
> 
> From the computational perspective, an important factor is how many
> instructions (on average) can be executed by the given CPU when it is
> running at a specific frequency, often referred to as the IPC
> (instructions per cycle) ratio of the given CPU to the least-capable
> CPU in the system.  In intel_pstate this ratio is represented by the
> performance-to-frequency scaling factor which needs to be used to get
> a frequency in kHz for a given HWP performance level of the given CPU.
> Since HWP performance levels are in the same units for all CPUs in a
> hybrid system, the smaller the scaling factor, the larger the IPC ratio
> for the given CPU.
> 
> Of course, the performance-to-frequency scaling factor must be the
> same for all CPUs of the same type.  While it may be the same for CPUs
> of different types, there is only one case in which that actually
> happens (Meteor Lake platforms with two types of E-cores) and it is not
> expected to happen again in the future.  Moreover, when it happens,
> there is no straightforward way to distinguish CPUs of different types
> with the same scaling factor in general.
> 
> For this reason, the scaling factor is as good as it gets for CPU
> type identification and so it is used for building hybrid domains in
> intel_pstate.
> 
> On hybrid systems, every CPU is added to a hybrid domain at the
> initialization time.  If a hybrid domain with a matching scaling
> factor is already present at that point, the CPU will be added to it.
> Otherwise, a new hybrid domain will be created and the CPU will be
> put into it.  The domain's scaling factor will then be set to the
> one of the new CPU.

Just two irrelevant typos below, although for the unfamiliar maybe an
example debug message output from any Arrow Lake would make this more
concrete?

> 
> So far, the new code doesn't do much beyond printing debud messages,

s/debud/debug

> but subsequently the EAS support for intel_pstate will be based on it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   57 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -943,6 +943,62 @@ static struct cpudata *hybrid_max_perf_c
>   */
>  static DEFINE_MUTEX(hybrid_capacity_lock);
>  
> +#ifdef CONFIG_ENERGY_MODEL
> +/*
> + * A hybrid domain is a collection of CPUs with the same perf-to-frequency
> + * scaling factor.
> + */
> +struct hybrid_domain {
> +	struct hybrid_domain *next;
> +	cpumask_t cpumask;
> +	int scaling;
> +};
> +
> +static struct hybrid_domain *hybrid_domains;
> +
> +static void hybrid_add_to_domain(struct cpudata *cpudata)
> +{
> +	int scaling = cpudata->pstate.scaling;
> +	int cpu = cpudata->cpu;
> +	struct hybrid_domain *hd;
> +
> +	/* Do this only on hubrid platforms. */

s/hubrid/hybrid


