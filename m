Return-Path: <linux-pm+bounces-26776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E1AAD918
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 09:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA29A09F5
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1A9224258;
	Wed,  7 May 2025 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6QpABJK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A6223DE7
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603907; cv=none; b=n1C7rACUJxZ75HLjVWq2rXlWhkcKa3sQkvGXFzFXPjTzF/Gx6r5wzvLzk40WIwahBILdIOF6mXwoVvU+FqvskuS6WbKc42SCs/FxK5Uye96cVmYiaQUsTYiRaBJZpQgtGXm8aKWZ5aU8EPsBuhn5SdWzsMIFoXzNP4x8shA+R5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603907; c=relaxed/simple;
	bh=i3iNoejldEwfu1pudT27J8wiNZ81ZODfSVYRzrrKNjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKVvSIx386tK1l46eYk8XzXDP4vNMNeBFeY3wA7aZn3IPPwD0gGGQCnTsJdVqkFIW90trVmG84HsWGr1+vsxZFUpWXQ82XANKBalBwlk0BuwnXY9OMBLnOVrfMFh/AvwdNbJr2ikHn+E0OU+E6iNmnNVAzHadNZOLAm61dw6q3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6QpABJK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746603906; x=1778139906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i3iNoejldEwfu1pudT27J8wiNZ81ZODfSVYRzrrKNjg=;
  b=W6QpABJKDToV/b3mcrNm9QEkK4zuK3nxtyCkB9GpsigHnkcOdtJiZ/oe
   1+yIsSIqr/XBL/CAtjURO2bbyaBWdXgHyqfH0Ey2bdqXzcLiSGkVYXn8F
   r9I5kspkDJzzML0Ls8OMBf5qP+FIpu4sIM1JaDW5w07RudsOWInn3cRKG
   0BLViWDrglr60BTfLDkGiJwbUn8afJtVomTiqudmvYaWGIB2ldTDySMyn
   yEs45hJnYflahDDOSlbCa3XBO0hJBen20+Iokg6gieD1h0pSyv5xTJiK0
   TsiBUYVrXjIKR/3VySrwbxwk77Fk3mjbTQY46rTvQEAQlAjsA4XKll42A
   w==;
X-CSE-ConnectionGUID: koTFWPavRC2baLIoKHlo6A==
X-CSE-MsgGUID: 1V90AYHET46R08CIs4M+Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52133198"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="52133198"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:45:03 -0700
X-CSE-ConnectionGUID: wbFxOg/ZReaIggV/UXRZwg==
X-CSE-MsgGUID: FGKt83fsS+24ZPRJt8PinQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="135875088"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2025 00:44:52 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCZST-0007LP-3C;
	Wed, 07 May 2025 07:44:49 +0000
Date: Wed, 7 May 2025 15:44:27 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
	rafael@kernel.org, len.brown@intel.com, pavel@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: Explicitly set PM_SUSPEND_MAX at
 hibernate entry
