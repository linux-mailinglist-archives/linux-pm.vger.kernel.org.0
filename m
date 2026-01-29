Return-Path: <linux-pm+bounces-41669-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2TLVDS74emkZAQIAu9opvQ
	(envelope-from <linux-pm+bounces-41669-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 07:03:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D42F6AC208
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 07:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D84123004424
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 06:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2ED376BFA;
	Thu, 29 Jan 2026 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z781McGq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1D23A994;
	Thu, 29 Jan 2026 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666598; cv=none; b=fumF6rKCjEJw7ptPTT+6adtqKxIK1+DKSEqvwfrMbkNunGOaLByZ6J128w7ZtnI+LeoTtWXm+ib9X21DG39pBWotD+WPbmAU9wVhbrIUJQCEHIae9fp7GRSMoQWnqTXBEG4PA6+2vE5q+h/d5r9Zz0+pT4JJBaEMJ06BFlrh6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666598; c=relaxed/simple;
	bh=1BvSsh83YrmCM1HCtpdrlxUSEkcGbSxzqDyiGRGb3Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pot3KqUv2vktIK4NlbCr9ekp87yaMI8tAeo4r2aosbr87i/EGhnj8Y6Wmj3SAscGnh0imRrSO3w0HJ1D6ftet4xbWnnYe6ukx7LfihW3McD7wIXcuShVFe3LoxUzt/7aUs0ebBIwgco59MZwkrqKtAB+RrH1DnQ14SdvpbwGikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z781McGq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769666596; x=1801202596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1BvSsh83YrmCM1HCtpdrlxUSEkcGbSxzqDyiGRGb3Fs=;
  b=Z781McGqOFJfX/ny2QsGtFpihpeCfGcHx+D8GrO0lTNjLrc/0sFHWrlB
   2H3pKH3XLiZeKizdJy2K6WT/4lzwdEkjrU8BO+4k3j//wbk3u/aOFiR5X
   TU97LsrH9z+deulwKsxZtOIU/5YpK4sbeZ0S7K7h01Epnzj30yV83wr9B
   47Mq1kQvKRp+FzZJvBXd2eYrWUnBUBBBAQWUpiWv+XNp9kTUw4pIqmYnA
   4KKCOseeny729yED1y9Kf1TXUuT5aY+i6zM03WoVwn1OEB78atfi88HX6
   mcUMe05sU4+S9eks51F0myQ4w0Z4IrFnU/3MCmzBgKB878lYwLEU84fGj
   w==;
X-CSE-ConnectionGUID: rdEw0nOgQ0aZF5g2S4A+hw==
X-CSE-MsgGUID: bIyTiQcMSXysTVPm/3XOzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70947991"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="70947991"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 22:03:16 -0800
X-CSE-ConnectionGUID: eDq6UUxjQOetjQ62QvrtuQ==
X-CSE-MsgGUID: ojNHspAOTIOGhuo+s14V8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="212562580"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Jan 2026 22:03:10 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlL7T-00000000b9A-1uvB;
	Thu, 29 Jan 2026 06:03:07 +0000
Date: Thu, 29 Jan 2026 14:02:43 +0800
From: kernel test robot <lkp@intel.com>
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jie Zhan <zhanjie9@hisilicon.com>, zhenglifeng1@huawei.com,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Christian Loehle <christian.loehle@arm.com>, sumitg@nvidia.com,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/6] cpufreq: Set policy->min and max as real QoS
 constraints
Message-ID: <202601291343.bghsD4zH-lkp@intel.com>
References: <20260126101826.94030-6-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126101826.94030-6-pierre.gondois@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41669-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D42F6AC208
X-Rspamd-Action: no action

Hi Pierre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.19-rc7 next-20260128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pierre-Gondois/cpufreq-Remove-per-CPU-QoS-constraint/20260126-182440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260126101826.94030-6-pierre.gondois%40arm.com
patch subject: [PATCH 5/6] cpufreq: Set policy->min and max as real QoS constraints
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260129/202601291343.bghsD4zH-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601291343.bghsD4zH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601291343.bghsD4zH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/virtual-cpufreq.c:167:19: warning: expression result unused [-Wunused-value]
                   policy->cpuinfo.min_freq;
                   ~~~~~~~~~~~~~~~ ^~~~~~~~
   drivers/cpufreq/virtual-cpufreq.c:168:19: warning: expression result unused [-Wunused-value]
                   policy->cpuinfo.max_freq;
                   ~~~~~~~~~~~~~~~ ^~~~~~~~
   2 warnings generated.


vim +167 drivers/cpufreq/virtual-cpufreq.c

   155	
   156	static int virt_cpufreq_get_freq_info(struct cpufreq_policy *policy)
   157	{
   158		struct cpufreq_frequency_table *table;
   159		u32 num_perftbl_entries, idx;
   160	
   161		num_perftbl_entries = per_cpu(perftbl_num_entries, policy->cpu);
   162	
   163		if (num_perftbl_entries == 1) {
   164			policy->cpuinfo.min_freq = 1;
   165			policy->cpuinfo.max_freq = virt_cpufreq_get_perftbl_entry(policy->cpu, 0);
   166	
 > 167			policy->cpuinfo.min_freq;
   168			policy->cpuinfo.max_freq;
   169	
   170			policy->cur = policy->cpuinfo.max_freq;
   171			return 0;
   172		}
   173	
   174		table = kcalloc(num_perftbl_entries + 1, sizeof(*table), GFP_KERNEL);
   175		if (!table)
   176			return -ENOMEM;
   177	
   178		for (idx = 0; idx < num_perftbl_entries; idx++)
   179			table[idx].frequency = virt_cpufreq_get_perftbl_entry(policy->cpu, idx);
   180	
   181		table[idx].frequency = CPUFREQ_TABLE_END;
   182		policy->freq_table = table;
   183	
   184		return 0;
   185	}
   186	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

