Return-Path: <linux-pm+bounces-26913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A658AB0D15
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 10:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B178B9E08C4
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA273270559;
	Fri,  9 May 2025 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M11fC+79"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504452741A2
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778969; cv=none; b=rOaWT+REYXMJz8Fc7GR5CDNYyJT9W6GYrIx9pEQhpLGmusTNQRCmyKhN+Z9LLTd5E1z7G03YIZ2+/RMWVrRbfBNv8t3RMLCSVtL/V6fci3qUEF2ut8vnKiMCpCDODM/+XmObAkGF0HIHQM6TRcAR5aibwdEGxY+e1Syp+9kTgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778969; c=relaxed/simple;
	bh=J2TFGJagph/ta7MoJmHwiVacD4SN5gx283HD/y3mKqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APHReLLpmlWJ2eYdMrr1Xff/V91ZSv+48pxX1fdXRsX93ptza6ovqOB8ZgXDbdqjjGaNWxmgt+Xi4Xj7+JXkBWXuTvAtCq7WR59+6rFLFZXssp4+T+20DO6bhjDWkyvCn4O5qddsPT/IIdpTtO04ZNOEYmO9Bw8T1gFdQnRbPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M11fC+79; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746778967; x=1778314967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J2TFGJagph/ta7MoJmHwiVacD4SN5gx283HD/y3mKqY=;
  b=M11fC+790rn+MCXCCwUq0Q1yMt64ncp8Eq0FmxIHwRi1KzcMAw5785+X
   cVKwAvjR02kmEnUpthVc6Ab1YRx5DVedgnTI1A/JnY36raauZeXlJ2WZY
   Rqd9cLiEUmmUP3Rqkc9x6+KDOexAsuCPC8y7sbdQyhTpYOCvGWdp/oO1F
   j/P/i4Tt2KWDIKVov8Nxl3W1MFE+ImqTmGJgh0hfxSd7L/Bkb86EeD4QT
   ePwmkJcJP6FrlrBPvWHplNfXg7u2xEqGG6jLOy8TKSsHV3t7DKyJ0TH98
   W5wmSk0AsvRqDS2VDjdNUsy7S414djZxejjUts5/g/mvVk0X6/6nd5tcQ
   Q==;
X-CSE-ConnectionGUID: FY9L64gqRh2jjtlsgVb+NQ==
X-CSE-MsgGUID: AQM68sRvQM+gBTKYVYJ95w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48712603"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48712603"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:22:46 -0700
X-CSE-ConnectionGUID: NVHTGny5TAiqKijxBMtofQ==
X-CSE-MsgGUID: zejCw9eqRNapVYavtfyugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136439359"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 May 2025 01:22:45 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDJ0E-000Bod-0p;
	Fri, 09 May 2025 08:22:42 +0000
Date: Fri, 9 May 2025 16:22:07 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
	rafael@kernel.org, pavel@kernel.org, len.brown@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM: hibernate: Explicitly set `PM_SUSPEND_MAX` at
 hibernate entry
