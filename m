Return-Path: <linux-pm+bounces-9523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23D90E16E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196671C21A54
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 01:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DD6208AD;
	Wed, 19 Jun 2024 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDGSa2+B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73818E20;
	Wed, 19 Jun 2024 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762005; cv=none; b=tGz7cGeWO8v3Rg2EniQgJROLhMYc6JgVhaiVu4Y3oseA+UKg3//VKdvKLGWiLA+dauopblpqyJdEpyLTAVA1Q3863a7gzmkIJE+wMJnVkhY9WdStvjHe50AfabPtJ1ah1Y36i6pIO3tF6KlnhkXO6USZ/++UUTfUAz8u2rsupLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762005; c=relaxed/simple;
	bh=y4h/IiEH9QhlxPRAVfEhG72ug8DRAf2ofzXJM2sJ1qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeQyHsIH23PL4dW27TTjXWSbiBIibT1oQrJigz2YbMM7NsxR1McWtVQXo+rC636k2DzvzFH/uLpXfM28LT/9qmWUaH+C6STxwYZgQa70LFFvvINvsVC2+s1rsg/hMQjOHP6x6brQdZf5Wezw00itijcl2DzcqGXeZEbgfrz8dbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDGSa2+B; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718762004; x=1750298004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=y4h/IiEH9QhlxPRAVfEhG72ug8DRAf2ofzXJM2sJ1qM=;
  b=lDGSa2+BTjeRlCO7QZBVk9jvT/m+L6mSOOx+kaMYYdzGKmmyCbg0WW4g
   /op5LaQxaNl03nT974jJEJmbG8ieZLTKHIrTkcnmuw14/RQFYDGNYSHMH
   nY5SC/xuTmaCH+cuD+SqCasdrEU43pJC5edlOv17ByAVf6OBqwebUbFDp
   3Jdnx2p39OBF2HXmVj7bwXkv6BEWjf5s+SPf6C1Zyf95QEwR3vxEtFBS/
   vTvuoFTXjQ17pRuyK0hnE3gLqh7Bcza7sfsYnf9xpatdBOSpO6OBxEiiU
   K7yQff5vDm9FL6TnNVXCkTATlqmVFvHdi+x8MWRqMjN4WPffzp9pYP+pD
   Q==;
X-CSE-ConnectionGUID: G3UI+FqiQSKdITeppl7nxA==
X-CSE-MsgGUID: t78bVsbRRNWZ5mWeeM5fSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19461672"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="19461672"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 18:53:23 -0700
X-CSE-ConnectionGUID: 2/1oZ4ocRuGCLo1eL49vLg==
X-CSE-MsgGUID: jtHcrt+CSm6csXi6+iqLjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41672159"
Received: from cgroden-mobl.amr.corp.intel.com (HELO desk) ([10.209.70.214])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 18:53:22 -0700
Date: Tue, 18 Jun 2024 18:53:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Brice Goglin <brice.goglin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 0/9] Add CPU-type to topology
Message-ID: <20240619015315.3ei5f6rovzdnxovo@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>

On Tue, Jun 18, 2024 at 02:49:10PM +0200, Brice Goglin wrote:
> Le 17/06/2024 à 11:11, Pawan Gupta a écrit :
> > Hi,
> > 
> > This series adds support for CPU-type (CPUID.1A.EAX[31-24] on Intel) to
> > differentiate between hybrid variants P+E, P-only, E-only that share the
> > same Family/Model/Stepping. One of the use case for CPU-type is the
> > affected CPU table for CPU vulnerabilities, which can now use the CPU-type
> > to filter the unaffected variants.
> > 
> > * Patch 1 adds cpu-type to CPU topology structure and introduces
> >    topology_cpu_type() to get the CPU-type.
> > 
> > * Patch 2-4 replaces usages of get_this_hybrid_cpu_type() with
> >    topology_cpu_type().
> > 
> > * Patch 5-7 Updates CPU-matching infrastructure to use CPU-type.
> > 
> > * Patch 8 cleans up the affected CPU list.
> > 
> > * Patch 9 uses the CPU-type to exclude P-only parts from the RFDS affected
> >    list.
> 
> 
> Hello
> 
> Is there still a plan to expose this info in sysfs?

Sure, if it helps userspace.

> Userspace currently uses frequencies to guess which cores are E or P.
> Intel sent some patches several years ago [1], but they got abandoned
> nowhere as far as I know. There was also some discussion about using a
> "capacity" field like ARM does, but IIRC Intel didn't like the idea in
> the end.

There can be many ways to expose this information in sysfs. Like this ...

> [1] https://lkml.org/lkml/2020/10/2/1208

... exposes /sys/devices/system/cpu/types which, in hybrid parts, creates a
subdirectory for each type of CPU. Each subdirectory contains a CPU list
and a CPU map that user space can query.

The other way is to expose the CPU-type in a file:

	/sys/devices/system/cpu/cpuN/type

that could return the CPU-type of the CPU N. Is there a preference?

