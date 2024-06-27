Return-Path: <linux-pm+bounces-10115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1BB91A6CF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 14:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFFB1C20AE4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E751779BB;
	Thu, 27 Jun 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYEqjhng"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A11581E1;
	Thu, 27 Jun 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492351; cv=none; b=tr/xUL4B5iJBwpPaI+HoqaQdra3c9qrtep6yX+SntJPHT/vBwETFBjAWkbOdwwWE430YVG/zp2+lM8OwxbmUWcShHAzXONqkZ1a0YTmq2Ea7yHpgXR0sadRJXLbO7u6jzLi84/pjB2KVSLOVWk2PdXXVfNftLtW0E6nD/3RXFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492351; c=relaxed/simple;
	bh=kzLjW83/58j+7eIFdoNOekMG35rdMimMsZmjjIIOGrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/KfRZeC/MgT52Aq8PZAp3Tl69NmoyfW1eddSlniuTE3u2jhqjCsG/WJtBkiSkm1Yc+pOhp6XHQFH/zWGH6VoNwVq9lA7EpyKUQY7Fbz9t7YDQJRwv+KrCHwxVi+zcptBt14jDLXHGeWYVXyqJDPlsLJJy+SPkCLiA2sQtyr+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYEqjhng; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719492350; x=1751028350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzLjW83/58j+7eIFdoNOekMG35rdMimMsZmjjIIOGrc=;
  b=WYEqjhngbr+AhKtMm3xbhijVRNtF0LWwqZpJdNBKLZyiZ2eVIfYuXD4C
   N9RUUFOY5XYBh+nqtvSs3wWsNSOEgkpLig1d4McmCDIWRVELzEuOvS02Z
   YuaSHpGcBvT6WumS2FJskNYu2W+UflUI0jhoPG3zrxt3+ydJJJTXd64wO
   ua8D8VSH25OIb7r49aTvshbXOs/GeMEtEnUBYRMWnk1VXPmSHKOdpVt4i
   KuzfP+qonOS9sA9RfmlBAPZsFxheWHb34yYxRkw6F4RSq2iSI+TN84ikI
   vxum4h+IdOwARFIAkJmmiTbapUls3Vhc8/kCd62KRlx/A92cKZZInGcKz
   g==;
X-CSE-ConnectionGUID: 7RhWomrxQ/Wjun3wiYn0Lw==
X-CSE-MsgGUID: prbDpuwuRGW/ER4Q+HxI3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19501750"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="19501750"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:45:49 -0700
X-CSE-ConnectionGUID: BgCU1k5lST237jrSSf5nGw==
X-CSE-MsgGUID: faB+XbraTrSzCZHWq2RSIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="67573958"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:45:48 -0700
Date: Thu, 27 Jun 2024 05:51:54 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Brice Goglin <brice.goglin@gmail.com>,
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
Message-ID: <20240627125154.GA4743@ranerica-svr.sc.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
 <0021f5f2-67c5-4b20-939d-48c9c1c60cdb@gmail.com>
 <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Jun 20, 2024 at 08:06:11AM -0700, Dave Hansen wrote:
> On 6/19/24 14:25, Brice Goglin wrote:
> > Good point. From this patch series, I understand that the current kernel
> > side doesn't care about these different E-cores. However it might be
> > good to expose them as different cpu-types (or better name) to userspace ?
> > 
> > Something like type 0 = P-core, 1 = normal E-core, 2 = low power E-core ?
> 
> The first priority here is getting the kernel to comprehend these types
> for architectural purposes: when there are functional differences
> between the cores.
> 
> Let's get that in place, first.  Then we can discuss the possibility of
> new ABI in the area.
> 
> Did the ARM folks ever do a sysfs ABI for big.LITTLE?  I don't see
> anything obvious in Documentation/ABI/testing/sysfs-devices-system-cpu.
> 

ARM has the interface /sys/devices/system/cpu/cpu0/regs/identification

Here they show the Main ID Register [A]. This register has CPU
identification fields such as architecture and other details. The
architecture can be specified as a number or refer to architecture-specific
features in other registers.

On my DragonBoard 845c, this interface shows different values for different
types of CPUs.

For functionality, there is also a /sys/devices/system/cpu/aarch32_el0. It
lists the CPUs that can 32-bit ARM programs on processors in which only a
subset of CPUs can do it.

ARM gives userspace specific details. This makes more sense to me. Instead
of reading these details, user space would have to infer these details if
a CPU type was given in sysfs.

Having said that, Intel does have a CPUID leaf that gives the CPU type. Such
leaf also has a "Native Model ID". Exposing only the CPU type may not be
sufficient.

[A]. https://developer.arm.com/documentation/ddi0595/2020-12/AArch64-Registers/MIDR-EL1--Main-ID-Register

