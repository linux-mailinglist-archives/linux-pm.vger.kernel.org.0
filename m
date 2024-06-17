Return-Path: <linux-pm+bounces-9309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0916890A989
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192801C24079
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064F1922C9;
	Mon, 17 Jun 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQeWwUel"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6919148E;
	Mon, 17 Jun 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616463; cv=none; b=i3jEi8marcAffE5uLTsTPE7Ena9hEr88KpQIwAxp28O5qedDButdzfRYdtjkNjlwQFq8BGC3Y4SiCAf+QH5J1zLtd8zeUWGgd8+Htsof23VpNtdXRPSwdZFd63izEJFAnA9YQl5s1pJO5XcsI1//7Z5c6OjCBmCISc/wdk9COX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616463; c=relaxed/simple;
	bh=dnFgPeAyWOcc/aC0MiFnCnbaJLtLBh5cDDDyNhkDw1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OtJyWdWFEWAEsNsrmRQeS59iroBrpKq4eYG+cDGWyqK7PTfypLdvQBb2MHcBiVIspwZEb1aiEVHfpxQYVf9EeHxHuXgjCVBGJhwtBuM7l5zcwbf/yGhzv/ZANkga+Hh30w1FTWkSspXEqMvWouWgCsUfajcFnKf/BoGdVga6XkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQeWwUel; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718616463; x=1750152463;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dnFgPeAyWOcc/aC0MiFnCnbaJLtLBh5cDDDyNhkDw1k=;
  b=KQeWwUelYuhRFpUcUgf6hcPFF/0HPqpKI6p1nC+zeQPWqLGivB14962k
   bQHREfxdYGEogSbgIhyOxqPwcMwh1wgAWy11WU0lIOHwaq7biIR8t2uGA
   GGZJd9RL/Ogmzi7I7NPTciyZE4VCQJUCKy/ymBR3/A3CyTAHJ6z0aDods
   ov+8e8C3vdWcK3KPyOGCYUe/yvG41SngHI938zthV1Lyi+9Gjv/hHgalC
   bA9GVjKfjwGoZIbJerfXAhcEswcNQV7SSKAy9qoVmvkaCItfbW+7YCklw
   VNGIt92jjqGO+Va8sd+xulLPQkiaB8H50HpsvZEtQn6nXpaVduCC8cWUP
   w==;
X-CSE-ConnectionGUID: TYbi6O7TTcGifbvYBaXkgQ==
X-CSE-MsgGUID: vp1ga7BTRUK/ZJjsTG6MIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26010571"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="26010571"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:27:42 -0700
X-CSE-ConnectionGUID: kfn5WqeBQmqSeExi4ReZgQ==
X-CSE-MsgGUID: 7jS773L6SgCRP3hyk+Dcbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="64337246"
Received: from varadarp-mobl.gar.corp.intel.com ([10.213.94.8])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:27:31 -0700
Message-ID: <27018603c7ed574451520aeeae405f7b1fcd6c4e.camel@linux.intel.com>
Subject: Re: [PATCH PATCH 2/9] cpufreq: intel_pstate: Use
 topology_cpu_type() to get cpu-type
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner
	 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>,  "Liang, Kan"
 <kan.liang@linux.intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>
Date: Mon, 17 Jun 2024 02:27:02 -0700
In-Reply-To: <20240617-add-cpu-type-v1-2-b88998c01e76@linux.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
	 <20240617-add-cpu-type-v1-2-b88998c01e76@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 02:11 -0700, Pawan Gupta wrote:
> Intel pstate driver uses hybrid_get_type() to get the cpu-type of a
> given
> CPU. It uses smp_call_function_single() which is sub-optimal and can
> be
> avoided as cpu-type is also available in the per-cpu topology
> structure.
>=20
> Use topology_cpu_type() to get the cpu-type.
>=20
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 14 +++-----------
> =C2=A01 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 65d3f79104bd..40f5e5b0b45e 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1951,24 +1951,16 @@ static int knl_get_turbo_pstate(int cpu)
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> -static void hybrid_get_type(void *data)
> -{
> -	u8 *cpu_type =3D data;
> -
> -	*cpu_type =3D get_this_hybrid_cpu_type();
> -}
> -
> =C2=A0static int hwp_get_cpu_scaling(int cpu)
> =C2=A0{
> -	u8 cpu_type =3D 0;
> +	u8 cpu_type =3D topology_cpu_type(cpu);
> =C2=A0
> -	smp_call_function_single(cpu, hybrid_get_type, &cpu_type,
> 1);
> =C2=A0	/* P-cores have a smaller perf level-to-freqency scaling
> factor. */
> -	if (cpu_type =3D=3D 0x40)
> +	if (cpu_type =3D=3D X86_CPU_TYPE_INTEL_CORE)
> =C2=A0		return hybrid_scaling_factor;
> =C2=A0
> =C2=A0	/* Use default core scaling for E-cores */
> -	if (cpu_type =3D=3D 0x20)
> +	if (cpu_type =3D=3D X86_CPU_TYPE_INTEL_ATOM)
> =C2=A0		return core_get_scaling();
> =C2=A0
> =C2=A0	/*
>=20


