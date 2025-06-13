Return-Path: <linux-pm+bounces-28694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E9CAD95DD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 22:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332703B9330
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C77F2343B6;
	Fri, 13 Jun 2025 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMJK21uk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DFA72608;
	Fri, 13 Jun 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749844997; cv=none; b=P0kYqZ7JNU8LryTGPks/EsGLtIteEyvuvwZNGn9xtFEbrojw+qWL1TwIBJFWr8BUSUhZfAsdKdPVhfxqcr/KTxZArVQPmcnFw9c5jks2mLC89myZdYuYX+G3VJf8C/hr80L+CPwnoWJRL4pdMZrB+/s/u81AqcBVPMTYf3QOm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749844997; c=relaxed/simple;
	bh=/4cO2oxwE2+MFIsqBcFcY3X9Z9y419YIquujHe9FTio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIvm/tjp3ow3Xi79vUOJ6on+N2FFEzjo7K3y7mwrwB/7BqzBKkYghUVTVs83olD/Ex1j3+cF0U4UQsRvx3iC4cbp4jJHUMgQu4hP1fHhoksAg6pPXM6Cd1CmdTOryl2+tyZA8DrOdUz/In3bq98HLGiIf38Wofus2HCVQT2f92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMJK21uk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749844996; x=1781380996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/4cO2oxwE2+MFIsqBcFcY3X9Z9y419YIquujHe9FTio=;
  b=RMJK21ukGX6FxQzNSaoMFym1H3cMYf+MdIxJaDqK17cu6ooDPJZRAwFK
   CLU4PKbcTyGPOQt9iaxclTNi2UAj2j9OCYWvzlxp/QEnUryltKzrJVoTx
   45WOlF/apimHw8GbAeYgvgE/MHzzFRLC5JpQxoDW6qy8MXiwvBoMBnYhq
   +/LMNQ/cAqyJW+vMhXxAXSo4iZ2sShdPoK3LX4DfS2Gb5IlPXpfOQGX+6
   WWeL4piDwZzdZbf9lbHyMmd8oR6fjd5MsTo7lJwzitjkEvGw26AigLfGq
   udem169OfzzM9dJfTW3EerJHbD5IjJOH0UWlfc/ANULjnDAa9eBeSg8yE
   w==;
X-CSE-ConnectionGUID: +AowgUV/ShCevISBJ/WP6w==
X-CSE-MsgGUID: hh4olmh0Tg+T/+ztWkrbjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51788476"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="51788476"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 13:03:15 -0700
X-CSE-ConnectionGUID: NGjm4sX7RoCq04Iz9oE4xw==
X-CSE-MsgGUID: DiqxwtpWSIaxHbuuah5MvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="178898439"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Jun 2025 13:03:12 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQAcI-000CyA-0K;
	Fri, 13 Jun 2025 20:03:10 +0000
Date: Sat, 14 Jun 2025 04:02:15 +0800
From: kernel test robot <lkp@intel.com>
To: Changwoo Min <changwoo@igalia.com>, lukasz.luba@arm.com,
	rafael@kernel.org, len.brown@intel.com, pavel@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	christian.loehle@arm.com, tj@kernel.org, kernel-dev@igalia.com,
	linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH v2 09/10] PM: EM: Implement
 em_notify_pd_created/updated().
Message-ID: <202506140306.tuIoz8rN-lkp@intel.com>
References: <20250613094428.267791-10-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613094428.267791-10-changwoo@igalia.com>

Hi Changwoo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc1 next-20250613]
[cannot apply to amd-pstate/linux-next amd-pstate/bleeding-edge]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Changwoo-Min/PM-EM-Add-em-yaml-and-autogen-files/20250613-174859
base:   linus/master
patch link:    https://lore.kernel.org/r/20250613094428.267791-10-changwoo%40igalia.com
patch subject: [PATCH v2 09/10] PM: EM: Implement em_notify_pd_created/updated().
config: i386-randconfig-001-20250614 (https://download.01.org/0day-ci/archive/20250614/202506140306.tuIoz8rN-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250614/202506140306.tuIoz8rN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506140306.tuIoz8rN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/power/em_netlink.c:234:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     234 |         if (!hdr)
         |             ^~~~
   kernel/power/em_netlink.c:249:9: note: uninitialized use occurs here
     249 |         return ret;
         |                ^~~
   kernel/power/em_netlink.c:234:2: note: remove the 'if' if its condition is always false
     234 |         if (!hdr)
         |         ^~~~~~~~~
     235 |                 goto out_free_msg;
         |                 ~~~~~~~~~~~~~~~~~
   kernel/power/em_netlink.c:221:17: note: initialize the variable 'ret' to silence this warning
     221 |         int msg_sz, ret;
         |                        ^
         |                         = 0
   1 warning generated.


vim +234 kernel/power/em_netlink.c

   215	
   216	
   217	/**************************** Event encoding *********************************/
   218	static int __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
   219	{
   220		struct sk_buff *msg;
   221		int msg_sz, ret;
   222		void *hdr;
   223	
   224		if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
   225			return 0;
   226	
   227		msg_sz = __em_nl_get_pd_table_size(pd);
   228	
   229		msg = genlmsg_new(msg_sz, GFP_KERNEL);
   230		if (!msg)
   231			return -ENOMEM;
   232	
   233		hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, ntf_type);
 > 234		if (!hdr)
   235			goto out_free_msg;
   236	
   237		ret = __em_nl_get_pd_table(msg, pd);
   238		if (ret)
   239			goto out_free_msg;
   240	
   241		genlmsg_end(msg, hdr);
   242	
   243		genlmsg_multicast(&em_nl_family, msg, 0, EM_NLGRP_EVENT, GFP_KERNEL);
   244	
   245		return 0;
   246	
   247	out_free_msg:
   248		nlmsg_free(msg);
   249		return ret;
   250	}
   251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

