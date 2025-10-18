Return-Path: <linux-pm+bounces-36412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00767BED7D0
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 20:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFAEA4E962F
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 18:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D230257839;
	Sat, 18 Oct 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gjxf/vgH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E031E00A0;
	Sat, 18 Oct 2025 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760812349; cv=none; b=jhOnoGt0AY/+/pdzzDsVhajQj9JJ88mox85nATNjnkt6nSYPv4D6+IjcgoBB+yadKQDUQjMIA/7Y/BDS7vs0RkM8ETZ2tMap++eQ7FdDxcCm+ySU2V1TGCIuwfhMIh2bx3jJIeKWEHS8XSmK1V0f7k1S7qAKjdRT8EH3mxb4LrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760812349; c=relaxed/simple;
	bh=wPo4wMLveYwmwF+xtSw/lXJkmyMLi54gYW0Sjt6epYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S28QfGrhxttQEGeWifp+qSjeHljdWU7a/77U7tcg4mmkPaq3ta35qVCU9q/tSIHc2kZCWBjgW/TUuftVP9ShWS+jL2WL5D6Eoj3baL8u5JoRyXANGuycfOmG1vDV/UAk3jdgTN5YEin7Nd/eme4TNDVAUXVbKHi82d8H5dbQJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gjxf/vgH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760812347; x=1792348347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPo4wMLveYwmwF+xtSw/lXJkmyMLi54gYW0Sjt6epYs=;
  b=Gjxf/vgHhurGHCJVVuC0sblTRr2xNGI2pn6me/JwGkiwvvf9CtFXEe/s
   hP8aIXR3oqv2wiDvWjUpdW8UCtIEYz4/wMwtt3VLxNGYyHK/zD3+vl/Jh
   EJxVY31z189tCASy3jeolIuMznFnGVdNYktZYtHfzwM9zb0HHGDXbtOw/
   4bzQ8UCajYg+d/18NnMZYJXpCXckCw2QQM1ccy6dAfJ3hZTxAh0aB7ZSE
   RHMqjBHNtPVXmaC/TOM5AfWg4y1el1v15PPTeg/yzZKc5gtQWZUjjs/rY
   TaxqwE2v4p7e1Orqq9MasOhygd8zJ5bzLNL7VgtDV/3qaJHIyGM6Raqej
   A==;
X-CSE-ConnectionGUID: 04BfE6OARDyJ6TysFRHnDQ==
X-CSE-MsgGUID: C5OJXYr6SMSYsRWtMMUZrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73598402"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="73598402"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 11:32:26 -0700
X-CSE-ConnectionGUID: KivUsA3GRqeG295YLtVzbg==
X-CSE-MsgGUID: jRJZvYW1RmGXnoMtIMcLDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="213602851"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 18 Oct 2025 11:32:23 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vABj2-0008Vx-2K;
	Sat, 18 Oct 2025 18:32:20 +0000
Date: Sun, 19 Oct 2025 02:31:44 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Wu <wusamuel@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	tuhaowen@uniontech.com, Samuel Wu <wusamuel@google.com>,
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
Message-ID: <202510190215.ppx4apvg-lkp@intel.com>
References: <20251017233907.2305303-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017233907.2305303-1-wusamuel@google.com>

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.18-rc1 next-20251017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Wu/PM-Support-aborting-sleep-during-filesystem-sync/20251018-091422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251017233907.2305303-1-wusamuel%40google.com
patch subject: [PATCH v5] PM: Support aborting sleep during filesystem sync
config: i386-randconfig-012-20251018 (https://download.01.org/0day-ci/archive/20251019/202510190215.ppx4apvg-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510190215.ppx4apvg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510190215.ppx4apvg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
>> include/linux/suspend.h:510:15: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     510 | static inline pm_stop_waiting_for_fs_sync(void) {}
         | ~~~~~~~~~~~~~ ^
         | int
   1 error generated.
   make[3]: *** [scripts/Makefile.build:182: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=1011955029
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1280: prepare0] Error 2 shuffle=1011955029
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=1011955029
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=1011955029
   make: Target 'prepare' not remade because of errors.


vim +/int +510 include/linux/suspend.h

   508	
   509	static inline void ksys_sync_helper(void) {}
 > 510	static inline pm_stop_waiting_for_fs_sync(void) {}
   511	static inline int pm_sleep_fs_sync(void) {}
   512	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

