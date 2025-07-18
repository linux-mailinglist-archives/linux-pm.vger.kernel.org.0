Return-Path: <linux-pm+bounces-31042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BABB09975
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 03:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810CC16A838
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 01:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A71191F91;
	Fri, 18 Jul 2025 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+dM83ST"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5A10957;
	Fri, 18 Jul 2025 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803897; cv=none; b=c8LP7CF9eQi4lT8cSvUcXThQfcDUkpUpTssbg1jxfqjCTOax4qZCfY27Rth2VQTTc6UAH/QC/JioKm47aV2tWm8E6/hjlG9fpd6dmrgNRzam2L002p6Wh//zncesm21IVZJvXZJkP86lBjYO87pwozecso2VVKcAZwfBLuNKasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803897; c=relaxed/simple;
	bh=GNaYOctQg5LyTxreYQeQjCllTFqqRPjbCFBYOUDt0rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+HyRLTv5jBVBUnvBXPnR3PmaL/hzpiMURvk84K3gH8NotMf++umBJWYEc67myTXtRJ2SHNtfNMhyePtUjOzpMHO5yU+BzeHeqgoo0b/G+cChv4inu73hzuzzeOcVLU1vyQFHl9wsTk+qVSCHB42wTnA22uH44HTpTXh5u1b+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+dM83ST; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752803896; x=1784339896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GNaYOctQg5LyTxreYQeQjCllTFqqRPjbCFBYOUDt0rQ=;
  b=g+dM83STmJ9iRY5m5cQvh4qoiNF8sjEsNpTk4F0QYe7x2+ONh38yIOQw
   x2mwpmgpZ0vMN827dSnLw41rkC9PQRoM1+Ki+6TvyyhoS8HNGRBXEJt9s
   A4D/u85II7saGY7KrszXPpp2bju4RlwJX3yH7IaTJH6mvVOlspn+Wi90u
   RkS4kjjf8l0vrM2chHVja/nFKnfE7SaT/jLPw+2dDZUzVKR1DHH8oMO3U
   8O2TBr25DwrrFkvVRr8RogXc45MTk5m/I6QzjuQf72X5nEeIF0lhUrDz4
   y3vTaCONQfBSI6cxpyVCsQddTo0OcydOQu+fcp4o1nySSxm8/M6WaiZP/
   Q==;
X-CSE-ConnectionGUID: +A+9wwH1TPyGM8Qe7glrJw==
X-CSE-MsgGUID: Og4XOWHsRQWGaguq2VLjwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66443463"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="66443463"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 18:58:03 -0700
X-CSE-ConnectionGUID: GU+lZIABSmC7EohNiknNkQ==
X-CSE-MsgGUID: Ob1amxHeR922SqEVVIVuHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="163473200"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jul 2025 18:58:02 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucaMJ-000EE7-2I;
	Fri, 18 Jul 2025 01:57:59 +0000
Date: Fri, 18 Jul 2025 09:57:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gaowei Pu <pugaowei@oppo.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Gaowei Pu <pugaowei@oppo.com>
Subject: Re: [PATCH v2] cpufreq: queue policy->update work to a dedicated
 thread
Message-ID: <202507180955.YXkJg7bR-lkp@intel.com>
References: <20250717085110.1468-1-pugaowei@oppo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717085110.1468-1-pugaowei@oppo.com>