Message-ID: <202505071516.juQNugSC-lkp@intel.com>
References: <20250501215838.2501827-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501215838.2501827-1-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on amd-pstate/linux-next]
[also build test ERROR on amd-pstate/bleeding-edge linus/master v6.15-rc5 next-20250506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PM-hibernate-Explicitly-set-PM_SUSPEND_MAX-at-hibernate-entry/20250502-060011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20250501215838.2501827-1-superm1%40kernel.org
patch subject: [PATCH] PM: hibernate: Explicitly set PM_SUSPEND_MAX at hibernate entry
config: x86_64-randconfig-071-20250502 (https://download.01.org/0day-ci/archive/20250507/202505071516.juQNugSC-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071516.juQNugSC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071516.juQNugSC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/power/hibernate.c:775:26: error: expression is not assignable
     775 |         pm_suspend_target_state = PM_SUSPEND_MAX;
         |         ~~~~~~~~~~~~~~~~~~~~~~~ ^
   kernel/power/hibernate.c:856:26: error: expression is not assignable
     856 |         pm_suspend_target_state = PM_SUSPEND_ON;
         |         ~~~~~~~~~~~~~~~~~~~~~~~ ^
   2 errors generated.


vim +775 kernel/power/hibernate.c

   741	
   742	/**
   743	 * hibernate - Carry out system hibernation, including saving the image.
   744	 */
   745	int hibernate(void)
   746	{
   747		bool snapshot_test = false;
   748		unsigned int sleep_flags;
   749		int error;
   750	
   751		if (!hibernation_available()) {
   752			pm_pr_dbg("Hibernation not available.\n");
   753			return -EPERM;
   754		}
   755	
   756		/*
   757		 * Query for the compression algorithm support if compression is enabled.
   758		 */
   759		if (!nocompress) {
   760			strscpy(hib_comp_algo, hibernate_compressor, sizeof(hib_comp_algo));
   761			if (!crypto_has_acomp(hib_comp_algo, 0, CRYPTO_ALG_ASYNC)) {
   762				pr_err("%s compression is not available\n", hib_comp_algo);
   763				return -EOPNOTSUPP;
   764			}
   765		}
   766	
   767		sleep_flags = lock_system_sleep();
   768		/* The snapshot device should not be opened while we're running */
   769		if (!hibernate_acquire()) {
   770			error = -EBUSY;
   771			goto Unlock;
   772		}
   773	
   774		pr_info("hibernation entry\n");
 > 775		pm_suspend_target_state = PM_SUSPEND_MAX;
   776		pm_prepare_console();
   777		error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
   778		if (error)
   779			goto Restore;
   780	
   781		ksys_sync_helper();
   782	
   783		error = freeze_processes();
   784		if (error)
   785			goto Exit;
   786	
   787		lock_device_hotplug();
   788		/* Allocate memory management structures */
   789		error = create_basic_memory_bitmaps();
   790		if (error)
   791			goto Thaw;
   792	
   793		error = hibernation_snapshot(hibernation_mode == HIBERNATION_PLATFORM);
   794		if (error || freezer_test_done)
   795			goto Free_bitmaps;
   796	
   797		if (in_suspend) {
   798			unsigned int flags = 0;
   799	
   800			if (hibernation_mode == HIBERNATION_PLATFORM)
   801				flags |= SF_PLATFORM_MODE;
   802			if (nocompress) {
   803				flags |= SF_NOCOMPRESS_MODE;
   804			} else {
   805			        flags |= SF_CRC32_MODE;
   806	
   807				/*
   808				 * By default, LZO compression is enabled. Use SF_COMPRESSION_ALG_LZ4
   809				 * to override this behaviour and use LZ4.
   810				 *
   811				 * Refer kernel/power/power.h for more details
   812				 */
   813	
   814				if (!strcmp(hib_comp_algo, COMPRESSION_ALGO_LZ4))
   815					flags |= SF_COMPRESSION_ALG_LZ4;
   816				else
   817					flags |= SF_COMPRESSION_ALG_LZO;
   818			}
   819	
   820			pm_pr_dbg("Writing hibernation image.\n");
   821			error = swsusp_write(flags);
   822			swsusp_free();
   823			if (!error) {
   824				if (hibernation_mode == HIBERNATION_TEST_RESUME)
   825					snapshot_test = true;
   826				else
   827					power_down();
   828			}
   829			in_suspend = 0;
   830			pm_restore_gfp_mask();
   831		} else {
   832			pm_pr_dbg("Hibernation image restored successfully.\n");
   833		}
   834	
   835	 Free_bitmaps:
   836		free_basic_memory_bitmaps();
   837	 Thaw:
   838		unlock_device_hotplug();
   839		if (snapshot_test) {
   840			pm_pr_dbg("Checking hibernation image\n");
   841			error = swsusp_check(false);
   842			if (!error)
   843				error = load_image_and_restore();
   844		}
   845		thaw_processes();
   846	
   847		/* Don't bother checking whether freezer_test_done is true */
   848		freezer_test_done = false;
   849	 Exit:
   850		pm_notifier_call_chain(PM_POST_HIBERNATION);
   851	 Restore:
   852		pm_restore_console();
   853		hibernate_release();
   854	 Unlock:
   855		unlock_system_sleep(sleep_flags);
   856		pm_suspend_target_state = PM_SUSPEND_ON;
   857		pr_info("hibernation exit\n");
   858	
   859		return error;
   860	}
   861	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

