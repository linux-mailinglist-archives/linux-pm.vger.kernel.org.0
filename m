Return-Path: <linux-pm+bounces-32355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6437CB253DC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 21:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D175A3483
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645EC2F998A;
	Wed, 13 Aug 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azUyOwJv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6612F9982;
	Wed, 13 Aug 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112948; cv=none; b=CfPebo0nb73AH74NZO4JNgRdICT/+rKb6J7f0f6v8rbgmwOiyAcOufE8zONiD/2ganVbF0LMe033uKHbXTCWslLMPlfCHnv5lwDCDxdnvQJ62p8rCf7u2wccWiA9AsCtvGvCiB/xiRALuLKuI7K3m/lLgKk6Rlqwsgn7/P0Vs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112948; c=relaxed/simple;
	bh=9ZM/5E8yCMd71ZNUu0AdWblXsP6yCelsV4CbJofMFuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK7LW/V9if0RvPm21EhRWlJUfvN9+P16md5CM/wi8XthX6PJylDUbvFDuEHMc3qmDhl5jblrxjGA8GZbX6jSSs9ocBvIvcmskBcVc5pU838ly6S+c6XVBFuzZHsp2FvpTp+lIIFv6J7UWi+1FkMuShVoTjClPd/j6pXN4ccujEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azUyOwJv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755112947; x=1786648947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ZM/5E8yCMd71ZNUu0AdWblXsP6yCelsV4CbJofMFuA=;
  b=azUyOwJvt9veH7HU5uqMhzHsoVoMwjx7gd2iJC96GR1B3hNzs2TeFT/c
   PFm2GIGIDnSUcJVKOuK2kBumlq2TEUlLutAGASuUJVNQ5wU13gN8ZpsX9
   sepe2Y0JQ7+HwZArMWLq7TQ6q+Wl/jLBGc1BWOqXmxuQffczMy5tPQ4Cf
   QmB/xtALapWZqIl4G7CFepfcGp7P9Fz++oBLZvhE7rVSLxtqv99sL5/SU
   07zXi5LrycKTj7hEjrvtLnwVfCDcLUZ0aeHmkYz+Byh0GUCa0MO6VFSRb
   D3xGpeCt/4JakhhXCAXxfTDmDel871a2ouAzOxn72dDKPJfD6Fr6U+k1R
   A==;
X-CSE-ConnectionGUID: CQybs/jcROKz8S8/XfQl/g==
X-CSE-MsgGUID: 0e8g0lRtRvChr7ohjbZ9ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57375916"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57375916"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 12:22:26 -0700
X-CSE-ConnectionGUID: yUD8ILOkSKO9gAaok1Trlg==
X-CSE-MsgGUID: fsipxVE3QvOY/e7Td8bztw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166465259"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 13 Aug 2025 12:22:21 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umH3D-000AFM-0o;
	Wed, 13 Aug 2025 19:22:19 +0000
Date: Thu, 14 Aug 2025 03:21:52 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Wu <wusamuel@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, Samuel Wu <wusamuel@google.com>,
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: Support aborting suspend during filesystem sync
Message-ID: <202508140303.9c38ncEh-lkp@intel.com>
References: <20250812232126.1814253-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812232126.1814253-1-wusamuel@google.com>

Hi Samuel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.17-rc1 next-20250813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Wu/PM-Support-aborting-suspend-during-filesystem-sync/20250813-072435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250812232126.1814253-1-wusamuel%40google.com
patch subject: [PATCH v1] PM: Support aborting suspend during filesystem sync
config: arm64-randconfig-r132-20250813 (https://download.01.org/0day-ci/archive/20250814/202508140303.9c38ncEh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250814/202508140303.9c38ncEh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508140303.9c38ncEh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/power/suspend.c:79:1: sparse: sparse: symbol 'suspend_fs_sync_lock' was not declared. Should it be static?
>> kernel/power/suspend.c:80:1: sparse: sparse: symbol 'suspend_fs_sync_complete' was not declared. Should it be static?
   kernel/power/suspend.c:104:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] @@
   kernel/power/suspend.c:104:54: sparse:     expected int val
   kernel/power/suspend.c:104:54: sparse:     got restricted suspend_state_t [usertype]
   kernel/power/suspend.c:141:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] @@
   kernel/power/suspend.c:141:54: sparse:     expected int val
   kernel/power/suspend.c:141:54: sparse:     got restricted suspend_state_t [usertype]
   kernel/power/suspend.c:202:19: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:202:47: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:203:19: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:203:51: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:208:26: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:208:65: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:215:42: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:215:51: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:216:38: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:217:51: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:215:72: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:240:34: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:240:73: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:241:27: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:241:59: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:246:34: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:246:69: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:247:21: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:247:42: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:537:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:537:33: sparse:     expected int val
   kernel/power/suspend.c:537:33: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:540:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:540:33: sparse:     expected int val
   kernel/power/suspend.c:540:33: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:610:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:610:57: sparse:     expected int val
   kernel/power/suspend.c:610:57: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:612:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:612:57: sparse:     expected int val
   kernel/power/suspend.c:612:57: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:650:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:650:52: sparse:     expected int val
   kernel/power/suspend.c:650:52: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:675:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:675:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:684:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:684:52: sparse:     expected int val
   kernel/power/suspend.c:684:52: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:685:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:685:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:708:13: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:708:22: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:708:39: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:708:48: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:711:9: sparse: sparse: restricted suspend_state_t degrades to integer

vim +/suspend_fs_sync_lock +79 kernel/power/suspend.c

    77	
    78	static bool suspend_fs_sync_queued;
  > 79	DEFINE_SPINLOCK(suspend_fs_sync_lock);
  > 80	DECLARE_COMPLETION(suspend_fs_sync_complete);
    81	void suspend_abort_fs_sync(void)
    82	{
    83		spin_lock(&suspend_fs_sync_lock);
    84		complete(&suspend_fs_sync_complete);
    85		spin_unlock(&suspend_fs_sync_lock);
    86	}
    87	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

