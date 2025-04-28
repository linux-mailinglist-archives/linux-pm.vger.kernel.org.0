Return-Path: <linux-pm+bounces-26351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202D9A9FEE7
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 03:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049C1467ABD
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 01:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F213B58B;
	Tue, 29 Apr 2025 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImVVA5Sv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF6433C4;
	Tue, 29 Apr 2025 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889573; cv=none; b=Fk5fFQ7HWHuWMajNqJpN9X7sRYMPPSyBcciOzssY+Vsom45lWfTt19hu+xjpHHkCMmZ1qv53OoXKQ7FMDLZT5vNKY7FedZAZTZSJKtIx/+7AQkl7L7109A4doIvtn623x2yr7sGvnM1sG+W+CaZajcxDJZrbp3gEuwXWN1qbKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889573; c=relaxed/simple;
	bh=Ig6rBPtJSH8iA/rKKNMYpbEYMMPT9H1HG6g552xirrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tkf6bktgYoiYhr9O10pEVfA0SM/BBsqz/HWI4dGh2aMDsPZ7qxpDwiJYTBLqI2BTCMpJiM2cuK3gw56AhkFHL/Id5Uxr6uXYdPQUso6DYmjfURI3zY2LfTwlGS7cLLPiPVEU3BxJZQmQPYpoQvYsv7CsMwA0gzikWQHuuX62fSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImVVA5Sv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745889571; x=1777425571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ig6rBPtJSH8iA/rKKNMYpbEYMMPT9H1HG6g552xirrA=;
  b=ImVVA5Sv5N0kyH5bSrwsggC89PycUww573KFtopDbDXm5FR3WahWWP/b
   4O5PP1bN/App8JUnOnzV5KAa6VsNFyKxNmCSjauREiFqHVUFvMUGq+E3L
   0uGjuljoFQSgbe+lyDnOiQaRUMYYi9tQvs5w3zJ0st8U731zuxS5alvSF
   fUk1sK4c+hz1OMiDzannD5AfYLnZP8cUYE01s7NS6Bt0TG1GDpSYWI7Bk
   eOaPlln8d2u0qYcfJ0WG1y/6Owrodi556LxMW7jIbJUHvD3Adcl6wYj8X
   5xxcq2CB9JDzUi+2FTQ5ngpnWz8nlhopMMlTSV2/QbQJH3buww/6NdHMy
   Q==;
X-CSE-ConnectionGUID: XoBu5ceZRV6wlEDKYiQcwQ==
X-CSE-MsgGUID: 2R3bYiKKQEWTgOvoyRsTNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="72874007"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="72874007"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 18:19:30 -0700
X-CSE-ConnectionGUID: r77JBzqSTnuIYgcATmIDgQ==
X-CSE-MsgGUID: N/AslonpRyWcRq2J0NQ1WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133581475"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Apr 2025 18:19:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u9Zd7-00001g-27;
	Tue, 29 Apr 2025 01:19:25 +0000
