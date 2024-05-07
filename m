Return-Path: <linux-pm+bounces-7611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC728BECBF
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 21:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF41F1C20D6F
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 19:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89E16DEDE;
	Tue,  7 May 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhiMiAzK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F91607A7;
	Tue,  7 May 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110852; cv=none; b=n1DdMaQ1qQyqai9k0kgQk1EaW/CUUIzNArzNu3BpUrUgIiubbxMdN0AfDdYzBdb2jkVvJGfYS27vn+j9IbiBDBuvt9c7ssjrGPWt9A/Ygm/4+HpwF8yBG22C7ymrDfRphFqOZCvGqHspHv8LfhZwfGyaRoPj+ymUgzRq42dryr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110852; c=relaxed/simple;
	bh=MCExTJG3akmiqgdJUA5kJ/OATvP+QAosuc1ov3k7V+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4jMY/QUPk+utLElD3hL/YYIB6ItehvVy+BvVCpaxRbkctErvCFsQmHo2tOOD2BE9MfbLU0837DpBjt3DayiJusfcog+BEK5PW3Jq9ta40048AhoBsRXFtZmaNIQgm7Vu5581+m3W0QgDvBbrpCtsp/hhPWiCD2Et8Y2RGkiplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhiMiAzK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715110851; x=1746646851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCExTJG3akmiqgdJUA5kJ/OATvP+QAosuc1ov3k7V+c=;
  b=FhiMiAzKzp9Pyw7Ury6W+oQpayy/m4jbQqooeLi5NPObYdrsfguSJs9r
   /6Ob+rlSPa69sC1XflJn4eHoQciN4uCWZ099zG5ZdnvEYJ9sbmNUuj3z/
   Tq6TcLA/6+zB5XSh90gQE+f2WBrqULdJ6aTOhDMI5/HC1AESu3jloRqwZ
   akLvVkmTLngbfbuXpNUFjLeMuNYjKvuV6NdFpS1HT+eistn+Tiz43brYU
   GCfyXrmSTORTZqIUVAL23TPqSjkuJZuXNxuXwy4xmpVCMlbqayy91b2ZL
   Yt+Z/H1iZQAlj0+etE2+4zlL+jYHAdaFizYhvBKwvUWbH2d/fdBaQIeA3
   A==;
X-CSE-ConnectionGUID: WOEjvb68TNmwiJ/WEd8Dcw==
X-CSE-MsgGUID: 6r4edEg/Rp6ycUsAp5mtng==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11090829"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11090829"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:40:51 -0700
X-CSE-ConnectionGUID: eQlpIZTvSc2/iNhGnLU2gg==
X-CSE-MsgGUID: ayGnskz1RQCwXKHjxXL3MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28600902"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2024 12:40:47 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4Qg9-0002ae-00;
	Tue, 07 May 2024 19:40:45 +0000
Date: Wed, 8 May 2024 03:40:14 +0800
From: kernel test robot <lkp@intel.com>
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
	Mario.Limonciello@amd.com, viresh.kumar@linaro.org,
	Ray.Huang@amd.com, gautham.shenoy@amd.com, Borislav.Petkov@amd.com
Cc: oe-kbuild-all@lists.linux.dev, Alexander.Deucher@amd.com,
	Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] cpufreq: amd-pstate: implement heterogeneous core
 topology for highest performance initialization
Message-ID: <202405080340.n0nVlmfY-lkp@intel.com>
References: <731a28ea8dda4ca1db64f673c87770de4646290b.1715065568.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731a28ea8dda4ca1db64f673c87770de4646290b.1715065568.git.perry.yuan@amd.com>

Hi Perry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge next-20240507]
[cannot apply to tip/x86/core linus/master v6.9-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Perry-Yuan/cpufreq-amd-pstate-optimiza-the-initial-frequency-values-verification/20240507-151930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/731a28ea8dda4ca1db64f673c87770de4646290b.1715065568.git.perry.yuan%40amd.com
patch subject: [PATCH 09/11] cpufreq: amd-pstate: implement heterogeneous core topology for highest performance initialization
config: i386-buildonly-randconfig-005-20240507 (https://download.01.org/0day-ci/archive/20240508/202405080340.n0nVlmfY-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080340.n0nVlmfY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080340.n0nVlmfY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:59,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/processor.h: In function 'amd_get_this_core_type':
>> arch/x86/include/asm/processor.h:690:1: warning: no return statement in function returning non-void [-Wreturn-type]
     690 | static inline int amd_get_this_core_type(void)          { }
         | ^~~~~~
--
   In file included from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:59,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/processor.h: In function 'amd_get_this_core_type':
>> arch/x86/include/asm/processor.h:690:1: warning: no return statement in function returning non-void [-Wreturn-type]
     690 | static inline int amd_get_this_core_type(void)          { }
         | ^~~~~~


vim +690 arch/x86/include/asm/processor.h

   680	
   681	#ifdef CONFIG_CPU_SUP_AMD
   682	extern u32 amd_get_highest_perf(void);
   683	extern void amd_clear_divider(void);
   684	extern void amd_check_microcode(void);
   685	extern int amd_get_this_core_type(void);
   686	#else
   687	static inline u32 amd_get_highest_perf(void)		{ return 0; }
   688	static inline void amd_clear_divider(void)		{ }
   689	static inline void amd_check_microcode(void)		{ }
 > 690	static inline int amd_get_this_core_type(void)		{ }
   691	#endif
   692	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

