Return-Path: <linux-pm+bounces-15889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41A9A2A3B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 19:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E05A287C44
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EE21F707E;
	Thu, 17 Oct 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDCItILA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF31EF936;
	Thu, 17 Oct 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184328; cv=none; b=lt+dfdIWYPw9fbuRjtyqAdihMGEsdm8GPd1Y8lBtu/CFjrBEDDXdRtbd7f4ubFut3NQFhd5cd8xSnWP+ihBHSz9DQW9pZCFwb5RE4HyWgz2RnwIVQpenhu5k1AAn1LolafK3dg98O5HyKNvYHIi48SxkcIcl/NR86k/bBT4bGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184328; c=relaxed/simple;
	bh=KyRthnK/hRJVa0err0gjkBoaFHgWB/n7LsV5WDKmys8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA+0mk7KN998p7QZpfv9VMVDiAwIsgrIqW1p7r4kq+Yr6SHsDudau0EU/EYWHMfX4nRvmJQ4VbUUzU0gPdQj0+6NWMCzETDDMhZoi1ZLL7khD/CDf+8/X6it9cHHnhcrJec+91w2ul7EmwAwlBVK5N0U1sLN+Q9m29rgoTLbLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDCItILA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729184323; x=1760720323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KyRthnK/hRJVa0err0gjkBoaFHgWB/n7LsV5WDKmys8=;
  b=GDCItILAPkDgJOHYOXDzKNTtLEX1OMFlbftIhTSKsfiKN3AocInBb6st
   HCN0L/GA59RzLXCmFX8upQ4IjRRs82qfRKgE3mcIgAaaEP8oGuzBSIhxt
   OSNOqb6hNPzSu50S+xRyS38OCWBaKrKSLHovwOMp3/kGEEGHxS8BXHF/D
   cE8NBvdtL5QeNt5RzswJuEEiV3szbsg75se/S7TCXNgT3rNVmRWdXmrlZ
   oABsc2iXdDoDMYHiQOsQEUXVX3xd+wZ2Vd4QGWRMjj1UgQBT0cGOG8+rQ
   70WTn5Hl3D4d3cXPfpqo/pEz+55i4uWsok1AhLsyI7j+0rg4iI4UTzLt0
   w==;
X-CSE-ConnectionGUID: etnyfPcOTJOG2AKwI3ZJZw==
X-CSE-MsgGUID: wD9kNP8ISR6FccMRcz8g2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32616466"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="32616466"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 09:57:39 -0700
X-CSE-ConnectionGUID: f8FDYwqYQQepp9zW7OiYsA==
X-CSE-MsgGUID: S+CawiarR6eQMwvFgCd/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="109420965"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Oct 2024 09:57:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1Toa-000Mct-0d;
	Thu, 17 Oct 2024 16:57:32 +0000
