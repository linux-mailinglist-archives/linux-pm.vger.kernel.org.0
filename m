Return-Path: <linux-pm+bounces-12921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417E095FDA4
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 01:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758F91C22279
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF26C1494AB;
	Mon, 26 Aug 2024 23:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZKEdDZ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAE487A5;
	Mon, 26 Aug 2024 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713247; cv=none; b=CsPHOWdW10TWyG6Ay1lmqDQKMTtyEv6yFF4O/rfs9lwpiiLVJmeZMcZlksltuN2mstXY8yB/9BTpZYtyNYq9BIomqLGXCnrQFYqKFU5Als7DWvG9tu36CSb1F6PNwbkBeJcerisUKIfBqEeqCwWmIfd3pqGxHksiKOAdUAhFjfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713247; c=relaxed/simple;
	bh=rsW3FuTSU9Hd0/Ixqri1uU9UjBMBX0oRwPSLiLLbOss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwyVVogj2VtMh+66Amj61eMVB7bVefrpXlw6nDEgBdLSgw4/+vmlweUFbSf+1UdjzLJpDaQgbaLQbiMe7xC9QMdhjQSgyBPgXqPGYp/BAIvfEa80lDgLFjHiqlJUR9jQb28TTKgy2en5ksFpAKzWkHGLWkDeDpbMsGUVz9rUXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZKEdDZ7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724713246; x=1756249246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rsW3FuTSU9Hd0/Ixqri1uU9UjBMBX0oRwPSLiLLbOss=;
  b=FZKEdDZ7bKIVxEzVYX0bNDTzVxwL4Wuq/3Qw5axvrAMNwtrqR1Ndx6gR
   aMMOlaKEcGiRGTsIOW0V9vO59+lNYdPJBaj5lf9AUlNeC8epF4pi3uU6X
   ZFtNSk+cdY3KLotkcUqjuznl5ZCJCkmz4ttSZZ+IIqEaHiUlcNVpqt4qI
   5vBGfByShpXqilfTNKjuXrSS/e3BjF650a2TvnyYd3Cjz+QmO6go+qTa+
   0vgqAiBPYVtE0J2W3dA94oZXg68weldUM3qhub2cTOc0Eh/zhhmoOvVu7
   7Rvjh8zjKFbvmksaxyFPriuJbOnDdpGaAM6ExJ5LT3O2iG1zxpm/PKgW+
   g==;
X-CSE-ConnectionGUID: H1RdixpURNy13sd7WzYyAA==
X-CSE-MsgGUID: NByRm+TETtGgjltalqQcKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23047280"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23047280"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 16:00:46 -0700
X-CSE-ConnectionGUID: 45HimrjyQhqOeQ2kHp3hLg==
X-CSE-MsgGUID: gXJDuSo7SB6UOk1KYgOYOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="93454540"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 16:00:45 -0700
Date: Mon, 26 Aug 2024 16:07:42 -0700
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
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: Set asymmetric CPU
 capacity on hybrid systems
Message-ID: <20240826230742.GA7773@ranerica-svr.sc.intel.com>
References: <4941491.31r3eYUQgx@rjwysocki.net>
 <3311190.44csPzL39Z@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3311190.44csPzL39Z@rjwysocki.net>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Aug 12, 2024 at 02:44:30PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[...]
> @@ -3143,6 +3341,20 @@ static int intel_pstate_register_driver(
>  
>  	global.min_perf_pct = min_perf_pct_min();
>  
> +	/*
> +	 * On hybrid systems, use asym capacity instead of ITMT, but because
> +	 * the capacity of SMT threads is not deterministic even approximately,
> +	 * do not do that when SMT is in use.
> +	 */
> +	if (hwp_is_hybrid && !sched_smt_active() &&
> +	    arch_enable_hybrid_capacity_scale()) {
> +		sched_clear_itmt_support();
> +
> +		hybrid_init_cpu_scaling();
> +
> +		arch_rebuild_sched_domains();

sched_clear_itmt_support() also calls arch_rebuild_sched_domains(). The
latter is also called earlier via sched_set_itmt_support(), totaling 3
calls, two of which are wasted.

Perhaps at minimum hybrid_init_cpu_scaling() can be before
sched_clear_itmt_support(). The changes made by these two functions will
be picked up in a single call of arch_rebuild_sched_domains().

Moreover, ITMT can be not enabled at all if so we wish. By the time
intel_pstate_set_itmt_prio() is called, the value of hwp_is_hybrid is
already known.

