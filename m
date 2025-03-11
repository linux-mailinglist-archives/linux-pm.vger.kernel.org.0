Return-Path: <linux-pm+bounces-23844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB7FA5C34F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E0E1892C4C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C01E25B67F;
	Tue, 11 Mar 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoThZfxt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273722D4FE;
	Tue, 11 Mar 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702226; cv=none; b=d0UAJoOeL09rxak+4NxRRWARC8J+DX8D9aI2h/WhLj7SS23LVOyz7SCu+nLTnPHA5NBO6iqm9V79Fm73DDuk3P4K7jtVlvPJqd1olId0D7TsT1R0ADsHRi0DXv3MJhyTRdDq39VvAotNSm5mHNObVEjA5Zomp3xe9jQP6zngi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702226; c=relaxed/simple;
	bh=6DCHttFxpQlt5JlaplZgiIIP2FjcwsLNjEAL1Va9+u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNmcoIXEc+k2ekDpAkjeWtVlrSNBMGbLEpnA0U6fMQzd2Qu5RVTVQrrnSBcywM85ahzPV3vBWRdoYHwTKF0ljtTyPphMLLpU7eyjgphWdJ17OwkdZ6DeDo1q3E3LE0S15JJ0k29w7fi8b2I7/1wE7VImqFkiz9FNUR97C64wQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoThZfxt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741702224; x=1773238224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6DCHttFxpQlt5JlaplZgiIIP2FjcwsLNjEAL1Va9+u4=;
  b=JoThZfxtWpBAhqz35ynvdytlBWUKooygdqA1ehBNKiETJA+kgNPGWIeO
   ALgbTMzxebN3BTl69J4/6+3neK/vHj7zeGBmmlkgCr9E10oJSN2uhIA2K
   SVgGkPzVwCAzhip4Ked4lXJSDKPS50PKNqpfk347WXw6BzDe0oqw9705i
   fO2yCukYgtwF/2iMM9hFEB9qlCmijD4IBox0iUtWHDegWXmD9yKmp0b0s
   HeV06IEFT/qHP+6GvCNdrwx8DxziNukDOiAcxF2ORRPB8qIMEzsQMl9nE
   4o9c+W6JfNwVi6gAOYgoA4j1PlP7UEPH4PscLKERtAqHm7nYKOxFuNf/B
   Q==;
X-CSE-ConnectionGUID: f9SNI9vLSNWZFUfLp49hyQ==
X-CSE-MsgGUID: HkPR4dGQSpSrfRWpx/EYwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46523319"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46523319"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 07:10:03 -0700
X-CSE-ConnectionGUID: lwwV97C/Q1Ck5Ar/zlHaNQ==
X-CSE-MsgGUID: ERKY/U9aQg6zkJ8ybsZURA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="157534140"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Mar 2025 07:10:00 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts0Iv-0006hg-0j;
	Tue, 11 Mar 2025 14:09:57 +0000
Date: Tue, 11 Mar 2025 22:09:18 +0800
From: kernel test robot <lkp@intel.com>
To: Antheas Kapenekakis <lkml@antheas.dev>,
	platform-driver-x86@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: Re: [PATCH v3 06/12] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
Message-ID: <202503112130.dl6b3XVs-lkp@intel.com>
References: <20250309112114.1177361-7-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309112114.1177361-7-lkml@antheas.dev>

Hi Antheas,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on sre-power-supply/for-next amd-pstate/linux-next amd-pstate/bleeding-edge rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antheas-Kapenekakis/hwmon-oxp-sensors-Distinguish-the-X1-variants/20250309-192300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250309112114.1177361-7-lkml%40antheas.dev
patch subject: [PATCH v3 06/12] platform/x86: oxpec: Add charge threshold and behaviour to OneXPlayer
config: x86_64-randconfig-074-20250311 (https://download.01.org/0day-ci/archive/20250311/202503112130.dl6b3XVs-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503112130.dl6b3XVs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503112130.dl6b3XVs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: battery_hook_register
   >>> referenced by oxpec.c:927 (drivers/platform/x86/oxpec.c:927)
   >>>               vmlinux.o:(oxp_platform_probe)
--
>> ld.lld: error: undefined symbol: battery_hook_unregister
   >>> referenced by oxpec.c:935 (drivers/platform/x86/oxpec.c:935)
   >>>               vmlinux.o:(oxp_platform_remove)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

