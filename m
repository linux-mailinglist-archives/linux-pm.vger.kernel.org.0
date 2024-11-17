Return-Path: <linux-pm+bounces-17676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E09D01BA
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 01:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9A72817A1
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 00:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604478F5B;
	Sun, 17 Nov 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFaaNC1W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E131392;
	Sun, 17 Nov 2024 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803731; cv=none; b=kGiPivhUtAqVUvvvg/mwBAllDjTF5lxBK8K0NvzkDxWnXGoLT90w6JEtKuMTmnxbhm/kMTZ8NR3WTxsfIGVqztbUOYKew3DBHLSkMiUSWS1wf8IxfwBbF5t+Cy9MQPUf/664hL7GKBMeyV+DsTroI0BiHZTY3mtWm0JW78DNZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803731; c=relaxed/simple;
	bh=0Ip7p5/sDU5L0F6uiB4z207X4Olq921W8AWZGfDwQfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS8fU5OxA0dvGGeopIMpxXwNFPJG1UsGd9iJrm1j78216FHHvNSZq1W45kXVvXLDqwolTe4hCvKh0baY3oe13+ANstZ4jDeThigSDu+sOGg8OFOw4Ec59cLCnfmMJU9MoLT4snRVA/5zxoE+V7fHBt/Lst/m1SkaNpKh8C3r0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFaaNC1W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731803729; x=1763339729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Ip7p5/sDU5L0F6uiB4z207X4Olq921W8AWZGfDwQfw=;
  b=dFaaNC1WSDpkKTvVLStkO0hIvKDNxD/j3Lae4g+W/YOLRqArAqIkZi/H
   tKlW7W/APblahilrRDXCF0d4EY9X8btH1zmLa6O7mnGER97gg79kslF/a
   RwhqtV6mLA63pFXhLlyEEpsyw3VJxngJ19q2QqE6W5YKiDUB+XclRCuZ0
   vdnhafHlq15IvIz805kbZONQsKR9Ae2faYlDfIRp/pUyyZYP7vKnpjsSF
   efoxTcHKFFWTby4yV4NluSYj1eexLAJCAh5HqeQm5AQd9kFNVT95cu+R/
   GGivHQcwYx6WncI09l/sUiM2oC0Ch1b+OJYKetzsF7my+as7Gt+F4zvCR
   A==;
X-CSE-ConnectionGUID: glb6n100SHSzJYCPK9nP7Q==
X-CSE-MsgGUID: 3BVo9M0YTEGF+y6WrF6dIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="54284808"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="54284808"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 16:35:29 -0800
X-CSE-ConnectionGUID: AQWN9aISQ7294p08psRBcA==
X-CSE-MsgGUID: 2HpbwD9ATUeFxS7dEZo0Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93914392"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Nov 2024 16:35:24 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCTG5-0001Bn-1s;
	Sun, 17 Nov 2024 00:35:21 +0000
Date: Sun, 17 Nov 2024 08:34:31 +0800
From: kernel test robot <lkp@intel.com>
To: Saravana Kannan <saravanak@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Vasut <marex@denx.de>, Bird@google.com,
	Tim <Tim.Bird@sony.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads
 during dpm_resume*() phases
Message-ID: <202411170802.SnHuptE7-lkp@intel.com>
References: <20241114220921.2529905-6-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114220921.2529905-6-saravanak@google.com>

