Return-Path: <linux-pm+bounces-8057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADBB8CC76E
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 21:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C094C282436
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 19:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F606142E68;
	Wed, 22 May 2024 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gp9t78h5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A75A929;
	Wed, 22 May 2024 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407148; cv=none; b=mhEJxP3BIy3WkBJAkIjZUz5B89yc8cTPwo6tmuDdPb39r3S2lZGaPvtkWZijrDFes8kC9mXxx+iOEBVW2YLcwGCl8Vqp1gKoxqOdlZlmk9Wnw44lOrDTbejg7qXeyMsnIV4bdAHLJ+lBtb2P6fgMZyIaBuimv3tD+NxczTP96dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407148; c=relaxed/simple;
	bh=VNy3X1gCkM1Q2lQt+/I2zG7AyOiV6ah49bD+X8inkw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE5uGjShWOn9mPS2FNIpX4NvWwInQwzbB86sHTzq+j+6jlPRMt6YAKbcEknjbJTBvY0pbeQAOd5uchq0MHPonuje4zZib6ITxOROo3NlC158mHTMg7ZWwhP9HDZWWH/iH9XsRphJFp7yvIFM+/qbcTMIubBvy0jyJ9jz1dPAAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gp9t78h5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716407147; x=1747943147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VNy3X1gCkM1Q2lQt+/I2zG7AyOiV6ah49bD+X8inkw4=;
  b=Gp9t78h57p+ribgoWSp6DYpU7YLPAd8Bp0T5TxtBNTyTTs6Lz2CgnUJx
   CSyobItc5FgGJGQPMSIgp91ELpKtkR4j3mnT9cBFKQf87tAeB0/Goeogk
   lrBZ4i5gl4RQ+C2AHsj2OWD4FOAitmpnWuEQDdu4pY/ywuzbKNo3l37RE
   NcOk9aKXD900Dt1p7Sm9CFhZT3FpmcJSNn+F8t/8EYTXG9lUik+VAA8Mm
   xy+yAss4xhWxPK4c+9CSE7FZKe022yWeMwxsNv1y9Q+XPXC++edpK2Th0
   oV+o28t4Id8pEQNrLp61mlWZRvc9h9u0H/z9ZYYkM9wnmkUm5F/Jg5z+u
   A==;
X-CSE-ConnectionGUID: mafGFH3KRBKPvFzw0r3fUw==
X-CSE-MsgGUID: EN1rdK+bSkC0keokfFFThA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23822285"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23822285"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 12:45:46 -0700
X-CSE-ConnectionGUID: rp48xsGlTcSri1Fl61eRFg==
X-CSE-MsgGUID: jvSo1K/UT1echsxPpGbLqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37883105"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 May 2024 12:45:41 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9ru7-0001vN-0N;
	Wed, 22 May 2024 19:45:39 +0000
Date: Thu, 23 May 2024 03:45:08 +0800
From: kernel test robot <lkp@intel.com>
To: Xiaojian Du <Xiaojian.Du@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, daniel.sneddon@linux.intel.com, jpoimboe@kernel.org,
	pawan.kumar.gupta@linux.intel.com, sandipan.das@amd.com,
	kai.huang@intel.com, perry.yuan@amd.com, x86@kernel.org,
	ray.huang@amd.com, rafael@kernel.org,
	Xiaojian Du <Xiaojian.Du@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 2/2] cpufreq: amd-pstate: change cpu freq transition
 delay for some models
Message-ID: <202405230325.UPlOikDm-lkp@intel.com>
References: <b2c8fb2da41f9fb21f095f67d99cbdbd0aa34091.1716356681.git.Xiaojian.Du@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2c8fb2da41f9fb21f095f67d99cbdbd0aa34091.1716356681.git.Xiaojian.Du@amd.com>

Hi Xiaojian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master next-20240522]
[cannot apply to tip/x86/core tip/auto-latest v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaojian-Du/cpufreq-amd-pstate-change-cpu-freq-transition-delay-for-some-models/20240522-135241
base:   tip/master
patch link:    https://lore.kernel.org/r/b2c8fb2da41f9fb21f095f67d99cbdbd0aa34091.1716356681.git.Xiaojian.Du%40amd.com
patch subject: [PATCH v2 2/2] cpufreq: amd-pstate: change cpu freq transition delay for some models
config: x86_64-randconfig-006-20240522 (https://download.01.org/0day-ci/archive/20240523/202405230325.UPlOikDm-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405230325.UPlOikDm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405230325.UPlOikDm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:824:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]
     824 |                 else
         |                 ^
   1 warning generated.


vim +824 drivers/cpufreq/amd-pstate.c

   811	
   812	/*
   813	 * Get pstate transition delay time from ACPI tables that firmware set
   814	 * instead of using hardcode value directly.
   815	 */
   816	static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
   817	{
   818		u32 transition_delay_ns;
   819	
   820		transition_delay_ns = cppc_get_transition_latency(cpu);
   821		if (transition_delay_ns == CPUFREQ_ETERNAL)
   822			if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
   823				return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
 > 824			else
   825				return AMD_PSTATE_TRANSITION_DELAY;
   826	
   827		return transition_delay_ns / NSEC_PER_USEC;
   828	}
   829	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

