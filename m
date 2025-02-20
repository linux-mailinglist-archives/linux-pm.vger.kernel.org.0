Return-Path: <linux-pm+bounces-22536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8739A3D8A2
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 12:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E102416B96F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 11:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB691F0E2C;
	Thu, 20 Feb 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCl+aY/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A141AF0B8;
	Thu, 20 Feb 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050873; cv=none; b=ai6uGSMh5LDLggYLQjtXskJGjexpLY1+ujBRR9c4RV2SMfsyObWhn7gS0Zvfh280aJYxcQK0EUf+ZfB0476PYHQvchAy4ktTlxrnDL6tBVaZhiea2NF2CEQFHCxqIv3Q3HqaqhaplXsBpzTELiYSqXn2Ddv6JVsJHhzPq2t0gg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050873; c=relaxed/simple;
	bh=fwOyOj0qji+42CdBHw3vCQTX7yICSvLRTGD1lywdiiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVm6sqQJFyJf+4JGWoSIHcrNaM8HjshPNgtQWfJlP4vD3ZiKlgbSnf224FJVs4TL8BTLUB+Jv4YDcP205Lv9mjQeeXmbMKjy/kRYtoYcBe4RRPHgCgQxnplu0RZbBW8xxKTl0WF/Bftd4la1Zmr5SUgUdJqZY3H87bkWULz/kHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCl+aY/t; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740050870; x=1771586870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fwOyOj0qji+42CdBHw3vCQTX7yICSvLRTGD1lywdiiA=;
  b=fCl+aY/t+JcfRk34GRdBG9/wAWSGl1nuucheD5s66aaj9C5uIXLf2wFy
   EipGRKvqzX7/KkWJ2rMe5x6GZjxSFk4T82zFMIZAkqqSQ2nUjLrafnnb/
   D7kjVyB3UlWqYmd+D1FIBYYEe0wpiXg7hrXs42kVQ8unC8fi892TCtW89
   jBrW4Zgh3g+UxLvINW4I2i5Yg8dar0dIoLcse1yzeDX3Xx/3iASY2fdw0
   Q6wlYVW1/w59hWtm4Ty48Zygar49D3WFwvif6dYpWxDV/3acW+ko96elR
   D4DZKCub849qPCtypILH5jWILVob2R+9gc2XS25jnFS7LE2TtIjK3Ahz1
   g==;
X-CSE-ConnectionGUID: NsHvy1U+QqmbssXya/3xdQ==
X-CSE-MsgGUID: Pg7HQk4qRnCtQXCISZ2ZWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44473211"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="44473211"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 03:27:49 -0800
X-CSE-ConnectionGUID: sZsYuPMpT3ipqx+dmjeXyw==
X-CSE-MsgGUID: fYk5/11zRguC0mkgUquUbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119111871"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 20 Feb 2025 03:27:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl4iW-0004Cp-33;
	Thu, 20 Feb 2025 11:27:44 +0000
Date: Thu, 20 Feb 2025 19:27:05 +0800
From: kernel test robot <lkp@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
	paul@crapouillou.net, andriy.shevchenko@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1] PM: Discard runtime_xx() handles using pm_ptr()
Message-ID: <202502201907.xdsGS0fm-lkp@intel.com>
References: <20250220080318.2660840-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220080318.2660840-1-raag.jadav@intel.com>

