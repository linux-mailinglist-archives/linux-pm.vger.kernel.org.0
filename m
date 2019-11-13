Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601C7FB04E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 13:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfKMMUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 07:20:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:52214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbfKMMUh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 07:20:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EFA7AD6F;
        Wed, 13 Nov 2019 12:20:34 +0000 (UTC)
Message-ID: <1573647975.2933.17.camel@suse.cz>
Subject: Re: [PATCH 6/6] x86: intel_pstate: handle runtime turbo
 disablement/enablement in freq. invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Date:   Wed, 13 Nov 2019 13:26:15 +0100
In-Reply-To: <201911130542.dtVRgDKU%lkp@intel.com>
References: <20191111180549.12166-7-ggherdovich@suse.cz>
         <201911130542.dtVRgDKU%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-11-13 at 05:28 +0800, kbuild test robot wrote:
> Hi Giovanni,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/sched/core]
> [cannot apply to v5.4-rc7 next-20191111]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Giovanni-Gherdovich/Add-support-for-frequency-invariance-for-some-x86/20191113-035438
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a0e813f26ebcb25c0b5e504498fbd796cca1a4ba
> config: i386-randconfig-e001-201945 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/cpufreq/intel_pstate.c: In function 'intel_pstate_update_limits':
> > > drivers/cpufreq/intel_pstate.c:925:3: error: implicit declaration of function 'set_arch_max_freq' [-Werror=implicit-function-declaration]
> 
>       set_arch_max_freq(global.turbo_disabled);
>       ^~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 

Good bot. I'm defining the function set_arch_max_freq only if CONFIG_SMP,
I forgot to provide a definition (with empty body) in the other case.

Resending.

Giovanni

> vim +/set_arch_max_freq +925 drivers/cpufreq/intel_pstate.c
> 
>    913	
>    914	static void intel_pstate_update_limits(unsigned int cpu)
>    915	{
>    916		mutex_lock(&intel_pstate_driver_lock);
>    917	
>    918		update_turbo_state();
>    919		/*
>    920		 * If turbo has been turned on or off globally, policy limits for
>    921		 * all CPUs need to be updated to reflect that.
>    922		 */
>    923		if (global.turbo_disabled_mf != global.turbo_disabled) {
>    924			global.turbo_disabled_mf = global.turbo_disabled;
>  > 925			set_arch_max_freq(global.turbo_disabled);
>    926			for_each_possible_cpu(cpu)
>    927				intel_pstate_update_max_freq(cpu);
>    928		} else {
>    929			cpufreq_update_policy(cpu);
>    930		}
>    931	
>    932		mutex_unlock(&intel_pstate_driver_lock);
>    933	}
>    934	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
