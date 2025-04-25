Return-Path: <linux-pm+bounces-26185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2156BA9C512
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C37716D8A5
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F2218858;
	Fri, 25 Apr 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/LWWgGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5421C8600;
	Fri, 25 Apr 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576284; cv=none; b=ffcJz0lf0+DJ9ZpyWmoORTljuE9vvVMP5EqxPXF3HboWjmmwgN+AOvQ7jYjY9Ri73SGvNEDhkL4QX1D3Amroac3uA+BarGfXlrCiI4QGn5HOIoV8Xk3vgZLRp3CR8iYgXbYJ5MrZL/MySDN249ouaxURvaJTy8uAEo8CLZXQA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576284; c=relaxed/simple;
	bh=CAARS+8LNUjnSfZXJGSR8d4F58Pl4bjzLGrLrrFkSaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTI0ueIN5NhD59LvzSthIEHKW6fi3M8Slg8xsK8ZB0DKW474uYSTcEMVrX+2BP6lIFAAblY1x6br7vgu42OsKTWWJMZRssxI/EMHyQ1rSuZWIcIctZR4BvLsqvwKxlkbTh4uOSmI/fdDYF7UAhSRjtusHg3npKld+JHgAwOKdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/LWWgGS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745576283; x=1777112283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CAARS+8LNUjnSfZXJGSR8d4F58Pl4bjzLGrLrrFkSaU=;
  b=Y/LWWgGSSgS3uMbjJGzVw71o/+xTFZLFbcO698dErVkFRCySdp8jQHNx
   bOl1dQct2hUH3Q/YPzJx6+YfAhvxDVB9YhQdanutdeuioKMLxaIzmu3wx
   IGdw1ts7eMYwWAu2ApHWUHNHi3i6fEBRT1Dj38W6dTIwI/kzl2/8TBRe0
   5P7Gvayea10R0xzgED8nkjnYo5KDuzj+wzHYdZqCysOgsVr0mhwNHZtuK
   qjlP0Mr8+Uy1IaK6183RVi4oFCtVgsOPz3jiLA0pvJJlnHST6x0pKwPYj
   8VXHnB2FNRkg69Dnm2L26hEuMV+Do6iD4iiOS7sl/Rl4dyfNtbDp81pRA
   A==;
X-CSE-ConnectionGUID: Et2EeD7XTha66UtjODWFUQ==
X-CSE-MsgGUID: wlWlNCrsTY6BYUoGLeXvUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="72604917"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="72604917"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 03:18:02 -0700
X-CSE-ConnectionGUID: Qx88MaN9Qha8IRwFQSi98w==
X-CSE-MsgGUID: eCn3RALWQ3G5XTbYuQmzLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133376590"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Apr 2025 03:18:00 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8G85-00053Z-2H;
	Fri, 25 Apr 2025 10:17:57 +0000
Date: Fri, 25 Apr 2025 18:17:06 +0800
From: kernel test robot <lkp@intel.com>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, rafael@kernel.org,
	pavel@kernel.org, len.brown@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_zhonhan@quicinc.com
Subject: Re: [PATCH] PM: QoS: Add support for CPU affinity mask-based CPUs
 latency QoS
Message-ID: <202504251805.5dAJMVbD-lkp@intel.com>
References: <20250424095228.1112558-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424095228.1112558-1-quic_zhonhan@quicinc.com>

