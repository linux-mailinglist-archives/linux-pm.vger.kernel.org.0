Return-Path: <linux-pm+bounces-18588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BAD9E4833
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 23:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3D32864B6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319BC202C54;
	Wed,  4 Dec 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYnWUYXl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F461FC7C6;
	Wed,  4 Dec 2024 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352948; cv=none; b=UlLJXym8at+f2hS7yRrpmnPnXNp1zWrL78eedgucE7+VpX9OSJWXbRIUJdbOnNpvLPF+ICHTf/3Bfd4Mc7UKbACKcyxKLDXOZKEqz21uEO4PvQs33CzoQjD74mYDs4ENZLC8dPkK/7dtV4vYn0paXscxfpqMv/yaFAfYFFBJivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352948; c=relaxed/simple;
	bh=cgJO1mT6QbFYcsRg42YFOL0quGCzPqrV4QxF7OZZOrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWB30fgLerv+nu7/unvdcuqDBHrE5mHO+egWmMKGflXlko+iB63oB+7TelZIEh3wWdaOy2TdjLDNeG4Xn+1g9sIk9SYn0w7ORx5SrGqSErfM/3nIM4sjkxqguMKbELC1QQq3X5m9gGmV//acnvAqsMl6u5jP/N5NC+khjV20Of4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYnWUYXl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733352946; x=1764888946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cgJO1mT6QbFYcsRg42YFOL0quGCzPqrV4QxF7OZZOrE=;
  b=TYnWUYXlZkytAUJuVQpKZMzss0/R2NG4g6jgREQk9YCdIeeHGXaLY+hG
   vRyUjIV3Of16WHPzviljXvLjQ3XOm60pMgjEfBAyzpqkLScY6kKmkLjIG
   my5mTvq1Npv7lITP8ktOKTq/7HbeI2k0EHG62lHiwpJQVJ0MBXI1g6pbV
   uchbBUoQ9cgugj9l2RKeVYkFk4/wCOSvFausJczaWdo/ZVZuqRD2ce6pm
   QZQlqLco2P2YQ34xJwqo7SeAOKTmHdFQBdljwXR8c0wxE+kNgFa70xQmK
   hPYMrvto+ICWMPPtr4cvh6KXsDeNPV0nG8v8jNByjrKq5G1yoZH2q+ziA
   A==;
X-CSE-ConnectionGUID: 9/fZGsl5RQOSSd3B5q4RPA==
X-CSE-MsgGUID: +zRqnr3/R+yfUbiAoA4XPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44122754"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="44122754"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 14:55:46 -0800
X-CSE-ConnectionGUID: IsgjPig3SxWaIsvTMN9ylg==
X-CSE-MsgGUID: WP+7dF4CQ8SgGxUUs7HR3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93784255"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2024 14:55:43 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIyHV-0003ZV-0J;
	Wed, 04 Dec 2024 22:55:41 +0000
Date: Thu, 5 Dec 2024 06:55:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
	mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 3/5] cpufreq/amd-pstate: Refactor
 amd_pstate_epp_reenable() and amd_pstate_epp_offline()
Message-ID: <202412050615.ObPzrf34-lkp@intel.com>
References: <20241204144842.164178-4-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204144842.164178-4-Dhananjay.Ugwekar@amd.com>

Hi Dhananjay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.13-rc1 next-20241204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dhananjay-Ugwekar/cpufreq-amd-pstate-Convert-the-amd_pstate_get-set_epp-to-static-calls/20241204-225537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241204144842.164178-4-Dhananjay.Ugwekar%40amd.com
patch subject: [PATCH 3/5] cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and amd_pstate_epp_offline()
config: x86_64-buildonly-randconfig-006-20241205 (https://download.01.org/0day-ci/archive/20241205/202412050615.ObPzrf34-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050615.ObPzrf34-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050615.ObPzrf34-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_epp_offline':
>> drivers/cpufreq/amd-pstate.c:1664:13: warning: variable 'value' set but not used [-Wunused-but-set-variable]
    1664 |         u64 value;
         |             ^~~~~


vim +/value +1664 drivers/cpufreq/amd-pstate.c

d4da12f8033a123 Perry Yuan        2023-01-31  1659  
d4da12f8033a123 Perry Yuan        2023-01-31  1660  static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
d4da12f8033a123 Perry Yuan        2023-01-31  1661  {
d4da12f8033a123 Perry Yuan        2023-01-31  1662  	struct amd_cpudata *cpudata = policy->driver_data;
d4da12f8033a123 Perry Yuan        2023-01-31  1663  	int min_perf;
d4da12f8033a123 Perry Yuan        2023-01-31 @1664  	u64 value;
d4da12f8033a123 Perry Yuan        2023-01-31  1665  
d4da12f8033a123 Perry Yuan        2023-01-31  1666  	min_perf = READ_ONCE(cpudata->lowest_perf);
d4da12f8033a123 Perry Yuan        2023-01-31  1667  	value = READ_ONCE(cpudata->cppc_req_cached);
d4da12f8033a123 Perry Yuan        2023-01-31  1668  
d4da12f8033a123 Perry Yuan        2023-01-31  1669  	mutex_lock(&amd_pstate_limits_lock);
d4da12f8033a123 Perry Yuan        2023-01-31  1670  
33cc0b550fa3510 Dhananjay Ugwekar 2024-12-04  1671  	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
33cc0b550fa3510 Dhananjay Ugwekar 2024-12-04  1672  	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
33cc0b550fa3510 Dhananjay Ugwekar 2024-12-04  1673  
d4da12f8033a123 Perry Yuan        2023-01-31  1674  	mutex_unlock(&amd_pstate_limits_lock);
d4da12f8033a123 Perry Yuan        2023-01-31  1675  }
d4da12f8033a123 Perry Yuan        2023-01-31  1676  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

