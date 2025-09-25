Return-Path: <linux-pm+bounces-35383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F730BA0589
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA3516A08A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE8D2E3B0D;
	Thu, 25 Sep 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQfeGkGi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F6270EA3
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814288; cv=none; b=O7f/q78ttKJ0h9oONfgcbKDA6iBNqwsaVaZOVjw9miLvud7UuE23s5BGMGyohLyZ7WzjKl54lmU3yWXLRkFzauvM4qXQ06QnWlka3Db1QEsvIRbIEfiCOTWoRB4FeorevW1iGRYLlTBKkHgV5QK2J0a9S+XfhNkHgUhU3ORmCX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814288; c=relaxed/simple;
	bh=JnZFUklpcUUd7vma9QDHXmuHxHggkDvopDY+JB7yBGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsHwD88bPdtxkzLOoxW3xtc4YLcqTmfLC1Pe5a6JyRo+9hPB2W9ulhlAieV3rxWy9HASHMqN+ozVg/5s7+OJ5FKZCLk81sx1ZKM+8J1wjy80yPqZKtEZCevjE2215Wu0HKyxsUAnfjQmtT7rl24z+SKfqG5MyNADglFfMvzLTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQfeGkGi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758814287; x=1790350287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JnZFUklpcUUd7vma9QDHXmuHxHggkDvopDY+JB7yBGk=;
  b=cQfeGkGi3IyOy7oIgTc/hndzAWwGQscxYmBuFu6veJEVLDu9aqRJ4eCf
   HkS8U1I2jmuRDxWej91WK3Y0684SYp+rVNzaOY7dAr/msxkVsx1tx08sZ
   f/TlkNw9hZOLF+5hXQF4N0ujbIOTN9RpPuDc1lr0G9KTrOzzKCCp2WBxu
   B3A5iRm3NkzQ/lwnUq+9c3uYY39NYqTdhuoU0Fijf1Bia8chmNjXhZ3Rm
   72sEq4gmc5p+Ti3Mdo9RYJHhRr037aK3bMvirR+/KEj/ShVuwfu1/fEtt
   SZ5uihGqdyKALvxt5iZPo7d2VEPGsb4qH3oZeU40K/NSzURNZRBxECoZq
   g==;
X-CSE-ConnectionGUID: sOdCthVsQg2qzJjfxZKFkg==
X-CSE-MsgGUID: 2YjRzP2wRa2Ouf+VA/5rFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="78572496"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="78572496"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:31:27 -0700
X-CSE-ConnectionGUID: rwxYC4quQiaj7tiM5osL6A==
X-CSE-MsgGUID: nK+V9+GJRQC52LoK+4eRvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="214492461"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Sep 2025 08:31:25 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1nwC-0005Ld-1h;
	Thu, 25 Sep 2025 15:31:18 +0000
Date: Thu, 25 Sep 2025 23:30:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
	"(open list:HIBERNATION (aka Software Suspend, aka swsusp))" <linux-pm@vger.kernel.org>,
	"aka swsusp)), Mario Limonciello" <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [PATCH 1/3] PM: hibernate: Fix hybrid-sleep
