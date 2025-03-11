Return-Path: <linux-pm+bounces-23878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 235E0A5CB6A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AB63B8EE0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAEF184F;
	Tue, 11 Mar 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4Ki6spx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E47255E20;
	Tue, 11 Mar 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712228; cv=none; b=LMZuuTUW+7kU30xBkO/u5pudWymtsHM2uRVYHroQW4SURDuckP0bXH66Yqhqt5UeBaem3Cidc7JLvJZ9pZJcYDrBMEQaD/qSK4+r0tOYfWK0EVwFmt4F01dQQYhZvJC2naPDuGAKMVWmkK06qF2C1qcl/PPWjE26BFLY2jLvaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712228; c=relaxed/simple;
	bh=yFwxyB/vYM+QVK1Xvi2YhsAyqzx7H7T2HfW55Y8XdJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjpzunBIwwJaQD+qp4b2MfCu4hCtZhBcXl96cHLIjqnRoe5Q9C/iea+tLU0gUF0wvpcp9wIG+d8nqF70iyBiQtd9ykVzHQNvuwH2hffDC1J0UUEg46vcwxJ2QdtypbTeCdyPx+wxnpmQisJ3boBkIgkfY68+5tpC+75g1omaGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4Ki6spx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741712227; x=1773248227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yFwxyB/vYM+QVK1Xvi2YhsAyqzx7H7T2HfW55Y8XdJs=;
  b=G4Ki6spx8ssB1+sYwNO6jl8JbPSVtLOeFsZVYcaf+Z+/AnOWxeV5v9Wr
   P5h0ofbTszUOTqwU16BFFOUM1o2G1VGHqbsopPIxriY2p8dzAv8+0IdZi
   g/J9FLdl6vXrVtBoYwwk8CuyfH4IQr5edrmbL7P12e/jRiQZQOia89Jrh
   IblJeVNQnvMiHKO0chIL8/cG04n6uY6wi0KxWDDB0TW786puMgBhAO7SE
   fjFfzFvOAA5BPI1EJvZW01K4hCM5neUiypZgqbKs5CHO0xgE9TECUoQOH
   foopq3J7AUkYJ8MwvmPcLSE/lFX5FmaTYqJ31kiaj6c3F7Tv7yVgjIFeN
   g==;
X-CSE-ConnectionGUID: YP9GigpOQUOziHEfPnu+5w==
X-CSE-MsgGUID: dYOfLcfRT8SOmUaBHUM/Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="54135119"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="54135119"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 09:57:06 -0700
X-CSE-ConnectionGUID: 2SAKFf+bRjqV6NWtJsv0PQ==
X-CSE-MsgGUID: 2Zumsmh6TS+qw2vv8LVAyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125438958"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 11 Mar 2025 09:57:03 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts2ub-0007eW-1H;
	Tue, 11 Mar 2025 16:57:01 +0000
Date: Wed, 12 Mar 2025 00:56:47 +0800
From: kernel test robot <lkp@intel.com>
To: Anand Moon <linux.amoon@gmail.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v4 4/4] drivers/thermal/exymos: Use guard notation when
 acquiring mutex
Message-ID: <202503120028.ZL9zhHXe-lkp@intel.com>
References: <20250310143450.8276-5-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310143450.8276-5-linux.amoon@gmail.com>

Hi Anand,

kernel test robot noticed the following build errors:

[auto build test ERROR on 80e54e84911a923c40d7bee33a34c1b4be148d7a]

url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/drivers-thermal-exynos-Refactor-clk_sec-initialization-inside-SOC-specific-case/20250310-223732
base:   80e54e84911a923c40d7bee33a34c1b4be148d7a
patch link:    https://lore.kernel.org/r/20250310143450.8276-5-linux.amoon%40gmail.com
patch subject: [PATCH v4 4/4] drivers/thermal/exymos: Use guard notation when acquiring mutex
config: s390-randconfig-001-20250311 (https://download.01.org/0day-ci/archive/20250312/202503120028.ZL9zhHXe-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503120028.ZL9zhHXe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503120028.ZL9zhHXe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/thermal/samsung/exynos_tmu.c:721:3: error: cannot jump from this goto statement to its label
                   goto out;
                   ^
   drivers/thermal/samsung/exynos_tmu.c:723:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
           guard(mutex)(&data->lock);
           ^
   include/linux/cleanup.h:309:15: note: expanded from macro 'guard'
           CLASS(_name, __UNIQUE_ID(guard))
                        ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
   #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                               ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
   #define __PASTE(a,b) ___PASTE(a,b)
                        ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
   #define ___PASTE(a,b) a##b
                         ^
   <scratch space>:78:1: note: expanded from here
   __UNIQUE_ID_guard398
   ^
   drivers/thermal/samsung/exynos_tmu.c:718:3: error: cannot jump from this goto statement to its label
                   goto out;
                   ^
   drivers/thermal/samsung/exynos_tmu.c:723:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
           guard(mutex)(&data->lock);
           ^
   include/linux/cleanup.h:309:15: note: expanded from macro 'guard'
           CLASS(_name, __UNIQUE_ID(guard))
                        ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
   #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                               ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
   #define __PASTE(a,b) ___PASTE(a,b)
                        ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
   #define ___PASTE(a,b) a##b
                         ^
   <scratch space>:78:1: note: expanded from here
   __UNIQUE_ID_guard398
   ^
   2 errors generated.


vim +721 drivers/thermal/samsung/exynos_tmu.c

285d994a51e45ca drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  711  
7ea98f70c73ea37 drivers/thermal/samsung/exynos_tmu.c Daniel Lezcano            2022-08-05  712  static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  713  {
5f68d0785e5258a drivers/thermal/samsung/exynos_tmu.c Daniel Lezcano            2023-03-01  714  	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  715  	int ret = -EINVAL;
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  716  
ef3f80fc7f79c32 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  717  	if (data->soc == SOC_ARCH_EXYNOS4210)
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  718  		goto out;
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  719  
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  720  	if (temp && temp < MCELSIUS)
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11 @721  		goto out;
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  722  
0c7c68a34f7d0f7 drivers/thermal/samsung/exynos_tmu.c Anand Moon                2025-03-10  723  	guard(mutex)(&data->lock);
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  724  	clk_enable(data->clk);
285d994a51e45ca drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  725  	data->tmu_set_emulation(data, temp);
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  726  	clk_disable(data->clk);
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  727  	return 0;
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  728  out:
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  729  	return ret;
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  730  }
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  731  #else
285d994a51e45ca drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  732  #define exynos4412_tmu_set_emulation NULL
7ea98f70c73ea37 drivers/thermal/samsung/exynos_tmu.c Daniel Lezcano            2022-08-05  733  static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  734  	{ return -EINVAL; }
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  735  #endif /* CONFIG_THERMAL_EMULATION */
bffd1f8ac87a798 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2013-02-11  736  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

