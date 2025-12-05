Return-Path: <linux-pm+bounces-39247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE11CA82E8
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45FCE32A1376
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5A3559C9;
	Fri,  5 Dec 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9u6bxDU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3B34E779;
	Fri,  5 Dec 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947820; cv=none; b=cSuHM875YX3q45PRpgGTUvrHZ9Y6KoqpeSgp3xh5WEVfLP5yHYigSMrIqISbPM8KEEKmFY6W9jvF8I2ZZhpwxbmbIjzUsSWYbKpWfplS5vleY8zZ+Wj6aFdLmYtGrGL8zCI5fakQ7kTNj6L75vCElEA4SUdGzMCDm77xU5Gt+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947820; c=relaxed/simple;
	bh=/0pxwljYE52fbEeH0J8mXoQ8htkOtzQ1bNaVYct7iBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnZIl3q9GMBRB6BeBOeVmq+JqC9nNxlKA5TsHowKu5m1xWBJcO1Xv4GCe897NSV2HDYYZ78wDhf+B7JYOuz97NUGu/wr/mzAUboRKdrnd2/m/K6hph9l/i5IZ/qv1W+QMU+Iv+QtFqCkPxamYUfGSX9+sZVMusHIDkGLSVrUyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9u6bxDU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764947817; x=1796483817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/0pxwljYE52fbEeH0J8mXoQ8htkOtzQ1bNaVYct7iBE=;
  b=D9u6bxDU9loJBcIwUeabItM0PGRSa/h7TOMCy8wwyWZfQ3JXc6SgP2HC
   FM4KRgmLJeGEXaQe2eztE9yvxRBua9xqUSI+NrDSkyg3rhrSpX80qVK85
   MEyQU/fWbU96QJnfVU0lg6vJL83jC11sNsXYb0uuo8AITV9GXNzF1wUMF
   6pEM/iumEUu7mbZKzu/NVMY01GgbH2AVel4aIrei0sMa1M5muFQn+3cYZ
   qTux4XN1J/QLacsC9f3URquWDRpGa8Y5UBOAMrd4n93tiSj+6aUUa3K77
   Hx+KWurlpCWb+/CkkcjaGyf09IWTa99TEuzoEpYoXWdkIHQW8ZUv7YcdK
   A==;
X-CSE-ConnectionGUID: KSvOqprVQ3KPHolB3q3kmw==
X-CSE-MsgGUID: lOLg37DxSwWEug/sENprDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="66876348"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="66876348"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:16:56 -0800
X-CSE-ConnectionGUID: zpOsOMIUS5qvMUsJ6/FmbQ==
X-CSE-MsgGUID: 3eCM89lgQLSFZ1phwu8Nog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="194970746"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Dec 2025 07:16:52 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRXYA-00000000F81-1MYM;
	Fri, 05 Dec 2025 15:16:50 +0000
Date: Fri, 5 Dec 2025 23:16:36 +0800
From: kernel test robot <lkp@intel.com>
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>, zhenglifeng1@huawei.com,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 4/4] cpufreq: Update set_boost callbacks to rely on
 boost_freq_req
Message-ID: <202512052257.WliHSJi6-lkp@intel.com>
References: <20251204101344.192678-5-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204101344.192678-5-pierre.gondois@arm.com>

Hi Pierre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.18 next-20251205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pierre-Gondois/Revert-cpufreq-Fix-re-boost-issue-after-hotplugging-a-CPU/20251204-182201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251204101344.192678-5-pierre.gondois%40arm.com
patch subject: [PATCH v1 4/4] cpufreq: Update set_boost callbacks to rely on boost_freq_req
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20251205/202512052257.WliHSJi6-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 14bf95b06a18b9b59c89601cbc0e5a6f2176b118)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251205/202512052257.WliHSJi6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512052257.WliHSJi6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/cppc_cpufreq.c:771:6: warning: unused variable 'ret' [-Wunused-variable]
     771 |         int ret;
         |             ^~~
   1 warning generated.


vim +/ret +771 drivers/cpufreq/cppc_cpufreq.c

33477d84c26bbf George Cherian  2018-07-11  766  
54e74df5d76dea Xiongfeng Wang  2020-05-30  767  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
54e74df5d76dea Xiongfeng Wang  2020-05-30  768  {
a28b2bfc099c6b Ionela Voinescu 2020-12-14  769  	struct cppc_cpudata *cpu_data = policy->driver_data;
bb025fb6c276ac Ionela Voinescu 2020-11-05  770  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
54e74df5d76dea Xiongfeng Wang  2020-05-30 @771  	int ret;
54e74df5d76dea Xiongfeng Wang  2020-05-30  772  
54e74df5d76dea Xiongfeng Wang  2020-05-30  773  	if (state)
75f25e3bda7140 Pierre Gondois  2025-12-04  774  		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
54e74df5d76dea Xiongfeng Wang  2020-05-30  775  	else
75f25e3bda7140 Pierre Gondois  2025-12-04  776  		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
54e74df5d76dea Xiongfeng Wang  2020-05-30  777  
54e74df5d76dea Xiongfeng Wang  2020-05-30  778  	return 0;
54e74df5d76dea Xiongfeng Wang  2020-05-30  779  }
54e74df5d76dea Xiongfeng Wang  2020-05-30  780  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