Date: Tue, 29 Apr 2025 02:57:29 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [rft, PATCH v1 1/1] PM: Don't use "proxy" headers
Message-ID: <202504290212.e8iXOU2x-lkp@intel.com>
References: <20250428071922.3264455-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428071922.3264455-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.15-rc4 next-20250428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/PM-Don-t-use-proxy-headers/20250428-152021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250428071922.3264455-1-andriy.shevchenko%40linux.intel.com
patch subject: [rft, PATCH v1 1/1] PM: Don't use "proxy" headers
config: sh-randconfig-001-20250428 (https://download.01.org/0day-ci/archive/20250429/202504290212.e8iXOU2x-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250429/202504290212.e8iXOU2x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504290212.e8iXOU2x-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/sh/kernel/reboot.c:2:
>> include/linux/pm.h:690:18: error: field 'suspend_timer' has incomplete type
     690 |  struct hrtimer  suspend_timer;
         |                  ^~~~~~~~~~~~~
   cc1: note: unrecognized command-line option '-Wno-unterminated-string-initialization' may have been intended to silence earlier diagnostics


vim +/suspend_timer +690 include/linux/pm.h

08810a4119aaeb Rafael J. Wysocki 2017-10-25  660  
1eede070a59e1c Rafael J. Wysocki 2008-05-20  661  struct dev_pm_info {
1eede070a59e1c Rafael J. Wysocki 2008-05-20  662  	pm_message_t		power_state;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  663  	bool			can_wakeup:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  664  	bool			async_suspend:1;
9ed9895370aedd Rafael J. Wysocki 2016-10-30  665  	bool			in_dpm_list:1;	/* Owned by the PM core */
f76b168b6f117a Alan Stern        2011-06-18  666  	bool			is_prepared:1;	/* Owned by the PM core */
6d0e0e84f66d32 Alan Stern        2011-06-18  667  	bool			is_suspended:1;	/* Ditto */
3d2699bc179a10 Liu, Chuansheng   2014-02-18  668  	bool			is_noirq_suspended:1;
3d2699bc179a10 Liu, Chuansheng   2014-02-18  669  	bool			is_late_suspended:1;
85945c28b5a888 Sudeep Holla      2019-02-14  670  	bool			no_pm:1;
bed2b42d9f0b41 Rafael J. Wysocki 2012-08-06  671  	bool			early_init:1;	/* Owned by the PM core */
aae4518b3124b2 Rafael J. Wysocki 2014-05-16  672  	bool			direct_complete:1;	/* Owned by the PM core */
08810a4119aaeb Rafael J. Wysocki 2017-10-25  673  	u32			driver_flags;
074037ec79bea7 Rafael J. Wysocki 2010-09-22  674  	spinlock_t		lock;
1eede070a59e1c Rafael J. Wysocki 2008-05-20  675  #ifdef CONFIG_PM_SLEEP
1eede070a59e1c Rafael J. Wysocki 2008-05-20  676  	struct list_head	entry;
5af84b82701a96 Rafael J. Wysocki 2010-01-23  677  	struct completion	completion;
074037ec79bea7 Rafael J. Wysocki 2010-09-22  678  	struct wakeup_source	*wakeup;
4ca46ff3e0d8c2 Rafael J. Wysocki 2011-10-16  679  	bool			wakeup_path:1;
feb70af0e3ac68 Rafael J. Wysocki 2012-08-13  680  	bool			syscore:1;
aa8e54b559479d Tomeu Vizoso      2016-01-07  681  	bool			no_pm_callbacks:1;	/* Owned by the PM core */
3038b22bc09856 Rafael J. Wysocki 2025-02-25  682  	bool			work_in_progress:1;	/* Owned by the PM core */
bca84a7b93fdc7 Rafael J. Wysocki 2025-02-18  683  	bool			smart_suspend:1;	/* Owned by the PM core */
b017500ab53c06 Rafael J. Wysocki 2024-01-22  684  	bool			must_resume:1;		/* Owned by the PM core */
b017500ab53c06 Rafael J. Wysocki 2024-01-22  685  	bool			may_skip_resume:1;	/* Set by subsystems */
805bdaec1a4415 Rafael J. Wysocki 2011-02-24  686  #else
b017500ab53c06 Rafael J. Wysocki 2024-01-22  687  	bool			should_wakeup:1;
1eede070a59e1c Rafael J. Wysocki 2008-05-20  688  #endif
d30d819dc83107 Rafael J. Wysocki 2014-11-27  689  #ifdef CONFIG_PM
8234f6734c5d74 Vincent Guittot   2018-12-14 @690  	struct hrtimer		suspend_timer;
6b61d49a55796d Grygorii Strashko 2020-09-18  691  	u64			timer_expires;
5e928f77a09a07 Rafael J. Wysocki 2009-08-18  692  	struct work_struct	work;
5e928f77a09a07 Rafael J. Wysocki 2009-08-18  693  	wait_queue_head_t	wait_queue;
4990d4fe327b9d Tony Lindgren     2015-05-18  694  	struct wake_irq		*wakeirq;
5e928f77a09a07 Rafael J. Wysocki 2009-08-18  695  	atomic_t		usage_count;
5e928f77a09a07 Rafael J. Wysocki 2009-08-18  696  	atomic_t		child_count;
5e928f77a09a07 Rafael J. Wysocki 2009-08-18  697  	unsigned int		disable_depth:3;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  698  	bool			idle_notification:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  699  	bool			request_pending:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  700  	bool			deferred_resume:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  701  	bool			needs_force_resume:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  702  	bool			runtime_auto:1;
372a12ed9d99c0 Ulf Hansson       2016-04-08  703  	bool			ignore_children:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  704  	bool			no_callbacks:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  705  	bool			irq_safe:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  706  	bool			use_autosuspend:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  707  	bool			timer_autosuspends:1;
b017500ab53c06 Rafael J. Wysocki 2024-01-22  708  	bool			memalloc_noio:1;
baa8809f60971d Rafael J. Wysocki 2016-10-30  709  	unsigned int		links_count;
5e928f77a09a07 Rafael J. Wysocki 2009-08-18  710  	enum rpm_request	request;
5e928f77a09a07 Rafael J. Wysocki 2009-08-18  711  	enum rpm_status		runtime_status;
c24efa6732788f Rafael J. Wysocki 2021-12-07  712  	enum rpm_status		last_status;
5e928f77a09a07 Rafael J. Wysocki 2009-08-18  713  	int			runtime_error;
15bcb91d7e607d Alan Stern        2010-09-25  714  	int			autosuspend_delay;
8234f6734c5d74 Vincent Guittot   2018-12-14  715  	u64			last_busy;
a08c2a5a319411 Thara Gopinath    2019-01-23  716  	u64			active_time;
a08c2a5a319411 Thara Gopinath    2019-01-23  717  	u64			suspended_time;
a08c2a5a319411 Thara Gopinath    2019-01-23  718  	u64			accounting_timestamp;
5e928f77a09a07 Rafael J. Wysocki 2009-08-18  719  #endif
5c095a0e0d600d Rafael J. Wysocki 2011-08-25  720  	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
2d984ad132a87c Rafael J. Wysocki 2014-02-11  721  	void (*set_latency_tolerance)(struct device *, s32);
5f986c590fcf42 Rafael J. Wysocki 2012-10-23  722  	struct dev_pm_qos	*qos;
1eede070a59e1c Rafael J. Wysocki 2008-05-20  723  };
1eede070a59e1c Rafael J. Wysocki 2008-05-20  724  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

