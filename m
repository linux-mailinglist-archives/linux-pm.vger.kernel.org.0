Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE4C8D21
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 17:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfJBPnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 11:43:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:38754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfJBPnu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 11:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5296DAC7D;
        Wed,  2 Oct 2019 15:43:45 +0000 (UTC)
Message-ID: <1570031352.22393.4.camel@suse.cz>
Subject: Re: [PATCH v2 1/2] x86,sched: Add support for frequency invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org,
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
Date:   Wed, 02 Oct 2019 17:49:12 +0200
In-Reply-To: <201910022359.6gxzMDqF%lkp@intel.com>
References: <20191002122926.385-2-ggherdovich@suse.cz>
         <201910022359.6gxzMDqF%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-10-02 at 23:23 +0800, kbuild test robot wrote:
> Hi Giovanni,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/sched/core]
> [cannot apply to v5.4-rc1 next-20191002]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

Noted, thanks.

Indeed this patch applies to the master branch of the "tip" tree,
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git , and depends on
5ebb34edbefa8 "x86/intel: Aggregate microserver naming".

I'll use '--base' in the future.


Giovanni

> 
> url:    https://github.com/0day-ci/linux/commits/Giovanni-Gherdovich/Add-support-for-frequency-invariance-for-some-x86/20191002-221807
> config: x86_64-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> > > arch/x86/kernel/smpboot.c:1834:7: error: 'INTEL_FAM6_ATOM_GOLDMONT_D' undeclared here (not in a function); did you mean 'INTEL_FAM6_ATOM_GOLDMONT_X'?
> 
>      ICPU(INTEL_FAM6_ATOM_GOLDMONT_D),
>           ^
>    arch/x86/kernel/smpboot.c:1824:25: note: in definition of macro 'ICPU'
>      { X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF, 0}
>                             ^~~~~
> 
> vim +1834 arch/x86/kernel/smpboot.c
> 
>   1831	
>   1832	static const struct x86_cpu_id has_turbo_ratio_group_limits[] = {
>   1833		ICPU(INTEL_FAM6_ATOM_GOLDMONT),
> > 1834		ICPU(INTEL_FAM6_ATOM_GOLDMONT_D),
> 
>   1835		ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS),
>   1836		ICPU(INTEL_FAM6_SKYLAKE_X),
>   1837		{}
>   1838	};
>   1839	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
