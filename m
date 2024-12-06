Return-Path: <linux-pm+bounces-18711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154029E769D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 18:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA0E28231F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6CE20628B;
	Fri,  6 Dec 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJuHNEgc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CAA1487D1
	for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504580; cv=none; b=CWOKC2543CokmxwKOsCT/SuUwxQj5+du9nh3of1C+pfZLNjS+BFi/SifOlXis8v1dV+ENGUNO7dXnhun68FBnVfObe4Q4U1q9iiPvEPvnBuXZqPQQX05TQMsyFU8PeRM9aPx3V9KzVEjklX68BLLTARs8JVFOm4UuBZr4B4pO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504580; c=relaxed/simple;
	bh=ux0yYXEb1iC9mXDwPqR6kY3Tu9X3mqmnqOo1y4A/1No=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Skbe9jeSEIn98biWDnGx1rim1vmqIyX/fK2wIdvTGiLDIkKAt8I6CVuTtfHVMmzNEPGitgT5G1IWoTEUm9ak4h62HfBQIoSsP+ZnHiMP/uR6SKmTtfkErUw6osvAvotRZZSpH+x60vi+sc8q6mLtCx48rn5d7lUQY0t6gUUx8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJuHNEgc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733504579; x=1765040579;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ux0yYXEb1iC9mXDwPqR6kY3Tu9X3mqmnqOo1y4A/1No=;
  b=JJuHNEgcjUepe7Yn/bixd5s+W03rH2WTIdORHroW45rboh46SHh4SXjw
   yr9uqkVXrzMvU6bxJhqNFCL/aDnNp5vqW2p3nFScYdUDut9EF8TwIwPrf
   ZO9k2sjXOtQ5y8oeJmQJudWQigQRrsjOy4ya1wi4jgpD3cIFVT0zQwgzI
   epe6JScdy0Npapop7N3iplzrHWXPXjBZLvwfTpnfDPiHNKIwFHwb04lDU
   5ulKg0oX+n+LbS5CbqYhzcbfypbzw+OJcwqaZ0Afgh9H6Ywh/FpYq4ffK
   s30GWx5uNHDgpoX833a0K4Ob+IEhZCrv9aCmlpqvD0BaS7rZFdQiADcKV
   w==;
X-CSE-ConnectionGUID: tRNej2vWT/qhRAzpgg3kBg==
X-CSE-MsgGUID: AEjHBg9xSruVQz7Ju0ljgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33599514"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="33599514"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 09:02:58 -0800
X-CSE-ConnectionGUID: ZZhvRsQ7R9KErjCWDQCrlA==
X-CSE-MsgGUID: 9tSE8WBwRny3zmQW2QFSZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="99268400"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Dec 2024 09:02:56 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJbjC-00026f-0p;
	Fri, 06 Dec 2024 17:02:54 +0000
Date: Sat, 7 Dec 2024 01:02:07 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [chanwoo:devfreq-next 2/4]
 drivers/devfreq/event/rockchip-dfi.c:645:9: error: implicit declaration of
 function 'hrtimer_setup'; did you mean 'timer_setup'?
Message-ID: <202412070000.0qhtOPGl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-next
head:   27d1a5d95c5202f927f1155ad8f919778cd9f155
commit: ba13bb7cee6699cfa97ea0f9f84f8d683a5c001d [2/4] PM / devfreq: rockchip-dfi: Switch to use hrtimer_setup()
config: arm-randconfig-002-20241206 (https://download.01.org/0day-ci/archive/20241207/202412070000.0qhtOPGl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070000.0qhtOPGl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070000.0qhtOPGl-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/devfreq/event/rockchip-dfi.c: In function 'rockchip_ddr_perf_init':
>> drivers/devfreq/event/rockchip-dfi.c:645:9: error: implicit declaration of function 'hrtimer_setup'; did you mean 'timer_setup'? [-Wimplicit-function-declaration]
     645 |         hrtimer_setup(&dfi->timer, rockchip_dfi_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
         |         ^~~~~~~~~~~~~
         |         timer_setup


vim +645 drivers/devfreq/event/rockchip-dfi.c

   596	
   597	static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
   598	{
   599		struct pmu *pmu = &dfi->pmu;
   600		int ret;
   601	
   602		seqlock_init(&dfi->count_seqlock);
   603	
   604		pmu->module = THIS_MODULE;
   605		pmu->capabilities = PERF_PMU_CAP_NO_EXCLUDE;
   606		pmu->task_ctx_nr = perf_invalid_context;
   607		pmu->attr_groups = attr_groups;
   608		pmu->event_init  = rockchip_ddr_perf_event_init;
   609		pmu->add = rockchip_ddr_perf_event_add;
   610		pmu->del = rockchip_ddr_perf_event_del;
   611		pmu->start = rockchip_ddr_perf_event_start;
   612		pmu->stop = rockchip_ddr_perf_event_stop;
   613		pmu->read = rockchip_ddr_perf_event_update;
   614	
   615		dfi->cpu = raw_smp_processor_id();
   616	
   617		ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
   618					      "rockchip_ddr_perf_pmu",
   619					      NULL,
   620					      ddr_perf_offline_cpu);
   621	
   622		if (ret < 0) {
   623			dev_err(dfi->dev, "cpuhp_setup_state_multi failed: %d\n", ret);
   624			return ret;
   625		}
   626	
   627		dfi->cpuhp_state = ret;
   628	
   629		rockchip_dfi_enable(dfi);
   630	
   631		ret = devm_add_action_or_reset(dfi->dev, rockchip_ddr_cpuhp_remove_state, dfi);
   632		if (ret)
   633			return ret;
   634	
   635		ret = cpuhp_state_add_instance_nocalls(dfi->cpuhp_state, &dfi->node);
   636		if (ret) {
   637			dev_err(dfi->dev, "Error %d registering hotplug\n", ret);
   638			return ret;
   639		}
   640	
   641		ret = devm_add_action_or_reset(dfi->dev, rockchip_ddr_cpuhp_remove_instance, dfi);
   642		if (ret)
   643			return ret;
   644	
 > 645		hrtimer_setup(&dfi->timer, rockchip_dfi_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
   646	
   647		switch (dfi->ddr_type) {
   648		case ROCKCHIP_DDRTYPE_LPDDR2:
   649		case ROCKCHIP_DDRTYPE_LPDDR3:
   650			dfi->burst_len = 8;
   651			break;
   652		case ROCKCHIP_DDRTYPE_LPDDR4:
   653		case ROCKCHIP_DDRTYPE_LPDDR4X:
   654			dfi->burst_len = 16;
   655			break;
   656		}
   657	
   658		ret = perf_pmu_register(pmu, "rockchip_ddr", -1);
   659		if (ret)
   660			return ret;
   661	
   662		return devm_add_action_or_reset(dfi->dev, rockchip_ddr_perf_remove, dfi);
   663	}
   664	#else
   665	static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
   666	{
   667		return 0;
   668	}
   669	#endif
   670	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

