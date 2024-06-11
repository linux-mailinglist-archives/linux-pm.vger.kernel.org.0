Return-Path: <linux-pm+bounces-8976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7416F9046E0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 00:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012761F245DF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 22:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DC8155308;
	Tue, 11 Jun 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQzXnwIP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750D18EAB;
	Tue, 11 Jun 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144596; cv=none; b=WW/ubwrjTzGu6i9VxrFDIW7P68PG9aSwCQX+RAt6SlX46fjKLxvlx6H0L6MwzRlNlowEeUYVjlT51qklgGUUjbDbaTtL9LsCq/wYg5cpe8YE0V3D2hnLSsfx0Mvg/TMkS41B2SpJudXBi/d1crgdgVHSl8Elj0Wmr78fHA2cuMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144596; c=relaxed/simple;
	bh=wdJEJplrsJKkj19NRnWfF8Z6F53YK6bJ3harSmrgip8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5rvOfLzPDc8405Xe04IhzXt3Fne+KO2EHjv8PCzY0CKQ+U5HQ7EWKzqZFpv/CG+Tk/5gDDkL3Oj4lI3HHoLEOaP57aIyGlykgMtOhJT/QAAnSC1WLlYAB6bgcbdtumViSKrM4LD9CW+b46Fdb4W9AzXRT1tjkUTYzeqqfd1eXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQzXnwIP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718144593; x=1749680593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wdJEJplrsJKkj19NRnWfF8Z6F53YK6bJ3harSmrgip8=;
  b=bQzXnwIPtGUkwhFOyij+w+hCBjM4nF1Agaj8kPFuSsd5pFtdXnuexn/t
   lD53hD3gaFdLVMmbONrabJvjN/vLPH8u+Jvp9zeOL+hGYdY4Tq3GK/WZa
   9OjRuSEhVaR1kgPwoQVQ3iPRjTdoK4uBGYRetVXErhFETctxzU1sATjdc
   AVV+phHLOwhyLK95vpQDCfzDWpFbdublw8k6U6kvrweH7GA01TSAMyjGQ
   7JIVMin4exWzukpQm6TMG7JmRI9jLQQx+8wvO86a6WpR7vOzCi1RXVXTM
   9SnWHw8qaLbKehE6GyVVqr2itWnuZH4b0fSa4SEYDlzG/zpz9CFxmGurZ
   Q==;
X-CSE-ConnectionGUID: w1EPIjMxTh6dHgdOMLn47g==
X-CSE-MsgGUID: i40Qa3QcQfuf7aCU8uTC0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="12029044"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="12029044"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 15:23:13 -0700
X-CSE-ConnectionGUID: LGiuR43SR8GtXgt+tg75CQ==
X-CSE-MsgGUID: D2GJ5rkTTx+D/QJ//02/9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="44011591"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Jun 2024 15:23:10 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sH9tU-0000xi-1S;
	Tue, 11 Jun 2024 22:23:08 +0000
Date: Wed, 12 Jun 2024 06:22:34 +0800
From: kernel test robot <lkp@intel.com>
To: PoShao Chen <poshao.chen@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	clive.lin@mediatek.com, ccj.yeh@mediatek.com,
	ching-hao.hsu@mediatek.com, poshao.chen@mediatek.com
Subject: Re: [PATCH] cpufreq: Fix per-policy boost behavior after CPU hotplug
Message-ID: <202406120637.OfjjCrcJ-lkp@intel.com>
References: <20240611115920.28665-1-poshao.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611115920.28665-1-poshao.chen@mediatek.com>

