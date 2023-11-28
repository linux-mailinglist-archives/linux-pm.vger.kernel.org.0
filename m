Return-Path: <linux-pm+bounces-421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F927FC9F0
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 23:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A54B21934
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ADB46B8D;
	Tue, 28 Nov 2023 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxiM0oGK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F5A83;
	Tue, 28 Nov 2023 14:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701211870; x=1732747870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6W77NMPWKSknRWM8nReLxQuR4biFLdG5sqgipoG+QAg=;
  b=CxiM0oGK/abrNEHyH2YH13d55CAjuNOf+8gFx/HlKqMKX3OXnWsrVYv2
   ly7u0PIW2OnpglvNSBgmish/RN2hE5pjwVa9sxVD0nyV2ibYkgTMOxgpC
   0XHUaKr4CAmqyEJJKREPNXK5aUGqrr605QzJdafuhAuWNj5BeRpTHWGzd
   MnZKwF/St4xlmLG8YBAD9W+ptpjPi85KyWfn3u9UHHHUrGeVCiRc8D7r6
   Ytg4mcDKNJFVvKA3CuMMVaTCmNP0v8Ji4sgZioG3nu2RBJ/F+JFKmgK7n
   5+oYiCEyqrrZF5roUAIe5DZTiGJzqfT0UU13w+CH92K4WIJB95Gt5fbeL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6304152"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6304152"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="839215219"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="839215219"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2023 14:51:06 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r86v2-0008Dz-06;
	Tue, 28 Nov 2023 22:51:04 +0000
Date: Wed, 29 Nov 2023 06:50:54 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
	theo.lebrun@bootlin.com, u-kumar1@ti.com,
	Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
Message-ID: <202311290333.AA0iLcWG-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20231129/202311290333.AA0iLcWG-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290333.AA0iLcWG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290333.AA0iLcWG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/thermal/k3_j72xx_bandgap.c:10:
>> drivers/thermal/k3_j72xx_bandgap.c:604:31: error: 'k3_j72xx_bandgap_pm_ops' undeclared here (not in a function); did you mean 'k3_j72xx_bandgap_probe'?
     604 |                 .pm = pm_ptr(&k3_j72xx_bandgap_pm_ops),
         |                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:54:44: note: in definition of macro 'PTR_IF'
      54 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/thermal/k3_j72xx_bandgap.c:604:23: note: in expansion of macro 'pm_ptr'
     604 |                 .pm = pm_ptr(&k3_j72xx_bandgap_pm_ops),
         |                       ^~~~~~


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

