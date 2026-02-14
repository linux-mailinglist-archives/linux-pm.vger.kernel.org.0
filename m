Return-Path: <linux-pm+bounces-42640-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wSzmFPKekGnkbgEAu9opvQ
	(envelope-from <linux-pm+bounces-42640-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 17:12:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A99113C6C4
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 17:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 232CE301D6A9
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D5280317;
	Sat, 14 Feb 2026 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYkxSDmX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BB136E3F;
	Sat, 14 Feb 2026 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085551; cv=none; b=aHswmf91jnhlq9gdHoDr4E1bzm1KbLAk1fQNXHn+6sspQ9NJsxvCqJ1gIs92oeK137OOgxULzLTSl8OrqcLbmEuXWGOWORzjUWC9KQQXDmecYLiKMqqH5jS+3yQ4v/236a7PeBkQNlNvEiZ5Uq2o1ZNEwKWJHlD7eTjIQrQICv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085551; c=relaxed/simple;
	bh=OTWHQXD36mqkalwGubVCV91Zotzok8gVblqwlp8QNGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo1kIH36h42UE+xSgYhKBcTOORGdjnNgpssVd4WMr+lNvPo80yLmeaDm38tFQ3FN8Do2m7nx26qqltKmqyPM3B5Ct/uNYtyv1T7p1HXqe8NmBG0Unpu8jgafMHiY3ukI5X4njbSr+ziDjk2r6p04tyIl03RrFnR6MNCSUvzAKqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYkxSDmX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771085549; x=1802621549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OTWHQXD36mqkalwGubVCV91Zotzok8gVblqwlp8QNGE=;
  b=NYkxSDmXjL+bamQB7SDG849xcWs1pLRoo7reR3WsKtIeC3Pc6w1k6dnm
   fOWyv1RnhqAKB4/6IHfj1enIjin4jIUwY4zqateP1L9kYWuaB/VER18lm
   CDP+PjJJbnlrx4Bo5DUJ1vHx7Wn7311CM2ZzwTQGEOgSKTIbGpw3XR7O6
   L6y91IH05nqaxU+dIZ/loRX46QO2m/q/r01xgLKThsn8qyC+NdrM0DRTC
   qeJHTmTA/RLPu7k+ko/SrHeq7RWxTk/Mtf8bqc1WJ4N7DVmHwO6ENq8Nv
   4XH/xqh2QWU4O/V2RwBN4ZfjVBH5NvLL0Mx2ke7AWmrFa08S6fsqZN2Tz
   A==;
X-CSE-ConnectionGUID: lBB/18QRSLO+MgYfQ/ckmQ==
X-CSE-MsgGUID: OyyHFwdZRCS25SS6Q8lTVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="83345272"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="83345272"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 08:12:28 -0800
X-CSE-ConnectionGUID: e8/B0/K6Q8esOBCZCjY4TQ==
X-CSE-MsgGUID: akqK1t48SeedeCmD8uOmpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="212049850"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 08:12:27 -0800
Date: Sat, 14 Feb 2026 17:12:24 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: sk.anirban@intel.com, kamil.konieczny@intel.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] powercap: intel_rapl: Prepare read_raw interface
 for atomic-context callers
Message-ID: <aZCe6NvXcj2okUFT@black.igk.intel.com>
References: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20251121000539.386069-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aZAYHb0kO8eS0Z_5@black.igk.intel.com>
 <3cf5e862-b723-492a-8a1e-044e846b62c3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf5e862-b723-492a-8a1e-044e846b62c3@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42640-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 9A99113C6C4
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 07:31:04AM -0800, Sathyanarayanan Kuppuswamy wrote:
> On 2/13/26 10:37 PM, Raag Jadav wrote:
> > On Thu, Nov 20, 2025 at 04:05:38PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > The current read_raw() implementation of the TPMI, MMIO and MSR
> > > interfaces does not distinguish between atomic and non-atomic callers.
> > > 
> > > rapl_msr_read_raw() uses rdmsrq_safe_on_cpu(), which can sleep and
> > > issue cross CPU calls. When MSR-based RAPL PMU support is enabled, PMU
> > > event handlers can invoke this function from atomic context where
> > > sleeping or rescheduling is not allowed. In atomic context, the caller
> > > is already executing on the target CPU, so a direct rdmsrq() is
> > > sufficient.
> > > 
> > > To support such usage, introduce an atomic flag to the read_raw()
> > > interface to allow callers pass the context information. Modify the
> > > common RAPL code to propagate this flag, and set the flag to reflect
> > > the calling contexts.
> > > 
> > > Utilize the atomic flag in rapl_msr_read_raw() to perform direct MSR
> > > read with rdmsrq() when running in atomic context, and a sanity check
> > > to ensure target CPU matches the current CPU for such use cases.
> > > 
> > > The TPMI and MMIO implementations do not require special atomic
> > > handling, so the flag is ignored in those paths.
> > > 
> > > This is a preparatory patch for adding MSR-based RAPL PMU support.
> > ...
> > 
> > > -static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
> > > +static int rapl_msr_read_raw(int cpu, struct reg_action *ra, bool atomic)
> > >   {
> > > +	/*
> > > +	 * When called from atomic-context (eg PMU event handler)
> > > +	 * perform MSR read directly using rdmsrq().
> > > +	 */
> > > +	if (atomic) {
> > > +		if (unlikely(smp_processor_id() != cpu))
> > > +			return -EIO;
> > This series breaks[1] our application[2] in cases where the reads are
> > issued from any available CPU it is scheduled on. This issue is not seen on
> > older platforms which use the original arch/x86 RAPL implementation.
> > 
> > Can someone please shed some light on the change of userspace expectations?
> > Or did I miss any points in the documentation?
> > 
> > [1] https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6935
> > [2] https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/lib/igt_power.c
> 
> The access with non-lead CPUs is fixed by following series:
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0gh_3y4+2qepC5Mqos+y+kBfGgeEKdmL5s6J4MBGcrQzw@mail.gmail.com/T/#mabe68b0d5c3e5571c9333ff915d38562ec7fed71
> 
> Can you please re-test with this above series?

Working now, thanks for the fix :)

Raag

> > > +		rdmsrq(ra->reg.msr, ra->value);
> > > +		goto out;
> > > +	}
> > > +
> > >   	if (rdmsrq_safe_on_cpu(cpu, ra->reg.msr, &ra->value)) {
> > >   		pr_debug("failed to read msr 0x%x on cpu %d\n", ra->reg.msr, cpu);
> > >   		return -EIO;
> > >   	}
> > > +
> > > +out:
> > >   	ra->value &= ra->mask;
> > >   	return 0;
> > >   }
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

