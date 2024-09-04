Return-Path: <linux-pm+bounces-13510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50C96B15E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC08281B43
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 06:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5833312C489;
	Wed,  4 Sep 2024 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9uA2AbT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CD53D6B;
	Wed,  4 Sep 2024 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430620; cv=none; b=dThaIcDyBfA1sN3T54ZxOF3vYQDCo7XGwEI07Dr3E97pEhjIj46mlxmc1oIAzRqNXhCHSLrQ9qtoKhkv86pqRFL1Pk+2Pht9NnurXmZaq2u7LVNqf7dFBW5bBdEGmsBl+3m2QydSjxbLAaXLRJABY8WLR13FhIKytvOjEYtq+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430620; c=relaxed/simple;
	bh=adNNc8DC5v9N4P7mgThkT8ETOdJZ6DtSIxX+77SKT6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afl7TqfxVFCc5B55eFfc0fiWYz267aScI9cqqJvhanGGEODNlT93Y9lgROvcc5Y5EC4GFiTN3Y22ZKiEjBQD1yO2sMhDOk+SNdrg5205jxhqoT6OlqCHlVK6eR9+XrvQZV1S7Lc4FGUBFo2cp20pKFiV24Ut1AoYGqH5OfXpZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9uA2AbT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725430619; x=1756966619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=adNNc8DC5v9N4P7mgThkT8ETOdJZ6DtSIxX+77SKT6w=;
  b=V9uA2AbTSU1hm0y/Eo9lrXwZkqYhO1qZwDeV6B9rJjsvYG6iUoeUSudW
   xuXiv/YHeUTPpgYHEygHG+apUO/xJkbRrDqTY3RwDXn495nqtlzXXynPD
   f3McCudOYMm9CWtBPb6VhzIib0L3Q7VR1rcn0rXh5ORSzNqDMVq+MN/VE
   zRFZYKbJ71cN2y76f7IGng1StAmmmiTdomtOolgYUNdoBJMOn3dnHigrb
   X0lU7Yo0/U5zWzfykp4jDwqSLAA1EsDf5w9hO7ANb/9KUiKo1jbejLYzt
   fCa5VW5cNgZbxUWZ/c3WBUSTbAEvS/RqWV+XfbiIbXVhTzHehXnmXOB5d
   Q==;
X-CSE-ConnectionGUID: evcMns/pSL6ZmeZPzEqNKg==
X-CSE-MsgGUID: vPNRXtY8Q9+PMFvGTcepqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35428328"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35428328"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 23:16:58 -0700
X-CSE-ConnectionGUID: DGTO71dNS/G9eYp1Is0q/A==
X-CSE-MsgGUID: 9m9NqvrqR76nHXrymkBHQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65679468"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 23:16:57 -0700
Date: Tue, 3 Sep 2024 23:22:44 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 1/2] x86/sched: Add basic support for CPU capacity
 scaling
Message-ID: <20240904062244.GA3614@ranerica-svr.sc.intel.com>
References: <3310447.aeNJFYEL58@rjwysocki.net>
 <10523497.nUPlyArG6x@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10523497.nUPlyArG6x@rjwysocki.net>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Aug 28, 2024 at 01:47:25PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order be able to compute the sizes of tasks consistently across all
> CPUs in a hybrid system, it is necessary to provide CPU capacity scaling
> information to the scheduler via arch_scale_cpu_capacity().  Moreover,
> the value returned by arch_scale_freq_capacity() for the given CPU must
> correspond to the arch_scale_cpu_capacity() return value for it, or
> utilization computations will be inaccurate.
> 
> Add support for it through per-CPU variables holding the capacity and
> maximum-to-base frequency ratio (times SCHED_CAPACITY_SCALE) that will
> be returned by arch_scale_cpu_capacity() and used by scale_freq_tick()
> to compute arch_freq_scale for the current CPU, respectively.
> 
> In order to avoid adding measurable overhead for non-hybrid x86 systems,
> which are the vast majority in the field, whether or not the new hybrid
> CPU capacity scaling will be in effect is controlled by a static key.
> This static key is set by calling arch_enable_hybrid_capacity_scale()
> which also allocates memory for the per-CPU data and initializes it.
> Next, arch_set_cpu_capacity() is used to set the per-CPU variables
> mentioned above for each CPU and arch_rebuild_sched_domains() needs
> to be called for the scheduler to realize that capacity-aware
> scheduling can be used going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3:
>    * Rebase after dropping patch [1/3].
>    * Rename arch_set_cpu_capacity() arguments.
>    * Add empty line to arch_enable_hybrid_capacity_scale().
>    * Declare local variables in scale_freq_tick() on one line.
> 
> v1 -> v2:
>    * Replaces WARN_ON_ONCE() with WARN_ONCE() (2 places)
>    * Fix arch_enable_hybrid_capacity_scale() return value when hybrid
>      capacity scaling is already enabled.
>    * Allow arch_enable_hybrid_capacity_scale() to succeed when
>      frequency-invariance is not enabled.
>    * Fix arch_set_cpu_capacity() kerneldoc comment
>    * Do not disable capacity scaling in disable_freq_invariance_workfn().
>    * Relocate arch_hybrid_cap_scale_key definition.
> 
> ---

Only one minor comment below...

FWIW:
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> # scale invariance

[...]

> +
> +static struct arch_hybrid_cpu_scale __percpu *arch_cpu_scale;
> +
> +/**
> + * arch_enable_hybrid_capacity_scale - Enable hybrid CPU capacity scaling

This looks to me like a kernel-doc comment. The function name should have ().

[...]
> +/**
> + * arch_set_cpu_capacity - Set scale-invariance parameters for a CPU

Same here.

