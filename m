Return-Path: <linux-pm+bounces-12385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF7A955795
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 13:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0974282617
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 11:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93168149DFA;
	Sat, 17 Aug 2024 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIhh0MEc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3486AE3
	for <linux-pm@vger.kernel.org>; Sat, 17 Aug 2024 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723895258; cv=none; b=KLMv786wR2sIE9GfOFxqvhCZHPYvxn6wUYM4I8hF3rDptczNyGanILxKR51VkJVyGJ3P2ADy+y2IlQhQsRhWsFsYmbbjmuCY0qzkOmdJcALfU5eFpQYErFcD3PTn2ajw4KWDR+KZ1XqCTnPabRLIiF/y5oE5vhCF4/w3rWAFR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723895258; c=relaxed/simple;
	bh=AZUAbIc24oH/VzXd5phoRH4eID2p1Ohn6zjI85Owo7U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fK0lGx5WxGksnJlagLeq/37lhmSYYcmeIPv/BVIoiUtHinrjOsBXb5noO69xf7PO6yxdWxHXh/IiUD5vph7Nfwr/ZJjZZ9+zKC7UR6qyThqAiOeAqnqucPB5hmZwxLoLGTNNqKtXnrVQQixt97NKTTp8V3kpTWemoImso8hHUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIhh0MEc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723895257; x=1755431257;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AZUAbIc24oH/VzXd5phoRH4eID2p1Ohn6zjI85Owo7U=;
  b=SIhh0MEcLD9VPdUN0rvjhDjKWP+t9xNLVkGfBkEJMbdC/mYDHYAH1+55
   VbllvUFKBPTowkMOzb5ZFR8MC7mPl3edCxmWXYG1pYnojRROFQ6LKQeC4
   cZUfhTAnmXxMfP6kWHS9PwnrdEJTwUUrHwWp7OFpAKIBAFSFm7SqUnCIq
   aQKwKZ4TcZqEREiYL1Sn0M3E6YkB3JBdbBH912liyjAQdv+QnGbqzDMOh
   p7t8JUn6vFE/xA+7mqaCoJS++ySZ9LJg15nix0EAm84AefSbNG6LVHbI6
   0aNgXikNGQYA+yn6a2+HTYIZ1mo1pIhSShgQddOPZ1q/fBLMnPznPlqXq
   Q==;
X-CSE-ConnectionGUID: fTEuSYNzSsucC2lHvaNEtQ==
X-CSE-MsgGUID: X7nDlTwVR0CSqlv6oI6T+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25939107"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="25939107"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 04:47:37 -0700
X-CSE-ConnectionGUID: Z6cu5aJURiuIZCQZMf1tCg==
X-CSE-MsgGUID: cU+1avdmR6ye9q1d+7oqzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="60196666"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Aug 2024 04:47:35 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfHu8-0007Pe-29;
	Sat, 17 Aug 2024 11:47:32 +0000
Date: Sat, 17 Aug 2024 19:46:49 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/runtime-pm-screen-on-off 5/5]
 drivers/platform/x86/asus-wmi.c:4915:18: error: use of undeclared identifier
 'asus_hotk_resume_early'; did you mean 'asus_hotk_resume'?
Message-ID: <202408171906.JvqE9BvI-lkp@intel.com>
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
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240817/202408171906.JvqE9BvI-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408171906.JvqE9BvI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408171906.JvqE9BvI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/x86/asus-wmi.c:4915:18: error: use of undeclared identifier 'asus_hotk_resume_early'; did you mean 'asus_hotk_resume'?
    4915 |         .resume_early = asus_hotk_resume_early,
         |                         ^~~~~~~~~~~~~~~~~~~~~~
         |                         asus_hotk_resume
   drivers/platform/x86/asus-wmi.c:4856:12: note: 'asus_hotk_resume' declared here
    4856 | static int asus_hotk_resume(struct device *device)
         |            ^
>> drivers/platform/x86/asus-wmi.c:4916:13: error: use of undeclared identifier 'asus_hotk_prepare'
    4916 |         .prepare = asus_hotk_prepare,
         |                    ^
   2 errors generated.


vim +4915 drivers/platform/x86/asus-wmi.c

0773d7f9f1c0ad5 drivers/platform/x86/eeepc-wmi.c Corentin Chary 2011-02-06  4910  
e12e6d94db24e90 drivers/platform/x86/asus-wmi.c  Corentin Chary 2011-02-26  4911  static const struct dev_pm_ops asus_pm_ops = {
e12e6d94db24e90 drivers/platform/x86/asus-wmi.c  Corentin Chary 2011-02-26  4912  	.thaw = asus_hotk_thaw,
e12e6d94db24e90 drivers/platform/x86/asus-wmi.c  Corentin Chary 2011-02-26  4913  	.restore = asus_hotk_restore,
307340493f3d629 drivers/platform/x86/asus-wmi.c  Oleksij Rempel 2015-09-14  4914  	.resume = asus_hotk_resume,
e0894ff038d86f3 drivers/platform/x86/asus-wmi.c  Luke D. Jones  2023-11-27 @4915  	.resume_early = asus_hotk_resume_early,
e0894ff038d86f3 drivers/platform/x86/asus-wmi.c  Luke D. Jones  2023-11-27 @4916  	.prepare = asus_hotk_prepare,
45f2c6937ed6066 drivers/platform/x86/eeepc-wmi.c Yong Wang      2010-04-11  4917  };
45f2c6937ed6066 drivers/platform/x86/eeepc-wmi.c Yong Wang      2010-04-11  4918  

:::::: The code at line 4915 was first introduced by commit
:::::: e0894ff038d86f30614ec16ec26dacb88c8d2bd4 platform/x86: asus-wmi: disable USB0 hub on ROG Ally before suspend

:::::: TO: Luke D. Jones <luke@ljones.dev>
:::::: CC: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

