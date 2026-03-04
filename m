Return-Path: <linux-pm+bounces-43631-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H48Iq+4qGnLwgAAu9opvQ
	(envelope-from <linux-pm+bounces-43631-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 23:56:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB73208CCD
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 23:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40E7F302D9EC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 22:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0A396590;
	Wed,  4 Mar 2026 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFh4P833"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993FC373C0B;
	Wed,  4 Mar 2026 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665005; cv=none; b=hfbO2eXygEtB1+LJBE74v+hf0LWDjuomRF/e9X7CKSUE8NShyDQUG+K33mqQhQSRkpJP7bRGaRn3vrLrSGabLrOu3PKrZ1ucJ4Pojp2GgaAZv82QT7lGVkQoA1fBCs9U/ULS5vtMabnvBOHvjms/uGS3mLMUKuvlqhcG1pXtAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665005; c=relaxed/simple;
	bh=0rXkdgSsjeXUw9O29HMod7MgndTa2Hf8FCWu+uPgaMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXEPnUQfS+RJnkxXsHRwFT/3xvFggbqEn29cEem++rxcU2Ld8BPUYpmnVRoLVEWmMWXsixfCHMeIyxF3lD7Lo1LDWI2Wwt7ChWQ8t0bUjW6TK8IoC7EPKe2kSrbtHGGoDQ/8aeG97u3qbEUR9E0hvpQIYmMGSMtVjQM1seK7nt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFh4P833; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772665002; x=1804201002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0rXkdgSsjeXUw9O29HMod7MgndTa2Hf8FCWu+uPgaMY=;
  b=WFh4P833Sug1XkOZIHvYijZPDxiu54CiwqCQinqojkdH0fYmd9abrm9H
   KB5jEAHa8cv6DvlMa3OdBtwUBkgemnV4f6mKw6mEB4a1e8n1/m/B1pJCq
   bdkzPL5Ywup8Z1dqIC0fs7pD+qjbXdyQF3xovZ6mN2KxNh/QhsizQyh0M
   24xZuIJ+4hMhGeIVrTFmomwKpB2ArPXEnsBS/Pf+p5FPq7r/Hx5JGBtPu
   NSHXa9H5AfXOt2lOZh/Z0ilDY2zmUIjo1JDKexISD/5H2OqEAgFvJh8+l
   MwycHwYfgqdR7tfSH0k1CHAVQv/+OP3mG36VLXAv7XYdWs3SYhhEYuTch
   Q==;
X-CSE-ConnectionGUID: ePlOpdFqTNmjB40CNZM2lg==
X-CSE-MsgGUID: yc5RSb3hR0WNqv/yRiOdPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="99209040"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="99209040"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:56:42 -0800
X-CSE-ConnectionGUID: VlbvOeV6QSemWMbmWJyJ+Q==
X-CSE-MsgGUID: xrxG+dIDSqalZu71ln8rHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="222628482"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Mar 2026 14:56:40 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxv8v-000000004eH-09jN;
	Wed, 04 Mar 2026 22:56:37 +0000
Date: Thu, 5 Mar 2026 06:56:17 +0800
From: kernel test robot <lkp@intel.com>
To: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Subject: Re: [PATCH] PM: Move to_device() out of CONFIG_PM_SLEEP protection
Message-ID: <202603050651.Tp7mTeNL-lkp@intel.com>
References: <20260302105456.4134882-1-pengpeng.hou@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302105456.4134882-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Rspamd-Queue-Id: 2EB73208CCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-43631-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,01.org:url]
X-Rspamd-Action: no action

Hi Pengpeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v7.0-rc2 next-20260303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pengpeng-Hou/PM-Move-to_device-out-of-CONFIG_PM_SLEEP-protection/20260302-190351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260302105456.4134882-1-pengpeng.hou%40isrc.iscas.ac.cn
patch subject: [PATCH] PM: Move to_device() out of CONFIG_PM_SLEEP protection
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20260305/202603050651.Tp7mTeNL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603050651.Tp7mTeNL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603050651.Tp7mTeNL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/base/core.c:38:
>> drivers/base/power/power.h:163:50: error: no member named 'entry' in 'struct dev_pm_info'
     163 |         return container_of(entry, struct device, power.entry);
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/linux/container_of.h:21:49: note: expanded from macro 'container_of'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
      22 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      23 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:617:74: note: expanded from macro '__same_type'
     617 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   In file included from drivers/base/core.c:38:
>> drivers/base/power/power.h:163:9: error: no member named 'entry' in 'dev_pm_info'
     163 |         return container_of(entry, struct device, power.entry);
         |                ^                                       ~~~~~~
   include/linux/container_of.h:24:21: note: expanded from macro 'container_of'
      24 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^              ~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^                        ~~~~~~
   2 errors generated.


vim +163 drivers/base/power/power.h

   160	
   161	static inline struct device *to_device(struct list_head *entry)
   162	{
 > 163		return container_of(entry, struct device, power.entry);
   164	}
   165	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

