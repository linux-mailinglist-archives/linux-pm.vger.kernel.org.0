Return-Path: <linux-pm+bounces-18547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F679E3D2D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B0A280C05
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D80020ADE4;
	Wed,  4 Dec 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmHR6WPK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2F205AB3;
	Wed,  4 Dec 2024 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323744; cv=none; b=nSElt4HlKTvhqlTa4/QLgHmVeNtLW1tcZiOLtU0zvyNgyx7kZRPYltzdJZGxpBl1vx3HQzCalq8S+vsDUJg6daWFr7wJf4wcbzJP9NBzc/e2akTWRIvAuLpFI6NF6lbSYoKuVD8QkbpCMxVpT/ktpfp/hp1LUEeZGD71CfIRWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323744; c=relaxed/simple;
	bh=H70A6386no0mRUCwERGv9Pkle7uucK5//o8iXLIk9Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIqlJABrW7ay+ZKFpJm1T1ZoYb2GPbtMq7O2abbUpojxjx3O/o8gFhgIeHoIh0Fn5LnRvVJhyuHXHwPH+ikZsgmFNm0XnGcJyAiNUwganRJhzze/2eVOD0qmhlFgey4ETVnHUrlM8tt+34aapvFV13GvRNXMCu+yJryjG910z7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmHR6WPK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733323743; x=1764859743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H70A6386no0mRUCwERGv9Pkle7uucK5//o8iXLIk9Fs=;
  b=BmHR6WPKPdqjs55nX1/CpmJs3H1r+l3abHT74KIiJaRA7UvKXFDXaTCH
   NWN3MDXcuxJE0V9r44Ed5Eo5xeQJlqyYh3j25TWmNg+najE/SnpPixIjO
   Xy9bMVMUS8oO9NwmCqDV5NTb1ResVAMybkD4qXvu7yIZDWAH4ZKecUx3n
   Co6uE1lVLkQ0Yk/0K1FlrkmejJ1mlZJnJ78hXXUptU65nILm3VWGwgt6b
   km9efGdIGAM84wb0mg2VnKVXWuOrlK6SxamVH0YLynzOR5yT1s7ftwHKC
   TMYT+NAiDSxFqJTNsPID1Jn5uaYp5soToNypSZZNTqu3Lz3ZgPc1B8TKt
   A==;
X-CSE-ConnectionGUID: cRGqBiITR1yoyTsVdhiSzA==
X-CSE-MsgGUID: am/gW7weS2mh8T+jejHImA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="36436387"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="36436387"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:49:02 -0800
X-CSE-ConnectionGUID: CGxns0dNQWCugjy1jW/q5A==
X-CSE-MsgGUID: sVlJY7EaQcGBH3lqiVJ2Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94614097"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Dec 2024 06:48:58 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIqgR-00038t-39;
	Wed, 04 Dec 2024 14:48:56 +0000
Date: Wed, 4 Dec 2024 22:48:55 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <202412042218.ldyfHhMs-lkp@intel.com>
References: <20241203163158.580-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203163158.580-2-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge robh/for-next linus/master v6.13-rc1 next-20241203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/cpufreq-airoha-Add-EN7581-CPUFreq-SMCCC-driver/20241204-113105
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241203163158.580-2-ansuelsmth%40gmail.com
patch subject: [PATCH v5 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
config: arm-kismet-CONFIG_PM_GENERIC_DOMAINS-CONFIG_ARM_AIROHA_SOC_CPUFREQ-0-0 (https://download.01.org/0day-ci/archive/20241204/202412042218.ldyfHhMs-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241204/202412042218.ldyfHhMs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412042218.ldyfHhMs-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS when selected by ARM_AIROHA_SOC_CPUFREQ
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
     Depends on [n]: PM [=n]
     Selected by [y]:
     - ARM_AIROHA_SOC_CPUFREQ [=y] && CPU_FREQ [=y] && (ARCH_AIROHA [=y] || COMPILE_TEST [=n] && ARM64)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

