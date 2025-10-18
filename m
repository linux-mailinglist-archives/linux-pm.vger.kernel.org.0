Return-Path: <linux-pm+bounces-36388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87336BED064
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9094E22C7
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC927A900;
	Sat, 18 Oct 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfENptPT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323A17A31C;
	Sat, 18 Oct 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760793632; cv=none; b=A53WUYvo0W5r2n5jImzUk66kmR9ZBr12uvCsJLD5xC1K0skfqh7raYQ5/9xjlSWplZQIIQh3MIRuU8HESratHu3g3pzVELQDVVDfj5HyeSq/fe+VvvcuZcLKAtfBZtWM40IblQqFiwsDJX/3jdLm5aICJLRgQxpskE3lP5JakO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760793632; c=relaxed/simple;
	bh=4h5qMKzR7GKLn8DUw5HPEhwvsGZS8JdHYq+ypNidyKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+yvhlgK1TaJuvhD2h7jcYRJqshTpMQf6dkYOc69pgB63wntFupTg0cb8P5BjqmCB/h6TGFIOzKMiFZw3LXH6weRPo3yAbQw3dtNmhYhfiYSjrpfcUgi9kK40zfklwQC7iCr8IP7NaTYvr/DkUuW2gPKYOJbr1YfPKg4V8MfwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfENptPT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760793631; x=1792329631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4h5qMKzR7GKLn8DUw5HPEhwvsGZS8JdHYq+ypNidyKo=;
  b=WfENptPT//UnrgxePgRHX+TqLIJpJwKrMm7Rm+dflosP8v1o+bMKugIB
   NqIGcQBwKNxfyYtzAEGZLDBKlPsANGqXuWM1gYQwpZNw+JhDK/qHljCXo
   iMGq9LaqwhhB5aw7+RPQZWMla6/4Pw9u8rIvYt/31K3PWd/2EkFOPXJlW
   DJb5eSIHExUBPP1OM5tJyfxcMcLfTKkAEl8j4+/bsLtJXoT1xrl64pREp
   pDgn4FBjZhjOKGGIFKMvCc675yKBIbzLd/Fd64Wb9M8sIdzQjAeHzIb21
   rOGxcDh5Fnm8onA5AZFKSlNb4dckRaGSPhsEOUV9RkdmG8McPZq1+ktOo
   w==;
X-CSE-ConnectionGUID: DRyV1h0+QraHsxmYuy1ozA==
X-CSE-MsgGUID: VlzOLnmjQwyYg+bPf+Z8Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63080034"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="63080034"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 06:20:30 -0700
X-CSE-ConnectionGUID: Gyv/mZwfRTefgpi1HOkP/A==
X-CSE-MsgGUID: QZlBs95XQMGaadl3hDJ5vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="188260456"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 18 Oct 2025 06:20:27 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vA6qx-0008Ib-2P;
	Sat, 18 Oct 2025 13:20:12 +0000
Date: Sat, 18 Oct 2025 21:19:20 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Wu <wusamuel@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, tuhaowen@uniontech.com,
	Samuel Wu <wusamuel@google.com>,
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
Message-ID: <202510182014.I0BvTZvE-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20251018 (https://download.01.org/0day-ci/archive/20251018/202510182014.I0BvTZvE-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510182014.I0BvTZvE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510182014.I0BvTZvE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
>> include/linux/suspend.h:510:15: error: return type defaults to 'int' [-Wimplicit-int]
     510 | static inline pm_stop_waiting_for_fs_sync(void) {}
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/suspend.h: In function 'pm_sleep_fs_sync':
>> include/linux/suspend.h:511:1: warning: no return statement in function returning non-void [-Wreturn-type]
     511 | static inline int pm_sleep_fs_sync(void) {}
         | ^~~~~~
   make[3]: *** [scripts/Makefile.build:182: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=496665200
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1280: prepare0] Error 2 shuffle=496665200
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=496665200
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=496665200
   make: Target 'prepare' not remade because of errors.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [y]:
   - MFD_SPACEMIT_P1 [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]


vim +/int +510 include/linux/suspend.h

   508	
   509	static inline void ksys_sync_helper(void) {}
 > 510	static inline pm_stop_waiting_for_fs_sync(void) {}
 > 511	static inline int pm_sleep_fs_sync(void) {}
   512	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

