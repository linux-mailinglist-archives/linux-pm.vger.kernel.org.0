Return-Path: <linux-pm+bounces-22530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E439A3D186
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 07:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8706E1891249
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 06:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD811B414F;
	Thu, 20 Feb 2025 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8sh0lb+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C471E570E
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034025; cv=none; b=f6j0zPBa5Q5hNU0C1CRXUvz2AelR+9UUOxZtaIgRphBoURg49HydCjjycvewAUgPtVQZSll9Cc1VKbRTjL1uBjS9BcGhu0if9wT/xkp9H3hbca3wT1fE+NDJ7YUbEVdthGPrIF1yE4s+S2jrqlsuE0tBwwfxQaWR7KwAN2bljog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034025; c=relaxed/simple;
	bh=sz5jR86VPN0LnfqC8pO9xIZNgJwCjM9li9CUL9Seri4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsfFQWi5DjP45cvejXcyR+nbA9NjDTjMvy4s5xW0HNpwRNEexjVOC0Y2z881eEzsCJ0OTrHLnYOXRWCoqBdmnpPw39YrfGFkD3Wbjh1DDRWxWOgYN3WhzZ++XS3fDE+xKS3HonDGsg0z3C/5EYGR6ldB/6w572FYLZHz1Es62Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8sh0lb+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740034024; x=1771570024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sz5jR86VPN0LnfqC8pO9xIZNgJwCjM9li9CUL9Seri4=;
  b=X8sh0lb+MtGT/SeUUzUUnW4YFJ8o5ThhmksvlTkKklOsfswKVxedJd4s
   UymdIkKiM63koz72hPLtlVX9gDxlh+B6w3iPa/ZkEc+LCUTW86dntTbXn
   wQtj8AOJFh7gieYiaNcrp0x3IdO/PGPfMgbYe6h+/cvvipAsiax4UDjxL
   n+rbVJLF0jU/a3nMB4oiTWY7E8jag7RMuw5ocdzvnaWZdipcKuWQcHtN+
   0kJoo25EKs9O6fYRfg8IjEYVJrxAr9kAgBOokISNSf1+L8RN03+UcswWB
   x+AzxGxgi/BxWfbwa5zfAPmlYdSRg6sShokvy3C25Py3pZH/O/jRWXb1K
   Q==;
X-CSE-ConnectionGUID: XA6zoh7kTd68gQoCPU8AVQ==
X-CSE-MsgGUID: K6gip/vLQ7K/fxRvF1+cqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51780832"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51780832"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:47:04 -0800
X-CSE-ConnectionGUID: F8Q7viy6Tp+1bNTkdIFMnA==
X-CSE-MsgGUID: xsogVkfSQpqSNqwkeGJu/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="119891877"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2025 22:47:01 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl0Kn-0003xf-0V;
	Thu, 20 Feb 2025 06:46:57 +0000
Date: Thu, 20 Feb 2025 14:46:51 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] pmdomain: rockchip: Check if smcc could be handled by TA
Message-ID: <202502201459.wqX8VWY9-lkp@intel.com>
References: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250218]
[cannot apply to v6.14-rc3 v6.14-rc2 v6.14-rc1 linus/master v6.14-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/pmdomain-rockchip-Check-if-smcc-could-be-handled-by-TA/20250219-122924
base:   next-20250218
patch link:    https://lore.kernel.org/r/1739926689-151827-1-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH] pmdomain: rockchip: Check if smcc could be handled by TA
config: x86_64-buildonly-randconfig-005-20250220 (https://download.01.org/0day-ci/archive/20250220/202502201459.wqX8VWY9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502201459.wqX8VWY9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502201459.wqX8VWY9-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pmdomain/rockchip/pm-domains.o: in function `rockchip_pd_power':
>> pm-domains.c:(.text+0x3bad): undefined reference to `arm_smccc_1_1_get_conduit'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

