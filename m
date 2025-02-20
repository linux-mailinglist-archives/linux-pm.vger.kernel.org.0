Return-Path: <linux-pm+bounces-22534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC695A3D6DE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 11:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6B316A83D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658D1F0E31;
	Thu, 20 Feb 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZhxs/tH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67F1F03E5;
	Thu, 20 Feb 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047823; cv=none; b=b2kQkOLWKrCfUNcLjqxz6OTj14F2DLHMwgOVBZ+mb5RekslRjir7e+SnyzKpy7xh269Dbs3XCEhgPPZVQuJW6hxPD02ENTalgmcxXiQ50W54iOJnmE1pym+EvLRDWD0K6XztJ37rDmtzm5qO9RductL0qPmje8XnAPvn8pqeiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047823; c=relaxed/simple;
	bh=rkZXy35xnfDxkTnp01r6nltwGmhymc4diO7AN7MfGvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wa+w2shqbhv7I7up4Asq/wCFL4HCunQxF/jz1kPWBQ1AHZ/qMd7+b3x1mfWwoNQmda9JGgJjRbprwCvz2Iq93F6UbQXkSA6deRbHCX3gTiYSoOm0YQXLm/2s8KDI1G4HAOaRZNqC0r4NhUXspxiw88e52s3z/r1j3ft1/sQfPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZhxs/tH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740047821; x=1771583821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rkZXy35xnfDxkTnp01r6nltwGmhymc4diO7AN7MfGvo=;
  b=bZhxs/tHJz0dFefoclzq/wgHgvcH0ZsagXzV2gsZI4hgLyaJAGRJIOzF
   emhp25tXOIvnOY44dlNY9ZhPq9ft9Qu2zbrUczNT3WYl+q6/ELVWSNgDD
   Qbn89U0NbUU1hj3gqVoaJnTqSHaP46K0otEhuAW0EXWrlfmVKo4N3+eZn
   DY55Lx+36m8lChA3xs0a2CRMw0IaRT+oXInUqAzOvI1vBbqfZkkmXkJ49
   GEEjeLvCYXUyzlSRS41mwEyej2XkQVf/H9dJ9YGFCq8hgiNNAmFJppasb
   xsh58FqglqP3MAkpu/1T05m6uGpyjnSQOXMgZOqYdjo1sdXfKq6PAqYfU
   g==;
X-CSE-ConnectionGUID: BOQPyYN6QRm7h+b9ljzY5Q==
X-CSE-MsgGUID: Q8ZVk2LMT9Gw8VmuaCzh7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63294862"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="63294862"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 02:37:00 -0800
X-CSE-ConnectionGUID: eDO3h02PTO6O8h55rXd5cQ==
X-CSE-MsgGUID: L+UihZLoQhWyW5Y8BMvtYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="138200311"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Feb 2025 02:36:58 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl3vF-0004AF-2G;
	Thu, 20 Feb 2025 10:36:52 +0000
Date: Thu, 20 Feb 2025 18:35:09 +0800
From: kernel test robot <lkp@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
	paul@crapouillou.net, andriy.shevchenko@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1] PM: Discard runtime_xx() handles using pm_ptr()
