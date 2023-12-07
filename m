Return-Path: <linux-pm+bounces-806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA521809160
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 20:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4B78B20BE9
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4774F890;
	Thu,  7 Dec 2023 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcmqXiTC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8989D93;
	Thu,  7 Dec 2023 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701977448; x=1733513448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQJzpPCJi2DcWLmi+tpSUDnGySOo5HoMcMdxmPpeqDs=;
  b=CcmqXiTC8Jerk1COxG9X1EsFD3q4V9+rzuJw/TmMGfOBmQU9fqVtjy5N
   bibyck4y0DG98jQtMqiQ+gR9P5Tn1k/x0JiXEu/8lWSLwkwbm2EPe2yud
   hLL1iT7rYoz5Pl+UtZpysxU+ETIiuUZyTU5tmM6hUzVtnijY3nKCILvfC
   QzabwrX1vJT3zk39hUjP2wLM3UKhLDh98S0dFQ/eV6KAjYnCZmja7g/L9
   S6yWvG5HqtFvOiZamUtv/rwBOpgFQtsVY01Y6MEa2LTsYYV9nsa1hDDUJ
   NtgXqfGE9MXb47wc79f6IYhCcpBuxwf/2J2ZkZfK+qZ517xk2vdpGQ/nd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="373791322"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="373791322"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:30:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="13216355"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 07 Dec 2023 11:30:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBK54-000Cjl-2R;
	Thu, 07 Dec 2023 19:30:42 +0000
Date: Fri, 8 Dec 2023 03:30:04 +0800
From: kernel test robot <lkp@intel.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, rafael@kernel.org,
	pavel@ucw.cz, len.brown@intel.com, peterz@infradead.org,
	mingo@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Move state information judgment outside
 task_call_func
Message-ID: <202312080347.yJvIjGb3-lkp@intel.com>
References: <20231207111634.667057-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207111634.667057-1-xiaolei.wang@windriver.com>

Hi Xiaolei,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc4 next-20231207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaolei-Wang/freezer-sched-Move-state-information-judgment-outside-task_call_func/20231207-191924
base:   linus/master
patch link:    https://lore.kernel.org/r/20231207111634.667057-1-xiaolei.wang%40windriver.com
patch subject: [PATCH] freezer,sched: Move state information judgment outside task_call_func
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231208/202312080347.yJvIjGb3-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080347.yJvIjGb3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080347.yJvIjGb3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/freezer.c:125:30: error: no member named 'lockdep_depth' in 'struct task_struct'
           p_check->lockdep_depth = p->lockdep_depth;
                                    ~  ^
   1 error generated.


vim +125 kernel/freezer.c

   107	
   108	static int __set_task_frozen(struct task_struct *p, void *arg)
   109	{
   110		unsigned int state = READ_ONCE(p->__state);
   111		struct task_freeze_check *p_check = arg;
   112	
   113		if (p->on_rq)
   114			return 0;
   115	
   116		if (p != current && task_curr(p))
   117			return 0;
   118	
   119		if (!(state & (TASK_FREEZABLE | __TASK_STOPPED | __TASK_TRACED)))
   120			return 0;
   121	
   122		p->saved_state = p->__state;
   123		WRITE_ONCE(p->__state, TASK_FROZEN);
   124		p_check->state = p->__state;
 > 125		p_check->lockdep_depth = p->lockdep_depth;
   126		return TASK_FROZEN;
   127	}
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

