Return-Path: <linux-pm+bounces-11816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3881945378
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 21:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789A21F22950
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690A314A0AA;
	Thu,  1 Aug 2024 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0I9y6ay"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747FE1422D0;
	Thu,  1 Aug 2024 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541347; cv=none; b=QVKlCwEVKCql7+8a5z23bRADUvsGyKpjHGP4emlXMMPJfubH4thvee302VgMuAUkMA/Jr7+ahc0D/uTxd/5hKsl6WimySLIY+Crux0rDxD1nnBOL8xxy1tHxvDooS58iAytnGv8PfN8ExTgo72cs/Xl8SBFYwibWe896Ed7/nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541347; c=relaxed/simple;
	bh=lvfv0gYAMYXDl4J8LANARZqbPTuzhHPJmdjQybAkBA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EolfSJWSZxR2qT7G7eoqXn7jsTACQxJTnScV/ZAFX8UK3XHnJ/VlQSbUBFbl2+5NDft8oLgKb1ReGZr6puuzXXpDoo9rk67Ln0t8do0OG1aOia344bSIQ0r0DzDFIyD7rjTcT3Yp4dAOnWVUYyB4/Ndfscpxhr2oWgifpeJZh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0I9y6ay; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722541345; x=1754077345;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lvfv0gYAMYXDl4J8LANARZqbPTuzhHPJmdjQybAkBA4=;
  b=W0I9y6ayJiE/istCzaNWbvx+6eaVuKrV04paAuW55giBd3lCb5FswiBl
   3OotlKevOr6WGCeu1azOa/kf5z1VvNDbv/EQar7vEeeC+SQUM0MDPy8kq
   YYWLrCVeSQ3T3AaNWEAglnmGh/1AUK9semb5L9eUtWsWpmSgKJcqEjSLb
   Ga/int5mM4ctxZC0+wqdKtfGYV59zOSETeIVb//FZzzgRP3IEamu1faK3
   g5Zj8XGARvdkZUyM6V214KwNHGHu9EepZeitJ9nNWA1/W5VYztSsOdDqA
   EhtxkGT4FOF2dQiOSbzusZKXSj1Dy//L4w+uyWG9U+jSvkAtbISzhT3+P
   Q==;
X-CSE-ConnectionGUID: MGe6n0/CTaygJvTU9tpKig==
X-CSE-MsgGUID: B2JkNemaS2O8CLMCL4Gj1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="12838072"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="12838072"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 12:42:25 -0700
X-CSE-ConnectionGUID: Qpx6A42VRyCk6SA14yLBMA==
X-CSE-MsgGUID: JsSBxWNARnKdEsYeqUAAAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="55107940"
Received: from unknown (HELO [10.124.223.52]) ([10.124.223.52])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 12:42:24 -0700
Message-ID: <c15a8a105308262856ee14bab558d34df8bdf92a.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Update Balance performance EPP
 for Emerald Rapids
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Pedro Henrique Kopper <pedro.kopper@canonical.com>, rafael@kernel.org, 
	lenb@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Aug 2024 12:42:21 -0700
In-Reply-To: <Zqu6zjVMoiXwROBI@capivara>
References: <Zqu6zjVMoiXwROBI@capivara>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-01 at 13:41 -0300, Pedro Henrique Kopper wrote:
> On Intel Emerald Rapids machines, we ship the Energy Performance
> Preference
> (EPP) default for balance_performance as 128. However, during an
> internal
> investigation together with Intel, we have determined that 32 is a
> more
> suitable value. This leads to significant improvements in both
> performance
> and energy:
>=20
> POV-Ray: 32% faster | 12% less energy
> OpenSSL: 12% faster | energy within 1%
> Build Linux Kernel: 29% faster | 18% less energy
>=20
> Therefore, we should move the default EPP for balance_performance to
> 32.
> This is in line with what has already been done for Sapphire Rapids.
>=20
> Signed-off-by: Pedro Henrique Kopper <pedro.kopper@canonical.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 392a8000b238..c0278d023cfc 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3405,6 +3405,7 @@ static const struct x86_cpu_id
> intel_epp_default[] =3D {
> =C2=A0	 */
> =C2=A0	X86_MATCH_VFM(INTEL_ALDERLAKE_L,
> HWP_SET_DEF_BALANCE_PERF_EPP(102)),
> =C2=A0	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,
> HWP_SET_DEF_BALANCE_PERF_EPP(32)),
> +	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,
> HWP_SET_DEF_BALANCE_PERF_EPP(32)),
> =C2=A0	X86_MATCH_VFM(INTEL_METEORLAKE_L,
> HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 179, 64, 16)),
> =C2=A0	X86_MATCH_VFM(INTEL_ARROWLAKE,
> HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,


