Return-Path: <linux-pm+bounces-28517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A787FAD6514
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 03:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B587AC9BF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 01:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C763136E37;
	Thu, 12 Jun 2025 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rk5rSjYz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F74207A;
	Thu, 12 Jun 2025 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691018; cv=none; b=onRmqbZ2BKda3UJFanofmqQ8bp/5XjBjR6ZCtT9/xc8LDABvj0nb+71UO9wSCFwtavShbmhlkcDI/4WzUDuFrmp/ASxZrp4469dVZ6Y8a2lfxdt/0iJjSLuK3cnKOcBrdD9ZFWYScXL2DO7c7XrF6Od5peRmlr7zc1uxI8ZvnMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691018; c=relaxed/simple;
	bh=9cQWUCePEsft2HV53xBGF7MysPCcHtpQG4kJkhSeY4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW7y/zsN6LtN1SMYpJ0rFIqb7fYuFOPr0KzDE0qWhgh9JbbYSlvEbjNi5OYWG2uths9VVyGXh365VT4tNDhdEi8lJVVFx6ugqrWvhceVxZ1JCT1Bur+zrEuW8fGyud070fP/Tjzk9XqpbI2/eZku86U9x+9YB4zn7MXQ1ST9U5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rk5rSjYz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749691017; x=1781227017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9cQWUCePEsft2HV53xBGF7MysPCcHtpQG4kJkhSeY4s=;
  b=Rk5rSjYzUjnFFhgXgWRr3NEFK7OIUQUYgS3cGXjlqn+wBfpaadWRmSYD
   3nw6q1ZWB95xRKyEPJ/qUtFUCiwU8UoSUKMRP39wosxP3j6lulHbHqI7+
   UQjPNTvtDmut/gQ3+/ZHpin4sFTnOtxK/AxGOkMY9Q+2NEtlR+TAE4/k+
   B4QU+gYCDp+YM/0SEzQfsStfPFaPDopocSojcJ1fEAO912+aHnrF5GHtc
   3g/imzUKfy+Ow5mKFoOhoqA/G5hqnbKeQf0oDQu69Idy3JsxKTjd+YKuB
   YstrM9L5ukupkbXZgHLPRdj2GxP2RqOnCFL/dbY0eaVNoQktlFJUQxHAc
   w==;
X-CSE-ConnectionGUID: NIkNL8v/Qtij0RiX/hIOQQ==
X-CSE-MsgGUID: hyGbfpmsTfCwothX5uvdzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="55656376"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="55656376"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 18:16:56 -0700
X-CSE-ConnectionGUID: uEnlmiMNStCycJ50+9Yvkw==
X-CSE-MsgGUID: FzzCKf4qSVitjP+8e/YByQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="152135888"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Jun 2025 18:16:51 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPWYj-000AyI-0v;
	Thu, 12 Jun 2025 01:16:49 +0000
Date: Thu, 12 Jun 2025 09:16:18 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Hu <nick.hu@sifive.com>, conor+dt@kernel.org, krzk+dt@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nick Hu <nick.hu@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 3/3] cpuidle: Add SiFive power provider
Message-ID: <202506120817.nRfhoHbQ-lkp@intel.com>
References: <20250611031023.28769-4-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611031023.28769-4-nick.hu@sifive.com>

