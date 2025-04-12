Return-Path: <linux-pm+bounces-25301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4CA86A50
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 03:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C4B189682A
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 01:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3013774D;
	Sat, 12 Apr 2025 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMPcdfla"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D76D26D;
	Sat, 12 Apr 2025 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744422921; cv=none; b=WuRjgyn5/LMt7INiRqoYdMuLTSDBNojkml6hZrpP8dJ62Ks1xt6s1XhTCpQVF9IfwJ7gmMkedH7akarAxjh6CcSonTNPRxvxmcj0le8rqOXzQ+5Q9jRJMGu4sZUV2xG0Vt4+6EEQHBf2SAxL6Ge++bUOUOpNrxKJTlkHj354eTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744422921; c=relaxed/simple;
	bh=wmKnxb7GFyuae2WQ6SVt9gXSex8dPJlcbqKCyw/Zp1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI9S1xGm2DARWZSZjp0SmnN1BRS/iUC/ThoDg9cT6xPlMAv4LWEaIpuvKMviclHl3rcJ+1mT9q4azVX3asIowud2hXr70TbCaL4dBM5Af1z0RIFpyEPpmvlCiCjQHYaAQnPM/xXARen+iUcErZX/Mz8IiKoFdepYMmRK+prEpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMPcdfla; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744422920; x=1775958920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wmKnxb7GFyuae2WQ6SVt9gXSex8dPJlcbqKCyw/Zp1E=;
  b=hMPcdflaXeqBa+cpEWt2oGHRHyRReLuscD77P99PcimkMnQ0jfISqJcn
   5sHaB4GR4JjYPlVfLOy4TX6WbGhwumeD91kMaszkCg0K6FC/JrAHxjnLv
   5tGrkCRLxkkeVhAgLdHyb/aZEi8/vpI3a9jh4jWZv+QmLmQlVIWFj2wPN
   dYtT/LLfJmxA3pg4L4rsKBvJ2eg0ZyE15x/jpHqjpW1YyRXUXsnhR3D+l
   hPJeIIcYirhcKKN4cyHzh52wuJWlH4uJztySrXhO7AyFDO5qHLqrIwI7o
   /NiURYvP5yjfUSAkfLQ1ey4JDl22khaMEK7NLuC2X4OmCdjLQjWiXxYUy
   g==;
X-CSE-ConnectionGUID: n5igox7ZS8af+m6SN1kq1g==
X-CSE-MsgGUID: 6V0a1XbpQ/21BeGuW8ryoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="68470301"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="68470301"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 18:55:20 -0700
X-CSE-ConnectionGUID: ysXp3TG6QtWGgy+aKhK3mg==
X-CSE-MsgGUID: zCIgpvvmTQKne7wo+UtwKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129319566"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Apr 2025 18:55:17 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3Q5S-000BVW-1o;
	Sat, 12 Apr 2025 01:55:14 +0000
Date: Sat, 12 Apr 2025 09:55:12 +0800
From: kernel test robot <lkp@intel.com>
To: Yaxiong Tian <iambestgod@qq.com>, rafael@kernel.org,
	lukasz.luba@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: Re: [PATCH v2] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
Message-ID: <202504120921.Wqmipx6e-lkp@intel.com>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>

Hi Yaxiong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/linux-next]
[also build test WARNING on amd-pstate/bleeding-edge linus/master v6.15-rc1 next-20250411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yaxiong-Tian/PM-EM-Fix-potential-division-by-zero-error-in-em_compute_costs/20250411-093452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405%40qq.com
patch subject: [PATCH v2] PM: EM: Fix potential division-by-zero error in em_compute_costs()
config: i386-buildonly-randconfig-003-20250412 (https://download.01.org/0day-ci/archive/20250412/202504120921.Wqmipx6e-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504120921.Wqmipx6e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504120921.Wqmipx6e-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/power/energy_model.c:247:14: warning: variable 'cost' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     247 |                 } else if (_is_cpu_device(dev)) {
         |                            ^~~~~~~~~~~~~~~~~~~
   kernel/power/energy_model.c:253:19: note: uninitialized use occurs here
     253 |                 table[i].cost = cost;
         |                                 ^~~~
   kernel/power/energy_model.c:247:10: note: remove the 'if' if its condition is always true
     247 |                 } else if (_is_cpu_device(dev)) {
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/power/energy_model.c:238:32: note: initialize the variable 'cost' to silence this warning
     238 |                 unsigned long power_res, cost;
         |                                              ^
         |                                               = 0
   1 warning generated.


vim +247 kernel/power/energy_model.c

   228	
   229	static int em_compute_costs(struct device *dev, struct em_perf_state *table,
   230				    const struct em_data_callback *cb, int nr_states,
   231				    unsigned long flags)
   232	{
   233		unsigned long prev_cost = ULONG_MAX;
   234		int i, ret;
   235	
   236		/* Compute the cost of each performance state. */
   237		for (i = nr_states - 1; i >= 0; i--) {
   238			unsigned long power_res, cost;
   239	
   240			if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
   241				ret = cb->get_cost(dev, table[i].frequency, &cost);
   242				if (ret || !cost || cost > EM_MAX_POWER) {
   243					dev_err(dev, "EM: invalid cost %lu %d\n",
   244						cost, ret);
   245					return -EINVAL;
   246				}
 > 247			} else if (_is_cpu_device(dev)) {
   248				/* increase resolution of 'cost' precision */
   249				power_res = table[i].power * 10;
   250				cost = power_res / table[i].performance;
   251			}
   252	
   253			table[i].cost = cost;
   254	
   255			if (table[i].cost >= prev_cost) {
   256				table[i].flags = EM_PERF_STATE_INEFFICIENT;
   257				dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
   258					table[i].frequency);
   259			} else {
   260				prev_cost = table[i].cost;
   261			}
   262		}
   263	
   264		return 0;
   265	}
   266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