Hi PoShao,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc3 next-20240611]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/PoShao-Chen/cpufreq-Fix-per-policy-boost-behavior-after-CPU-hotplug/20240611-200804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240611115920.28665-1-poshao.chen%40mediatek.com
patch subject: [PATCH] cpufreq: Fix per-policy boost behavior after CPU hotplug
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240612/202406120637.OfjjCrcJ-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4403cdbaf01379de96f8d0d6ea4f51a085e37766)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240612/202406120637.OfjjCrcJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406120637.OfjjCrcJ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/cpufreq.c:23:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/cpufreq/cpufreq.c:1515:13: warning: missing terminating '"' character [-Winvalid-pp-token]
    1515 |                                 pr_info("%s: per-policy boost flag mirror the cpufreq_driver
         |                                         ^
   drivers/cpufreq/cpufreq.c:1516:13: warning: missing terminating '"' character [-Winvalid-pp-token]
    1516 |                                         boost\n", __func__);
         |                                                ^
   drivers/cpufreq/cpufreq.c:1522:13: warning: missing terminating '"' character [-Winvalid-pp-token]
    1522 |                                         pr_err("%s: per-policy boost flag mirror the cpufreq_driver
         |                                                ^
   drivers/cpufreq/cpufreq.c:1523:21: warning: missing terminating '"' character [-Winvalid-pp-token]
    1523 |                                                 boost failed\n", __func__);
         |                                                               ^
>> drivers/cpufreq/cpufreq.c:1515:5: error: unterminated function-like macro invocation
    1515 |                                 pr_info("%s: per-policy boost flag mirror the cpufreq_driver
         |                                 ^
   include/linux/printk.h:536:9: note: macro 'pr_info' defined here
     536 | #define pr_info(fmt, ...) \
         |         ^
>> drivers/cpufreq/cpufreq.c:3092:34: error: expected '}'
    3092 | core_initcall(cpufreq_core_init);
         |                                  ^
   drivers/cpufreq/cpufreq.c:1514:65: note: to match this '{'
    1514 |                         if (policy->boost_enabled && !cpufreq_driver->boost_enabled) {
         |                                                                                      ^
>> drivers/cpufreq/cpufreq.c:3092:34: error: expected '}'
    3092 | core_initcall(cpufreq_core_init);
         |                                  ^
   drivers/cpufreq/cpufreq.c:1509:10: note: to match this '{'
    1509 |                 } else {
         |                        ^
>> drivers/cpufreq/cpufreq.c:3092:34: error: expected '}'
    3092 | core_initcall(cpufreq_core_init);
         |                                  ^
   drivers/cpufreq/cpufreq.c:1498:9: note: to match this '{'
    1498 |         } else {
         |                ^
>> drivers/cpufreq/cpufreq.c:3092:34: error: expected '}'
    3092 | core_initcall(cpufreq_core_init);
         |                                  ^
   drivers/cpufreq/cpufreq.c:1380:1: note: to match this '{'
    1380 | {
         | ^
>> drivers/cpufreq/cpufreq.c:1417:9: error: use of undeclared label 'out_exit_policy'
    1417 |                         goto out_exit_policy;
         |                              ^
>> drivers/cpufreq/cpufreq.c:1430:9: error: use of undeclared label 'out_free_policy'
    1430 |                         goto out_free_policy;
         |                              ^
>> drivers/cpufreq/cpufreq.c:1443:9: error: use of undeclared label 'out_offline_policy'
    1443 |                         goto out_offline_policy;
         |                              ^
>> drivers/cpufreq/cpufreq.c:1465:9: error: use of undeclared label 'out_destroy_policy'
    1465 |                         goto out_destroy_policy;
         |                              ^
   5 warnings and 9 errors generated.


vim +1515 drivers/cpufreq/cpufreq.c

  1378	
  1379	static int cpufreq_online(unsigned int cpu)
  1380	{
  1381		struct cpufreq_policy *policy;
  1382		bool new_policy;
  1383		unsigned long flags;
  1384		unsigned int j;
  1385		int ret;
  1386	
  1387		pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
  1388	
  1389		/* Check if this CPU already has a policy to manage it */
  1390		policy = per_cpu(cpufreq_cpu_data, cpu);
  1391		if (policy) {
  1392			WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
  1393			if (!policy_is_inactive(policy))
  1394				return cpufreq_add_policy_cpu(policy, cpu);
  1395	
  1396			/* This is the only online CPU for the policy.  Start over. */
  1397			new_policy = false;
  1398			down_write(&policy->rwsem);
  1399			policy->cpu = cpu;
  1400			policy->governor = NULL;
  1401		} else {
  1402			new_policy = true;
  1403			policy = cpufreq_policy_alloc(cpu);
  1404			if (!policy)
  1405				return -ENOMEM;
  1406			down_write(&policy->rwsem);
  1407		}
  1408	
  1409		if (!new_policy && cpufreq_driver->online) {
  1410			/* Recover policy->cpus using related_cpus */
  1411			cpumask_copy(policy->cpus, policy->related_cpus);
  1412	
  1413			ret = cpufreq_driver->online(policy);
  1414			if (ret) {
  1415				pr_debug("%s: %d: initialization failed\n", __func__,
  1416					 __LINE__);
> 1417				goto out_exit_policy;
  1418			}
  1419		} else {
  1420			cpumask_copy(policy->cpus, cpumask_of(cpu));
  1421	
  1422			/*
  1423			 * Call driver. From then on the cpufreq must be able
  1424			 * to accept all calls to ->verify and ->setpolicy for this CPU.
  1425			 */
  1426			ret = cpufreq_driver->init(policy);
  1427			if (ret) {
  1428				pr_debug("%s: %d: initialization failed\n", __func__,
  1429					 __LINE__);
> 1430				goto out_free_policy;
  1431			}
  1432	
  1433			/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
  1434			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
  1435	
  1436			/*
  1437			 * The initialization has succeeded and the policy is online.
  1438			 * If there is a problem with its frequency table, take it
  1439			 * offline and drop it.
  1440			 */
  1441			ret = cpufreq_table_validate_and_sort(policy);
  1442			if (ret)
> 1443				goto out_offline_policy;
  1444	
  1445			/* related_cpus should at least include policy->cpus. */
  1446			cpumask_copy(policy->related_cpus, policy->cpus);
  1447		}
  1448	
  1449		/*
  1450		 * affected cpus must always be the one, which are online. We aren't
  1451		 * managing offline cpus here.
  1452		 */
  1453		cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
  1454	
  1455		if (new_policy) {
  1456			for_each_cpu(j, policy->related_cpus) {
  1457				per_cpu(cpufreq_cpu_data, j) = policy;
  1458				add_cpu_dev_symlink(policy, j, get_cpu_device(j));
  1459			}
  1460	
  1461			policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
  1462						       GFP_KERNEL);
  1463			if (!policy->min_freq_req) {
  1464				ret = -ENOMEM;
> 1465				goto out_destroy_policy;
  1466			}
  1467	
  1468			ret = freq_qos_add_request(&policy->constraints,
  1469						   policy->min_freq_req, FREQ_QOS_MIN,
  1470						   FREQ_QOS_MIN_DEFAULT_VALUE);
  1471			if (ret < 0) {
  1472				/*
  1473				 * So we don't call freq_qos_remove_request() for an
  1474				 * uninitialized request.
  1475				 */
  1476				kfree(policy->min_freq_req);
  1477				policy->min_freq_req = NULL;
  1478				goto out_destroy_policy;
  1479			}
  1480	
  1481			/*
  1482			 * This must be initialized right here to avoid calling
  1483			 * freq_qos_remove_request() on uninitialized request in case
  1484			 * of errors.
  1485			 */
  1486			policy->max_freq_req = policy->min_freq_req + 1;
  1487	
  1488			ret = freq_qos_add_request(&policy->constraints,
  1489						   policy->max_freq_req, FREQ_QOS_MAX,
  1490						   FREQ_QOS_MAX_DEFAULT_VALUE);
  1491			if (ret < 0) {
  1492				policy->max_freq_req = NULL;
  1493				goto out_destroy_policy;
  1494			}
  1495	
  1496			blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
  1497					CPUFREQ_CREATE_POLICY, policy);
  1498		} else {
  1499			/*
  1500			 * Call freq_qos_update_request() for the per-policy boost flag mirror
  1501			 * the cpufreq_driver boost during hotplug online.
  1502			 * Register an online callback if the default mirroring of the global
  1503			 * boost setting is not intended.
  1504			 */
  1505			if (!cpufreq_driver->online) {
  1506				ret = freq_qos_update_request(policy->max_freq_req, policy->max);
  1507				if (ret)
  1508					pr_err("%s: freq qos update failed\n", __func__);
  1509			} else {
  1510				/*
  1511				 * Let the per-policy boost flag mirror the cpufreq_driver
  1512				 * boost if an illegal state occurs after hotplug
  1513				 */
  1514				if (policy->boost_enabled && !cpufreq_driver->boost_enabled) {
> 1515					pr_info("%s: per-policy boost flag mirror the cpufreq_driver
  1516						boost\n", __func__);
  1517					policy->boost_enabled = cpufreq_driver->boost_enabled;
  1518					ret = cpufreq_driver->set_boost(policy,
  1519								cpufreq_driver->boost_enabled);
  1520					if (ret) {
  1521						policy->boost_enabled = !policy->boost_enabled;
  1522						pr_err("%s: per-policy boost flag mirror the cpufreq_driver
  1523							boost failed\n", __func__);
  1524					}
  1525				}
  1526			}
  1527		}
  1528	
  1529		if (cpufreq_driver->get && has_target()) {
  1530			policy->cur = cpufreq_driver->get(policy->cpu);
  1531			if (!policy->cur) {
  1532				ret = -EIO;
  1533				pr_err("%s: ->get() failed\n", __func__);
  1534				goto out_destroy_policy;
  1535			}
  1536		}
  1537	
  1538		/*
  1539		 * Sometimes boot loaders set CPU frequency to a value outside of
  1540		 * frequency table present with cpufreq core. In such cases CPU might be
  1541		 * unstable if it has to run on that frequency for long duration of time
  1542		 * and so its better to set it to a frequency which is specified in
  1543		 * freq-table. This also makes cpufreq stats inconsistent as
  1544		 * cpufreq-stats would fail to register because current frequency of CPU
  1545		 * isn't found in freq-table.
  1546		 *
  1547		 * Because we don't want this change to effect boot process badly, we go
  1548		 * for the next freq which is >= policy->cur ('cur' must be set by now,
  1549		 * otherwise we will end up setting freq to lowest of the table as 'cur'
  1550		 * is initialized to zero).
  1551		 *
  1552		 * We are passing target-freq as "policy->cur - 1" otherwise
  1553		 * __cpufreq_driver_target() would simply fail, as policy->cur will be
  1554		 * equal to target-freq.
  1555		 */
  1556		if ((cpufreq_driver->flags & CPUFREQ_NEED_INITIAL_FREQ_CHECK)
  1557		    && has_target()) {
  1558			unsigned int old_freq = policy->cur;
  1559	
  1560			/* Are we running at unknown frequency ? */
  1561			ret = cpufreq_frequency_table_get_index(policy, old_freq);
  1562			if (ret == -EINVAL) {
  1563				ret = __cpufreq_driver_target(policy, old_freq - 1,
  1564							      CPUFREQ_RELATION_L);
  1565	
  1566				/*
  1567				 * Reaching here after boot in a few seconds may not
  1568				 * mean that system will remain stable at "unknown"
  1569				 * frequency for longer duration. Hence, a BUG_ON().
  1570				 */
  1571				BUG_ON(ret);
  1572				pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
  1573					__func__, policy->cpu, old_freq, policy->cur);
  1574			}
  1575		}
  1576	
  1577		if (new_policy) {
  1578			ret = cpufreq_add_dev_interface(policy);
  1579			if (ret)
  1580				goto out_destroy_policy;
  1581	
  1582			cpufreq_stats_create_table(policy);
  1583	
  1584			write_lock_irqsave(&cpufreq_driver_lock, flags);
  1585			list_add(&policy->policy_list, &cpufreq_policy_list);
  1586			write_unlock_irqrestore(&cpufreq_driver_lock, flags);
  1587	
  1588			/*
  1589			 * Register with the energy model before
  1590			 * sugov_eas_rebuild_sd() is called, which will result
  1591			 * in rebuilding of the sched domains, which should only be done
  1592			 * once the energy model is properly initialized for the policy
  1593			 * first.
  1594			 *
  1595			 * Also, this should be called before the policy is registered
  1596			 * with cooling framework.
  1597			 */
  1598			if (cpufreq_driver->register_em)
  1599				cpufreq_driver->register_em(policy);
  1600		}
  1601	
  1602		ret = cpufreq_init_policy(policy);
  1603		if (ret) {
  1604			pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
  1605			       __func__, cpu, ret);
  1606			goto out_destroy_policy;
  1607		}
  1608	
  1609		up_write(&policy->rwsem);
  1610	
  1611		kobject_uevent(&policy->kobj, KOBJ_ADD);
  1612	
  1613		/* Callback for handling stuff after policy is ready */
  1614		if (cpufreq_driver->ready)
  1615			cpufreq_driver->ready(policy);
  1616	
  1617		/* Register cpufreq cooling only for a new policy */
  1618		if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
  1619			policy->cdev = of_cpufreq_cooling_register(policy);
  1620	
  1621		pr_debug("initialization complete\n");
  1622	
  1623		return 0;
  1624	
  1625	out_destroy_policy:
  1626		for_each_cpu(j, policy->real_cpus)
  1627			remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
  1628	
  1629	out_offline_policy:
  1630		if (cpufreq_driver->offline)
  1631			cpufreq_driver->offline(policy);
  1632	
  1633	out_exit_policy:
  1634		if (cpufreq_driver->exit)
  1635			cpufreq_driver->exit(policy);
  1636	
  1637	out_free_policy:
  1638		cpumask_clear(policy->cpus);
  1639		up_write(&policy->rwsem);
  1640	
  1641		cpufreq_policy_free(policy);
  1642		return ret;
  1643	}
  1644	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

