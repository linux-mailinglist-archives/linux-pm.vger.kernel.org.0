Return-Path: <linux-pm+bounces-43912-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMlTCXT6rGk1wwEAu9opvQ
	(envelope-from <linux-pm+bounces-43912-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 05:26:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B060E22E76A
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 05:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC48301C3CC
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2026 04:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF0286D4B;
	Sun,  8 Mar 2026 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="as2W/YBR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883961C84A6;
	Sun,  8 Mar 2026 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772943984; cv=none; b=ZZKY7G8GME6nYXmoOfpJCp8R/VmZymX0opP+Cem/EyT9gFAg8U/XCS6DqM276dUg000dEklAp56MyB+k/ey18fKO1RunCQjuVO5dCmXjVpNF5nU3+e768PEJh7eAhV56hTiWp1BqHrFpMPns7619PClEYeU5I1zfFedeMJ9BM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772943984; c=relaxed/simple;
	bh=XNY0rSi3p70citvBmYhhGSIYumaAqYRRuG37tYjCdLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N76C1MoncKN8FOB0taHh5nXl5vT1/uZ1/gYtck4At6jcYHXUO06n+zATaSffwF6kCm3vPkzOR74IQShH8BM+IwCVk4cUfdY08uDewQbjGMmRyI1Rlf8CW81PmycR/KWcpOJJwubRVOjno2IrGSFqLeIiJr3A/usOYd5Z/iLiIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=as2W/YBR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772943983; x=1804479983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XNY0rSi3p70citvBmYhhGSIYumaAqYRRuG37tYjCdLc=;
  b=as2W/YBRXIf4kXFMoD1LWVZo4wb92WkThoRDdX8gX5O+gL5zu05IwA6c
   9+yytYT7PUVjxheoLoNqvc/qfkUpM1IoGldWAy8kMBdIerMhcyoxulhdy
   QvFlOyMlKpIXi3ttfHHUM45Y5vt+75boJVoST4JU8ZlGrRtiX5thftVuS
   EZcawW1KwoM4udWjhVWfmonRa5ZPLVFau/M6P1wxLHylZnsiIQb4vV56e
   C0dUFtuRIMvDgaTICQnmUBGU5LJA4TX9Hax6eHoPzcTj1Vt0izJ7LMgVt
   9V7WkR5Sqi/LUxuR1FuCcbPiN8gmaRliwXmHxhcgrf1jdZe886JOW5adW
   A==;
X-CSE-ConnectionGUID: GI/vjLJTST6gKjiehJcMMA==
X-CSE-MsgGUID: evUqcZVBSVWIv6cu9gi2gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73701735"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="73701735"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 20:26:22 -0800
X-CSE-ConnectionGUID: YtqTOBL+Q0SlQGRJRDLbAQ==
X-CSE-MsgGUID: HFSeOeqFTFm7wTBYtMyoBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="217074682"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 07 Mar 2026 20:26:16 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz5iY-000000002cz-1hcE;
	Sun, 08 Mar 2026 04:26:14 +0000
Date: Sun, 8 Mar 2026 05:25:50 +0100
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, rafael@kernel.org, dakr@kernel.org,
	pavel@kernel.org, lenb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, zhongqiu.han@oss.qualcomm.com,
	akpm@linux-foundation.org, bp@alien8.de, pmladek@suse.com,
	rdunlap@infradead.org, feng.tang@linux.alibaba.com,
	pawan.kumar.gupta@linux.intel.com, kees@kernel.org,
	elver@google.com, arnd@arndb.de, fvdl@google.com,
	lirongqing@baidu.com, bhelgaas@google.com, neelx@suse.com,
	sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com,
	nick.lange@gmail.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <202603080526.A162fF4D-lkp@intel.com>
References: <20260307200736.4192234-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307200736.4192234-1-atomlin@atomlin.com>
X-Rspamd-Queue-Id: B060E22E76A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[lists.linux.dev,oss.qualcomm.com,linux-foundation.org,alien8.de,suse.com,infradead.org,linux.alibaba.com,linux.intel.com,kernel.org,google.com,arndb.de,baidu.com,ashe.io,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43912-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Aaron,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus rafael-pm/linux-next rafael-pm/bleeding-edge akpm-mm/mm-everything linus/master v6.16-rc1 next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/PM-QoS-Introduce-boot-parameter-pm_qos_resume_latency_us/20260308-040909
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20260307200736.4192234-1-atomlin%40atomlin.com
patch subject: [PATCH v3] PM: QoS: Introduce boot parameter pm_qos_resume_latency_us
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260308/202603080526.A162fF4D-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080526.A162fF4D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080526.A162fF4D-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/power/qos.c:344:5: error: redefinition of 'pm_qos_get_boot_cpu_latency_limit'
     344 | s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/power/qos.c:25:
   ./include/linux/pm_qos.h:222:19: note: previous definition of 'pm_qos_get_boot_cpu_latency_limit' with type 's32(unsigned int)' {aka 'int(unsigned int)'}
     222 | static inline s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pm_qos_get_boot_cpu_latency_limit +344 kernel/power/qos.c

   332	
   333	/**
   334	 * pm_qos_get_boot_cpu_latency_limit - Get boot-time latency limit for a CPU.
   335	 * @cpu: Logical CPU number to check.
   336	 *
   337	 * Checks the read-only boot-time constraints list to see if a specific
   338	 * PM QoS latency override was requested for this CPU via the kernel
   339	 * command line.
   340	 *
   341	 * Return: The latency limit in microseconds if a constraint exists,
   342	 * or PM_QOS_RESUME_LATENCY_NO_CONSTRAINT if no boot override applies.
   343	 */
 > 344	s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
   345	{
   346		struct pm_qos_boot_entry *entry;
   347	
   348		if (list_empty(&pm_qos_boot_list))
   349			return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
   350	
   351		list_for_each_entry(entry, &pm_qos_boot_list, node) {
   352			if (cpumask_test_cpu(cpu, &entry->mask))
   353				return entry->latency;
   354		}
   355	
   356		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
   357	}
   358	EXPORT_SYMBOL_GPL(pm_qos_get_boot_cpu_latency_limit);
   359	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

