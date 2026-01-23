Return-Path: <linux-pm+bounces-41357-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFUAKn9Dc2mWtwAAu9opvQ
	(envelope-from <linux-pm+bounces-41357-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 10:46:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B873982
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 10:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5775B3002A37
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDB336072B;
	Fri, 23 Jan 2026 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyCFZpHk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E43370F4;
	Fri, 23 Jan 2026 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161323; cv=none; b=H3uR6apX+/tmwgTw6Zlk3oDfpRq0hb0W2xGdrAPVHS7cSBOFPS3/W45WTeEqlTX8T+fqftLGShY5cy4vCM5CuQG0ThesOOw0POcU9leP3WmFHvXozw6qP6ELf87E7mJISTMAp7mvj7HNpY4XBkM8jP/Eq+RHAbbw26ZZTNHFq78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161323; c=relaxed/simple;
	bh=bYe+5mye5EU5BZsStchEKf+8Drtyqh4KMfvGrN988sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqcRwVu0LpTfD+clviILUgbI+zpl+7jkk9OGoRGsBieLG86Re7PT/qunI4yp4r7tVJTsDgjphgu+2ATPxmsRdegrJLaBxGdk3ynfhrTqfd//vWvvm32axBgYQT7q90QtwjZgcb4o4V7OENcuvFGX5sp/oNZV1PsjmbEyZHk54EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyCFZpHk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769161311; x=1800697311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bYe+5mye5EU5BZsStchEKf+8Drtyqh4KMfvGrN988sQ=;
  b=PyCFZpHkRIqCDyrNk3EPIVYAUwhifWU5jWuekmV6Vm7/AvfwC6eCGxyH
   4u8f5GqZ3PVTyH/O41DHdIBINoI/5BZJpO9huTHatO+lg9DQezbwJpfl2
   ve+0os3LJjogqeDmOgQ518spPbmIITKcVVNnHgUCH6ohU3P3hWOMuzct4
   iJtRwrNKJa0Zgwz+VQ4MKnpPkM15hlDdLw5DQTOOUE7QsaupHuVDgc96r
   f4JIqjmf0zO+oTC3c1sHc/JX4GLnGKG04ZbK4avRAUTRFkXB1uaPxo0+D
   iBPSQNpCLXrvF2Xbf6HQ9R9uHxYnR18HZeHtQRSybTeFojbtyjEvuWx9o
   Q==;
X-CSE-ConnectionGUID: NekDLB1wTg2VlbiTQYhDCQ==
X-CSE-MsgGUID: 85Na7V7eT9ywou9do7vxOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="69609349"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="69609349"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 01:41:46 -0800
X-CSE-ConnectionGUID: kyXBHUVgTH2HCovzzPevqA==
X-CSE-MsgGUID: kowiCTB3S32lqyVb8NcsVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211985262"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 23 Jan 2026 01:41:43 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjDfg-000000000gj-3hLp;
	Fri, 23 Jan 2026 09:41:40 +0000
Date: Fri, 23 Jan 2026 10:40:58 +0100
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, rafael@kernel.org, dakr@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pavel@kernel.org, lenb@kernel.org,
	neelx@suse.com, atomlin@atomlin.com, sean@ashe.io,
	mproche@gmail.com, chjohnst@gmail.com, nick.lange@gmail.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <202601231030.N1gaWeuj-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,suse.com,atomlin.com,ashe.io,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-41357-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 094B873982
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
config: powerpc64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260123/202601231030.N1gaWeuj-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601231030.N1gaWeuj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601231030.N1gaWeuj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/power/qos.c:56:13: warning: 'pm_qos_resume_latency_cmdline' defined but not used [-Wunused-variable]
      56 | static char pm_qos_resume_latency_cmdline[COMMAND_LINE_SIZE] __initdata;
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pm_qos_resume_latency_cmdline +56 kernel/power/qos.c

    55	
  > 56	static char pm_qos_resume_latency_cmdline[COMMAND_LINE_SIZE] __initdata;
    57	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

