Return-Path: <linux-pm+bounces-26192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29495A9C6BD
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8035C1BC15F5
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11BE242D62;
	Fri, 25 Apr 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP5bCBEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933C823D2BA;
	Fri, 25 Apr 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579471; cv=none; b=hU5HkqVM1UfhrjWWmr1H4bpTFMa+g7yaeAfCS654qeXRFMzWLaydn9Ey6q9w1Yynani+ersXx6rBf3eagY8ZYGvZwDY6WMq2A4iNrP19q/xOvaeAQpgqQ9EshzdL70wt6f6cwlTSTmvd+srAMCxz7waafmkSjudHEy6bf7kB8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579471; c=relaxed/simple;
	bh=1ZSf56sNYI6j4qj01LSEArPtw7DeT0VqLEN7JdmGOec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhM5vhe0e9deN8d0C/Z0BT8l2z9uSiOCNzysjlKKz6+AST19gGBsNaJPmm68CUnpu0LmLxIPui0pZFIR/+QG+EuIsdF1MY5a3icj9o7r5+V/fCsf6NXnBNayPt3p+ou+lhT13KEfvz2+WIe7yi5PpXIDIuh3F7qxNZxPDryVSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP5bCBEF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745579469; x=1777115469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ZSf56sNYI6j4qj01LSEArPtw7DeT0VqLEN7JdmGOec=;
  b=BP5bCBEFKp6I8RQVoMGZW3T6gLG5hQ6fvJhxhc4E/SIvt6JL91IV721v
   zQRrBKfnTsg3VZnIA6EzpAAjIoSFSjDGNKAzSH42b60ORtqnv4z6N0d8P
   EjTwaUUiSE3Kwv7fG4CLteY/2971LubfM38WRPPa+VnSKZdq7cF3Fgppp
   osyBl3QxcJjMocV8NFuKde59OLVgUQnx/j7rCTEmjFIBgEXFMTSsPQCmj
   1SQEax+bPqNbWpTU7iKTQjjW2GOFczmpBLIlQi6ORQJ21QBzxf9IopCVi
   M5HhW8qrgBB8gWtXP3LgKvUM0gCRlCLyFW0ghr87CqLdU9rIFl4Um6MBM
   w==;
X-CSE-ConnectionGUID: zWl8VOU+SUa3qk42KFIvIw==
X-CSE-MsgGUID: v46Vvb9xRD272D7w8PGsoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="51060261"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="51060261"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 04:11:08 -0700
X-CSE-ConnectionGUID: D2igj/P5TFGBykfl8InkmA==
X-CSE-MsgGUID: +BbwTgxQQMiTk6NKZtt5Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="136943683"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Apr 2025 04:11:06 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8GxT-00056f-22;
	Fri, 25 Apr 2025 11:11:03 +0000
Date: Fri, 25 Apr 2025 19:10:31 +0800
From: kernel test robot <lkp@intel.com>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, rafael@kernel.org,
	pavel@kernel.org, len.brown@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_zhonhan@quicinc.com
Subject: Re: [PATCH] PM: QoS: Add support for CPU affinity mask-based CPUs
 latency QoS
Message-ID: <202504251845.LAwzxYtY-lkp@intel.com>
References: <20250424095228.1112558-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424095228.1112558-1-quic_zhonhan@quicinc.com>