Message-ID: <202505091658.9UZSCXpa-lkp@intel.com>
References: <20250508211822.2698678-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508211822.2698678-1-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on amd-pstate/linux-next]
[also build test ERROR on amd-pstate/bleeding-edge linus/master v6.15-rc5 next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PM-hibernate-Explicitly-set-PM_SUSPEND_MAX-at-hibernate-entry/20250509-051901
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20250508211822.2698678-1-superm1%40kernel.org
patch subject: [PATCH v2] PM: hibernate: Explicitly set `PM_SUSPEND_MAX` at hibernate entry
config: i386-buildonly-randconfig-004-20250509 (https://download.01.org/0day-ci/archive/20250509/202505091658.9UZSCXpa-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505091658.9UZSCXpa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505091658.9UZSCXpa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/power/main.c:23:17: error: expected ')'
      23 | suspend_state_t pm_suspend_target_state;
         |                 ^
   include/linux/suspend.h:148:34: note: expanded from macro 'pm_suspend_target_state'
     148 | #define pm_suspend_target_state (PM_SUSPEND_ON)
         |                                  ^
   include/linux/suspend.h:36:51: note: expanded from macro 'PM_SUSPEND_ON'
      36 | #define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
         |                                                            ^
   kernel/power/main.c:23:17: note: to match this '('
   include/linux/suspend.h:148:34: note: expanded from macro 'pm_suspend_target_state'
     148 | #define pm_suspend_target_state (PM_SUSPEND_ON)
         |                                  ^
   include/linux/suspend.h:36:24: note: expanded from macro 'PM_SUSPEND_ON'
      36 | #define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
         |                                 ^
>> kernel/power/main.c:23:17: error: redefinition of 'suspend_state_t' as different kind of symbol
      23 | suspend_state_t pm_suspend_target_state;
         |                 ^
   include/linux/suspend.h:148:34: note: expanded from macro 'pm_suspend_target_state'
     148 | #define pm_suspend_target_state (PM_SUSPEND_ON)
         |                                  ^
   include/linux/suspend.h:36:34: note: expanded from macro 'PM_SUSPEND_ON'
      36 | #define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
         |                                           ^
   include/linux/suspend.h:34:23: note: previous definition is here
      34 | typedef int __bitwise suspend_state_t;
         |                       ^
   kernel/power/main.c:24:19: error: expected ')'
      24 | EXPORT_SYMBOL_GPL(pm_suspend_target_state);
         |                   ^
   include/linux/suspend.h:148:34: note: expanded from macro 'pm_suspend_target_state'
     148 | #define pm_suspend_target_state (PM_SUSPEND_ON)
         |                                  ^
   include/linux/suspend.h:36:51: note: expanded from macro 'PM_SUSPEND_ON'
      36 | #define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
         |                                                            ^
   kernel/power/main.c:24:19: note: to match this '('
   include/linux/suspend.h:148:34: note: expanded from macro 'pm_suspend_target_state'
     148 | #define pm_suspend_target_state (PM_SUSPEND_ON)
         |                                  ^
   include/linux/suspend.h:36:24: note: expanded from macro 'PM_SUSPEND_ON'
      36 | #define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
         |                                 ^
   kernel/power/main.c:24:19: error: redefinition of 'suspend_state_t' as different kind of symbol
      24 | EXPORT_SYMBOL_GPL(pm_suspend_target_state);
         |                   ^
   include/linux/suspend.h:148:34: note: expanded from macro 'pm_suspend_target_state'
     148 | #define pm_suspend_target_state (PM_SUSPEND_ON)
         |                                  ^
   include/linux/suspend.h:36:34: note: expanded from macro 'PM_SUSPEND_ON'
      36 | #define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
         |                                           ^
   include/linux/suspend.h:34:23: note: previous definition is here
      34 | typedef int __bitwise suspend_state_t;
         |                       ^
>> kernel/power/main.c:24:1: error: pasting formed '__addressable_(', an invalid preprocessing token
      24 | EXPORT_SYMBOL_GPL(pm_suspend_target_state);
         | ^
   include/linux/export.h:84:33: note: expanded from macro 'EXPORT_SYMBOL_GPL'
      84 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^
   include/linux/export.h:80:38: note: expanded from macro '_EXPORT_SYMBOL'
      80 | #define _EXPORT_SYMBOL(sym, license)    __EXPORT_SYMBOL(sym, license, "")
         |                                         ^
   include/linux/export.h:71:2: note: expanded from macro '__EXPORT_SYMBOL'
      71 |         __ADDRESSABLE(sym)                                      \
         |         ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:286:14: note: expanded from macro '___ADDRESSABLE'
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |                     ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:24: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                        ^
   kernel/power/main.c:24:19: error: expected ')'
      24 | EXPORT_SYMBOL_GPL(pm_suspend_target_state);
         |                   ^
   include/linux/suspend.h:148:34: note: expanded from macro 'pm_suspend_target_state'
     148 | #define pm_suspend_target_state (PM_SUSPEND_ON)
         |                                  ^
   include/linux/suspend.h:36:51: note: expanded from macro 'PM_SUSPEND_ON'
      36 | #define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
         |                                                            ^
   kernel/power/main.c:24:19: note: to match this '('
   include/linux/suspend.h:148:34: note: expanded from macro 'pm_suspend_target_state'
     148 | #define pm_suspend_target_state (PM_SUSPEND_ON)
         |                                  ^
   include/linux/suspend.h:36:24: note: expanded from macro 'PM_SUSPEND_ON'
      36 | #define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
         |                                 ^
>> kernel/power/main.c:24:1: error: pasting formed ')417', an invalid preprocessing token
      24 | EXPORT_SYMBOL_GPL(pm_suspend_target_state);
         | ^
   include/linux/export.h:84:33: note: expanded from macro 'EXPORT_SYMBOL_GPL'
      84 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^
   include/linux/export.h:80:38: note: expanded from macro '_EXPORT_SYMBOL'
      80 | #define _EXPORT_SYMBOL(sym, license)    __EXPORT_SYMBOL(sym, license, "")
         |                                         ^
   include/linux/export.h:71:2: note: expanded from macro '__EXPORT_SYMBOL'
      71 |         __ADDRESSABLE(sym)                                      \
         |         ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:24: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                        ^
>> kernel/power/main.c:24:19: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
      24 | EXPORT_SYMBOL_GPL(pm_suspend_target_state);
         |                   ^
   include/linux/suspend.h:148:34: note: expanded from macro 'pm_suspend_target_state'
     148 | #define pm_suspend_target_state (PM_SUSPEND_ON)
         |                                  ^
   include/linux/suspend.h:36:34: note: expanded from macro 'PM_SUSPEND_ON'
      36 | #define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
         |                                           ^
>> kernel/power/main.c:24:1: error: expected function body after function declarator
      24 | EXPORT_SYMBOL_GPL(pm_suspend_target_state);
         | ^
   include/linux/export.h:84:33: note: expanded from macro 'EXPORT_SYMBOL_GPL'
      84 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^
   include/linux/export.h:80:38: note: expanded from macro '_EXPORT_SYMBOL'
      80 | #define _EXPORT_SYMBOL(sym, license)    __EXPORT_SYMBOL(sym, license, "")
         |                                         ^
   include/linux/export.h:71:2: note: expanded from macro '__EXPORT_SYMBOL'
      71 |         __ADDRESSABLE(sym)                                      \
         |         ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:286:2: note: expanded from macro '___ADDRESSABLE'
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |         ^
   include/linux/compiler.h:166:68: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                                                    ^
   <scratch space>:210:1: note: expanded from here
     210 | 417
         | ^
>> kernel/power/main.c:24:1: error: pasting formed '__export_symbol_(', an invalid preprocessing token
   include/linux/export.h:84:33: note: expanded from macro 'EXPORT_SYMBOL_GPL'
      84 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^
   include/linux/export.h:80:38: note: expanded from macro '_EXPORT_SYMBOL'
      80 | #define _EXPORT_SYMBOL(sym, license)    __EXPORT_SYMBOL(sym, license, "")
         |                                         ^
   include/linux/export.h:73:18: note: expanded from macro '__EXPORT_SYMBOL'
      73 |         asm(__stringify(___EXPORT_SYMBOL(sym, license, ns)))
         |                         ^
   include/linux/export.h:29:18: note: expanded from macro '___EXPORT_SYMBOL'
      29 |         __export_symbol_##sym:                  ASM_NL  \
         |                         ^
   10 errors generated.


vim +23 kernel/power/main.c

    22	
  > 23	suspend_state_t pm_suspend_target_state;
  > 24	EXPORT_SYMBOL_GPL(pm_suspend_target_state);
    25	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

