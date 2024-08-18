Return-Path: <linux-pm+bounces-12389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F91955A88
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2024 03:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB70F281F46
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2024 01:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84952CA9;
	Sun, 18 Aug 2024 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXf6Z6xO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400638C;
	Sun, 18 Aug 2024 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723945022; cv=none; b=YfdceaiTP6bdr8SzKiniQ1jZHCdxmCDTAkJ5hkJj7wfo81eWnsq/V2+rTndEBDTbU9z3Uhp2/xFWxQWUEQd5U0ojgJ2zCo4i8uxN3L/XtqRqFupsG3pX5KUGd1aQSjuO3YGsbFSUH9haFuzuYwiwVfjQ+GJW69tUqbCFKZWa54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723945022; c=relaxed/simple;
	bh=pKTc9YBaShJeDIbOxekvUzBsbWwjuqG4vB3IhdsLsEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAJbCVWmm1/2yh/KkwNIL9i7iMa6NcYBiNShc3ILYePWp0g7kb4wnu1ejA4DwBwJyMPErRW7AwlIKMSSCPm8h+KQvML5DMUasetG+ob5WOMwO79Vn8zlqZmqbWS1J5skeiRdhwZytCfontRFib2rObWvx6Bt+XnajgMv7QZbGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXf6Z6xO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723945020; x=1755481020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKTc9YBaShJeDIbOxekvUzBsbWwjuqG4vB3IhdsLsEs=;
  b=cXf6Z6xOvpNIFMZvetDsBSn6ugZXoO7H5qtp5igUz3Ra+kjSr9MrVK8a
   5DRyl3Q6bYpENOvpCB0wV4qqFm/nFJq4krOOBPecBfTrXA6p58bC69008
   f0dSVAgngp7MIv7eghaGpur1wVbb2kATPsQBdM+x+IK4gRxkICdMCLC0j
   bsgrBNOxVkpi0768y68UWMyD3PdavqY1eh6i7TbU79eie2otNuPLY6Qtc
   +SLbzfkJIauvLl2e1lyHh6Ez7bhkLOR9UKuFGZRZcPgbuIRDmQYLHqq0h
   NPXHOiknzhMNCwsYMz90NqRuZyeC/uecbYekGFVTAdycytIFdhWLsU5Yw
   w==;
X-CSE-ConnectionGUID: Gw/2NCdGTZiFMchENoEzdw==
X-CSE-MsgGUID: 8RNhBlO3SmyISuj/Y08h/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="21754466"
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="21754466"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 18:37:00 -0700
X-CSE-ConnectionGUID: +7VW4Hd4T2mufiOu+8yBmg==
X-CSE-MsgGUID: q3lqzevdR8qCf+uhtviW3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="90793410"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Aug 2024 18:36:57 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfUql-0007wY-1L;
	Sun, 18 Aug 2024 01:36:55 +0000
Date: Sun, 18 Aug 2024 09:36:03 +0800
From: kernel test robot <lkp@intel.com>
To: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change
  battery charge settings
Message-ID: <202408180954.hBMWkKuU-lkp@intel.com>
References: <20240815192848.3489d3e1@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815192848.3489d3e1@5400>

Hi Andres,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on linus/master v6.11-rc3 next-20240816]
[cannot apply to amd-pstate/linux-next amd-pstate/bleeding-edge]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andres-Salomon/platform-x86-dell-laptop-remove-duplicate-code-w-battery-function/20240816-102156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240815192848.3489d3e1%405400
patch subject: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change  battery charge settings
config: x86_64-randconfig-122-20240817 (https://download.01.org/0day-ci/archive/20240818/202408180954.hBMWkKuU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240818/202408180954.hBMWkKuU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408180954.hBMWkKuU-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/mm/testmmiotrace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in mm/kasan/kasan_test.o
>> WARNING: modpost: drivers/platform/x86/dell/dell-laptop: section mismatch in reference: dell_init+0x637 (section: .init.text) -> dell_battery_exit (section: .exit.text)
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

