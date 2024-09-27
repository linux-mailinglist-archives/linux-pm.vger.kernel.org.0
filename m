Return-Path: <linux-pm+bounces-14866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300F9882C5
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190171F21BE7
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 10:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C518A6C3;
	Fri, 27 Sep 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0jGm7U+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F9189F5C;
	Fri, 27 Sep 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434032; cv=none; b=ryDK7X8J62Myj6FcYBuYGAgR1GxD/N0p1qNqJflSe9pNqEYfFx+QvlftGHbq9XBxtnaQtxLnF1kHQV/2oYz3YqdrbfK4j7aZoC/Pq1bluSNGR5IPX5+szdToRBN20i8fXs/VF4vrJH13ZV6mm5OSG5zohJxFJvwD5omOXo3TBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434032; c=relaxed/simple;
	bh=z/Og3zFUzWWKjPZOxY77b/dnBGdDbGV6vklMbrYLvSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/Q7zvTdlTn8HGo3XyULyrbZ4CnM16oFvy6MsDuNRWAtiwVkhh55Oq4a+Bo9NCLquEhxQQ5wq5VYGRPR6ojjRhBSioetYUKnKHe6yosqEvnJUaY5JakMIrFI60eF/PY/+Z/w5bWM8YTrQYADvXRXBQXBVTNbTyj03JjPmuxhFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0jGm7U+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727434030; x=1758970030;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=z/Og3zFUzWWKjPZOxY77b/dnBGdDbGV6vklMbrYLvSM=;
  b=b0jGm7U+3/JCFl5mmMfDDuBhorMJr/Cl4DaiT0FXWhWRJawu2f1E5eHQ
   QK/kdk2WhhO1VL2XDKAMLD7N2I7B08WDkV/+rZLJIY/SXtjMjuTgaVxyx
   5/W5pHMRC3IgitjPYMZsukpv366qo0Ey1POqfVBOjF9BgbF+tlqmvQndr
   TnCZWBZHo/tV/TLuev93QUiMoKpjwvC6vlAABuKetI5P1ei3x8/cCLdYe
   eAK8imamqax4kcwSEawIngE6XVQgfEWTGdBDfZpLRmkCTVNT0bg1JbSZw
   UZbpLK5YK2lvUo/NGUBvygZNzH/znV2g4mPfe0gtu/Jly++jykvEhTwmd
   A==;
X-CSE-ConnectionGUID: LW7aZbBQTkeFQ23DaFLbUQ==
X-CSE-MsgGUID: SLFT92/7TCSm+l114NVTdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30462986"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="30462986"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 03:47:09 -0700
X-CSE-ConnectionGUID: GPGM5ph8TmGolM20K1h0+w==
X-CSE-MsgGUID: nA67MDqQSky0f3RY0Yg2kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="72581168"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.111.243])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 03:47:09 -0700
Message-ID: <229b9ff9ef6cf201b4e56d6ccb03c028c2d8f51f.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw
 spinlock
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>, Len Brown
 <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>,  linux-rt-users@vger.kernel.org, xiao sheng wen
 <atzlinux@sina.com>
Date: Fri, 27 Sep 2024 03:47:08 -0700
In-Reply-To: <20240919081121.10784-2-ukleinek@debian.org>
References: <20240919081121.10784-2-ukleinek@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-19 at 10:11 +0200, Uwe Kleine-K=C3=B6nig wrote:
> notify_hwp_interrupt() is called via sysvec_thermal() ->
> smp_thermal_vector() -> intel_thermal_interrupt() in hard irq
> context.
> For this reason it must not use a simple spin_lock that sleeps with
> PREEMPT_RT enabled. So convert it to a raw spinlock.
>=20
> Reported-by: xiao sheng wen <atzlinux@sina.com>
> Link: https://bugs.debian.org/1076483
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>

