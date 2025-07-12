Return-Path: <linux-pm+bounces-30733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD7B02D41
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 23:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140343BB13E
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D63225A38;
	Sat, 12 Jul 2025 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkApOp/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C91F2BAE
	for <linux-pm@vger.kernel.org>; Sat, 12 Jul 2025 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752356730; cv=none; b=IRETBoMM6fq3Ff+cr597vvksJ9+jmyUiJg5hAGtZ5R+f9IVV53INK9p4Zu/hQ3x+LVn1wJukGurMgwiN6m0xK6zBBU6YKlzC195iSS24ohBfLsIw77LejLViWF1/1y27ZRXwaKoo5KV24LKWQjOj3pdwK8uJd5KJVfB2aDNOMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752356730; c=relaxed/simple;
	bh=8IX5mpUXCYTmlFFh11WohKJGUsbbEjDDWLInJqawZEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoRI+De35MKtRwlsMMIj7T5unT53YyqW3ytu4/gGFn9rXt+TSc+g6ZN256OPZPkwHwmVNZnMWQfYi+gMeZRZSB+ONVhT3lLINa/pIJPwqK8Q5ZoEIIFO0CCVwE6/j3whVrzx/zPhsuEOzvIoROoNgRA1FBsZP58/8A83krj/FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkApOp/b; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752356729; x=1783892729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8IX5mpUXCYTmlFFh11WohKJGUsbbEjDDWLInJqawZEY=;
  b=SkApOp/bYJe2vop5MVX3ly8djmboKT00fOrNAY6mxcoLxQGWYKITBDeS
   vJr3Ey33QM9+LTEcrF18frGpBuK1QEjf3kswE+ZSlGosQpLJBZ3bbdcrg
   Np9bq6dLs6qOE7pVHtYSZ6aJvOMoXoRaGXEQD2dlWmXIfc3Ko144lPtfw
   N6mOaKL4e58ZLHne0p4ftWEiEzJpWGpe38EiJ+OLDDOLKhnqMIrmkSdji
   GJGdP0sJigkfnW1ZrE9hpUaJAYxtwqRaJK3W4+16LLsiN2aN4ySn7f/V/
   g3Syqb2ZdevtnxT+qzy1eGKyTA1ajH2HlLOpJSzydyBXvuId0WtxC/5uc
   A==;
X-CSE-ConnectionGUID: 2LzlrytMTuuoDj1FFDBw/w==
X-CSE-MsgGUID: FDxu2DIwQUmbv/bl8MQX8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65186567"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="65186567"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 14:45:28 -0700
X-CSE-ConnectionGUID: RmIkj5dVTpazBxX/ONimvA==
X-CSE-MsgGUID: 7ReyvrBwRCC9uIny1h44Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="156714724"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 12 Jul 2025 14:45:26 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uai28-0007i3-1J;
	Sat, 12 Jul 2025 21:45:24 +0000
Date: Sun, 13 Jul 2025 05:44:34 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
	rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
	guoqing.zhang@amd.com
Cc: oe-kbuild-all@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: Add stub for pm_hibernate_is_recovering()
Message-ID: <202507130544.2Nxzh8Qg-lkp@intel.com>
References: <20250712185851.591024-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712185851.591024-1-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux-next/master]
[cannot apply to linus/master v6.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PM-hibernate-Add-stub-for-pm_hibernate_is_recovering/20250713-025938
base:   linux-next/master
patch link:    https://lore.kernel.org/r/20250712185851.591024-1-superm1%40kernel.org
patch subject: [PATCH] PM: hibernate: Add stub for pm_hibernate_is_recovering()
config: i386-buildonly-randconfig-003-20250713 (https://download.01.org/0day-ci/archive/20250713/202507130544.2Nxzh8Qg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250713/202507130544.2Nxzh8Qg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507130544.2Nxzh8Qg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/base/power/main.c:77:6: error: redefinition of 'pm_hibernate_is_recovering'
      77 | bool pm_hibernate_is_recovering(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/power/main.c:32:
   include/linux/suspend.h:420:20: note: previous definition of 'pm_hibernate_is_recovering' with type 'bool(void)' {aka '_Bool(void)'}
     420 | static inline bool pm_hibernate_is_recovering(void) { return false; }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pm_hibernate_is_recovering +77 drivers/base/power/main.c

098dff738abbea Rafael J. Wysocki 2010-09-22  68  
c2aaddbd2deded Samuel Zhang      2025-07-10  69  /**
c2aaddbd2deded Samuel Zhang      2025-07-10  70   * pm_hibernate_is_recovering - if recovering from hibernate due to error.
c2aaddbd2deded Samuel Zhang      2025-07-10  71   *
c2aaddbd2deded Samuel Zhang      2025-07-10  72   * Used to query if dev_pm_ops.thaw() is called for normal hibernation case or
c2aaddbd2deded Samuel Zhang      2025-07-10  73   * recovering from some error.
c2aaddbd2deded Samuel Zhang      2025-07-10  74   *
c2aaddbd2deded Samuel Zhang      2025-07-10  75   * Return: true for error case, false for normal case.
c2aaddbd2deded Samuel Zhang      2025-07-10  76   */
c2aaddbd2deded Samuel Zhang      2025-07-10 @77  bool pm_hibernate_is_recovering(void)
c2aaddbd2deded Samuel Zhang      2025-07-10  78  {
c2aaddbd2deded Samuel Zhang      2025-07-10  79  	return pm_transition.event == PM_EVENT_RECOVER;
c2aaddbd2deded Samuel Zhang      2025-07-10  80  }
c2aaddbd2deded Samuel Zhang      2025-07-10  81  EXPORT_SYMBOL_GPL(pm_hibernate_is_recovering);
c2aaddbd2deded Samuel Zhang      2025-07-10  82  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

