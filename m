Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56D1F8AD0
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jun 2020 23:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFNVEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Jun 2020 17:04:33 -0400
Received: from foss.arm.com ([217.140.110.172]:33566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgFNVEd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Jun 2020 17:04:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B911F1;
        Sun, 14 Jun 2020 14:04:32 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD24A3F71F;
        Sun, 14 Jun 2020 14:04:30 -0700 (PDT)
References: <20200614010755.9129-2-valentin.schneider@arm.com> <202006141541.YN3AhUnc%lkp@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/3] thermal/cpu-cooling, sched/core: Cleanup thermal pressure definition
In-reply-to: <202006141541.YN3AhUnc%lkp@intel.com>
Date:   Sun, 14 Jun 2020 22:04:23 +0100
Message-ID: <jhjlfkp1hrc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 14/06/20 08:39, kernel test robot wrote:
> Hi Valentin,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on tip/auto-latest]
> [also build test WARNING on driver-core/driver-core-testing tip/sched/core arm/for-next arm64/for-next/core soc/for-next linus/master v5.7 next-20200613]
> [cannot apply to linux/master]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Valentin-Schneider/sched-arch_topology-Thermal-pressure-configuration-cleanup/20200614-091051
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8dc697d75c13ee2901d1a40f1d7d58163048c204
> config: arm64-randconfig-r013-20200614 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project cb5072d1877b38c972f95092db2cedbcddb81da6)
> reproduce (this is a W=1 build):

Ah, W=1! I thought I was going nuts.

If desired, I can add a declaration in cpu_cooling.h, similar to what we
have for the arch_set_freq_scale() stub.

>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
>>> drivers/base/arch_topology.c:59:6: warning: no previous prototype for function 'arch_set_thermal_pressure' [-Wmissing-prototypes]
> void arch_set_thermal_pressure(const struct cpumask *cpus,
> ^
> drivers/base/arch_topology.c:59:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> void arch_set_thermal_pressure(const struct cpumask *cpus,
> ^
> static
> 1 warning generated.
>
> vim +/arch_set_thermal_pressure +59 drivers/base/arch_topology.c
>
>     58
>   > 59	void arch_set_thermal_pressure(const struct cpumask *cpus,
>     60				       unsigned long th_pressure)
>     61	{
>     62		int cpu;
>     63
>     64		for_each_cpu(cpu, cpus)
>     65			WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
>     66	}
>     67
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