Hi Raag,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.14-rc3 next-20250220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/PM-Discard-runtime_xx-handles-using-pm_ptr/20250220-160636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250220080318.2660840-1-raag.jadav%40intel.com
patch subject: [PATCH v1] PM: Discard runtime_xx() handles using pm_ptr()
config: sparc-randconfig-002-20250220 (https://download.01.org/0day-ci/archive/20250220/202502201907.xdsGS0fm-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502201907.xdsGS0fm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502201907.xdsGS0fm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:11,
                    from arch/sparc/include/asm/smp_32.h:15,
                    from arch/sparc/include/asm/smp.h:7,
                    from arch/sparc/include/asm/switch_to_32.h:5,
                    from arch/sparc/include/asm/switch_to.h:7,
                    from arch/sparc/include/asm/ptrace.h:120,
                    from arch/sparc/include/asm/thread_info_32.h:19,
                    from arch/sparc/include/asm/thread_info.h:7,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/irq.h:14,
                    from drivers/slimbus/qcom-ctrl.c:6:
>> drivers/slimbus/qcom-ctrl.c:711:28: error: 'qcom_slim_runtime_suspend' undeclared here (not in a function); did you mean 'pm_runtime_suspend'?
     711 |                            qcom_slim_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/slimbus/qcom-ctrl.c:710:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     710 |         SET_RUNTIME_PM_OPS(
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/slimbus/qcom-ctrl.c:712:28: error: 'qcom_slim_runtime_resume' undeclared here (not in a function); did you mean 'pm_runtime_resume'?
     712 |                            qcom_slim_runtime_resume,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/slimbus/qcom-ctrl.c:710:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     710 |         SET_RUNTIME_PM_OPS(
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/clk.h:13,
                    from drivers/spi/spi-amlogic-spifc-a1.c:11:
>> drivers/spi/spi-amlogic-spifc-a1.c:440:28: error: 'amlogic_spifc_a1_runtime_suspend' undeclared here (not in a function); did you mean 'amlogic_spifc_a1_fill_buffer'?
     440 |         SET_RUNTIME_PM_OPS(amlogic_spifc_a1_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-amlogic-spifc-a1.c:440:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     440 |         SET_RUNTIME_PM_OPS(amlogic_spifc_a1_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-amlogic-spifc-a1.c:441:28: error: 'amlogic_spifc_a1_runtime_resume' undeclared here (not in a function); did you mean 'amlogic_spifc_a1_request'?
     441 |                            amlogic_spifc_a1_runtime_resume,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-amlogic-spifc-a1.c:440:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     440 |         SET_RUNTIME_PM_OPS(amlogic_spifc_a1_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/clk.h:13,
                    from drivers/spi/spi-slave-mt27xx.c:4:
>> drivers/spi/spi-slave-mt27xx.c:548:28: error: 'mtk_spi_slave_runtime_suspend' undeclared here (not in a function); did you mean 'mtk_spi_slave_interrupt'?
     548 |         SET_RUNTIME_PM_OPS(mtk_spi_slave_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-slave-mt27xx.c:548:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     548 |         SET_RUNTIME_PM_OPS(mtk_spi_slave_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-slave-mt27xx.c:549:28: error: 'mtk_spi_slave_runtime_resume' undeclared here (not in a function); did you mean 'mtk_spi_slave_interrupt'?
     549 |                            mtk_spi_slave_runtime_resume, NULL)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-slave-mt27xx.c:548:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     548 |         SET_RUNTIME_PM_OPS(mtk_spi_slave_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/clk.h:13,
                    from drivers/spi/spi-meson-spifc.c:8:
>> drivers/spi/spi-meson-spifc.c:418:28: error: 'meson_spifc_runtime_suspend' undeclared here (not in a function); did you mean 'pm_generic_runtime_suspend'?
     418 |         SET_RUNTIME_PM_OPS(meson_spifc_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-meson-spifc.c:418:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     418 |         SET_RUNTIME_PM_OPS(meson_spifc_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-meson-spifc.c:419:28: error: 'meson_spifc_runtime_resume' undeclared here (not in a function); did you mean 'pm_generic_runtime_resume'?
     419 |                            meson_spifc_runtime_resume,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-meson-spifc.c:418:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     418 |         SET_RUNTIME_PM_OPS(meson_spifc_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/clk.h:13,
                    from drivers/spi/spi-s3c64xx.c:8:
>> drivers/spi/spi-s3c64xx.c:1507:28: error: 's3c64xx_spi_runtime_suspend' undeclared here (not in a function)
    1507 |         SET_RUNTIME_PM_OPS(s3c64xx_spi_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-s3c64xx.c:1507:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1507 |         SET_RUNTIME_PM_OPS(s3c64xx_spi_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-s3c64xx.c:1508:28: error: 's3c64xx_spi_runtime_resume' undeclared here (not in a function)
    1508 |                            s3c64xx_spi_runtime_resume, NULL)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-s3c64xx.c:1507:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1507 |         SET_RUNTIME_PM_OPS(s3c64xx_spi_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/clk.h:13,
                    from drivers/spi/spi-img-spfi.c:9:
>> drivers/spi/spi-img-spfi.c:741:28: error: 'img_spfi_runtime_suspend' undeclared here (not in a function); did you mean 'pm_runtime_suspend'?
     741 |         SET_RUNTIME_PM_OPS(img_spfi_runtime_suspend, img_spfi_runtime_resume,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-img-spfi.c:741:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     741 |         SET_RUNTIME_PM_OPS(img_spfi_runtime_suspend, img_spfi_runtime_resume,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-img-spfi.c:741:54: error: 'img_spfi_runtime_resume' undeclared here (not in a function); did you mean 'pm_runtime_resume'?
     741 |         SET_RUNTIME_PM_OPS(img_spfi_runtime_suspend, img_spfi_runtime_resume,
         |                                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-img-spfi.c:741:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     741 |         SET_RUNTIME_PM_OPS(img_spfi_runtime_suspend, img_spfi_runtime_resume,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/spi/spi-dln2.c:8:
>> drivers/spi/spi-dln2.c:864:28: error: 'dln2_spi_runtime_suspend' undeclared here (not in a function); did you mean 'pm_runtime_suspend'?
     864 |         SET_RUNTIME_PM_OPS(dln2_spi_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-dln2.c:864:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     864 |         SET_RUNTIME_PM_OPS(dln2_spi_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-dln2.c:865:28: error: 'dln2_spi_runtime_resume' undeclared here (not in a function); did you mean 'pm_runtime_resume'?
     865 |                            dln2_spi_runtime_resume, NULL)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-dln2.c:864:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     864 |         SET_RUNTIME_PM_OPS(dln2_spi_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/interrupt.h:6,
                    from drivers/spi/spi-orion.c:9:
>> drivers/spi/spi-orion.c:837:28: error: 'orion_spi_runtime_suspend' undeclared here (not in a function); did you mean 'pm_runtime_suspend'?
     837 |         SET_RUNTIME_PM_OPS(orion_spi_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-orion.c:837:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     837 |         SET_RUNTIME_PM_OPS(orion_spi_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-orion.c:838:28: error: 'orion_spi_runtime_resume' undeclared here (not in a function); did you mean 'pm_runtime_resume'?
     838 |                            orion_spi_runtime_resume,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-orion.c:837:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     837 |         SET_RUNTIME_PM_OPS(orion_spi_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/clk.h:13,
                    from drivers/spi/spi-rockchip.c:7:
>> drivers/spi/spi-rockchip.c:1020:28: error: 'rockchip_spi_runtime_suspend' undeclared here (not in a function)
    1020 |         SET_RUNTIME_PM_OPS(rockchip_spi_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-rockchip.c:1020:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1020 |         SET_RUNTIME_PM_OPS(rockchip_spi_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-rockchip.c:1021:28: error: 'rockchip_spi_runtime_resume' undeclared here (not in a function)
    1021 |                            rockchip_spi_runtime_resume, NULL)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/spi/spi-rockchip.c:1020:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1020 |         SET_RUNTIME_PM_OPS(rockchip_spi_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
..


vim +711 drivers/slimbus/qcom-ctrl.c

ad7fcbc308b050 Sagar Dharia 2017-12-11  707  
ad7fcbc308b050 Sagar Dharia 2017-12-11  708  static const struct dev_pm_ops qcom_slim_dev_pm_ops = {
ad7fcbc308b050 Sagar Dharia 2017-12-11  709  	SET_SYSTEM_SLEEP_PM_OPS(qcom_slim_suspend, qcom_slim_resume)
ad7fcbc308b050 Sagar Dharia 2017-12-11  710  	SET_RUNTIME_PM_OPS(
ad7fcbc308b050 Sagar Dharia 2017-12-11 @711  			   qcom_slim_runtime_suspend,
ad7fcbc308b050 Sagar Dharia 2017-12-11 @712  			   qcom_slim_runtime_resume,
ad7fcbc308b050 Sagar Dharia 2017-12-11  713  			   NULL
ad7fcbc308b050 Sagar Dharia 2017-12-11  714  	)
ad7fcbc308b050 Sagar Dharia 2017-12-11  715  };
ad7fcbc308b050 Sagar Dharia 2017-12-11  716  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

