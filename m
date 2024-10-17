Return-Path: <linux-pm+bounces-15869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35C9A233F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F13B1C28AD8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92851DE4C7;
	Thu, 17 Oct 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M90qfR5h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41551DE3D8;
	Thu, 17 Oct 2024 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170749; cv=none; b=g8gF9VmPb6eMdP8Wa/deVu15+3Jlq0q+fi3fDRV2ej95sB4BCC6wcmfeS7oHzB5lamwM1MyNGPPZy46cDdigP06rbAs+rRuAoP/Fl/TnMEO6HAAqmjatZO84dlPd75dJ7pAWqClcTbdDuZD/msj/O+awVdcmBk3bYeAraGkgVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170749; c=relaxed/simple;
	bh=z6DoODhaSQ1MauMVN+zE0qV0NEEBtXP29YMduO1kw6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5wQcKq8m9BVZJViHNnhJkCYSxh+7ORg7IhGCvr/6iwxfRvO/SvLJ/0GV4+l6S2Sv6pquG+1oAXJOrcdfNVCaq/DHhhizspoO6GPx7zvZ2Nq4tR+KkQDlNLU33ftYA4MNHLYNB6H5aD/Vt42SmJNb06muPmI5vhI1dDEb7C81mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M90qfR5h; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729170746; x=1760706746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z6DoODhaSQ1MauMVN+zE0qV0NEEBtXP29YMduO1kw6I=;
  b=M90qfR5hmw4WeLa/2XItPwYbKOi0s5034tKgCBRILhW5vFugtXRPI0b3
   9JFXYDxQVEVZujZefDzSJDjs187RB8PdwwwTl7Sr9oigcXKKKC9dBmvh4
   Pkb2XKBr15wkDrJbx5k/rFghzPF3E29xD4atmRp4ug+GpHga8vRVn+/D/
   UUA18iThnEVZknCRU9UOaH61QJXu9V32QoYgdJ3z9Wug4opvD3hLcmpFt
   3M0K4ApiXs1iElcYpJEKXt9ZZTiJM3y+UzX1gzTvIJAU7jjpGf8mHbFaP
   kLRsnrb2C2Rv/jeqYofzBtMkeUiO7BQbChrIU8Jjh7LPMBaR+CNXk9ZcK
   g==;
X-CSE-ConnectionGUID: HUNq7yTgS+iyY/ng96o69w==
X-CSE-MsgGUID: T0tG/FJbSKawpBxWpFpPgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="32452565"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="32452565"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:12:26 -0700
X-CSE-ConnectionGUID: xFswveiFQSakBOInpOFLXQ==
X-CSE-MsgGUID: DU0bhVPFRkuksfWreldL/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="83315305"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Oct 2024 06:12:24 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1QIf-000MM3-1l;
	Thu, 17 Oct 2024 13:12:21 +0000
