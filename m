Return-Path: <linux-pm+bounces-13519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B3296B2AC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 09:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7A8282520
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE6A83CDB;
	Wed,  4 Sep 2024 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceuc2Y0t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC026BFA3;
	Wed,  4 Sep 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434391; cv=none; b=hPrUPxj72Gw3SbHHj1WcZxWYYsLTmegFMarFf5WTCmWODXrml2twkNv8bX7AoWZq1/IHOgyJ0GmZvkcg0IEEoX10abEL6VuvhYI4o5IQuFo5svpYfCS7/NBzXNqHYIFhxHs268h5G516ASdBrDfXwHoFnoaWCNkblZEiwTXw0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434391; c=relaxed/simple;
	bh=6/0kN+PdIoKIhYAPwW3m9WLHBECcU7HjeWWLYgFJdLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpyyqLDvCqr0hk5tgWtGEK+NUDI5aQscxJvOv6cx424/1tF8HqgvyjiPrI5N5GBARiFwktLxnR8hzXc3rrfpN5Mp+W3xcs6TIVTmtZsEcQ2PaFYYEYqqlBt6NI2OhKUI3DOR10fajXgx0zDsO7q3MQmlJrYByN9acYtTe8LGb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceuc2Y0t; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725434390; x=1756970390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6/0kN+PdIoKIhYAPwW3m9WLHBECcU7HjeWWLYgFJdLk=;
  b=ceuc2Y0tkiEq017xjVkN65/7PQFF0UF4K9+4F3mySKKiDvAe1sz9MRWB
   lmAuDIv/i7USwUx4Tosz8qE9IL8LEVhudbYVJNEnong8ZYEjjLSmAu8FK
   8F7HA1Wjm1UXYjMiWaKcakBNJQ25OBggYgDvQyHe9Uun3nf8rqFQbR9TZ
   QIQxV5h3GItMpAFzf0mG2cDIraucl03QvtvzppWbATgXJ0ouVSiqvXAmb
   VeyHmRIJ7HvHcROYV/T983s+xX88Dh3s/1ZvxE79sphy9MREuQh9U1Gy4
   3rdxdz7pROY0cDeG0YuHqvxBYd0ZMKdVrvv3XrBKbLvvLiOekMB4Bnmf5
   w==;
X-CSE-ConnectionGUID: y0JUjgwQSpKr7xYgDJxl2A==
X-CSE-MsgGUID: wrb1Q/NSSmm8j7r6z4osAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23951180"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23951180"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 00:19:35 -0700
X-CSE-ConnectionGUID: fFcvEoGVQV2cPP7W3TWGXg==
X-CSE-MsgGUID: A3eARBvSRW2zvVNSl5axkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65901057"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 00:19:34 -0700
Date: Wed, 4 Sep 2024 00:25:21 -0700
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
Subject: Re: [PATCH v3 0/2] x86 / intel_pstate: Set asymmetric CPU capacity
 on hybrid systems
Message-ID: <20240904072521.GA3757@ranerica-svr.sc.intel.com>
References: <3310447.aeNJFYEL58@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3310447.aeNJFYEL58@rjwysocki.net>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Aug 28, 2024 at 01:45:00PM +0200, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-pm/4941491.31r3eYUQgx@rjwysocki.net/
> 
> which was an update of
> 
> https://lore.kernel.org/linux-pm/4908113.GXAFRqVoOG@rjwysocki.net/
> 
> It addresses Ricardo's review comments and fixes an issue with intel_pstate
> operation mode changes that would cause it to attempt to enable hybrid CPU
> capacity scaling after it has been already enabled during initialization.
> 
> The most visible difference with respect to the previous version is that
> patch [1/3] has been dropped because it is not needed any more after using
> the observation that sched_clear_itmt_support() would cause sched domains
> to be rebuilt.
> 
> Other than this, there are cosmetic differences in patch [1/2] (previously [2/3])
> and the new code in intel_pstate_register_driver() in patch [2/2] (previously [3/3])
> has been squashed into hybrid_init_cpu_scaling() which now checks whether or
> not to enable hybrid CPU capacity scaling (as it may have been enabled already).
> 
> This series is available from the following git branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=intel_pstate-testing
> 
> (with an extra debug commit on top).
> 
> The original cover letter quoted below still applies:
> 
> The purpose of this series is to provide the scheduler with asymmetric CPU
> capacity information on x86 hybrid systems based on Intel hardware.
> 
> The asymmetric CPU capacity information is important on hybrid systems as it
> allows utilization to be computed for tasks in a consistent way across all
> CPUs in the system, regardless of their capacity.  This, in turn, allows
> the schedutil cpufreq governor to set CPU performance levels consistently
> in the cases when tasks migrate between CPUs of different capacities.  It
> should also help to improve task placement and load balancing decisions on
> hybrid systems and it is key for anything along the lines of EAS.
> 
> The information in question comes from the MSR_HWP_CAPABILITIES register and
> is provided to the scheduler by the intel_pstate driver, as per the changelog
> of patch [3/3].  Patch [2/3] introduces the arch infrastructure needed for
> that (in the form of a per-CPU capacity variable) and patch [1/3] is a
> preliminary code adjustment.
> 
> This is based on an RFC posted previously
> 
> https://lore.kernel.org/linux-pm/7663799.EvYhyI6sBW@kreacher/
> 
> but differs from it quite a bit (except for the first patch).  The most
> significant difference is based on the observation that frequency-
> invariance needs to adjusted to the capacity scaling on hybrid systems
> for the complete scale-invariance to work as expected.
> 
> Thank you!

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> # scale invariance

You can look at the scaling invariance these patches achieve here

https://pasteboard.co/dhBAUjfr36Tx.png

I tested these patches on an Meteor Lake system. It has CPUs with three
levels of capacity (Pcore, Ecore, and Lcore)

The "Requested work" plot shows a sawtooth pattern of the amount of work
requested as a percentage of the maximum amount of work that can be
obtained from the biggest CPU running at its maximum frequency. The work
is continuously calling getcpu() in a time window of constant duration
with varying percentages of work.

The "Achieved work" plot shows that the Ecore and Lcore cannot complete
as much work as the PCore even when fully busy (see the "Busy %" plot).
Also, bigger CPUs have more idle time.

The "Scale freq capacity" plot shows the current frequency of each CPU
is now scaled to 1024 by their respective max frequencies. It no longer
uses the single arch_max_freq_ratio value. Capacity now scales correctly:
when running at its maximum frequency, the current capacity (see
"Current capacity" plot and refer to cap_scale()) now matches the value
from arch_scale_cpu_capacity() (see "CPU capacity" plot).

The "Task utilization" plot shows that task->util_avg is now invariant
across CPUs.
> 
> 
> 