Hi Gaowei,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.16-rc6]
[also build test ERROR on linus/master next-20250717]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gaowei-Pu/cpufreq-queue-policy-update-work-to-a-dedicated-thread/20250717-165319
base:   v6.16-rc6
patch link:    https://lore.kernel.org/r/20250717085110.1468-1-pugaowei%40oppo.com
patch subject: [PATCH v2] cpufreq: queue policy->update work to a dedicated thread
config: i386-buildonly-randconfig-003-20250718 (https://download.01.org/0day-ci/archive/20250718/202507180955.YXkJg7bR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250718/202507180955.YXkJg7bR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507180955.YXkJg7bR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cpufreq/cpufreq.c: In function 'cpufreq_policy_alloc':
>> drivers/cpufreq/cpufreq.c:1308:26: error: too many arguments to function 'kthread_create_worker_on_cpu'
    1308 |         policy->worker = kthread_create_worker_on_cpu(cpu, 0, "policy_worker%d", cpu);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/cpufreq.h:23,
                    from drivers/cpufreq/cpufreq.c:18:
   include/linux/kthread.h:216:1: note: declared here
     216 | kthread_create_worker_on_cpu(int cpu, unsigned int flags,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/kthread_create_worker_on_cpu +1308 drivers/cpufreq/cpufreq.c

  1250	
  1251	static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
  1252	{
  1253		struct cpufreq_policy *policy;
  1254		struct device *dev = get_cpu_device(cpu);
  1255		int ret;
  1256	
  1257		if (!dev)
  1258			return NULL;
  1259	
  1260		policy = kzalloc(sizeof(*policy), GFP_KERNEL);
  1261		if (!policy)
  1262			return NULL;
  1263	
  1264		if (!alloc_cpumask_var(&policy->cpus, GFP_KERNEL))
  1265			goto err_free_policy;
  1266	
  1267		if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
  1268			goto err_free_cpumask;
  1269	
  1270		if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
  1271			goto err_free_rcpumask;
  1272	
  1273		init_completion(&policy->kobj_unregister);
  1274		ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
  1275					   cpufreq_global_kobject, "policy%u", cpu);
  1276		if (ret) {
  1277			dev_err(dev, "%s: failed to init policy->kobj: %d\n", __func__, ret);
  1278			/*
  1279			 * The entire policy object will be freed below, but the extra
  1280			 * memory allocated for the kobject name needs to be freed by
  1281			 * releasing the kobject.
  1282			 */
  1283			kobject_put(&policy->kobj);
  1284			goto err_free_real_cpus;
  1285		}
  1286	
  1287		freq_constraints_init(&policy->constraints);
  1288	
  1289		policy->nb_min.notifier_call = cpufreq_notifier_min;
  1290		policy->nb_max.notifier_call = cpufreq_notifier_max;
  1291	
  1292		ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MIN,
  1293					    &policy->nb_min);
  1294		if (ret) {
  1295			dev_err(dev, "Failed to register MIN QoS notifier: %d (CPU%u)\n",
  1296				ret, cpu);
  1297			goto err_kobj_remove;
  1298		}
  1299	
  1300		ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MAX,
  1301					    &policy->nb_max);
  1302		if (ret) {
  1303			dev_err(dev, "Failed to register MAX QoS notifier: %d (CPU%u)\n",
  1304				ret, cpu);
  1305			goto err_min_qos_notifier;
  1306		}
  1307	
> 1308		policy->worker = kthread_create_worker_on_cpu(cpu, 0, "policy_worker%d", cpu);
  1309		if (IS_ERR(policy->worker)) {
  1310			dev_err(dev, "Failed to create policy_worker%d\n", cpu);
  1311			goto err_max_qos_notifier;
  1312		}
  1313	
  1314		INIT_LIST_HEAD(&policy->policy_list);
  1315		init_rwsem(&policy->rwsem);
  1316		spin_lock_init(&policy->transition_lock);
  1317		init_waitqueue_head(&policy->transition_wait);
  1318		kthread_init_work(&policy->update, handle_update);
  1319	
  1320		return policy;
  1321	
  1322	err_max_qos_notifier:
  1323		freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MAX,
  1324					 &policy->nb_max);
  1325	err_min_qos_notifier:
  1326		freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
  1327					 &policy->nb_min);
  1328	err_kobj_remove:
  1329		cpufreq_policy_put_kobj(policy);
  1330	err_free_real_cpus:
  1331		free_cpumask_var(policy->real_cpus);
  1332	err_free_rcpumask:
  1333		free_cpumask_var(policy->related_cpus);
  1334	err_free_cpumask:
  1335		free_cpumask_var(policy->cpus);
  1336	err_free_policy:
  1337		kfree(policy);
  1338	
  1339		return NULL;
  1340	}
  1341	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