Date: Thu, 17 Oct 2024 21:11:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
Message-ID: <202410172028.AdkR2sEw-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241017/202410172028.AdkR2sEw-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410172028.AdkR2sEw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410172028.AdkR2sEw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/cpufreq/airoha-cpufreq.c: In function 'airoha_cpufreq_get':
>> drivers/cpufreq/airoha-cpufreq.c:27:22: error: variable 'args' has initializer but incomplete type
      27 |         const struct arm_smccc_1_2_regs args = {
         |                      ^~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/airoha-cpufreq.c:28:18: error: 'const struct arm_smccc_1_2_regs' has no member named 'a0'
      28 |                 .a0 = AIROHA_SIP_AVS_HANDLE,
         |                  ^~
>> drivers/cpufreq/airoha-cpufreq.c:7:49: warning: excess elements in struct initializer
       7 | #define AIROHA_SIP_AVS_HANDLE                   0x82000301
         |                                                 ^~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:28:23: note: in expansion of macro 'AIROHA_SIP_AVS_HANDLE'
      28 |                 .a0 = AIROHA_SIP_AVS_HANDLE,
         |                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:7:49: note: (near initialization for 'args')
       7 | #define AIROHA_SIP_AVS_HANDLE                   0x82000301
         |                                                 ^~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:28:23: note: in expansion of macro 'AIROHA_SIP_AVS_HANDLE'
      28 |                 .a0 = AIROHA_SIP_AVS_HANDLE,
         |                       ^~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/airoha-cpufreq.c:29:18: error: 'const struct arm_smccc_1_2_regs' has no member named 'a1'
      29 |                 .a1 = AIROHA_AVS_OP_GET_FREQ,
         |                  ^~
>> drivers/cpufreq/airoha-cpufreq.c:13:50: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
      13 |                                                  FIELD_PREP(AIROHA_AVS_OP_MASK, 0x2))
         |                                                  ^~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:29:23: note: in expansion of macro 'AIROHA_AVS_OP_GET_FREQ'
      29 |                 .a1 = AIROHA_AVS_OP_GET_FREQ,
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:12:49: warning: excess elements in struct initializer
      12 | #define AIROHA_AVS_OP_GET_FREQ                  (AIROHA_AVS_OP_BASE | \
         |                                                 ^
   drivers/cpufreq/airoha-cpufreq.c:29:23: note: in expansion of macro 'AIROHA_AVS_OP_GET_FREQ'
      29 |                 .a1 = AIROHA_AVS_OP_GET_FREQ,
         |                       ^~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:12:49: note: (near initialization for 'args')
      12 | #define AIROHA_AVS_OP_GET_FREQ                  (AIROHA_AVS_OP_BASE | \
         |                                                 ^
   drivers/cpufreq/airoha-cpufreq.c:29:23: note: in expansion of macro 'AIROHA_AVS_OP_GET_FREQ'
      29 |                 .a1 = AIROHA_AVS_OP_GET_FREQ,
         |                       ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/airoha-cpufreq.c:27:41: error: storage size of 'args' isn't known
      27 |         const struct arm_smccc_1_2_regs args = {
         |                                         ^~~~
>> drivers/cpufreq/airoha-cpufreq.c:31:35: error: storage size of 'res' isn't known
      31 |         struct arm_smccc_1_2_regs res;
         |                                   ^~~
>> drivers/cpufreq/airoha-cpufreq.c:33:9: error: implicit declaration of function 'arm_smccc_1_2_smc'; did you mean 'arm_smccc_1_1_smc'? [-Wimplicit-function-declaration]
      33 |         arm_smccc_1_2_smc(&args, &res);
         |         ^~~~~~~~~~~~~~~~~
         |         arm_smccc_1_1_smc
>> drivers/cpufreq/airoha-cpufreq.c:31:35: warning: unused variable 'res' [-Wunused-variable]
      31 |         struct arm_smccc_1_2_regs res;
         |                                   ^~~
>> drivers/cpufreq/airoha-cpufreq.c:27:41: warning: unused variable 'args' [-Wunused-variable]
      27 |         const struct arm_smccc_1_2_regs args = {
         |                                         ^~~~
   drivers/cpufreq/airoha-cpufreq.c: In function 'airoha_cpufreq_set_target':
   drivers/cpufreq/airoha-cpufreq.c:40:22: error: variable 'args' has initializer but incomplete type
      40 |         const struct arm_smccc_1_2_regs args = {
         |                      ^~~~~~~~~~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:41:18: error: 'const struct arm_smccc_1_2_regs' has no member named 'a0'
      41 |                 .a0 = AIROHA_SIP_AVS_HANDLE,
         |                  ^~
>> drivers/cpufreq/airoha-cpufreq.c:7:49: warning: excess elements in struct initializer
       7 | #define AIROHA_SIP_AVS_HANDLE                   0x82000301
         |                                                 ^~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:41:23: note: in expansion of macro 'AIROHA_SIP_AVS_HANDLE'
      41 |                 .a0 = AIROHA_SIP_AVS_HANDLE,
         |                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:7:49: note: (near initialization for 'args')
       7 | #define AIROHA_SIP_AVS_HANDLE                   0x82000301
         |                                                 ^~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:41:23: note: in expansion of macro 'AIROHA_SIP_AVS_HANDLE'
      41 |                 .a0 = AIROHA_SIP_AVS_HANDLE,
         |                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:42:18: error: 'const struct arm_smccc_1_2_regs' has no member named 'a1'
      42 |                 .a1 = AIROHA_AVS_OP_FREQ_DYN_ADJ,
         |                  ^~
   drivers/cpufreq/airoha-cpufreq.c:10:49: warning: excess elements in struct initializer
      10 | #define AIROHA_AVS_OP_FREQ_DYN_ADJ              (AIROHA_AVS_OP_BASE | \
         |                                                 ^
   drivers/cpufreq/airoha-cpufreq.c:42:23: note: in expansion of macro 'AIROHA_AVS_OP_FREQ_DYN_ADJ'
      42 |                 .a1 = AIROHA_AVS_OP_FREQ_DYN_ADJ,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/airoha-cpufreq.c:10:49: note: (near initialization for 'args')
      10 | #define AIROHA_AVS_OP_FREQ_DYN_ADJ              (AIROHA_AVS_OP_BASE | \
         |                                                 ^
   drivers/cpufreq/airoha-cpufreq.c:42:23: note: in expansion of macro 'AIROHA_AVS_OP_FREQ_DYN_ADJ'
      42 |                 .a1 = AIROHA_AVS_OP_FREQ_DYN_ADJ,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/airoha-cpufreq.c:43:18: error: 'const struct arm_smccc_1_2_regs' has no member named 'a3'
      43 |                 .a3 = index,
         |                  ^~
   drivers/cpufreq/airoha-cpufreq.c:43:23: warning: excess elements in struct initializer
      43 |                 .a3 = index,
         |                       ^~~~~
   drivers/cpufreq/airoha-cpufreq.c:43:23: note: (near initialization for 'args')
   drivers/cpufreq/airoha-cpufreq.c:40:41: error: storage size of 'args' isn't known
      40 |         const struct arm_smccc_1_2_regs args = {
         |                                         ^~~~
   drivers/cpufreq/airoha-cpufreq.c:45:35: error: storage size of 'res' isn't known
      45 |         struct arm_smccc_1_2_regs res;
         |                                   ^~~
   drivers/cpufreq/airoha-cpufreq.c:45:35: warning: unused variable 'res' [-Wunused-variable]
   drivers/cpufreq/airoha-cpufreq.c:40:41: warning: unused variable 'args' [-Wunused-variable]
      40 |         const struct arm_smccc_1_2_regs args = {
         |                                         ^~~~
   drivers/cpufreq/airoha-cpufreq.c: In function 'airoha_cpufreq_init':
>> drivers/cpufreq/airoha-cpufreq.c:68:24: warning: variable 'cpu_dev' set but not used [-Wunused-but-set-variable]
      68 |         struct device *cpu_dev;
         |                        ^~~~~~~
   drivers/cpufreq/airoha-cpufreq.c: In function 'airoha_cpufreq_driver_init_cpu':
>> drivers/cpufreq/airoha-cpufreq.c:103:16: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
     103 |         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
         |                ^~~~~~~
>> drivers/cpufreq/airoha-cpufreq.c:103:14: error: assignment to 'struct airoha_cpufreq_priv *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     103 |         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
         |              ^
   drivers/cpufreq/airoha-cpufreq.c: In function 'airoha_cpufreq_release':
>> drivers/cpufreq/airoha-cpufreq.c:145:17: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Wimplicit-function-declaration]
     145 |                 kfree(priv);
         |                 ^~~~~
         |                 kvfree
   drivers/cpufreq/airoha-cpufreq.c: In function 'airoha_cpufreq_get':
>> drivers/cpufreq/airoha-cpufreq.c:36:1: warning: control reaches end of non-void function [-Wreturn-type]
      36 | }
         | ^
   drivers/cpufreq/airoha-cpufreq.c: In function 'airoha_cpufreq_set_target':
   drivers/cpufreq/airoha-cpufreq.c:51:1: warning: control reaches end of non-void function [-Wreturn-type]
      51 | }
         | ^


vim +/args +27 drivers/cpufreq/airoha-cpufreq.c

     6	
   > 7	#define AIROHA_SIP_AVS_HANDLE			0x82000301
     8	#define AIROHA_AVS_OP_BASE			0xddddddd0
     9	#define AIROHA_AVS_OP_MASK			GENMASK(1, 0)
    10	#define AIROHA_AVS_OP_FREQ_DYN_ADJ		(AIROHA_AVS_OP_BASE | \
    11							 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x1))
    12	#define AIROHA_AVS_OP_GET_FREQ			(AIROHA_AVS_OP_BASE | \
  > 13							 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x2))
    14	
    15	struct airoha_cpufreq_priv {
    16		struct list_head list;
    17	
    18		cpumask_var_t cpus;
    19		struct device *cpu_dev;
    20		struct cpufreq_frequency_table *freq_table;
    21	};
    22	
    23	static LIST_HEAD(priv_list);
    24	
    25	static unsigned int airoha_cpufreq_get(unsigned int cpu)
    26	{
  > 27		const struct arm_smccc_1_2_regs args = {
  > 28			.a0 = AIROHA_SIP_AVS_HANDLE,
  > 29			.a1 = AIROHA_AVS_OP_GET_FREQ,
    30		};
  > 31		struct arm_smccc_1_2_regs res;
    32	
  > 33		arm_smccc_1_2_smc(&args, &res);
    34	
    35		return (int)(res.a0 * 1000);
  > 36	}
    37	
    38	static int airoha_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
    39	{
    40		const struct arm_smccc_1_2_regs args = {
    41			.a0 = AIROHA_SIP_AVS_HANDLE,
    42			.a1 = AIROHA_AVS_OP_FREQ_DYN_ADJ,
  > 43			.a3 = index,
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
  > 68		struct device *cpu_dev;
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

