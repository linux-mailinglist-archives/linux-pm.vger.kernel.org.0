Return-Path: <linux-pm+bounces-36125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56662BDC8BF
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368893A9A93
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD82FF15B;
	Wed, 15 Oct 2025 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIWWG9xi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6B2FDC54;
	Wed, 15 Oct 2025 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503824; cv=none; b=FhG5n/E+7AJ8aZAbkdBe2wwRL+sGh5xCdZ7LM9Ya+PsV3w639BX0EbYhaOsyY6TzaaO/efF1A2BEsspKLamG5XrsAKMqUh/KgPVIxMILkVCZuPpBKPWOWPGmf0OG7JqaE+OulDPBK2e7xRXS/2AAOu8vuQPlh2mfM3Ojsz3wR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503824; c=relaxed/simple;
	bh=LqQqWnML8DclCbVCtkFguG/McePDuiseyX71RGUghcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpxR7lQZrrbJ00ef92qG9ieW+FYMo7rAfXTU1/m7xlvq8GZmmnBBffiWLGM1UbsfGMhcmif8S1sJ83vhEEd68j55YO5CReldsrgu1b/tf8sWxGvZN3fnfjGNaedC+y7I63pZGsEeDTvoCHJoSRJmr5WGMBmwL0Cl1lDV5Q+8W18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIWWG9xi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760503823; x=1792039823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LqQqWnML8DclCbVCtkFguG/McePDuiseyX71RGUghcQ=;
  b=VIWWG9xij1i9qcnh0U2jFiBK0F52rWkC2ZMy5hTWwQAXyyKIEeZajJ0F
   xPVsCE+CzruE7TXRW8JNKAPMIBZBIXWRF78AnJ3dFLEdKmt+Mia+gb0/c
   QvvpccBJAL4FLhYc41js7T8GPLwxuTELNFj6LZ2X0RJzCLk4/VA7Deb3T
   FvUgHjt73Bx9UxagPBfnXo3Ki0miehjYYFCLhGptUHLb8bhnpsMuWZnlv
   T+Kv8LtpdeBMlKq5i15O9s4g8+VSK7Gf3lVFrpUNc4QUNI5x/HvJN0B+0
   rUhB+kqIQ3qj6zRU95I+Y3nmXCwlUx2yrCpnHRL5OmA1doqUMfzK6dDLN
   A==;
X-CSE-ConnectionGUID: Ucj01nRnROegk5tbZJmgUg==
X-CSE-MsgGUID: akf04SSKQriLJBW85FazlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50234694"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="50234694"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 21:50:23 -0700
X-CSE-ConnectionGUID: SMWUyt40S7OMWDVvD/jLuQ==
X-CSE-MsgGUID: J3aQ1pfEQXWAR4GohqDU3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182847741"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2025 21:50:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8tSr-0003SD-1b;
	Wed, 15 Oct 2025 04:50:17 +0000
Date: Wed, 15 Oct 2025 12:49:54 +0800
From: kernel test robot <lkp@intel.com>
To: Changwoo Min <changwoo@igalia.com>, lukasz.luba@arm.com,
	rafael@kernel.org, len.brown@intel.com, pavel@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, christian.loehle@arm.com, tj@kernel.org,
	kernel-dev@igalia.com, linux-pm@vger.kernel.org,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH v5 05/10] PM: EM: Add an iterator and accessor for the
 performance domain
Message-ID: <202510151232.UNZ2J7TZ-lkp@intel.com>
References: <20251014001055.772422-6-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014001055.772422-6-changwoo@igalia.com>

Hi Changwoo,

kernel test robot noticed the following build errors:

[auto build test ERROR on amd-pstate/linux-next]
[also build test ERROR on amd-pstate/bleeding-edge linus/master v6.18-rc1 next-20251014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Changwoo-Min/PM-EM-Assign-a-unique-ID-when-creating-a-performance-domain/20251014-082420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20251014001055.772422-6-changwoo%40igalia.com
patch subject: [PATCH v5 05/10] PM: EM: Add an iterator and accessor for the performance domain
config: i386-buildonly-randconfig-001-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151232.UNZ2J7TZ-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151232.UNZ2J7TZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151232.UNZ2J7TZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/power/energy_model.c:1003:5: error: redefinition of 'for_each_em_perf_domain'
    1003 | int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/power/energy_model.c:20:
   kernel/power/em_netlink.h:18:5: note: previous definition of 'for_each_em_perf_domain' with type 'int(int (*)(struct em_perf_domain *, void *), void *)'
      18 | int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> kernel/power/energy_model.c:1022:24: error: redefinition of 'em_perf_domain_get_by_id'
    1022 | struct em_perf_domain *em_perf_domain_get_by_id(int id)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/power/em_netlink.h:24:24: note: previous definition of 'em_perf_domain_get_by_id' with type 'struct em_perf_domain *(int)'
      24 | struct em_perf_domain *em_perf_domain_get_by_id(int id)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/for_each_em_perf_domain +1003 kernel/power/energy_model.c

  1002	
> 1003	int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
  1004				    void *data)
  1005	{
  1006		struct em_perf_domain *pd;
  1007	
  1008		lockdep_assert_not_held(&em_pd_mutex);
  1009		guard(mutex)(&em_pd_list_mutex);
  1010	
  1011		list_for_each_entry(pd, &em_pd_list, node) {
  1012			int ret;
  1013	
  1014			ret = cb(pd, data);
  1015			if (ret)
  1016				return ret;
  1017		}
  1018	
  1019		return 0;
  1020	}
  1021	
> 1022	struct em_perf_domain *em_perf_domain_get_by_id(int id)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