Missing Tested-by?

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> Hello,
>=20
> this is deep in x86 land where I have *very* little experience and
> knowledge. Is sysvec_thermal() (defined in arch/x86/kernel/irq.c)
> really
> running in hard irq context? The stacktrace in the Debian bug report
> suggests that.
>=20
> So please double check my reasoning before applying this patch.
>=20
This is thermal LVT and runs in hard IRQ context.=20

> Thanks
> Uwe
>=20
> =C2=A0drivers/cpufreq/intel_pstate.c | 16 ++++++++--------
> =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index aaea9a39eced..b0018f371ea3 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1845,7 +1845,7 @@ static void intel_pstate_notify_work(struct
> work_struct *work)
> =C2=A0	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
> =C2=A0}
> =C2=A0
> -static DEFINE_SPINLOCK(hwp_notify_lock);
> +static DEFINE_RAW_SPINLOCK(hwp_notify_lock);
> =C2=A0static cpumask_t hwp_intr_enable_mask;
> =C2=A0
> =C2=A0#define HWP_GUARANTEED_PERF_CHANGE_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BIT(0)
> @@ -1868,7 +1868,7 @@ void notify_hwp_interrupt(void)
> =C2=A0	if (!(value & status_mask))
> =C2=A0		return;
> =C2=A0
> -	spin_lock_irqsave(&hwp_notify_lock, flags);
> +	raw_spin_lock_irqsave(&hwp_notify_lock, flags);
> =C2=A0
> =C2=A0	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
> =C2=A0		goto ack_intr;
> @@ -1876,13 +1876,13 @@ void notify_hwp_interrupt(void)
> =C2=A0	schedule_delayed_work(&all_cpu_data[this_cpu]-
> >hwp_notify_work,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msecs_to_jiffies(10));
> =C2=A0
> -	spin_unlock_irqrestore(&hwp_notify_lock, flags);
> +	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
> =C2=A0
> =C2=A0	return;
> =C2=A0
> =C2=A0ack_intr:
> =C2=A0	wrmsrl_safe(MSR_HWP_STATUS, 0);
> -	spin_unlock_irqrestore(&hwp_notify_lock, flags);
> +	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
> =C2=A0}
> =C2=A0
> =C2=A0static void intel_pstate_disable_hwp_interrupt(struct cpudata
> *cpudata)
> @@ -1895,9 +1895,9 @@ static void
> intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
> =C2=A0	/* wrmsrl_on_cpu has to be outside spinlock as this can
> result in IPC */
> =C2=A0	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
> =C2=A0
> -	spin_lock_irq(&hwp_notify_lock);
> +	raw_spin_lock_irq(&hwp_notify_lock);
> =C2=A0	cancel_work =3D cpumask_test_and_clear_cpu(cpudata->cpu,
> &hwp_intr_enable_mask);
> -	spin_unlock_irq(&hwp_notify_lock);
> +	raw_spin_unlock_irq(&hwp_notify_lock);
> =C2=A0
> =C2=A0	if (cancel_work)
> =C2=A0		cancel_delayed_work_sync(&cpudata->hwp_notify_work);
> @@ -1912,10 +1912,10 @@ static void
> intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
> =C2=A0	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
> =C2=A0		u64 interrupt_mask =3D HWP_GUARANTEED_PERF_CHANGE_REQ;
> =C2=A0
> -		spin_lock_irq(&hwp_notify_lock);
> +		raw_spin_lock_irq(&hwp_notify_lock);
> =C2=A0		INIT_DELAYED_WORK(&cpudata->hwp_notify_work,
> intel_pstate_notify_work);
> =C2=A0		cpumask_set_cpu(cpudata->cpu,
> &hwp_intr_enable_mask);
> -		spin_unlock_irq(&hwp_notify_lock);
> +		raw_spin_unlock_irq(&hwp_notify_lock);
> =C2=A0
> =C2=A0		if
> (cpu_feature_enabled(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))
> =C2=A0			interrupt_mask |=3D
> HWP_HIGHEST_PERF_CHANGE_REQ;
>=20
> base-commit: 3621a2c9142bd490af0666c0c02d52d60ce0d2a5


