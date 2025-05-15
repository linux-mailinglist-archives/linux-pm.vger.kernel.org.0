Return-Path: <linux-pm+bounces-27198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA09AB88E0
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 16:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892083ACCFC
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6599C198A08;
	Thu, 15 May 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxT3shgb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85C191
	for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317895; cv=none; b=IAnjzf2umdkTQay2mmSJu/ekLSM2owdk0qNl+YvmkKOX5bAtXC7t4FXp4d6Xq6oqJBl1K9+wsx069LGEnXEtYQvEGi1QQIeQiTgBnrrFnDBUd+n4vCC7PBAz7K9aWLoWD0JJSeFGZoVG+AzmXa3RqCyH9tj8CXk5UJWbX+Sd/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317895; c=relaxed/simple;
	bh=r1p+FV6djhLa+cbI8e/2Z9BgF0sx4hIKM1DrL6mCX3U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CiUWZVw8WmmCHEpmsaHGZ4UIPMHFyEE3t2NP89cih9h8aYZaSB8kc2DkZRD48wzI25Rw8coKckUcL9rI2jCHNOA2o3HRzgE10pIFort4YNM0PIBlr36DlU4yY6UILCL4kK1+EW0xVl8EUqGwK0Jl4cZGr/5iuLHqMWHt5cbM/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxT3shgb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747317894; x=1778853894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r1p+FV6djhLa+cbI8e/2Z9BgF0sx4hIKM1DrL6mCX3U=;
  b=kxT3shgb1neZfiNYUvfkzC+TesSa6ga4meZIdMMr1S/saeaoFSOOVm5W
   WgEan5fkKZYqVQ1NTWl5kkm/EqmOqTccBnrQxjp6XIdQ1aNPaUC3AhWpp
   s3CvfTAFbRGukKIi8FTtSGsgJXbu6Htmqkxiyntb16T1ZJHIGD9vEU9vn
   mbFAK2WLxeQ1wbYfckiny0l31fpaoDngoKBhwayxOozPoFxYd6BrOBmmy
   lOaWZmZrAMUJUd3LIdGva0jTcV2B11ULyD2iLtSScyKU/ICEt/GdlYpP2
   kcHHeUBbUDrLWbfpvhddH5Zc4J0RDeZSh36uN5ByHU5gyq5LdoQip0BoM
   Q==;
X-CSE-ConnectionGUID: cnCTLlZQRrq0U9RRIiXw5g==
X-CSE-MsgGUID: TQbpPDj7TjurTSxvEjUKFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48943633"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="48943633"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 07:04:52 -0700
X-CSE-ConnectionGUID: 09gDly3MSoCBd4AQxqlOKw==
X-CSE-MsgGUID: ms/Qlvo3RWKE86sFDTsbpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138778836"
Received: from igk-lkp-server01.igk.intel.com (HELO a1decbf9c5f9) ([10.211.3.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 May 2025 07:04:50 -0700
Received: from kbuild by a1decbf9c5f9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFZCa-0000Et-19;
	Thu, 15 May 2025 14:04:48 +0000
Date: Thu, 15 May 2025 22:04:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Subject: [chanwoo:devfreq-testing 5/5]
 drivers/devfreq/hisi_uncore_freq.c:552:9: error: returning 'const struct
 cpumask *' from a function with result type 'struct cpumask *' discards
 qualifiers
Message-ID: <202505150757.6H95XXiq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   a4bcf6ccfb61f2e8354081ecc584c003d6b91c4e
commit: a0983893e344a836747449e1d20f5273761d39fa [5/5] PM / devfreq: Add HiSilicon uncore frequency scaling driver
config: mips-randconfig-2004-20250513 (https://download.01.org/0day-ci/archive/20250515/202505150757.6H95XXiq-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250515/202505150757.6H95XXiq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505150757.6H95XXiq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/devfreq/hisi_uncore_freq.c:552:9: error: returning 'const struct cpumask *' from a function with result type 'struct cpumask *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     552 |         return topology_core_cpumask(cpu);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/topology.h:221:37: note: expanded from macro 'topology_core_cpumask'
     221 | #define topology_core_cpumask(cpu)              cpumask_of(cpu)
         |                                                 ^~~~~~~~~~~~~~~
   include/linux/cpumask.h:880:25: note: expanded from macro 'cpumask_of'
     880 | #define cpumask_of(cpu) (get_cpu_mask(cpu))
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/devfreq/hisi_uncore_freq.c:562:9: error: returning 'const struct cpumask *' from a function with result type 'struct cpumask *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     562 |         return topology_cluster_cpumask(cpu);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/topology.h:224:40: note: expanded from macro 'topology_cluster_cpumask'
     224 | #define topology_cluster_cpumask(cpu)           cpumask_of(cpu)
         |                                                 ^~~~~~~~~~~~~~~
   include/linux/cpumask.h:880:25: note: expanded from macro 'cpumask_of'
     880 | #define cpumask_of(cpu) (get_cpu_mask(cpu))
         |                         ^~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +552 drivers/devfreq/hisi_uncore_freq.c

   549	
   550	static struct cpumask *get_package_cpumask(int cpu)
   551	{
 > 552		return topology_core_cpumask(cpu);
   553	}
   554	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

