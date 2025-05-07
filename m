Return-Path: <linux-pm+bounces-26819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 386E2AAE3AC
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB8B1889B98
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB1289E1B;
	Wed,  7 May 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgDScMEe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3FD2139D2
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629939; cv=none; b=TcXlqvC58TuoHSUSRs7gvCiagwC0vVnZyGkeWyzI8Krqz5YfekDAZvi+9KfD1X5/u1x4KOJxalOD1h0oxq38jlsL7zno6NpiHPu2iUPbD6YvNtXntZGow+8w6Gt6MXckVCFWRPLxFvNRfAqM5LPM94As4orcT/BU9YOP9k0ycxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629939; c=relaxed/simple;
	bh=IGXdX2BAsVgNBRGGF2TMG5ojhGH82DlFpzKBv3/jxOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UTt3gSH0a+FeFyLWxU34jXAlCrToMez2STzg8P4QHTOKg73z9Wb4izWCp7sfzaS6gyM8Rxew4M13IkqQ0HPPPrpBMqzIUCc2beDtNnb7SbsUQ7Dg39jLXcSM0wNO/Okn9WRhuSkTyDZol6ZaRbL4rDzuSvcgDmQOfeFDAVZg1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgDScMEe; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746629937; x=1778165937;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IGXdX2BAsVgNBRGGF2TMG5ojhGH82DlFpzKBv3/jxOc=;
  b=QgDScMEeiq/bt2oFfZnIBPqHF+JDNXETEvQRYINfrbWV3NkUlUGjSLEF
   O7xs49Nd7sOpizlXy+Wa+2TgUTdVcv3N3FyQM5rkn56zol3Cth3Z4NW22
   jWP91tF45gSfIyPvLH/nQYhFliS3XcIuA3qTh/+tlQ9K15/u7yYltwXW1
   ELbp7XTRCSWBzynUnN4sotK26rebfLTeEbVJYlPhIUz6GHpzxNoJ2RzVf
   TLeYmLHkoonHxBB8wB0rztZiwqF5733eSqiFvTXF0fO4oc9njjvuLY8ae
   9s6kEfg0gxf3QeaIjhWTsbIlRTGy27K+qtO2bjDnJNLyySUcy8Ocmvb4r
   g==;
X-CSE-ConnectionGUID: GRzIy6UFRWiqHQtEwLe3sA==
X-CSE-MsgGUID: N6P+XKhxT6WchCLsL33kUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59763566"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="59763566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:58:56 -0700
X-CSE-ConnectionGUID: kHFGRZmVQ4GYY7YmSJJ7Ig==
X-CSE-MsgGUID: wWg7FOTsRPm2FOd/BWMkfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="140827650"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2025 07:58:55 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCgEX-000825-0N;
	Wed, 07 May 2025 14:58:53 +0000
Date: Wed, 7 May 2025 22:58:41 +0800
From: kernel test robot <lkp@intel.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Subject: [chanwoo:devfreq-testing 5/5] include/linux/cpumask.h:880:26:
 warning: return discards 'const' qualifier from pointer target type
Message-ID: <202505072207.bsjJiSl8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   a0983893e344a836747449e1d20f5273761d39fa
commit: a0983893e344a836747449e1d20f5273761d39fa [5/5] PM / devfreq: Add HiSilicon uncore frequency scaling driver
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20250507/202505072207.bsjJiSl8-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505072207.bsjJiSl8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505072207.bsjJiSl8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/devfreq/hisi_uncore_freq.c:8:
   drivers/devfreq/hisi_uncore_freq.c: In function 'get_package_cpumask':
>> include/linux/cpumask.h:880:26: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     880 | #define cpumask_of(cpu) (get_cpu_mask(cpu))
         |                         ~^~~~~~~~~~~~~~~~~~
   include/linux/topology.h:221:49: note: in expansion of macro 'cpumask_of'
     221 | #define topology_core_cpumask(cpu)              cpumask_of(cpu)
         |                                                 ^~~~~~~~~~
   drivers/devfreq/hisi_uncore_freq.c:552:16: note: in expansion of macro 'topology_core_cpumask'
     552 |         return topology_core_cpumask(cpu);
         |                ^~~~~~~~~~~~~~~~~~~~~
   drivers/devfreq/hisi_uncore_freq.c: In function 'get_cluster_cpumask':
>> include/linux/cpumask.h:880:26: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     880 | #define cpumask_of(cpu) (get_cpu_mask(cpu))
         |                         ~^~~~~~~~~~~~~~~~~~
   include/linux/topology.h:224:49: note: in expansion of macro 'cpumask_of'
     224 | #define topology_cluster_cpumask(cpu)           cpumask_of(cpu)
         |                                                 ^~~~~~~~~~
   drivers/devfreq/hisi_uncore_freq.c:562:16: note: in expansion of macro 'topology_cluster_cpumask'
     562 |         return topology_cluster_cpumask(cpu);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/const +880 include/linux/cpumask.h

2d3854a37e8b76 Rusty Russell 2008-11-05  875  
cd83e42c6b0413 Rusty Russell 2008-11-07  876  /**
cd83e42c6b0413 Rusty Russell 2008-11-07  877   * cpumask_of - the cpumask containing just a given cpu
cd83e42c6b0413 Rusty Russell 2008-11-07  878   * @cpu: the cpu (<= nr_cpu_ids)
cd83e42c6b0413 Rusty Russell 2008-11-07  879   */
cd83e42c6b0413 Rusty Russell 2008-11-07 @880  #define cpumask_of(cpu) (get_cpu_mask(cpu))
cd83e42c6b0413 Rusty Russell 2008-11-07  881  

:::::: The code at line 880 was first introduced by commit
:::::: cd83e42c6b0413dcbb548c2ead799111ff7e6a13 cpumask: new API, v2

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

