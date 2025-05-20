Return-Path: <linux-pm+bounces-27434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE0CABE383
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 21:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CCF1BC1F18
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 19:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F483255E32;
	Tue, 20 May 2025 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzMZPcdJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B931B7F4
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768768; cv=none; b=IEU6LLNiitKOA/p+xBvSdVt+vvN+sqvRG1zBTIMBU0hmSvv81i6GuZ/a4T/3vXMmWbuLVVNqTkKk6DjZeXEWI1mQg8ruUaejK3AUk5GWqfCikRpPdUtVZl+Dlwbrkc+CDwo23sF2u7y0Ouae7tzuFShypRutaTSAHSPAiyvq9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768768; c=relaxed/simple;
	bh=9dyF/1WrQAjplPxdmFJJjkp2EcW47hvbjaoy4iQBplo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QWapAIWAqjUWRbNwdzFhYUAsfx8MK37ImFuM4yhY7Uk39vp6bzh1whJ5So535fysoiFVC6vqOQKKk9+4azoh0AAo54/kp1AHpKigdTwnHnSxizMGBeGuFBZnH4kt16rWvxLwNrWJcWFfHPXT9w+O98Ywd80++V//bYEC8wAvsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzMZPcdJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747768766; x=1779304766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9dyF/1WrQAjplPxdmFJJjkp2EcW47hvbjaoy4iQBplo=;
  b=MzMZPcdJAlUDdMkmyHEIOx1N2lpxJoYn3OARajGNT982z+ogDQs/Cuwn
   W9rfWXwWgTmWdLflFdqJVHQRhjkol9WeXb17K1nkHHOjcPONwemwhV7dO
   RyYaaetN1c7YgjhZ5XSoqAYgHWyo14M+G43bbjfT8zHNxe45sIfKT5w/j
   owfBrC3XsdGYRfbeAYTqufTZ3MtTYpPxlPjJ5PVZP07uQgMGKpEtwMjCM
   NHtikZ9s+HgI+ir+0B6UZhBTuezmyrJhkMOwZlOuwRlFvMJt2hJ2iqp6+
   cGHcbMcET3W1f4fiN3rp1l/b88R2QjvEwX2+MDoPXOS1jwQMLPNDK04fD
   Q==;
X-CSE-ConnectionGUID: d8APbudZQteW9KsB3qu7xg==
X-CSE-MsgGUID: 81kcY9wAR8OdDrkeLe/WJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60759634"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60759634"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 12:19:26 -0700
X-CSE-ConnectionGUID: 1rNcApXTSmuSznMfK4hG5g==
X-CSE-MsgGUID: w6xSQBGER0Ge5yeUFIs9AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140312313"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 May 2025 12:19:23 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHSUk-000NUQ-0g;
	Tue, 20 May 2025 19:19:22 +0000
Date: Wed, 21 May 2025 03:18:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Subject: [chanwoo:devfreq-testing 5/5]
 drivers/devfreq/hisi_uncore_freq.c:562:9: error: returning 'const struct
 cpumask *' from a function with result type 'struct cpumask *' discards
 qualifiers
Message-ID: <202505210327.PWLD6OdP-lkp@intel.com>
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
commit: a4bcf6ccfb61f2e8354081ecc584c003d6b91c4e [5/5] PM / devfreq: Add HiSilicon uncore frequency scaling driver
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20250521/202505210327.PWLD6OdP-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250521/202505210327.PWLD6OdP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505210327.PWLD6OdP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/devfreq/hisi_uncore_freq.c:562:9: error: returning 'const struct cpumask *' from a function with result type 'struct cpumask *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     562 |         return topology_cluster_cpumask(cpu);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/topology.h:224:40: note: expanded from macro 'topology_cluster_cpumask'
     224 | #define topology_cluster_cpumask(cpu)           cpumask_of(cpu)
         |                                                 ^~~~~~~~~~~~~~~
   include/linux/cpumask.h:880:25: note: expanded from macro 'cpumask_of'
     880 | #define cpumask_of(cpu) (get_cpu_mask(cpu))
         |                         ^~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +562 drivers/devfreq/hisi_uncore_freq.c

   559	
   560	static struct cpumask *get_cluster_cpumask(int cpu)
   561	{
 > 562		return topology_cluster_cpumask(cpu);
   563	}
   564	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

