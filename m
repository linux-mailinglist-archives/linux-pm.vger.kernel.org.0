Return-Path: <linux-pm+bounces-1118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C28123FD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 01:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9C01C2140A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58B39C;
	Thu, 14 Dec 2023 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9JAIAzv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E214FAC;
	Wed, 13 Dec 2023 16:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702514465; x=1734050465;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=k1qSf+lV25zr0Dwp3/EooJ11sf1fNhwipYU+ucC77pE=;
  b=i9JAIAzv7k0/yolUo9D3yjzKN8Tb2IqPrKxATvzlLGablmQ2QVp+7aqM
   mLHUS5KTWWsgMSf631dVv3BE31FN7YLtum+Zr/RqUY62f0ZyjF2ED4Md2
   0Def/5Lx5lJ/ha/lEVj1tl4db2HAY+amMIemgAbf2RcexZzBlSNbvELne
   k/MRyvz3uUx1pzrAffEr6Tq4la+gnU2X17V3i6vmXTqn3N/e5PhJxCe72
   y4L87nJoAGgC/6JaAt0ebcuRdVmtn1jdBRTKbVW45gHwUNrEJyyV4CbEN
   KRjcThqyvyre/38Fh3QaOU78JSNRCq+nqQ1f4A8nKXb0ZC8hzzYszu1Rb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="426180857"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="426180857"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:41:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947367819"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="947367819"
Received: from wanghuan-mobl1.amr.corp.intel.com (HELO [10.212.178.119]) ([10.212.178.119])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:41:04 -0800
Message-ID: <2e8807b68133f4b3a72227122a9d9a05f3fbf9d8.camel@linux.intel.com>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, catalin.marinas@arm.com, 
 will@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
 viresh.kumar@linaro.org,  agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org,  mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com,  dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de,  bristot@redhat.com,
 vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com, 
 mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
Date: Wed, 13 Dec 2023 16:41:04 -0800
In-Reply-To: <20231212142730.998913-2-vincent.guittot@linaro.org>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
	 <20231212142730.998913-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-12 at 15:27 +0100, Vincent Guittot wrote:
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 48 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 10 ++++++++
>  2 files changed, 58 insertions(+)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..7d5f71be8d29 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2563,6 +2563,50 @@ int cpufreq_get_policy(struct cpufreq_policy *poli=
cy, unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpufreq_get_policy);
> =20
> +DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
> +EXPORT_PER_CPU_SYMBOL_GPL(cpufreq_pressure);
> +
> +/**
> + * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
> + * @cpus        : The related CPUs for which max capacity has been reduc=
ed
> + * @capped_freq : The maximum allowed frequency that CPUs can run at
> + *
> + * Update the value of cpufreq pressure for all @cpus in the mask. The
> + * cpumask should include all (online+offline) affected CPUs, to avoid
> + * operating on stale data when hot-plug is used for some CPUs. The
> + * @capped_freq reflects the currently allowed max CPUs frequency due to
> + * freq_qos capping. It might be also a boost frequency value, which is =
bigger
> + * than the internal 'capacity_freq_ref' max frequency. In such case the
> + * pressure value should simply be removed, since this is an indication =
that
> + * there is no capping. The @capped_freq must be provided in kHz.
> + */
> +static void cpufreq_update_pressure(const struct cpumask *cpus,
> +				      unsigned long capped_freq)
> +{
> +	unsigned long max_capacity, capacity, pressure;
> +	u32 max_freq;
> +	int cpu;
> +
> +	cpu =3D cpumask_first(cpus);
> +	max_capacity =3D arch_scale_cpu_capacity(cpu);
> +	max_freq =3D arch_scale_freq_ref(cpu);
> +
> +	/*
> +	 * Handle properly the boost frequencies, which should simply clean
> +	 * the thermal pressure value.
> +	 */
> +	if (max_freq <=3D capped_freq)
> +		capacity =3D max_capacity;
> +	else
> +		capacity =3D mult_frac(max_capacity, capped_freq, max_freq);
> +
> +	pressure =3D max_capacity - capacity;
> +
> +
> +	for_each_cpu(cpu, cpus)
> +		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);

Seems like the pressure value computed from the first CPU applies to all CP=
U.
Will this be valid for non-homogeneous CPUs that could have different
max_freq and max_capacity?

Tim

