Return-Path: <linux-pm+bounces-41349-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBOoLhEoc2kAswAAu9opvQ
	(envelope-from <linux-pm+bounces-41349-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 08:49:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A18071FED
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 08:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2981E30238D3
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A72D94B2;
	Fri, 23 Jan 2026 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/+Fz7WY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CF27EFF7;
	Fri, 23 Jan 2026 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769154529; cv=none; b=jeKu9k7VpkjMZc5x2gos43nhn/YDyablbVnGyh7Q407sPfxyetSignox3OgXwdOJQ+Od4VMwq2IFCum/k1hP34lilLQ081c72PoezqkvaoNWVkQdfM1ovAQ28AJNFe1eNtn49hBxfPTI7kNsrJyKEdjo7IjUo5c2FRzQweblgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769154529; c=relaxed/simple;
	bh=erFLakW2WZ72tu+xZhioj2szakHLvev8zWSXYFYy7CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlHy2mTqCRUUU4QCA7zumkeJShyTny8c1KYruf4jf0BdMil2T51pEwH3gw4nT/lJNJgf5WZhjNseRzgPc/uNzK8a8oy2dNWbCwdVAdbzvPtdkMUqog11/tPHcJDG5rxS4HhlxbWGvChvX8KKBZtZwVLJyOtR5mhjpJvm4xrdI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/+Fz7WY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769154527; x=1800690527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=erFLakW2WZ72tu+xZhioj2szakHLvev8zWSXYFYy7CA=;
  b=S/+Fz7WY163j/ox7u0dJG0NEu7iiNI+gD9S7+S4haiL9vKQkSnXAVXKV
   pa+2BY44y2HTyurTwxeNYGSfQKn+sK0rl+FpnCx5bz4H44PnT3sweNr5z
   1fY96JKht5GAauSAOW1oS7UdJdWXReICitz2fw8UfsTj+7NGgR6RUnqkZ
   WxhiR4mx6QQ+OSnt3AdfLKDAAzCQlglKcosEwXTo8D/pWApJAjYzud0Ub
   Qch9U9/qEhCoK1hM1mNQj/mGd9DRo/Vm7jcULbhdgARXy5im8Xhjza6Yl
   qtHU03MCD0dJ3EFXVSGlFWUxAKp5d3YwN+VZI4QSIkE6jJV85TuaF7GFq
   w==;
X-CSE-ConnectionGUID: IIKv0KbpT+iYhJNSVXPlCw==
X-CSE-MsgGUID: hTknLdHXQUqxnGkPidVXuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70465835"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70465835"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:48:45 -0800
X-CSE-ConnectionGUID: QQOHBZnqSZ2QCdpBfqABww==
X-CSE-MsgGUID: cu8FMCukRS6SHmRDduq48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211416807"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jan 2026 23:48:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjBuH-00000000Tew-0fmt;
	Fri, 23 Jan 2026 07:48:37 +0000
Date: Fri, 23 Jan 2026 15:47:39 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, rafael@kernel.org, dakr@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, pavel@kernel.org,
	lenb@kernel.org, neelx@suse.com, atomlin@atomlin.com, sean@ashe.io,
	mproche@gmail.com, chjohnst@gmail.com, nick.lange@gmail.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <202601231542.GkFyNtdd-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,suse.com,atomlin.com,ashe.io,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-41349-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 2A18071FED
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
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20260123/202601231542.GkFyNtdd-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601231542.GkFyNtdd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601231542.GkFyNtdd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/power/qos.c:56:13: warning: unused variable 'pm_qos_resume_latency_cmdline' [-Wunused-variable]
      56 | static char pm_qos_resume_latency_cmdline[COMMAND_LINE_SIZE] __initdata;
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/pm_qos_resume_latency_cmdline +56 kernel/power/qos.c

    55	
  > 56	static char pm_qos_resume_latency_cmdline[COMMAND_LINE_SIZE] __initdata;
    57	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

