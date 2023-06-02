Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479A97203BD
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jun 2023 15:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjFBNvr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jun 2023 09:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjFBNvn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jun 2023 09:51:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E81A7;
        Fri,  2 Jun 2023 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685713902; x=1717249902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/07fBv2e57QftVltVTK+v/AFpok7g468L/WXtTWLpI=;
  b=L0rK2BNZ6FXsb32ZcAZHVEC2CVU2sqh8lkyRSaaiz0nRXcT5EkaiCnFZ
   IBl0ERTh44IJXB4+SVjDGzLadKzmZex4R75+M6DPLDTN9BLBC7YEYrEf4
   6vf2Jbj/vL/JnUJdBpv8/1+A2kSFcTewPCgUBozporZqEdUlWI/q3CKqk
   0OgrlGPNbT3IEFaryHHwdkcx8LF9EGkZ5jxI/FuXoQyADnE76yhxeku1C
   eKkeLuVVZyoNRpKRJ2Kzc8RaIXR9FtwqMCdTdg7CRK0n5pzZy/9MbThPV
   1uNr3zdMnxpX+Xo40SKhLrhMkLYG9TJ0x4kJ86qt1n+++Zy/rjB2J+Edd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="336235036"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="336235036"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="772890379"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="772890379"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2023 06:51:34 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q55Bl-0000Vd-1f;
        Fri, 02 Jun 2023 13:51:33 +0000
Date:   Fri, 2 Jun 2023 21:51:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v3 6/7] soc: renesas: rmobile-sysc: Convert to
 readl_poll_timeout_atomic()
Message-ID: <202306022137.eAP4Q3hL-lkp@intel.com>
References: <ae4bf03ab8fd5a557c683086958d6764babc0723.1685692810.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4bf03ab8fd5a557c683086958d6764babc0723.1685692810.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

kernel test robot noticed the following build warnings:

[auto build test WARNING on geert-renesas-drivers/renesas-clk]
[also build test WARNING on joro-iommu/next clk/clk-next linus/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geert-Uytterhoeven/iopoll-Call-cpu_relax-in-busy-loops/20230602-165454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git renesas-clk
patch link:    https://lore.kernel.org/r/ae4bf03ab8fd5a557c683086958d6764babc0723.1685692810.git.geert%2Brenesas%40glider.be
patch subject: [PATCH v3 6/7] soc: renesas: rmobile-sysc: Convert to readl_poll_timeout_atomic()
config: hexagon-randconfig-r031-20230531 (https://download.01.org/0day-ci/archive/20230602/202306022137.eAP4Q3hL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2198e2f3fd21eb62861b6ada08eeec7d6f420ee3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Geert-Uytterhoeven/iopoll-Call-cpu_relax-in-busy-loops/20230602-165454
        git checkout 2198e2f3fd21eb62861b6ada08eeec7d6f420ee3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soc/renesas/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306022137.eAP4Q3hL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/soc/renesas/rmobile-sysc.c:15:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/soc/renesas/rmobile-sysc.c:15:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/soc/renesas/rmobile-sysc.c:15:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/soc/renesas/rmobile-sysc.c:78:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                   return ret;
                          ^~~
   drivers/soc/renesas/rmobile-sysc.c:75:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   7 warnings generated.


vim +/ret +78 drivers/soc/renesas/rmobile-sysc.c

8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  71  
445aeb081bc713 arch/arm/mach-shmobile/pm-rmobile.c Geert Uytterhoeven 2018-11-29  72  static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd)
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  73  {
2198e2f3fd21eb drivers/soc/renesas/rmobile-sysc.c  Geert Uytterhoeven 2023-06-02  74  	unsigned int val, mask = BIT(rmobile_pd->bit_shift);
2198e2f3fd21eb drivers/soc/renesas/rmobile-sysc.c  Geert Uytterhoeven 2023-06-02  75  	int ret;
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  76  
8b6bed678428b6 drivers/soc/renesas/rmobile-sysc.c  Geert Uytterhoeven 2020-11-19  77  	if (readl(rmobile_pd->base + PSTR) & mask)
445aeb081bc713 arch/arm/mach-shmobile/pm-rmobile.c Geert Uytterhoeven 2018-11-29 @78  		return ret;
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  79  
8b6bed678428b6 drivers/soc/renesas/rmobile-sysc.c  Geert Uytterhoeven 2020-11-19  80  	writel(mask, rmobile_pd->base + SWUCR);
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  81  
2198e2f3fd21eb drivers/soc/renesas/rmobile-sysc.c  Geert Uytterhoeven 2023-06-02  82  	ret = readl_poll_timeout_atomic(rmobile_pd->base + SWUCR, val,
2198e2f3fd21eb drivers/soc/renesas/rmobile-sysc.c  Geert Uytterhoeven 2023-06-02  83  					(val & mask), PSTR_DELAY_US,
2198e2f3fd21eb drivers/soc/renesas/rmobile-sysc.c  Geert Uytterhoeven 2023-06-02  84  					PSTR_RETRIES * PSTR_DELAY_US);
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  85  
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  86  	pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
25717b85736076 arch/arm/mach-shmobile/pm-rmobile.c Geert Uytterhoeven 2014-12-03  87  		 rmobile_pd->genpd.name, mask,
8b6bed678428b6 drivers/soc/renesas/rmobile-sysc.c  Geert Uytterhoeven 2020-11-19  88  		 readl(rmobile_pd->base + PSTR));
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  89  
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  90  	return ret;
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  91  }
8f45b112fc66ef arch/arm/mach-shmobile/pm-rmobile.c Kuninori Morimoto  2012-07-05  92  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
