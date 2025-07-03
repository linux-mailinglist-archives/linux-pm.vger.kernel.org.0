Return-Path: <linux-pm+bounces-30077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38551AF7E5B
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83814A07E1
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBC258CF8;
	Thu,  3 Jul 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQMznmMm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82B17A319;
	Thu,  3 Jul 2025 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751562299; cv=none; b=l3owlYSHO2q/u3tv0LVq+OAfYpJcGFD6N8apgNqpNVqTwRHUUaMxm3+dvL54MExLtaVHA7FT2BL2AHhGX299akX0A6QPlhudKq8UqZASUMio2jolajPKxB5ROxmj+ebOA+NJCVTI6P3ddaihESHtNSRbwMTP8IO5GzDmx6tTJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751562299; c=relaxed/simple;
	bh=QsC4CqDA0Dxv8zb6CyeYGANC/Ef8RVUzUXmP4D/HMSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaeZQTz9XSBRxxGseKGEQ2C2ei0FKgTnYKGyqpxYRT5QyshXNT4WvZqG5LTFD4EnKnEEp44lo7YPhIx/9zBRXXZ0JyCSMGUpwS7Wdg4iSj7Oxd25NlMvPnJ5FBc99s2nwcnRtbypnpWyNRmElw+/SdqdcPpCr1fH0pM1sTU6zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQMznmMm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751562296; x=1783098296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QsC4CqDA0Dxv8zb6CyeYGANC/Ef8RVUzUXmP4D/HMSM=;
  b=GQMznmMmocKUBFBTnOu2G43QI8WKQjn5vrKPKk3vY69d0O7lv6zb90RZ
   mO23uIWbTqEOd5II0YF4iFs/ezX7OG/c+gG1+PXIvlZXBPDa8o0bhHOPW
   lGx7J0GwQV6NLXdBiOOw6dwdtJrCrfziKcxJl0ZZLedjbty1RW5nN1M2Z
   jBh2rMqeqsL27aDpVsexkacWotJZw+KXLoKEXgIYJfE1ZLzDqHtjzMOkc
   qoRIrRCjg1BYbWWuX9GXnZUwgynSmHOlURsOvJxJwYJnbNeCE5Y7rW53g
   cMFH4Squ70RFCiig1xfjl2nTEtm5dk+v2C9loJU9xPy73DGmCuzYL3hFr
   g==;
X-CSE-ConnectionGUID: xpkPe0hCTyS6eoJfpcdEYg==
X-CSE-MsgGUID: VKrIbyniSvW2+oOQZGiKsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53868202"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53868202"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:04:56 -0700
X-CSE-ConnectionGUID: cM4NzYspRFWldVkEozDfmA==
X-CSE-MsgGUID: DXOA958VQjupwLGla7Z+3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154062938"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 03 Jul 2025 10:04:52 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXNMf-0002op-2A;
	Thu, 03 Jul 2025 17:04:49 +0000
Date: Fri, 4 Jul 2025 01:04:47 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Hu <nick.hu@sifive.com>, conor+dt@kernel.org, krzk+dt@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Nick Hu <nick.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 2/3] cpuidle: riscv-sbi: Work with the external
 pmdomain driver
Message-ID: <202507040001.Jm6FQyH6-lkp@intel.com>
References: <20250702091236.5281-3-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702091236.5281-3-nick.hu@sifive.com>

Hi Nick,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge robh/for-next linus/master v6.16-rc4 next-20250703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Hu/cpuidle-riscv-sbi-Work-with-the-external-pmdomain-driver/20250702-181250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250702091236.5281-3-nick.hu%40sifive.com
patch subject: [PATCH v3 2/3] cpuidle: riscv-sbi: Work with the external pmdomain driver
config: riscv-randconfig-001-20250703 (https://download.01.org/0day-ci/archive/20250704/202507040001.Jm6FQyH6-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507040001.Jm6FQyH6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507040001.Jm6FQyH6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cpuidle/cpuidle-riscv-sbi.c: In function 'sbi_cpuidle_probe':
>> drivers/cpuidle/cpuidle-riscv-sbi.c:569:1: warning: label 'out' defined but not used [-Wunused-label]
     569 | out:
         | ^~~


vim +/out +569 drivers/cpuidle/cpuidle-riscv-sbi.c

   493	
   494	static int sbi_cpuidle_probe(struct platform_device *pdev)
   495	{
   496		int cpu, ret;
   497		struct cpuidle_driver *drv;
   498		struct cpuidle_device *dev;
   499		struct device_node *pds_node;
   500	
   501		/* Detect OSI support based on CPU DT nodes */
   502		sbi_cpuidle_use_osi = true;
   503		for_each_possible_cpu(cpu) {
   504			struct device_node *np __free(device_node) = of_cpu_device_node_get(cpu);
   505			if (np &&
   506			    of_property_present(np, "power-domains") &&
   507			    of_property_present(np, "power-domain-names")) {
   508				continue;
   509			} else {
   510				sbi_cpuidle_use_osi = false;
   511				break;
   512			}
   513		}
   514	
   515		/* Populate generic power domains from DT nodes */
   516		pds_node = of_find_node_by_path("/cpus/power-domains");
   517		if (pds_node) {
   518			ret = sbi_genpd_probe(pds_node);
   519			of_node_put(pds_node);
   520			if (ret)
   521				return ret;
   522		}
   523	
   524		/* Attaching the cpu to the corresponding power domain */
   525		if (sbi_cpuidle_use_osi) {
   526			for_each_present_cpu(cpu) {
   527				struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
   528	
   529				data->dev = dt_idle_attach_cpu(cpu, "sbi");
   530				if (IS_ERR_OR_NULL(data->dev)) {
   531					ret = PTR_ERR_OR_ZERO(data->dev);
   532					if (ret != -EPROBE_DEFER)
   533						pr_debug("Hart%ld: fail to attach the power domain\n",
   534							 cpuid_to_hartid_map(cpu));
   535	
   536					while (--cpu >= 0)
   537						dt_idle_detach_cpu(data->dev);
   538					return ret;
   539				}
   540			}
   541			/* Setup CPU hotplut notifiers */
   542			sbi_idle_init_cpuhp();
   543		}
   544	
   545		/* Initialize CPU idle driver for each present CPU */
   546		for_each_present_cpu(cpu) {
   547			ret = sbi_cpuidle_init_cpu(&pdev->dev, cpu);
   548			if (ret) {
   549				pr_debug("HART%ld: idle driver init failed\n",
   550					 cpuid_to_hartid_map(cpu));
   551				goto out_fail;
   552			}
   553		}
   554	
   555		if (cpuidle_disabled())
   556			pr_info("cpuidle is disabled\n");
   557		else
   558			pr_info("idle driver registered for all CPUs\n");
   559	
   560		return 0;
   561	
   562	out_fail:
   563		while (--cpu >= 0) {
   564			dev = per_cpu(cpuidle_devices, cpu);
   565			drv = cpuidle_get_cpu_driver(dev);
   566			cpuidle_unregister(drv);
   567			sbi_cpuidle_deinit_cpu(cpu);
   568		}
 > 569	out:
   570		return ret;
   571	}
   572	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

