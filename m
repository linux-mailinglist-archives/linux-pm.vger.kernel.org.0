Return-Path: <linux-pm+bounces-41673-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHkkMfgte2mbCAIAu9opvQ
	(envelope-from <linux-pm+bounces-41673-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 10:52:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C2AE47B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 10:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D9B33009552
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E337FF67;
	Thu, 29 Jan 2026 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0os6OKy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B337474C;
	Thu, 29 Jan 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680373; cv=none; b=rO/zPSTEerJ3vYCFQNWMaHKF8ZCTj3uR0ZdMplFZpBPM9TaUKInn85XUqSOYl0dGQpKKw4m3cnAVrpISp7Z4705qryXx0CKthMBuwDvlYyrSyrvLKmlVTtpgBrHri4Y3YTXVDP++AsULHxLarZXYdJ/VE2fs8VoRmE0tEKPHmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680373; c=relaxed/simple;
	bh=zFTy40P++A/fj80s2qLzscLKWBZGOQDRR0TgMNIVEJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=envDERO46uzbCpH7uJUQmXplsFVyDtSB67ojU/7DmAjkRmBYrDY5HqV7BlyiqFamdtXjHIiDO0dj/5Z+JyepQExrnsJWFpfsad9HmCyY1Y4vj4r06jv+Hgxdl9qCjUhvCGY1Krd5bfG3xJZgvlrT81n4qqm1tSy/ukdjzOAJb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0os6OKy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769680372; x=1801216372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFTy40P++A/fj80s2qLzscLKWBZGOQDRR0TgMNIVEJM=;
  b=n0os6OKyHiL5oX+QPopJIeC9ajHwTbzQNI6vzf+ar8MGJpwcJhhCTtO0
   7tbAA4Vka1T/Zphw7Xg/VGlTCCHsxRr3s94vdiPojkq8XREjDO9fWokDV
   1dOBZnNSf2azdAT3j3emLZbnje0/DSItnujRdlTQA3nH0XBUpa9P1pqh7
   8h2sPqNyVw+eK+HhhOW7U/ttnAO7wp0lQ83khRNPQBf/68VilruuogosT
   HLo6gihF/4G9Oo4ewTaVN7M0QMm2FjSe18RVBKY8ymPL9B7hGONDymKjO
   KAkEalD4Jv4yuuCFogBu45q2sS96GsnzReLnSEMIbLR++HiErY6vSPxb2
   w==;
X-CSE-ConnectionGUID: xjX5T/04TMqNlahnmjd2Rw==
X-CSE-MsgGUID: 2JCAvr7iT+WYH5gjsSKyoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70109461"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="70109461"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 01:52:51 -0800
X-CSE-ConnectionGUID: 2KX1gktWSq+Q9StTj6QC0w==
X-CSE-MsgGUID: mZN+qnMeSVqqXyC606aUOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="207775246"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Jan 2026 01:52:47 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlOhg-00000000bL6-3guq;
	Thu, 29 Jan 2026 09:52:44 +0000
Date: Thu, 29 Jan 2026 17:52:30 +0800
From: kernel test robot <lkp@intel.com>
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jie Zhan <zhanjie9@hisilicon.com>,
	zhenglifeng1@huawei.com, Ionela Voinescu <ionela.voinescu@arm.com>,
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
Message-ID: <202601291700.LY8K4K9v-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41673-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: E51C2AE47B
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
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260129/202601291700.LY8K4K9v-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601291700.LY8K4K9v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601291700.LY8K4K9v-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cpufreq/virtual-cpufreq.c: In function 'virt_cpufreq_get_freq_info':
>> drivers/cpufreq/virtual-cpufreq.c:167:32: warning: statement with no effect [-Wunused-value]
     167 |                 policy->cpuinfo.min_freq;
         |                 ~~~~~~~~~~~~~~~^~~~~~~~~
   drivers/cpufreq/virtual-cpufreq.c:168:32: warning: statement with no effect [-Wunused-value]
     168 |                 policy->cpuinfo.max_freq;
         |                 ~~~~~~~~~~~~~~~^~~~~~~~~


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

