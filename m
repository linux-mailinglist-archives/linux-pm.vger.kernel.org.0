Return-Path: <linux-pm+bounces-41350-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJEOImgyc2lItAAAu9opvQ
	(envelope-from <linux-pm+bounces-41350-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:33:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F51E72904
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62667301589B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27BB2DF153;
	Fri, 23 Jan 2026 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpRHYyyg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0942C11D9;
	Fri, 23 Jan 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157167; cv=none; b=mXmySp+AaJDZ+siAAoE74lPGLp4KA2DOgGw+tIcySQP9DZwlNGF4B/piarukxtz1AlhaLZhZ41xgwnK3PtIhtORF/nUXVKu0CZG1eQ5WYsM16JinY49XSckfKBa4ggxYyrPNPd9mTsg4HD6o+DQTnudcx43uTPnoy0CgVAZ6Qfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157167; c=relaxed/simple;
	bh=HdNnpo9nq/0E5XPtCDogUHy6OiuDbDh3XodkdpDtKOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQtvMieC+5vzLfBUM/TOJjJZ4rZpsgVruM1AyF3/GFXU9EAT+KJme7rrRUfA7XHCKxQdUS2pB+A8ovq6n2OAngLcp7aoOIKMyCEQd1im0sDH71tZwji14UwNtev57MgSJHQpYFfZLGGNi1az3aP2vOA4/hmyc2tJNDsxY/xtbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpRHYyyg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769157165; x=1800693165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HdNnpo9nq/0E5XPtCDogUHy6OiuDbDh3XodkdpDtKOg=;
  b=HpRHYyygH7BhbgYURi0lN5W6ODQOVWdr3/W3FemtzuYveyaInZrI9QPA
   /1twrntfJA9FOQR7bL8J3Ip2NgjZAk2PQ/SaEI7A4A+ljxafwZdFqUshj
   LNW9P6gwl3vc6cMXYCMkadu/ESgWaHEMwugj17zdjZczRStgNt/jGDj2R
   S7Ac5PWphQBAW+Dg+2A+fol4MitpQGpW4JC1HY9o1gl5tERpnUc0HKWk4
   4+Y2AHwfeMk08kq5AbcvFOpGAxD+RGDqcnpYSK5m1W7tlBw0EXhcIHBsi
   ivPBaG6nK8+GhzLQxhp3EZe8hiSGsKBGE6rwg+WqSwpJnMNkRYYrEgcI4
   w==;
X-CSE-ConnectionGUID: w0Y1UOCoTJKVMU5VzgTO6g==
X-CSE-MsgGUID: msJZdGy2Qmmdqsa5s9yKAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70309834"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70309834"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:32:45 -0800
X-CSE-ConnectionGUID: ls8GZ4dRSdCYnMlL52aHnw==
X-CSE-MsgGUID: obQ1P4AeQw2pRvIJvia3pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="237619083"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Jan 2026 00:32:42 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjCat-00000000Thq-05dr;
	Fri, 23 Jan 2026 08:32:39 +0000
Date: Fri, 23 Jan 2026 16:31:39 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, rafael@kernel.org, dakr@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pavel@kernel.org, lenb@kernel.org,
	neelx@suse.com, atomlin@atomlin.com, sean@ashe.io,
	mproche@gmail.com, chjohnst@gmail.com, nick.lange@gmail.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <202601231616.nbo2ijJf-lkp@intel.com>
References: <20260123010024.3301276-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123010024.3301276-1-atomlin@atomlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,suse.com,atomlin.com,ashe.io,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-41350-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 0F51E72904
X-Rspamd-Action: no action

Hi Aaron,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus rafael-pm/linux-next rafael-pm/bleeding-edge linus/master amd-pstate/linux-next amd-pstate/bleeding-edge v6.19-rc6 next-20260122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/PM-QoS-Introduce-boot-parameter-pm_qos_resume_latency_us/20260123-090409
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20260123010024.3301276-1-atomlin%40atomlin.com
patch subject: [PATCH] PM: QoS: Introduce boot parameter pm_qos_resume_latency_us
config: x86_64-randconfig-161-20260123 (https://download.01.org/0day-ci/archive/20260123/202601231616.nbo2ijJf-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601231616.nbo2ijJf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601231616.nbo2ijJf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/power/qos.c:339:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     339 |         return ret;
         |                ^~~
   kernel/power/qos.c:266:9: note: initialize the variable 'ret' to silence this warning
     266 |         int ret;
         |                ^
         |                 = 0
   kernel/power/qos.c:354:5: error: redefinition of 'pm_qos_get_boot_cpu_latency_limit'
     354 | s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
         |     ^
   include/linux/pm_qos.h:222:19: note: previous definition is here
     222 | static inline s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
         |                   ^
   1 warning and 1 error generated.


vim +/ret +339 kernel/power/qos.c

   245	
   246	/* init_pm_qos_latency_us_setup - Parse the pm_qos_latency_us boot parameter.
   247	 *
   248	 * Parses the kernel command line option "pm_qos_resume_latency_us=" to establish
   249	 * per-CPU resume latency constraints. These constraints are applied
   250	 * immediately when a CPU is registered.
   251	 *
   252	 * Syntax: pm_qos_resume_latency_us=<cpu-list>:<value>[,<cpu-list>:<value>...]
   253	 * Example: pm_qos_resume_latency_us=0-3:0,4-7:20
   254	 *
   255	 * The parsing logic enforces a "First Match Wins" policy. If a CPU is
   256	 * covered by multiple entries in the list, only the first valid entry
   257	 * applies. Any subsequent overlapping ranges for that CPU are ignored.
   258	 *
   259	 * Return: 0 on success, or a negative error code on failure.
   260	 */
   261	static int __init init_pm_qos_latency_us_setup(void)
   262	{
   263		char *token, *cmd = pm_qos_resume_latency_cmdline;
   264		struct pm_qos_boot_entry *entry, *tentry;
   265		cpumask_var_t covered;
   266		int ret;
   267	
   268		if (boot_option_idle_override == IDLE_POLL) {
   269			pr_warn("pm_qos: Cannot be used with idle=poll\n");
   270			return -EINVAL;
   271		}
   272	
   273		if (!zalloc_cpumask_var(&covered, GFP_KERNEL)) {
   274			pr_warn("pm_qos: Failed to allocate memory for parsing boot parameter\n");
   275			return -ENOMEM;
   276		}
   277	
   278		while ((token = strsep(&cmd, ",")) != NULL) {
   279			char *str_range, *str_val;
   280	
   281			str_range = strsep(&token, ":");
   282			str_val = token;
   283	
   284			if (!str_val) {
   285				pr_warn("pm_qos: Missing value range %s\n",
   286					str_range);
   287				continue;
   288			}
   289	
   290			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
   291			if (!entry) {
   292				pr_warn("pm_qos: Failed to allocate memory for boot entry\n");
   293				goto cleanup;
   294			}
   295	
   296			if (cpulist_parse(str_range, &entry->mask)) {
   297				pr_warn("pm_qos: Failed to parse cpulist range %s\n",
   298					str_range);
   299				kfree(entry);
   300				continue;
   301			}
   302	
   303			cpumask_andnot(&entry->mask, &entry->mask, covered);
   304			if (cpumask_empty(&entry->mask)) {
   305				pr_warn("pm_qos: Entry %s already covered, ignoring\n",
   306					str_range);
   307				kfree(entry);
   308				continue;
   309			}
   310			cpumask_or(covered, covered, &entry->mask);
   311	
   312			if (kstrtos32(str_val, 0, &entry->latency)) {
   313				pr_warn("pm_qos: Invalid latency requirement value %s\n",
   314					str_val);
   315				kfree(entry);
   316				continue;
   317			}
   318	
   319			if (entry->latency < 0) {
   320				pr_warn("pm_qos: Latency requirement cannot be negative: %d\n",
   321					entry->latency);
   322				kfree(entry);
   323				continue;
   324			}
   325	
   326			list_add_tail(&entry->node, &pm_qos_boot_list);
   327		}
   328	
   329		free_cpumask_var(covered);
   330		return 0;
   331	
   332	cleanup:
   333		list_for_each_entry_safe(entry, tentry, &pm_qos_boot_list, node) {
   334			list_del(&entry->node);
   335			kfree(entry);
   336		}
   337	
   338		free_cpumask_var(covered);
 > 339		return ret;
   340	}
   341	early_initcall(init_pm_qos_latency_us_setup);
   342	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

