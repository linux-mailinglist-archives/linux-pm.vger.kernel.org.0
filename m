Return-Path: <linux-pm+bounces-19962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AED4A017FF
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 05:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03FE161CC1
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 04:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049521DFEF;
	Sun,  5 Jan 2025 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfFGQjK6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181F442F;
	Sun,  5 Jan 2025 04:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736050023; cv=none; b=RDcc3B0FiXZIZSljSCPokA0jB9IPrXu98I9yZgEUZxLORHlNBG1hvRi3Rj5e7R7rm5CEy3lAFya0YeFurDYc/FbTLcaBfIgdSQjpsBnZAWeCtvIjeWcvvRZG/TcWMWtqGbopUjfrfCIaWqQTkBHAUVoXxKDLZCLyCQbAEBjNaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736050023; c=relaxed/simple;
	bh=uTTXcYE2JlL0MwZNF4xf3gPhakQayiJl1mKH6vTKQMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIOfsR1yArBMcsu6iFggXErm2kih3EWzROpcCeaVoEqy3VFpxxIhST8Wu7p1C1zXnkYaeVeLfbxN4Y2D4LpmeK8Pe5Umtyki6yWqOcezU/pCgUxMrhyYpU5UStXkGzK0BNr9h3fZo2VHlap/MGRl8YLV3LFGeW1dhEZL/3SJ5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfFGQjK6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736050022; x=1767586022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uTTXcYE2JlL0MwZNF4xf3gPhakQayiJl1mKH6vTKQMI=;
  b=RfFGQjK6PekFSvPeMj+D+sau8EUDjhqUHBGoNgYE16Bw6tkBSOaXWLmY
   KKps1AbsnmykHuxGvbPEo9mz8t07TKLRxVdMUPmhQjkdBCAWktd8gP5w6
   h6sL/HfTJkzZxw2dU7CFrrEgXucyhrrfFxBoCQrj5t30iMhAh3nr0eDI1
   Wglv/gCbb6MS0KiZOVthXfn7TQmx8/bU+qj/f/JDYM2CECFOnKBFrdbSl
   Y9EszjC/H6DdbP4EOsS/J40Wvom49KChbGU4lSMwHjZYjWavK4JAas0fS
   UTCOR3NZ/OQF3ZAKsQmXUVep8ew2NyvFV4sgLUb813nZnuQE4DeWwNXDo
   w==;
X-CSE-ConnectionGUID: 1SsTWpg7SqG3Pd0TxPgwRg==
X-CSE-MsgGUID: WIZbAWXfSOm8UB+yzkzcCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11305"; a="46906606"
X-IronPort-AV: E=Sophos;i="6.12,289,1728975600"; 
   d="scan'208";a="46906606"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 20:07:01 -0800
X-CSE-ConnectionGUID: s5QBkrq/RlC6x0S1Bzo8Zg==
X-CSE-MsgGUID: T/KGlmm5Qo60f34HgbLZqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,289,1728975600"; 
   d="scan'208";a="106980210"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Jan 2025 20:06:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tUHui-000BRL-14;
	Sun, 05 Jan 2025 04:06:56 +0000
Date: Sun, 5 Jan 2025 12:06:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
Message-ID: <202501051127.3AKt5ZE9-lkp@intel.com>
References: <20250104181305.28185-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104181305.28185-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.13-rc5 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/cpufreq-airoha-Add-EN7581-CPUFreq-SMCCC-driver/20250105-022153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250104181305.28185-1-ansuelsmth%40gmail.com
patch subject: [PATCH v8 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
config: arm64-randconfig-001-20250105 (https://download.01.org/0day-ci/archive/20250105/202501051127.3AKt5ZE9-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 096551537b2a747a3387726ca618ceeb3950e9bc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250105/202501051127.3AKt5ZE9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501051127.3AKt5ZE9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:135:3: error: field designator 'remove_new' does not refer to any field in type 'struct platform_driver'
     135 |         .remove_new = airoha_cpu_pmdomain_remove,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +135 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c

   132	
   133	static struct platform_driver airoha_cpu_pmdomain_driver = {
   134		.probe = airoha_cpu_pmdomain_probe,
 > 135		.remove_new = airoha_cpu_pmdomain_remove,
   136		.driver = {
   137			.name = "airoha-cpu-pmdomain",
   138			.of_match_table = airoha_cpu_pmdomain_of_match,
   139		},
   140	};
   141	module_platform_driver(airoha_cpu_pmdomain_driver);
   142	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

