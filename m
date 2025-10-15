Return-Path: <linux-pm+bounces-36108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A2BDC705
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74DC42473B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE72EFD95;
	Wed, 15 Oct 2025 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqyBiZYZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691942E975E;
	Wed, 15 Oct 2025 04:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501841; cv=none; b=ELW2TCdH6AtdxSAAZq/RhG8lc+GwHCzl8YiyW221++xSsOWFP9mtHd0EmKtqvhGchzpuaH6dBHwWMNoEmwE6CRpdYbTDciXmdbbolqfO9VrSqM5FkLkVIkm3RHZWdxTYdbQF1i412G01+Yj/jbvVoy/6sXTRYi2LQfg09zf3lOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501841; c=relaxed/simple;
	bh=ovqQe7GOvD0OcEx7/AkCnQHKdx2amFS8fzjSEwxqnMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7aI+OWwd4MxQ0cVvExaGxgILiSrMryqKGVpNUrOO9eX8eUBzjyL+J9SPMHz4J0EzOn+LzdZgDhSMbHh6H/VfZIaHeP4a2iF7a0cH0EHTMIAAHshCZ2v2ST3q86VRTvVKJ5IJBXOOn5rxh+9YIbcguPxNElw8BHkYaEMehTALCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqyBiZYZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760501840; x=1792037840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ovqQe7GOvD0OcEx7/AkCnQHKdx2amFS8fzjSEwxqnMY=;
  b=VqyBiZYZ3HZbeBTmZRxnFNmqclPuI6Zktqhsgu0bSjt4Iz26/dPW9wDh
   gkkVOo3EX9lGrIojwWyTlNz4y1SyRX6v8w2QPfNn6evYt3M34oQkOfIi7
   5f1wnq1IEzpKDNPkPvvPzr6vUKCyFsYGnAVItGBBQnoJQn9JWYsq15/pl
   nTAtxo6X2qIW79OunYNHtzXgjyqaszf6OKtqD2rU4+ZmYj8CdlpiKhgnL
   rs5BlRV4R/7S1P06hyFiOBif2iqtp4HD0JdXf0DLUCVmh1ZhxwbUJhYfK
   EuILFLiA72E88QSgN35gRGyncqQnsi9i3lAkmTrNt7Kl6ssBX90Rqncny
   Q==;
X-CSE-ConnectionGUID: XTvy4SIGRc+MWkBWX1/H8A==
X-CSE-MsgGUID: yK7O66HXTGqP5PW9YlhbCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62376356"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62376356"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 21:17:19 -0700
X-CSE-ConnectionGUID: lp6rFhTRQyKawdXxI3Y7wA==
X-CSE-MsgGUID: bmvJ/X1rS+iEHMBm+SThKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="186067579"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 14 Oct 2025 21:17:15 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8swr-0003RM-11;
	Wed, 15 Oct 2025 04:17:13 +0000
Date: Wed, 15 Oct 2025 12:16:10 +0800
From: kernel test robot <lkp@intel.com>
To: Changwoo Min <changwoo@igalia.com>, lukasz.luba@arm.com,
	rafael@kernel.org, len.brown@intel.com, pavel@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	christian.loehle@arm.com, tj@kernel.org, kernel-dev@igalia.com,
	linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH v5 08/10] PM: EM: Implement em_notify_pd_deleted()
Message-ID: <202510151223.THlBK6QR-lkp@intel.com>
References: <20251014001055.772422-9-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014001055.772422-9-changwoo@igalia.com>

Hi Changwoo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/linux-next]
[also build test WARNING on amd-pstate/bleeding-edge linus/master v6.18-rc1 next-20251014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Changwoo-Min/PM-EM-Assign-a-unique-ID-when-creating-a-performance-domain/20251014-082420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20251014001055.772422-9-changwoo%40igalia.com
patch subject: [PATCH v5 08/10] PM: EM: Implement em_notify_pd_deleted()
config: i386-buildonly-randconfig-004-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151223.THlBK6QR-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151223.THlBK6QR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151223.THlBK6QR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/power/em_netlink.c:228:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     228 |         int ret = -EMSGSIZE;
         |             ^
   1 warning generated.


vim +/ret +228 kernel/power/em_netlink.c

   224	
   225	void em_notify_pd_deleted(const struct em_perf_domain *pd)
   226	{
   227		struct sk_buff *msg;
 > 228		int ret = -EMSGSIZE;
   229		void *hdr;
   230		int msg_sz;
   231	
   232		if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
   233			return;
   234	
   235		msg_sz = __em_notify_pd_deleted_size(pd);
   236	
   237		msg = genlmsg_new(msg_sz, GFP_KERNEL);
   238		if (!msg)
   239			return;
   240	
   241		hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, EM_CMD_PD_DELETED);
   242		if (!hdr)
   243			goto out_free_msg;
   244	
   245		if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id)) {
   246			ret = -EMSGSIZE;
   247			goto out_free_msg;
   248		}
   249	
   250		genlmsg_end(msg, hdr);
   251	
   252		genlmsg_multicast(&em_nl_family, msg, 0, EM_NLGRP_EVENT, GFP_KERNEL);
   253	
   254		return;
   255	
   256	out_free_msg:
   257		nlmsg_free(msg);
   258		return;
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

