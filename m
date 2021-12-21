Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE79247BC07
	for <lists+linux-pm@lfdr.de>; Tue, 21 Dec 2021 09:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhLUIow (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Dec 2021 03:44:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:55040 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhLUIow (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Dec 2021 03:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640076292; x=1671612292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rVoyD+FvdznEp+IETLMurYFc/p2TNZ+Bkzs5UggFAdw=;
  b=DTjPetw9yQLqaTM9Qu0F4SD+EtPywQWVANGkYCvWC+tycIxJfJPLGSjC
   dVZ4L7Bzt2Gg3ATma8Q2mNebL1mOTaSo2dcD8f4Ud0Scoy2JuMHJ/b2Gy
   P5X/oHcEEjEx9q+cfZPbg1puMhfmi3avp36jmMCOivYcUze9NyVpthXqm
   CR/0zh1Pcls666TnMMzuIQH5JklqCigaT+EOoWIVCKoe/mKhdfD8nOOBO
   qW5xT5mPXhhlhXhwEcrDpz9vY2Q11Jbpfttmo4Txmcn3ohqiQ93hAptT9
   6wqjszl0RVF1TTbsSbIxuJ/j8cyXKYk+3iYlujccmSSsM+zAdj0RF57E0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="303724683"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="303724683"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 00:44:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="684592993"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 00:44:49 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzalN-0008sr-7S; Tue, 21 Dec 2021 08:44:49 +0000
Date:   Tue, 21 Dec 2021 16:44:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        alvin@alvinhc.com, kernel@pengutronix.de
Subject: Re: [PATCH] thermal: Kconfig: simplify dependency of THERMAL_HWMON
Message-ID: <202112211604.Vb1MeFLx-lkp@intel.com>
References: <20211220215828.189814-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220215828.189814-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi "Uwe,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on v5.16-rc6 next-20211220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Uwe-Kleine-K-nig/thermal-Kconfig-simplify-dependency-of-THERMAL_HWMON/20211221-060020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: openrisc-randconfig-r011-20211220 (https://download.01.org/0day-ci/archive/20211221/202112211604.Vb1MeFLx-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/440241d26b4fa7c82b2bce16874fbc3e4c26edba
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Uwe-Kleine-K-nig/thermal-Kconfig-simplify-dependency-of-THERMAL_HWMON/20211221-060020
        git checkout 440241d26b4fa7c82b2bce16874fbc3e4c26edba
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/thermal/thermal_hwmon.o: in function `thermal_add_hwmon_sysfs':
>> (.text+0x490): undefined reference to `hwmon_device_register_with_info'
   (.text+0x490): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `hwmon_device_register_with_info'
>> or1k-linux-ld: (.text+0x508): undefined reference to `hwmon_device_unregister'
   (.text+0x508): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `hwmon_device_unregister'
   or1k-linux-ld: drivers/thermal/thermal_hwmon.o: in function `thermal_remove_hwmon_sysfs':
>> (.text+0x814): undefined reference to `hwmon_device_unregister'
   (.text+0x814): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `hwmon_device_unregister'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
