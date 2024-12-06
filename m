Return-Path: <linux-pm+bounces-18669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F9D9E6499
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 04:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14373188556A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 03:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0B183098;
	Fri,  6 Dec 2024 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mevta1bH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6A18E361;
	Fri,  6 Dec 2024 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733454700; cv=none; b=dpwoCL3nvUTYwGB/Bpeln8295jh7sBY6Byrul43z9Z2wKeWXSyl6fA4zfd6KZQBCDPF0kuTiFqUYj7PvLTFsjEtIkBZgN5pzZaNhp3I2CmibIRsB6QRp/If7hAoaFa5xPHRgVVLAx0v9R9iBMzfuTF2xb0k60ZZ3D+wEJ/ZTCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733454700; c=relaxed/simple;
	bh=2p7yAnzIn4l4lR9klx+Ihd8mz1BQuI2IefYmFHxauns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/BzPae6Jt6JHUVh0OTMB7X4PgWFOASw/JqkCstleG5VMrdJJQDCrc1hZia8Ib4VaMffyKcqbSK7hns2JtoM5O/LLn+n/TjP1VnOVqZP0bku4301g98BHTqreNN0moq5qCKA7ozbw1F72wg1GQPiez00vlnD8zGRgTnQkVr5Phw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mevta1bH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733454699; x=1764990699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2p7yAnzIn4l4lR9klx+Ihd8mz1BQuI2IefYmFHxauns=;
  b=mevta1bHdIA1mcFSdTok8k45Cb2qowmZDo+IsZA7C1gAT0WWAPps1og9
   2ing/N2ZhiDVRh5smeGDkP0iaU5Gs8tm5UMviM/66ud6UOvOEAbNNfsCx
   F7wXTanU13x9BwPJj9kOzhjdLAe/am4Us7Cy9zni9rAwaGWMuoDu0CiqI
   mCcPucz77s1QIX2RVXZZ4oupgDVPaLQhfNGazvSbq3fxZA9pxaR5U/LIa
   Sy4EozEW31/uE7FJ5oRfKPCUK2hh+vOojv3pwgAL3RZPKElTNugB96cwU
   cpGaDZH8gHbfLS+pkNd980C3eBCxOGaJf8FPqJvUN25/EWSLQDVvlI8ip
   A==;
X-CSE-ConnectionGUID: jS1ivcb8R4mRN0JTcgp09w==
X-CSE-MsgGUID: zyoFgzMKQqWGJM7pJxlM8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33945828"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33945828"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 19:11:39 -0800
X-CSE-ConnectionGUID: P2kuHB3BQ8yLcCjGFXSfJQ==
X-CSE-MsgGUID: cXZLOWEJQ2KzQ+kyzt9UTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="125118657"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Dec 2024 19:11:36 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJOkf-0000eV-1T;
	Fri, 06 Dec 2024 03:11:33 +0000
Date: Fri, 6 Dec 2024 11:10:52 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 10/15] cpufreq/amd-pstate: Move limit updating code
Message-ID: <202412061054.cJTnhP0n-lkp@intel.com>
References: <20241205222847.7889-11-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-11-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ab9e5b2eb56412cb8c63b46b935878d29205418e]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/cpufreq-amd-pstate-Add-trace-event-for-EPP-perf-updates/20241206-063920
base:   ab9e5b2eb56412cb8c63b46b935878d29205418e
patch link:    https://lore.kernel.org/r/20241205222847.7889-11-mario.limonciello%40amd.com
patch subject: [PATCH 10/15] cpufreq/amd-pstate: Move limit updating code
config: x86_64-buildonly-randconfig-001-20241206 (https://download.01.org/0day-ci/archive/20241206/202412061054.cJTnhP0n-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412061054.cJTnhP0n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412061054.cJTnhP0n-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_update_min_max_limit':
>> drivers/cpufreq/amd-pstate.c:606:45: warning: variable 'lowest_perf' set but not used [-Wunused-but-set-variable]
     606 |         u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
         |                                             ^~~~~~~~~~~


vim +/lowest_perf +606 drivers/cpufreq/amd-pstate.c

ec437d71db77a18 Huang Rui         2021-12-24  603  
febab20caebac95 Wyes Karny        2023-11-17  604  static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
febab20caebac95 Wyes Karny        2023-11-17  605  {
b623ceabb704d2d Mario Limonciello 2024-12-05 @606  	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
febab20caebac95 Wyes Karny        2023-11-17  607  	struct amd_cpudata *cpudata = policy->driver_data;
febab20caebac95 Wyes Karny        2023-11-17  608  
18d9b5227121389 Mario Limonciello 2024-10-12  609  	max_perf = READ_ONCE(cpudata->highest_perf);
b623ceabb704d2d Mario Limonciello 2024-12-05  610  	max_freq = READ_ONCE(cpudata->max_freq);
b623ceabb704d2d Mario Limonciello 2024-12-05  611  	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
b623ceabb704d2d Mario Limonciello 2024-12-05  612  	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
febab20caebac95 Wyes Karny        2023-11-17  613  
8164f743326404f Meng Li           2024-02-27  614  	lowest_perf = READ_ONCE(cpudata->lowest_perf);
8164f743326404f Meng Li           2024-02-27  615  
6fbd2a2609d0033 Mario Limonciello 2024-12-05  616  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
6fbd2a2609d0033 Mario Limonciello 2024-12-05  617  		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
8164f743326404f Meng Li           2024-02-27  618  
febab20caebac95 Wyes Karny        2023-11-17  619  	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
febab20caebac95 Wyes Karny        2023-11-17  620  	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
febab20caebac95 Wyes Karny        2023-11-17  621  	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
febab20caebac95 Wyes Karny        2023-11-17  622  	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
febab20caebac95 Wyes Karny        2023-11-17  623  
febab20caebac95 Wyes Karny        2023-11-17  624  	return 0;
febab20caebac95 Wyes Karny        2023-11-17  625  }
febab20caebac95 Wyes Karny        2023-11-17  626  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