Message-ID: <202509252323.KEdz98a4-lkp@intel.com>
References: <20250924205211.1059571-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924205211.1059571-2-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on amd-pstate/linux-next]
[also build test ERROR on amd-pstate/bleeding-edge linus/master v6.17-rc7 next-20250924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello-AMD/PM-hibernate-Fix-hybrid-sleep/20250925-045432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20250924205211.1059571-2-superm1%40kernel.org
patch subject: [PATCH 1/3] PM: hibernate: Fix hybrid-sleep
config: i386-randconfig-014-20250925 (https://download.01.org/0day-ci/archive/20250925/202509252323.KEdz98a4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509252323.KEdz98a4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509252323.KEdz98a4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/power/hibernate.c:866:27: error: use of undeclared identifier 'HIBERNATION_SUSPEND'
     866 |                 if (hibernation_mode != HIBERNATION_SUSPEND)
         |                                         ^
   1 error generated.


vim +/HIBERNATION_SUSPEND +866 kernel/power/hibernate.c

   776	
   777	/**
   778	 * hibernate - Carry out system hibernation, including saving the image.
   779	 */
   780	int hibernate(void)
   781	{
   782		bool snapshot_test = false;
   783		unsigned int sleep_flags;
   784		int error;
   785	
   786		if (!hibernation_available()) {
   787			pm_pr_dbg("Hibernation not available.\n");
   788			return -EPERM;
   789		}
   790	
   791		/*
   792		 * Query for the compression algorithm support if compression is enabled.
   793		 */
   794		if (!nocompress) {
   795			strscpy(hib_comp_algo, hibernate_compressor);
   796			if (!crypto_has_acomp(hib_comp_algo, 0, CRYPTO_ALG_ASYNC)) {
   797				pr_err("%s compression is not available\n", hib_comp_algo);
   798				return -EOPNOTSUPP;
   799			}
   800		}
   801	
   802		sleep_flags = lock_system_sleep();
   803		/* The snapshot device should not be opened while we're running */
   804		if (!hibernate_acquire()) {
   805			error = -EBUSY;
   806			goto Unlock;
   807		}
   808	
   809		pr_info("hibernation entry\n");
   810		pm_prepare_console();
   811		error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
   812		if (error)
   813			goto Restore;
   814	
   815		ksys_sync_helper();
   816		if (filesystem_freeze_enabled)
   817			filesystems_freeze();
   818	
   819		error = freeze_processes();
   820		if (error)
   821			goto Exit;
   822	
   823		lock_device_hotplug();
   824		/* Allocate memory management structures */
   825		error = create_basic_memory_bitmaps();
   826		if (error)
   827			goto Thaw;
   828	
   829		error = hibernation_snapshot(hibernation_mode == HIBERNATION_PLATFORM);
   830		if (error || freezer_test_done)
   831			goto Free_bitmaps;
   832	
   833		if (in_suspend) {
   834			unsigned int flags = 0;
   835	
   836			if (hibernation_mode == HIBERNATION_PLATFORM)
   837				flags |= SF_PLATFORM_MODE;
   838			if (nocompress) {
   839				flags |= SF_NOCOMPRESS_MODE;
   840			} else {
   841			        flags |= SF_CRC32_MODE;
   842	
   843				/*
   844				 * By default, LZO compression is enabled. Use SF_COMPRESSION_ALG_LZ4
   845				 * to override this behaviour and use LZ4.
   846				 *
   847				 * Refer kernel/power/power.h for more details
   848				 */
   849	
   850				if (!strcmp(hib_comp_algo, COMPRESSION_ALGO_LZ4))
   851					flags |= SF_COMPRESSION_ALG_LZ4;
   852				else
   853					flags |= SF_COMPRESSION_ALG_LZO;
   854			}
   855	
   856			pm_pr_dbg("Writing hibernation image.\n");
   857			error = swsusp_write(flags);
   858			swsusp_free();
   859			if (!error) {
   860				if (hibernation_mode == HIBERNATION_TEST_RESUME)
   861					snapshot_test = true;
   862				else
   863					power_down();
   864			}
   865			in_suspend = 0;
 > 866			if (hibernation_mode != HIBERNATION_SUSPEND)
   867				pm_restore_gfp_mask();
   868		} else {
   869			pm_pr_dbg("Hibernation image restored successfully.\n");
   870		}
   871	
   872	 Free_bitmaps:
   873		free_basic_memory_bitmaps();
   874	 Thaw:
   875		unlock_device_hotplug();
   876		if (snapshot_test) {
   877			pm_pr_dbg("Checking hibernation image\n");
   878			error = swsusp_check(false);
   879			if (!error)
   880				error = load_image_and_restore();
   881		}
   882		thaw_processes();
   883	
   884		/* Don't bother checking whether freezer_test_done is true */
   885		freezer_test_done = false;
   886	 Exit:
   887		filesystems_thaw();
   888		pm_notifier_call_chain(PM_POST_HIBERNATION);
   889	 Restore:
   890		pm_restore_console();
   891		hibernate_release();
   892	 Unlock:
   893		unlock_system_sleep(sleep_flags);
   894		pr_info("hibernation exit\n");
   895	
   896		return error;
   897	}
   898	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

