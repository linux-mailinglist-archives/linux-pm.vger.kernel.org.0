Return-Path: <linux-pm+bounces-24976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9CBA81ACD
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 04:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6363D4C008C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430118DF62;
	Wed,  9 Apr 2025 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QY2KYTXY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A315855E
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744164697; cv=none; b=qpfyDxSQ8cQbKRbzTe/j9m5/8onT1N5nByHwCh9QpAtzrfVVlTzsEjpYlJwk9d9CY0PDyRX8/Yn5XYpRVQslsoCQPaikXXb2TwsW9FDeLbSG6Sfh9ARK/P0pPdN8Es7w/TDIALBntWINHSHNPruWLndfxL5keFHuw+h4LsfesKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744164697; c=relaxed/simple;
	bh=lT4dqsZsNby/RxWe7UXu1FK1U8SrjaI3u2qqJIvaq70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6zEHgpZXAikBZpS+MFA0cIeRxXJLDq4BeetK3ZVmCX47WuPs7DY5HdGnOyVIlSw0MARtY/8NuIIobB17LGxMRDYIIP8lqsr/3atmvMq8Aan8eGt4rYOfOexRbCetroSZC1p5yqWfjIoStEG8OCJxgq+sfJKvD7Q0A9a5ScSnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QY2KYTXY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744164695; x=1775700695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lT4dqsZsNby/RxWe7UXu1FK1U8SrjaI3u2qqJIvaq70=;
  b=QY2KYTXYcEtnFaYD8WUEaVY6wHNM+0AZvNwK9mcT5RYXnAkMLF8SswTp
   ecQlUUCc2R7GUn5EOCTAXDwc3+MfknJvjJrTJhqQL21/gCljjkoPrC5rK
   R21TGjvRMEgcC9aCHu2XeDZOW7Av0TZ1X/P1Ad5BrI8Kspv70HTAJyaQB
   cB7uUtvm6vbbULrBI47BoVOQKDtLvzQ8W2rZXqUjnM5PwdQg4qqZwLJH8
   9s8w36FIJlmfCrZfjTH4+kKsxslxBhpkcLYvIFRXcsLgM5+fZP1Ah+Tf2
   5cvvWfyNWbU8fdI7c+N4qrJ+jzkF/ptMZWMSGR6W3vZLr9Pi65Rux0O3z
   w==;
X-CSE-ConnectionGUID: mUqTjaY3Qa68Op0KrTYg5A==
X-CSE-MsgGUID: /iTaNuWRS2+t3zZ8oiCVWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56992187"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="56992187"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 19:11:33 -0700
X-CSE-ConnectionGUID: cCallOZRSo2s10FfnaQZBw==
X-CSE-MsgGUID: 28+2TRLDQiCcIefEoK0KNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="128298421"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Apr 2025 19:11:31 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2KuW-0008B9-35;
	Wed, 09 Apr 2025 02:11:28 +0000
Date: Wed, 9 Apr 2025 10:11:24 +0800
From: kernel test robot <lkp@intel.com>
To: Jelle van der Waa <jvanderw@redhat.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
	Jelle van der Waa <jvanderwaa@redhat.com>
Subject: Re: [PATCH 1/1] power: supply: support charge_types in extensions
Message-ID: <202504090859.yXF0zkoj-lkp@intel.com>
References: <20250407201845.332348-2-jvanderw@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407201845.332348-2-jvanderw@redhat.com>

Hi Jelle,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on linus/master v6.15-rc1 next-20250408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jelle-van-der-Waa/power-supply-support-charge_types-in-extensions/20250408-045501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250407201845.332348-2-jvanderw%40redhat.com
patch subject: [PATCH 1/1] power: supply: support charge_types in extensions
config: csky-randconfig-001-20250409 (https://download.01.org/0day-ci/archive/20250409/202504090859.yXF0zkoj-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250409/202504090859.yXF0zkoj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504090859.yXF0zkoj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/power/supply/test_power.c: In function 'test_power_battery_property_is_writeable':
>> drivers/power/supply/test_power.c:148:20: warning: suggest parentheses around comparison in operand of '|' [-Wparentheses]
     148 |         return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR | POWER_SUPPLY_PROP_CHARGE_TYPES;
         |                ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +148 drivers/power/supply/test_power.c

   144	
   145	static int test_power_battery_property_is_writeable(struct power_supply *psy,
   146							    enum power_supply_property psp)
   147	{
 > 148		return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR | POWER_SUPPLY_PROP_CHARGE_TYPES;
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

