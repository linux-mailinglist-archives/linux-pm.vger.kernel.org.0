Return-Path: <linux-pm+bounces-16520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35499B1F0C
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 16:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22540B20DB1
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F228715FD13;
	Sun, 27 Oct 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFO56Vpw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD713C3CD
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730042114; cv=none; b=DI/Hn9WPis/Vaq2eq03qvmwpRyBnySE9iZErjiru4ywCAWLVNdl4oBPnxU4KUXNFgom/F7LmrUbJSNkjeecfO6mYpVUMI8j5z6A1n3ZGObjaKtJcLJELBU80TZicT6OmXg/c0QhXauaK6YQFeWLkghZ2tkhbaMurmhkdix7puTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730042114; c=relaxed/simple;
	bh=5u94Y7pa7BgsT3vqoEkK0FTH4Jud6+1xUFtegZSSdd4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NlRDMIcuKUBiTGNF/EKZO+y5DHIkTNDRQGGv+cDD9up4p8VpOURUREowFz86WvjGkeniOMkp179TSOpJ+udzIGx/U95xhfk2wHxWEpJJWkXx2XBfQDEjRJkYQVlBTEcC1hPo8lW1KwI1vqC9HJ7x3R6c1iYxn0lKePXIwAclT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFO56Vpw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730042112; x=1761578112;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5u94Y7pa7BgsT3vqoEkK0FTH4Jud6+1xUFtegZSSdd4=;
  b=fFO56VpwwGAmvR5RczcM9t3ElgMT+h7QtogeF6zcY+yyKpWS1UPXHD0b
   0aofagd38TRbo/H45FUKPl4x8VUpyvPsh77OCd91rRAGULuyvIcx056vf
   8PCGNeu1FDAbNuSvrqogxOjhhBdCrihyu+Fn7c2hU1aVvYX1Df5k7Tos7
   7nWcuLcSSQ+4Ty/q2lbezJsmN2xT698NpcASh/sJfmjd2cgPEifwtoApf
   6qY5yuO6fUGFRJ4iPgqxohBhduIaX1uVB1oyJYQaosMXgM/XKqsc9WuAN
   DYe5krJoxMapvobxq5XeJytiVu6NYpnWfOf1NLClJCMD9i1J84+ANi/mA
   A==;
X-CSE-ConnectionGUID: bcb3WC7vSQajbnbehdUhUA==
X-CSE-MsgGUID: /l4rVqk4RGWXE3aPq0C7IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40188619"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40188619"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 08:15:11 -0700
X-CSE-ConnectionGUID: mmVIbh3TSVWcWMgJ0F9Ydg==
X-CSE-MsgGUID: wEho5RnrR1WwN5Mv73HKFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="81285453"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Oct 2024 08:15:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t54yx-000amW-1g;
	Sun, 27 Oct 2024 15:15:07 +0000
Date: Sun, 27 Oct 2024 23:14:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/multiple-platform-profile-handlers-v2 13/15]
 drivers/acpi/platform_profile.c:209:29: error: incompatible integer to
 pointer conversion passing 'unsigned long' to parameter of type 'const
 unsigned long *'; take the address with &
Message-ID: <202410272314.4WjSxBUJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/multiple-platform-profile-handlers-v2
head:   cca7df72a75a655ad552ae621054784b4a41c9ac
commit: e336433fe10fc421aeece46f2d67647e0c91931b [13/15] ACPI: platform_profile: Check all profile handler to calculate next
config: x86_64-buildonly-randconfig-001-20241027 (https://download.01.org/0day-ci/archive/20241027/202410272314.4WjSxBUJ-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410272314.4WjSxBUJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410272314.4WjSxBUJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/platform_profile.c:59:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]
      59 |         int err;
         |             ^
   drivers/acpi/platform_profile.c:115:35: warning: unused variable 'handler' [-Wunused-variable]
     115 |         struct platform_profile_handler *handler;
         |                                          ^~~~~~~
>> drivers/acpi/platform_profile.c:209:29: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const unsigned long *'; take the address with & [-Wint-conversion]
     209 |                 next = find_next_bit_wrap(choices,
         |                                           ^~~~~~~
         |                                           &
   include/linux/find.h:452:55: note: passing argument to parameter 'addr' here
     452 | unsigned long find_next_bit_wrap(const unsigned long *addr,
         |                                                       ^
   2 warnings and 1 error generated.


vim +209 drivers/acpi/platform_profile.c

   192	
   193	
   194	int platform_profile_cycle(void)
   195	{
   196		enum platform_profile_option next = PLATFORM_PROFILE_LAST;
   197		struct platform_profile_handler *handler;
   198		enum platform_profile_option profile;
   199		unsigned long choices;
   200		int err;
   201	
   202		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
   203			err = platform_profile_get_active(&profile);
   204			if (err)
   205				return err;
   206	
   207			choices = platform_profile_get_choices();
   208	
 > 209			next = find_next_bit_wrap(choices,
   210						  PLATFORM_PROFILE_LAST,
   211						  profile + 1);
   212	
   213			list_for_each_entry(handler, &platform_profile_handler_list, list) {
   214				err = handler->profile_set(handler, next);
   215				if (err) {
   216					pr_err("Failed to set profile for handler %s\n", handler->name);
   217					break;
   218				}
   219			}
   220			if (err) {
   221				list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
   222					err = handler->profile_set(handler, PLATFORM_PROFILE_BALANCED);
   223					if (err)
   224						pr_err("Failed to revert profile for handler %s\n", handler->name);
   225				}
   226			}
   227		}
   228	
   229		sysfs_notify(acpi_kobj, NULL, "platform_profile");
   230	
   231		return 0;
   232	}
   233	EXPORT_SYMBOL_GPL(platform_profile_cycle);
   234	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

