Return-Path: <linux-pm+bounces-425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7907FCDBF
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 05:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F801C20EF9
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 04:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286C63DB;
	Wed, 29 Nov 2023 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9uzGQx+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EEA1AE;
	Tue, 28 Nov 2023 20:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701231285; x=1732767285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YIvS4LQS2PhkCaZ4Tm+YeCL2w5fycapLbYdyhJloM5U=;
  b=J9uzGQx+hmJ8aEANUYc5BNRzvdyGgjtEoFqZHd7tu856txYS9HJVS+Cj
   vrxBrE5ZIhiBg9pvfEie5O0yodYQXIxStxHN16PMN+Hz4qvzkFeFt5lIT
   Jm7zTwTczkrEBGU5uHOhZKVj9riSgoJZfm+UNYRUdST/NFB05Yxio7N32
   Wk5gfyz8H+1D7xabVsOO8NPptT/Gn8+x8CycARBsVk9nWXLLwOiq33oub
   sJYduCWw4MwbrWRbLa8V212dKrZOaw20LQ8rAMA7OlCuFUJOrtt40kw2J
   m5lEROFyt94LMQ2VsF7zrJlJNDRDeGlLEvKSnKk1M0uZRRUfI+SWffU48
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="383483240"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="383483240"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 20:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892314394"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892314394"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2023 20:14:41 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8ByA-0008Xk-24;
	Wed, 29 Nov 2023 04:14:38 +0000
Date: Wed, 29 Nov 2023 12:13:51 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	gregory.clement@bootlin.com, theo.lebrun@bootlin.com,
	u-kumar1@ti.com, Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
Message-ID: <202311291148.HMS1dKk0-lkp@intel.com>
References: <20231128130332.584127-1-thomas.richard@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128130332.584127-1-thomas.richard@bootlin.com>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Richard/thermal-k3_j72xx_bandgap-implement-suspend-resume-support/20231128-211217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231128130332.584127-1-thomas.richard%40bootlin.com
patch subject: [PATCH] thermal: k3_j72xx_bandgap: implement suspend/resume support
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20231129/202311291148.HMS1dKk0-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311291148.HMS1dKk0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311291148.HMS1dKk0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/thermal/k3_j72xx_bandgap.c:17:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/thermal/k3_j72xx_bandgap.c:17:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/thermal/k3_j72xx_bandgap.c:17:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/thermal/k3_j72xx_bandgap.c:604:17: error: use of undeclared identifier 'k3_j72xx_bandgap_pm_ops'; did you mean 'k3_j72xx_bandgap_probe'?
     604 |                 .pm = pm_ptr(&k3_j72xx_bandgap_pm_ops),
         |                               ^~~~~~~~~~~~~~~~~~~~~~~
         |                               k3_j72xx_bandgap_probe
   include/linux/pm.h:475:53: note: expanded from macro 'pm_ptr'
     475 | #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
         |                                                     ^
   include/linux/kernel.h:54:38: note: expanded from macro 'PTR_IF'
      54 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^
   drivers/thermal/k3_j72xx_bandgap.c:376:12: note: 'k3_j72xx_bandgap_probe' declared here
     376 | static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
         |            ^
>> drivers/thermal/k3_j72xx_bandgap.c:604:9: error: incompatible pointer types initializing 'const struct dev_pm_ops *' with an expression of type 'int (*)(struct platform_device *)' [-Werror,-Wincompatible-pointer-types]
     604 |                 .pm = pm_ptr(&k3_j72xx_bandgap_pm_ops),
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:475:22: note: expanded from macro 'pm_ptr'
     475 | #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:54:27: note: expanded from macro 'PTR_IF'
      54 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   6 warnings and 2 errors generated.


vim +604 drivers/thermal/k3_j72xx_bandgap.c

   597	
   598	static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
   599		.probe = k3_j72xx_bandgap_probe,
   600		.remove_new = k3_j72xx_bandgap_remove,
   601		.driver = {
   602			.name = "k3-j72xx-soc-thermal",
   603			.of_match_table	= of_k3_j72xx_bandgap_match,
 > 604			.pm = pm_ptr(&k3_j72xx_bandgap_pm_ops),
   605		},
   606	};
   607	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