Message-ID: <202502201807.2UYZnMAp-lkp@intel.com>
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
config: s390-randconfig-002-20250220 (https://download.01.org/0day-ci/archive/20250220/202502201807.2UYZnMAp-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502201807.2UYZnMAp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502201807.2UYZnMAp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:11,
                    from arch/s390/include/asm/processor.h:31,
                    from include/linux/sched.h:13,
                    from include/linux/delay.h:13,
                    from drivers/greybus/interface.c:9:
>> drivers/greybus/interface.c:764:28: error: 'gb_interface_suspend' undeclared here (not in a function); did you mean 'gb_interface_type'?
     764 |         SET_RUNTIME_PM_OPS(gb_interface_suspend, gb_interface_resume,
         |                            ^~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/greybus/interface.c:764:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     764 |         SET_RUNTIME_PM_OPS(gb_interface_suspend, gb_interface_resume,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/greybus/interface.c:764:50: error: 'gb_interface_resume' undeclared here (not in a function); did you mean 'gb_interface_release'?
     764 |         SET_RUNTIME_PM_OPS(gb_interface_suspend, gb_interface_resume,
         |                                                  ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/greybus/interface.c:764:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     764 |         SET_RUNTIME_PM_OPS(gb_interface_suspend, gb_interface_resume,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/greybus/interface.c:765:28: error: 'gb_interface_runtime_idle' undeclared here (not in a function); did you mean 'gb_interface_read_dme'?
     765 |                            gb_interface_runtime_idle)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:339:25: note: in expansion of macro 'pm_ptr'
     339 |         .runtime_idle = pm_ptr(idle_fn),
         |                         ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/greybus/interface.c:764:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     764 |         SET_RUNTIME_PM_OPS(gb_interface_suspend, gb_interface_resume,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/greybus.h:14,
                    from drivers/greybus/bundle.c:9:
>> drivers/greybus/bundle.c:166:28: error: 'gb_bundle_suspend' undeclared here (not in a function); did you mean 'gb_bundle_find'?
     166 |         SET_RUNTIME_PM_OPS(gb_bundle_suspend, gb_bundle_resume, gb_bundle_idle)
         |                            ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/greybus/bundle.c:166:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     166 |         SET_RUNTIME_PM_OPS(gb_bundle_suspend, gb_bundle_resume, gb_bundle_idle)
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/greybus/bundle.c:166:47: error: 'gb_bundle_resume' undeclared here (not in a function); did you mean 'gb_bundle_release'?
     166 |         SET_RUNTIME_PM_OPS(gb_bundle_suspend, gb_bundle_resume, gb_bundle_idle)
         |                                               ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/greybus/bundle.c:166:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     166 |         SET_RUNTIME_PM_OPS(gb_bundle_suspend, gb_bundle_resume, gb_bundle_idle)
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/greybus/bundle.c:166:65: error: 'gb_bundle_idle' undeclared here (not in a function); did you mean 'gb_bundle_add'?
     166 |         SET_RUNTIME_PM_OPS(gb_bundle_suspend, gb_bundle_resume, gb_bundle_idle)
         |                                                                 ^~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:339:25: note: in expansion of macro 'pm_ptr'
     339 |         .runtime_idle = pm_ptr(idle_fn),
         |                         ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/greybus/bundle.c:166:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     166 |         SET_RUNTIME_PM_OPS(gb_bundle_suspend, gb_bundle_resume, gb_bundle_idle)
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/cdev.h:5,
                    from include/linux/gnss.h:11,
                    from drivers/gnss/serial.c:9:
>> drivers/gnss/serial.c:270:28: error: 'gnss_serial_runtime_suspend' undeclared here (not in a function); did you mean 'pm_generic_runtime_suspend'?
     270 |         SET_RUNTIME_PM_OPS(gnss_serial_runtime_suspend, gnss_serial_runtime_resume, NULL)
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
   drivers/gnss/serial.c:270:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     270 |         SET_RUNTIME_PM_OPS(gnss_serial_runtime_suspend, gnss_serial_runtime_resume, NULL)
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/gnss/serial.c:270:57: error: 'gnss_serial_runtime_resume' undeclared here (not in a function); did you mean 'pm_generic_runtime_resume'?
     270 |         SET_RUNTIME_PM_OPS(gnss_serial_runtime_suspend, gnss_serial_runtime_resume, NULL)
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/gnss/serial.c:270:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     270 |         SET_RUNTIME_PM_OPS(gnss_serial_runtime_suspend, gnss_serial_runtime_resume, NULL)
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/misc/apds990x.c:11:
>> drivers/misc/apds990x.c:1266:28: error: 'apds990x_runtime_suspend' undeclared here (not in a function); did you mean 'pm_runtime_suspend'?
    1266 |         SET_RUNTIME_PM_OPS(apds990x_runtime_suspend,
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
   drivers/misc/apds990x.c:1266:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1266 |         SET_RUNTIME_PM_OPS(apds990x_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/misc/apds990x.c:1267:25: error: 'apds990x_runtime_resume' undeclared here (not in a function); did you mean 'pm_runtime_resume'?
    1267 |                         apds990x_runtime_resume,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/misc/apds990x.c:1266:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1266 |         SET_RUNTIME_PM_OPS(apds990x_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/misc/bh1770glc.c:11:
>> drivers/misc/bh1770glc.c:1373:28: error: 'bh1770_runtime_suspend' undeclared here (not in a function); did you mean 'pm_runtime_suspend'?
    1373 |         SET_RUNTIME_PM_OPS(bh1770_runtime_suspend, bh1770_runtime_resume, NULL)
         |                            ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/misc/bh1770glc.c:1373:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1373 |         SET_RUNTIME_PM_OPS(bh1770_runtime_suspend, bh1770_runtime_resume, NULL)
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/misc/bh1770glc.c:1373:52: error: 'bh1770_runtime_resume' undeclared here (not in a function); did you mean 'pm_runtime_resume'?
    1373 |         SET_RUNTIME_PM_OPS(bh1770_runtime_suspend, bh1770_runtime_resume, NULL)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/misc/bh1770glc.c:1373:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1373 |         SET_RUNTIME_PM_OPS(bh1770_runtime_suspend, bh1770_runtime_resume, NULL)
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/iio/accel/bmc150-accel-core.c:7:
>> drivers/iio/accel/bmc150-accel-core.c:1858:28: error: 'bmc150_accel_runtime_suspend' undeclared here (not in a function); did you mean 'bmc150_accel_update_slope'?
    1858 |         SET_RUNTIME_PM_OPS(bmc150_accel_runtime_suspend,
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
   drivers/iio/accel/bmc150-accel-core.c:1858:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1858 |         SET_RUNTIME_PM_OPS(bmc150_accel_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/bmc150-accel-core.c:1859:28: error: 'bmc150_accel_runtime_resume' undeclared here (not in a function); did you mean 'bmc150_accel_core_remove'?
    1859 |                            bmc150_accel_runtime_resume, NULL)
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
   drivers/iio/accel/bmc150-accel-core.c:1858:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1858 |         SET_RUNTIME_PM_OPS(bmc150_accel_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/iio/accel/mma8452.c:21:
>> drivers/iio/accel/mma8452.c:1823:28: error: 'mma8452_runtime_suspend' undeclared here (not in a function); did you mean 'pm_runtime_suspend'?
    1823 |         SET_RUNTIME_PM_OPS(mma8452_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:337:28: note: in expansion of macro 'pm_ptr'
     337 |         .runtime_suspend = pm_ptr(suspend_fn), \
         |                            ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/iio/accel/mma8452.c:1823:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1823 |         SET_RUNTIME_PM_OPS(mma8452_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/mma8452.c:1824:28: error: 'mma8452_runtime_resume' undeclared here (not in a function); did you mean 'pm_runtime_resume'?
    1824 |                            mma8452_runtime_resume, NULL)
         |                            ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:48:44: note: in definition of macro 'PTR_IF'
      48 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:338:27: note: in expansion of macro 'pm_ptr'
     338 |         .runtime_resume = pm_ptr(resume_fn), \
         |                           ^~~~~~
   include/linux/pm.h:363:9: note: in expansion of macro 'RUNTIME_PM_OPS'
     363 |         RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
         |         ^~~~~~~~~~~~~~
   drivers/iio/accel/mma8452.c:1823:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1823 |         SET_RUNTIME_PM_OPS(mma8452_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/iio/magnetometer/bmc150_magn.c:12:
>> drivers/iio/magnetometer/bmc150_magn.c:1062:28: error: 'bmc150_magn_runtime_suspend' undeclared here (not in a function)
    1062 |         SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
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
   drivers/iio/magnetometer/bmc150_magn.c:1062:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1062 |         SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/iio/magnetometer/bmc150_magn.c:1063:28: error: 'bmc150_magn_runtime_resume' undeclared here (not in a function); did you mean 'bmc150_magn_trim_regs'?
    1063 |                            bmc150_magn_runtime_resume, NULL)
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
   drivers/iio/magnetometer/bmc150_magn.c:1062:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
    1062 |         SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
..


vim +764 drivers/greybus/interface.c

30a3bf7b30d86b drivers/staging/greybus/interface.c David Lin 2016-07-14  762  
30a3bf7b30d86b drivers/staging/greybus/interface.c David Lin 2016-07-14  763  static const struct dev_pm_ops gb_interface_pm_ops = {
30a3bf7b30d86b drivers/staging/greybus/interface.c David Lin 2016-07-14 @764  	SET_RUNTIME_PM_OPS(gb_interface_suspend, gb_interface_resume,
30a3bf7b30d86b drivers/staging/greybus/interface.c David Lin 2016-07-14 @765  			   gb_interface_runtime_idle)
30a3bf7b30d86b drivers/staging/greybus/interface.c David Lin 2016-07-14  766  };
30a3bf7b30d86b drivers/staging/greybus/interface.c David Lin 2016-07-14  767  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

