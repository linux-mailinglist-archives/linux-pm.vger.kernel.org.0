Return-Path: <linux-pm+bounces-43632-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ek/Bly8qGlbwwAAu9opvQ
	(envelope-from <linux-pm+bounces-43632-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 00:12:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D000208E3C
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 00:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E772301AD10
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E031A38C2BC;
	Wed,  4 Mar 2026 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApdlUjOo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DD361DD0;
	Wed,  4 Mar 2026 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665723; cv=none; b=pW3bePlzdqAM3NCy+S65YaeqJbDPgtpj4GSg31eft5bCNp8LGyyoIaEEtPTQbCp2sVgNFqyIdMcZekPhYI+7Yoh2F3fVcx8nDMSrTeM2lzlN+uTZlsAeNOIEbpMiKQNXuY1WCd3R45ZA1LThyR0H1TBnKYIGvJZAgRI2aWcjl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665723; c=relaxed/simple;
	bh=gDZUAt2PKJk5mvudI8hISeOmReKHFAbTfQcoGPt+tFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMFSIINrdILzBT2gtPVZw6F8yPIspFoRddaEPtC4lQeWQ3eLpEJ6+kssLaDLqpOItCtokFIaqZV3nduIYQZUurne64GbLXkfmNyuVOzFYynhu5ydWrLpnT/DeANd/TbMu+k2i+Y3FnV7cBHU27dO6IR0ieJNjVZETrre7I/ysGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApdlUjOo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772665723; x=1804201723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gDZUAt2PKJk5mvudI8hISeOmReKHFAbTfQcoGPt+tFo=;
  b=ApdlUjOo81/Ge6VEFsMtKFZgvRaKnTjTLD2x3snQbmqY2io3qwAqm88Y
   wixsgtGzHG54k/kZh93XrDhQSjFD1UAEDhBYYPICXpJiQ6mTN8O/ZpvtO
   8jOQifokund6PqDanPV6g46/JczmK3AyUMxtVmSnKISWDQSEujTMyIy3P
   XZxiA+9+dwDiSRQo97YOgp2Ap47nccDYBVuxyls96WMywOGTQNbZ0iJdR
   C2wtLGK2Xi8DS5pp07h0Vdjx39P41opv1yAw+ur2kxydikDSFDN87s36U
   w+wDCrE4lf3O6ImKKONOdrP+CVv/u8f21RM4wjDn1EUsUxJX1YQWc+t2E
   A==;
X-CSE-ConnectionGUID: 3EyZaiogRxWtupL8VNd3WQ==
X-CSE-MsgGUID: rRr9qKoQS+SJu0jxJBn8ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73647859"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73647859"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:08:43 -0800
X-CSE-ConnectionGUID: uCLVVyR/QuCbdhfcyoAb+A==
X-CSE-MsgGUID: u56QrKi5QgGMR/285TOgzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="222632136"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Mar 2026 15:08:41 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxvKY-000000004et-0uLl;
	Wed, 04 Mar 2026 23:08:38 +0000
Date: Thu, 5 Mar 2026 07:07:45 +0800
From: kernel test robot <lkp@intel.com>
To: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Subject: Re: [PATCH] PM: Move to_device() out of CONFIG_PM_SLEEP protection
Message-ID: <202603050624.gml2vPY4-lkp@intel.com>
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
X-Rspamd-Queue-Id: 8D000208E3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43632-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Action: no action

Hi Pengpeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v7.0-rc2 next-20260304]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pengpeng-Hou/PM-Move-to_device-out-of-CONFIG_PM_SLEEP-protection/20260302-190351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260302105456.4134882-1-pengpeng.hou%40isrc.iscas.ac.cn
patch subject: [PATCH] PM: Move to_device() out of CONFIG_PM_SLEEP protection
config: sh-se7751_defconfig (https://download.01.org/0day-ci/archive/20260305/202603050624.gml2vPY4-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603050624.gml2vPY4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603050624.gml2vPY4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bits.h:30,
                    from include/linux/ioport.h:14,
                    from include/linux/acpi.h:13,
                    from drivers/base/core.c:11:
   drivers/base/power/power.h: In function 'to_device':
>> drivers/base/power/power.h:163:56: error: 'struct dev_pm_info' has no member named 'entry'
     163 |         return container_of(entry, struct device, power.entry);
         |                                                        ^
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:21:9: note: in expansion of macro 'static_assert'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/base/power/power.h:163:16: note: in expansion of macro 'container_of'
     163 |         return container_of(entry, struct device, power.entry);
         |                ^~~~~~~~~~~~
   include/linux/compiler_types.h:617:27: error: expression in static assertion is not an integer
     617 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:21:9: note: in expansion of macro 'static_assert'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/base/power/power.h:163:16: note: in expansion of macro 'container_of'
     163 |         return container_of(entry, struct device, power.entry);
         |                ^~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:5,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/sh/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:372,
                    from include/linux/cleanup.h:5,
                    from include/linux/acpi.h:11:
>> include/linux/stddef.h:16:33: error: 'struct dev_pm_info' has no member named 'entry'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:24:28: note: in expansion of macro 'offsetof'
      24 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   drivers/base/power/power.h:163:16: note: in expansion of macro 'container_of'
     163 |         return container_of(entry, struct device, power.entry);
         |                ^~~~~~~~~~~~


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

