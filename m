Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A8243E10B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 14:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1MfK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 08:35:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:21434 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhJ1MfJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Oct 2021 08:35:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="217570119"
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; 
   d="gz'50?scan'50,208,50";a="217570119"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 05:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; 
   d="gz'50?scan'50,208,50";a="665400063"
Received: from lkp-server01.sh.intel.com (HELO 3b851179dbd8) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2021 05:32:39 -0700
Received: from kbuild by 3b851179dbd8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mg4aF-00025o-8I; Thu, 28 Oct 2021 12:32:39 +0000
Date:   Thu, 28 Oct 2021 20:32:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] thermal: Fix implicit type conversion
Message-ID: <202110282043.I4uZvHTO-lkp@intel.com>
References: <1635391292-2879179-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <1635391292-2879179-1-git-send-email-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiasheng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on v5.15-rc7 next-20211028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jiasheng-Jiang/thermal-Fix-implicit-type-conversion/20211028-112252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: i386-randconfig-a004-20211027 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5db7568a6a1fcb408eb8988abdaff2a225a8eb72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/07e91da90fa6847b02bff413b1a24027e4d36392
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiasheng-Jiang/thermal-Fix-implicit-type-conversion/20211028-112252
        git checkout 07e91da90fa6847b02bff413b1a24027e4d36392
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/thermal/intel/intel_powerclamp.c:723:9: error: incompatible function pointer types passing 'int (int)' to parameter of type 'int (*)(unsigned int)' [-Werror,-Wincompatible-function-pointer-types]
                                              powerclamp_cpu_predown);
                                              ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/cpuhotplug.h:317:16: note: passing argument to parameter 'teardown' here
                                               int (*teardown)(unsigned int cpu))
                                                     ^
   1 error generated.


vim +723 drivers/thermal/intel/intel_powerclamp.c

cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28  704  
4d2b6e4a9ebc290 drivers/thermal/intel_powerclamp.c       Mathias Krause            2015-03-25  705  static int __init powerclamp_init(void)
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  706  {
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  707  	int retval;
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  708  
7fc775ffebb93f2 drivers/thermal/intel/intel_powerclamp.c Christophe JAILLET        2021-09-26  709  	cpu_clamping_mask = bitmap_zalloc(num_possible_cpus(), GFP_KERNEL);
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  710  	if (!cpu_clamping_mask)
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  711  		return -ENOMEM;
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  712  
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  713  	/* probe cpu features and ids here */
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  714  	retval = powerclamp_probe();
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  715  	if (retval)
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  716  		goto exit_free;
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  717  
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  718  	/* set default limit, maybe adjusted during runtime based on feedback */
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  719  	window_size = 2;
cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28  720  	retval = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28  721  					   "thermal/intel_powerclamp:online",
cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28  722  					   powerclamp_cpu_online,
cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28 @723  					   powerclamp_cpu_predown);
cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28  724  	if (retval < 0)
cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28  725  		goto exit_free;
cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28  726  
cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28  727  	hp_state = retval;
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  728  
8d962ac7f396bc8 drivers/thermal/intel_powerclamp.c       Petr Mladek               2016-11-28  729  	worker_data = alloc_percpu(struct powerclamp_worker_data);
8d962ac7f396bc8 drivers/thermal/intel_powerclamp.c       Petr Mladek               2016-11-28  730  	if (!worker_data) {
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  731  		retval = -ENOMEM;
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  732  		goto exit_unregister;
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  733  	}
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  734  
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  735  	cooling_dev = thermal_cooling_device_register("intel_powerclamp", NULL,
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  736  						&powerclamp_cooling_ops);
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  737  	if (IS_ERR(cooling_dev)) {
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  738  		retval = -ENODEV;
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  739  		goto exit_free_thread;
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  740  	}
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  741  
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  742  	if (!duration)
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  743  		duration = jiffies_to_msecs(DEFAULT_DURATION_JIFFIES);
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  744  
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  745  	powerclamp_create_debug_files();
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  746  
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  747  	return 0;
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  748  
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  749  exit_free_thread:
8d962ac7f396bc8 drivers/thermal/intel_powerclamp.c       Petr Mladek               2016-11-28  750  	free_percpu(worker_data);
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  751  exit_unregister:
cb91fef1b71954e drivers/thermal/intel_powerclamp.c       Sebastian Andrzej Siewior 2016-11-28  752  	cpuhp_remove_state_nocalls(hp_state);
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  753  exit_free:
7fc775ffebb93f2 drivers/thermal/intel/intel_powerclamp.c Christophe JAILLET        2021-09-26  754  	bitmap_free(cpu_clamping_mask);
c32a5087b70a670 drivers/thermal/intel_powerclamp.c       durgadoss.r@intel.com     2013-10-04  755  	return retval;
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  756  }
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  757  module_init(powerclamp_init);
d6d71ee4a14ae60 drivers/thermal/intel_powerclamp.c       Jacob Pan                 2013-01-21  758  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Q68bSM7Ycu6FN28Q--
