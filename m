Return-Path: <linux-pm+bounces-12376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9389551B0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 22:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81831F229BA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE9E1C3F2D;
	Fri, 16 Aug 2024 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cw0u/3WJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64E80BFF;
	Fri, 16 Aug 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723838420; cv=none; b=OHqGkWjGrUCDXw1hwYnvbX66c06xBZVnK3VR3VwmRr33fQD/aMQ3PdfqflRH8c2SpGr5uJuIGdO0MZWhztCRDrNN3w33ZdD2CDkCcxAZaz8VXajp5HTmg6RApDMlfM1KO43+a0KMN+SBMda++OyGAvPlcpr5d8AxhMtUODfpcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723838420; c=relaxed/simple;
	bh=vIqSPXtwEUcd5MPZRu26qi2+4l/3pimxfpMvymEeGyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT3rSh3M7hiWLr5NordBE7BODa0I3Mo358uzrPGYyPSCok+jDBlOw+bMkiivY+cZLhGWUetHWI4Qx+U8s9Ic4G6f34g5U45iBqDcAila+4m/LdHQlxay4lo8/7M2X37IyH9NEX7fRgN9T97SelFCF98eDu+B5s2PqYlomBPc3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cw0u/3WJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723838419; x=1755374419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vIqSPXtwEUcd5MPZRu26qi2+4l/3pimxfpMvymEeGyE=;
  b=Cw0u/3WJYe7aSPaZ0J2qaAv2WaZJNuxBqhjGAd5Qm7sjQD2IFC0GypBq
   bmMZY9Z67Ax2FyqgGgVdPDUy1dX8i49K9QNnsCPqBI0dT2NyaBzwe4mSK
   1VKM1A26oIetoGke6jvn4b9jd9kYXd4LUSs6naZPwZTObiC1M+6H3dPZA
   9B/Mt3wKg+7WjGAXWsmqLRKw55ewIleamF8R+oKOF2cdjilHQWP7CxtD8
   QlWR58hpNUXPKqo40vL6X8IZxlo/97e781JA80gAigTISMpuiDbpm+yk7
   woa8hUI/jx7n5eQ3vV7CRJZOTSQMrUm9LZ9nFW0/r+S0hnCnB5tSP/tBV
   w==;
X-CSE-ConnectionGUID: VSp1KL5vRuyGSh9Ua4pHrA==
X-CSE-MsgGUID: XrAVTvg1T8iblzlzox0lDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22319068"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="22319068"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 13:00:18 -0700
X-CSE-ConnectionGUID: H+U6fLuOTPWxU6/D8+jBtQ==
X-CSE-MsgGUID: PKuGJ0MWRI+jXWpVDUX+zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64721137"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Aug 2024 13:00:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sf37L-0006t8-1N;
	Fri, 16 Aug 2024 20:00:11 +0000
Date: Sat, 17 Aug 2024 03:59:12 +0800
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
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v3 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <202408170359.M7BAB0O0-lkp@intel.com>
References: <20240815-add-cpu-type-v3-2-234162352057@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-add-cpu-type-v3-2-234162352057@linux.intel.com>

Hi Pawan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7c626ce4bae1ac14f60076d00eafe71af30450ba]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawan-Gupta/x86-cpu-Prepend-0x-to-the-hex-values-in-cpu_debug_show/20240816-122157
base:   7c626ce4bae1ac14f60076d00eafe71af30450ba
patch link:    https://lore.kernel.org/r/20240815-add-cpu-type-v3-2-234162352057%40linux.intel.com
patch subject: [PATCH v3 02/10] x86/cpu/topology: Add CPU type to struct cpuinfo_topology
config: x86_64-randconfig-013-20240816 (https://download.01.org/0day-ci/archive/20240817/202408170359.M7BAB0O0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408170359.M7BAB0O0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408170359.M7BAB0O0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/power/cpu.c:25:
>> arch/x86/include/asm/cpu.h:55:12: warning: 'intel_hw_native_model_id' defined but not used [-Wunused-function]
      55 | static u32 intel_hw_native_model_id(struct cpuinfo_x86 *c)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/intel_hw_native_model_id +55 arch/x86/include/asm/cpu.h

    54	
  > 55	static u32 intel_hw_native_model_id(struct cpuinfo_x86 *c)
    56	{
    57		return 0;
    58	}
    59	#endif
    60	#ifdef CONFIG_IA32_FEAT_CTL
    61	void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
    62	#else
    63	static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
    64	#endif
    65	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