Hi Saravana,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge tip/sched/core amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saravana-Kannan/PM-sleep-Fix-runtime-PM-issue-in-dpm_resume/20241115-183855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241114220921.2529905-6-saravanak%40google.com
patch subject: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during dpm_resume*() phases
config: arm-s3c6400_defconfig (https://download.01.org/0day-ci/archive/20241117/202411170802.SnHuptE7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411170802.SnHuptE7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411170802.SnHuptE7-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/power/suspend.o: in function `suspend_enter':
>> kernel/power/suspend.c:485:(.text+0x2f4): undefined reference to `sched_set_energy_aware'
>> arm-linux-gnueabi-ld: kernel/power/suspend.c:485:(.text+0x48c): undefined reference to `sched_set_energy_aware'
   arm-linux-gnueabi-ld: kernel/power/suspend.c:485:(.text+0x4c0): undefined reference to `sched_set_energy_aware'
   arm-linux-gnueabi-ld: kernel/power/suspend.c:485:(.text+0x4d0): undefined reference to `sched_set_energy_aware'
   arm-linux-gnueabi-ld: kernel/power/suspend.o: in function `suspend_devices_and_enter':
   kernel/power/suspend.c:538:(.text+0x748): undefined reference to `sched_set_energy_aware'


vim +485 kernel/power/suspend.c

   401	
   402	/**
   403	 * suspend_enter - Make the system enter the given sleep state.
   404	 * @state: System sleep state to enter.
   405	 * @wakeup: Returns information that the sleep state should not be re-entered.
   406	 *
   407	 * This function should be called after devices have been suspended.
   408	 */
   409	static int suspend_enter(suspend_state_t state, bool *wakeup)
   410	{
   411		int error;
   412	
   413		error = platform_suspend_prepare(state);
   414		if (error)
   415			goto Platform_finish;
   416	
   417		error = dpm_suspend_late(PMSG_SUSPEND);
   418		if (error) {
   419			pr_err("late suspend of devices failed\n");
   420			goto Platform_finish;
   421		}
   422		error = platform_suspend_prepare_late(state);
   423		if (error)
   424			goto Devices_early_resume;
   425	
   426		error = dpm_suspend_noirq(PMSG_SUSPEND);
   427		if (error) {
   428			pr_err("noirq suspend of devices failed\n");
   429			goto Platform_early_resume;
   430		}
   431		error = platform_suspend_prepare_noirq(state);
   432		if (error)
   433			goto Platform_wake;
   434	
   435		if (suspend_test(TEST_PLATFORM))
   436			goto Platform_wake;
   437	
   438		if (state == PM_SUSPEND_TO_IDLE) {
   439			s2idle_loop();
   440			goto Platform_wake;
   441		}
   442	
   443		error = pm_sleep_disable_secondary_cpus();
   444		if (error || suspend_test(TEST_CPUS))
   445			goto Enable_cpus;
   446	
   447		arch_suspend_disable_irqs();
   448		BUG_ON(!irqs_disabled());
   449	
   450		system_state = SYSTEM_SUSPEND;
   451	
   452		error = syscore_suspend();
   453		if (!error) {
   454			*wakeup = pm_wakeup_pending();
   455			if (!(suspend_test(TEST_CORE) || *wakeup)) {
   456				trace_suspend_resume(TPS("machine_suspend"),
   457					state, true);
   458				error = suspend_ops->enter(state);
   459				trace_suspend_resume(TPS("machine_suspend"),
   460					state, false);
   461			} else if (*wakeup) {
   462				error = -EBUSY;
   463			}
   464			syscore_resume();
   465		}
   466	
   467		system_state = SYSTEM_RUNNING;
   468	
   469		arch_suspend_enable_irqs();
   470		BUG_ON(irqs_disabled());
   471	
   472	 Enable_cpus:
   473		pm_sleep_enable_secondary_cpus();
   474	
   475	 Platform_wake:
   476		platform_resume_noirq(state);
   477		/*
   478		 * We do this only for resume instead of suspend and resume for these
   479		 * reasons:
   480		 * - Performance is more important than power for resume.
   481		 * - Power spent entering suspend is more important for suspend. Also,
   482		 *   stangely, disabling EAS was making suspent a few milliseconds
   483		 *   slower in my testing.
   484		 */
 > 485		sched_set_energy_aware(0);
   486		dpm_resume_noirq(PMSG_RESUME);
   487	
   488	 Platform_early_resume:
   489		platform_resume_early(state);
   490	
   491	 Devices_early_resume:
   492		dpm_resume_early(PMSG_RESUME);
   493	
   494	 Platform_finish:
   495		platform_resume_finish(state);
   496		return error;
   497	}
   498	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

