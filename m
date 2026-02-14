Return-Path: <linux-pm+bounces-42641-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC07G5mgkGnkbgEAu9opvQ
	(envelope-from <linux-pm+bounces-42641-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 17:19:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34B13C746
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 17:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2A5C3014111
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264429ACFC;
	Sat, 14 Feb 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coAcXXGz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA17221F1F;
	Sat, 14 Feb 2026 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085974; cv=none; b=ZZe9ol8T06HjS9bN2rdQ41jbIDUgYB8ejoEtjj7ANw23IefJpKdrsQLdo8wlTGek48YKyotvo3ozCB9KvE/PMPMZry6zO0QDs0nfSJG6COwmqzl2kxwWGxMMqtjYDxQuLWW/Uay4SAPryQ/TXJiLZl5mO7/7uQqWTfQXgy6lE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085974; c=relaxed/simple;
	bh=x3fe8WZ+2+W4YSB2xsa8jaPz0W2DHrGr8nrRNdsdXn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clOUA53dZB7BP+UGcBDVn6jKFmaF/f8X6F5CRiq/9uQsJe/C+pEnDDckysdB+ToPQ36k3Z/2EQGfC4/k63WP3i6J8eagT9Sotuz8syegOIBxsfWQo5I41/o7QLxHPxs5GRC5S+aR1Gzz/pgQdxLbDVGnIp6H0Y424SQxPYDqHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coAcXXGz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771085973; x=1802621973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x3fe8WZ+2+W4YSB2xsa8jaPz0W2DHrGr8nrRNdsdXn4=;
  b=coAcXXGzZL7Jv+Dp238ziFzVrGyn24Y/n9Kof1x+gvpt4NN9Ij5pnesj
   0jtLjV1hGEYQmlexL6pDuZlKUFWVpK8Szrol1EgCSIL7o1oQWz7mucakZ
   cXdaKLoWsiLiaZjO3zmdJLlwoY1OCQo8XNBlnvnYa1kylu8wDWwq0876S
   cmRTwq39rtN1kQzEzkPKDpga/0ivTSLcRy2SjZnwp2695J/LaZx2q0WV/
   g5oCmd9z/Qx9MyvCnUraVGLVKAGtVewujmX6WejAPtt8r5Vy4x2ymK6S9
   ibyAKG7EBx9mruSpEGV1oqAS4r+egWh7Qda+TkpHFJZcYvVzZw734+PEk
   Q==;
X-CSE-ConnectionGUID: IZjkcnqUR3+XC8bGD99+Sg==
X-CSE-MsgGUID: brZL2e+WTyq8nVrHhi2Xfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="72145447"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="72145447"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 08:19:32 -0800
X-CSE-ConnectionGUID: 4holg2ccRC62/k0hMaPpsg==
X-CSE-MsgGUID: Z++exEzIRkm+kUJ4J2NWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="213208808"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 08:19:31 -0800
Date: Sat, 14 Feb 2026 17:19:28 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] powercap: intel_rapl: Remove incorrect CPU check
 in PMU context
Message-ID: <aZCgkKj0DgR8nfWI@black.igk.intel.com>
References: <20260209234310.1440722-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260209234310.1440722-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209234310.1440722-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42641-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.freedesktop.org:url,intel.com:email,intel.com:dkim,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: DC34B13C746
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:43:09PM -0800, Kuppuswamy Sathyanarayanan wrote:
> The RAPL MSR read path incorrectly validates CPU context when called
> from the PMU subsystem:
> 
>     if (atomic) {
>         if (unlikely(smp_processor_id() != cpu))
>             return -EIO;
>         rdmsrq(ra->reg.msr, ra->value);
>     }
> 
> This check fails for package-scoped MSRs like RAPL energy counters,
> which are readable from any CPU within the package.
> 
> The perf tool avoids hitting this check by validating against
> /sys/bus/event_source/devices/power/cpumask before opening events.
> However, turbostat does not perform this validation and may attempt
> reads from non-lead CPUs, causing the check to fail and return zero
> power values.
> 
> Since package-scoped MSRs are architecturally accessible from any CPU
> in the package, remove the CPU matching check.
> 
> Also rename 'atomic' to 'pmu_ctx' to clarify this indicates PMU context
> where rdmsrq() can be used directly instead of rdmsrl_safe_on_cpu().
> 
> Fixes: 748d6ba43afd ("powercap: intel_rapl: Enable MSR-based RAPL PMU support")
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Tested-by: Furquim Ulisses <ulisses.furquim@intel.com>

This fixes a regression[1] in our test suite.
Looks like the patch is already applied, but feel free to add my

Tested-by: Raag Jadav <raag.jadav@intel.com>

[1] https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6935

> ---
>  drivers/powercap/intel_rapl_common.c |  6 +++---
>  drivers/powercap/intel_rapl_msr.c    | 12 +++++-------
>  include/linux/intel_rapl.h           |  2 +-
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 3ff6da3bf4e6..3705d0608a0f 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -254,7 +254,7 @@ static void rapl_init_domains(struct rapl_package *rp);
>  static int rapl_read_data_raw(struct rapl_domain *rd,
>  			      enum rapl_primitives prim,
>  			      bool xlate, u64 *data,
> -			      bool atomic);
> +			      bool pmu_ctx);
>  static int rapl_write_data_raw(struct rapl_domain *rd,
>  			       enum rapl_primitives prim,
>  			       unsigned long long value);
> @@ -832,7 +832,7 @@ prim_fixups(struct rapl_domain *rd, enum rapl_primitives prim)
>   */
>  static int rapl_read_data_raw(struct rapl_domain *rd,
>  			      enum rapl_primitives prim, bool xlate, u64 *data,
> -			      bool atomic)
> +			      bool pmu_ctx)
>  {
>  	u64 value;
>  	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
> @@ -854,7 +854,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
>  
>  	ra.mask = rpi->mask;
>  
> -	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, atomic)) {
> +	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, pmu_ctx)) {
>  		pr_debug("failed to read reg 0x%llx for %s:%s\n", ra.reg.val, rd->rp->name, rd->name);
>  		return -EIO;
>  	}
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index 9a7e150b3536..152893dca565 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -110,16 +110,14 @@ static int rapl_cpu_down_prep(unsigned int cpu)
>  	return 0;
>  }
>  
> -static int rapl_msr_read_raw(int cpu, struct reg_action *ra, bool atomic)
> +static int rapl_msr_read_raw(int cpu, struct reg_action *ra, bool pmu_ctx)
>  {
>  	/*
> -	 * When called from atomic-context (eg PMU event handler)
> -	 * perform MSR read directly using rdmsrq().
> +	 * When called from PMU context, perform MSR read directly using
> +	 * rdmsrq() without IPI overhead. Package-scoped MSRs are readable
> +	 * from any CPU in the package.
>  	 */
> -	if (atomic) {
> -		if (unlikely(smp_processor_id() != cpu))
> -			return -EIO;
> -
> +	if (pmu_ctx) {
>  		rdmsrq(ra->reg.msr, ra->value);
>  		goto out;
>  	}
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index f479ef5b3341..fa1f328d6712 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -152,7 +152,7 @@ struct rapl_if_priv {
>  	union rapl_reg reg_unit;
>  	union rapl_reg regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
>  	int limits[RAPL_DOMAIN_MAX];
> -	int (*read_raw)(int id, struct reg_action *ra, bool atomic);
> +	int (*read_raw)(int id, struct reg_action *ra, bool pmu_ctx);
>  	int (*write_raw)(int id, struct reg_action *ra);
>  	void *defaults;
>  	void *rpi;
> -- 
> 2.43.0
> 

