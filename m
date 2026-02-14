Return-Path: <linux-pm+bounces-42632-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BjKGFScYkGmPWAEAu9opvQ
	(envelope-from <linux-pm+bounces-42632-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 07:37:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B351A13B3E9
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 07:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7688130120C3
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 06:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C0305E10;
	Sat, 14 Feb 2026 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjFwZi9j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA92202F65;
	Sat, 14 Feb 2026 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771051044; cv=none; b=VFjWJ58GSUwQHVOs2dgrk3qEK3OiKtDqGAyjlxH8CxraaSFT3Wk3reLwfwcWza4ypyBPBiRn9O/jWPtD+5rIqy/mY17DTzawDEdvIfSglUzO0Ns+Km8FRFuAR5YOL6cVDj+3mzyoWFsLZuzRWTTJiqF54RSdk0gTTumAdIWTRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771051044; c=relaxed/simple;
	bh=O4wcaSchYTaZw9CiVrhloF4oK3nb6+HXB8G5MMszfPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7u4y0KQ7doM7QaKbxVbsuD8nwkic59i3uGmUdKXj1vofRvyop8MQHgmTcfHPQXHGZSxViLxSdCH8eVMGMzyfYJIyJFMSwnDzZnH7m/dzyHbINDV/G3SvKZjngBqGzkbvuULFfGibWX5zV8t9rPZy2Ein9Wlp81ZbzgPLxk/BAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjFwZi9j; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771051043; x=1802587043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O4wcaSchYTaZw9CiVrhloF4oK3nb6+HXB8G5MMszfPc=;
  b=cjFwZi9j/SW51VD8mu/qwU5GQljSYYjB9aeLNg+F6w+zEKuqMpyQ/Gyc
   Hq13Yd2GpYMqD+dgQIOUMKPIwWHfjUyztC6ivKPn/OT7d39wGhNPomIKv
   CHeFp65QuelrRheQ7RXRrvrcT/DOpQEQlmoypYzYB0PbHQQqo+3/1ipeq
   T2uKIUC8jSUFeu8ZkQbGxx3auoF5CiwVaq0GkMlo5Gx4W694VS2CKGVKw
   AgWFBsNo4GmE5F2uKMAzU2fL6RWl+KXuECqj+fK0G/F0y71r5yxjd9U1X
   u2uVK64eIIatManXC07zW+N5kbsBQfhI94Zsrq1agUOWVr8MbsI3Sy++y
   A==;
X-CSE-ConnectionGUID: 0vFGAyDaQcyzDRhdAuABVw==
X-CSE-MsgGUID: vPjYUVKNTweA+5IgtdL2+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="71424848"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="71424848"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 22:37:22 -0800
X-CSE-ConnectionGUID: 4tY7+iApQfC2hWL7pQLkUw==
X-CSE-MsgGUID: AEVwuLz6QWijj859M3Tg2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="217263819"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 22:37:18 -0800
Date: Sat, 14 Feb 2026 07:37:17 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	sk.anirban@intel.com, kamil.konieczny@intel.com
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] powercap: intel_rapl: Prepare read_raw interface
 for atomic-context callers
Message-ID: <aZAYHb0kO8eS0Z_5@black.igk.intel.com>
References: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20251121000539.386069-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121000539.386069-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42632-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: B351A13B3E9
X-Rspamd-Action: no action

On Thu, Nov 20, 2025 at 04:05:38PM -0800, Kuppuswamy Sathyanarayanan wrote:
> The current read_raw() implementation of the TPMI, MMIO and MSR
> interfaces does not distinguish between atomic and non-atomic callers.
> 
> rapl_msr_read_raw() uses rdmsrq_safe_on_cpu(), which can sleep and
> issue cross CPU calls. When MSR-based RAPL PMU support is enabled, PMU
> event handlers can invoke this function from atomic context where
> sleeping or rescheduling is not allowed. In atomic context, the caller
> is already executing on the target CPU, so a direct rdmsrq() is
> sufficient.
> 
> To support such usage, introduce an atomic flag to the read_raw()
> interface to allow callers pass the context information. Modify the
> common RAPL code to propagate this flag, and set the flag to reflect
> the calling contexts.
> 
> Utilize the atomic flag in rapl_msr_read_raw() to perform direct MSR
> read with rdmsrq() when running in atomic context, and a sanity check
> to ensure target CPU matches the current CPU for such use cases.
> 
> The TPMI and MMIO implementations do not require special atomic
> handling, so the flag is ignored in those paths.
> 
> This is a preparatory patch for adding MSR-based RAPL PMU support.

...

> -static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
> +static int rapl_msr_read_raw(int cpu, struct reg_action *ra, bool atomic)
>  {
> +	/*
> +	 * When called from atomic-context (eg PMU event handler)
> +	 * perform MSR read directly using rdmsrq().
> +	 */
> +	if (atomic) {
> +		if (unlikely(smp_processor_id() != cpu))
> +			return -EIO;

This series breaks[1] our application[2] in cases where the reads are
issued from any available CPU it is scheduled on. This issue is not seen on
older platforms which use the original arch/x86 RAPL implementation.

Can someone please shed some light on the change of userspace expectations?
Or did I miss any points in the documentation?

[1] https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6935
[2] https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/lib/igt_power.c

Raag

> +		rdmsrq(ra->reg.msr, ra->value);
> +		goto out;
> +	}
> +
>  	if (rdmsrq_safe_on_cpu(cpu, ra->reg.msr, &ra->value)) {
>  		pr_debug("failed to read msr 0x%x on cpu %d\n", ra->reg.msr, cpu);
>  		return -EIO;
>  	}
> +
> +out:
>  	ra->value &= ra->mask;
>  	return 0;
>  }

