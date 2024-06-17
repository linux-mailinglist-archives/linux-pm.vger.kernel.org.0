Return-Path: <linux-pm+bounces-9336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E190B1FD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A4E1F24458
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A376F1B29CD;
	Mon, 17 Jun 2024 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4FWWIGl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03B197A77;
	Mon, 17 Jun 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631957; cv=none; b=ImoalIA8YWRWhrdGEv+pmYFUMPH/QH2bPUx1s4Vt0ANf92SlGTHcz6EYHLDAhAuLPJnncJE2SD9DtAAE9hj/V+USGwAaeBn67btX6GUxW2Sp2hgzjJ5/aTrtTxk28ldRRuEAxQyYSS40CsGioK6l2j/ZyZogfSHCYjdY6niVR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631957; c=relaxed/simple;
	bh=uxUyG9w3kzRRDkCmDR9ae5S/qbGPu4o5T0wPuhZOZm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MScUIVKurqsJjTzGykrd2N6Xnn6RvTVF6EBgGvI1hrKJ3Y/t8eBVV0JdUM/eokcF1LzmVz4xJ0bKNQUPPiIRZrFc5/g8xcB+t9Zq15xXlP9WGHUmeUIelrIHOqZXBW0ugYgcsoqDCjpCUaCIn/8bGASRBI0IrAXVU7ez2uzMm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4FWWIGl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718631954; x=1750167954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uxUyG9w3kzRRDkCmDR9ae5S/qbGPu4o5T0wPuhZOZm4=;
  b=m4FWWIGlGGVbWNWRZBG1ZnFWiEBVfpv64QJHDn0TX8ctBzyRAx7I+sZm
   DExisWi1Jvv23UKvQ068BnxVXU//4D3F7L7mVhkPiHo71Oqn7yP2UpWOx
   tFLJzzvbpai5XRCPgiWsJ6sMN1rgEuQ5blDJO63pR9+34+fcjZ2o+llOd
   JhBAfl94jiMxwVoLj0iqNM7gF2+NdrEfLpN2stXrnIyh+luovVd88xtUm
   RV2GNDjAuSzoMSWvEk0kwLR4geP5AVFJcpj78+0l5kAS639dqApwCK2iX
   TT/BkyMxgIcaoIlSzaRyfwoUxVOcFkNismlmjxiaKzgMYYRaRsYlWQaEL
   Q==;
X-CSE-ConnectionGUID: iYXybY+xTI+IiWLZjdo0tg==
X-CSE-MsgGUID: LxOHWzXiSW6RPI3tw7WW9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15423009"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15423009"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 06:45:54 -0700
X-CSE-ConnectionGUID: yRDSuFj8TKGtE6IfgTep9g==
X-CSE-MsgGUID: 3AxYSsRuSoWIkXxrMDqhRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="64394193"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Jun 2024 06:45:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJCg7-0004LF-26;
	Mon, 17 Jun 2024 13:45:47 +0000
Date: Mon, 17 Jun 2024 21:45:45 +0800
From: kernel test robot <lkp@intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel.sneddon@linux.intel.com,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
Message-ID: <202406172100.6R91rhbf-lkp@intel.com>
References: <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>

Hi Pawan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 83a7eefedc9b56fe7bfeff13b6c7356688ffa670]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawan-Gupta/x86-cpu-topology-Add-x86_cpu_type-to-struct-cpuinfo_topology/20240617-172542
base:   83a7eefedc9b56fe7bfeff13b6c7356688ffa670
patch link:    https://lore.kernel.org/r/20240617-add-cpu-type-v1-1-b88998c01e76%40linux.intel.com
patch subject: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct cpuinfo_topology
config: i386-buildonly-randconfig-003-20240617 (https://download.01.org/0day-ci/archive/20240617/202406172100.6R91rhbf-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240617/202406172100.6R91rhbf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406172100.6R91rhbf-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/cpu/topology_common.c: In function 'topo_set_cpu_type':
>> arch/x86/kernel/cpu/topology_common.c:145:21: error: 'X86_CPU_TYPE_UNKNOWN' undeclared (first use in this function)
     145 |  c->topo.cpu_type = X86_CPU_TYPE_UNKNOWN;
         |                     ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/topology_common.c:145:21: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/kernel/cpu/topology_common.c:148:41: error: 'X86_CPU_TYPE_INTEL_SHIFT' undeclared (first use in this function)
     148 |   c->topo.cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/X86_CPU_TYPE_UNKNOWN +145 arch/x86/kernel/cpu/topology_common.c

   142	
   143	static void topo_set_cpu_type(struct cpuinfo_x86 *c)
   144	{
 > 145		c->topo.cpu_type = X86_CPU_TYPE_UNKNOWN;
   146	
   147		if (c->x86_vendor == X86_VENDOR_INTEL && cpuid_eax(0) >= 0x1a)
 > 148			c->topo.cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

