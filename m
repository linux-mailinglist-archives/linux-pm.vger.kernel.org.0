Return-Path: <linux-pm+bounces-9332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401FC90B050
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 15:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541A81C21EAE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B833198E73;
	Mon, 17 Jun 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOOivvcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B3197A9A;
	Mon, 17 Jun 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630695; cv=none; b=tRrmTfa2OWj/PqlsGm/jVepelKA3ckDrSYlBWYtHTizYoatNQnN+8/mTCoi6vGx+btXw860AuAbelcjLe56FCBVZYMs0cYZSx32hVjKwexqpmC2ulEtPSbj4nSO/2XvRgmbaTixBhx/IRvgy09YfYEFueEi0E8qhnOybEq6bYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630695; c=relaxed/simple;
	bh=3W7OKXAyhdPAO8/WbYF1gIWUxeS2ZzVMV22aj1YWSPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H21BhmQaBnN2tn70XxQ25Y8FmoKz3Nl13pZdLaIiLlYqh+7sJZvbmctSCFJU/Eu4uCrCjDhCJaR36hsMBoj7K1t6VDonk7p+xu2VSQesotoVXbQ+yjD8wZfQKmR3mxYkErLunT0vr0Da0Td1YaBEPxRqaLXTw0Z6+n43mGKj3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOOivvcY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718630694; x=1750166694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3W7OKXAyhdPAO8/WbYF1gIWUxeS2ZzVMV22aj1YWSPw=;
  b=MOOivvcYQUY3oqHCTbuRtvglayhtkHYI9zkY8QrpdtB27syy4duzUME4
   uwAajMiElokhpzyMeSjN7Q8sddWb3wT+EeNn3rVUjI6C64D9n9P4wy4Iu
   rukunao0vCaaR2qKpSSLRHzvl/9iB4zHqvZ7yrgtupak4xmod0IvGuFYH
   o/cab5XVEL1Y+gwhfszLk26jyuqph32z5T9dU/y1RyVk4c/5LwAxXGvMO
   LcbIUk9QMppJ2brifwUynJTP66x0JHnRpq8oaAesWjG7qS2QXZ5WONs3y
   /g26dZQR31FWPm4lUhi9SHCOnFXdr9pC3pW5ktzI6z17INoU6pXpVJDu4
   Q==;
X-CSE-ConnectionGUID: P7YNUh9zSLKHiNjMgYn1Qg==
X-CSE-MsgGUID: Wi9yrzuZR46S18uVzNnsRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="18372708"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="18372708"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 06:24:53 -0700
X-CSE-ConnectionGUID: PPRLjr1UQsmF05dkhgQ1ZA==
X-CSE-MsgGUID: eC9cEVyMRymH4ArabPUkbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41072411"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jun 2024 06:24:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJCLm-0004KB-34;
	Mon, 17 Jun 2024 13:24:46 +0000
Date: Mon, 17 Jun 2024 21:24:20 +0800
From: kernel test robot <lkp@intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
Message-ID: <202406172104.aOlpCnvb-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20240617 (https://download.01.org/0day-ci/archive/20240617/202406172104.aOlpCnvb-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240617/202406172104.aOlpCnvb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406172104.aOlpCnvb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/topology_common.c:145:21: error: use of undeclared identifier 'X86_CPU_TYPE_UNKNOWN'
     145 |         c->topo.cpu_type = X86_CPU_TYPE_UNKNOWN;
         |                            ^
>> arch/x86/kernel/cpu/topology_common.c:148:41: error: use of undeclared identifier 'X86_CPU_TYPE_INTEL_SHIFT'
     148 |                 c->topo.cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
         |                                                       ^
   2 errors generated.


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