Hi Zhongqiu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.15-rc3 next-20250424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhongqiu-Han/PM-QoS-Add-support-for-CPU-affinity-mask-based-CPUs-latency-QoS/20250424-175559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250424095228.1112558-1-quic_zhonhan%40quicinc.com
patch subject: [PATCH] PM: QoS: Add support for CPU affinity mask-based CPUs latency QoS
config: s390-randconfig-001-20250425 (https://download.01.org/0day-ci/archive/20250425/202504251845.LAwzxYtY-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250425/202504251845.LAwzxYtY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504251845.LAwzxYtY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/cpu.c:41:
   In file included from include/trace/events/power.h:8:
   In file included from include/linux/cpufreq.h:19:
>> include/linux/pm_qos.h:335:5: warning: no previous prototype for function 'cpu_latency_qos_affinity_add' [-Wmissing-prototypes]
     335 | int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
         |     ^
   include/linux/pm_qos.h:335:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     335 | int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
         | ^
         | static 
>> include/linux/pm_qos.h:340:5: warning: no previous prototype for function 'cpu_latency_qos_affinity_update' [-Wmissing-prototypes]
     340 | int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
         |     ^
   include/linux/pm_qos.h:340:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     340 | int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
         | ^
         | static 
>> include/linux/pm_qos.h:345:5: warning: no previous prototype for function 'cpu_latency_qos_affinity_remove' [-Wmissing-prototypes]
     345 | int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
         |     ^
   include/linux/pm_qos.h:345:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     345 | int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
         | ^
         | static 
>> include/linux/pm_qos.h:349:5: warning: no previous prototype for function 'cpu_latency_qos_affinity_release' [-Wmissing-prototypes]
     349 | int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
         |     ^
   include/linux/pm_qos.h:349:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     349 | int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
         | ^
         | static 
>> include/linux/pm_qos.h:353:6: warning: no previous prototype for function 'wakeup_qos_affinity_idle_cpu' [-Wmissing-prototypes]
     353 | void wakeup_qos_affinity_idle_cpu(int cpu) {}
         |      ^
   include/linux/pm_qos.h:353:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     353 | void wakeup_qos_affinity_idle_cpu(int cpu) {}
         | ^
         | static 
   In file included from kernel/cpu.c:41:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:335:5: error: redefinition of 'cpu_latency_qos_affinity_add'
     335 | int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
         |     ^
   include/linux/pm_qos.h:335:5: note: previous definition is here
     335 | int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
         |     ^
   In file included from kernel/cpu.c:41:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:340:5: error: redefinition of 'cpu_latency_qos_affinity_update'
     340 | int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
         |     ^
   include/linux/pm_qos.h:340:5: note: previous definition is here
     340 | int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
         |     ^
   In file included from kernel/cpu.c:41:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:345:5: error: redefinition of 'cpu_latency_qos_affinity_remove'
     345 | int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
         |     ^
   include/linux/pm_qos.h:345:5: note: previous definition is here
     345 | int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
         |     ^
   In file included from kernel/cpu.c:41:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:349:5: error: redefinition of 'cpu_latency_qos_affinity_release'
     349 | int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
         |     ^
   include/linux/pm_qos.h:349:5: note: previous definition is here
     349 | int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
         |     ^
   In file included from kernel/cpu.c:41:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:353:6: error: redefinition of 'wakeup_qos_affinity_idle_cpu'
     353 | void wakeup_qos_affinity_idle_cpu(int cpu) {}
         |      ^
   include/linux/pm_qos.h:353:6: note: previous definition is here
     353 | void wakeup_qos_affinity_idle_cpu(int cpu) {}
         |      ^
   5 warnings and 5 errors generated.
--
   In file included from kernel/sched/core.c:88:
   In file included from kernel/sched/sched.h:31:
   In file included from include/linux/cpufreq.h:19:
>> include/linux/pm_qos.h:335:5: warning: no previous prototype for function 'cpu_latency_qos_affinity_add' [-Wmissing-prototypes]
     335 | int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
         |     ^
   include/linux/pm_qos.h:335:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     335 | int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
         | ^
         | static 
>> include/linux/pm_qos.h:340:5: warning: no previous prototype for function 'cpu_latency_qos_affinity_update' [-Wmissing-prototypes]
     340 | int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
         |     ^
   include/linux/pm_qos.h:340:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     340 | int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
         | ^
         | static 
>> include/linux/pm_qos.h:345:5: warning: no previous prototype for function 'cpu_latency_qos_affinity_remove' [-Wmissing-prototypes]
     345 | int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
         |     ^
   include/linux/pm_qos.h:345:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     345 | int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
         | ^
         | static 
>> include/linux/pm_qos.h:349:5: warning: no previous prototype for function 'cpu_latency_qos_affinity_release' [-Wmissing-prototypes]
     349 | int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
         |     ^
   include/linux/pm_qos.h:349:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     349 | int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
         | ^
         | static 
>> include/linux/pm_qos.h:353:6: warning: no previous prototype for function 'wakeup_qos_affinity_idle_cpu' [-Wmissing-prototypes]
     353 | void wakeup_qos_affinity_idle_cpu(int cpu) {}
         |      ^
   include/linux/pm_qos.h:353:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     353 | void wakeup_qos_affinity_idle_cpu(int cpu) {}
         | ^
         | static 
   In file included from kernel/sched/core.c:88:
   In file included from kernel/sched/sched.h:73:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:335:5: error: redefinition of 'cpu_latency_qos_affinity_add'
     335 | int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
         |     ^
   include/linux/pm_qos.h:335:5: note: previous definition is here
     335 | int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
         |     ^
   In file included from kernel/sched/core.c:88:
   In file included from kernel/sched/sched.h:73:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:340:5: error: redefinition of 'cpu_latency_qos_affinity_update'
     340 | int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
         |     ^
   include/linux/pm_qos.h:340:5: note: previous definition is here
     340 | int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
         |     ^
   In file included from kernel/sched/core.c:88:
   In file included from kernel/sched/sched.h:73:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:345:5: error: redefinition of 'cpu_latency_qos_affinity_remove'
     345 | int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
         |     ^
   include/linux/pm_qos.h:345:5: note: previous definition is here
     345 | int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
         |     ^
   In file included from kernel/sched/core.c:88:
   In file included from kernel/sched/sched.h:73:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:349:5: error: redefinition of 'cpu_latency_qos_affinity_release'
     349 | int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
         |     ^
   include/linux/pm_qos.h:349:5: note: previous definition is here
     349 | int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
         |     ^
   In file included from kernel/sched/core.c:88:
   In file included from kernel/sched/sched.h:73:
   In file included from include/trace/events/power.h:10:
   include/linux/pm_qos.h:353:6: error: redefinition of 'wakeup_qos_affinity_idle_cpu'
     353 | void wakeup_qos_affinity_idle_cpu(int cpu) {}
         |      ^
   include/linux/pm_qos.h:353:6: note: previous definition is here
     353 | void wakeup_qos_affinity_idle_cpu(int cpu) {}
         |      ^
   kernel/sched/core.c:7686:12: warning: array index -1 is before the beginning of the array [-Warray-bounds]
    7686 |                                        preempt_modes[preempt_dynamic_mode] : "undef",
         |                                        ^             ~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7661:1: note: array 'preempt_modes' declared here
    7661 | const char *preempt_modes[] = {
         | ^
   6 warnings and 5 errors generated.


vim +/cpu_latency_qos_affinity_add +335 include/linux/pm_qos.h

   325	
   326	#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_PM)
   327	int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
   328				const cpumask_t *affinity_mask, s32 latency_value);
   329	int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
   330				s32 new_value);
   331	int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req);
   332	int cpu_latency_qos_affinity_release(struct list_head *pm_reqs);
   333	void wakeup_qos_affinity_idle_cpu(int cpu);
   334	#else
 > 335	int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
   336				const cpumask_t *affinity_mask, s32 latency_value)
   337	{
   338		return 0;
   339	}
 > 340	int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
   341				s32 new_value)
   342	{
   343		return 0;
   344	}
 > 345	int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
   346	{
   347		return 0;
   348	}
 > 349	int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
   350	{
   351		return 0;
   352	}
 > 353	void wakeup_qos_affinity_idle_cpu(int cpu) {}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

