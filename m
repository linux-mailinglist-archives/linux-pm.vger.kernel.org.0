Return-Path: <linux-pm+bounces-18790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C26329E8A24
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 05:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A051633E1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 04:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5DA156F5F;
	Mon,  9 Dec 2024 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxfBSZ70"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF0156676
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717352; cv=none; b=QNY2oKNhyQGVVW2eWPvIJrVNOaMHVonyxuCgXHjcMx7nziet6xtAUGviqbFrldVw2/WOZjJlXEZ+o4i19hvrrqBf8vm5tUo5A1LQeJ9/xdit7rSpC8c0msQR5w055s7mRcpmNxyK4nY50MfJHpykDCrLTS3Ei34+5meF2/GvBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717352; c=relaxed/simple;
	bh=GYJ4c0AYqXdCp+BmoltJWMTnHa4voLeKfkhTOewFYRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lBYu5I/2OdXKeT6YGHdNfoTb07ncw19y3YtNzipf3kNCIC0BnFUtbOWyiA0JpjQiS1oryeULgXGuXqtSxJ9tuankBLD3Gdb4sDxIMLtGSzmv6W8g20TyHP0rnqrY3t0TKIrBJDrW30WuRhe4OWzljrbeq0nOSaiuIY92obHsWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxfBSZ70; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717350; x=1765253350;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GYJ4c0AYqXdCp+BmoltJWMTnHa4voLeKfkhTOewFYRk=;
  b=LxfBSZ702I6T7CxRs7F/02nl3kPaAe+28zHXV0oThx7PB5w74Y6uUga4
   4dv67GvfAJ9Gg3ungdsIKT2L+TvZp/3BJvakwnVf2ewjhNPQ2v1fBKMdA
   7T9v7ZUrdnWlclP4zUnPdNH0xWTHqPwvy+v8tvDQZNT6HQC8bmyFmi9Yq
   xTGH0zvX6Op3eSo8ZITu2CnRr3Cgj+nQ3xT5sc1ommChWIB9NQoFDIksH
   9LE6vTPJeLy1M57gw0ZZCr83QUeWjOcIBUhymNooGwReFjaI305TSynwe
   KzOq14kY4VA8Wv5v0UkVUCXJmkGDFHjWR/OYDX0WoThKwn2qNEHn/xg44
   g==;
X-CSE-ConnectionGUID: yP1I1CxmRV6gIZViZjWamw==
X-CSE-MsgGUID: 4OTa3jYJQFWtGeZUcSNdPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="36841941"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="36841941"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:09:08 -0800
X-CSE-ConnectionGUID: sXsl04c1Raend5gDccZ/iQ==
X-CSE-MsgGUID: vlPGBQkcR9m+YajMVSGHNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95044954"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Dec 2024 20:09:06 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKV4x-0003nN-1x;
	Mon, 09 Dec 2024 04:09:03 +0000
Date: Mon, 9 Dec 2024 12:08:40 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [chanwoo:devfreq-next 2/4]
 drivers/devfreq/event/rockchip-dfi.c:645:2: error: call to undeclared
 function 'hrtimer_setup'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202412071429.JnFmSoBv-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241207/202412071429.JnFmSoBv-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412071429.JnFmSoBv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071429.JnFmSoBv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/devfreq/event/rockchip-dfi.c:8:
   In file included from include/linux/devfreq-event.h:12:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/devfreq/event/rockchip-dfi.c:12:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/devfreq/event/rockchip-dfi.c:12:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/devfreq/event/rockchip-dfi.c:12:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/devfreq/event/rockchip-dfi.c:645:2: error: call to undeclared function 'hrtimer_setup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     645 |         hrtimer_setup(&dfi->timer, rockchip_dfi_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
         |         ^
   drivers/devfreq/event/rockchip-dfi.c:645:2: note: did you mean 'hrtimer_start'?
   include/linux/hrtimer.h:272:20: note: 'hrtimer_start' declared here
     272 | static inline void hrtimer_start(struct hrtimer *timer, ktime_t tim,
         |                    ^
   16 warnings and 1 error generated.


vim +/hrtimer_setup +645 drivers/devfreq/event/rockchip-dfi.c

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