Hi Zhongqiu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.15-rc3 next-20250424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhongqiu-Han/PM-QoS-Add-support-for-CPU-affinity-mask-based-CPUs-latency-QoS/20250424-175559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250424095228.1112558-1-quic_zhonhan%40quicinc.com
patch subject: [PATCH] PM: QoS: Add support for CPU affinity mask-based CPUs latency QoS
config: i386-buildonly-randconfig-001-20250425 (https://download.01.org/0day-ci/archive/20250425/202504251805.5dAJMVbD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250425/202504251805.5dAJMVbD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504251805.5dAJMVbD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/power/qos.c:344: warning: Function parameter or struct member 'cpu' not described in 'wakeup_qos_affinity_idle_cpu'
>> kernel/power/qos.c:368: warning: Function parameter or struct member 'latency_value' not described in 'cpu_latency_qos_affinity_add'
>> kernel/power/qos.c:368: warning: Excess function parameter 'new_value' description in 'cpu_latency_qos_affinity_add'
>> kernel/power/qos.c:479: warning: Function parameter or struct member 'pm_reqs' not described in 'cpu_latency_qos_affinity_release'
>> kernel/power/qos.c:479: warning: Excess function parameter 'pm_req' description in 'cpu_latency_qos_affinity_release'


vim +344 kernel/power/qos.c

   339	
   340	/**
   341	 * wakeup_qos_affinity_idle_cpu - break one specific cpu out of idle.
   342	 */
   343	void wakeup_qos_affinity_idle_cpu(int cpu)
 > 344	{
   345		preempt_disable();
   346		if (cpu != smp_processor_id() && cpu_online(cpu))
   347			wake_up_if_idle(cpu);
   348		preempt_enable();
   349	}
   350	
   351	/**
   352	 * cpu_latency_qos_affinity_add - Add new CPU affinity latency QoS request.
   353	 * @pm_req : Pointer to a preallocated handle.
   354	 * @affinity_mask: Mask to determine which CPUs need latency QoS.
   355	 * @new_value: New requested constraint value.
   356	 *
   357	 * Use @latency_value to initialize the request handle pointed to by @pm_req,
   358	 * insert it as a new entry to the CPU latency QoS list and recompute the
   359	 * effective QoS constraint for that list, @affinity_mask determine which CPUs
   360	 * need the latency QoS.
   361	 *
   362	 * Callers need to save the handle for later use in updates and removal of the
   363	 * QoS request represented by it.
   364	 */
   365	int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
   366					 const cpumask_t *affinity_mask,
   367					 s32 latency_value)
 > 368	{
   369		int cpu;
   370		cpumask_t actual_mask;
   371		struct cpu_affinity_qos_req *cpu_pm_req;
   372		int ret = 0;
   373	
   374		if (!pm_req)
   375			pr_err("%s: invalid PM Qos request\n", __func__);
   376	
   377		INIT_LIST_HEAD(&pm_req->list);
   378	
   379		if (!affinity_mask || cpumask_empty(affinity_mask) ||
   380		    latency_value < 0) {
   381			pr_err("%s: invalid PM Qos request value\n", __func__);
   382			return -EINVAL;
   383		}
   384	
   385		for_each_cpu(cpu, affinity_mask) {
   386			cpu_pm_req = kzalloc(sizeof(struct cpu_affinity_qos_req),
   387					     GFP_KERNEL);
   388			if (!cpu_pm_req) {
   389				ret = -ENOMEM;
   390				goto out_err;
   391			}
   392			ret = dev_pm_qos_add_request(get_cpu_device(cpu),
   393						     &cpu_pm_req->req,
   394						     DEV_PM_QOS_RESUME_LATENCY,
   395						     latency_value);
   396			if (ret < 0) {
   397				pr_err("failed to add latency req for cpu%d", cpu);
   398				kfree(cpu_pm_req);
   399				goto out_err;
   400			} else if (ret > 0) {
   401				wakeup_qos_affinity_idle_cpu(cpu);
   402			}
   403	
   404			cpumask_set_cpu(cpu, &actual_mask);
   405			list_add(&cpu_pm_req->list, &pm_req->list);
   406		}
   407	
   408		pr_info("PM Qos latency: %d added on cpus %*pb\n", latency_value,
   409			cpumask_pr_args(&actual_mask));
   410	
   411		return ret;
   412	
   413	out_err:
   414		cpu_latency_qos_affinity_release(&pm_req->list);
   415		pr_err("failed to add PM QoS latency req, removed all added requests\n");
   416		return ret;
   417	}
   418	EXPORT_SYMBOL_GPL(cpu_latency_qos_affinity_add);
   419	
   420	/**
   421	 * cpu_latency_qos_affinity_update - Modify existing CPU affinity latency QoS.
   422	 * @pm_req : QoS request to update for CPUs with affinity masks.
   423	 * @new_value: New requested constraint value.
   424	 *
   425	 * Use @new_value to update the QoS request represented by @pm_req in the CPU
   426	 * latency QoS list along with updating the effective constraint value for that
   427	 * list.
   428	 */
   429	int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
   430					    s32 new_value)
   431	{
   432		struct cpu_affinity_qos_req *cpu_pm_req, *next;
   433		int ret = 0;
   434	
   435		if (!pm_req || new_value < 0 || list_empty(&pm_req->list)) {
   436			pr_err("%s: invalid PM Qos request value\n", __func__);
   437			return -EINVAL;
   438		}
   439	
   440		list_for_each_entry_safe(cpu_pm_req, next, &pm_req->list, list) {
   441			ret = dev_pm_qos_update_request(&cpu_pm_req->req, new_value);
   442			if (ret < 0) {
   443				pr_err("PM QoS qos update failed for %s\n",
   444				       dev_name(cpu_pm_req->req.dev));
   445			} else if (ret > 0) {
   446				wakeup_qos_affinity_idle_cpu(cpu_pm_req->req.dev->id);
   447			}
   448		}
   449	
   450		return ret;
   451	}
   452	EXPORT_SYMBOL_GPL(cpu_latency_qos_affinity_update);
   453	
   454	/**
   455	 * cpu_latency_qos_affinity_remove - Remove existing CPU affinity latency QoS.
   456	 * @pm_req: QoS request to update for CPUs with affinity masks.
   457	 *
   458	 * Remove the CPU latency QoS request represented by @pm_req from the CPU latency
   459	 * QoS list.
   460	 */
   461	int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
   462	{
   463		if (!pm_req || list_empty(&pm_req->list)) {
   464			pr_err("%s: invalid PM Qos request value\n", __func__);
   465			return -EINVAL;
   466		}
   467	
   468		return cpu_latency_qos_affinity_release(&pm_req->list);
   469	}
   470	EXPORT_SYMBOL_GPL(cpu_latency_qos_affinity_remove);
   471	
   472	/**
   473	 * cpu_latency_qos_affinity_release - Release pm_reqs latency QoS resource.
   474	 * @pm_req: QoS request to remove.
   475	 *
   476	 * Release pm_reqs managed CPU affinity latency QoS resource.
   477	 */
   478	int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
 > 479	{
   480		int ret = 0;
   481		struct cpu_affinity_qos_req *cpu_pm_req, *next;
   482	
   483		list_for_each_entry_safe(cpu_pm_req, next, pm_reqs, list) {
   484			ret = dev_pm_qos_remove_request(&cpu_pm_req->req);
   485			if (ret < 0)
   486				pr_err("failed to remove qos request for %s\n",
   487				       dev_name(cpu_pm_req->req.dev));
   488			list_del(&cpu_pm_req->list);
   489			kfree(cpu_pm_req);
   490		}
   491	
   492		return ret;
   493	}
   494	#endif /* CONFIG_PM */
   495	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