Date: Fri, 18 Oct 2024 00:56:48 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
Message-ID: <202410180024.2NpHo5Z6-lkp@intel.com>
References: <20241016161044.28745-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016161044.28745-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.12-rc3 next-20241017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/cpufreq-airoha-Add-EN7581-Cpufreq-SMC-driver/20241017-001217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241016161044.28745-1-ansuelsmth%40gmail.com
patch subject: [PATCH] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
config: arm-defconfig (https://download.01.org/0day-ci/archive/20241018/202410180024.2NpHo5Z6-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410180024.2NpHo5Z6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410180024.2NpHo5Z6-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/cpufreq/airoha-cpufreq.c:27:34: error: variable has incomplete type 'const struct arm_smccc_1_2_regs'
           const struct arm_smccc_1_2_regs args = {
                                           ^
   drivers/cpufreq/airoha-cpufreq.c:27:15: note: forward declaration of 'struct arm_smccc_1_2_regs'
           const struct arm_smccc_1_2_regs args = {
                        ^
   drivers/cpufreq/airoha-cpufreq.c:31:28: error: variable has incomplete type 'struct arm_smccc_1_2_regs'
           struct arm_smccc_1_2_regs res;
                                     ^
   drivers/cpufreq/airoha-cpufreq.c:27:15: note: forward declaration of 'struct arm_smccc_1_2_regs'
           const struct arm_smccc_1_2_regs args = {
                        ^
>> drivers/cpufreq/airoha-cpufreq.c:33:2: error: implicit declaration of function 'arm_smccc_1_2_smc' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           arm_smccc_1_2_smc(&args, &res);
           ^
   drivers/cpufreq/airoha-cpufreq.c:40:34: error: variable has incomplete type 'const struct arm_smccc_1_2_regs'
           const struct arm_smccc_1_2_regs args = {
                                           ^
   drivers/cpufreq/airoha-cpufreq.c:40:15: note: forward declaration of 'struct arm_smccc_1_2_regs'
           const struct arm_smccc_1_2_regs args = {
                        ^
   drivers/cpufreq/airoha-cpufreq.c:45:28: error: variable has incomplete type 'struct arm_smccc_1_2_regs'
           struct arm_smccc_1_2_regs res;
                                     ^
   drivers/cpufreq/airoha-cpufreq.c:40:15: note: forward declaration of 'struct arm_smccc_1_2_regs'
           const struct arm_smccc_1_2_regs args = {
                        ^
   drivers/cpufreq/airoha-cpufreq.c:47:2: error: implicit declaration of function 'arm_smccc_1_2_smc' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           arm_smccc_1_2_smc(&args, &res);
           ^
   drivers/cpufreq/airoha-cpufreq.c:68:17: warning: variable 'cpu_dev' set but not used [-Wunused-but-set-variable]
           struct device *cpu_dev;
                          ^
>> drivers/cpufreq/airoha-cpufreq.c:103:9: error: implicit declaration of function 'kzalloc' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           priv = kzalloc(sizeof(*priv), GFP_KERNEL);
                  ^
>> drivers/cpufreq/airoha-cpufreq.c:103:7: warning: incompatible integer to pointer conversion assigning to 'struct airoha_cpufreq_priv *' from 'int' [-Wint-conversion]
           priv = kzalloc(sizeof(*priv), GFP_KERNEL);
                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/airoha-cpufreq.c:145:3: error: implicit declaration of function 'kfree' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   kfree(priv);
                   ^
   2 warnings and 8 errors generated.


vim +/arm_smccc_1_2_smc +33 drivers/cpufreq/airoha-cpufreq.c

    24	
    25	static unsigned int airoha_cpufreq_get(unsigned int cpu)
    26	{
    27		const struct arm_smccc_1_2_regs args = {
    28			.a0 = AIROHA_SIP_AVS_HANDLE,
    29			.a1 = AIROHA_AVS_OP_GET_FREQ,
    30		};
    31		struct arm_smccc_1_2_regs res;
    32	
  > 33		arm_smccc_1_2_smc(&args, &res);
    34	
    35		return (int)(res.a0 * 1000);
    36	}
    37	
    38	static int airoha_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
    39	{
    40		const struct arm_smccc_1_2_regs args = {
    41			.a0 = AIROHA_SIP_AVS_HANDLE,
    42			.a1 = AIROHA_AVS_OP_FREQ_DYN_ADJ,
    43			.a3 = index,
    44		};
    45		struct arm_smccc_1_2_regs res;
    46	
    47		arm_smccc_1_2_smc(&args, &res);
    48	
    49		/* SMC signal correct apply by unsetting BIT 0 */
    50		return res.a0 & BIT(0) ? -EINVAL : 0;
    51	}
    52	
    53	static struct airoha_cpufreq_priv *airoha_cpufreq_find_data(int cpu)
    54	{
    55		struct airoha_cpufreq_priv *priv;
    56	
    57		list_for_each_entry(priv, &priv_list, list) {
    58			if (cpumask_test_cpu(cpu, priv->cpus))
    59				return priv;
    60		}
    61	
    62		return NULL;
    63	}
    64	
    65	static int airoha_cpufreq_init(struct cpufreq_policy *policy)
    66	{
    67		struct airoha_cpufreq_priv *priv;
    68		struct device *cpu_dev;
    69	
    70		priv = airoha_cpufreq_find_data(policy->cpu);
    71		if (!priv)
    72			return -ENODEV;
    73	
    74		cpu_dev = priv->cpu_dev;
    75		cpumask_copy(policy->cpus, priv->cpus);
    76		policy->driver_data = priv;
    77		policy->freq_table = priv->freq_table;
    78	
    79		return 0;
    80	}
    81	
    82	static struct cpufreq_driver airoha_cpufreq_driver = {
    83		.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
    84				  CPUFREQ_IS_COOLING_DEV,
    85		.verify		= cpufreq_generic_frequency_table_verify,
    86		.target_index	= airoha_cpufreq_set_target,
    87		.get		= airoha_cpufreq_get,
    88		.init		= airoha_cpufreq_init,
    89		.attr		= cpufreq_generic_attr,
    90		.name		= "airoha-cpufreq",
    91	};
    92	
    93	static int airoha_cpufreq_driver_init_cpu(int cpu)
    94	{
    95		struct airoha_cpufreq_priv *priv;
    96		struct device *cpu_dev;
    97		int ret;
    98	
    99		cpu_dev = get_cpu_device(cpu);
   100		if (!cpu_dev)
   101			return -EPROBE_DEFER;
   102	
 > 103		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
   104		if (!priv)
   105			return -ENOMEM;
   106	
   107		if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
   108			return -ENOMEM;
   109	
   110		cpumask_set_cpu(cpu, priv->cpus);
   111		priv->cpu_dev = cpu_dev;
   112	
   113		ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, priv->cpus);
   114		if (ret)
   115			goto err;
   116	
   117		ret = dev_pm_opp_of_cpumask_add_table(priv->cpus);
   118		if (ret)
   119			goto err;
   120	
   121		ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &priv->freq_table);
   122		if (ret)
   123			goto err;
   124	
   125		list_add(&priv->list, &priv_list);
   126	
   127		return 0;
   128	
   129	err:
   130		dev_pm_opp_of_cpumask_remove_table(priv->cpus);
   131		free_cpumask_var(priv->cpus);
   132	
   133		return ret;
   134	}
   135	
   136	static void airoha_cpufreq_release(void)
   137	{
   138		struct airoha_cpufreq_priv *priv, *tmp;
   139	
   140		list_for_each_entry_safe(priv, tmp, &priv_list, list) {
   141			dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
   142			dev_pm_opp_of_cpumask_remove_table(priv->cpus);
   143			free_cpumask_var(priv->cpus);
   144			list_del(&priv->list);
 > 145			kfree(priv);
   146		}
   147	}
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

