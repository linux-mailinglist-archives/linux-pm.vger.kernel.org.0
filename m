Return-Path: <linux-pm+bounces-38143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307FC66885
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 00:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 59967296F2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 23:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197812D23A8;
	Mon, 17 Nov 2025 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwytZfxP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDD30E822;
	Mon, 17 Nov 2025 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763421264; cv=none; b=I3F3iG/18sTYmnpgtxnhOF6yAaaMB2vU/RKeMvUNF8kTZMWhg4NjfYiCeIFkexzCsxRekAJ9fkvdZ/EM2u/2o9pOaeJ9FqK95sxVDYwNmEMF6AH4iIZSm5bEHhkra8Mhia0b3zO5cTj5hu0xgU7WK5a5u0wNY+Nr+6bUeilsaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763421264; c=relaxed/simple;
	bh=gxtI42daC9Kg7eIWRLNuR/gqGVo/peG1DAg8dLTRkkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rYiePmMORj2W0PT9xLxCyHFQVQne6HAzul/6Dvv0Aar53KeJYWjHe1xKwWFZMOf0+X34pc7mlM4XFZ64IhlPFfDlntSgCBe80Bpnpq9SbtIiweSBqZ7+hxeKxne8kViHOHxTEv6mOTmgXnFyCYDyE06MgOk/eMziaKbX8SRVrQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwytZfxP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763421262; x=1794957262;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gxtI42daC9Kg7eIWRLNuR/gqGVo/peG1DAg8dLTRkkY=;
  b=BwytZfxPDOsirUzNwoxpYWzaQINcPtPFzj6O9luqdsUl1SSl5GB7uCGw
   DrDuQvPBUQsSTDneBJjFzsymXOy6oU2uoXZLUsZWzomaUgplMep3V2awU
   yAhPBMVHvrx7T3+XjniIG4BXlY0wWNvyDjP5aMnkTyOO4v7GkVcshowFb
   Au4YCfd3uD8sZ0WHxZZtD2eZQZ3F8JfKx3CLrSdf/Dcz52hpeQK5ZnhD9
   ODl9SQUTQAlahgmH1kYca2h/iRRWte3MdGRJcTYo+BfvaPZ8sNxjaJnsJ
   MRFLMohwoSyNZ9ZEhQdv+GbkkDH/m8F16jxr7JjmAxSCoaXVlP5H+Z+qU
   A==;
X-CSE-ConnectionGUID: LJL4zNB3TM6l+5cntLVubA==
X-CSE-MsgGUID: h2y/I2OCRX+yIfre3p+NEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65314475"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="65314475"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 15:14:21 -0800
X-CSE-ConnectionGUID: yh5nWWbZRoKWHyNCh1B7MQ==
X-CSE-MsgGUID: 3ujU7mMDTNWzwwJ9XMx9qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="190605560"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 15:14:21 -0800
Message-ID: <8df91a0610ecab0de19ab5d1444bc8d07f87f659.camel@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Eliminate some code
 duplication
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Mon, 17 Nov 2025 15:14:21 -0800
In-Reply-To: <2829273.mvXUDI8C0e@rafael.j.wysocki>
References: <2829273.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 19:48 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> To eliminate some code duplication from the intel_pstate driver,
> move the core_get_val() function body to a new function called
> get_perf_ctl_val() and make both core_get_val() and atom_get_val()
> invoke it to carry out the same computation.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0 28 ++++++++++++++-----=
---------
> =C2=A01 file changed, 14 insertions(+), 14 deletions(-)
>=20
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2119,6 +2119,18 @@ static void intel_pstate_hwp_enable(stru
> =C2=A0	intel_pstate_update_epp_defaults(cpudata);
> =C2=A0}
> =C2=A0
> +static u64 get_perf_ctl_val(int pstate)
> +{
> +	u64 val;
> +
> +	val =3D (u64)pstate << 8;
> +	if (READ_ONCE(global.no_turbo) &&
> !READ_ONCE(global.turbo_disabled) &&
> +	=C2=A0=C2=A0=C2=A0 cpu_feature_enabled(X86_FEATURE_IDA))
> +		val |=3D (u64)1 << 32;
> +
> +	return val;
> +}
> +
> =C2=A0static int atom_get_min_pstate(int not_used)
> =C2=A0{
> =C2=A0	u64 value;
> @@ -2145,15 +2157,10 @@ static int atom_get_turbo_pstate(int not
> =C2=A0
> =C2=A0static u64 atom_get_val(struct cpudata *cpudata, int pstate)
> =C2=A0{
> -	u64 val;
> +	u64 val =3D get_perf_ctl_val(pstate);
> =C2=A0	int32_t vid_fp;
> =C2=A0	u32 vid;
> =C2=A0
> -	val =3D (u64)pstate << 8;
> -	if (READ_ONCE(global.no_turbo) &&
> !READ_ONCE(global.turbo_disabled) &&
> -	=C2=A0=C2=A0=C2=A0 cpu_feature_enabled(X86_FEATURE_IDA))
> -		val |=3D (u64)1 << 32;
> -
> =C2=A0	vid_fp =3D cpudata->vid.min + mul_fp(
> =C2=A0		int_tofp(pstate - cpudata->pstate.min_pstate),
> =C2=A0		cpudata->vid.ratio);
> @@ -2313,14 +2320,7 @@ static int core_get_turbo_pstate(int cpu
> =C2=A0
> =C2=A0static u64 core_get_val(struct cpudata *cpudata, int pstate)
> =C2=A0{
> -	u64 val;
> -
> -	val =3D (u64)pstate << 8;
> -	if (READ_ONCE(global.no_turbo) &&
> !READ_ONCE(global.turbo_disabled) &&
> -	=C2=A0=C2=A0=C2=A0 cpu_feature_enabled(X86_FEATURE_IDA))
> -		val |=3D (u64)1 << 32;
> -
> -	return val;
> +	return get_perf_ctl_val(pstate);
> =C2=A0}
> =C2=A0
> =C2=A0static int knl_get_aperf_mperf_shift(void)
>=20
>=20
>=20

