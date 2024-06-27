Return-Path: <linux-pm+bounces-10117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA791A6E9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 14:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F93F2827FB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B6717FAA2;
	Thu, 27 Jun 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K85+EMsw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF437178CCB;
	Thu, 27 Jun 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492585; cv=none; b=VD8++7S6/XoQKa4+H2mfYw+StLXkEs2JkgjNLN6GIcBQOVgT6WmB/FD15R7IKzXdblYzi48+sCEveqDZrEI1TfuJYdcTuQ9j2m/R8nm6ExSCbcgD4kA5Bq5JGGftUtGjZKzmmU+/zFbF+nLRkCioCdtyrY5yYECPjM8LkhktPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492585; c=relaxed/simple;
	bh=8x1y/BA5HEpl3H5PIsYbNzWqptF+ddQo7TG0proyfUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU0hxls/THXHYdLhhwP6EWqZXQ7mRs6ewcQVFSPEjrWPe44vTFufFDbaNVoX+JrP/0M9mjneY/o6zXvscLbYJFy3wl/7ZpwA9W3cvzLqtYQChKwKgyRsIhBVLlN4le8S7ZbOnqRLoIHwaPV29z6IlwBvrZ0Y/IBiRZsUMrfpQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K85+EMsw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719492584; x=1751028584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8x1y/BA5HEpl3H5PIsYbNzWqptF+ddQo7TG0proyfUc=;
  b=K85+EMsw8MfwP4MzDXcZvoIhJGABSy1HqMMaQMzLTiy1HXhzGcr3UkHO
   i0tuzKsVxtXsFsbrwMlqwkRBDKNQbupQU26Gmr49f4OfT8Z29hNRHBAGm
   vDZQPhFkmHVvjxzg4h0qKHR/hNtuhyyj1UlvektkfGdsY1vWcO7eBJvT9
   iogMrBr8w0C8x4OhDjULaWCNo8EO7z5RjmTciaeWd0ddHlsxZfmK6FxAK
   J3zFuFJcU1fp9lhyh5S28zPxEGwTAfyToap/WF3CaxPV+1kxlo53bBP09
   /q/3ZR/RH5TLdPRD1XkkEGxRe+IZNRSIJCXTvO02O2HGsbLCLdLCNYGct
   w==;
X-CSE-ConnectionGUID: bmGNYaU5QEaB2+Bq2sH6Pw==
X-CSE-MsgGUID: ZSNaYqgDRXi3LKFGDXJXKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="20497855"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="20497855"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:49:43 -0700
X-CSE-ConnectionGUID: MqMx0kdTTweZIqkpI365OA==
X-CSE-MsgGUID: Kt0pFqHxQXO/fF/VvyTNgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49537549"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:49:42 -0700
Date: Thu, 27 Jun 2024 05:55:47 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Brice Goglin <brice.goglin@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 0/9] Add CPU-type to topology
Message-ID: <20240627125547.GC4743@ranerica-svr.sc.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
 <0021f5f2-67c5-4b20-939d-48c9c1c60cdb@gmail.com>
 <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
 <ec4eeab6-ce32-4a2f-a32c-dfd95cdd9ccd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec4eeab6-ce32-4a2f-a32c-dfd95cdd9ccd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Jun 20, 2024 at 05:22:59PM +0200, Brice Goglin wrote:
> Le 20/06/2024 à 17:06, Dave Hansen a écrit :
> 
> > On 6/19/24 14:25, Brice Goglin wrote:
> > > Good point. From this patch series, I understand that the current kernel
> > > side doesn't care about these different E-cores. However it might be
> > > good to expose them as different cpu-types (or better name) to userspace ?
> > > 
> > > Something like type 0 = P-core, 1 = normal E-core, 2 = low power E-core ?
> > The first priority here is getting the kernel to comprehend these types
> > for architectural purposes: when there are functional differences
> > between the cores.
> > 
> > Let's get that in place, first.  Then we can discuss the possibility of
> > new ABI in the area.
> 
> Agreed.
> 
> > Did the ARM folks ever do a sysfs ABI for big.LITTLE?  I don't see
> > anything obvious in Documentation/ABI/testing/sysfs-devices-system-cpu.
> 
> As far as I know, they only have the "capacity" field in sysfs cpu files
> that reports a higher number for the equivalent of P-core:
> 
> From testing/sysfs-devices-system-cpu:
> 
> What:           /sys/devices/system/cpu/cpuX/cpu_capacity
> Date:           December 2016
> Contact:        Linux kernel mailing list <linux-kernel@vger.kernel.org>
> Description:    information about CPUs heterogeneity.
> 
>                 cpu_capacity: capacity of cpuX.
> 
> I don't know how it's calculated but I've never seen it report something wrong.
> On Android/ARM phones, big cores usually have 1024 and small cores something
> between 400 and 500.
> Where there are 3 types of cores, they report 1024, 500-800 about ~250.

I *think* this information comes from firmware tables, but you cannot reliably
infer CPU types from capacity (e.g., Intel's Ecores vs Low Power Ecores).

Also, it is not useful to identify "performance" vs "efficient" CPUs.

