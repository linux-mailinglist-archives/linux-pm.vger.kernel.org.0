Return-Path: <linux-pm+bounces-12386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27632955850
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 16:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E0E1F220D1
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4291537D4;
	Sat, 17 Aug 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIqI3iFt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62D14D28A
	for <linux-pm@vger.kernel.org>; Sat, 17 Aug 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904504; cv=none; b=RgQV0qkxxMQ0fapgZMIubuV8inO8an6rDv6/wJcCc7SZBjB+a2QulyfEtn4pJalCU0mFSdu9h/G3IqpP/c08cxywPe/v5k2FiXFbi4hrc086ICuwyjesfOEJ2xcwvHXgfr/zvTdYK3yzHilUj+fUxSNDPhTQW+QJBt0oVMYgMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904504; c=relaxed/simple;
	bh=Y17/xrUztOomoSskCwGO5F1eOes8mK6fYV+yumVB8QM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vBDEXBW8d79JpYNXgdEDX0GKH9xyKXjM0NAiDzAq7Nd+m1qZNidonQ1WoX+aY27XsRxzihhNh5Zwz70nKYzimOFifNRe9vXArSazZ2UZOcEt9nuCBCZwWmVZQkDk0hG0ZHvpEJk3x07uZtmaNIyhpD5w1QygOHNPFZLLb62tYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIqI3iFt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723904503; x=1755440503;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Y17/xrUztOomoSskCwGO5F1eOes8mK6fYV+yumVB8QM=;
  b=oIqI3iFtxqLF5qqo7cGACyzwXSzM5WNehOOkNKDEyUrvjydXfwuq2Vhc
   c5vqoO8TEe/Qvh9mEu6m9HF3DJpzJ+OYucUpZ+U+LMyoz6ifA+NBefLXc
   +9oVuvZecglnLxLpn2Z+h7f3tNoamkJTZ/g22FpzzL+m85HUw11vXybM2
   I8fMU1r6IyjpgkjJsiXUCqH8pUPoJ+/wH12dC+/RMZr+maJ+snUNiGTVB
   YIox5NUa3Iz8Xgs3DoFeafnZzjXpr1MNUSSqCwcKIGt7lNIt3XtkrtXSz
   bLcaQxbjC06xQcZtlAGjdBzpENdpwoh3bBBq4u2pcKenvsOm7YAR0MB5v
   A==;
X-CSE-ConnectionGUID: 1pc0hewoQlSRNM9Y9YwnjQ==
X-CSE-MsgGUID: eq2wNQs5QEOavMsUOjbcAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="44708744"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="44708744"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 07:21:43 -0700
X-CSE-ConnectionGUID: WgO8WI7/SBO/BZ0zdI6Xxw==
X-CSE-MsgGUID: qBrbyueoSI2x3C20i53Y/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="59946515"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Aug 2024 07:21:41 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfKJG-0007Xi-2H;
	Sat, 17 Aug 2024 14:21:38 +0000
Date: Sat, 17 Aug 2024 22:21:34 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/runtime-pm-screen-on-off 5/5]
 drivers/platform/x86/asus-wmi.c:4915:25: error: 'asus_hotk_resume_early'
 undeclared here (not in a function); did you mean 'asus_hotk_resume'?
Message-ID: <202408172243.JTi2DN1W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/runtime-pm-screen-on-off
head:   09020cb8f4063731baa98c5f0fd9f1785597c989
commit: 09020cb8f4063731baa98c5f0fd9f1785597c989 [5/5] platform/x86: asus-wmi: Drop CSEE quirks
config: x86_64-buildonly-randconfig-003-20240817 (https://download.01.org/0day-ci/archive/20240817/202408172243.JTi2DN1W-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408172243.JTi2DN1W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408172243.JTi2DN1W-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/x86/asus-wmi.c:4915:25: error: 'asus_hotk_resume_early' undeclared here (not in a function); did you mean 'asus_hotk_resume'?
    4915 |         .resume_early = asus_hotk_resume_early,
         |                         ^~~~~~~~~~~~~~~~~~~~~~
         |                         asus_hotk_resume
>> drivers/platform/x86/asus-wmi.c:4916:20: error: 'asus_hotk_prepare' undeclared here (not in a function); did you mean 'asus_hotk_restore'?
    4916 |         .prepare = asus_hotk_prepare,
         |                    ^~~~~~~~~~~~~~~~~
         |                    asus_hotk_restore


vim +4915 drivers/platform/x86/asus-wmi.c

0773d7f9f1c0ad drivers/platform/x86/eeepc-wmi.c Corentin Chary 2011-02-06  4910  
e12e6d94db24e9 drivers/platform/x86/asus-wmi.c  Corentin Chary 2011-02-26  4911  static const struct dev_pm_ops asus_pm_ops = {
e12e6d94db24e9 drivers/platform/x86/asus-wmi.c  Corentin Chary 2011-02-26  4912  	.thaw = asus_hotk_thaw,
e12e6d94db24e9 drivers/platform/x86/asus-wmi.c  Corentin Chary 2011-02-26  4913  	.restore = asus_hotk_restore,
307340493f3d62 drivers/platform/x86/asus-wmi.c  Oleksij Rempel 2015-09-14  4914  	.resume = asus_hotk_resume,
e0894ff038d86f drivers/platform/x86/asus-wmi.c  Luke D. Jones  2023-11-27 @4915  	.resume_early = asus_hotk_resume_early,
e0894ff038d86f drivers/platform/x86/asus-wmi.c  Luke D. Jones  2023-11-27 @4916  	.prepare = asus_hotk_prepare,
45f2c6937ed606 drivers/platform/x86/eeepc-wmi.c Yong Wang      2010-04-11  4917  };
45f2c6937ed606 drivers/platform/x86/eeepc-wmi.c Yong Wang      2010-04-11  4918  

:::::: The code at line 4915 was first introduced by commit
:::::: e0894ff038d86f30614ec16ec26dacb88c8d2bd4 platform/x86: asus-wmi: disable USB0 hub on ROG Ally before suspend

:::::: TO: Luke D. Jones <luke@ljones.dev>
:::::: CC: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