Hi Nick,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge robh/for-next linus/master v6.16-rc1 next-20250611]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Hu/cpuidle-riscv-sbi-Work-with-the-external-pmdomain-driver/20250611-121115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250611031023.28769-4-nick.hu%40sifive.com
patch subject: [PATCH v2 3/3] cpuidle: Add SiFive power provider
config: riscv-randconfig-002-20250612 (https://download.01.org/0day-ci/archive/20250612/202506120817.nRfhoHbQ-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250612/202506120817.nRfhoHbQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506120817.nRfhoHbQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cpuidle/cpuidle-sifive-dmc-pd.c:8:
   In file included from include/linux/of_device.h:5:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/riscv/include/asm/elf.h:12:
   In file included from include/linux/compat.h:17:
   include/linux/fs.h:3975:15: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    3975 |         if (unlikely(get_user(c, path)))
         |                      ^
   arch/riscv/include/asm/uaccess.h:274:3: note: expanded from macro 'get_user'
     274 |                 __get_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:244:2: note: expanded from macro '__get_user'
     244 |         __get_user_error(__gu_val, __gu_ptr, __gu_err);         \
         |         ^
   arch/riscv/include/asm/uaccess.h:207:2: note: expanded from macro '__get_user_error'
     207 |         __get_user_nocheck(x, ptr, __gu_failed);                        \
         |         ^
   arch/riscv/include/asm/uaccess.h:196:3: note: expanded from macro '__get_user_nocheck'
     196 |                 __get_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:130:2: note: expanded from macro '__get_user_8'
     130 |         u32 __user *__ptr = (u32 __user *)(ptr);                \
         |         ^
>> drivers/cpuidle/cpuidle-sifive-dmc-pd.c:42:27: error: use of undeclared identifier 'pm_domain_cpu_gov'
      42 |         ret = pm_genpd_init(pd, &pm_domain_cpu_gov, false);
         |                                  ^
   1 warning and 1 error generated.
--
   In file included from drivers/cpuidle/cpuidle-riscv-sbi.c:16:
   In file included from include/linux/cpu_cooling.h:17:
   In file included from include/linux/thermal.h:15:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/riscv/include/asm/elf.h:12:
   In file included from include/linux/compat.h:17:
   include/linux/fs.h:3975:15: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    3975 |         if (unlikely(get_user(c, path)))
         |                      ^
   arch/riscv/include/asm/uaccess.h:274:3: note: expanded from macro 'get_user'
     274 |                 __get_user((x), __p) :                          \
         |                 ^
   arch/riscv/include/asm/uaccess.h:244:2: note: expanded from macro '__get_user'
     244 |         __get_user_error(__gu_val, __gu_ptr, __gu_err);         \
         |         ^
   arch/riscv/include/asm/uaccess.h:207:2: note: expanded from macro '__get_user_error'
     207 |         __get_user_nocheck(x, ptr, __gu_failed);                        \
         |         ^
   arch/riscv/include/asm/uaccess.h:196:3: note: expanded from macro '__get_user_nocheck'
     196 |                 __get_user_8((x), __gu_ptr, label);             \
         |                 ^
   arch/riscv/include/asm/uaccess.h:130:2: note: expanded from macro '__get_user_8'
     130 |         u32 __user *__ptr = (u32 __user *)(ptr);                \
         |         ^
>> drivers/cpuidle/cpuidle-riscv-sbi.c:410:25: error: use of undeclared identifier 'pm_domain_cpu_gov'
     410 |         pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
         |                                ^
   1 warning and 1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
   Depends on [n]: PM_GENERIC_DOMAINS [=n] && OF [=y]
   Selected by [y]:
   - SIFIVE_DMC_PD_CPUIDLE [=y] && CPU_IDLE [=y] && RISCV [=y] && ARCH_SIFIVE [=y]


vim +/pm_domain_cpu_gov +42 drivers/cpuidle/cpuidle-sifive-dmc-pd.c

    26	
    27	static int sifive_dmc_probe(struct platform_device *pdev)
    28	{
    29		struct device *dev = &pdev->dev;
    30		struct device_node *np = dev->of_node;
    31		struct generic_pm_domain *pd;
    32		struct of_phandle_args child, parent;
    33		int ret = -ENOMEM;
    34	
    35		pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
    36		if (!pd)
    37			goto fail;
    38	
    39		pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
    40		pd->power_off = sbi_cpuidle_pd_power_off;
    41	
  > 42		ret = pm_genpd_init(pd, &pm_domain_cpu_gov, false);
    43		if (ret)
    44			goto free_pd;
    45	
    46		ret = of_genpd_add_provider_simple(np, pd);
    47		if (ret)
    48			goto remove_pd;
    49	
    50		if (of_parse_phandle_with_args(np, "power-domains",
    51					       "#power-domain-cells", 0,
    52					       &parent) == 0) {
    53			child.np = np;
    54			child.args_count = 0;
    55	
    56			if (of_genpd_add_subdomain(&parent, &child))
    57				pr_warn("%pOF failed to add subdomain: %pOF\n",
    58					parent.np, child.np);
    59			else
    60				pr_debug("%pOF has a child subdomain: %pOF.\n",
    61					 parent.np, child.np);
    62		}
    63	
    64		platform_set_drvdata(pdev, pd);
    65		pm_runtime_enable(dev);
    66		pr_info("%s create success\n", pd->name);
    67		return 0;
    68	
    69	remove_pd:
    70		pm_genpd_remove(pd);
    71	free_pd:
    72		dt_idle_pd_free(pd);
    73	fail:
    74		pr_info("%s create fail\n", pd->name);
    75	
    76		return ret;
    77	}
    78	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

